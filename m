Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E6C3E68F477
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Feb 2023 18:27:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230482AbjBHR1R (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Feb 2023 12:27:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230477AbjBHR1N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Feb 2023 12:27:13 -0500
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8FB90A5E3
        for <linux-kernel@vger.kernel.org>; Wed,  8 Feb 2023 09:26:48 -0800 (PST)
Received: by mail-wm1-x336.google.com with SMTP id az4-20020a05600c600400b003dff767a1f1so2043784wmb.2
        for <linux-kernel@vger.kernel.org>; Wed, 08 Feb 2023 09:26:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=PTB+kn5OHzrK76DFGgifiq/bBOHjSff6c06ytq0LeG8=;
        b=PJQHQB6suTprZ+B5q6crGllreJnIOzwF6L1019hH/KbIaQN5LVKFUiQb34RosXdyIe
         rptvHTsnKteguT0OO4GwP2rRGYxxRrit1lSjPk1DkUo6RlEzdWcHORq8ukghwDKEdRBA
         gQBup0PxXlYGmyXrFynoZkmYkM8HResj1oW+QsgigDgz9pacJOw6Fu9EmT9XXynr4xqN
         otrH3E0RqTKtT7f7Iuhk6ZT4tM7GfhWi/Sm/03qC8zP5BeWVdAaxofCwLFCyhLqjr5+i
         RBJwHAzfXA5wZC/GFUY3Jkhy4N1sUmEd+WGmgy7ezv4fCmppUjfKTfcjdAZT/sSHP1Rz
         3fGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PTB+kn5OHzrK76DFGgifiq/bBOHjSff6c06ytq0LeG8=;
        b=ok5eLzwTybwvqOZA992W2zt+6ei4O0Cra507PGbrK3/Gd659mbSzgN0ACHo1CWp14Z
         z6XS87yhQAQphwFofOjdhcT6XSnJtXr2ohi251O2RrDSqQi7WjPQogJe0nMM6IR4r3Pg
         Oap3CQhzgd2ewklsPP89fk6I1a0lB75p+nTWCY2r9EyMOhMF+lwZqizNMp5Zq4xgDyNU
         KAWmeXAaGFgwR9cdJc07on/t80/VSeZgGNRbUnWBxNU2WsTsc5vXndMMQNm6GC4IgJ6u
         iFR3GjODyAqFWydtdlZi14DQwmE/GJhzNNw/KkkKUPo62aSr3v5cJhcOoo3lgbdJ3mhh
         gjJA==
X-Gm-Message-State: AO0yUKUCG725+EBUxfz3mEqU6RETCindFvTU8Pqo/uhdqfOKSJDnFw7j
        73QSXZjIsJRTMrI79hZcNCmRMg==
X-Google-Smtp-Source: AK7set870vm3+lGW8S93Tx7ST0ROVr/EZF9AnP+//pii2ImLkyUNYR9v3kXSy0jlT23mL7LhhdcJIQ==
X-Received: by 2002:a05:600c:16c8:b0:3e0:185:e935 with SMTP id l8-20020a05600c16c800b003e00185e935mr7214991wmn.36.1675877204933;
        Wed, 08 Feb 2023 09:26:44 -0800 (PST)
Received: from krzk-bin.. ([178.197.216.144])
        by smtp.gmail.com with ESMTPSA id h1-20020a05600c2ca100b003dc3f3d77e3sm2624502wmc.7.2023.02.08.09.26.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Feb 2023 09:26:44 -0800 (PST)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        replicant@osuosl.org, phone-devel@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht,
        =?UTF-8?q?Martin=20J=C3=BCcker?= <martin.juecker@gmail.com>,
        Henrik Grimler <henrik@grimler.se>
Subject: [RFT PATCH 1/3] ARM: dts: exynos: add "gpios" suffix to wlf,ldo1ena on Midas
Date:   Wed,  8 Feb 2023 18:26:32 +0100
Message-Id: <20230208172634.404452-1-krzysztof.kozlowski@linaro.org>
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

The GPIOs properties should end with "gpios" suffix and Linux gpiolib
already handles both names, so switch to preferred one.

While touching the lines, replace open-coded GPIO_ACTIVE_HIGH flag.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 arch/arm/boot/dts/exynos4412-midas.dtsi | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/exynos4412-midas.dtsi b/arch/arm/boot/dts/exynos4412-midas.dtsi
index d5074fa57142..525f945c4b91 100644
--- a/arch/arm/boot/dts/exynos4412-midas.dtsi
+++ b/arch/arm/boot/dts/exynos4412-midas.dtsi
@@ -653,8 +653,8 @@ wm1811: audio-codec@1a {
 		CPVDD-supply = <&vbatt_reg>;
 		SPKVDD1-supply = <&vbatt_reg>;
 		SPKVDD2-supply = <&vbatt_reg>;
-		wlf,ldo1ena = <&gpj0 4 0>;
-		wlf,ldo2ena = <&gpj0 4 0>;
+		wlf,ldo1ena-gpios = <&gpj0 4 GPIO_ACTIVE_HIGH>;
+		wlf,ldo2ena-gpios = <&gpj0 4 GPIO_ACTIVE_HIGH>;
 	};
 };
 
-- 
2.34.1

