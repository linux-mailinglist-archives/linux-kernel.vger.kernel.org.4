Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4002E64CCD4
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Dec 2022 16:06:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238608AbiLNPGP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Dec 2022 10:06:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237778AbiLNPGM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Dec 2022 10:06:12 -0500
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59E8C1147D
        for <linux-kernel@vger.kernel.org>; Wed, 14 Dec 2022 07:06:11 -0800 (PST)
Received: by mail-lf1-x12f.google.com with SMTP id cf42so10962937lfb.1
        for <linux-kernel@vger.kernel.org>; Wed, 14 Dec 2022 07:06:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=m5UOweenssjuPFfHtO2azIhEx1ll4q21eV9Ps6cE+6E=;
        b=B2iZXPeemy1Ie27I0eHgcj8azEuur6S70JuRqfCT+LUrn2ygMgvQ3YyCwvAgam3qfr
         GHX4Pgvfzqig+QVS7uC/NzyPNNRomEfp1B/1boDsy6oFVY/1tsJKkaBns2a/cNksuM4B
         tF1LPK+GnIvoeVPY3TB7X2zbOVW6mBZWfGyeUlctApaUWpfcErnNzT1f8OKD7e/gl0Q0
         8SFAIkYA8VwFaIvmxzHtNXOIaBsUPrNyc/KztZdcFdSfG9oyQ9iCk1AT3LogkMsfxQan
         4rUx/r6sgTXDnwjndcLWYDk9VkEBUTG3SOK60SqjHiW8xlE0LaUck6KMSUnM3/gDcqBI
         3EaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=m5UOweenssjuPFfHtO2azIhEx1ll4q21eV9Ps6cE+6E=;
        b=J73ZmQOFrs/9ww2HjZu4Af9FHsYyoMcCsUxlnjrisSumyVCZWCw5J6wMM+4xCvAyoy
         Royezv0MElKlK1tDSqcfoM8kDVwjqNDN7ZPoc6tKkxJ4us7sK6tNxvZchGxdaXjYBgRg
         7ySR1UbARQGJ+ywyfSvw8LafcRC7JwXO+KlHD8uNfhulY67VXSTrhifjCArL6ewerF7Q
         wSGgRyzzSR3nobpL/Km9i3b5WdzAAICLSCqlAZnfcrnsLVQ+7xA1p8SOaUKrdhjkbQ6f
         6+ViwdQSFtamBAhgmhWWKYfXb2ZBLIp+vbnE3/kq72DkCSU5kJYSQrDfSxr+RI7SQsKh
         Abmg==
X-Gm-Message-State: ANoB5pldBW2zUGn3bV8Vv6R1J42IKw70SRm4K1RGLMb2Oor6mgKXw6bl
        fI6I4ea9Hb+DqfIf1swBD8EULg==
X-Google-Smtp-Source: AA0mqf6ywxwsv18d+/NiLvxVcMp6WumqgWoKopzGSaqzXt6FRMjCo6chgUESRLipjhj6nik9InkZAg==
X-Received: by 2002:a05:6512:21ac:b0:4b5:785b:1caf with SMTP id c12-20020a05651221ac00b004b5785b1cafmr6307684lft.36.1671030369516;
        Wed, 14 Dec 2022 07:06:09 -0800 (PST)
Received: from krzk-bin.NAT.warszawa.vectranet.pl (088156142067.dynamic-2-waw-k-3-2-0.vectranet.pl. [88.156.142.67])
        by smtp.gmail.com with ESMTPSA id t19-20020a19dc13000000b004972b0bb426sm840107lfg.257.2022.12.14.07.06.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Dec 2022 07:06:08 -0800 (PST)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH] dt-bindings: arm: qcom: add board-id/msm-id for MSM8956, SDM636 and SM4250
Date:   Wed, 14 Dec 2022 16:06:05 +0100
Message-Id: <20221214150605.173346-1-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
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

Allow qcom,board-id and qcom,msm-id leagcy properties on these older
platforms: MSM8956, SDM636 and SM4250.  Also mention more OnePlus
devices using modified qcom,board-id field.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 Documentation/devicetree/bindings/arm/qcom.yaml | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/qcom.yaml b/Documentation/devicetree/bindings/arm/qcom.yaml
index d45e2129fce3..cfb7f5caf606 100644
--- a/Documentation/devicetree/bindings/arm/qcom.yaml
+++ b/Documentation/devicetree/bindings/arm/qcom.yaml
@@ -925,15 +925,18 @@ allOf:
               - qcom,apq8026
               - qcom,apq8094
               - qcom,apq8096
+              - qcom,msm8956
               - qcom,msm8992
               - qcom,msm8994
               - qcom,msm8996
               - qcom,msm8998
               - qcom,sdm630
               - qcom,sdm632
+              - qcom,sdm636
               - qcom,sdm845
               - qcom,sdx55
               - qcom,sdx65
+              - qcom,sm4250
               - qcom,sm6125
               - qcom,sm6350
               - qcom,sm7225
@@ -957,6 +960,8 @@ allOf:
               - oneplus,dumpling
               - oneplus,enchilada
               - oneplus,fajita
+              - oneplus,oneplus3
+              - oneplus,oneplus3t
     then:
       properties:
         qcom,board-id:
-- 
2.34.1

