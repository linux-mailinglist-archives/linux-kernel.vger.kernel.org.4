Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7EC2E677F60
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Jan 2023 16:17:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232389AbjAWPRJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Jan 2023 10:17:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232601AbjAWPQb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jan 2023 10:16:31 -0500
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0111E29E1A
        for <linux-kernel@vger.kernel.org>; Mon, 23 Jan 2023 07:16:01 -0800 (PST)
Received: by mail-wm1-x329.google.com with SMTP id f25-20020a1c6a19000000b003da221fbf48so8810207wmc.1
        for <linux-kernel@vger.kernel.org>; Mon, 23 Jan 2023 07:16:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=VGIqYd+6R6CDvlsfcJLpQUg9BBeJw42R7dgqJjjInqs=;
        b=RrqLJIhRqd6agHBXqRCqwziEcVsM7JvgDCGm5SbD2myoFSBWt8WVteU6Nn8WPZLabz
         XsXS5Hm1VAIehLgllMLLycYwHJkm6OON/t2YQZlgzjmiIV8/BtgV/bI+U0vRKeWXiKdh
         4JNEw4NEuczDFFkU6n6Uj0fn9wgxkwJqvdgFTdtQHwinMhTRm0VlfQYxqr5k/A7YTKGA
         V0OQ7c7qAfOnKQ8DFonrMC7yvT6Z7Gh4kGTdQgPlq19kWPCIOky7lnA0LZuSIKryqjQz
         BnV0Vj933pSX0aOmCrxNI7iJytXoORVXGqR6c6Ggmlrfq8+q7K8OEWa+BnHscR18fSfn
         a3FQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VGIqYd+6R6CDvlsfcJLpQUg9BBeJw42R7dgqJjjInqs=;
        b=11/8O/EVfkWnevLGVFtx9Sf9bF3aaseg7IabWBLbe5gcxRvwpHv71VYMvsY4GssXYY
         m3WxR+KN+tXkiOKVQUzkv7fnCjpcjAABo73Udi1IIJzcE1af5lhhrPaKWFjFGAKB1l+i
         bv1RDKuzy/Z583A23bpRcHlypTstgsYCsfs4WFIRN5rytE7Qg3ZVaVH7bHP7cXlZRAKU
         OfPS0CGxh55TIrgWgh+LWWqv6ZIZI3kmakvdkZP9TgrEtpbIQYsbLIH3mluZ50x+uarD
         lIRjHjBzX+578UyPFV2dTCu344Mtue/jZMJvFGsXBx9MiNhrS0Obt3YIOaoEgrYh2484
         L0eQ==
X-Gm-Message-State: AFqh2krVfEXJJkqFkWm0sfoY4yxQ6GhH8yODBAd8lu3OI8FAcSk/bzuz
        CwM5UWdlGlYgYZGQ1lAaWkeaIQ==
X-Google-Smtp-Source: AMrXdXtI9McLxV1AZvT/5qDVJRdIgobpyIaSHkPg+S3SsEEQvJS1jQ7YFcInQRmRuzgTn0c8i55MqA==
X-Received: by 2002:a05:600c:2292:b0:3d3:50b9:b1a1 with SMTP id 18-20020a05600c229200b003d350b9b1a1mr32419939wmf.1.1674486960513;
        Mon, 23 Jan 2023 07:16:00 -0800 (PST)
Received: from krzk-bin.. ([178.197.216.144])
        by smtp.gmail.com with ESMTPSA id h11-20020a05600c314b00b003db0f4e12c8sm11772532wmo.34.2023.01.23.07.15.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Jan 2023 07:16:00 -0800 (PST)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Stefan Agner <stefan@agner.ch>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH 1/2] ARM: dts: imx: use generic node name for rave-sp
Date:   Mon, 23 Jan 2023 16:15:54 +0100
Message-Id: <20230123151555.369881-1-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
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

Use generic "mcu" node name for rave-sp node, as recommended by
Devicetree specification.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 arch/arm/boot/dts/imx51-zii-rdu1.dts      | 2 +-
 arch/arm/boot/dts/imx51-zii-scu2-mezz.dts | 2 +-
 arch/arm/boot/dts/imx51-zii-scu3-esb.dts  | 2 +-
 arch/arm/boot/dts/imx6qdl-zii-rdu2.dtsi   | 2 +-
 arch/arm/boot/dts/imx7d-zii-rmu2.dts      | 2 +-
 arch/arm/boot/dts/imx7d-zii-rpu2.dts      | 2 +-
 arch/arm/boot/dts/vf610-zii-spb4.dts      | 2 +-
 arch/arm/boot/dts/vf610-zii-ssmb-spu3.dts | 2 +-
 8 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/arch/arm/boot/dts/imx51-zii-rdu1.dts b/arch/arm/boot/dts/imx51-zii-rdu1.dts
