Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 28B1E61FC38
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Nov 2022 18:55:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232925AbiKGRz0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Nov 2022 12:55:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232617AbiKGRyO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Nov 2022 12:54:14 -0500
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38050197;
        Mon,  7 Nov 2022 09:53:21 -0800 (PST)
Received: by mail-wm1-x32c.google.com with SMTP id o30so7366614wms.2;
        Mon, 07 Nov 2022 09:53:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iQl1Hu5/nrSTnzRvbQ3bMIxhET8sBmMlsPi/XY+Y+k4=;
        b=bOlwmN8wV1l4EKmTWFaCpg+tK20WDHNdisJNBG2s35YMFKLTU7viELgi2SOh/R5U8h
         hMaWWRXNG6oaolcKw7W0cblTpwhk6smh7gOxPSS0b7qRjZkgsXjHFAjazdUJjh/c3i3H
         qMW1HF61Y85kL/qRS1xevfZfHD2n2I2V+TAkrpvDGGdNpAnVXXg/eIU+nsyvRG5iC7br
         5IgvRHeQCsaD5Vi2Ikh1TfQyK+3Mx7RCSXjrfKiqmZ8eNsQWQDRCVULODzSCDXd60qkk
         HzWMYW93EInfqkhzC3PThCRxo4JADogGvtrJbj7Qu/sAlgx8AeASlsVg5Xn+IHFbq9MZ
         6bUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iQl1Hu5/nrSTnzRvbQ3bMIxhET8sBmMlsPi/XY+Y+k4=;
        b=2lowsKqrAJKV0jhKpsbifHqeCm5G4NYmPjmEAYlzuiMaN03P3dxWUWib/FxOVMk6iN
         +wz4P3kV1gZ9zfksu94upjXu2niDYgz4PMahxh7CXxXh3IyFr1txBdA5IaJrIvtS348V
         aYncuLfU0MDXWNJeg13HtYDaxm3NSHUlCvyPTjbEluGBaatBBVSAtumGrw/EkqdsXHGJ
         WRcDsxqQ+E5gGFbbH7mw7VgEMkCpFxyjfc2VHFjTAqkFiKThmhqMeIQlsAC6APVc9NXK
         MDlyIgPUw6OrQQNbAifb+v7Ls1vrk+EE5AOlyDwN9yQwVnd5dNRXXK+bqvs0qPRB3Oz0
         qCgA==
X-Gm-Message-State: ANoB5pkQ+vvyUoUA5vKq80vweV79EzgZ7EhQVash3jw8Qa2CcfhDT5SC
        +lxS2XSQgmUNfOBgF6ye/y4=
X-Google-Smtp-Source: AA0mqf5ihVQvbBpKQZiANLVLZsILeRFrbkkYHN6CmL/95rHEt3QrboF2MHcjAs6wJJly7AkhgRS/aA==
X-Received: by 2002:a05:600c:314e:b0:3cf:a816:80dc with SMTP id h14-20020a05600c314e00b003cfa81680dcmr6090812wmo.88.1667843599761;
        Mon, 07 Nov 2022 09:53:19 -0800 (PST)
Received: from prasmi.home ([2a00:23c8:2501:c701:9c45:7ed3:c12e:e25b])
        by smtp.gmail.com with ESMTPSA id v4-20020a5d4a44000000b002365254ea42sm8072454wrs.1.2022.11.07.09.53.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Nov 2022 09:53:19 -0800 (PST)
From:   Prabhakar <prabhakar.csengg@gmail.com>
X-Google-Original-From: Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Magnus Damm <magnus.damm@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>
Cc:     linux-gpio@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Prabhakar <prabhakar.csengg@gmail.com>,
        Biju Das <biju.das.jz@bp.renesas.com>,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH RFC 3/5] arm64: dts: renesas: r9a07g043[u]: Add IRQC node
Date:   Mon,  7 Nov 2022 17:53:03 +0000
Message-Id: <20221107175305.63975-4-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221107175305.63975-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20221107175305.63975-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,UPPERCASE_50_75 autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

Add IRQC node to R9A07G043 (RZ/G2UL) SoC DTSI.

Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
---
Note,
- clocks and resets are differnt when compared to RZ/Five hence its added
  in r9a07g043u.dtsi
- We have additional interrupt on RZ/Five hence interrupts are added in
  r9a07g043u.dtsi
- clock-names is also added in r9a07g043u.dtsi to avoid dtbs_check warning
---
 arch/arm64/boot/dts/renesas/r9a07g043.dtsi  |  8 ++++
 arch/arm64/boot/dts/renesas/r9a07g043u.dtsi | 50 +++++++++++++++++++++
 2 files changed, 58 insertions(+)

diff --git a/arch/arm64/boot/dts/renesas/r9a07g043.dtsi b/arch/arm64/boot/dts/renesas/r9a07g043.dtsi
index 3f7d451b1199..44b9bc6294be 100644
--- a/arch/arm64/boot/dts/renesas/r9a07g043.dtsi
+++ b/arch/arm64/boot/dts/renesas/r9a07g043.dtsi
@@ -538,6 +538,14 @@ pinctrl: pinctrl@11030000 {
 				 <&cpg R9A07G043_GPIO_SPARE_RESETN>;
 		};
 
+		irqc: interrupt-controller@110a0000 {
+			#interrupt-cells = <2>;
+			#address-cells = <0>;
+			interrupt-controller;
+			reg = <0 0x110a0000 0 0x10000>;
+			power-domains = <&cpg>;
+		};
+
 		dmac: dma-controller@11820000 {
 			compatible = "renesas,r9a07g043-dmac",
 				     "renesas,rz-dmac";
diff --git a/arch/arm64/boot/dts/renesas/r9a07g043u.dtsi b/arch/arm64/boot/dts/renesas/r9a07g043u.dtsi
index b8bf06b51235..7a8ed7ae253b 100644
--- a/arch/arm64/boot/dts/renesas/r9a07g043u.dtsi
+++ b/arch/arm64/boot/dts/renesas/r9a07g043u.dtsi
@@ -48,6 +48,56 @@ timer {
 	};
 };
 
