Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB9F2625972
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Nov 2022 12:36:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233521AbiKKLgQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Nov 2022 06:36:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233338AbiKKLgM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Nov 2022 06:36:12 -0500
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79044532C6
        for <linux-kernel@vger.kernel.org>; Fri, 11 Nov 2022 03:36:11 -0800 (PST)
Received: by mail-lf1-x12e.google.com with SMTP id d6so7889183lfs.10
        for <linux-kernel@vger.kernel.org>; Fri, 11 Nov 2022 03:36:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DfDjuOFKuz/+4/FzdYKlkZ69vw3btOLkFXgVYX8IZ2M=;
        b=ZKPSdCvUfQ+4rklV7ZSQx16ScC7V9kumpSo9BjsV6LnyloCLaVJ0dngjVBxr2Hrsi9
         CGxOF33E70rP/rRnCRF3ajRGc+9YR3Awm3keIdj2ZgASSdkXf+xl8sNp37DQVJoiI8tG
         ap1SPP0dszpnLauFUhO8RNiJK4/ulw1xjyuVcsit+/mIRq61CS3VhBuM5IN3jvBqacXC
         gBYEnGamrMtxDAvrv9u1+auXJglZnqICiRf2Od33ETCZf1X7eYyDmv29e1KWnUvteexq
         oUdS7E9y7s61aYxZX+VxcgW8PTnTjgh9oUe7om7qXU/acYbauoEfdzIdPE9sv0XiR7QM
         Jjgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DfDjuOFKuz/+4/FzdYKlkZ69vw3btOLkFXgVYX8IZ2M=;
        b=s8qmmbxj8tN/bvtG5XBq7UyKD1NcBdIfy9IImJuJa69X445NSqjiBo4UjnbqhGT4dz
         8da7w/Ox1kNYSQSunqJ2dY4OdCB1y9GEqNULS0TAs581ZlrJCKEmcshKe/KdN4NlD+C/
         c2dQfxsKySnGXIzAMQwo+SaWgckucDXie5Im94ExzO/+1hszPJFLvhcaIws3KLba0HCY
         zx8z+T9ZIzuQsigaMJvrLqmopXgcHcNGoYO7jWAUC9019pm0dczUGtaSH1hQAoXOgxN2
         o0jBJ0XIWAeJ2P9O/AYwf7sN7cqdGiMVgZoV4xrB3oOiVG67mbXY0TVHvJomuO3qWvgR
         IGEQ==
X-Gm-Message-State: ANoB5pl2kc6mZXSXHHpPhBBOjur2LMwSZo+9BHzwWxCNk+q3pz1Z0HyN
        msVQFsy0JYcfltvUHDlzf3pHwA==
X-Google-Smtp-Source: AA0mqf7GsQcfMEHOYwYQHodGjXvbjYjvJ5JL9FA5oZ6eESNpG+IMCWd0C8dHIroXSuERvZiHyVxWaQ==
X-Received: by 2002:ac2:5b5b:0:b0:4aa:148d:5168 with SMTP id i27-20020ac25b5b000000b004aa148d5168mr545004lfp.561.1668166569837;
        Fri, 11 Nov 2022 03:36:09 -0800 (PST)
Received: from krzk-bin.NAT.warszawa.vectranet.pl (088156142199.dynamic-2-waw-k-3-2-0.vectranet.pl. [88.156.142.199])
        by smtp.gmail.com with ESMTPSA id bi30-20020a0565120e9e00b004acb2adfa1fsm274970lfb.307.2022.11.11.03.36.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Nov 2022 03:36:09 -0800 (PST)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Banajit Goswami <bgoswami@quicinc.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>, alsa-devel@alsa-project.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Patrick Lai <plai@qti.qualcomm.com>,
        Srinivasa Rao Mandadapu <srivasam@qti.qualcomm.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH 01/10] ASoC: dt-bindings: qcom,apr: Add GLINK channel name for SM8450
Date:   Fri, 11 Nov 2022 12:35:38 +0100
Message-Id: <20221111113547.100442-2-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221111113547.100442-1-krzysztof.kozlowski@linaro.org>
References: <20221111113547.100442-1-krzysztof.kozlowski@linaro.org>
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

On SM8450 and SC8280XP with Qualcomm GPR, the GLINK channel name
(qcom,glink-channels) for ADSP is "adsp_apps".

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 .../devicetree/bindings/soc/qcom/qcom,apr.yaml        | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/soc/qcom/qcom,apr.yaml b/Documentation/devicetree/bindings/soc/qcom/qcom,apr.yaml
index f47491aab3b1..0a7a34cb2497 100644
--- a/Documentation/devicetree/bindings/soc/qcom/qcom,apr.yaml
+++ b/Documentation/devicetree/bindings/soc/qcom/qcom,apr.yaml
@@ -58,8 +58,7 @@ properties:
   qcom,glink-channels:
     $ref: /schemas/types.yaml#/definitions/string-array
     description: Channel name used for the communication
-    items:
-      - const: apr_audio_svc
+    maxItems: 1
 
   qcom,intents:
     $ref: /schemas/types.yaml#/definitions/uint32-array
@@ -203,7 +202,15 @@ allOf:
             - qcom,gpr
     then:
       properties:
+        qcom,glink-channels:
+          items:
+            - const: adsp_apps
         power-domains: false
+    else:
+      properties:
+        qcom,glink-channels:
+          items:
+            - const: apr_audio_svc
 
   - if:
       required:
-- 
2.34.1

