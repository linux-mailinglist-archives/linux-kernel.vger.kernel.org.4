Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AAE0A624735
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Nov 2022 17:39:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231998AbiKJQjY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Nov 2022 11:39:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231956AbiKJQjL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Nov 2022 11:39:11 -0500
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1517740933;
        Thu, 10 Nov 2022 08:39:08 -0800 (PST)
Received: by mail-wm1-x330.google.com with SMTP id 187-20020a1c02c4000000b003cf9c3f3b80so3868808wmc.0;
        Thu, 10 Nov 2022 08:39:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CEuLsZijDHIURQmlzbVFcv2ePl7fzXP5XewpwaGNPfE=;
        b=q8Ednjpo9n4TB285iTt/y7Cr9qrUvZrfph6i5UnrSFU1JBMkI8ZZ62kTmvTdzGCA5o
         KUnQLtCliqx1pKKF/IFta57PlH5bqgf7Ci41DxCYvxDbQIsAe48epCExiISbbCpPhYtN
         nTMaYpeDKaXFrKT+kcaU4iGUh1u8XZ6lfyRB7T32aN/cNvQ2307zKg84gZ6EmzXBop9X
         9JuD0VxRA+TrU2/3/9LrU4Fj5+77VoYPUfKqSEXRuE9kM/nJOR3JyIK/apsir0rVrEJ0
         Nia7yc1wdO0G7Hc2rV9Y7kOooFVjKYxtCEwnRp4ImCPkbZSf0/9OKE/QFkRWM1Eez4qS
         qTnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CEuLsZijDHIURQmlzbVFcv2ePl7fzXP5XewpwaGNPfE=;
        b=m9K8Th7KEQfGDM0xbDCrBsAeVEOc7tJuJGjWBy/6bxxTvewvXt+tonY8Xey/+Q022H
         FtU8W4zhlkY3h1PGhRtD+X9/nGhVTFqau2heLsxU/bQes9Ku+b6LPOzn889DCbD8CaJe
         AwFA/9BWwcQg7GO59mC+aP8KiLKQhmoZKhz3pLe0h+a4nk5HI1oZCITgKaYF23BQefR3
         pBrCJZz2zs2s3w6YbWf/fBkE0lGS2DJ25VSlPsSfugYf3lvqLFySYGPLGimRETVPud4B
         JHBqaFyvnHBy/iO8bUqzEaG4GlG+n6n35Zk1CwDtnz41dSwNzf2fX00Bfpa9ncSPtE4v
         sohg==
X-Gm-Message-State: ACrzQf07hxdrPGRISbYACiMYny/pS1tWpe6HN5/PSaVkL/jp8aJQ0X1O
        /RDgyCMOJxaRKNABuvYHK3M=
X-Google-Smtp-Source: AMsMyM4vbGUsEHG0NKAE1xRIufXiEPYkN4XR+5oplPtvpQud17nl4IG9F6CmaQ8t+Feh+F01nsHssw==
X-Received: by 2002:a05:600c:21c9:b0:3cf:7833:2940 with SMTP id x9-20020a05600c21c900b003cf78332940mr36973681wmj.35.1668098346718;
        Thu, 10 Nov 2022 08:39:06 -0800 (PST)
Received: from localhost.localdomain (84-72-105-84.dclient.hispeed.ch. [84.72.105.84])
        by smtp.gmail.com with ESMTPSA id f24-20020a1cc918000000b003b4935f04a4sm128730wmb.5.2022.11.10.08.39.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Nov 2022 08:39:06 -0800 (PST)
From:   Nicolas Frattaroli <frattaroli.nicolas@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Heiko Stuebner <heiko@sntech.de>
Cc:     Nicolas Frattaroli <frattaroli.nicolas@gmail.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 4/4] arm64: dts: rockchip: Enable PCIe 2 on SOQuartz CM4IO
Date:   Thu, 10 Nov 2022 17:38:45 +0100
Message-Id: <20221110163845.42309-5-frattaroli.nicolas@gmail.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221110163845.42309-1-frattaroli.nicolas@gmail.com>
References: <20221110163845.42309-1-frattaroli.nicolas@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch enables the PCIe2 on the CM4IO board when paired with
a SOQuartz CM4 System-on-Module board. combphy2 also needs to be
enabled in this case to make the PHY work for this.

Signed-off-by: Nicolas Frattaroli <frattaroli.nicolas@gmail.com>
---
 arch/arm64/boot/dts/rockchip/rk3566-soquartz-cm4.dts | 10 ++++++++++
 arch/arm64/boot/dts/rockchip/rk3566-soquartz.dtsi    | 12 ++++++++++++
 2 files changed, 22 insertions(+)

diff --git a/arch/arm64/boot/dts/rockchip/rk3566-soquartz-cm4.dts b/arch/arm64/boot/dts/rockchip/rk3566-soquartz-cm4.dts
index e00568a6be5c..4cf60be267ed 100644
--- a/arch/arm64/boot/dts/rockchip/rk3566-soquartz-cm4.dts
+++ b/arch/arm64/boot/dts/rockchip/rk3566-soquartz-cm4.dts
@@ -30,6 +30,11 @@ vcc_5v: vcc-5v-regulator {
 	};
 };
 
+/* phy for pcie */
+&combphy2 {
+	status = "okay";
+};
+
 &gmac1 {
 	status = "okay";
 };
@@ -105,6 +110,11 @@ &led_work {
 	status = "okay";
 };
 
+&pcie2x1 {
+	vpcie3v3-supply = <&vcc_3v3>;
+	status = "okay";
+};
+
 &rgmii_phy1 {
 	status = "okay";
 };
diff --git a/arch/arm64/boot/dts/rockchip/rk3566-soquartz.dtsi b/arch/arm64/boot/dts/rockchip/rk3566-soquartz.dtsi
index 1b975822effa..294354e95336 100644
--- a/arch/arm64/boot/dts/rockchip/rk3566-soquartz.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk3566-soquartz.dtsi
@@ -487,6 +487,12 @@ rgmii_phy1: ethernet-phy@0 {
 	};
 };
 
+&pcie2x1 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pcie_reset_h>;
+	reset-gpios = <&gpio1 RK_PB2 GPIO_ACTIVE_HIGH>;
+};
+
 &pinctrl {
 	bt {
 		bt_enable_h: bt-enable-h {
@@ -512,6 +518,12 @@ diy_led_enable_h: diy-led-enable-h {
 		};
 	};
 
+	pcie {
+		pcie_reset_h: pcie-reset-h {
+			rockchip,pins = <1 RK_PB2 RK_FUNC_GPIO &pcfg_pull_none>;
+		};
+	};
+
 	pmic {
 		pmic_int_l: pmic-int-l {
 			rockchip,pins = <0 RK_PA3 RK_FUNC_GPIO &pcfg_pull_up>;
-- 
2.38.1

