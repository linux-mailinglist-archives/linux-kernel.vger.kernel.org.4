Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D18B676924
	for <lists+linux-kernel@lfdr.de>; Sat, 21 Jan 2023 21:19:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229972AbjAUUTH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 21 Jan 2023 15:19:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229789AbjAUUTE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 Jan 2023 15:19:04 -0500
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06CC423653;
        Sat, 21 Jan 2023 12:19:03 -0800 (PST)
Received: by mail-ed1-x530.google.com with SMTP id g11so4920024eda.12;
        Sat, 21 Jan 2023 12:19:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CH5ssNbMjjziLJwNcTMZ2d/eFIt2gMohhe8o5T2jQ1M=;
        b=cmlPIsUKJIXzWwqnC4S5Q6Sh3AiU8MryNr3cqUXSVhP42gUD0VfJGZsO9FNpADkAVC
         oyZWkecCioCu9CFyvvW4s4luOl1aSnKERWv1dsDFj2v8wwfSwFenA8UC4t/PtoXp8tSC
         V4vnx8CcjfkLS7KBz3EeOLEmmHI6dyPb43ize4jsyIAzcmnr7XVMf9pAw2Qj8l+4RRjP
         uaWlcfutQUME1qsMyRgJAmVL8FRjzl6ZtH56MV5Nq3iXHLS19sSlhgs0rlzPXLP9m34u
         yEhcfZQfiKa8qjge/o5uu2RTRXy29JhSN2w6fRMFlbnSNsjZ7lqxbpddCHpjzHLN9S4B
         2o+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CH5ssNbMjjziLJwNcTMZ2d/eFIt2gMohhe8o5T2jQ1M=;
        b=SiBRVxelcAeYOj90hOOhMmNY8ZwtQnRQZMmo7Qzwpuo+s1cXfu82RT4qk9//rtBFvl
         0S4nI5ex6EM1h98XuyrBz1On43UC92k+T4V3qkx6HlwQh8BoHnGezQ2+tBO3p9ZCBWxu
         wtPSphQgyyVI/FfVv6njLdYk8srTbhl9/7EY21WtMph4iA6V4YVC18d9YMFLelOjwInF
         xAhFfZsG8rhaEpcL5IORKgeQpZnluwA0qgtseeKqlR7dtZV1gEJnNYOFNXvr4YGCYRjA
         sBHprYTC2JDjsoxFVIgRQoMEl3l4hfa+L6mPpG1NisYETSLsoNQyf6FesQfuft2/PWCI
         JYlQ==
X-Gm-Message-State: AFqh2kr/wTJkRQmI3mrEoJxVpLQSwLzd8Bft+H8mJfb+QJLCX+kKIsze
        SUp1ohTSYTMsehuWxoVaM/TkyGIhmUj1aQ==
X-Google-Smtp-Source: AMrXdXt2T1rSWy07cfoufrTsb4Ux/gRiVjdxbuoH6X7KzDV2UqKSIKXY976EzcAdpKOxcUNxlm2uFw==
X-Received: by 2002:aa7:ccd3:0:b0:49d:f44f:7ef1 with SMTP id y19-20020aa7ccd3000000b0049df44f7ef1mr22672142edt.14.1674332341236;
        Sat, 21 Jan 2023 12:19:01 -0800 (PST)
Received: from localhost.localdomain ([194.39.226.133])
        by smtp.gmail.com with ESMTPSA id i23-20020a50fc17000000b0047c6f3eccb2sm19203423edr.50.2023.01.21.12.18.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 21 Jan 2023 12:19:00 -0800 (PST)
From:   Markuss Broks <markuss.broks@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     Markuss Broks <markuss.broks@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>,
        soc@kernel.org, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-samsung-soc@vger.kernel.org
Subject: [PATCH v2 2/2] arm: dts: exynos5800: Use Exynos5422 compatible for the DSI controller
Date:   Sat, 21 Jan 2023 22:18:43 +0200
Message-Id: <20230121201844.46872-3-markuss.broks@gmail.com>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230121201844.46872-1-markuss.broks@gmail.com>
References: <20230121201844.46872-1-markuss.broks@gmail.com>
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

The driver adding support for Exynos5422/Exynos5800 DSI controller was
merged in 2016, yet it wasn't actually used. Add a proper compatible
for it.

Signed-off-by: Markuss Broks <markuss.broks@gmail.com>
---
 arch/arm/boot/dts/exynos5420.dtsi | 2 +-
 arch/arm/boot/dts/exynos5800.dtsi | 4 ++++
 2 files changed, 5 insertions(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/exynos5420.dtsi b/arch/arm/boot/dts/exynos5420.dtsi
index 62263eb91b3c..b612468515eb 100644
--- a/arch/arm/boot/dts/exynos5420.dtsi
+++ b/arch/arm/boot/dts/exynos5420.dtsi
@@ -597,7 +597,7 @@ mipi_phy: mipi-video-phy {
 			#phy-cells = <1>;
 		};
 
-		dsi@14500000 {
+		dsi: dsi@14500000 {
 			compatible = "samsung,exynos5410-mipi-dsi";
 			reg = <0x14500000 0x10000>;
 			interrupts = <GIC_SPI 82 IRQ_TYPE_LEVEL_HIGH>;
diff --git a/arch/arm/boot/dts/exynos5800.dtsi b/arch/arm/boot/dts/exynos5800.dtsi
index 526729dad53f..8328ddb3b02f 100644
--- a/arch/arm/boot/dts/exynos5800.dtsi
+++ b/arch/arm/boot/dts/exynos5800.dtsi
@@ -148,6 +148,10 @@ opp-200000000 {
 	};
 };
 
+&dsi {
+	compatible = "samsung,exynos5422-mipi-dsi";
+};
+
 &mfc {
 	compatible = "samsung,mfc-v8";
 };
-- 
2.39.0

