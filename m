Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D0A267593B
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Jan 2023 16:54:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230037AbjATPyk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Jan 2023 10:54:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231633AbjATPye (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jan 2023 10:54:34 -0500
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23502DF960
        for <linux-kernel@vger.kernel.org>; Fri, 20 Jan 2023 07:54:22 -0800 (PST)
Received: by mail-wm1-x334.google.com with SMTP id bg13-20020a05600c3c8d00b003d9712b29d2so6154211wmb.2
        for <linux-kernel@vger.kernel.org>; Fri, 20 Jan 2023 07:54:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FmvkahJnJPGZHnYSzbVDVni5JGwF4pYBp1CYe5p5z9g=;
        b=JSREVOLUC18RqwaXMd7Zkdfwk2edeiKs39U+FngduPFHHcw7Ylmr3bbDFlMMkrBxbH
         RyTeMmhifDDjDjZN68KnhDMf8Je469Kbjprn3fsvjHvJeI7lWBwfqoevCgL9vfdLrdKS
         5w7xOdWn0G4OSgXSSG5cjIakHa+RlvJdiqT7Pzq+VT128Fuk+ay0R1jyG/wy35WifCDo
         EahNQ5KaDKzx3ADBmcAwa2rRxbPU35Yw2mHIE2/3F5lgGfyB2TPOB0u0M1hNjbl5a/Rx
         zMPChhMLJa5ovxv+hhPejoIhjuOrp7ix1OMgGYdxdfvMgYRrULkN2DtVmdCcFqAeo4As
         tkJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FmvkahJnJPGZHnYSzbVDVni5JGwF4pYBp1CYe5p5z9g=;
        b=orZBKUszuAQt4MvYHIKmFQ2W8sIwbSIkywAcGEQ/lCyxawGqHnCfUPwL2IBCF5KTEb
         yhH9t+GwgOg+dGKkiNGg2fB7P9frypfe8LXO3GNdtOJKZSH9aB+Q1uwlYD8DFEz6/6qq
         4991ufJr+7RxWpE+dlGqPc3jpnCGdg3TBg64DDV35POipcU+J4zNI2KeVX3+8RlVgJVe
         oqbWykjQ//qZh9vJKldE33AfV7J4d5MIAHaNmZupJPG7iB5ClH8AcaBt6gp1ZqM6Tycb
         Qy2bW1sbdWZ73dW4jsQ6elzsJTp3n6ptgNaCsMDqIw51hnG27wS0YV6zHa77yCcITdb5
         jr4w==
X-Gm-Message-State: AFqh2kotrjsQV4xw4VqJNesfFpApNxj0omP6DCJy75+2BmzbtRzSPcc4
        fbndEUc580fsm0lFSD2pCtJDaw==
X-Google-Smtp-Source: AMrXdXtT+/pjtAzumRFn7MR9+GO3xfqIabangPY5gfiLmeuvvw3RNhnTSCieqQLklmOSM63c7oiBqg==
X-Received: by 2002:a05:600c:1e21:b0:3d0:7fee:8a70 with SMTP id ay33-20020a05600c1e2100b003d07fee8a70mr14995666wmb.19.1674230061636;
        Fri, 20 Jan 2023 07:54:21 -0800 (PST)
Received: from krzk-bin.. ([178.197.216.144])
        by smtp.gmail.com with ESMTPSA id n42-20020a05600c3baa00b003d96efd09b7sm3349596wms.19.2023.01.20.07.54.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Jan 2023 07:54:21 -0800 (PST)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Inki Dae <inki.dae@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Kukjin Kim <kgene@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     replicant@osuosl.org, phone-devel@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht,
        =?UTF-8?q?Martin=20J=C3=BCcker?= <martin.juecker@gmail.com>,
        Henrik Grimler <henrik@grimler.se>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH 06/11] ARM: dts: exynos: add panel supply in Tiny4412
Date:   Fri, 20 Jan 2023 16:53:59 +0100
Message-Id: <20230120155404.323386-7-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230120155404.323386-1-krzysztof.kozlowski@linaro.org>
References: <20230120155404.323386-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The simple panel should have a supply.  Provide a stub, as the board DTS
does not have a PMIC node, to silence warning:

  exynos4412-tiny4412.dtb: panel: 'power-supply' is a required property

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 arch/arm/boot/dts/exynos4412-tiny4412.dts | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/arm/boot/dts/exynos4412-tiny4412.dts b/arch/arm/boot/dts/exynos4412-tiny4412.dts
index 04388c575efe..e0b6162d2e2a 100644
--- a/arch/arm/boot/dts/exynos4412-tiny4412.dts
+++ b/arch/arm/boot/dts/exynos4412-tiny4412.dts
@@ -79,6 +79,7 @@ pmic_ap_clk: pmic-ap-clk {
 
 	panel {
 		compatible = "innolux,at070tn92";
+		power-supply = <&vddq_lcd>;
 
 		port {
 			panel_input: endpoint {
@@ -86,6 +87,13 @@ panel_input: endpoint {
 			};
 		};
 	};
+
+	vddq_lcd: regulator-vddq-lcd {
+		compatible = "regulator-fixed";
+		regulator-name = "vddq-lcd";
+		regulator-min-microvolt = <1800000>;
+		regulator-max-microvolt = <1800000>;
+	};
 };
 
 &cpu_thermal {
-- 
2.34.1

