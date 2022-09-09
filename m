Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 484A45B37CF
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Sep 2022 14:32:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231238AbiIIMb5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Sep 2022 08:31:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229589AbiIIMbz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Sep 2022 08:31:55 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB5C998347;
        Fri,  9 Sep 2022 05:31:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1662726713; x=1694262713;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=J/KA5IP1P64+fZAZNeRF2iSfGho/kaCFDpeCMd5oTCw=;
  b=gWSzOfBEY8cbq6DbLiev1iDui6FQuNsjQr/gApGI7YevLh2+V7+WQDD3
   y2fXnjO6gIk/TqHc3YVchsaqr/W77rtufCWTS1BKwvyFFzFsc1SRBJMPE
   AS9jOXzhjEYMlG1wkORdT1792KRE8YT9tdk+TAcBO+Zwxa1UgjuDO+9zs
   gBI3jLrRNqpX1WdznMqXKF3s9DIFa4Gd2ZWq/l9Iv7deZSTpeeDQ02nb7
   wnaBNvSkt2FK+LgGZM8XCGMtJ8I6EGeo2ugGJZhnAurjcz4f3B218gPpE
   x3oR+A2YBfJpeZOs4Tx7GA3+Kd16fvTe1wGtozcjzKN8jvBSw+p846VVd
   A==;
X-IronPort-AV: E=Sophos;i="5.93,303,1654585200"; 
   d="scan'208";a="176399082"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa2.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 09 Sep 2022 05:31:51 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.12; Fri, 9 Sep 2022 05:31:49 -0700
Received: from wendy.microchip.com (10.10.115.15) by chn-vm-ex04.mchp-main.com
 (10.10.85.152) with Microsoft SMTP Server id 15.1.2507.12 via Frontend
 Transport; Fri, 9 Sep 2022 05:31:46 -0700
From:   Conor Dooley <conor.dooley@microchip.com>
To:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Conor Dooley <conor.dooley@microchip.com>,
        Daire McNamara <daire.mcnamara@microchip.com>
CC:     Paul Walmsley <paul.walmsley@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Claudiu Beznea <claudiu.beznea@microchip.com>,
        <linux-clk@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-riscv@lists.infradead.org>,
        "Nathan Chancellor" <nathan@kernel.org>
Subject: [PATCH v5 01/14] clk: microchip: mpfs: fix clk_cfg array bounds violation
Date:   Fri, 9 Sep 2022 13:31:10 +0100
Message-ID: <20220909123123.2699583-2-conor.dooley@microchip.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220909123123.2699583-1-conor.dooley@microchip.com>
References: <20220909123123.2699583-1-conor.dooley@microchip.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is an array bounds violation present during clock registration,
triggered by current code by only specific toolchains. This seems to
fail gracefully in v6.0-rc1, using a toolchain build from the riscv-
gnu-toolchain repo and with clang-15, and life carries on. While
converting the driver to use standard clock structs/ops, kernel panics
were seen during boot when built with clang-15:

[    0.581754] Unable to handle kernel NULL pointer dereference at virtual address 00000000000000b1
[    0.591520] Oops [#1]
[    0.594045] Modules linked in:
[    0.597435] CPU: 0 PID: 1 Comm: swapper/0 Not tainted 6.0.0-rc1-00011-g8e1459cf4eca #1
[    0.606188] Hardware name: Microchip PolarFire-SoC Icicle Kit (DT)
[    0.613012] epc : __clk_register+0x4a6/0x85c
[    0.617759]  ra : __clk_register+0x49e/0x85c
[    0.622489] epc : ffffffff803faf7c ra : ffffffff803faf74 sp : ffffffc80400b720
[    0.630466]  gp : ffffffff810e93f8 tp : ffffffe77fe60000 t0 : ffffffe77ffb3800
[    0.638443]  t1 : 000000000000000a t2 : ffffffffffffffff s0 : ffffffc80400b7c0
[    0.646420]  s1 : 0000000000000001 a0 : 0000000000000001 a1 : 0000000000000000
[    0.654396]  a2 : 0000000000000001 a3 : 0000000000000000 a4 : 0000000000000000
[    0.662373]  a5 : ffffffff803a5810 a6 : 0000000200000022 a7 : 0000000000000006
[    0.670350]  s2 : ffffffff81099d48 s3 : ffffffff80d6e28e s4 : 0000000000000028
[    0.678327]  s5 : ffffffff810ed3c8 s6 : ffffffff810ed3d0 s7 : ffffffe77ffbc100
[    0.686304]  s8 : ffffffe77ffb1540 s9 : ffffffe77ffb1540 s10: 0000000000000008
[    0.694281]  s11: 0000000000000000 t3 : 00000000000000c6 t4 : 0000000000000007
[    0.702258]  t5 : ffffffff810c78c0 t6 : ffffffe77ff88cd0
[    0.708125] status: 0000000200000120 badaddr: 00000000000000b1 cause: 000000000000000d
[    0.716869] [<ffffffff803fb892>] devm_clk_hw_register+0x62/0xaa
[    0.723420] [<ffffffff80403412>] mpfs_clk_probe+0x1e0/0x244

In v6.0-rc1 and later, this issue is visible without the follow on
patches doing the conversion using toolchains provided by our Yocto
meta layer too.

It fails on "clk_periph_timer" - which uses a different parent, that it
tries to find using the macro:
\#define PARENT_CLK(PARENT) (&mpfs_cfg_clks[CLK_##PARENT].cfg.hw)

If parent is RTCREF, so the macro becomes: &mpfs_cfg_clks[33].cfg.hw
which is well beyond the end of the array. Amazingly, builds with GCC
11.1 see no problem here, booting correctly and hooking the parent up
etc. Builds with clang-15 do not, with the above panic.

Change the macro to use specific offsets depending on the parent rather
than the dt-binding's clock IDs.

Fixes: 1c6a7ea32b8c ("clk: microchip: mpfs: add RTCREF clock control")
CC: Nathan Chancellor <nathan@kernel.org>
Signed-off-by: Conor Dooley <conor.dooley@microchip.com>
---
 drivers/clk/microchip/clk-mpfs.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/clk/microchip/clk-mpfs.c b/drivers/clk/microchip/clk-mpfs.c
index 070c3b896559..f0f9c9a1cc48 100644
--- a/drivers/clk/microchip/clk-mpfs.c
+++ b/drivers/clk/microchip/clk-mpfs.c
@@ -239,6 +239,11 @@ static const struct clk_ops mpfs_clk_cfg_ops = {
 	.hw.init = CLK_HW_INIT(_name, _parent, &mpfs_clk_cfg_ops, 0),			\
 }
 
+#define CLK_CPU_OFFSET		0u
+#define CLK_AXI_OFFSET		1u
+#define CLK_AHB_OFFSET		2u
+#define CLK_RTCREF_OFFSET	3u
+
 static struct mpfs_cfg_hw_clock mpfs_cfg_clks[] = {
 	CLK_CFG(CLK_CPU, "clk_cpu", "clk_msspll", 0, 2, mpfs_div_cpu_axi_table, 0,
 		REG_CLOCK_CONFIG_CR),
@@ -362,7 +367,7 @@ static const struct clk_ops mpfs_periph_clk_ops = {
 				  _flags),					\
 }
 
-#define PARENT_CLK(PARENT) (&mpfs_cfg_clks[CLK_##PARENT].hw)
+#define PARENT_CLK(PARENT) (&mpfs_cfg_clks[CLK_##PARENT##_OFFSET].hw)
 
 /*
  * Critical clocks:
-- 
2.36.1

