Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B11E62C171
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Nov 2022 15:53:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233936AbiKPOxU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Nov 2022 09:53:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233406AbiKPOwz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Nov 2022 09:52:55 -0500
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2D673E0A0
        for <linux-kernel@vger.kernel.org>; Wed, 16 Nov 2022 06:51:22 -0800 (PST)
Received: by mail-wm1-x331.google.com with SMTP id c3-20020a1c3503000000b003bd21e3dd7aso1806204wma.1
        for <linux-kernel@vger.kernel.org>; Wed, 16 Nov 2022 06:51:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MIxl+dyuDxJf/KHK5mOk1YlQ1ePtA/R5q7N29MhOEr8=;
        b=hsyTLKcjJMtC2XIlo46Q4n/wHg0xvqCJltw/e9GWAGSXeqYTbN+AeeOyqDOILQDPRJ
         VlZPOxei0RyrtZSYQA3/nUxXlLpcmc102QNJPY1zMruofp6isA8A+OthiNqB7h+WTL61
         eaYz2Wwmkn0jPyo0z8kloe6eMbP62hjiMFuogEyTt7hQoVPBs+aZaRYnIfuEl8UnrfpH
         cwpERayw3L2AS8oaa1ZoU+nfs08uXf4umcLLsBRfDM4R4LqY5gkEAlmEpQRknVyGwIxE
         fdc4YkvXRrGn8kGkQ0sl6ZLDt7qQHJqRMoSMwdl+T1DGuG7RRtnyY/Vg71PItFDfNWVV
         LAZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MIxl+dyuDxJf/KHK5mOk1YlQ1ePtA/R5q7N29MhOEr8=;
        b=DXMgYVIiSQWuAQDA+yPUBrGnHI1YDoByrBiGN6Xrf+D1x7MInef96L/jtAc/MIvbnQ
         4VjbpeFZj1OeugQ7yVCKEQxUWtkfS0GO9wSwy3eAc6szWsWNnAJT7RrdSkSQrZ0UxfI4
         1CwoJ0tWqvPsKuAUauKyYRqdLtgPeysnK2Rfl90KxagoLYPmzbbnAM49x/DHr34gukQD
         84BPTYl3aiFoMu0Cft5gdGf9rOiqP/SmkVOMLqmpF5JoqpJr/xMMs9OM9aQzcTljYgWI
         Uceb8AeRPLCVMIUN0CUDbDd6NXp3AVw1AJy4jHoUvHx7ZeWz+v9h6b9O/mk5dj/U8A4C
         ++fw==
X-Gm-Message-State: ANoB5pnW1t7mDCsopM+j9gUrczDVxCZ421WeB3rD/ESb+wzlN1FUFQbb
        ezz4s16+w8xAjqPYuAWsQ5XBtg==
X-Google-Smtp-Source: AA0mqf6knMjrYErEYhVRUW3wV7V1cB4HPC7OVJP7YkKtfqykl2aqt1oHvkMg0/AJ124bPHwgFb3NWw==
X-Received: by 2002:a1c:541c:0:b0:3cf:774b:ce5a with SMTP id i28-20020a1c541c000000b003cf774bce5amr2520965wmb.0.1668610281465;
        Wed, 16 Nov 2022 06:51:21 -0800 (PST)
Received: from nicolas-Precision-3551.home ([2001:861:5180:dcc0:3f99:5293:49fd:9c5b])
        by smtp.gmail.com with ESMTPSA id k21-20020a05600c1c9500b003cfa3a12660sm8641789wms.1.2022.11.16.06.51.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Nov 2022 06:51:21 -0800 (PST)
From:   Nicolas Frayer <nfrayer@baylibre.com>
To:     nm@ti.com, ssantosh@kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Cc:     khilman@baylibre.com, glaroque@baylibre.com, nfrayer@baylibre.com
Subject: [PATCH v5 2/2] soc: ti: Add module build support
Date:   Wed, 16 Nov 2022 15:51:03 +0100
Message-Id: <20221116145103.26744-3-nfrayer@baylibre.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221116145103.26744-1-nfrayer@baylibre.com>
References: <20221116145103.26744-1-nfrayer@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Added module build support for the TI K3 SoC info driver.

Signed-off-by: Nicolas Frayer <nfrayer@baylibre.com>
---
 arch/arm64/Kconfig.platforms |  1 -
 drivers/soc/ti/Kconfig       |  3 ++-
 drivers/soc/ti/k3-socinfo.c  | 11 +++++++++++
 3 files changed, 13 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/Kconfig.platforms b/arch/arm64/Kconfig.platforms
index d1970adf80ab..912529ac58b3 100644
--- a/arch/arm64/Kconfig.platforms
+++ b/arch/arm64/Kconfig.platforms
@@ -130,7 +130,6 @@ config ARCH_K3
 	select TI_SCI_PROTOCOL
 	select TI_SCI_INTR_IRQCHIP
 	select TI_SCI_INTA_IRQCHIP
-	select TI_K3_SOCINFO
 	help
 	  This enables support for Texas Instruments' K3 multicore SoC
 	  architecture.
diff --git a/drivers/soc/ti/Kconfig b/drivers/soc/ti/Kconfig
index e009d9589af4..b944e8bd3a8b 100644
--- a/drivers/soc/ti/Kconfig
+++ b/drivers/soc/ti/Kconfig
@@ -74,7 +74,8 @@ config TI_K3_RINGACC
 	  If unsure, say N.
 
 config TI_K3_SOCINFO
-	bool
+	tristate "TI K3 SoC info driver"
+	default ARCH_K3
 	depends on ARCH_K3 || COMPILE_TEST
 	select SOC_BUS
 	select MFD_SYSCON
diff --git a/drivers/soc/ti/k3-socinfo.c b/drivers/soc/ti/k3-socinfo.c
index 19f3e74f5376..98348f998e0f 100644
--- a/drivers/soc/ti/k3-socinfo.c
+++ b/drivers/soc/ti/k3-socinfo.c
@@ -13,6 +13,7 @@
 #include <linux/slab.h>
 #include <linux/string.h>
 #include <linux/sys_soc.h>
+#include <linux/module.h>
 
 #define CTRLMMR_WKUP_JTAGID_REG		0
 /*
@@ -141,6 +142,7 @@ static const struct of_device_id k3_chipinfo_of_match[] = {
 	{ .compatible = "ti,am654-chipid", },
 	{ /* sentinel */ },
 };
+MODULE_DEVICE_TABLE(of, k3_chipinfo_of_match);
 
 static struct platform_driver k3_chipinfo_driver = {
 	.driver = {
@@ -156,3 +158,12 @@ static int __init k3_chipinfo_init(void)
 	return platform_driver_register(&k3_chipinfo_driver);
 }
 subsys_initcall(k3_chipinfo_init);
+
+static void __exit k3_chipinfo_exit(void)
+{
+	platform_driver_unregister(&k3_chipinfo_driver);
+}
+module_exit(k3_chipinfo_exit);
+
+MODULE_DESCRIPTION("TI K3 SoC info driver");
+MODULE_LICENSE("GPL");
-- 
2.25.1

