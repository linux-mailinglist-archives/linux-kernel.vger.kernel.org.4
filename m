Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B78EE62D78B
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Nov 2022 10:55:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234569AbiKQJzz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Nov 2022 04:55:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239420AbiKQJzc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Nov 2022 04:55:32 -0500
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32F6C7721B
        for <linux-kernel@vger.kernel.org>; Thu, 17 Nov 2022 01:54:30 -0800 (PST)
Received: by mail-wr1-x429.google.com with SMTP id cl5so2848151wrb.9
        for <linux-kernel@vger.kernel.org>; Thu, 17 Nov 2022 01:54:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ge4h32WeUIGGUsdbGaeuk/Z15cXvVv3yHykriwBprs8=;
        b=M841FhfJxObnrtEdbOtKlI0HLA5EgEowM7jaDkLFjHo+tSzLuXoqvpgB1W9CQQRSUc
         WcPNX/YceioFB0+Ml+eMl+I/hZSIGBE2NhE7Gk4hREUP5LujErdd0HWMLEMnA/ZlevcA
         +/gvqiuSx+X9b/mjXWZVJshxmkO3rgLb9fQ09CIZBeVsYDEFDmIPICcILs4xjHRMuE4o
         svl+8lFebrbRSZ0uoFUK4+lXFujmpz9/jeneQJ99kbUzLnxR7XlXoGE5jgdvp6+T7Y/s
         nVVV5It5qbuK1EB9DXk8kA3zpOGSjwA94caU9eop3kaIwOo7NWlLTw8yvk6uTIkQQcO/
         /y6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ge4h32WeUIGGUsdbGaeuk/Z15cXvVv3yHykriwBprs8=;
        b=4p04p4hpXjDe0es4m9SOSwXzjg6AIpYvDDFsVa0ov4604R2lYObehN2QJiKFh3mJV+
         HxfQU/lHxmaBKpSg4pDZrKsbw7aMYgTeDAux7rQlUKFbYiE8nxk10XE0nUAhN+BKfvf7
         Z5xohp60y9NMW2OGulZd+nnOtH7no2wtR7pMRsXqXVBXBWJlgRsLontV5sqzQEvqBlFA
         kMmtxdL4yaSjAkxau/3190MXzuvTXRXJD3NQN6rQhkfo3cbfg9NJe7aPFX1CHLFmV6xt
         1HLyJ7SEo+GS0uWvzjHeFoXzvgE/cJlYGAaSVRjGRkIjQ9gxyh7SHr4ICOKIcV3tUhmi
         WfSQ==
X-Gm-Message-State: ANoB5plkjMflvzX2mzgQlV9JHPpJ6p463HO1Kl/xK9dJjncAIjo/iSkA
        bUquEgOf7puWcNKEKbZe5vvhXA==
X-Google-Smtp-Source: AA0mqf6l0cQKDF/K1HFMIuXcsrD+LUWBqTwTOQ+o6QUUg5NOe9UpujiBnif5Ji3qGRkiw+9jw/SAWg==
X-Received: by 2002:adf:e648:0:b0:236:774e:5b78 with SMTP id b8-20020adfe648000000b00236774e5b78mr980201wrn.351.1668678868797;
        Thu, 17 Nov 2022 01:54:28 -0800 (PST)
Received: from nicolas-Precision-3551.home ([2001:861:5180:dcc0:9287:74a3:4740:e7a0])
        by smtp.gmail.com with ESMTPSA id v18-20020a5d6112000000b00236e834f050sm497021wrt.35.2022.11.17.01.54.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Nov 2022 01:54:28 -0800 (PST)
From:   Nicolas Frayer <nfrayer@baylibre.com>
To:     nm@ti.com, ssantosh@kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Cc:     khilman@baylibre.com, glaroque@baylibre.com, nfrayer@baylibre.com
Subject: [PATCH v6 2/2] soc: ti: k3-socinfo: Add module build support
Date:   Thu, 17 Nov 2022 10:54:19 +0100
Message-Id: <20221117095419.171906-3-nfrayer@baylibre.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221117095419.171906-1-nfrayer@baylibre.com>
References: <20221117095419.171906-1-nfrayer@baylibre.com>
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
index 76580b932e44..4f2f92eb499f 100644
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
index 7e2fb1c16af1..3244fa8a5b0e 100644
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

