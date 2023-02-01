Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 429E26868AB
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Feb 2023 15:43:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232571AbjBAOnR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Feb 2023 09:43:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232502AbjBAOnK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Feb 2023 09:43:10 -0500
Received: from mail.fris.de (mail.fris.de [116.203.77.234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39E1EF751;
        Wed,  1 Feb 2023 06:43:04 -0800 (PST)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id A3F56C0340;
        Wed,  1 Feb 2023 15:35:21 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fris.de; s=dkim;
        t=1675262122; h=from:subject:date:message-id:to:cc:mime-version:
         content-transfer-encoding:in-reply-to:references;
        bh=s+I2FNNs+N+h3hl6gVrjPwSvZ5ntoO7yYLOlsjMKshg=;
        b=X/aZQs7ZNCRFZ3MdWAMbtDzLN1eXorx7zqRcGW/qhiRxZxgRp0Kgil1B5Oes0tlJnDJbgt
        JTNHlMqlMF7pRitaPnLv3YBoWWkiVJLkHN5hf3r/AISUyQIpj25+oH8yRuFOL7L7H3QXk3
        jU/1xffz52Ul4TR4OZZmEU42yLNjywbNT7aTYpbkbA4fRNZnbzkAqWLH3iGlUDBed6trYG
        +V39IaEbSi4eFiqYwghw5K5KZ/kPbh2oNf+3nATF3IWWYxfoNFNHUgh1GnC80ITObIT9PK
        Pn8ZZJkbMb/LgNdg981I76EOEeXzSuWDTMFI4finyA6fYyPBHv0xEO2tLx+F9Q==
From:   Frieder Schrempf <frieder@fris.de>
To:     devicetree@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Shawn Guo <shawnguo@kernel.org>
Cc:     Frieder Schrempf <frieder.schrempf@kontron.de>,
        Fabio Estevam <festevam@gmail.com>,
        Heiko Thiery <heiko.thiery@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Marek Vasut <marex@denx.de>,
        NXP Linux Team <linux-imx@nxp.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>
Subject: [PATCH 7/7] arm64: dts: imx8mm-kontron: Enable backup switch mode for RTC on OSM-S module
Date:   Wed,  1 Feb 2023 15:34:29 +0100
Message-Id: <20230201143431.863784-8-frieder@fris.de>
In-Reply-To: <20230201143431.863784-1-frieder@fris.de>
References: <20230201143431.863784-1-frieder@fris.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Frieder Schrempf <frieder.schrempf@kontron.de>

The board has a battery backup supply for the RTC, but the factory
default is to have BSM disabled. Therefore the time will not be
preserved if the board is not supplied. Fix this by forcing the RTC
into BSM level mode.

Signed-off-by: Frieder Schrempf <frieder.schrempf@kontron.de>
---
 arch/arm64/boot/dts/freescale/imx8mm-kontron-osm-s.dtsi | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/imx8mm-kontron-osm-s.dtsi b/arch/arm64/boot/dts/freescale/imx8mm-kontron-osm-s.dtsi
index 131f98cf5a04..5188b5b718a0 100644
--- a/arch/arm64/boot/dts/freescale/imx8mm-kontron-osm-s.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8mm-kontron-osm-s.dtsi
@@ -4,6 +4,7 @@
  */
 
 #include <dt-bindings/interrupt-controller/irq.h>
+#include <dt-bindings/rtc/rtc.h>
 #include "imx8mm.dtsi"
 
 / {
@@ -206,6 +207,7 @@ rtc@52 {
 		pinctrl-names = "default";
 		pinctrl-0 = <&pinctrl_rtc>;
 		interrupts-extended = <&gpio4 1 IRQ_TYPE_LEVEL_HIGH>;
+		backup-switch-mode = <RTC_BSM_LEVEL>;
 	};
 };
 
-- 
2.39.1

