Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1EF3C671916
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Jan 2023 11:37:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229949AbjARKhw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Jan 2023 05:37:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230229AbjARKfu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jan 2023 05:35:50 -0500
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4DAC949431
        for <linux-kernel@vger.kernel.org>; Wed, 18 Jan 2023 01:42:50 -0800 (PST)
Received: by mail-wm1-x32a.google.com with SMTP id k22-20020a05600c1c9600b003d1ee3a6289so1041598wms.2
        for <linux-kernel@vger.kernel.org>; Wed, 18 Jan 2023 01:42:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jaewd2L8TgxgXbB/K1HfRKTMQWLJEFmYWcmTBCa0RC8=;
        b=GU1REnZEAYxr5gnK/c11uqhYCCvVTzCtMtRsedU7qTu3etvRaFM1ZpHmrFwef2sDKL
         ap5NSkPQoah09uVlxszezdLRT8XvN4PxInmt3rotCChRa+pYfQGhkD8zEIvA9b4kqLg5
         QcN1ZUwhPHvgXsvfgR8agOl8RabEUfqje9SqpU6eU6FZTq4dWTue76QAGOS5La0N4wjV
         +6c8vbKv9qX1cFyMaZDjR9YdkH1hxclBB6JO+HzQL4CNEz5sGk4gD5JHAvX/MpIt/m5A
         c+nsL+z0hsLecaXXE3jbxUqXeVw8Rta5e2n7qsm9YZQs+LrTD+I50DWe6Yk8yi7uzXsG
         Oqng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jaewd2L8TgxgXbB/K1HfRKTMQWLJEFmYWcmTBCa0RC8=;
        b=N3nJDTgRvAPzinrcZUav0B2nSx8h/TLhwPvYWKhmZ4dEsrfpza8i3jqI6ldleXW7td
         JqVbqq4J8fJ/oxZT2hgvn7GmSBtJd2Dqkcz0hMTtH65uqhPJWRnrUeETD9uMm2ibctMC
         ARDjUqW2m0Q1aKoYtIs3AyOvUtbKJJ10u37GCGOZMDLJ296ZGrh4Yl7rpP5TXA9qa8Rq
         hgZHQARw6wuXGnvx1DxhnRm34fqbMGQOiOHlj8y20xG4VKgApIfW/Sa6sCZoKxHSvh1b
         AlyzmfZqVnUbPYcgpvdl8RrhSvwegUnQAg4w8qfFp9U58s0y2eiA+8y+XmQF/NqIbJvD
         i+Hg==
X-Gm-Message-State: AFqh2kqgYdDseDTtpNdoblfA1hNiKGyiU0SDWyuvGPK5MGJYL9DIlOIn
        LJiaJ+7VCrHmjFieRgL7vSyUDg==
X-Google-Smtp-Source: AMrXdXsBHwdvsYNou+cx4ItMPakpwEYAvNSUrq6Eo3TSnH7kFKV3tUETdCHSxQQuIiBLaZLQbHBpYw==
X-Received: by 2002:a05:600c:2284:b0:3d3:5c21:dd9d with SMTP id 4-20020a05600c228400b003d35c21dd9dmr6009243wmf.19.1674034955224;
        Wed, 18 Jan 2023 01:42:35 -0800 (PST)
Received: from krzk-bin.. ([178.197.216.144])
        by smtp.gmail.com with ESMTPSA id m13-20020adfe94d000000b002714b3d2348sm30972662wrn.25.2023.01.18.01.42.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Jan 2023 01:42:33 -0800 (PST)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH v2 3/3] arm64: dts: qcom: sc8280xp: drop unused properties from tx-macro
Date:   Wed, 18 Jan 2023 10:42:24 +0100
Message-Id: <20230118094224.51704-3-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230118094224.51704-1-krzysztof.kozlowski@linaro.org>
References: <20230118094224.51704-1-krzysztof.kozlowski@linaro.org>
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

tx-macro does not have children and does not allow address/size cells:

  sc8280xp-crd.dtb: txmacro@3220000: Unevaluated properties are not allowed ('#address-cells', '#size-cells' were unexpected)

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>

---

Changes since v1:
1. Add Rb tag.
2. Split from SDM845 audio patchset, so this can easily be picked up.
---
 arch/arm64/boot/dts/qcom/sc8280xp.dtsi | 2 --
 1 file changed, 2 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/sc8280xp.dtsi b/arch/arm64/boot/dts/qcom/sc8280xp.dtsi
index fb1aa08c2524..bc698e417fae 100644
--- a/arch/arm64/boot/dts/qcom/sc8280xp.dtsi
+++ b/arch/arm64/boot/dts/qcom/sc8280xp.dtsi
@@ -1789,8 +1789,6 @@ txmacro: txmacro@3220000 {
 			clock-output-names = "mclk";
 
 			#clock-cells = <0>;
-			#address-cells = <2>;
-			#size-cells = <2>;
 			#sound-dai-cells = <1>;
 		};
 
-- 
2.34.1

