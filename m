Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C780A68EC97
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Feb 2023 11:16:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231226AbjBHKQU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Feb 2023 05:16:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231194AbjBHKP7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Feb 2023 05:15:59 -0500
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51CBC4390B
        for <linux-kernel@vger.kernel.org>; Wed,  8 Feb 2023 02:15:58 -0800 (PST)
Received: by mail-wm1-x32f.google.com with SMTP id c4-20020a1c3504000000b003d9e2f72093so1059763wma.1
        for <linux-kernel@vger.kernel.org>; Wed, 08 Feb 2023 02:15:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=49xfQXijB76l60qaT7Z6y5pL81SUu0qI+8WlIubqbjg=;
        b=gA3+N5HCQCDSfTWCK2lAx7KSNX5Hgzhutg1Rt0iIsmzBXjmyOwn5ijz0CFXd6Dbhsk
         skuHIVhtJGMwbMbJUdnOXu2NxvJd/+yvOsCXIaKvRGyxVnn6Xs2NtiwKrVvuEwJM0kCS
         5Txpn44mlT2mdIgjoeVS2iD21KzP8Pqb+/9dEgyg9NCsvkd+LdUZgblIPZ/GeF0X9mXt
         7Fqf/Fswa21N+/CSvMtXNleg3DXzEkYVHzI0ecwz0Kx20UAHQZzjU136DQMu52SwLv6q
         LQbF9BN7SVS1E0m47zABYoNrlbHlRWRVZirrXA5ewXHXYzMtLlSZPh9ZIeq8ADMsGQLi
         o8Lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=49xfQXijB76l60qaT7Z6y5pL81SUu0qI+8WlIubqbjg=;
        b=HQHrf4j5K1M7zbLpwBP7Tgk9GRE7xHKg0ejT708tYh3j+0fdOSChOKkqLnpkWgI4Pr
         3O0ODZ/FFuFEDYmQPQe/R9JAWyM0ggpvKGXmo/O80we7WJ0k9RIO89fglLRaYW1nxMY4
         VMBZhKjMwEdb4sT42iYfCkLLvclz9zprgPDfjVALtGRedLkJQOVVkOXd/onlq9gkn+Mg
         YZqckK0L9KBZA8SYyZhZqyD+ZULa8WLWMFQr0bvwvdxXu3gmSmgJlfQhSzewvLHmr4w4
         UgFmEoOR5ZCNCl5TICCqxZ1fTSvDdRjc+ZdkIyoLn1VuL+UuEJJLJKGC/bEtIFfqVcAB
         tAkQ==
X-Gm-Message-State: AO0yUKWPcQ0/sfp7iZicl5DRsH9rj7lX5MzhgQBoBXGAv7xyhm6QnKqT
        o2HTWIBc7JvQH39NoGRDBvRWJg==
X-Google-Smtp-Source: AK7set8+a67vFQhEsNOGq72ebMc7Hy74DAStJ4dxQG5w7ZrdDobR6OOZ8N1+Q5kFi4stZWp5ErdDkQ==
X-Received: by 2002:a05:600c:1604:b0:3d2:3be4:2d9a with SMTP id m4-20020a05600c160400b003d23be42d9amr6073107wmn.20.1675851357957;
        Wed, 08 Feb 2023 02:15:57 -0800 (PST)
Received: from krzk-bin.. ([178.197.216.144])
        by smtp.gmail.com with ESMTPSA id t14-20020a05600c198e00b003dc4ecfc4d7sm1496328wmq.29.2023.02.08.02.15.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Feb 2023 02:15:57 -0800 (PST)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Jassi Brar <jassisinghbrar@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Banajit Goswami <bgoswami@quicinc.com>,
        Mark Brown <broonie@kernel.org>, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-remoteproc@vger.kernel.org, alsa-devel@alsa-project.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH v2 5/7] dt-bindings: soc: qcom,apr: correct qcom,intents type
Date:   Wed,  8 Feb 2023 11:15:43 +0100
Message-Id: <20230208101545.45711-5-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230208101545.45711-1-krzysztof.kozlowski@linaro.org>
References: <20230208101545.45711-1-krzysztof.kozlowski@linaro.org>
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

The qcom,intents property is a list of pairs, thus it should be defined
as uint32-matrix.

Fixes: b2d7616e13c4 ("dt-bindings: soc: qcom: apr: add missing properties")
Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

---

Changes since v1:
1. New patch
---
 Documentation/devicetree/bindings/soc/qcom/qcom,apr.yaml | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/soc/qcom/qcom,apr.yaml b/Documentation/devicetree/bindings/soc/qcom/qcom,apr.yaml
index 6026c21736d8..4502458b0669 100644
--- a/Documentation/devicetree/bindings/soc/qcom/qcom,apr.yaml
+++ b/Documentation/devicetree/bindings/soc/qcom/qcom,apr.yaml
@@ -62,7 +62,14 @@ properties:
     maxItems: 1
 
   qcom,intents:
-    $ref: /schemas/types.yaml#/definitions/uint32-array
+    $ref: /schemas/types.yaml#/definitions/uint32-matrix
+    minItems: 1
+    maxItems: 32
+    items:
+      items:
+        - description: size of each intent to preallocate
+        - description: amount of intents to preallocate
+          minimum: 1
     description:
       List of (size, amount) pairs describing what intents should be
       preallocated for this virtual channel. This can be used to tweak the
-- 
2.34.1

