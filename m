Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 220AA6AE11B
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Mar 2023 14:48:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231267AbjCGNsM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Mar 2023 08:48:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229973AbjCGNrZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Mar 2023 08:47:25 -0500
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97F2C3A879
        for <linux-kernel@vger.kernel.org>; Tue,  7 Mar 2023 05:46:42 -0800 (PST)
Received: by mail-wm1-x32d.google.com with SMTP id fm20-20020a05600c0c1400b003ead37e6588so10425981wmb.5
        for <linux-kernel@vger.kernel.org>; Tue, 07 Mar 2023 05:46:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112; t=1678196801;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HL0iDIXLsQAcI9AkmnTSM5zr0OsSGj+qBQeOWTRy/+8=;
        b=qMMcV4xeNepot/rQWT0Too3dn1ySQorZarygkDn55w8Zy4ynNWxVgr0YXoYR3e1Jhq
         3h35eC6acHD7KiiMVwH3/rLR8VZuhxknKCeqRo0jKqbRjbOyVWZCWcVk3EZLbZGcR97o
         yV6Px6PHHc9KS/8QshBoe+S1DOhlQGuScdsXhtRxA1nls3BalEBE/ipRoCIdtfj4OdVe
         0SgRl8R6lBYr+60OF4WBCzI76yPQI4zwamXiy8Go9wMSMFBZrwtGvSo4biO3oVOqj3BR
         FxA1gEKzDyXq6tOiXp+/e1RVpnJ0mXdLeSpsA3oRRPhukMLJaCo0UZDVQtYqJPeZPt0W
         fIjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678196801;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HL0iDIXLsQAcI9AkmnTSM5zr0OsSGj+qBQeOWTRy/+8=;
        b=dUdrZK/+kh2k06Jy33rndHO9/KqRthuJeBxIULjiiCSH7Qe8LSSUlmgMLKSsjKiNRu
         zV0iL7oD96AJkBR4D4RlqWa0MCdLlHwE7vnl1L26otf6NqbLtFLUkOtYj38fP+oBOLMC
         sdko1i4wKjjqFfUMcDvkDSB11lxsIb5hU0eiSBd4LjsjP4uMxT+YtwKAhU0xppA8ZGon
         EJZ+pF6pwESUY6yB74euPYi0QczUuc8PZ9McFGnrqBmaSb3wyi6dMSPZwcNzKQZn88OC
         H4NbmU58MNQstDXm/PDJR/kGJEQyxQP0Tf2SUyquLQTQxKY7O+nvPV6K3EC/nrpVDjA+
         5IAg==
X-Gm-Message-State: AO0yUKVj7y2bchyT18crHSAiScn37nA2uIG7vgNHGi6aYE36KPtRgZ5D
        wnoSal6pD6igwomY1w8gujWckzq0FjbFZAGqZq0=
X-Google-Smtp-Source: AK7set8zDOX8b86nHRX4AgYzVr2J1YveECRdXXtVhEz4fn4MnJ3gPNYNuaIHo5+fS59Q6xPr6yGklA==
X-Received: by 2002:a05:600c:3555:b0:3eb:2b88:8682 with SMTP id i21-20020a05600c355500b003eb2b888682mr12861938wmq.17.1678196800908;
        Tue, 07 Mar 2023 05:46:40 -0800 (PST)
