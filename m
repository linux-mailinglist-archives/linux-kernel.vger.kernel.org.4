Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 28F026C7DC9
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Mar 2023 13:13:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231846AbjCXMNS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Mar 2023 08:13:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231508AbjCXMNQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Mar 2023 08:13:16 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7312C113EE
        for <linux-kernel@vger.kernel.org>; Fri, 24 Mar 2023 05:13:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1679659994; x=1711195994;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=vqediUMzXqF6NjXsWDqodVWUF23Z9yjoQDiTJA0nKpw=;
  b=n7c6rSL7qBdWsATOaxCc3SVMDN1QZ3sja5fRK/jXJZ8SsSiAyeCvcIgv
   YOYPXotk3afrdLD1i6rq6edffm1ZZzfdrwrt4rvgo0OPtShIDetil9nPO
   GNg/xK97su9Rslqo2qaDCU1rh07D1xhQtoS22Q5LFJU3OJbr0zCoIPsPM
   EYX0Gs1Pn+dYokZbfg0T6jbVzed5MI2F4WzJICKa3HE6t9W6ULVo8al46
   0uYTBdhGcOu03pq9WKbSMNAKJtOLKOW8ceTCMyAqJTu9wf2xw+OAOZFDE
   TfTW5IXbuYSn1xKMW3qDIxnb2Ax+3B6eHfZFNNTfKHTj22+PugrVMdZdr
   Q==;
X-IronPort-AV: E=Sophos;i="5.98,287,1673938800"; 
   d="scan'208";a="203263383"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa4.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 24 Mar 2023 05:13:13 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Fri, 24 Mar 2023 05:13:12 -0700
Received: from wendy.microchip.com (10.10.115.15) by chn-vm-ex02.mchp-main.com
 (10.10.85.144) with Microsoft SMTP Server id 15.1.2507.21 via Frontend
 Transport; Fri, 24 Mar 2023 05:13:10 -0700
From:   Conor Dooley <conor.dooley@microchip.com>
To:     <palmer@dabbelt.com>
CC:     <conor@kernel.org>, <conor.dooley@microchip.com>,
        <ajones@ventanamicro.com>, <Jason@zx2c4.com>,
        <apatel@ventanamicro.com>, <heiko.stuebner@vrull.eu>,
        <jszhang@kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-riscv@lists.infradead.org>, <paul.walmsley@sifive.com>
Subject: [PATCH v1] RISC-V: convert new selectors of RISCV_ALTERNATIVE to dependencies
Date:   Fri, 24 Mar 2023 12:12:41 +0000
Message-ID: <20230324121240.3594777-1-conor.dooley@microchip.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1705; i=conor.dooley@microchip.com; h=from:subject; bh=vqediUMzXqF6NjXsWDqodVWUF23Z9yjoQDiTJA0nKpw=; b=owGbwMvMwCFWscWwfUFT0iXG02pJDCmyk7epz3t10Pa3/WadLys8Fp7RXJJ+ccKxWNW4vJkLNpUE Hlym1FHKwiDGwSArpsiSeLuvRWr9H5cdzj1vYeawMoEMYeDiFICJBMgwMlwNXGc+/8DxnRUHVu9QaO h52W9itXrZjq3bSn6XL3VKbPvCyLDA0kQtJT/o0q7lpSvtvmzz/aJV+6hPOcnPP8iCm9VMngkA
X-Developer-Key: i=conor.dooley@microchip.com; a=openpgp; fpr=F9ECA03CF54F12CD01F1655722E2C55B37CF380C
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

for-next contains two additional extensions that select
RISCV_ALTERNATIVE. RISCV_ALTERNATIVE no longer needs to be selected by
individual config options as it is now selected for !XIP_KERNEL builds
by the top level RISCV option.
These extensions rely on the alternative framework, so convert the
"select"s to "depends on"s instead.

Signed-off-by: Conor Dooley <conor.dooley@microchip.com>
---
Applies on top of my series doing the aforementioned conversion:
https://lore.kernel.org/all/20230324100538.3514663-3-conor.dooley@microchip.com/

This patch is sent on its own, because I expect the others to be applied
to fixes, as it fixes a v6.3 regression.
For this patch, I applied my other series to v6.3-rc1 and merged that
into for-next, and created this patch on top of the result.
---
 arch/riscv/Kconfig | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
index d2acd69d6e3e..a48d1ee677ec 100644
--- a/arch/riscv/Kconfig
+++ b/arch/riscv/Kconfig
@@ -402,8 +402,8 @@ config RISCV_ISA_C
 config RISCV_ISA_SVNAPOT
 	bool "SVNAPOT extension support"
 	depends on 64BIT && MMU
+	depends on RISCV_ALTERNATIVE
 	default y
-	select RISCV_ALTERNATIVE
 	help
 	  Allow kernel to detect the SVNAPOT ISA-extension dynamically at boot
 	  time and enable its usage.
@@ -478,8 +478,8 @@ config RISCV_ISA_ZICBOM
 
 config RISCV_ISA_ZICBOZ
 	bool "Zicboz extension support for faster zeroing of memory"
-	depends on !XIP_KERNEL && MMU
-	select RISCV_ALTERNATIVE
+	depends on MMU
+	depends on RISCV_ALTERNATIVE
 	default y
 	help
 	   Enable the use of the ZICBOZ extension (cbo.zero instruction)
-- 
2.39.2