index 3140f038aa98..e537e06e11d7 100644
--- a/arch/arm/boot/dts/imx51-zii-rdu1.dts
+++ b/arch/arm/boot/dts/imx51-zii-rdu1.dts
@@ -556,7 +556,7 @@ &uart3 {
 	pinctrl-0 = <&pinctrl_uart3>;
 	status = "okay";
 
-	rave-sp {
+	mcu {
 		compatible = "zii,rave-sp-rdu1";
 		current-speed = <38400>;
 		#address-cells = <1>;
diff --git a/arch/arm/boot/dts/imx51-zii-scu2-mezz.dts b/arch/arm/boot/dts/imx51-zii-scu2-mezz.dts
index aa91e5dde4b8..21dd3f7abd48 100644
--- a/arch/arm/boot/dts/imx51-zii-scu2-mezz.dts
+++ b/arch/arm/boot/dts/imx51-zii-scu2-mezz.dts
@@ -311,7 +311,7 @@ &uart3 {
 	pinctrl-0 = <&pinctrl_uart3>;
 	status = "okay";
 
-	rave-sp {
+	mcu {
 		compatible = "zii,rave-sp-mezz";
 		current-speed = <57600>;
 		#address-cells = <1>;
diff --git a/arch/arm/boot/dts/imx51-zii-scu3-esb.dts b/arch/arm/boot/dts/imx51-zii-scu3-esb.dts
index 875b10a7d674..9f857eb44bf7 100644
--- a/arch/arm/boot/dts/imx51-zii-scu3-esb.dts
+++ b/arch/arm/boot/dts/imx51-zii-scu3-esb.dts
@@ -319,7 +319,7 @@ &uart3 {
 	pinctrl-0 = <&pinctrl_uart3>;
 	status = "okay";
 
-	rave-sp {
+	mcu {
 		compatible = "zii,rave-sp-esb";
 		current-speed = <57600>;
 		#address-cells = <1>;
diff --git a/arch/arm/boot/dts/imx6qdl-zii-rdu2.dtsi b/arch/arm/boot/dts/imx6qdl-zii-rdu2.dtsi
index 525ff62b47f5..5bb47c79a4da 100644
--- a/arch/arm/boot/dts/imx6qdl-zii-rdu2.dtsi
+++ b/arch/arm/boot/dts/imx6qdl-zii-rdu2.dtsi
@@ -277,7 +277,7 @@ &uart4 {
 	pinctrl-0 = <&pinctrl_uart4>;
 	status = "okay";
 
-	rave-sp {
+	mcu {
 		compatible = "zii,rave-sp-rdu2";
 		current-speed = <1000000>;
 		#address-cells = <1>;
diff --git a/arch/arm/boot/dts/imx7d-zii-rmu2.dts b/arch/arm/boot/dts/imx7d-zii-rmu2.dts
index 1c9f25848bf7..521493342fe9 100644
--- a/arch/arm/boot/dts/imx7d-zii-rmu2.dts
+++ b/arch/arm/boot/dts/imx7d-zii-rmu2.dts
@@ -204,7 +204,7 @@ &uart4 {
 	assigned-clock-parents = <&clks IMX7D_PLL_SYS_MAIN_240M_CLK>;
 	status = "okay";
 
-	rave-sp {
+	mcu {
 		compatible = "zii,rave-sp-rdu2";
 		current-speed = <1000000>;
 		#address-cells = <1>;
diff --git a/arch/arm/boot/dts/imx7d-zii-rpu2.dts b/arch/arm/boot/dts/imx7d-zii-rpu2.dts
index 9d29490ab4c9..decc19af3b83 100644
--- a/arch/arm/boot/dts/imx7d-zii-rpu2.dts
+++ b/arch/arm/boot/dts/imx7d-zii-rpu2.dts
@@ -607,7 +607,7 @@ &uart4 {
 	assigned-clock-parents = <&clks IMX7D_PLL_SYS_MAIN_240M_CLK>;
 	status = "okay";
 
-	rave-sp {
+	mcu {
 		compatible = "zii,rave-sp-rdu2";
 		current-speed = <1000000>;
 		#address-cells = <1>;
diff --git a/arch/arm/boot/dts/vf610-zii-spb4.dts b/arch/arm/boot/dts/vf610-zii-spb4.dts
index 6c6ec46fd015..180acb0795b9 100644
--- a/arch/arm/boot/dts/vf610-zii-spb4.dts
+++ b/arch/arm/boot/dts/vf610-zii-spb4.dts
@@ -241,7 +241,7 @@ &uart2 {
 	pinctrl-0 = <&pinctrl_uart2>;
 	status = "okay";
 
-	rave-sp {
+	mcu {
 		compatible = "zii,rave-sp-rdu2";
 		current-speed = <1000000>;
 		#address-cells = <1>;
diff --git a/arch/arm/boot/dts/vf610-zii-ssmb-spu3.dts b/arch/arm/boot/dts/vf610-zii-ssmb-spu3.dts
index fe600ab2e4bd..20beaa8433b6 100644
--- a/arch/arm/boot/dts/vf610-zii-ssmb-spu3.dts
+++ b/arch/arm/boot/dts/vf610-zii-ssmb-spu3.dts
@@ -254,7 +254,7 @@ &uart1 {
 	pinctrl-0 = <&pinctrl_uart1>;
 	status = "okay";
 
-	rave-sp {
+	mcu {
 		compatible = "zii,rave-sp-rdu2";
 		current-speed = <1000000>;
 		#address-cells = <1>;
-- 
2.34.1

