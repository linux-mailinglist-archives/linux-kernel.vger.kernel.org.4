Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5513F5B4560
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Sep 2022 11:09:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229562AbiIJJJF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 10 Sep 2022 05:09:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229459AbiIJJJC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Sep 2022 05:09:02 -0400
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ACFCB5B783
        for <linux-kernel@vger.kernel.org>; Sat, 10 Sep 2022 02:09:01 -0700 (PDT)
Received: by mail-lf1-x133.google.com with SMTP id bt10so6733690lfb.1
        for <linux-kernel@vger.kernel.org>; Sat, 10 Sep 2022 02:09:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date;
        bh=ZuuwgMgWZdLoQrFrciWoob85mt2oidbKv+Fs5nLorLU=;
        b=D7lvpBa0OM2v483NJSAEmhXZpFZw85H62yQlnE1xUaS/R5kScSmkTe0rYvjcqqc80z
         goHwh8vzRFL9X4sbCE2sWNtNgszbOtNXi+1FGPWGk2nH8n694oZ2W36pe2kYW6O/bhuB
         KtykgK6iheKISgYAQXEe1k5MkjAoUEZGoe9fmFXE8DGLaQKA2eLcs4tjyb204ZyWsI3U
         xRRCvJWu28+jD8mz5pZPpERVTK9hnxQik7dlY+HLZVzvO+xouGjae2KaEPwhSXC0ohvD
         0FmRgWzZ40MWwxQCprWXb4RKOQypJbjTpjD3kQamfMHwzca3epphmRkDMQLMr4QeAo5k
         7a9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date;
        bh=ZuuwgMgWZdLoQrFrciWoob85mt2oidbKv+Fs5nLorLU=;
        b=EO6IAj1ceuFiii2QzEzxYpuSTkucLNz+vhvj079G9Vc29spRJoFW0nnP1wv3XUDG77
         UveUK7S9OVSGpj+wvOtLHT7bVLFpSMk/wXj9zhM5dvhG+7AihoSxQbTUzhbirhj0tQqa
         cwZunycxRZ7ipkbVUJedSc18Pnb8NiJ8MfA33ItfCVo7Lx9r3U9iDvPdxtINngIzUP1C
         p+L3X9rDo24yTCCQhZzygLlTSMYDQ2Ka0exg0i5ZCO4mEllwKz2Md1sRIqClljZoDIfV
         1CBg3N0LcGJMVBRqSA88txPRtrE63xGfRH7DCT3KmHjHepDG6UjBUMpyIicro0pP9VLQ
         z96Q==
X-Gm-Message-State: ACgBeo1hoXkG5OwPYaJxx6HJ3IMSkt7l0gBUj4Dio41qFUekU12So/Mu
        KH5plpacYRqWiB5IygpnLynx5A==
X-Google-Smtp-Source: AA6agR57Mnkr7zHXYRcCJwAmGEe1GabSx2cHHL3x4HqQ+6NQFNGed0q/+0WhZQTzoRJKylo4QscqeA==
X-Received: by 2002:a05:6512:239c:b0:497:938e:2c99 with SMTP id c28-20020a056512239c00b00497938e2c99mr5503975lfv.416.1662800940013;
        Sat, 10 Sep 2022 02:09:00 -0700 (PDT)
Received: from krzk-bin.. (78-11-189-27.static.ip.netia.com.pl. [78.11.189.27])
        by smtp.gmail.com with ESMTPSA id k7-20020ac257c7000000b0048b23c609c9sm197338lfo.102.2022.09.10.02.08.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 10 Sep 2022 02:08:59 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Banajit Goswami <bgoswami@quicinc.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, alsa-devel@alsa-project.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH] ASoC: dt-bindings: qcom,q6afe: remove binding
Date:   Sat, 10 Sep 2022 11:08:56 +0200
Message-Id: <20220910090856.49271-1-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
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

qcom,q6afe is already documented in soc/qcom/qcom,apr.yaml.  The
version-based compatibles ("qcom,q6afe-v<MAJOR-NUMBER>.<MINOR-NUMBER>")
are not used (neither in upstream nor in downstream DTS).

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 .../devicetree/bindings/sound/qcom,q6afe.txt  | 20 -------------------
 1 file changed, 20 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/sound/qcom,q6afe.txt

diff --git a/Documentation/devicetree/bindings/sound/qcom,q6afe.txt b/Documentation/devicetree/bindings/sound/qcom,q6afe.txt
deleted file mode 100644
index bc6b5f1fe4f1..000000000000
--- a/Documentation/devicetree/bindings/sound/qcom,q6afe.txt
+++ /dev/null
@@ -1,20 +0,0 @@
-Qualcomm Audio Front End (Q6AFE) binding
-
-AFE is one of the APR audio service on Q6DSP
-Please refer to qcom,apr.txt for details of the common apr service bindings
-used by all apr services. Must contain the following properties.
-
-- compatible:
-	Usage: required
-	Value type: <stringlist>
-	Definition: must be "qcom,q6afe-v<MAJOR-NUMBER>.<MINOR-NUMBER>"
-		  Or "qcom,q6afe" where the version number can be queried
-		  from DSP.
-		  example "qcom,q6afe"
-
-= EXAMPLE
-
-apr-service@4 {
-	compatible = "qcom,q6afe";
-	reg = <APR_SVC_AFE>;
-};
-- 
2.34.1

