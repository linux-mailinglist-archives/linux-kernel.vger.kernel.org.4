Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A9B9274500D
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Jul 2023 20:53:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230261AbjGBSxj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 2 Jul 2023 14:53:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230316AbjGBSxc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Jul 2023 14:53:32 -0400
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 094AD1B6
        for <linux-kernel@vger.kernel.org>; Sun,  2 Jul 2023 11:53:09 -0700 (PDT)
Received: by mail-ej1-x62f.google.com with SMTP id a640c23a62f3a-992ace062f3so447563666b.2
        for <linux-kernel@vger.kernel.org>; Sun, 02 Jul 2023 11:53:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1688323976; x=1690915976;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=tgC5G6Tgwd58MYPb/kPelTKoJa9t4jd7ti9GD2J7b6w=;
        b=tsKBdME9nVegTtxrZhfmfNqghqFf3+NckytKQIponU6qCjMHmb9QMSAosVW2JlqRBl
         0hHRmZPOk1tUnj2Ok5h97jYopgRuWInYFZMlWlB1f+6KgDagTRDOM8R509LdmiFDAsos
         l8gNAp/Acz9Ke0hbeRWd0SqJrVBpCtyS7kDAJoFCxFOXeJ3BEWq2/JtHhyywQBRNPXnQ
         4bxWFlpJn49b+p1sjjwHZvcM5X2CH7DHU+gxOM1zn0MM02l47UrHfj0QEmGu1irWG+54
         QJsnxR9qIDDievWCBl5fEk4Kr4y1xnAOF8zEI1GTbEG9aZGRTpLxkI5OsWaOj8oYnWJG
         a8Fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688323976; x=1690915976;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tgC5G6Tgwd58MYPb/kPelTKoJa9t4jd7ti9GD2J7b6w=;
        b=PLna7wkmt0VxHfia05Vf1zt0Xzp0xboKmLxN4BhFMjPBEO21z/OnlJlWBcBMTMltAb
         GgrqR8u/dpT6c384Qk5+XJLgyoS+Ydp2D/ZBNKDQiJ7iG9k7P2Z7X2UkQryIwLEhulMn
         yCl8oXLJZPSKY660pyZ3gSAfBAfZKmQOoSgZ/mDDQPpWS8K1p4h1+40c8N/eQs0BcVvd
         geuOKp6/cZGTfIrJPMiip13W3l6Bp0t7mzVru3aknwJ4dtKK0CCv+6ghT1NpUHyE32m9
         HXksJ5d8f4sx02gu/gsB4xwUM/dNnbBp3qLFbku7dRcayMlsmini3QTEfmwvyOWrFcfE
         npQw==
X-Gm-Message-State: ABy/qLYU0R9CXk7aPUbenOpNORJx1GZ7xeuUNPrHZbYnNRDnM145+BRh
        CsMdKo7MmbVjpGLy7f8pUVk0Ruu1xuU0EHZn7ZPotg==
X-Google-Smtp-Source: APBJJlFE4FCS2v9mPTPpDeuJJa3ynNZEopLYJXjYfMyMhMdYn8+YtSzBAXuXH0D/43/p/1JSJaB+Xw==
X-Received: by 2002:a17:906:c284:b0:98d:63c5:d147 with SMTP id r4-20020a170906c28400b0098d63c5d147mr6070561ejz.47.1688323976072;
        Sun, 02 Jul 2023 11:52:56 -0700 (PDT)
Received: from krzk-bin.. ([217.169.179.6])
        by smtp.gmail.com with ESMTPSA id gx23-20020a170906f1d700b00992dcae806bsm3738444ejb.5.2023.07.02.11.52.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 02 Jul 2023 11:52:55 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Geert Uytterhoeven <geert+renesas@glider.be>,
        Magnus Damm <magnus.damm@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        linux-renesas-soc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH] arm64: dts: renesas: minor whitespace cleanup around '='
Date:   Sun,  2 Jul 2023 20:52:52 +0200
Message-Id: <20230702185252.44462-1-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The DTS code coding style expects exactly one space before and after '='
sign.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 arch/arm64/boot/dts/renesas/r8a77990.dtsi | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/renesas/r8a77990.dtsi b/arch/arm64/boot/dts/renesas/r8a77990.dtsi
index 1be0b99c15ed..4c545eff9b42 100644
--- a/arch/arm64/boot/dts/renesas/r8a77990.dtsi
+++ b/arch/arm64/boot/dts/renesas/r8a77990.dtsi
@@ -76,7 +76,7 @@ a53_0: cpu@0 {
 			enable-method = "psci";
 			cpu-idle-states = <&CPU_SLEEP_0>;
 			dynamic-power-coefficient = <277>;
-			clocks =<&cpg CPG_CORE R8A77990_CLK_Z2>;
+			clocks = <&cpg CPG_CORE R8A77990_CLK_Z2>;
 			operating-points-v2 = <&cluster1_opp>;
 		};
 
@@ -88,7 +88,7 @@ a53_1: cpu@1 {
 			next-level-cache = <&L2_CA53>;
 			enable-method = "psci";
 			cpu-idle-states = <&CPU_SLEEP_0>;
-			clocks =<&cpg CPG_CORE R8A77990_CLK_Z2>;
+			clocks = <&cpg CPG_CORE R8A77990_CLK_Z2>;
 			operating-points-v2 = <&cluster1_opp>;
 		};
 
-- 
2.34.1

