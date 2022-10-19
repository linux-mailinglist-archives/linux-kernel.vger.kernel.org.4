Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B4F53604819
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Oct 2022 15:50:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233606AbiJSNt7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Oct 2022 09:49:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232921AbiJSNsa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Oct 2022 09:48:30 -0400
Received: from relay4-d.mail.gandi.net (relay4-d.mail.gandi.net [217.70.183.196])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E25ED19003;
        Wed, 19 Oct 2022 06:32:51 -0700 (PDT)
Received: (Authenticated sender: kory.maincent@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id D76FAE0007;
        Wed, 19 Oct 2022 13:32:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1666186343;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=4H7vT96t4Gg2mvOMTAf2MIe6YqeZHlVPrSbGQ6Z0P8U=;
        b=CUy8nN36BZsU6m2IBtItc7gm2WLjl4v/gW7apb0LG5G+/b5o54EWRmh7oGhxJ0nOwV1ga7
        C3RSJBI/JxW8doW/hUs0fNQ1BrdzoNzB5eP29YIrK5l0Hf1KpimS4mchfUgk46TctPq+nx
        O89Hb1KJ872kYLdDwS3Zaqg01SBvf5fqvm+l0wYKfxS9xt89b4xSz15QQo1XeSHjVy2lfU
        aANYFiYsF3eJHaN45klxj2fQVr2/SOsGCIg9y6I0sLdrnjLGhWmA6BOoSOL04HruC+V6XP
        7TmKp1vntsTG35puwEMzFauSQeYEKVlvtm4/1LlsdS0fA5MbhjqHcJ+JpnJPeA==
From:   =?UTF-8?q?K=C3=B6ry=20Maincent?= <kory.maincent@bootlin.com>
To:     linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     thomas.petazzoni@bootlin.com,
        Kory Maincent <kory.maincent@bootlin.com>,
        Viresh Kumar <vireshk@kernel.org>,
        Shiraz Hashim <shiraz.linux.kernel@gmail.com>, soc@kernel.org,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Subject: [PATCH 5/6] arm: dts: spear600: Add ssp controller nodes
Date:   Wed, 19 Oct 2022 15:32:07 +0200
Message-Id: <20221019133208.319626-6-kory.maincent@bootlin.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221019133208.319626-1-kory.maincent@bootlin.com>
References: <20221019133208.319626-1-kory.maincent@bootlin.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kory Maincent <kory.maincent@bootlin.com>

The SPEAr600 has three Synchronous serial port to enables synchronous
serial communication with slave or master peripherals (SPI). Lets add these
nodes to be able to use them.

Signed-off-by: Kory Maincent <kory.maincent@bootlin.com>
---
 arch/arm/boot/dts/spear600.dtsi | 30 ++++++++++++++++++++++++++++++
 1 file changed, 30 insertions(+)

diff --git a/arch/arm/boot/dts/spear600.dtsi b/arch/arm/boot/dts/spear600.dtsi
index 9d5a04a46b14..6b67c0ceaed9 100644
--- a/arch/arm/boot/dts/spear600.dtsi
+++ b/arch/arm/boot/dts/spear600.dtsi
@@ -207,6 +207,36 @@ adc: adc@d820b000 {
 				interrupts = <6>;
 				status = "disabled";
 			};
+
+			ssp1: spi@d0100000 {
+				compatible = "arm,pl022", "arm,primecell";
+				reg = <0xd0100000 0x1000>;
+				#address-cells = <1>;
+				#size-cells = <0>;
+				interrupt-parent = <&vic0>;
+				interrupts = <26>;
+				status = "disabled";
+			};
+
+			ssp2: spi@d0180000 {
+				compatible = "arm,pl022", "arm,primecell";
+				reg = <0xd0180000 0x1000>;
+				#address-cells = <1>;
+				#size-cells = <0>;
+				interrupt-parent = <&vic0>;
+				interrupts = <27>;
+				status = "disabled";
+			};
+
+			ssp3: spi@d8180000 {
+				compatible = "arm,pl022", "arm,primecell";
+				reg = <0xd8180000 0x1000>;
+				#address-cells = <1>;
+				#size-cells = <0>;
+				interrupt-parent = <&vic1>;
+				interrupts = <5>;
+				status = "disabled";
+			};
 		};
 	};
 };
-- 
2.25.1

