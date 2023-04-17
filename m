Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7929A6E423F
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Apr 2023 10:10:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230509AbjDQIKF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Apr 2023 04:10:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230349AbjDQIJ5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Apr 2023 04:09:57 -0400
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6889249F2
        for <linux-kernel@vger.kernel.org>; Mon, 17 Apr 2023 01:09:56 -0700 (PDT)
Received: by mail-ej1-x62e.google.com with SMTP id a640c23a62f3a-94a34a0baf9so568380266b.1
        for <linux-kernel@vger.kernel.org>; Mon, 17 Apr 2023 01:09:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1681718995; x=1684310995;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KKWm9tEgyLkR2LrDnQHya00CgrTHhk53PFAbFDMhV/g=;
        b=B7Jy2H2honXINw+ZyKlDZu8ykacocrKoafXsSfM04UNh+3rQxCQk9Z3cVoR/NpXIwF
         EeB7qG3SsqJhXIrnNFEPGiDTbE7JeCqMV7+8Ry7vOojQ4WInhuftMB0f634vaVCWwCzO
         i+46KIRqJfM8FIv1kwLP+cX0hz9DYipNstVuUNSUyVusmBEDbe2yzhJkPvN6gy2Ns4LF
         iat1gm1dEfXIbl4xyM8BLRQBd+KV3XuHl2sj4eNkqNF85jFTV+yI+v3aL9JCqe9+QAU2
         IJQvJsGOAWz+Qf1oqw8pHncMSZ5jiUVUAb4hfjiA5dbRHaygG9y93MvLwdxQ4dEQVaov
         Jx0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681718995; x=1684310995;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KKWm9tEgyLkR2LrDnQHya00CgrTHhk53PFAbFDMhV/g=;
        b=L977/MzEr6nU6f4FqNmoV0if84EGMAWayNTX3+XxZua1Wma8cBgluew2KHoIFZAGDL
         bviVi0upoTDUE0ww9NI+tZJQmCsRTHk35j7qKAP+3rzs9oyUbQgk5APyd9rDc5owVRg1
         qRoZQRaoGyHGTc2drkJnczu9RsPJ4rY/ZtcB9D2Z2ZXDG7O9eItziRJlQFyaLCfV0JW4
         xSMfrXTb0n1iBe3cJbPBk5M7/zCmoYiFHR2oCLlSAeNMrlQis9ccou9GXDxR/02eExmS
         2DACHpp6SlfYsOSPO0oXNzMbBkQYAbW39zrHPHimW5hadKM0DogPHV+JXyvAK/yl3Vcw
         bing==
X-Gm-Message-State: AAQBX9dGNgtzbsNFFATB3LG8hkpb4pL/KyP8r47aTeDdX1LkFoIPnPx1
        VSizJ+MyuqJga2RhFLpfD44NTg==
X-Google-Smtp-Source: AKy350b5O70x9rSXlvv0IH1MJwhhc2u8oY86o0yE6bYOh0NvmCEENY7YMCcPUb6amzh642sqxwA3pA==
X-Received: by 2002:a05:6402:1281:b0:505:31e:7968 with SMTP id w1-20020a056402128100b00505031e7968mr12322714edv.22.1681718994833;
        Mon, 17 Apr 2023 01:09:54 -0700 (PDT)
Received: from krzk-bin.. ([2a02:810d:15c0:828:b0ac:4d3b:966c:b33d])
        by smtp.gmail.com with ESMTPSA id y16-20020a1709064b1000b0094f7da9f1besm988179eju.61.2023.04.17.01.09.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Apr 2023 01:09:54 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH v2 4/4] arm64: dts: qcom: sc8280xp: correct GIC child node name
Date:   Mon, 17 Apr 2023 10:09:39 +0200
Message-Id: <20230417080939.28648-3-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230417080818.28398-1-krzysztof.kozlowski@linaro.org>
References: <20230417080818.28398-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

GIC child node is supposed to be named msi-controller:

  sa8295p-adp.dtb: interrupt-controller@17a00000: gic-its@17a40000: False schema does not allow

Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>
Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

---

Changes since v1:
1. Add Rb tag.
---
 arch/arm64/boot/dts/qcom/sc8280xp.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/qcom/sc8280xp.dtsi b/arch/arm64/boot/dts/qcom/sc8280xp.dtsi
index a4e52fb72710..d999d1799f52 100644
--- a/arch/arm64/boot/dts/qcom/sc8280xp.dtsi
+++ b/arch/arm64/boot/dts/qcom/sc8280xp.dtsi
@@ -3904,7 +3904,7 @@ intc: interrupt-controller@17a00000 {
 			#size-cells = <2>;
 			ranges;
 
-			gic-its@17a40000 {
+			msi-controller@17a40000 {
 				compatible = "arm,gic-v3-its";
 				reg = <0 0x17a40000 0 0x20000>;
 				msi-controller;
-- 
2.34.1

