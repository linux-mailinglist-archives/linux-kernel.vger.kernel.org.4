Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2CBD6676912
	for <lists+linux-kernel@lfdr.de>; Sat, 21 Jan 2023 21:17:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229936AbjAUURL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 21 Jan 2023 15:17:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229493AbjAUURI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 Jan 2023 15:17:08 -0500
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD0E02311B;
        Sat, 21 Jan 2023 12:17:07 -0800 (PST)
Received: by mail-ed1-x532.google.com with SMTP id y11so10335371edd.6;
        Sat, 21 Jan 2023 12:17:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CH5ssNbMjjziLJwNcTMZ2d/eFIt2gMohhe8o5T2jQ1M=;
        b=Dv0b6ksBdcZ72PXJRcORAxnH0Iq1zuAyzyqI5LMnojaZXSC0kZdyTqXwLVlAalC+UJ
         SSYvgkG4A/QFPzDQKCUOiQCcFLbLJuzY944fdAEgdiwuN+ny16nJJAXvqRbgNp80U4ju
         Za/N7cpkvQtXHCAd1n9k8SM2acfBRiPGktOwlKA53S7IZ7tcqUOQ4JLl9NbbL1yhzycK
         KwxLpk3ymGjR+UnXczeQ2/FmonNY5wXKJ81wcddvJ2/sWgpBV4XCRkMoxnrLKUcI19LZ
         wJ8g47AQOvhce0mGA+PPUWxm5h+fs8+8fo+5ggNMDfkyMzDmLVSAH86AdP0l3Lnurfti
         q00Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CH5ssNbMjjziLJwNcTMZ2d/eFIt2gMohhe8o5T2jQ1M=;
        b=WGXN/WF0W5pLZCNZKwQPHwgiq4OhX1tQkrPrpRKg/NiXUBFiKxKUuFMJ4gbEne6qPV
         MyhGg+hwJKkVSbCNnGkUH0Fa0gIPirCYvr/jtilnBwzdiL4o/zi+pAcCU7FmyMcgf35g
         7vK6OnW//UVi/BckhrWDueaFayr3yGYV8NE5pnykwxxrh1EWu+2k4OiWJAoeoxs7SN4O
         NxXPvRI4jjMdIz414mHMEoIaAElfUwg+A/5Q6cg08liJiphnYg5XOtHVVSPDXPeO/d+v
         zQcQZmwGAo/OKxlVe/4i84hWhjwpuOho1vLJvcOdOKuqPE+rrB1XIYFKb9//UlZBBFQR
         +QDA==
X-Gm-Message-State: AFqh2krIBSSvpwxcbfd5+dWUjE8L65G8dTwrV0GGUcnr5SxVna06Qy7D
        X4gFUsBP4OA6lIDYrjw7g4lQALXiaID6kA==
X-Google-Smtp-Source: AMrXdXv89ONZz3LcxEWaKL43u1skuqG9qemHpKY74Z6CbJH6SiaDeaJuoUSKdDPdUTh27n2eDI/01A==
X-Received: by 2002:a05:6402:43c4:b0:49e:8425:6033 with SMTP id p4-20020a05640243c400b0049e84256033mr9862767edc.28.1674332225921;
        Sat, 21 Jan 2023 12:17:05 -0800 (PST)
Received: from localhost.localdomain ([194.39.226.133])
        by smtp.gmail.com with ESMTPSA id g8-20020aa7d1c8000000b0049e1f167956sm8278427edp.9.2023.01.21.12.17.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 21 Jan 2023 12:17:05 -0800 (PST)
From:   Markuss Broks <markuss.broks@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     Markuss Broks <markuss.broks@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>,
        soc@kernel.org, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-samsung-soc@vger.kernel.org
Subject: [PATCH 2/2] arm: dts: exynos5800: Use Exynos5422 compatible for the DSI controller
Date:   Sat, 21 Jan 2023 22:16:49 +0200
Message-Id: <20230121201650.46560-3-markuss.broks@gmail.com>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230121201650.46560-1-markuss.broks@gmail.com>
References: <20230121201650.46560-1-markuss.broks@gmail.com>
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