+&irqc {
+	compatible = "renesas,r9a07g043u-irqc",
+		     "renesas,rzg2l-irqc";
+	interrupts = <SOC_PERIPHERAL_IRQ(0) IRQ_TYPE_LEVEL_HIGH>,
+		     <SOC_PERIPHERAL_IRQ(1) IRQ_TYPE_LEVEL_HIGH>,
+		     <SOC_PERIPHERAL_IRQ(2) IRQ_TYPE_LEVEL_HIGH>,
+		     <SOC_PERIPHERAL_IRQ(3) IRQ_TYPE_LEVEL_HIGH>,
+		     <SOC_PERIPHERAL_IRQ(4) IRQ_TYPE_LEVEL_HIGH>,
+		     <SOC_PERIPHERAL_IRQ(5) IRQ_TYPE_LEVEL_HIGH>,
+		     <SOC_PERIPHERAL_IRQ(6) IRQ_TYPE_LEVEL_HIGH>,
+		     <SOC_PERIPHERAL_IRQ(7) IRQ_TYPE_LEVEL_HIGH>,
+		     <SOC_PERIPHERAL_IRQ(8) IRQ_TYPE_LEVEL_HIGH>,
+		     <SOC_PERIPHERAL_IRQ(444) IRQ_TYPE_LEVEL_HIGH>,
+		     <SOC_PERIPHERAL_IRQ(445) IRQ_TYPE_LEVEL_HIGH>,
+		     <SOC_PERIPHERAL_IRQ(446) IRQ_TYPE_LEVEL_HIGH>,
+		     <SOC_PERIPHERAL_IRQ(447) IRQ_TYPE_LEVEL_HIGH>,
+		     <SOC_PERIPHERAL_IRQ(448) IRQ_TYPE_LEVEL_HIGH>,
+		     <SOC_PERIPHERAL_IRQ(449) IRQ_TYPE_LEVEL_HIGH>,
+		     <SOC_PERIPHERAL_IRQ(450) IRQ_TYPE_LEVEL_HIGH>,
+		     <SOC_PERIPHERAL_IRQ(451) IRQ_TYPE_LEVEL_HIGH>,
+		     <SOC_PERIPHERAL_IRQ(452) IRQ_TYPE_LEVEL_HIGH>,
+		     <SOC_PERIPHERAL_IRQ(453) IRQ_TYPE_LEVEL_HIGH>,
+		     <SOC_PERIPHERAL_IRQ(454) IRQ_TYPE_LEVEL_HIGH>,
+		     <SOC_PERIPHERAL_IRQ(455) IRQ_TYPE_LEVEL_HIGH>,
+		     <SOC_PERIPHERAL_IRQ(456) IRQ_TYPE_LEVEL_HIGH>,
+		     <SOC_PERIPHERAL_IRQ(457) IRQ_TYPE_LEVEL_HIGH>,
+		     <SOC_PERIPHERAL_IRQ(458) IRQ_TYPE_LEVEL_HIGH>,
+		     <SOC_PERIPHERAL_IRQ(459) IRQ_TYPE_LEVEL_HIGH>,
+		     <SOC_PERIPHERAL_IRQ(460) IRQ_TYPE_LEVEL_HIGH>,
+		     <SOC_PERIPHERAL_IRQ(461) IRQ_TYPE_LEVEL_HIGH>,
+		     <SOC_PERIPHERAL_IRQ(462) IRQ_TYPE_LEVEL_HIGH>,
+		     <SOC_PERIPHERAL_IRQ(463) IRQ_TYPE_LEVEL_HIGH>,
+		     <SOC_PERIPHERAL_IRQ(464) IRQ_TYPE_LEVEL_HIGH>,
+		     <SOC_PERIPHERAL_IRQ(465) IRQ_TYPE_LEVEL_HIGH>,
+		     <SOC_PERIPHERAL_IRQ(466) IRQ_TYPE_LEVEL_HIGH>,
+		     <SOC_PERIPHERAL_IRQ(467) IRQ_TYPE_LEVEL_HIGH>,
+		     <SOC_PERIPHERAL_IRQ(468) IRQ_TYPE_LEVEL_HIGH>,
+		     <SOC_PERIPHERAL_IRQ(469) IRQ_TYPE_LEVEL_HIGH>,
+		     <SOC_PERIPHERAL_IRQ(470) IRQ_TYPE_LEVEL_HIGH>,
+		     <SOC_PERIPHERAL_IRQ(471) IRQ_TYPE_LEVEL_HIGH>,
+		     <SOC_PERIPHERAL_IRQ(472) IRQ_TYPE_LEVEL_HIGH>,
+		     <SOC_PERIPHERAL_IRQ(473) IRQ_TYPE_LEVEL_HIGH>,
+		     <SOC_PERIPHERAL_IRQ(474) IRQ_TYPE_LEVEL_HIGH>,
+		     <SOC_PERIPHERAL_IRQ(475) IRQ_TYPE_LEVEL_HIGH>;
+	clocks = <&cpg CPG_MOD R9A07G043_IA55_CLK>,
+		 <&cpg CPG_MOD R9A07G043_IA55_PCLK>;
+	clock-names = "clk", "pclk";
+	resets = <&cpg R9A07G043_IA55_RESETN>;
+};
+
 &soc {
 	interrupt-parent = <&gic>;
 
-- 
2.25.1

