Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C5B3F72122C
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Jun 2023 22:05:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230094AbjFCUFJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 3 Jun 2023 16:05:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229936AbjFCUE7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 3 Jun 2023 16:04:59 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C2011A7;
        Sat,  3 Jun 2023 13:04:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1685822693; x=1717358693;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=n72Mi5CHYjTekZNhh3wgxCm6RCoAYvNuRArMlcfF45k=;
  b=DMTjxsYT3cq2rfh2PVMWJQUNUbN5WmKqyujCihjSp0J9JEIwP2wekoSt
   JcTn/npy9yVYfzJQOqbGGmo1Gmv3+x77XbFKckZCPYljS4HxVN4PT3e05
   gf+U43wuoR3k6plcaUi5aQ4ooiqCgaOkOywtDT2ujdxaRasMyUIFLuzWK
   XrjB+Lz55PLX5HxPRPKBHDnvui8oTSkCS1ePnluOLxirslIn7pi0BWoVU
   KPUnCPnf8lhzvapzKuye3i43PlEjfCHbDZ2AEIMrpzH1FKGt30P5tmpBA
   pdN9WFXVQFPTir0hrem5dRrkMT6amLTRn3lpofB0p/uN5q7nTNRJF8guE
   A==;
X-IronPort-AV: E=Sophos;i="6.00,216,1681196400"; 
   d="scan'208";a="228307928"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa1.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 03 Jun 2023 13:04:52 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Sat, 3 Jun 2023 13:04:51 -0700
Received: from che-lt-i67070.amer.actel.com (10.10.115.15) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server id
 15.1.2507.21 via Frontend Transport; Sat, 3 Jun 2023 13:04:39 -0700
From:   Varshini Rajendran <varshini.rajendran@microchip.com>
To:     <tglx@linutronix.de>, <maz@kernel.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
        <nicolas.ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
        <claudiu.beznea@microchip.com>, <davem@davemloft.net>,
        <edumazet@google.com>, <kuba@kernel.org>, <pabeni@redhat.com>,
        <gregkh@linuxfoundation.org>, <linux@armlinux.org.uk>,
        <mturquette@baylibre.com>, <sboyd@kernel.org>, <sre@kernel.org>,
        <broonie@kernel.org>, <varshini.rajendran@microchip.com>,
        <arnd@arndb.de>, <gregory.clement@bootlin.com>,
        <sudeep.holla@arm.com>, <balamanikandan.gunasundar@microchip.com>,
        <mihai.sain@microchip.com>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <netdev@vger.kernel.org>,
        <linux-usb@vger.kernel.org>, <linux-clk@vger.kernel.org>,
        <linux-pm@vger.kernel.org>
CC:     <Hari.PrasathGE@microchip.com>, <cristian.birsan@microchip.com>,
        <durai.manickamkr@microchip.com>, <manikandan.m@microchip.com>,
        <dharma.b@microchip.com>, <nayabbasha.sayed@microchip.com>,
        <balakrishnan.s@microchip.com>
Subject: [PATCH 08/21] ARM: at91: pm: add support for sam9x7 soc family
Date:   Sun, 4 Jun 2023 01:32:30 +0530
Message-ID: <20230603200243.243878-9-varshini.rajendran@microchip.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230603200243.243878-1-varshini.rajendran@microchip.com>
References: <20230603200243.243878-1-varshini.rajendran@microchip.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support and pm init config for sam9x7 soc

Signed-off-by: Varshini Rajendran <varshini.rajendran@microchip.com>
---
 arch/arm/mach-at91/generic.h |  2 ++
 arch/arm/mach-at91/pm.c      | 35 +++++++++++++++++++++++++++++++++++
 2 files changed, 37 insertions(+)

diff --git a/arch/arm/mach-at91/generic.h b/arch/arm/mach-at91/generic.h
index 0c3960a8b3eb..acf0b3c82a30 100644
--- a/arch/arm/mach-at91/generic.h
+++ b/arch/arm/mach-at91/generic.h
@@ -12,6 +12,7 @@
 extern void __init at91rm9200_pm_init(void);
 extern void __init at91sam9_pm_init(void);
 extern void __init sam9x60_pm_init(void);
