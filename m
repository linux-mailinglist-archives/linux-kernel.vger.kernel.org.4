Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6EC0773DD51
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Jun 2023 13:21:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230189AbjFZLVz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Jun 2023 07:21:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229828AbjFZLVh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Jun 2023 07:21:37 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BF5610D2;
        Mon, 26 Jun 2023 04:21:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1687778475; x=1719314475;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=eZGPwaE1m+Pw9q6+drdEFoQWfh6B8MVtcv7cz4C7AWM=;
  b=2LhukpHJasRWaIHS/suE1gWjUor621djuHskSIQrQl6icJ7QTtZqhSsU
   zvZlybZ5TS3lGiapEKGJbPCjD1JUKV/FH6WVn0zwDjNZZ2ZpB+zoL9kth
   nRhJEBTqi18ZsjrIsYR99+C4w2hzUvAyC+m6c9m/Vo0Fde2bP1gSGD1Hu
   XbmbVEm0D9UfAfnAKhCEevMpkoIC5rHWFX3EmVg4Ivew2WXMB0mnudrIf
   gYyca7hQ70YL4374Y8nY40a0M4ppJ5FO8mQVec7b3US0c0YLwaLeDzUrh
   DvBpyxJuIPXolP+2RJOfkKTs7mKpZBPdEpigiJfXyB6uCAAO66KEug3St
   g==;
X-IronPort-AV: E=Sophos;i="6.01,159,1684825200"; 
   d="scan'208";a="158621162"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa6.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 26 Jun 2023 04:21:14 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Mon, 26 Jun 2023 04:21:09 -0700
Received: from wendy.microchip.com (10.10.115.15) by chn-vm-ex02.mchp-main.com
 (10.10.85.144) with Microsoft SMTP Server id 15.1.2507.21 via Frontend
 Transport; Mon, 26 Jun 2023 04:21:06 -0700
From:   Conor Dooley <conor.dooley@microchip.com>
To:     <palmer@dabbelt.com>
CC:     <conor@kernel.org>, <conor.dooley@microchip.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Andrew Jones <ajones@ventanamicro.com>,
        Heiko Stuebner <heiko.stuebner@vrull.eu>,
        "Evan Green" <evan@rivosinc.com>,
        Sunil V L <sunilvl@ventanamicro.com>,
        <linux-riscv@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH v1 9/9] RISC-V: try new extension properties in of_early_processor_hartid()
Date:   Mon, 26 Jun 2023 12:19:47 +0100
Message-ID: <20230626-ardently-caress-7c5886566ea6@wendy>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230626-provable-angrily-81760e8c3cc6@wendy>
References: <20230626-provable-angrily-81760e8c3cc6@wendy>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1532; i=conor.dooley@microchip.com; h=from:subject:message-id; bh=eZGPwaE1m+Pw9q6+drdEFoQWfh6B8MVtcv7cz4C7AWM=; b=owGbwMvMwCFWscWwfUFT0iXG02pJDCkzSwIaJ2btMmdgqZot8WPa/G3PGEPs4r1udXSujdFqnn9/ 14GTHaUsDGIcDLJiiiyJt/tapNb/cdnh3PMWZg4rE8gQBi5OAZjIa35GhvvsnlwdH+17zPm/9ExMZm n5+La70FFEbOkUKZ1ir5dmlxj+1076fM9XhG3d0c9OmjclNshf3Wa71PXiWp93E2qmir0rZQAA
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

To fully deprecate the kernel's use of "riscv,isa",
of_early_processor_hartid() needs to first try using the new properties,
before falling back to "riscv,isa".

Signed-off-by: Conor Dooley <conor.dooley@microchip.com>
---
 arch/riscv/kernel/cpu.c | 23 ++++++++++++++++++++++-
 1 file changed, 22 insertions(+), 1 deletion(-)

diff --git a/arch/riscv/kernel/cpu.c b/arch/riscv/kernel/cpu.c
index 046d9d3dac16..332574f27c95 100644
--- a/arch/riscv/kernel/cpu.c
+++ b/arch/riscv/kernel/cpu.c
@@ -61,8 +61,29 @@ int riscv_early_of_processor_hartid(struct device_node *node, unsigned long *har
 		return -ENODEV;
 	}
 
+	if (of_property_read_string(node, "riscv,isa-base", &isa))
+		goto old_interface;
+
+	if (IS_ENABLED(CONFIG_32BIT) && strncasecmp(isa, "rv32i", 5))
+		return -ENODEV;
+
+	if (IS_ENABLED(CONFIG_64BIT) && strncasecmp(isa, "rv64i", 5))
+		return -ENODEV;
+
+	if (!of_property_present(node, "riscv,isa-extensions"))
+		return -ENODEV;
+
+	if (of_property_match_string(node, "riscv,isa-extensions", "i") < 0 ||
+	    of_property_match_string(node, "riscv,isa-extensions", "m") < 0 ||
+	    of_property_match_string(node, "riscv,isa-extensions", "a") < 0)
+		return -ENODEV;
+
+	return 0;
+
+old_interface:
 	if (of_property_read_string(node, "riscv,isa", &isa)) {
-		pr_warn("CPU with hartid=%lu has no \"riscv,isa\" property\n", *hart);
+		pr_warn("CPU with hartid=%lu has no \"riscv,isa-base\" or \"riscv,isa\" property\n",
+			*hart);
 		return -ENODEV;
 	}
 
-- 
2.40.1

