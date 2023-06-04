Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 682D37217FB
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Jun 2023 16:57:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232315AbjFDO5G (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 4 Jun 2023 10:57:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232287AbjFDO5D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Jun 2023 10:57:03 -0400
Received: from aposti.net (aposti.net [89.234.176.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D735BE3;
        Sun,  4 Jun 2023 07:56:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net;
        s=mail; t=1685890610;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ifqQeQGnnzV13/cFXnaYHZyXnfxZDj76WFVwrDE4Edg=;
        b=oO7orWjt7QQ63CskpU2DxU6A80UhBTRt3YqOrZqqOtMJPOhN+vR8wV4Kcf8/9T/OIDzcV/
        b0Gj4AkMcjnnf27WBNY8lJhZFpHahKJgpqZ7xm8IFrB/HZJdAVKC030nq2qkzwcBYTxtCt
        TqulaHg+Dv8DYvR/YJSMwiWhQucNQFY=
From:   Paul Cercueil <paul@crapouillou.net>
To:     Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc:     "H . Nikolaus Schaller" <hns@goldelico.com>,
        linux-mips@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, list@opendingux.net,
        Paul Cercueil <paul@crapouillou.net>
Subject: [PATCH 1/9] MIPS: DTS: CI20: Fix regulators
Date:   Sun,  4 Jun 2023 16:56:34 +0200
Message-Id: <20230604145642.200577-2-paul@crapouillou.net>
In-Reply-To: <20230604145642.200577-1-paul@crapouillou.net>
References: <20230604145642.200577-1-paul@crapouillou.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam: Yes
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The regulators don't have any "reg" property, and therefore shouldn't
use an unit address in their node names. They also don't need to specify
the GPIO_ACTIVE_LOW flag, which will be ignored anyway, as they are
active-high.

Signed-off-by: Paul Cercueil <paul@crapouillou.net>
---
 arch/mips/boot/dts/ingenic/ci20.dts | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/arch/mips/boot/dts/ingenic/ci20.dts b/arch/mips/boot/dts/ingenic/ci20.dts
index 239c4537484d..e76953dce2e7 100644
--- a/arch/mips/boot/dts/ingenic/ci20.dts
+++ b/arch/mips/boot/dts/ingenic/ci20.dts
@@ -67,14 +67,14 @@ led-3 {
 		};
 	};
 
-	eth0_power: fixedregulator@0 {
+	eth0_power: fixedregulator-0 {
 		compatible = "regulator-fixed";
 
 		regulator-name = "eth0_power";
 		regulator-min-microvolt = <3300000>;
 		regulator-max-microvolt = <3300000>;
 
-		gpio = <&gpb 25 GPIO_ACTIVE_LOW>;
+		gpio = <&gpb 25 0>;
 		enable-active-high;
 	};
 
@@ -97,23 +97,23 @@ ir: ir {
 		gpios = <&gpe 3 GPIO_ACTIVE_LOW>;
 	};
 
-	wlan0_power: fixedregulator@1 {
+	wlan0_power: fixedregulator-1 {
 		compatible = "regulator-fixed";
 
 		regulator-name = "wlan0_power";
 
-		gpio = <&gpb 19 GPIO_ACTIVE_LOW>;
+		gpio = <&gpb 19 0>;
 		enable-active-high;
 	};
 
-	otg_power: fixedregulator@2 {
+	otg_power: fixedregulator-2 {
 		compatible = "regulator-fixed";
 
 		regulator-name = "otg_power";
 		regulator-min-microvolt = <5000000>;
 		regulator-max-microvolt = <5000000>;
 
-		gpio = <&gpf 15 GPIO_ACTIVE_LOW>;
+		gpio = <&gpf 15 0>;
 		enable-active-high;
 	};
 };
-- 
2.39.2

