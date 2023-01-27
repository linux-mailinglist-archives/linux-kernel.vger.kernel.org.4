Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4CFE067F03F
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Jan 2023 22:16:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230200AbjA0VQL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Jan 2023 16:16:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230516AbjA0VQE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jan 2023 16:16:04 -0500
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2EFD8A556
        for <linux-kernel@vger.kernel.org>; Fri, 27 Jan 2023 13:15:38 -0800 (PST)
Received: by mail-wm1-x329.google.com with SMTP id e19-20020a05600c439300b003db1cac0c1fso6215745wmn.5
        for <linux-kernel@vger.kernel.org>; Fri, 27 Jan 2023 13:15:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FziN2ciblGO11V/qPlwYKnDFHaO/t/ie6w/sKp8lvIY=;
        b=W5PFTaeeYxWlgV02+EJnISFZeW+ldcp0gYNhmnDPX2C62Y3OX8smGdWwSPmsW+2l2d
         mLf1KR7nZHQzpsOGEed9/gc8S5XUoG/AUPOtnCc1fZvgJoBZIwj9o0LKoqQF7H9LGSPW
         qNY99e6rxtwU8yTvAdP2Ldr7eGJLNADbktzxD1RdJFp1yTDdxOoUe6hWRS6zM4DSpuyK
         mAlV0eFj2oyE8u7LZj29skEKufjFmTsIDJPAqlAGEciNSHMr2QZkYgnwAKdPghHXoV/Y
         Ra1/QJdvT5+rJuJhm/Va0mon5g+f9D/hq3r6YK2xSqNZFwvaH1bEizISROsQtFDnupcT
         m5aQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FziN2ciblGO11V/qPlwYKnDFHaO/t/ie6w/sKp8lvIY=;
        b=WHStt2J0cXv93XDDClKY8oZAbx392ZJ+rLdIkqTdPPPaCvuxZHI5DaYaDEVhcas/3C
         CTwVhb/gDbe4vO+2bXw904P/QIxDynRIXoRP2CMRAte9gjQ84nGNOv5jhAasd+bpz2Pp
         6XyeIHX2ZvLGC9yOeBF731dCL1sVroA+ZHVqfL5lDH5rb2ckPIssHSZ2BRbQxEk1ipuN
         fRkxlVaxpvXQQE7WPUKOZG97qu322ome5jWxC9Ell+Upqiww9VZPVtOiTcTpmH02hqvL
         k3NemfIPuUZSfuTBY6hDI5hN05O65rHgOlRigGm2+yWDP1Mcs+1/zCt9p92C/fvwNlEH
         TJTw==
X-Gm-Message-State: AFqh2kpdRFUjw0P7YnLu6ahCbdO4tk+/cK7O9L9pzTf8AY2cm1EFG8qS
        bI7/urv6SKsNUpx3/k9/oMvRAQ==
X-Google-Smtp-Source: AMrXdXvwdcLmIe+WwjquWvEUJNbsvUuzB/zvrJRj+AJSmWF/hrIA7ICjeti3LZYuNZR9FVJ7MJ1x8A==
X-Received: by 2002:a05:600c:539a:b0:3d9:ef72:190d with SMTP id hg26-20020a05600c539a00b003d9ef72190dmr39668733wmb.19.1674854137376;
        Fri, 27 Jan 2023 13:15:37 -0800 (PST)
Received: from krzk-bin.. ([178.197.216.144])
        by smtp.gmail.com with ESMTPSA id l16-20020a7bc350000000b003d9aa76dc6asm10513504wmj.0.2023.01.27.13.15.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Jan 2023 13:15:37 -0800 (PST)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     replicant@osuosl.org, phone-devel@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht,
        =?UTF-8?q?Martin=20J=C3=BCcker?= <martin.juecker@gmail.com>,
        Henrik Grimler <henrik@grimler.se>,
        Sam Protsenko <semen.protsenko@linaro.org>,
        Chanho Park <chanho61.park@samsung.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [RFT PATCH v2 2/4] ARM: dts: exynos: add unit address to DWC3 node wrapper in Exynos54xx
Date:   Fri, 27 Jan 2023 22:15:25 +0100
Message-Id: <20230127211527.260060-2-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230127211527.260060-1-krzysztof.kozlowski@linaro.org>
References: <20230127211527.260060-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Neither simple-bus bindings nor dtc W=1 accept device nodes in soc@ node
which do not have unit address.  Therefore usethe address space
of child device (actual DWC3 Controller) as the wrapper's address to
fix:

  exynos5422-odroidhc1.dtb: soc: usb3-0: {'compatible': ['samsung,exynos5250-dwusb3'],
    ... } should not be valid under {'type': 'object'}

  exynos54xx.dtsi:145.21-159.5: Warning (simple_bus_reg): /soc/usb3-0: missing or empty reg/ranges property

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

---

Changes since v1:
1. Use ranges with values and drop reg from usb-wrapper node.
2. Keep "usb" as wrapper's node name.
---
 arch/arm/boot/dts/exynos54xx.dtsi | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/arch/arm/boot/dts/exynos54xx.dtsi b/arch/arm/boot/dts/exynos54xx.dtsi
index 3ec43761d8b9..5c799886c275 100644
--- a/arch/arm/boot/dts/exynos54xx.dtsi
+++ b/arch/arm/boot/dts/exynos54xx.dtsi
@@ -142,15 +142,15 @@ hsi2c_7: i2c@12cd0000 {
 			status = "disabled";
 		};
 
-		usbdrd3_0: usb3-0 {
+		usbdrd3_0: usb@12000000 {
 			compatible = "samsung,exynos5250-dwusb3";
 			#address-cells = <1>;
 			#size-cells = <1>;
-			ranges;
+			ranges = <0x0 0x12000000 0x10000>;
 
-			usbdrd_dwc3_0: usb@12000000 {
+			usbdrd_dwc3_0: usb@0 {
 				compatible = "snps,dwc3";
-				reg = <0x12000000 0x10000>;
+				reg = <0x0 0x10000>;
 				interrupts = <GIC_SPI 72 IRQ_TYPE_LEVEL_HIGH>;
 				phys = <&usbdrd_phy0 0>, <&usbdrd_phy0 1>;
 				phy-names = "usb2-phy", "usb3-phy";
@@ -164,15 +164,15 @@ usbdrd_phy0: phy@12100000 {
 			#phy-cells = <1>;
 		};
 
-		usbdrd3_1: usb3-1 {
+		usbdrd3_1: usb@12400000 {
 			compatible = "samsung,exynos5250-dwusb3";
 			#address-cells = <1>;
 			#size-cells = <1>;
-			ranges;
+			ranges = <0x0 0x12400000 0x10000>;
 
-			usbdrd_dwc3_1: usb@12400000 {
+			usbdrd_dwc3_1: usb@0 {
 				compatible = "snps,dwc3";
-				reg = <0x12400000 0x10000>;
+				reg = <0x0 0x10000>;
 				phys = <&usbdrd_phy1 0>, <&usbdrd_phy1 1>;
 				phy-names = "usb2-phy", "usb3-phy";
 				snps,dis_u3_susphy_quirk;
-- 
2.34.1

