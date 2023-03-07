Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 260ED6AE11A
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Mar 2023 14:48:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229981AbjCGNsJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Mar 2023 08:48:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229780AbjCGNrY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Mar 2023 08:47:24 -0500
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0012F8ABF1
        for <linux-kernel@vger.kernel.org>; Tue,  7 Mar 2023 05:46:41 -0800 (PST)
Received: by mail-wr1-x434.google.com with SMTP id bw19so12144318wrb.13
        for <linux-kernel@vger.kernel.org>; Tue, 07 Mar 2023 05:46:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112; t=1678196800;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fiD1jGNfmWPjdfgXlaXHwcnvI1OsqFwof1Wcy6nVM2I=;
        b=sF/Usli7kkaMJg9fqNQR2RN3tExZk4+8j2vwRRHt99Ct3EPd9Cbi12QgJcdkDQqsMV
         BENMPAuud2wUkK24443HBtEjc48OkthydjGXsUcJJ4v5Oa2B0IXAxgSoJizz5RczacbZ
         XPCNML3KhL4ODv+VYt0NeGiiuvO41WR1STG3+sRTvNTtTfZ+hR1kNyiPJMroSBQVwsZJ
         g6tsoPkvecMJDvMCj1pvgsbOSz2xXtSvAxWcM0dwDhePufD3XhFWB/KSsRn/1bbvhLAQ
         S5Lj2X9mDdve0K9a0O7L0s8peJU4s2cSaFrYS2H2DqXkA8oNwXXBeZjSU+nikLb0abtl
         TvpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678196800;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fiD1jGNfmWPjdfgXlaXHwcnvI1OsqFwof1Wcy6nVM2I=;
        b=CAji6WTMIVsu4oMKF97ciue25mhmWKsSGmNZpdA3hr0jtaxvMhQhFpQTR3/ySyRfsy
         ep9GzNWBGes4j2R+3qmpIrHSbar8RAN9m/S2CkDXD7m5E8Mt/FfbcCFGAphHxmmiYx+y
         Mhok8qovfsFVC0dHhhzI0zR2rhI8klssJfGadtv6xBHnk0mCSHemtZ3t661A9514mbYY
         7FFOLHnNsDAV9R+QgEysyu7NRaKqf+8Y2qa5/NmlEbbCD4VDjjtifOPj/s8CjM2Ojt82
         iRziEpc+oqOgtORWfL3ls+sy11ceot2zW5g614+2Xter9rexdLm2R2LIovYF2P4w6fV2
         w//A==
X-Gm-Message-State: AO0yUKVK16CMbxeeIGkKeZHn1deSA5yH+prR3v4//7xEyw7fi6ytUyXA
        doTH9lozqoEGn+OIeuY0C4WBd6EivPiXg8TFTWI=
X-Google-Smtp-Source: AK7set+4LLeARHWHlJ21fLaACA85Yg6NVqJ++jzgrq+VvBOyk7RHx/KY6buV77yrNV3twwbOh2HC/g==
X-Received: by 2002:adf:f448:0:b0:2ca:e8c2:6d29 with SMTP id f8-20020adff448000000b002cae8c26d29mr9228862wrp.7.1678196800148;
        Tue, 07 Mar 2023 05:46:40 -0800 (PST)
