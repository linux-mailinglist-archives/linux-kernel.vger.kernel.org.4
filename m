Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0475E5BAD4F
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Sep 2022 14:21:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231520AbiIPMVk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Sep 2022 08:21:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231531AbiIPMVW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Sep 2022 08:21:22 -0400
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11599B14ED
        for <linux-kernel@vger.kernel.org>; Fri, 16 Sep 2022 05:21:15 -0700 (PDT)
Received: by mail-wm1-x330.google.com with SMTP id n8so8457452wmr.5
        for <linux-kernel@vger.kernel.org>; Fri, 16 Sep 2022 05:21:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=s2q2GhLpVfz2HreaKFxxQqbdd2/gRY5+cPvd0gHqtUM=;
        b=pXdp2gYt/E3X5A1iEsCGf9a/VG5uPhfqC/l4GMORAzbN6dYD/mZldd6UrzfnIQj6+v
         WNoE/OioyyYYBibILRu7ECc/l1e0udfZcG58fjQxO3nA5d84eEDDtRVLB9wZkTqJ39/7
         fJGkM34bmo08UK4kApzR7qJ/KkHqdNiUdlTgfKR1kAiM+hlAbjrzdRrfxmzCVtC98zq6
         Y1hF6MgdV/daj+XHK967sXOmxIW7iEf7Hx0svHDkyK8wyLY6gK03rZUV7zXsg9um0YIE
         Q0UhBUI7nSx45KtuttjnGi5t27jKsbDZ5/jsFMNfzQCOkwacgHkQezrHex7ZCZ/HO9xU
         V36w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=s2q2GhLpVfz2HreaKFxxQqbdd2/gRY5+cPvd0gHqtUM=;
        b=rqDwY9lmBuGSYuMxtHRtPSaHSV4+xXucHvoSBdk+1j/qTbR9BzpJJ6tPdcOvCaDfDD
         8wwLyU9vPf+Yu/YiyIjKkBcciB7Df5CkN1HX2RTm6yBonPD3xvBgYL5XpaPUX3LU3ISo
         CPRO7rr/CFl0VXBfbEiAc5pJjYv/xVSpn//JXADXkERKcLiRwhKRXitfY4Cm8SEzbEDS
         HWCU7nSLBDwVUb38qHMbSmfElb/jAEJN7nKUC/kuUd4yrY5rn23Zq/mtk2a8jgwQH21y
         5dhlvDvJ+3BmYkHj+o74uFlC00bxz/b9DsuDpS5LVPsMyoHj/KjxSyipLRq3ETvkBflS
         htYg==
X-Gm-Message-State: ACgBeo3Ui+8M4+FxtwqOK0h/VOSUlK3gioojMynhLXPZ1TbStPVHtCl0
        eBhdTMwjzKMqvBCAW7tFhTE19A==
X-Google-Smtp-Source: AA6agR7hYqWY2cOpTuVv/zCjt4nFs7uJnCuK8Tf8oQ10AQ+ZubcUFwKT56gtfbZI8USmeXMh5K8hkA==
X-Received: by 2002:a05:600c:35d2:b0:3b4:a897:d48 with SMTP id r18-20020a05600c35d200b003b4a8970d48mr6669891wmq.48.1663330873513;
        Fri, 16 Sep 2022 05:21:13 -0700 (PDT)
Received: from srini-hackbase.lan (cpc90716-aztw32-2-0-cust825.18-1.cable.virginm.net. [86.26.103.58])
        by smtp.gmail.com with ESMTPSA id u11-20020adfdb8b000000b0022add371ed2sm1540015wri.55.2022.09.16.05.21.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Sep 2022 05:21:12 -0700 (PDT)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH 06/13] dt-bindings: nvmem: qfprom: add IPQ8064 and SDM630 compatibles
Date:   Fri, 16 Sep 2022 13:20:53 +0100
Message-Id: <20220916122100.170016-7-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220916122100.170016-1-srinivas.kandagatla@linaro.org>
References: <20220916122100.170016-1-srinivas.kandagatla@linaro.org>
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

From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Document compatibles for QFPROM used on IPQ8064 and SDM630.  They are
compatible with generic QFPROM fallback.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 Documentation/devicetree/bindings/nvmem/qcom,qfprom.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/nvmem/qcom,qfprom.yaml b/Documentation/devicetree/bindings/nvmem/qcom,qfprom.yaml
index dede8892ee01..b4163086a5be 100644
--- a/Documentation/devicetree/bindings/nvmem/qcom,qfprom.yaml
+++ b/Documentation/devicetree/bindings/nvmem/qcom,qfprom.yaml
@@ -18,6 +18,7 @@ properties:
       - enum:
           - qcom,apq8064-qfprom
           - qcom,apq8084-qfprom
+          - qcom,ipq8064-qfprom
           - qcom,msm8974-qfprom
           - qcom,msm8916-qfprom
           - qcom,msm8996-qfprom
@@ -25,6 +26,7 @@ properties:
           - qcom,qcs404-qfprom
           - qcom,sc7180-qfprom
           - qcom,sc7280-qfprom
+          - qcom,sdm630-qfprom
           - qcom,sdm845-qfprom
       - const: qcom,qfprom
 
-- 
2.25.1

