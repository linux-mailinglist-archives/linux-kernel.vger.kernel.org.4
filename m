Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6AD6A6B404B
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Mar 2023 14:23:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229923AbjCJNXE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Mar 2023 08:23:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230262AbjCJNWd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Mar 2023 08:22:33 -0500
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 220E5101122
        for <linux-kernel@vger.kernel.org>; Fri, 10 Mar 2023 05:22:11 -0800 (PST)
Received: by mail-ed1-x52c.google.com with SMTP id k10so20236357edk.13
        for <linux-kernel@vger.kernel.org>; Fri, 10 Mar 2023 05:22:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1678454529;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fDF0ZYXFDOllcKLsEzC0jJ5Ov6N9QuMsH10mVyhVQIQ=;
        b=oLwGVvsu4v/dczo8heTsQZTwVOKSatJ3guqetRKyIQUX0n+ilG+gjQ5StwZyfWd6Je
         ujoIULrFgb9ww6EtVZW332WURx5ePBT4fcrA6sb27dFmxxWQed5S80gDXdb+MmvOrTCv
         GtwGtcpS24mXGMserupwBs8l1e4X6PeV2x3C/PP6d131xKEdjZjB1VxAG/NZQJlFmq8E
         nh2rf+rCKWMz6TfrAJgtpoHYHYsKx2dn6Bz/VbHN96Lw+RruQJTNBPlSbp0QZRLgHKdx
         K8h7EpwJQxAlKggQUO5i/bgYylQv2h3J3Z7x+RSIQSRY75S7YosyQZHzrKArqjxfuT9f
         lH9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678454529;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fDF0ZYXFDOllcKLsEzC0jJ5Ov6N9QuMsH10mVyhVQIQ=;
        b=JbaQ2CLNQdKHeJ24xuiAWL4bguPUJoW1aAI7lDZ9N1Q4JG/rc0/uNQZ56l6LDGteAR
         p/IUx1MNf7tooZ5nFWl7i0dOq4tHzDwvkIYHIO6Ie4AlejqkFxFB/QCbqK0AFMD7jLzE
         7TSqsNsr1nCE9brKixYevaqUKOvPixuKiyBeN2eBX/ANzzZt6aeZzpGClubnhVZQ4C2W
         YDgaUZbbyXEN7SVMrDvxkv/hi1ost1SrfssScfBs86CUIYzAMfGWPPMVWSLGTeBgtSHu
         NsQVe3Srk7/tyoz6cRkDqhLGIBB1kS3vwRxkLcelqfAQNDrTB1/59pIXzl7At0PKIHSo
         3M8A==
X-Gm-Message-State: AO0yUKXa5DIcyS33QeHfeHbZZTgzx6kbc6BoQHq6/pDrWJnJviToFpgK
        4gLZYu+JvvlWhaJbKb1Wj941AQ==
X-Google-Smtp-Source: AK7set89Qn/1m1aeZv+N9sciSUxqSHuGksR73sKrN3UIa/BGEEosLsI4sUmNPKBLS69d2ARaCBE5wg==
X-Received: by 2002:a17:907:7244:b0:8b1:78b6:bbd7 with SMTP id ds4-20020a170907724400b008b178b6bbd7mr31804262ejc.10.1678454529523;
        Fri, 10 Mar 2023 05:22:09 -0800 (PST)
Received: from krzk-bin.. ([2a02:810d:15c0:828:45c4:46be:ec71:4a51])
        by smtp.gmail.com with ESMTPSA id zc4-20020a170906988400b008b17879ec95sm959124ejb.22.2023.03.10.05.22.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Mar 2023 05:22:09 -0800 (PST)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Banajit Goswami <bgoswami@quicinc.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, linux-arm-msm@vger.kernel.org,
        alsa-devel@alsa-project.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH 5/9] ASoC: dt-bindings: qcom,lpass-tx-macro: Add SM8550 TX macro
Date:   Fri, 10 Mar 2023 14:21:57 +0100
Message-Id: <20230310132201.322148-6-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230310132201.322148-1-krzysztof.kozlowski@linaro.org>
References: <20230310132201.322148-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the TX macro codec on Qualcomm SM8550, which comes without NPL clock
exposed.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 .../bindings/sound/qcom,lpass-tx-macro.yaml    | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/Documentation/devicetree/bindings/sound/qcom,lpass-tx-macro.yaml b/Documentation/devicetree/bindings/sound/qcom,lpass-tx-macro.yaml
index 559da2509d8d..9d6e67524daf 100644
--- a/Documentation/devicetree/bindings/sound/qcom,lpass-tx-macro.yaml
+++ b/Documentation/devicetree/bindings/sound/qcom,lpass-tx-macro.yaml
@@ -15,6 +15,7 @@ properties:
       - qcom,sc7280-lpass-tx-macro
       - qcom,sm8250-lpass-tx-macro
       - qcom,sm8450-lpass-tx-macro
+      - qcom,sm8550-lpass-tx-macro
       - qcom,sc8280xp-lpass-tx-macro
 
   reg:
@@ -96,6 +97,23 @@ allOf:
             - const: dcodec
             - const: fsgen
 
+  - if:
+      properties:
+        compatible:
+          enum:
+            - qcom,sm8550-lpass-tx-macro
+    then:
+      properties:
+        clocks:
+          minItems: 4
+          maxItems: 4
+        clock-names:
+          items:
+            - const: mclk
+            - const: macro
+            - const: dcodec
+            - const: fsgen
+
 unevaluatedProperties: false
 
 examples:
-- 
2.34.1