Received: from [127.0.1.1] (laubervilliers-658-1-213-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.googlemail.com with ESMTPSA id o13-20020a5d670d000000b002c8476dde7asm12657607wru.114.2023.03.07.05.46.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Mar 2023 05:46:39 -0800 (PST)
From:   Alexandre Mergnat <amergnat@baylibre.com>
Date:   Tue, 07 Mar 2023 14:46:29 +0100
Subject: [PATCH 4/6] arm64: dts: mediatek: add smi support for mt8365 SoC
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20230207-iommu-support-v1-4-4f0c81fd52c1@baylibre.com>
References: <20230207-iommu-support-v1-0-4f0c81fd52c1@baylibre.com>
In-Reply-To: <20230207-iommu-support-v1-0-4f0c81fd52c1@baylibre.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Yong Wu <yong.wu@mediatek.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Cc:     linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org,
        Alexandre Mergnat <amergnat@baylibre.com>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org
X-Mailer: b4 0.10.1
X-Developer-Signature: v=1; a=openpgp-sha256; l=2234; i=amergnat@baylibre.com;
 h=from:subject:message-id; bh=8Utuzf8vnkkr4HLSj6tVwRat45+MSGUxWim3O+x8mr0=;
 b=owEBbQKS/ZANAwAKAStGSZ1+MdRFAcsmYgBkB0A7ZT3peawJygVrc7zIOmQK2eu2/NkUJKAXx44O
 NcT7aE2JAjMEAAEKAB0WIQQjG17X8+qqcA5g/osrRkmdfjHURQUCZAdAOwAKCRArRkmdfjHUReLVD/
 4lojGGLFnZrYGkcB0rp+6wSSgVkNlIDEaTmRBtCB08m417n1STAtRI3sET3VknYAqzm2C+8BVxWTd+
 o6eWt09OTxUMAT/mxZ+29GbNkzqOZKv8EVjbAnFnCWln2+nodvXZDsE1VOUnj/ll0OqNtK2D8wB0TU
 Z6DSNZy3VvraHoly8gz96u+CW0ZP3ImikyFWWJB9kB5kkGZ1xORMMKeMsC0tQgj2Itu0gbmk6QO+n9
 enmIm55j4rdDWIkrRNrjmdrtClXq0W9BoTvPLkeX7anmciBdhBpzG91V20N0fpwIkwEESGZn/apQ0V
 tnyVVVDXlaFfV87ynZlS5Zvv+0v8f0VwsN1w79IS5zrYvPD0WAg+l8miSCDfrnfOrTCG5FzzhctCjh
 kC44gf5kRimqk/TK078eJUVjuJAADC94j6A8/ZgzZpXu8NPpWrik6ERWcKaYwPRCRJXEYdITIuKmqB
 QBS6Nhlt6K+yBEluIqcwJC73Q3un6DfY9FgyQG6VRTTkMUi8wY+m6Ahx4INcEq/5YmJzGBjD3xi/xi
 A5N93wRyiCGoe9VKJKRrg/qyYi7MELFU/M4N3aprDR8hzqGEZguetV9IasqmOEjGkvYE2j8pgTBVfC
 y7EINJuyoh4sKZKMXU9SisziJTeRpDxAZSqIoL8jTy956zaGRaZBh+NdhJCg==
X-Developer-Key: i=amergnat@baylibre.com; a=openpgp;
 fpr=231B5ED7F3EAAA700E60FE8B2B46499D7E31D445
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Smart Multimedia Interface (SMI) local arbiter does the arbitration for
memory requests from multi-media engines. Add SMI in the MT8365 DTS will allow
to add local ARBiter (LARB), use by IOMMU.

Signed-off-by: Alexandre Mergnat <amergnat@baylibre.com>
---
 arch/arm64/boot/dts/mediatek/mt8365.dtsi | 17 ++++++++++++++++-
 1 file changed, 16 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/mediatek/mt8365.dtsi b/arch/arm64/boot/dts/mediatek/mt8365.dtsi
index 67b375fe2020..61333800ff4a 100644
--- a/arch/arm64/boot/dts/mediatek/mt8365.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt8365.dtsi
@@ -324,16 +324,19 @@ power-domain@MT8365_POWER_DOMAIN_CAM {
 							      "cam-4", "cam-5";
 						#power-domain-cells = <0>;
 						mediatek,infracfg = <&infracfg>;
+						mediatek,smi = <&smi_common>;
 					};
 
 					power-domain@MT8365_POWER_DOMAIN_VDEC {
 						reg = <MT8365_POWER_DOMAIN_VDEC>;
 						#power-domain-cells = <0>;
+						mediatek,smi = <&smi_common>;
 					};
 
 					power-domain@MT8365_POWER_DOMAIN_VENC {
 						reg = <MT8365_POWER_DOMAIN_VENC>;
 						#power-domain-cells = <0>;
+						mediatek,smi = <&smi_common>;
 					};
 
 					power-domain@MT8365_POWER_DOMAIN_APU {
@@ -351,6 +354,7 @@ power-domain@MT8365_POWER_DOMAIN_APU {
 							      "apu-5";
 						#power-domain-cells = <0>;
 						mediatek,infracfg = <&infracfg>;
+						mediatek,smi = <&smi_common>;
 					};
 				};
 
@@ -709,6 +713,18 @@ mmsys: syscon@14000000 {
 			#clock-cells = <1>;
 		};
 
+		smi_common: smi@14002000 {
+			compatible = "mediatek,mt8365-smi-common",
+				     "mediatek,mt8186-smi-common";
+			reg = <0 0x14002000 0 0x1000>;
+			clocks = <&mmsys CLK_MM_MM_SMI_COMMON>,
+				 <&mmsys CLK_MM_MM_SMI_COMMON>,
+				 <&mmsys CLK_MM_MM_SMI_COMM0>,
+				 <&mmsys CLK_MM_MM_SMI_COMM1>;
+			clock-names = "apb", "smi", "gals0", "gals1";
+			power-domains = <&spm MT8365_POWER_DOMAIN_MM>;
+		};
+
 		camsys: syscon@15000000 {
 			compatible = "mediatek,mt8365-imgsys", "syscon";
 			reg = <0 0x15000000 0 0x1000>;
@@ -720,7 +736,6 @@ apu: syscon@19020000 {
 			reg = <0 0x19020000 0 0x1000>;
 			#clock-cells = <1>;
 		};
-
 	};
 
 	timer {

-- 
b4 0.10.1
