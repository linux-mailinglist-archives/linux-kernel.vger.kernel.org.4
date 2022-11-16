Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9EE1E62C877
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Nov 2022 19:56:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233799AbiKPS4K (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Nov 2022 13:56:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238611AbiKPSzu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Nov 2022 13:55:50 -0500
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C84562DCF
        for <linux-kernel@vger.kernel.org>; Wed, 16 Nov 2022 10:55:09 -0800 (PST)
Received: by mail-wr1-x42a.google.com with SMTP id o4so31313858wrq.6
        for <linux-kernel@vger.kernel.org>; Wed, 16 Nov 2022 10:55:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yC+ZvGeuV708LRepwFxAzDvpt6r2kZ2kPIpakorvNBc=;
        b=dN3eQsDdf+GLzKeEd9JwUCAw3cFWfnDmXEqowZLPi/HYzc+t9WGE8u8+dff+PAAVzF
         hPHVBFYOKOvLGTM+eJ7ttM98m23Cv6vfDdagHmrRCYp9m9VMB7aUJPwuukCViSnoPVkE
         M5uea2gQJWkcFF6flh++khhwnz2L2p6lzua3yxaXDlt/XUmK2wJODOj/Yq2fNiPcUAIn
         SNZOmV1197Zj1iiC2WID+k583qxKQNbz+KLl9lhsKkiz4dhus50Tz2dSAsWMpx7lzKWw
         IDPMqrGMNmw5br+f/R4EMAgkjE0PEYt/HXOac+nmPgry5Xc3t2B5bPKuRRR78GfUusvX
         +suQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yC+ZvGeuV708LRepwFxAzDvpt6r2kZ2kPIpakorvNBc=;
        b=FwK9r0/+IYMDqlpHVTj4lUmjesfXTY+4eDnpSL2EM5rfOlK0TKzDneeoPNrvH7Vxhd
         h7gAYBDhOrY4IGI6qVhBiBWfaRLzTC9NuNTgpoeB3XczH9diOmtj+MCSrUFByGUo81jU
         DzcXAz5qrkxNz1BjdFaxqnjoBfys+RBSC3cj+mfVsP8JmBy9s/DWhnYtrq8Vh7K8bMSn
         jmCEpX9AOtMrNEbQAyTawLnKhwO0et42KeW+Q+winN1yjQzmglyIJn2tjhrnK8XxLuQm
         gT2azaNZNtwZyw4sfHD83gem9aZLI4OIVhsK0DeJcuXdzokQojUqUV6GDIa26E5PXioa
         Xkkg==
X-Gm-Message-State: ANoB5pngjvl25qIVG//dRJp3/69i2T8px2b2nAhEfzr1Ao0ZgOa4TFhY
        yfNLD7d2Flwoq+ndJqhfgO6z5w==
X-Google-Smtp-Source: AA0mqf4FaT8z9IJv1WmZiqWI+7/QDGJmY/qd5SKdEHVuMg3R3if3ON5x8RaXhvvMbDrPN4b74ziSOg==
X-Received: by 2002:adf:f0d2:0:b0:236:8ef4:6eea with SMTP id x18-20020adff0d2000000b002368ef46eeamr15197231wro.716.1668624908424;
        Wed, 16 Nov 2022 10:55:08 -0800 (PST)
Received: from nicolas-Precision-3551.home ([2001:861:5180:dcc0:3f99:5293:49fd:9c5b])
        by smtp.gmail.com with ESMTPSA id a16-20020a056000051000b002365730eae8sm15771280wrf.55.2022.11.16.10.55.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Nov 2022 10:55:08 -0800 (PST)
From:   Nicolas Frayer <nfrayer@baylibre.com>
To:     tglx@linutronix.de, maz@kernel.org, linux-kernel@vger.kernel.org
Cc:     khilman@baylibre.com, glaroque@baylibre.com, nfrayer@baylibre.com
Subject: [PATCH 1/2] irqchip: Kconfig: module build support for the TI interrupt router driver
Date:   Wed, 16 Nov 2022 19:54:59 +0100
Message-Id: <20221116185500.40431-2-nfrayer@baylibre.com>
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

Added module build support in Kconfig for the TI SCI interrupt router
driver

Signed-off-by: Nicolas Frayer <nfrayer@baylibre.com>
---
 arch/arm64/Kconfig.platforms | 1 -
 drivers/irqchip/Kconfig      | 5 +++--
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arm64/Kconfig.platforms b/arch/arm64/Kconfig.platforms
index 912529ac58b3..2ee8de238b39 100644
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
 	  This enables support for Texas Instruments' K3 multicore SoC
diff --git a/drivers/irqchip/Kconfig b/drivers/irqchip/Kconfig
index 7ef9f5e696d3..ea79d2499372 100644
--- a/drivers/irqchip/Kconfig
+++ b/drivers/irqchip/Kconfig
@@ -506,9 +506,10 @@ config LS1X_IRQ
 	  Support for the Loongson-1 platform Interrupt Controller.
 
 config TI_SCI_INTR_IRQCHIP
-	bool
-	depends on TI_SCI_PROTOCOL
+	tristate "TI SCI INTR Interrupt Controller"
+	select TI_SCI_PROTOCOL
 	select IRQ_DOMAIN_HIERARCHY
+	default ARCH_K3
 	help
 	  This enables the irqchip driver support for K3 Interrupt router
 	  over TI System Control Interface available on some new TI's SoCs.
-- 
2.25.1