Received: from [127.0.1.1] (laubervilliers-658-1-213-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.googlemail.com with ESMTPSA id o13-20020a5d670d000000b002c8476dde7asm12657607wru.114.2023.03.07.05.46.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Mar 2023 05:46:40 -0800 (PST)
From:   Alexandre Mergnat <amergnat@baylibre.com>
Date:   Tue, 07 Mar 2023 14:46:30 +0100
Subject: [PATCH 5/6] arm64: dts: mediatek: add larb support for mt8365 SoC
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20230207-iommu-support-v1-5-4f0c81fd52c1@baylibre.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2839; i=amergnat@baylibre.com;
 h=from:subject:message-id; bh=qbp237msdU+trOSTXH/QRPFc21+mI2NO5dacDzMLh3Q=;
 b=owEBbQKS/ZANAwAKAStGSZ1+MdRFAcsmYgBkB0A7RY2Eu1Vsstyo9EZBmvxVNAXGU4eCVVO9NKUb
 RbKMUBmJAjMEAAEKAB0WIQQjG17X8+qqcA5g/osrRkmdfjHURQUCZAdAOwAKCRArRkmdfjHURTIMD/
 0SlBZKOawWa2ITMV79h4OvYMNbPD2N5loSX22BXgssDKlMTqTpROMXcdDRngpwRY3Z/BkTDJ0aMU4h
 4Fik0UmDuN/OS38NvWMCr9DVH/OlE//+e2RHSMapKekzs4rCi3c5PjiydkhyppvI530biL2GSWzjy6
 T3UysY1XzjvDcIuypOiLCdJhiZvHl09zPRVFbptVvi3ie3h+A8AQCwFU7Fqs8pidJXJWTQSCmfn6a/
 PL5cn752yH8SOJKVlxcA6vdJWQj/ojLc0kPTxF5I/XNHzmGCvYDuVw2mkVzplRyoRVPPG/Hg8m/wGE
 AnPByhCY0s+QIQmt+YFE+WFHJ1xetsyD+QbbY8bAH885FM751JzxVJeY7OBhRt9C2FBXWxEJfQyeqT
 ruhyTxoA6H8ohWjuromFLCsGlkDeCI3RTTj2ArCUeQRr4xXQEuaLVos6iYV4pvpp+mne7gcIQaPnyT
 RiWe7c7Ua0rFd3L3QUv83pr1tDVg3ODGkCAIBtj5cWWe082em64KpWCQyrVWKgw9W/bKxTOx7kILop
 9wjPTNEkyK5LGNMaAdwkos9PZ2jQqOH0HCBC6IJd70ahzjGDEEtvgojy6tt0DmEZTTDQOi63tTPrye
 h9ZNNgml3mXf+TOTif62ZSfVFjBsJIQbPkLueDNbRDAUj1tQJwswrblJEnng==
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

Local arbiter (LARB) is a component of Smart Multimedia Interface (SMI),
used to help the memory management (IOMMU).
This patch add 4 LARBs and 2 clocks for the larb1 and larb3 support.

Signed-off-by: Alexandre Mergnat <amergnat@baylibre.com>
---
 arch/arm64/boot/dts/mediatek/mt8365.dtsi | 59 ++++++++++++++++++++++++++++++++
 1 file changed, 59 insertions(+)

diff --git a/arch/arm64/boot/dts/mediatek/mt8365.dtsi b/arch/arm64/boot/dts/mediatek/mt8365.dtsi
index 61333800ff4a..db0b897f58bb 100644
--- a/arch/arm64/boot/dts/mediatek/mt8365.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt8365.dtsi
@@ -725,12 +725,71 @@ smi_common: smi@14002000 {
 			power-domains = <&spm MT8365_POWER_DOMAIN_MM>;
 		};
 
+		larb0: larb@14003000 {
+			compatible = "mediatek,mt8365-smi-larb",
+				     "mediatek,mt8186-smi-larb";
+			reg = <0 0x14003000 0 0x1000>;
+			mediatek,smi = <&smi_common>;
+			clocks = <&mmsys CLK_MM_MM_SMI_LARB0>,
+				 <&mmsys CLK_MM_MM_SMI_LARB0>;
+			clock-names = "apb", "smi";
+			power-domains = <&spm MT8365_POWER_DOMAIN_MM>;
+			mediatek,larb-id = <0>;
+		};
+
 		camsys: syscon@15000000 {
 			compatible = "mediatek,mt8365-imgsys", "syscon";
 			reg = <0 0x15000000 0 0x1000>;
 			#clock-cells = <1>;
 		};
 
+		larb2: larb@15001000 {
+			compatible = "mediatek,mt8365-smi-larb",
+				     "mediatek,mt8186-smi-larb";
+			reg = <0 0x15001000 0 0x1000>;
+			mediatek,smi = <&smi_common>;
+			clocks = <&mmsys CLK_MM_MM_SMI_IMG>,
+				 <&camsys CLK_CAM_LARB2>;
+			clock-names = "apb", "smi";
+			power-domains = <&spm MT8365_POWER_DOMAIN_CAM>;
+			mediatek,larb-id = <2>;
+		};
+
+		vdecsys: syscon@16000000 {
+			compatible = "mediatek,mt8365-vdecsys", "syscon";
+			reg = <0 0x16000000 0 0x1000>;
+			#clock-cells = <1>;
+		};
+
+		larb3: larb@16010000 {
+			compatible = "mediatek,mt8365-smi-larb",
+				     "mediatek,mt8186-smi-larb";
+			reg = <0 0x16010000 0 0x1000>;
+			mediatek,smi = <&smi_common>;
+			clocks = <&vdecsys CLK_VDEC_LARB1>,
+				 <&vdecsys CLK_VDEC_LARB1>;
+			clock-names = "apb", "smi";
+			power-domains = <&spm MT8365_POWER_DOMAIN_VDEC>;
+			mediatek,larb-id = <3>;
+		};
+
+		vencsys: syscon@17000000 {
+			compatible = "mediatek,mt8365-vencsys", "syscon";
+			reg = <0 0x17000000 0 0x1000>;
+			#clock-cells = <1>;
+		};
+
+		larb1: larb@17010000 {
+			compatible = "mediatek,mt8365-smi-larb",
+				     "mediatek,mt8186-smi-larb";
+			reg = <0 0x17010000 0 0x1000>;
+			mediatek,smi = <&smi_common>;
+			clocks = <&vencsys CLK_VENC>, <&vencsys CLK_VENC>;
+			clock-names = "apb", "smi";
+			power-domains = <&spm MT8365_POWER_DOMAIN_VENC>;
+			mediatek,larb-id = <1>;
+		};
+
 		apu: syscon@19020000 {
 			compatible = "mediatek,mt8365-apu", "syscon";
 			reg = <0 0x19020000 0 0x1000>;

-- 
b4 0.10.1
