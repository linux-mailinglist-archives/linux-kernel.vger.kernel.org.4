Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8997B6B7097
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Mar 2023 08:57:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230370AbjCMH53 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Mar 2023 03:57:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230179AbjCMH4f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Mar 2023 03:56:35 -0400
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C11D11352B
        for <linux-kernel@vger.kernel.org>; Mon, 13 Mar 2023 00:54:57 -0700 (PDT)
Received: by mail-ed1-x52f.google.com with SMTP id j11so44924871edq.4
        for <linux-kernel@vger.kernel.org>; Mon, 13 Mar 2023 00:54:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1678694092;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AcXL6MCdOOilzj/9V8Bxhr6PgZvPsGUvEZbtUrf8CA0=;
        b=lLbMCDNB8izZF0fMR6XD6CON56cutGL+/47tYCKHA5REqfw0OHpU5thIMeGFsVNMYt
         2G0eJymUZKnlJOXDMn8isJG5H3Zp5q8EcBslx3NyoV0oePVWELvAGHbBOpnij18+4vXK
         sKji7OnEoFB5VGB/aa2bpE5JTNOee2r9C9mEGzTNyJWGepq56pWje0dnQzTMLBMNA2gA
         7oUCP/HhpyQxPtI5nw4EoTCINxCc/zTdz13pEjogkCY2hdsqjQbGgfSJzzmbJExKjvKO
         uC+gdGF6wBXChBD0mfvj3adWHkcIheeOyZrPZR3oEt7j7pd70fi8ARY3jyU+Gh91Cuph
         wsyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678694092;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AcXL6MCdOOilzj/9V8Bxhr6PgZvPsGUvEZbtUrf8CA0=;
        b=ZxvJw0ClBuwWZk4CYTsrMhaZa48lJfTM1dk9GPQHk6wyzIDRq5sfxFdt4ZCld7qril
         5ek1ur2DpUMwOA+HxayA9PqzvcfRA4rCWtO4RDyiqEoJ+tSdBFDf2jzkuIgCEMKAHsWN
         ESVA2lb1kSIXwkfYl8CWFzZ7CIWI5bPHPyi3yEZuGLcSJwX/yb8C8+knpvqAr9ovnjnK
         Qv931NMce+gdO4RIzH5u0su3v2ah2UjmGJrrXAzeRkwTcV+Zn3ww3nfzek1TYPSxlX0E
         CO2QjZsXjDO6K5he/hen7eD8wFBc76ndO+h10VOLR0JT/AeNB/OekIB2zo0kw991gORo
         qxGw==
X-Gm-Message-State: AO0yUKXqC/C0zxo5fPism5k8ekbC555wnOs/BId238gFDNpRwy4s3Psz
        jVWg6NGD7GYbvbfYJ5LiiG8+8Q==
X-Google-Smtp-Source: AK7set+m4WhsczrGwKvch2GzsDuipvIzOAeVXm2+r2tgr1spqAPI7mk1/Gr1PcaQM3BIxlNKL8vOpQ==
X-Received: by 2002:a17:906:8d86:b0:8f9:ed75:f962 with SMTP id ry6-20020a1709068d8600b008f9ed75f962mr36202738ejc.18.1678694092265;
        Mon, 13 Mar 2023 00:54:52 -0700 (PDT)
Received: from krzk-bin.. ([2a02:810d:15c0:828:f052:f15:3f90:fcb3])
        by smtp.gmail.com with ESMTPSA id g7-20020a1709061c8700b008b980c3e013sm3146943ejh.179.2023.03.13.00.54.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Mar 2023 00:54:51 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Banajit Goswami <bgoswami@quicinc.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH v2 2/9] ASoC: dt-bindings: qcom,lpass-rx-macro: Add SM8550 RX macro
Date:   Mon, 13 Mar 2023 08:54:38 +0100
Message-Id: <20230313075445.17160-2-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230313075445.17160-1-krzysztof.kozlowski@linaro.org>
References: <20230313075445.17160-1-krzysztof.kozlowski@linaro.org>
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

Add the RX macro codec on Qualcomm SM8550, which comes without NPL clock
exposed.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 .../bindings/sound/qcom,lpass-rx-macro.yaml    | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/Documentation/devicetree/bindings/sound/qcom,lpass-rx-macro.yaml b/Documentation/devicetree/bindings/sound/qcom,lpass-rx-macro.yaml
index 8b3d617a9578..0ae3c81abdf8 100644
--- a/Documentation/devicetree/bindings/sound/qcom,lpass-rx-macro.yaml
+++ b/Documentation/devicetree/bindings/sound/qcom,lpass-rx-macro.yaml
@@ -15,6 +15,7 @@ properties:
       - qcom,sc7280-lpass-rx-macro
       - qcom,sm8250-lpass-rx-macro
       - qcom,sm8450-lpass-rx-macro
+      - qcom,sm8550-lpass-rx-macro
       - qcom,sc8280xp-lpass-rx-macro
 
   reg:
@@ -92,6 +93,23 @@ allOf:
             - const: dcodec
             - const: fsgen
 
+  - if:
+      properties:
+        compatible:
+          enum:
+            - qcom,sm8550-lpass-rx-macro
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

