Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0FA27656CE2
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Dec 2022 17:31:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231550AbiL0Qbu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Dec 2022 11:31:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230456AbiL0Qbn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Dec 2022 11:31:43 -0500
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 658ADB7E7
        for <linux-kernel@vger.kernel.org>; Tue, 27 Dec 2022 08:31:41 -0800 (PST)
Received: by mail-lf1-x12e.google.com with SMTP id cf42so20287520lfb.1
        for <linux-kernel@vger.kernel.org>; Tue, 27 Dec 2022 08:31:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4vKtFWde8ag1p6V6juNXXh4nFSRBR0CPIqIm4A+AUkI=;
        b=aCSdFPp3ybPM5fn1ZC9OofVvgotn9V4jc7wxsDPkHRan+nIu4hrvuxCQ45s7NtchTJ
         SsI1slzKPtFhR9Jzz2WWxAOBpHR0IL1b8CaPbS9WonCOcfAk6eNJYm9I7wKTAQjRnKm2
         xn4fTnvQMQdI76EMG097ThjtRn68C83kaxi3w94D1JgRWKLIuAhRA82BlQk2FW6Bvgnn
         ryxjYjCcd/R8dLWgpXP/vJ1gK0RRjqn6EKHWgoqjND0RoGdLYT0VDbMnNLou9UO3hU4t
         q/mDvwpi6WiMVxNid83fVGMnEYjlcSI0kXmLOV8wTq5SUc1EUbbJDIAfuU84cNIgBybh
         WNFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4vKtFWde8ag1p6V6juNXXh4nFSRBR0CPIqIm4A+AUkI=;
        b=cggx7ofLqyJkL/v8CPXYMhqy0uT4QxN9ZTtpSjrZqsDWnHoiSl68yq/mthQpiFwk7O
         ua50Ujqmy/f8dN8E4mvolp28vZoSxo81XBPEyDoBNvg6xtqPrf8UmAN9mD+Gh7OvQEmj
         xSJvKMN9Pnci5p+jyYmODqlpFj5sd7f8ULIkU826N17hXvKtmIFOUCS3TqCu7DxUf2Gs
         uqAwZ7LIx8a6pFD662DuVp0TxJTSfwGtO8TEIaPpEDUdQS8rCybbe2RzVZBIk0btIP+d
         eH4uzmb28xmX7Ukh7GnVlAwiWAcahb7hiN3cLYYXTeZVqSoF1uqkwhYGbTbMmTwVWu1C
         MiTQ==
X-Gm-Message-State: AFqh2kqlXeHvYq0/Vyd6Akm7zxNP1kwQvkElDfX8FgqMPzAAjpUCRDgi
        HSHE++1e9S3fQgUE993nq1Rl0Q==
X-Google-Smtp-Source: AMrXdXsi1Yf+1sfjPFQxih5hmhW2m86/4RfbGkn0PY6lv0SikoXPrs5jrTzZX0V5FNf/qJhcAX9dPw==
X-Received: by 2002:a05:6512:e85:b0:4b5:aa59:28 with SMTP id bi5-20020a0565120e8500b004b5aa590028mr7251601lfb.38.1672158699757;
        Tue, 27 Dec 2022 08:31:39 -0800 (PST)
Received: from krzk-bin.NAT.warszawa.vectranet.pl (088156142067.dynamic-2-waw-k-3-2-0.vectranet.pl. [88.156.142.67])
        by smtp.gmail.com with ESMTPSA id v9-20020a056512348900b004a46a9cebe2sm2318019lfr.289.2022.12.27.08.31.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Dec 2022 08:31:39 -0800 (PST)
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
        Rohit kumar <rohitkr@codeaurora.org>,
        alsa-devel@alsa-project.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH 2/3] ASoC: dt-bindings: qcom,lpass-cpu: Fix DAI children pattern
Date:   Tue, 27 Dec 2022 17:31:34 +0100
Message-Id: <20221227163135.102559-2-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221227163135.102559-1-krzysztof.kozlowski@linaro.org>
References: <20221227163135.102559-1-krzysztof.kozlowski@linaro.org>
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

DAI children (as subnodes) can come with two-digit unit addresses:

  sc7280-herobrine-crd.dtb: audio@3987000: Unevaluated properties are not allowed ('dai-link@19', 'dai-link@25' were unexpected)

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 Documentation/devicetree/bindings/sound/qcom,lpass-cpu.yaml | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/sound/qcom,lpass-cpu.yaml b/Documentation/devicetree/bindings/sound/qcom,lpass-cpu.yaml
index f00fc1051d4d..16248629f659 100644
--- a/Documentation/devicetree/bindings/sound/qcom,lpass-cpu.yaml
+++ b/Documentation/devicetree/bindings/sound/qcom,lpass-cpu.yaml
@@ -78,7 +78,7 @@ properties:
     const: 0
 
 patternProperties:
-  "^dai-link@[0-9a-f]$":
+  "^dai-link@[0-9a-f]+$":
     type: object
     description: |
       LPASS CPU dai node for each I2S device or Soundwire device. Bindings of each node
-- 
2.34.1

