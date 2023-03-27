Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CCDB86CA5A9
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Mar 2023 15:24:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232638AbjC0NYU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Mar 2023 09:24:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232290AbjC0NXh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Mar 2023 09:23:37 -0400
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7CCA95B91
        for <linux-kernel@vger.kernel.org>; Mon, 27 Mar 2023 06:23:20 -0700 (PDT)
Received: by mail-ed1-x534.google.com with SMTP id x3so36070164edb.10
        for <linux-kernel@vger.kernel.org>; Mon, 27 Mar 2023 06:23:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1679923398;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=H6C2oehD29mdvVUf/6YW/LF4OD+LurGgZwAXHRNOwNI=;
        b=iOLCw3e8jcrKj2cxEFSkhEBca6jq+IfluJjdDP8MQu/l33h0IohvFKmIcy9IkOryjG
         GvJwMwhdbsJmt1HXUj9LhKH0XngcDRYLciRZMfgOA1TvT8l8tjaiTbdsNjlobFB5cJu/
         tdI1ikQjZKJZ/2VUjp3nBYb/6eTA3Y0wFR1WmFlc5xkCrLbEDVxP8fn7Y5ap5FWAdIEW
         MucQZiaKDZKwbWLN8I077nTgcmmhRkTMwRf3/SJNi3V3Td+5aModmPAj1WXiU9zIhZVF
         Bc8/0L8qNRU3E7dSpbF5T+ch5r7BWwGXwBeaC2LG+pzM8Yxi9ofuA2jBlNp45jLyXgTd
         sQjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679923398;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=H6C2oehD29mdvVUf/6YW/LF4OD+LurGgZwAXHRNOwNI=;
        b=0rPsCcjRA7NtJwVlfMmP9lETIj1OQzNBXCYoU3Bk8EETMJOONgIqN88co2VihxYu0l
         Ex5k10qeQT2agyWQ7JZxZSR93r7Do+cA8eb+03ulCX/qXQvbM2aNptfhYX/9PGDu3Pbe
         GZJbVMa6k252T1Zrd7eN0wPXhH9bqN1x8VLCXbgLMRecbzOmLmcT9xAYFmLKaOFUOG+d
         PhxNrwf3T3VMK7ea0CVpSnRf5NEChYyKCPTy//KBeGqgjnBBaBN/EIkuJdwBrJWUjTrt
         Nr0QLYLww2g2kvlXKJq9jkPr5KFuTIWD7u4CdrGnLHUBIK+kU2t8zbRgjOuNKwVylrAT
         76GQ==
X-Gm-Message-State: AAQBX9dSYRWl2BdBJk1+yKeEGDi5TDaDbBgxHgyt89zqoRj0RhIdRHeS
        UxH5iYcaHGIhEGhaoLUvpVO7gQ==
X-Google-Smtp-Source: AKy350bJk9HPKQFGqOqsrsC9SPm+Pem+SwXwgMWcjh2NW7nmdunmuYH86WBqFrDz9P78cDEKgaDkhg==
X-Received: by 2002:a17:906:3616:b0:931:19f8:d89c with SMTP id q22-20020a170906361600b0093119f8d89cmr12312627ejb.73.1679923398704;
        Mon, 27 Mar 2023 06:23:18 -0700 (PDT)
Received: from krzk-bin.. ([2a02:810d:15c0:828:581e:789c:7616:5ee])
        by smtp.gmail.com with ESMTPSA id gy24-20020a170906f25800b00930445428acsm14286814ejb.14.2023.03.27.06.23.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Mar 2023 06:23:18 -0700 (PDT)
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
Cc:     Patrick Lai <quic_plai@quicinc.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Rob Herring <robh@kernel.org>
Subject: [PATCH v3 08/10] ASoC: dt-bindings: qcom,lpass-va-macro: Add SM8550 VA macro
Date:   Mon, 27 Mar 2023 15:22:52 +0200
Message-Id: <20230327132254.147975-9-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230327132254.147975-1-krzysztof.kozlowski@linaro.org>
References: <20230327132254.147975-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the VA macro codec on Qualcomm SM8550, which comes without NPL clock
exposed.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Reviewed-by: Rob Herring <robh@kernel.org>
---
 .../bindings/sound/qcom,lpass-va-macro.yaml    | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/Documentation/devicetree/bindings/sound/qcom,lpass-va-macro.yaml b/Documentation/devicetree/bindings/sound/qcom,lpass-va-macro.yaml
index 528b677a439c..4a56108c444b 100644
--- a/Documentation/devicetree/bindings/sound/qcom,lpass-va-macro.yaml
+++ b/Documentation/devicetree/bindings/sound/qcom,lpass-va-macro.yaml
@@ -15,6 +15,7 @@ properties:
       - qcom,sc7280-lpass-va-macro
       - qcom,sm8250-lpass-va-macro
       - qcom,sm8450-lpass-va-macro
+      - qcom,sm8550-lpass-va-macro
       - qcom,sc8280xp-lpass-va-macro
 
   reg:
@@ -110,6 +111,23 @@ allOf:
             - const: dcodec
             - const: npl
 
+  - if:
+      properties:
+        compatible:
+          contains:
+            enum:
+              - qcom,sm8550-lpass-va-macro
+    then:
+      properties:
+        clocks:
+          minItems: 3
+          maxItems: 3
+        clock-names:
+          items:
+            - const: mclk
+            - const: macro
+            - const: dcodec
+
 unevaluatedProperties: false
 
 examples:
-- 
2.34.1

