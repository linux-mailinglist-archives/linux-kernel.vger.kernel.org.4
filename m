Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7259E652A3E
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Dec 2022 01:03:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234353AbiLUAD2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Dec 2022 19:03:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234325AbiLUADF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Dec 2022 19:03:05 -0500
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3B42201A4;
        Tue, 20 Dec 2022 16:03:04 -0800 (PST)
Received: by mail-wr1-x42a.google.com with SMTP id h16so13390490wrz.12;
        Tue, 20 Dec 2022 16:03:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LNyPY43zgGr1A85XTmiE4/fhVElkNurZ7fW0yqYaRFM=;
        b=lRmKVfykfWVj0cGXPi8E0tsM5KwgJb18SJe3Z/fYrdQdAQKB+IUvF8OsAWoXgCO2Tt
         GpZcYc7lQpSLJHIk/XmHTIYGTQoBUeWZcrY3mJdbrqA8ytC3A4llv4o1znbwfQh/oWC2
         P46mDecLRqf5R+Auqkv+lFZLzs9hVuZYQx/oQFe8Zn1ftOm2WJvpK2/NkJ4rfOXTSoJ6
         FoGANO6oIhCkyEDFw4p/6c9cj8xf8a8DVPMUnM20khuXw2jWnIv5s8PYmSgtVuG2gtuM
         10UlhVT7+NJvvLJPnVk+HVrPMH4UjW0Of1E8FTor3BgHsDJ1TevJb42LtiCeZdQIjghS
         07VQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LNyPY43zgGr1A85XTmiE4/fhVElkNurZ7fW0yqYaRFM=;
        b=YQBEHN/a/ntKVpxFMl6Ekd9NPb6y8QAKt8UghGj2HfJoeVDOsTAunZy045AC1ZZYLi
         x//Swso/a9dz3fCMhZM3PbjfAbnGu6fS87QwZdabuNqFBz3EqCk8YX8k/h9bVcXAcDAt
         ECvlz8zhW5eCZpZ0xgCxpdunBxu4qzd60AcYfp1Tl2+ONuLs56I0ziCmHVOqm2Q/ye33
         HCFvuR1RlGnABworeI0pRPWjmbBHCYaK2++L1ltG1QIBXSDYDCCtZn1cFRaibTFvjFns
         LWnP+Y0pNVWi1rxQzZQA9Go6C/JJd6BNoslwj6JwXrcOzaboOHzJ9ZxmNb3hXZaZ/q6d
         A1sw==
X-Gm-Message-State: ANoB5pmj+ILbMO2Ej92kCFijQ+6ln1EZo1nC4OuwtWuJK7XMrOayXKFa
        lbsEFZu08G8vx4Fyni9iGsY=
X-Google-Smtp-Source: AA0mqf7L/nkpPAcY7TsjGvrq1WYphSjNvzyqhoHR6bVuyaz0Zr7uEW6XOLz78MltwmRi6kbMO4CCEQ==
X-Received: by 2002:a05:6000:799:b0:24e:aad5:c48b with SMTP id bu25-20020a056000079900b0024eaad5c48bmr23947136wrb.15.1671580984216;
        Tue, 20 Dec 2022 16:03:04 -0800 (PST)
Received: from prasmi.home ([2a00:23c8:2501:c701:1595:a48c:95a8:15e0])
        by smtp.gmail.com with ESMTPSA id f2-20020a5d50c2000000b002362f6fcaf5sm13740150wrt.48.2022.12.20.16.03.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Dec 2022 16:03:03 -0800 (PST)
From:   Prabhakar <prabhakar.csengg@gmail.com>
X-Google-Original-From: Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Magnus Damm <magnus.damm@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-renesas-soc@vger.kernel.org, linux-gpio@vger.kernel.org,
        Prabhakar <prabhakar.csengg@gmail.com>,
        Biju Das <biju.das.jz@bp.renesas.com>,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH v2 7/9] arm64: dts: renesas: r9a07g043u: Add IRQC node
Date:   Wed, 21 Dec 2022 00:02:40 +0000
Message-Id: <20221221000242.340202-8-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221221000242.340202-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20221221000242.340202-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
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
v1 -> v2
* Moved irqc node completely to rzg2ul SoC DTSI
* Added interrupt-names
---
 arch/arm64/boot/dts/renesas/r9a07g043u.dtsi | 68 +++++++++++++++++++++
 1 file changed, 68 insertions(+)

