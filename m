Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E4C735B37D1
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Sep 2022 14:32:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231374AbiIIMcA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Sep 2022 08:32:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230360AbiIIMb4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Sep 2022 08:31:56 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 442731153BC;
        Fri,  9 Sep 2022 05:31:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1662726715; x=1694262715;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=HX/acfokj679TW0p8JjwsB6cH8hSfz79iHSDR58YKNY=;
  b=xAR6r1ArqAtkeWuIdgLB2nHh6er5g/bJNtXI9M4OlMyr5D/ylghmp7hP
   /bSqi1oml54G07bLQUjpiVmfjoVZfKHPzv36v21ehXpaUG4ovlpEZaI83
   /SHY8pJsGAfP1RXvoHGJoOsOsMkoTu3EtMowAY6u7MNR3OFX91W1tOMKn
   T1eFYHymtdFF22vbXd+X5hEm9ZAw9RsQxhAV3xg+D3A16tbUzmsWPKVvk
   X+37kPz2sNKhI1MF4Lz+t4oA07eWuZEle0l2PUT4lmvjucPvuzub7F6dx
   gbCyIunhNMcby4T890EVsHRYVk7sLU/A7lYTLIV38sTJ8BVe1447yXYxR
   g==;
X-IronPort-AV: E=Sophos;i="5.93,303,1654585200"; 
   d="scan'208";a="176399083"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa2.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 09 Sep 2022 05:31:51 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.12; Fri, 9 Sep 2022 05:31:46 -0700
Received: from wendy.microchip.com (10.10.115.15) by chn-vm-ex04.mchp-main.com
 (10.10.85.152) with Microsoft SMTP Server id 15.1.2507.12 via Frontend
 Transport; Fri, 9 Sep 2022 05:31:43 -0700
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
        <linux-kernel@vger.kernel.org>, <linux-riscv@lists.infradead.org>
Subject: [PATCH v5 00/14] PolarFire SoC reset controller & clock cleanups
Date:   Fri, 9 Sep 2022 13:31:09 +0100
Message-ID: <20220909123123.2699583-1-conor.dooley@microchip.com>
X-Mailer: git-send-email 2.36.1
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

@Stephen, even if you do not take the rest of the series for v6.1, the
first patch is a bugfix for boot failures that can be trigged with v6.0
so even if you have reservations about the aux device stuff, I would
appreciate if you would take the first patch.

Unfortunately, the rest of the series does have a conflict with/depends
on the fix - so if you do take it on -fixes could you do it as a commit
on top of -rc1 so the rest of the series will apply?

Thanks,
Conor.

Original Cover:
Hey all,

Kinda two things happening in this series, but I sent it together to
ensure the second part would apply correctly.

The first is the reset controller that I promised after discovering the
issue triggered by CONFIG_PM & the phy not coming up correctly. I have
now removed all the messing with resets from clock enable/disable
functions & now use the aux bus to set up a reset controller driver.
Since I needed something to test it, I hooked up the reset for the
Cadence MACB on PolarFire SoC. This has been split into a second series
for v2 (and is now in v6.0-rcN):
https://lore.kernel.org/all/20220704114511.1892332-1-conor.dooley@microchip.com/

The second part adds rate control for the MSS PLL clock, followed by
some simplifications to the driver & conversions of some custom structs
to the corresponding structs in the framework.

I'll take the dts patch myself when the rest of this is okay-ed.
Thanks,
Conor.

Changes since v4:
- use the alternative macro Claudiu suggested for patch 1
- drop a ~useless intermediate variable in mpfs_deassert()

Changes since v3:
- return results directly in probe() & reset_controller_register()

Changes since v2:
- reorder reset Makefile/Kconfig entries
- fix a pre-existing bug exposed by clang with this series applied
- add Padmarao who co-authored the original driver to the authors

Conor Dooley (14):
  clk: microchip: mpfs: fix clk_cfg array bounds violation
  clk: microchip: mpfs: make the rtc's ahb clock critical
  dt-bindings: clk: microchip: mpfs: add reset controller support
  clk: microchip: mpfs: add reset controller
  reset: add polarfire soc reset support
  MAINTAINERS: add polarfire soc reset controller
  riscv: dts: microchip: add mpfs specific macb reset support
  clk: microchip: mpfs: add MSS pll's set & round rate
  clk: microchip: mpfs: move id & offset out of clock structs
  clk: microchip: mpfs: simplify control reg access
  clk: microchip: mpfs: delete 2 line mpfs_clk_register_foo()
  clk: microchip: mpfs: convert cfg_clk to clk_divider
  clk: microchip: mpfs: convert periph_clk to clk_gate
  clk: microchip: mpfs: update module authorship & licencing

 .../bindings/clock/microchip,mpfs.yaml        |  17 +-
 MAINTAINERS                                   |   1 +
 arch/riscv/boot/dts/microchip/mpfs.dtsi       |   7 +-
 drivers/clk/microchip/Kconfig                 |   1 +
 drivers/clk/microchip/clk-mpfs.c              | 384 +++++++++---------
 drivers/reset/Kconfig                         |   7 +
 drivers/reset/Makefile                        |   2 +-
 drivers/reset/reset-mpfs.c                    | 157 +++++++
 include/soc/microchip/mpfs.h                  |   8 +
 9 files changed, 388 insertions(+), 196 deletions(-)
 create mode 100644 drivers/reset/reset-mpfs.c


base-commit: 568035b01cfb107af8d2e4bd2fb9aea22cf5b868
-- 
2.36.1

