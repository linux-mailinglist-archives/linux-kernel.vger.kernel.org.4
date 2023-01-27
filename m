Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B19667E16B
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Jan 2023 11:19:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233501AbjA0KTD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Jan 2023 05:19:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233521AbjA0KSy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jan 2023 05:18:54 -0500
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5EE207E6FF
        for <linux-kernel@vger.kernel.org>; Fri, 27 Jan 2023 02:18:39 -0800 (PST)
Received: by mail-wm1-x32a.google.com with SMTP id c10-20020a05600c0a4a00b003db0636ff84so3097636wmq.0
        for <linux-kernel@vger.kernel.org>; Fri, 27 Jan 2023 02:18:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=g9aAd7DNS1wF4Jmg6JIGH3FDyRdPxMQHQVFNneT5OWI=;
        b=kn70lyCrzNebxrhqdbCHTwQzYQpOrRG9Utd0XXJYy5wlvl/7+MltdnFF/XBIF/r/08
         6G3HsQPodltHOYOawCtxn4DJ/790GQcOOLE3+iZNsS3IHl50h7N5wvWmhA2vgKqE09l6
         hG/7/4T6chdiqeBOdTDv/jyGjE7HDXWZwzo3fyVvcXvr1CNdAXY6E3WTeSkw0jiFNzT2
         ioivgE3O8QYrsQ+I/h3dI/NVUODWv+iC9FhEtxg+A7kuyGVXx4cvC1hC6h8xc6DyNxRI
         k9oq+bHIuVVprpc8WHSa2/ZFRysVZK+zNlsJapYFs0PiHFlp4Yrfxary6yTO7J4X6hNq
         cYoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=g9aAd7DNS1wF4Jmg6JIGH3FDyRdPxMQHQVFNneT5OWI=;
        b=btR+q/MisemHwcxCjsglRlmoyYlg5MnqerBLj3nMKjDjMSAZ0+2AHyzo3JwuDsNPsC
         WcFlhDWg+HzhUB/uxO5cOtDlc0QZ6IxLUN3KKtLn39zZussesaysv+lsKKocD33FazsL
         99DwvFqm7VcougJU1f6V1lWzEKHapNUMYTWu4VEEX0874VTGPYQ/3cPP5wCLF/+5FFRO
         YI9ctLVN8UvW5FbOYmcE9Kuzm1wytFQS+l8HbZG4wzFGmr2zRScysPij/mMvZ4EpPYKW
         hMlkSB/bRORbU+gngNZOv8f+kPw7NgmCWzl/VlI467/7Dx5PevrwjHdZIDefEew7MHLx
         +iEA==
X-Gm-Message-State: AFqh2kplVXx3ZFMUgKSVEve5m7GlLu0jMST4VD0W7QGhVn8et8dpDtwj
        ByfKEiXQLQmK9SGHUSfLvWKNtA==
X-Google-Smtp-Source: AMrXdXsLHHBpUT7iwq834hoPGO9BOsa8m/18qeVGudaggjt1B3Ub76aSH/A9G0rg71gX+uwEJzNe4Q==
X-Received: by 2002:a05:600c:1695:b0:3da:f651:8ccc with SMTP id k21-20020a05600c169500b003daf6518cccmr39902493wmn.4.1674814718586;
        Fri, 27 Jan 2023 02:18:38 -0800 (PST)
Received: from krzk-bin.. ([178.197.216.144])
        by smtp.gmail.com with ESMTPSA id c1-20020a05600c0a4100b003d9fba3c7a4sm7798284wmq.16.2023.01.27.02.18.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Jan 2023 02:18:38 -0800 (PST)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Bartosz Golaszewski <brgl@bgdev.pl>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Nishanth Menon <nm@ti.com>,
        Santosh Shilimkar <ssantosh@kernel.org>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH] ARM: dts: ti: use "okay" for status
