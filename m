Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E87168F2C7
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Feb 2023 17:05:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230025AbjBHQFC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Feb 2023 11:05:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229936AbjBHQEp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Feb 2023 11:04:45 -0500
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 646F64ABDE
        for <linux-kernel@vger.kernel.org>; Wed,  8 Feb 2023 08:04:28 -0800 (PST)
Received: by mail-wm1-x32e.google.com with SMTP id n13so13658932wmr.4
        for <linux-kernel@vger.kernel.org>; Wed, 08 Feb 2023 08:04:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=R0rE8Lb8ibUWc7kHbj+yZ/hofiyZLCvQRtWGXPk+RRQ=;
        b=ivA9vXJ5HErZ0jSUfWbxaanTS4VhVkXF/+qTcymMgj2HsI5SbC7CpaYW1pVlAA630r
         0IybXgqzE55NBFLpmYl5ZZSOgyqHVSst5nvPe4rJN3k5VBQbyuk+fJPWA7KJ7vJe6dy3
         97t302+R2DeFQ4SzMmMzyvYe20bJ39BWP48Vrz3M75cNKSGw7Gi5SRJcZ5ZTMlm53LQD
         VD1hh1cu9O/BDwVEbIwGoDKPeF/SZ5fj45bmGWM/iASCrQomNJYrV3ylj2J+meWZmHmP
         TR1YKapAr8sFwrcS4lGUz3Yc2I4vNz3USDptOt73CSR/eai7fpemnOfDe/XYxIfYkWjJ
         5VGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=R0rE8Lb8ibUWc7kHbj+yZ/hofiyZLCvQRtWGXPk+RRQ=;
        b=bECk4IJqij3aHEn1uCMK9n5cqbCfQ704qdSnI4uINQK60+DTZRu1Nquz2a0+e91Lzg
         9qXMUt9XYsdSooP7RkLIHkR6cg987lnXJsJYBC94V/BqMUxKuU76tLqCi8P5zS0MpgTM
         5NjD1SnNflsikiIW9lLWCAq7Sp/dgF4N2X30mCjlkkE/jDrV9VLvtXZXE1JU4960G/8K
         0/06VVZ1/vB0rVOShi33pl59u1zRGRFKuD6HrkTYLRRe3YolkZTtto8kmzDk2d2Da16q
         ky2gGoSdfIPzCRcDHQp9pF+Bmguus0TodkAQjY5SF0vBrBAE4a62EZop7PJ60xXoqwR9
         DBVw==
X-Gm-Message-State: AO0yUKUx2XtCJMxkNW8xsGBd/rQ2pCk3WvihhBd2GQ6Sq7M85+y5jWMx
        gsbouXL/M6Ft8AaP7w1XsxTDAg==
X-Google-Smtp-Source: AK7set+OvUX1Ujsg0vDVzePW1OFuWxgWdPpykyHrq3lV5Zs0mUMc2DcbvEzHzoz7hTiJh35Cni1OOA==
X-Received: by 2002:a05:600c:4919:b0:3df:f2a5:49fb with SMTP id f25-20020a05600c491900b003dff2a549fbmr6719356wmp.7.1675872266974;
        Wed, 08 Feb 2023 08:04:26 -0800 (PST)
Received: from krzk-bin.. ([178.197.216.144])
        by smtp.gmail.com with ESMTPSA id r3-20020a05600c424300b003dc492e4430sm2114847wmm.28.2023.02.08.08.04.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Feb 2023 08:04:26 -0800 (PST)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH] ARM: dts: exynos: correct max98090 DAI argument in Snow
Date:   Wed,  8 Feb 2023 17:04:24 +0100
Message-Id: <20230208160424.371678-1-krzysztof.kozlowski@linaro.org>
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

The max98090 has only one DAI and does not take argument to DAI
phandles:

  exynos5250-snow-rev5.dtb: audio-codec@10: #sound-dai-cells:0:0: 0 was expected

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 arch/arm/boot/dts/exynos5250-snow-rev5.dts | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/exynos5250-snow-rev5.dts b/arch/arm/boot/dts/exynos5250-snow-rev5.dts
index 0a47597d6f0d..3d32c3476e84 100644
--- a/arch/arm/boot/dts/exynos5250-snow-rev5.dts
+++ b/arch/arm/boot/dts/exynos5250-snow-rev5.dts
@@ -27,7 +27,7 @@ cpu {
 		};
 
 		codec {
-			sound-dai = <&max98090 0>, <&hdmi>;
+			sound-dai = <&max98090>, <&hdmi>;
 		};
 	};
 };
@@ -42,7 +42,7 @@ max98090: audio-codec@10 {
 		pinctrl-0 = <&max98090_irq>;
 		clocks = <&pmu_system_controller 0>;
 		clock-names = "mclk";
-		#sound-dai-cells = <1>;
+		#sound-dai-cells = <0>;
 	};
 };
 
-- 
2.34.1

