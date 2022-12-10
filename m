Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 46BCD648E70
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Dec 2022 12:34:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229658AbiLJLeA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 10 Dec 2022 06:34:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229761AbiLJLdv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Dec 2022 06:33:51 -0500
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7604F1FCFF
        for <linux-kernel@vger.kernel.org>; Sat, 10 Dec 2022 03:33:50 -0800 (PST)
Received: by mail-lf1-x12f.google.com with SMTP id cf42so11035982lfb.1
        for <linux-kernel@vger.kernel.org>; Sat, 10 Dec 2022 03:33:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=VQb/YxDmg3WRV5VwyOoHcCZWorD7UL47Mk4PA4a4FQc=;
        b=OXATOLg9JYiPcxWSD6cU9ST5jmTx4pL0IeHcP8/15/6bkbVpwDzKpRzmt+pyS834AW
         iHLna+Y4Y1RURsuohQddgiDFW42KPnyLYyvxgCOKzTRx18xqloVYRU28cCHkijwG9/vh
         vlTnRUSR1jtZ97lDxvJKJcb2+IhFllmsZca0eMOZRdoxss01jhIqeoU7OayPL/xUm48Z
         qwPlzOmT6HddRrbMpcAIHYLtTQ+lWFTmqXa9wPvyGnoxUtbjTfF/Bhl2GaT3EHMKv8mN
         9XDV+BRvbup3p4gab0wKRexSM2fBwCDAmWwGroeYfhQ+qVavVLPNJoswp0CT0PcL6fQ0
         8cew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VQb/YxDmg3WRV5VwyOoHcCZWorD7UL47Mk4PA4a4FQc=;
        b=D3mGeA8ddyyNT5Puzzoi6P9ZehUqNcyUVBbgIs2zGz0nANbqdVty3c9VUs3zD8EBia
         O5i7ZPwW+3KhL121IvC0+j2effTq6cR5gWCPOby+nigoTrlMl88CL4WeZ0uqL3YhtBsP
         83CzTyApsHrWJQiCGxzK8UPXZ1bGzIJhJa18WyRrfeqCLfQN0RKYLlaxG9KMNQ1yiGT9
         oNFQt4aMajEAK2DMWCtxRA48FheTjudXoTGYMvrtjP/d0CadjlStT8RXnNC04swVMkL9
         +G8FDI0S5+OP19URKlTz1EIBm84y1o9sFqrCE2sGGvNUD530Xw7eYqSYUZAD2sKzbFYU
         j4bQ==
X-Gm-Message-State: ANoB5pnlEY0tg9N4F3V4PWsiYLizsuOwP51KWjpUXuTvOOmYCVIfP2pH
        Tmy3T+wi5Z9QtIuwK3KmSie21tUoX222urRJOaA=
X-Google-Smtp-Source: AA0mqf7IVjYG4W4DNo+gzrSYxWA7ZCl5Mvajox9s4euvPH1Z/9LN1C2ZpcnKKzYqNF1IvrtLWQILhQ==
X-Received: by 2002:ac2:555b:0:b0:4b0:6023:6f71 with SMTP id l27-20020ac2555b000000b004b060236f71mr2460351lfk.62.1670672028799;
        Sat, 10 Dec 2022 03:33:48 -0800 (PST)
Received: from krzk-bin.NAT.warszawa.vectranet.pl (088156142067.dynamic-2-waw-k-3-2-0.vectranet.pl. [88.156.142.67])
        by smtp.gmail.com with ESMTPSA id o27-20020ac25e3b000000b0048a9e899693sm696055lfg.16.2022.12.10.03.33.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 10 Dec 2022 03:33:48 -0800 (PST)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Viresh Kumar <vireshk@kernel.org>,
        Shiraz Hashim <shiraz.linux.kernel@gmail.com>, soc@kernel.org,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH] ARM: dts: spear: drop 0x from unit address
Date:   Sat, 10 Dec 2022 12:33:46 +0100
Message-Id: <20221210113347.63939-1-krzysztof.kozlowski@linaro.org>
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

By coding style, unit address should not start with 0x.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 arch/arm/boot/dts/spear300.dtsi | 2 +-
 arch/arm/boot/dts/spear310.dtsi | 2 +-
 arch/arm/boot/dts/spear320.dtsi | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arm/boot/dts/spear300.dtsi b/arch/arm/boot/dts/spear300.dtsi
index b39bd5a22627..f1135e887f7b 100644
--- a/arch/arm/boot/dts/spear300.dtsi
+++ b/arch/arm/boot/dts/spear300.dtsi
@@ -46,7 +46,7 @@ sdhci@70000000 {
 			status = "disabled";
 		};
 
-		shirq: interrupt-controller@0x50000000 {
+		shirq: interrupt-controller@50000000 {
 			compatible = "st,spear300-shirq";
 			reg = <0x50000000 0x1000>;
 			interrupts = <28>;
diff --git a/arch/arm/boot/dts/spear310.dtsi b/arch/arm/boot/dts/spear310.dtsi
index 77570833d46b..ce08d8820940 100644
--- a/arch/arm/boot/dts/spear310.dtsi
+++ b/arch/arm/boot/dts/spear310.dtsi
@@ -34,7 +34,7 @@ fsmc: flash@44000000 {
 			status = "disabled";
 		};
 
-		shirq: interrupt-controller@0xb4000000 {
+		shirq: interrupt-controller@b4000000 {
 			compatible = "st,spear310-shirq";
 			reg = <0xb4000000 0x1000>;
 			interrupts = <28 29 30 1>;
diff --git a/arch/arm/boot/dts/spear320.dtsi b/arch/arm/boot/dts/spear320.dtsi
index b12474446a48..56f141297ea3 100644
--- a/arch/arm/boot/dts/spear320.dtsi
+++ b/arch/arm/boot/dts/spear320.dtsi
@@ -49,7 +49,7 @@ sdhci@70000000 {
 			status = "disabled";
 		};
 
-		shirq: interrupt-controller@0xb3000000 {
+		shirq: interrupt-controller@b3000000 {
 			compatible = "st,spear320-shirq";
 			reg = <0xb3000000 0x1000>;
 			interrupts = <30 28 29 1>;
-- 
2.34.1

