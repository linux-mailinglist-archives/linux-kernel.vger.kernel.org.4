Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1554065469F
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Dec 2022 20:32:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235614AbiLVTcY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Dec 2022 14:32:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231345AbiLVTcS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Dec 2022 14:32:18 -0500
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B235F13FAB
        for <linux-kernel@vger.kernel.org>; Thu, 22 Dec 2022 11:32:14 -0800 (PST)
Received: by mail-wm1-x32b.google.com with SMTP id o15so2167851wmr.4
        for <linux-kernel@vger.kernel.org>; Thu, 22 Dec 2022 11:32:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4LScnR97JjHMi4S1rF8CGEtPw9AqlLZZAUF0xcigJ2I=;
        b=VOPpCFKfnE12/TkToUE9fIL0WOTRG16ycf3CM6VFmJh4s26PjrNzbmzZE0kzOfrYYj
         yIDf7jDjcFV+Os8K/Tkh7qztm33U+TSVBsDHEDVGsEq+CP0rDptsJ5tgvmEhxnYf0WcC
         fOPxqfYv5y+2RuHqvSOyxkyW5UyadIrsuQwidJ4ieTGAqnalUAOzOA/hJYIS0OUC+ooa
         z3x3Ppu5hmBJ+YwHwIpxJbXMroRBmxcPLd0RyCTYG7U8LUB36OPPHXBFgKEatlR20Yai
         IqZwt8Jjii5q3MUqx03odk3RBybMHfzQfFw20CrrrplKB5N80Dai+Igu5kTFXe7cW0V2
         G0Uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4LScnR97JjHMi4S1rF8CGEtPw9AqlLZZAUF0xcigJ2I=;
        b=6+kjZT+8O1Bv5fcYPtGWSF+T37Nkl6iVwS82zpsYO0IGMF3mNeHip0aAvzM624wCL9
         2e2DPAyNhuwQ9J3xKgvbdjmLlkmZCmkXRUgM5xZCLAE1h0ZefQafiH9R+PX8Tq7DWlZE
         IBDCxLOLWMcRpPM7InTuyjPduTZfAqnOA+OVuXNGExOjswjgiUi8QxNgRgg0Ucs6yTkC
         4d2iQBMFAEy89FfagXbH5YABvWyIreS9W9r/G4skTNQM/EBjb0x9JQXcFj2oFZ/EdKEX
         VhvykBhy71sg1zLwHb1nqngnob2isEeZTcbXomHGbaoMe0e6RD8lXT/g7PwPX0ggEruZ
         uvhw==
X-Gm-Message-State: AFqh2kryEwPeD30EWCIPsnydTn9I860Ge2iDQ54mr6x7lcEnJ7Q3P3tu
        dFRhJovLZSbS2uO0zb6S6nSQkQ==
X-Google-Smtp-Source: AMrXdXs//QvSBgKwiNaaIxucSfyQbLplDgLAg/P/UCwJ4cV+D6eU3RGZIoMHvno8bcsC8acx/76JIA==
X-Received: by 2002:a05:600c:3495:b0:3c6:e62e:2e74 with SMTP id a21-20020a05600c349500b003c6e62e2e74mr4973525wmq.15.1671737533249;
        Thu, 22 Dec 2022 11:32:13 -0800 (PST)
Received: from nicolas-Precision-3551.home ([2001:861:5180:dcc0:f5e4:afec:1c65:21c3])
        by smtp.gmail.com with ESMTPSA id p12-20020a05600c468c00b003cf57329221sm4446729wmo.14.2022.12.22.11.32.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Dec 2022 11:32:12 -0800 (PST)
From:   Nicolas Frayer <nfrayer@baylibre.com>
To:     nm@ti.com, kristo@kernel.org, ssantosh@kernel.org,
        tglx@linutronix.de, maz@kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-omap@vger.kernel.org
Cc:     khilman@baylibre.com, glaroque@baylibre.com,
        mkorpershoek@baylibre.com, nfrayer@baylibre.com
Subject: [PATCH v2 1/2] irqchip: Kconfig: module build support for the TI interrupt router driver
Date:   Thu, 22 Dec 2022 20:32:00 +0100
Message-Id: <20221222193201.1552711-2-nfrayer@baylibre.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221222193201.1552711-1-nfrayer@baylibre.com>
References: <20221222193201.1552711-1-nfrayer@baylibre.com>
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

Added module build support in Kconfig for the TI SCI interrupt router
driver

Signed-off-by: Nicolas Frayer <nfrayer@baylibre.com>
---
 arch/arm64/Kconfig.platforms | 1 -
 drivers/irqchip/Kconfig      | 3 ++-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/Kconfig.platforms b/arch/arm64/Kconfig.platforms
index d1970adf80ab3..6ede8e105af52 100644
--- a/arch/arm64/Kconfig.platforms
+++ b/arch/arm64/Kconfig.platforms
@@ -128,7 +128,6 @@ config ARCH_K3
 	select SOC_TI
 	select TI_MESSAGE_MANAGER
 	select TI_SCI_PROTOCOL
-	select TI_SCI_INTR_IRQCHIP
 	select TI_SCI_INTA_IRQCHIP
 	select TI_K3_SOCINFO
 	help
diff --git a/drivers/irqchip/Kconfig b/drivers/irqchip/Kconfig
index caa952c40ff92..e773357e4ab03 100644
--- a/drivers/irqchip/Kconfig
+++ b/drivers/irqchip/Kconfig
@@ -506,9 +506,10 @@ config LS1X_IRQ
 	  Support for the Loongson-1 platform Interrupt Controller.
 
 config TI_SCI_INTR_IRQCHIP
-	bool
+	tristate "TI SCI INTR Interrupt Controller"
 	depends on TI_SCI_PROTOCOL
 	select IRQ_DOMAIN_HIERARCHY
+	default ARCH_K3
 	help
 	  This enables the irqchip driver support for K3 Interrupt router
 	  over TI System Control Interface available on some new TI's SoCs.
-- 
2.25.1

