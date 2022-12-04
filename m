Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 25D9E641CB4
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Dec 2022 12:39:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230122AbiLDLjD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 4 Dec 2022 06:39:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230029AbiLDLis (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Dec 2022 06:38:48 -0500
Received: from mail-lj1-x232.google.com (mail-lj1-x232.google.com [IPv6:2a00:1450:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33BFE17AAE
        for <linux-kernel@vger.kernel.org>; Sun,  4 Dec 2022 03:38:46 -0800 (PST)
Received: by mail-lj1-x232.google.com with SMTP id a19so10515605ljk.0
        for <linux-kernel@vger.kernel.org>; Sun, 04 Dec 2022 03:38:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=A/pyD6f/Bd5araMX2BGAQkyHpIILubF0UH36/Nqyung=;
        b=pw+/weV8273mc7WQRhOCz/fEmRatku/+mzB7uNOZ2IgDyxteXWbePyBdLhwP5Ky4GZ
         WvYGMOmrTOnelA+B6wKLGtkoy7R0aoCBtiqwwWQ3CLSowrMihPQKhUsbHHQZGLt3T7d9
         05z9BJFi9WffNpdIO0N7D4F9buOBtSfQsHFRhN1L0xgo+ki0OHFqRI+7Px1i3oPJCTt1
         8X6CjYppXj+cekpDrUasxP/IVLKAuOk01pw/dz+89sLkJdjqFSETPdNUUsj8pLvjFC07
         o7oiztrKS7KG2V7ATFuy6K1CNVaHkC/MINf3U1aGo1EHrXO5kRgKcND2whFi8k6icmUR
         dX5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=A/pyD6f/Bd5araMX2BGAQkyHpIILubF0UH36/Nqyung=;
        b=ST2/Znl09ruz5GvdrNvEyuQ99Xl/M9FmXDn6qilt3nrAo9MLq6hGFG9I7Yxle6uOfl
         bnYP0aPjZxPpyZRYrt6VZn/vBT/yn3a5jwMAIwI3k+YwPAabrNjYFyhp5dtH1SA/sCag
         zGZJAm5+luRd5qhogPrAziw5wp0QC9DHG+jHV26lIgK9bT9X6Bwf6uDwtxTfps6Gt7sm
         v3bNlS9I2u0NP+XNqv3F4d5S+3IoIu+Zhe2YS5Zt5p3tA4uGHW8VB0daO92g/HmdrI/J
         k6oyKGtGkwux/9pNAUMN9+1tSoXZy1gGeUH7BS+LG+aLthU6CufvnRagMZQpdSoby36f
         +43Q==
X-Gm-Message-State: ANoB5pnc8woOQw7euWjMqizPYJuKON9RXdlEiKa1wkR87tXLl6kLwFDL
        Q4HjkSshSQRdG0Pi67o9VKDQ/A==
X-Google-Smtp-Source: AA0mqf4/SRU0PT5ngN26z9s2HHADkNm5cfxKllkHevCCEQyyIIa4Qu5B/KQUe2w5hnwORb6RgA2Fjw==
X-Received: by 2002:a05:651c:905:b0:26d:d0d2:2ef5 with SMTP id e5-20020a05651c090500b0026dd0d22ef5mr26291598ljq.369.1670153924584;
        Sun, 04 Dec 2022 03:38:44 -0800 (PST)
Received: from krzk-bin.NAT.warszawa.vectranet.pl (088156142067.dynamic-2-waw-k-3-2-0.vectranet.pl. [88.156.142.67])
        by smtp.gmail.com with ESMTPSA id a11-20020ac25e6b000000b0048a9e899693sm1762826lfr.16.2022.12.04.03.38.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 04 Dec 2022 03:38:44 -0800 (PST)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH RFT 3/3] arm64: dts: exynos: correct properties of MAX98504 in TM2
Date:   Sun,  4 Dec 2022 12:38:39 +0100
Message-Id: <20221204113839.151816-3-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221204113839.151816-1-krzysztof.kozlowski@linaro.org>
References: <20221204113839.151816-1-krzysztof.kozlowski@linaro.org>
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

Drop unused and unsupported MAX98504 amplifier properties (maxim,rx-path
and similar) and add two supplies.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 arch/arm64/boot/dts/exynos/exynos5433-tm2-common.dtsi | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/arm64/boot/dts/exynos/exynos5433-tm2-common.dtsi b/arch/arm64/boot/dts/exynos/exynos5433-tm2-common.dtsi
index a8224b3123d4..6f701297a665 100644
--- a/arch/arm64/boot/dts/exynos/exynos5433-tm2-common.dtsi
+++ b/arch/arm64/boot/dts/exynos/exynos5433-tm2-common.dtsi
@@ -96,10 +96,10 @@ i2c_max98504: i2c-gpio-0 {
 		max98504: amplifier@31 {
 			compatible = "maxim,max98504";
 			reg = <0x31>;
-			maxim,rx-path = <1>;
-			maxim,tx-path = <1>;
-			maxim,tx-channel-mask = <3>;
-			maxim,tx-channel-source = <2>;
+
+			DIOVDD-supply = <&ldo3_reg>;
+			DVDD-supply = <&ldo3_reg>;
+			/* PVDD-supply to VPH_PWR */
 		};
 	};
 
-- 
2.34.1

