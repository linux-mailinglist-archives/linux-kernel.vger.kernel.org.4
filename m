Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 14D6C6CA58F
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Mar 2023 15:23:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232646AbjC0NXp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Mar 2023 09:23:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232582AbjC0NX1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Mar 2023 09:23:27 -0400
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1755527A
        for <linux-kernel@vger.kernel.org>; Mon, 27 Mar 2023 06:23:13 -0700 (PDT)
Received: by mail-ed1-x529.google.com with SMTP id ek18so36169146edb.6
        for <linux-kernel@vger.kernel.org>; Mon, 27 Mar 2023 06:23:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1679923391;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=o4SWFLm+fv3A0ySINaCNR8lIIUv5v6wsF3OLQGhunvA=;
        b=IiDkvh0ejQBbFpPsdHJyK18wy5TKG0EelJXbBMmzTJ5kaiva8pulY7S24sFjqBGI0U
         E1TWncUtQipI9yn+Jjcdg1rvFMJLCxDG5F12kk2ktaqDu7s6Ksp174UkdnOGbmyLr0xU
         xZpuifrtD63hgs7W/3/Lir2QgmsYA/HyHq530eh7l3JdMOmOSkaDJBznEC4JL/UkyV/R
         vhJf0zVwOjqMiGn/rAUm3jJVaqPg+5VOMr2J9hBZfQ+Vk/41NnKHDulfF4zP+3kHRW1H
         0uZXszlwK7VtXqDuApLNz3xy/m33C1SyWXWyYrfnclfK/I60X22bYn7xB80iAPdaDtEw
         twjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679923391;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=o4SWFLm+fv3A0ySINaCNR8lIIUv5v6wsF3OLQGhunvA=;
        b=zriQpMEhEZxAPMpMFXiMGMxRqiRGaZ1FC0lOhvWe31OFD7ruHzwGSHHXmb10O19knz
         +v8j+pPNyFkUVf1yDxSMgtZEjgxdi3WwrR46nXvIWtNKWlm6z68qUYktDb6ik59AII5r
         LGpNl4sJw+0FtZTMiRb/pGAGq6Gofai1sbX6fnR0oXQeORgqmgfPfvfHrnbY4aHiC+qS
         ATy22NB5lyF5tBa3htLAhlkrUA8IRvHIUwJ8Wib8WEQhSf/YPK209eDDTI56W0iFiulc
         +XiBgkESswRJr1T/C03VrFYJazCs0I59vTbTJg+qmf2WdHBeWnehSD+v3wBvdA3+5joq
         mk4w==
X-Gm-Message-State: AAQBX9e/mSxf7wqexP0T/AS83cN2wv2YZJn6DOczLkkM2NJjUu4BVmPg
        SbxVbWLyW0YrhH0DRmH/7USJwA==
X-Google-Smtp-Source: AKy350Zi4gbqJ8JQAJAptTP29tPI/Ta9y7VGPm750r05GvqYJLrb0dD5M7SIgOgUrq1fGW1LVsGH+Q==
X-Received: by 2002:a17:906:5010:b0:92a:77dd:f6f with SMTP id s16-20020a170906501000b0092a77dd0f6fmr13047882ejj.73.1679923391718;
        Mon, 27 Mar 2023 06:23:11 -0700 (PDT)
Received: from krzk-bin.. ([2a02:810d:15c0:828:581e:789c:7616:5ee])
        by smtp.gmail.com with ESMTPSA id gy24-20020a170906f25800b00930445428acsm14286814ejb.14.2023.03.27.06.23.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Mar 2023 06:23:11 -0700 (PDT)
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
Subject: [PATCH v3 02/10] ASoC: dt-bindings: qcom,lpass-rx-macro: Add SM8550 RX macro
Date:   Mon, 27 Mar 2023 15:22:46 +0200
Message-Id: <20230327132254.147975-3-krzysztof.kozlowski@linaro.org>
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

Add the RX macro codec on Qualcomm SM8550, which comes without NPL clock
exposed.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Reviewed-by: Rob Herring <robh@kernel.org>
---
 .../bindings/sound/qcom,lpass-rx-macro.yaml    | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/Documentation/devicetree/bindings/sound/qcom,lpass-rx-macro.yaml b/Documentation/devicetree/bindings/sound/qcom,lpass-rx-macro.yaml
index babf2ac20afb..ec4b0ac8ad68 100644
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