+extern void __init sam9x7_pm_init(void);
 extern void __init sama5_pm_init(void);
 extern void __init sama5d2_pm_init(void);
 extern void __init sama7_pm_init(void);
@@ -19,6 +20,7 @@ extern void __init sama7_pm_init(void);
 static inline void __init at91rm9200_pm_init(void) { }
 static inline void __init at91sam9_pm_init(void) { }
 static inline void __init sam9x60_pm_init(void) { }
+static inline void __init sam9x7_pm_init(void) { }
 static inline void __init sama5_pm_init(void) { }
 static inline void __init sama5d2_pm_init(void) { }
 static inline void __init sama7_pm_init(void) { }
diff --git a/arch/arm/mach-at91/pm.c b/arch/arm/mach-at91/pm.c
index 60dc56d8acfb..43a77ae0c38c 100644
--- a/arch/arm/mach-at91/pm.c
+++ b/arch/arm/mach-at91/pm.c
@@ -232,6 +232,17 @@ static const struct of_device_id sama7g5_ws_ids[] = {
 	{ /* sentinel */ }
 };
 
+static const struct of_device_id sam9x7_ws_ids[] = {
+	{ .compatible = "microchip,sam9x60-rtc",	.data = &ws_info[1] },
+	{ .compatible = "atmel,at91rm9200-ohci",	.data = &ws_info[2] },
+	{ .compatible = "usb-ohci",			.data = &ws_info[2] },
+	{ .compatible = "atmel,at91sam9g45-ehci",	.data = &ws_info[2] },
+	{ .compatible = "usb-ehci",			.data = &ws_info[2] },
+	{ .compatible = "microchip,sam9x60-rtt",	.data = &ws_info[4] },
+	{ .compatible = "microchip,sam9x7-gem",		.data = &ws_info[5] },
+	{ /* sentinel */ }
+};
+
 static int at91_pm_config_ws(unsigned int pm_mode, bool set)
 {
 	const struct wakeup_source_info *wsi;
@@ -1133,6 +1144,7 @@ static const struct of_device_id gmac_ids[] __initconst = {
 	{ .compatible = "atmel,sama5d2-gem" },
 	{ .compatible = "atmel,sama5d29-gem" },
 	{ .compatible = "microchip,sama7g5-gem" },
+	{ .compatible = "microchip,sam9x7-gem" },
 	{ },
 };
 
@@ -1360,6 +1372,7 @@ static const struct of_device_id atmel_pmc_ids[] __initconst = {
 	{ .compatible = "atmel,sama5d2-pmc", .data = &pmc_infos[1] },
 	{ .compatible = "microchip,sam9x60-pmc", .data = &pmc_infos[4] },
 	{ .compatible = "microchip,sama7g5-pmc", .data = &pmc_infos[5] },
+	{ .compatible = "microchip,sam9x7-pmc", .data = &pmc_infos[4] },
 	{ /* sentinel */ },
 };
 
@@ -1497,6 +1510,28 @@ void __init sam9x60_pm_init(void)
 	soc_pm.config_pmc_ws = at91_sam9x60_config_pmc_ws;
 }
 
+void __init sam9x7_pm_init(void)
+{
+	static const int modes[] __initconst = {
+		AT91_PM_STANDBY, AT91_PM_ULP0,
+	};
+
+	int ret;
+
+	if (!IS_ENABLED(CONFIG_SOC_SAM9X7))
+		return;
+
+	at91_pm_modes_validate(modes, ARRAY_SIZE(modes));
+	ret = at91_dt_ramc(false);
+	if (ret)
+		return;
+
+	at91_pm_init(NULL);
+
+	soc_pm.ws_ids = sam9x7_ws_ids;
+	soc_pm.config_pmc_ws = at91_sam9x60_config_pmc_ws;
+}
+
 void __init at91sam9_pm_init(void)
 {
 	int ret;
-- 
2.25.1