Date:   Fri, 27 Jan 2023 11:18:36 +0100
Message-Id: <20230127101836.93845-1-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
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

"okay" over "ok" is preferred for status property.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 arch/arm/boot/dts/da850-evm.dts         | 2 +-
 arch/arm/boot/dts/keystone-k2e-evm.dts  | 2 +-
 arch/arm/boot/dts/keystone-k2g-evm.dts  | 2 +-
 arch/arm/boot/dts/keystone-k2hk-evm.dts | 2 +-
 arch/arm/boot/dts/keystone-k2l-evm.dts  | 2 +-
 5 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/arch/arm/boot/dts/da850-evm.dts b/arch/arm/boot/dts/da850-evm.dts
index 1fdd9a249165..0ca849885d1f 100644
--- a/arch/arm/boot/dts/da850-evm.dts
+++ b/arch/arm/boot/dts/da850-evm.dts
@@ -415,7 +415,7 @@ &edma1 {
 &aemif {
 	pinctrl-names = "default";
 	pinctrl-0 = <&nand_pins>;
-	status = "ok";
+	status = "okay";
 	cs3 {
 		#address-cells = <2>;
 		#size-cells = <1>;
diff --git a/arch/arm/boot/dts/keystone-k2e-evm.dts b/arch/arm/boot/dts/keystone-k2e-evm.dts
index 5d6d074011df..abd5aef8b87d 100644
--- a/arch/arm/boot/dts/keystone-k2e-evm.dts
+++ b/arch/arm/boot/dts/keystone-k2e-evm.dts
@@ -159,7 +159,7 @@ partition@1 {
 };
 
 &mdio {
-	status = "ok";
+	status = "okay";
 	ethphy0: ethernet-phy@0 {
 		compatible = "marvell,88E1514", "marvell,88E1510", "ethernet-phy-ieee802.3-c22";
 		reg = <0>;
diff --git a/arch/arm/boot/dts/keystone-k2g-evm.dts b/arch/arm/boot/dts/keystone-k2g-evm.dts
index 88be868cf71e..3a87b7943c70 100644
--- a/arch/arm/boot/dts/keystone-k2g-evm.dts
+++ b/arch/arm/boot/dts/keystone-k2g-evm.dts
@@ -534,7 +534,7 @@ tlv320aic3106: tlv320aic3106@1b {
 &dss {
 	pinctrl-names = "default";
 	pinctrl-0 = <&vout_pins>;
-	status = "ok";
+	status = "okay";
 
 	port {
 		dpi_out: endpoint {
diff --git a/arch/arm/boot/dts/keystone-k2hk-evm.dts b/arch/arm/boot/dts/keystone-k2hk-evm.dts
index 4352397b4f52..1f762af6f502 100644
--- a/arch/arm/boot/dts/keystone-k2hk-evm.dts
+++ b/arch/arm/boot/dts/keystone-k2hk-evm.dts
@@ -183,7 +183,7 @@ partition@1 {
 };
 
 &mdio {
-	status = "ok";
+	status = "okay";
 	ethphy0: ethernet-phy@0 {
 		compatible = "marvell,88E1111", "ethernet-phy-ieee802.3-c22";
 		reg = <0>;
diff --git a/arch/arm/boot/dts/keystone-k2l-evm.dts b/arch/arm/boot/dts/keystone-k2l-evm.dts
index 1c880cf8fa91..3a69f65de81e 100644
--- a/arch/arm/boot/dts/keystone-k2l-evm.dts
+++ b/arch/arm/boot/dts/keystone-k2l-evm.dts
@@ -132,7 +132,7 @@ partition@1 {
 };
 
 &mdio {
-	status = "ok";
+	status = "okay";
 	ethphy0: ethernet-phy@0 {
 		compatible = "marvell,88E1514", "marvell,88E1510", "ethernet-phy-ieee802.3-c22";
 		reg = <0>;
-- 
2.34.1

