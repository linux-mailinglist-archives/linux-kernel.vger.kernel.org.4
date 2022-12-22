Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C1BE6546A0
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Dec 2022 20:32:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235668AbiLVTc2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Dec 2022 14:32:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229868AbiLVTcS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Dec 2022 14:32:18 -0500
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77B1C17E34
        for <linux-kernel@vger.kernel.org>; Thu, 22 Dec 2022 11:32:15 -0800 (PST)
Received: by mail-wm1-x32e.google.com with SMTP id o5-20020a05600c510500b003d21f02fbaaso4640518wms.4
        for <linux-kernel@vger.kernel.org>; Thu, 22 Dec 2022 11:32:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zNJxRZfkj51KwDKq1a1M1MYd6okplAxevNZpSh9Sp8E=;
        b=M1INwOzOMu2/uO3wMa+PG1XV1IhWC/mSobIA2M20QAYfcNnT/bVoNTwXA99NjcqIzd
         af3gJ/smTHfLFB5LCHkTKvga9EnW5p8xsh4jK6dhTqKe+pfu+cqCnbth/fxNWN9AcsWG
         RnjpBEHD0cOWOtAHRKkEb5M13JyTj8Ol4BOk0/bQRoEfY3y6JQzJyEXiv6MGffefbSrm
         MumvBCraSE1kwfveS7v0Ag6ODRcVdOigk3B4A+ipBe8cJ+q7GM6nht6TVljoJs9S4uyy
         dPMVZqbHaZOwjuM1oXIxqsFU/3H/UeDduRLZUBLqqeoY4RTgwenwm4eXXHU3j1e6bZ5N
         3JQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zNJxRZfkj51KwDKq1a1M1MYd6okplAxevNZpSh9Sp8E=;
        b=2Be4VYsNWSuBmDtrW0Fn1FWOgTYucKRLqaOFexOsQCZEfyLcUBNK44D9S2xusYdvcz
         gKy2q8J5iQDKAtOGL8mOSORCQvM+YGEAywn1TAtr9VlnrpQZifYO+hg2DxMUJZrvuAu8
         uZGJnGbgJcG7foxBPZAHNpZPAShCKN6pvU2FNxD2OY6vXfVsVQyeMaIuSaqB0ndkvLth
         WwSJ4cIZqsXgGJHQDtgkobDVNZSGxdgjFlOFAoj/3EHGrEpV4TwuIIW4mL/22SNk9/9M
         VhvQ+v426OKEHdqPeC+OlOCo5HOt0RrMVXjGV4HhMECMiA5MTtBam0novsjehP0rtzg0
         DHCw==
X-Gm-Message-State: AFqh2kq1Lc6Iak7dlMNBIXaA2nu8M/2QxRMjtJHXwzEEIzpTX5+lvgHb
        56YAFSZddH+dv2Ekc6iFko8zAg==
X-Google-Smtp-Source: AMrXdXsiq5a3VIXTM1M/LZ9ItZoVVu6V8Rubs2+q5FtHOS2UV1GRCroRnLcceee6vs8Fyql/dNL3uA==
X-Received: by 2002:a05:600c:a4f:b0:3d3:5c35:8919 with SMTP id c15-20020a05600c0a4f00b003d35c358919mr5316137wmq.30.1671737534058;
        Thu, 22 Dec 2022 11:32:14 -0800 (PST)
Received: from nicolas-Precision-3551.home ([2001:861:5180:dcc0:f5e4:afec:1c65:21c3])
        by smtp.gmail.com with ESMTPSA id p12-20020a05600c468c00b003cf57329221sm4446729wmo.14.2022.12.22.11.32.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Dec 2022 11:32:13 -0800 (PST)
From:   Nicolas Frayer <nfrayer@baylibre.com>
To:     nm@ti.com, kristo@kernel.org, ssantosh@kernel.org,
        tglx@linutronix.de, maz@kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-omap@vger.kernel.org
Cc:     khilman@baylibre.com, glaroque@baylibre.com,
        mkorpershoek@baylibre.com, nfrayer@baylibre.com
Subject: [PATCH v2 2/2] irqchip: Kconfig: Added module build support for the TI interrupt aggregator
Date:   Thu, 22 Dec 2022 20:32:01 +0100
Message-Id: <20221222193201.1552711-3-nfrayer@baylibre.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221222193201.1552711-1-nfrayer@baylibre.com>
References: <20221222193201.1552711-1-nfrayer@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Added module build support in Kconfig for the TI SCI interrupt aggregator
driver. The driver's default build is built-in and it also depends on
ARCH_K3 as the driver uses some 64 bit ops and should only be built
for 64 bit platforms.

Signed-off-by: Nicolas Frayer <nfrayer@baylibre.com>
---
 arch/arm64/Kconfig.platforms | 1 -
 drivers/irqchip/Kconfig      | 5 +++--
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arm64/Kconfig.platforms b/arch/arm64/Kconfig.platforms
index 6ede8e105af52..26cd5021d265c 100644
--- a/arch/arm64/Kconfig.platforms
+++ b/arch/arm64/Kconfig.platforms
@@ -128,7 +128,6 @@ config ARCH_K3
 	select SOC_TI
 	select TI_MESSAGE_MANAGER
 	select TI_SCI_PROTOCOL
-	select TI_SCI_INTA_IRQCHIP
 	select TI_K3_SOCINFO
 	help
 	  This enables support for Texas Instruments' K3 multicore SoC
diff --git a/drivers/irqchip/Kconfig b/drivers/irqchip/Kconfig
index e773357e4ab03..77be35559168e 100644
--- a/drivers/irqchip/Kconfig
+++ b/drivers/irqchip/Kconfig
@@ -517,10 +517,11 @@ config TI_SCI_INTR_IRQCHIP
 	  TI System Controller, say Y here. Otherwise, say N.
 
 config TI_SCI_INTA_IRQCHIP
-	bool
-	depends on TI_SCI_PROTOCOL
+	tristate "TI SCI INTA Interrupt Controller"
+	depends on ARCH_K3 && TI_SCI_PROTOCOL
 	select IRQ_DOMAIN_HIERARCHY
 	select TI_SCI_INTA_MSI_DOMAIN
+	default ARCH_K3
 	help
 	  This enables the irqchip driver support for K3 Interrupt aggregator
 	  over TI System Control Interface available on some new TI's SoCs.
-- 
2.25.1

