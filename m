Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 274D662C878
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Nov 2022 19:56:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231370AbiKPS4N (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Nov 2022 13:56:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234639AbiKPSzu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Nov 2022 13:55:50 -0500
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84E7525F6
        for <linux-kernel@vger.kernel.org>; Wed, 16 Nov 2022 10:55:10 -0800 (PST)
Received: by mail-wr1-x429.google.com with SMTP id w14so31430262wru.8
        for <linux-kernel@vger.kernel.org>; Wed, 16 Nov 2022 10:55:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jukxkPU/QE+9dTDy9wvR1S6biRVYwlww7LIcqBeNLxg=;
        b=79cm72CP+JtQJP++Xq/vwXMhAdJBxoFJSkVmmM8VIfb1eTGQd1nbMrdSrhUV0xa0Zj
         RyCkDokMQBvDLVihIQz3ZdK4JoH4+LbtwjgvZ+fn02ulfGSopYkJ2VGAKVgICWo0KWhO
         kBbB050+UuKfnQSDJNNqD5FxNqVyHWX7er7ZOtJ5ZU4MhaTfZxyWN7RO3FKi5iD3FUWf
         YCd0CHIFGbvqA0B58eFH9ksHOkOSWVjRUYOLsEAiNqsGb7NczFCbhP3lcD0XZpXlc3/a
         HqybphZ/e7kGcHYxhVbqr1dHu44VvokIGHmdOHFHUmSOWUJRnBNwKWL5UubS7vsZE3zy
         7P8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jukxkPU/QE+9dTDy9wvR1S6biRVYwlww7LIcqBeNLxg=;
        b=DknEVt43ge1wsEDxaOr6NBchUpvKKAxVqHXUWrsi7p7VAy3UDcfwYHrPdOnCnIqM3i
         0kXYw/89OX1il2nOVjLN2AS5xrp3ZJWTiuHhd4ylLsVqwFP8cia9duEq4HVxDs68NT1k
         7Z35M+njFB/M9bSIk3seoRp3gMdE6m5JERg6gfeWjuouPWW4qbaYMSJCKvTgRgAdz95f
         vb47aFY0AdpwS/R9aXgnxjHRsNiLBHRjhHyOhn3RcgMucBR7Kl+GivL38YgiPiYGwKt5
         WrC+R5VgvS5EcX90+Vv0EqpSF4shNDU7ZLOVOSkB9a3SoZoJtsMzW1a2G2oSnwIaFRXM
         69LA==
X-Gm-Message-State: ANoB5pmhm7qQW8nbvdT+I6aK5PIHOBUi3OfN0rC+klY/323ZGQRhWhpB
        5thHspg8Ll9tJ34uMBKjK7TbUA==
X-Google-Smtp-Source: AA0mqf766CvpMuH2ku2GRR0JY1w4FWIeBM76va61CnZ0So0uh4lNzS0Tzki9Bg4nBSUz0KUN6oJj+g==
X-Received: by 2002:a5d:4a83:0:b0:236:b24b:aaf9 with SMTP id o3-20020a5d4a83000000b00236b24baaf9mr14628731wrq.394.1668624909087;
        Wed, 16 Nov 2022 10:55:09 -0800 (PST)
Received: from nicolas-Precision-3551.home ([2001:861:5180:dcc0:3f99:5293:49fd:9c5b])
        by smtp.gmail.com with ESMTPSA id a16-20020a056000051000b002365730eae8sm15771280wrf.55.2022.11.16.10.55.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Nov 2022 10:55:08 -0800 (PST)
From:   Nicolas Frayer <nfrayer@baylibre.com>
To:     tglx@linutronix.de, maz@kernel.org, linux-kernel@vger.kernel.org
Cc:     khilman@baylibre.com, glaroque@baylibre.com, nfrayer@baylibre.com
Subject: [PATCH 2/2] irqchip: Kconfig: Added module build support for the TI interrupt aggregator
Date:   Wed, 16 Nov 2022 19:55:00 +0100
Message-Id: <20221116185500.40431-3-nfrayer@baylibre.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221116185500.40431-1-nfrayer@baylibre.com>
References: <20221116185500.40431-1-nfrayer@baylibre.com>
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

Added module build support in Kconfig for the TI SCI interrupt aggregator
driver

Signed-off-by: Nicolas Frayer <nfrayer@baylibre.com>
---
 arch/arm64/Kconfig.platforms | 1 -
 drivers/irqchip/Kconfig      | 7 ++++---
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/arm64/Kconfig.platforms b/arch/arm64/Kconfig.platforms
index 2ee8de238b39..d9f0a93f3826 100644
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
 	  architecture.
diff --git a/drivers/irqchip/Kconfig b/drivers/irqchip/Kconfig
index ea79d2499372..7d5dd130d16f 100644
--- a/drivers/irqchip/Kconfig
+++ b/drivers/irqchip/Kconfig
@@ -517,10 +517,11 @@ config TI_SCI_INTR_IRQCHIP
 	  TI System Controller, say Y here. Otherwise, say N.
 
 config TI_SCI_INTA_IRQCHIP
-	bool
-	depends on TI_SCI_PROTOCOL
-	select IRQ_DOMAIN_HIERARCHY
+	tristate "TI SCI INTA Interrupt Controller"
+	select TI_SCI_PROTOCOL
 	select TI_SCI_INTA_MSI_DOMAIN
+	select IRQ_DOMAIN_HIERARCHY
+	default ARCH_K3
 	help
 	  This enables the irqchip driver support for K3 Interrupt aggregator
 	  over TI System Control Interface available on some new TI's SoCs.
-- 
2.25.1