diff --git a/arch/arm64/boot/dts/renesas/r9a07g043u.dtsi b/arch/arm64/boot/dts/renesas/r9a07g043u.dtsi
index 6af5f3bca2d1..c6e25ad98011 100644
--- a/arch/arm64/boot/dts/renesas/r9a07g043u.dtsi
+++ b/arch/arm64/boot/dts/renesas/r9a07g043u.dtsi
@@ -52,6 +52,74 @@ timer {
 &soc {
 	interrupt-parent = <&gic>;
 
+	irqc: interrupt-controller@110a0000 {
+		compatible = "renesas,r9a07g043u-irqc",
+			     "renesas,rzg2ul-irqc";
+		reg = <0 0x110a0000 0 0x10000>;
+		#interrupt-cells = <2>;
+		#address-cells = <0>;
+		interrupt-controller;
+		interrupts = <SOC_PERIPHERAL_IRQ(0) IRQ_TYPE_LEVEL_HIGH>,
+			     <SOC_PERIPHERAL_IRQ(1) IRQ_TYPE_LEVEL_HIGH>,
+			     <SOC_PERIPHERAL_IRQ(2) IRQ_TYPE_LEVEL_HIGH>,
+			     <SOC_PERIPHERAL_IRQ(3) IRQ_TYPE_LEVEL_HIGH>,
+			     <SOC_PERIPHERAL_IRQ(4) IRQ_TYPE_LEVEL_HIGH>,
+			     <SOC_PERIPHERAL_IRQ(5) IRQ_TYPE_LEVEL_HIGH>,
+			     <SOC_PERIPHERAL_IRQ(6) IRQ_TYPE_LEVEL_HIGH>,
+			     <SOC_PERIPHERAL_IRQ(7) IRQ_TYPE_LEVEL_HIGH>,
+			     <SOC_PERIPHERAL_IRQ(8) IRQ_TYPE_LEVEL_HIGH>,
+			     <SOC_PERIPHERAL_IRQ(444) IRQ_TYPE_LEVEL_HIGH>,
+			     <SOC_PERIPHERAL_IRQ(445) IRQ_TYPE_LEVEL_HIGH>,
+			     <SOC_PERIPHERAL_IRQ(446) IRQ_TYPE_LEVEL_HIGH>,
+			     <SOC_PERIPHERAL_IRQ(447) IRQ_TYPE_LEVEL_HIGH>,
+			     <SOC_PERIPHERAL_IRQ(448) IRQ_TYPE_LEVEL_HIGH>,
+			     <SOC_PERIPHERAL_IRQ(449) IRQ_TYPE_LEVEL_HIGH>,
+			     <SOC_PERIPHERAL_IRQ(450) IRQ_TYPE_LEVEL_HIGH>,
+			     <SOC_PERIPHERAL_IRQ(451) IRQ_TYPE_LEVEL_HIGH>,
+			     <SOC_PERIPHERAL_IRQ(452) IRQ_TYPE_LEVEL_HIGH>,
+			     <SOC_PERIPHERAL_IRQ(453) IRQ_TYPE_LEVEL_HIGH>,
+			     <SOC_PERIPHERAL_IRQ(454) IRQ_TYPE_LEVEL_HIGH>,
+			     <SOC_PERIPHERAL_IRQ(455) IRQ_TYPE_LEVEL_HIGH>,
+			     <SOC_PERIPHERAL_IRQ(456) IRQ_TYPE_LEVEL_HIGH>,
+			     <SOC_PERIPHERAL_IRQ(457) IRQ_TYPE_LEVEL_HIGH>,
+			     <SOC_PERIPHERAL_IRQ(458) IRQ_TYPE_LEVEL_HIGH>,
+			     <SOC_PERIPHERAL_IRQ(459) IRQ_TYPE_LEVEL_HIGH>,
+			     <SOC_PERIPHERAL_IRQ(460) IRQ_TYPE_LEVEL_HIGH>,
+			     <SOC_PERIPHERAL_IRQ(461) IRQ_TYPE_LEVEL_HIGH>,
+			     <SOC_PERIPHERAL_IRQ(462) IRQ_TYPE_LEVEL_HIGH>,
+			     <SOC_PERIPHERAL_IRQ(463) IRQ_TYPE_LEVEL_HIGH>,
+			     <SOC_PERIPHERAL_IRQ(464) IRQ_TYPE_LEVEL_HIGH>,
+			     <SOC_PERIPHERAL_IRQ(465) IRQ_TYPE_LEVEL_HIGH>,
+			     <SOC_PERIPHERAL_IRQ(466) IRQ_TYPE_LEVEL_HIGH>,
+			     <SOC_PERIPHERAL_IRQ(467) IRQ_TYPE_LEVEL_HIGH>,
+			     <SOC_PERIPHERAL_IRQ(468) IRQ_TYPE_LEVEL_HIGH>,
+			     <SOC_PERIPHERAL_IRQ(469) IRQ_TYPE_LEVEL_HIGH>,
+			     <SOC_PERIPHERAL_IRQ(470) IRQ_TYPE_LEVEL_HIGH>,
+			     <SOC_PERIPHERAL_IRQ(471) IRQ_TYPE_LEVEL_HIGH>,
+			     <SOC_PERIPHERAL_IRQ(472) IRQ_TYPE_LEVEL_HIGH>,
+			     <SOC_PERIPHERAL_IRQ(473) IRQ_TYPE_LEVEL_HIGH>,
+			     <SOC_PERIPHERAL_IRQ(474) IRQ_TYPE_LEVEL_HIGH>,
+			     <SOC_PERIPHERAL_IRQ(475) IRQ_TYPE_LEVEL_HIGH>,
+			     <SOC_PERIPHERAL_IRQ(25) IRQ_TYPE_EDGE_RISING>;
+		interrupt-names = "nmi",
+				  "irq0", "irq1", "irq2", "irq3",
+				  "irq4", "irq5", "irq6", "irq7",
+				  "tint0", "tint1", "tint2", "tint3",
+				  "tint4", "tint5", "tint6", "tint7",
+				  "tint8", "tint9", "tint10", "tint11",
+				  "tint12", "tint13", "tint14", "tint15",
+				  "tint16", "tint17", "tint18", "tint19",
+				  "tint20", "tint21", "tint22", "tint23",
+				  "tint24", "tint25", "tint26", "tint27",
+				  "tint28", "tint29", "tint30", "tint31",
+				  "bus-err";
+		clocks = <&cpg CPG_MOD R9A07G043_IA55_CLK>,
+			<&cpg CPG_MOD R9A07G043_IA55_PCLK>;
+		clock-names = "clk", "pclk";
+		power-domains = <&cpg>;
+		resets = <&cpg R9A07G043_IA55_RESETN>;
+	};
+
 	gic: interrupt-controller@11900000 {
 		compatible = "arm,gic-v3";
 		#interrupt-cells = <3>;
-- 
2.25.1

