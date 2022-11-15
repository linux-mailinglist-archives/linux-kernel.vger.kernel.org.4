Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E2EB86299B3
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Nov 2022 14:09:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231179AbiKONJu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Nov 2022 08:09:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229970AbiKONJq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Nov 2022 08:09:46 -0500
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D43DB0B
        for <linux-kernel@vger.kernel.org>; Tue, 15 Nov 2022 05:09:45 -0800 (PST)
Received: by mail-ej1-x631.google.com with SMTP id y14so35892488ejd.9
        for <linux-kernel@vger.kernel.org>; Tue, 15 Nov 2022 05:09:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Sb7kVf2+cqbh9c9psQ+6IfpJ5bt8QizDspR3uCbRadE=;
        b=Ash/+IeUau8JlbOAS5SVeURaST37KmVAeD66Hu+ndKpbBAcHA+66DJ3syXsFz2fJzd
         GdNYqZYvBMXvlmrFxevapGYxwlBaCDHlyxP8+P2TX+Zn49hgN00hTALMJsM/Lzsbag5P
         WJpE3hCVHCh/yCEZkTnhTUajf9seqyhLyqO2igOX5yliYFf9j1KDz6DvGA2WQlDOiMfM
         jBM33M6saVOzMGYmp5Duf81TCCnvrF5uk8/+fMvv/aSOHzX92OdeuF42cllG82fM69tR
         0sNrxMUA+K3m5upwZua154rca5QZ4OWzYw4FEq9W7Ne1tFZqf9oMbxxdHX9b1h04ajco
         E9Ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Sb7kVf2+cqbh9c9psQ+6IfpJ5bt8QizDspR3uCbRadE=;
        b=U5jqAo/p3SEDZ2eADQ2W8QfQ7Ck9ri42Me1DOVofNNIkVa/yNXKKK3yJgWdCcNfGES
         nomXOmYzsKckdP84+HQ0CMI8OlWAW7eD4ePFEy242EC5pg4cxD/fZxRiNXZl/9qvPN8K
         Ai4HmW2DO/mqUboYyaCWmmv48Y6+j1JLnvOD0v2HnzD/pYyGPhcuMfHarcPiiXmm23e+
         Sq1V/HSU7n7Pn1/+T4iakNiEqLVgoXN2NEx7ZDfRouyzo0qQg+z3E+fgK7LWOcL3DrF7
         7UreyVgxmCD+ccSYYNSUkaO4mhIhVcDsmJYxTDWlhbpI2mguchbeBf/6ZPh1Bo3x9M3Z
         wy+g==
X-Gm-Message-State: ANoB5plopbWkgKSm2jT6SVIcU4rDr4JEZA7NMYr+u5Iky6Lact3PuN6e
        mm9MguPvWl3F54flis7/V7VETQ==
X-Google-Smtp-Source: AA0mqf4468CWGLHs6W4KOti6ysoSWIH4+Xunqum1zCCfrea6gy8s1qhIVS6jvy5k4sVqJzva+Xl7eA==
X-Received: by 2002:a17:906:53c7:b0:780:8144:a41f with SMTP id p7-20020a17090653c700b007808144a41fmr14284415ejo.189.1668517783752;
        Tue, 15 Nov 2022 05:09:43 -0800 (PST)
Received: from localhost.localdomain ([194.29.137.22])
        by smtp.gmail.com with ESMTPSA id ay26-20020a056402203a00b00461816beef9sm6093260edb.14.2022.11.15.05.09.42
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 15 Nov 2022 05:09:43 -0800 (PST)
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
To:     linux-arm-msm@vger.kernel.org, andersson@kernel.org,
        agross@kernel.org, krzysztof.kozlowski@linaro.org
Cc:     patches@linaro.org, Konrad Dybcio <konrad.dybcio@linaro.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] arm64: dts: qcom: sm8450: Use defines for power domain indices
Date:   Tue, 15 Nov 2022 14:09:35 +0100
Message-Id: <20221115130936.6830-1-konrad.dybcio@linaro.org>
X-Mailer: git-send-email 2.32.0 (Apple Git-132)
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use the defines from qcom-rpmpd.h instead of bare numbers for
readability.

Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
 arch/arm64/boot/dts/qcom/sm8450.dtsi | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/sm8450.dtsi b/arch/arm64/boot/dts/qcom/sm8450.dtsi
index 19a0f5033cc9..705e05588941 100644
--- a/arch/arm64/boot/dts/qcom/sm8450.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm8450.dtsi
@@ -2277,8 +2277,8 @@ remoteproc_mpss: remoteproc@4080000 {
 			clocks = <&rpmhcc RPMH_CXO_CLK>;
 			clock-names = "xo";
 
-			power-domains = <&rpmhpd 0>,
-					<&rpmhpd 12>;
+			power-domains = <&rpmhpd SM8450_CX>,
+					<&rpmhpd SM8450_MSS>;
 			power-domain-names = "cx", "mss";
 
 			memory-region = <&mpss_mem>;
-- 
2.38.1

