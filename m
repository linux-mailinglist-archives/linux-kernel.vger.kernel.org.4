Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 94FEC745A2D
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jul 2023 12:29:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231347AbjGCK3Q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Jul 2023 06:29:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231287AbjGCK3L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jul 2023 06:29:11 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B242C7;
        Mon,  3 Jul 2023 03:29:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1688380150; x=1719916150;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=1i34KSawlUL8WNjNkmTiVglWiYjIqUpNKEWr7RWMan4=;
  b=kNTKKDCLGjdW4qO5lUKCPucWl8UbsxiEAx7WgtZHZgzC4s2bWtdsaRvA
   pdJ0IqqMPZEYAnoNwzIDMwOKpPPkiwkSV2KmQSlGi3ovgyKhX48iS0bQ4
   iaQsIvV3IFxvtjL0MTWO57vf180K6e6vAwVMFtj1YDGDkWhuPFoGbuinI
   UauUHlXPIcjcqV/74Bg3N4JKXH9TXabSePQwURxzYMAtZRda1pRKHlstN
   /fr3qZMGtxAX0aBHwg0YpJmSMopS1rFiEk/EK0Xuts6xKFNJTst50UUEJ
   MTktJrtx41wC/qDIrlKaHvQr1JYFPupe3DRpXTVMsht6F+qP2sljfX2i8
   A==;
X-IronPort-AV: E=Sophos;i="6.01,177,1684825200"; 
   d="scan'208";a="233446742"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa1.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 03 Jul 2023 03:29:09 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Mon, 3 Jul 2023 03:29:06 -0700
Received: from wendy.microchip.com (10.10.115.15) by chn-vm-ex03.mchp-main.com
 (10.10.85.151) with Microsoft SMTP Server id 15.1.2507.21 via Frontend
 Transport; Mon, 3 Jul 2023 03:29:03 -0700
From:   Conor Dooley <conor.dooley@microchip.com>
To:     <palmer@dabbelt.com>
CC:     <conor@kernel.org>, <conor.dooley@microchip.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        "Jonathan Corbet" <corbet@lwn.net>,
        Andrew Jones <ajones@ventanamicro.com>,
        "Heiko Stuebner" <heiko.stuebner@vrull.eu>,
        Evan Green <evan@rivosinc.com>,
        Sunil V L <sunilvl@ventanamicro.com>,
        <linux-doc@vger.kernel.org>, <linux-riscv@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v3 03/11] RISC-V: drop a needless check in print_isa_ext()
Date:   Mon, 3 Jul 2023 11:27:55 +0100
Message-ID: <20230703-driver-draw-034bd62ec119@wendy>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230703-repayment-vocalist-e4f3eeac2b2a@wendy>
References: <20230703-repayment-vocalist-e4f3eeac2b2a@wendy>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1275; i=conor.dooley@microchip.com; h=from:subject:message-id; bh=1i34KSawlUL8WNjNkmTiVglWiYjIqUpNKEWr7RWMan4=; b=owGbwMvMwCFWscWwfUFT0iXG02pJDCmLFq36zeG3+Kh/GHuWk/TypQLCmwoeb2ubrK+zd/415dBJ Z9XWdJSyMIhxMMiKKbIk3u5rkVr/x2WHc89bmDmsTCBDGLg4BWAiUYmMDD//OcYYXEqd/CBS9xhP8N 4/1/jnTctiC5Uq2a6YoxfR/ZXhf4WrRzebp47s+l0Jv55kmT3rMbgcxO5TaMFwZ//W+rP9LAA=
X-Developer-Key: i=conor.dooley@microchip.com; a=openpgp; fpr=F9ECA03CF54F12CD01F1655722E2C55B37CF380C
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

isa_ext_arr cannot be empty, as some of the extensions within it are
always built into the kernel. When this code was first added, back in
commit a9b202606c69 ("RISC-V: Improve /proc/cpuinfo output for ISA
extensions"), the array was empty and needed a dummy item & thus there
could be no extensions present. When the first multi-letter ones did
get added, it was Sscofpmf - which didn't have a Kconfig symbol to
disable it.

Remove this check, as it has been redundant since Sscofpmf was added.

Reviewed-by: Andrew Jones <ajones@ventanamicro.com>
Signed-off-by: Conor Dooley <conor.dooley@microchip.com>
---
Changes in v2:
- Reword commit message to explain why this can be dropped
---
 arch/riscv/kernel/cpu.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/arch/riscv/kernel/cpu.c b/arch/riscv/kernel/cpu.c
index f808b67f5a27..e721f15fdf17 100644
--- a/arch/riscv/kernel/cpu.c
+++ b/arch/riscv/kernel/cpu.c
@@ -237,10 +237,6 @@ static void print_isa_ext(struct seq_file *f)
 
 	arr_sz = ARRAY_SIZE(isa_ext_arr) - 1;
 
-	/* No extension support available */
-	if (arr_sz <= 0)
-		return;
-
 	for (i = 0; i <= arr_sz; i++) {
 		edata = &isa_ext_arr[i];
 		if (!__riscv_isa_extension_available(NULL, edata->isa_ext_id))
-- 
2.40.1

