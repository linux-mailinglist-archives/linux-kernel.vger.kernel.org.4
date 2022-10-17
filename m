Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B843601CE6
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Oct 2022 01:01:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231159AbiJQXBm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Oct 2022 19:01:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231128AbiJQXBL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Oct 2022 19:01:11 -0400
Received: from mail-qk1-x72f.google.com (mail-qk1-x72f.google.com [IPv6:2607:f8b0:4864:20::72f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08B808287A
        for <linux-kernel@vger.kernel.org>; Mon, 17 Oct 2022 16:00:54 -0700 (PDT)
Received: by mail-qk1-x72f.google.com with SMTP id f8so7674498qkg.3
        for <linux-kernel@vger.kernel.org>; Mon, 17 Oct 2022 16:00:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EEMOUzHy3Lbue0VlcEhhmI28Nc+eV4/vRjIaKRvM/Ws=;
        b=DYsEf/duN4XCC0OByGlaMIgD2ReuU7Z/lAENS021SD0CmPBORi+XL8zfAgU0YNSzc2
         AlC2Yq+JPFijlImx70oNHls9JuT1A0QWmt5xOLZwpT+0rIKvBxt96ar5igAo/yymdK5R
         GjX14wwWM8mgOLJXw7zplyZ63BwW5vAhBF9QUOp5a5MVzgjGruLJgngtMyD+0MamZhGs
         rmZn6motKVmTK7yhS3kmBlf0ckR2Mf4pyuV/7tJM39Rnif+2FzzLUssk6mVIbWfIYTfk
         Tw8C+mDtneqvk4fl9xz6NTJbu0E4iBtS/bV84vDEWg6TN8w+q3NgifUGCmmPOUB+nDpz
         4OTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EEMOUzHy3Lbue0VlcEhhmI28Nc+eV4/vRjIaKRvM/Ws=;
        b=4TZ+TUPHOy3+uEdZlfcBxqYFvgIor4J+BfZ9QWIVOcN9Gjbb6CSPO0fU98vT/oEJuK
         KwZkL0bq8+MXciKuAWZOkHmhThldV9GYgpFU6hqSdPSi+N9y9thXJzJCeem6PaTtcLRg
         sKNHNQd3pi5i/VX+1Yljg7ry4QjO1hAFudQXii7xYbEUnEC9PtlNDfdC8GQYvZWfEWEK
         x5QWtFqCwhPixWR2PGghx0mU6/eWo25/lpsItyved5xrs4f3KP+vsYbqG3fB4Cv3UfOz
         N1VIIXuXDXna+VEHwrTRCmygNnDimPgp7qKS/GHr0syq6x0efMU4eUi3zdtrNidakw04
         MI3A==
X-Gm-Message-State: ACrzQf01cOAMqVN2RtydVz+Vu9k5s3wu+uzBPSQhlKXBdf+pwYs8dAEC
        Ey3FVxdywD/CkGsCmhk1759CWw==
X-Google-Smtp-Source: AMsMyM6u6071wzR4TIslfsfuLiz94WMBMMVBb2Uvl+Kd6YZa7dI5eFobVwygIvU3m3EPDR8w4JiN6A==
X-Received: by 2002:a37:9584:0:b0:6ec:55b9:b8da with SMTP id x126-20020a379584000000b006ec55b9b8damr9569800qkd.735.1666047654314;
        Mon, 17 Oct 2022 16:00:54 -0700 (PDT)
Received: from localhost.localdomain (pool-72-83-177-149.washdc.east.verizon.net. [72.83.177.149])
        by smtp.gmail.com with ESMTPSA id fg11-20020a05622a580b00b0039cb9b6c390sm729670qtb.79.2022.10.17.16.00.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Oct 2022 16:00:52 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Stephan Gerhold <stephan@gerhold.net>,
        Shawn Guo <shawn.guo@linaro.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Vinod Koul <vkoul@kernel.org>,
        krishna Lanka <quic_vamslank@quicinc.com>,
        Iskren Chernev <iskren.chernev@gmail.com>,
        Martin Botka <martin.botka@somainline.org>,
        linux-arm-msm@vger.kernel.org, linux-gpio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Rob Herring <robh@kernel.org>
Subject: [PATCH v3 09/33] dt-bindings: pinctrl: qcom,sm6350: drop checks used in common TLMM
Date:   Mon, 17 Oct 2022 18:59:48 -0400
Message-Id: <20221017230012.47878-10-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221017230012.47878-1-krzysztof.kozlowski@linaro.org>
References: <20221017230012.47878-1-krzysztof.kozlowski@linaro.org>
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

The common Qualcomm TLMM pin controller schema already brings
requirement of function for GPIO pins.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Acked-by: Rob Herring <robh@kernel.org>
---
 .../bindings/pinctrl/qcom,sm6350-pinctrl.yaml         | 11 +----------
 1 file changed, 1 insertion(+), 10 deletions(-)

diff --git a/Documentation/devicetree/bindings/pinctrl/qcom,sm6350-pinctrl.yaml b/Documentation/devicetree/bindings/pinctrl/qcom,sm6350-pinctrl.yaml
index 94af82ee5967..894e59caa735 100644
--- a/Documentation/devicetree/bindings/pinctrl/qcom,sm6350-pinctrl.yaml
+++ b/Documentation/devicetree/bindings/pinctrl/qcom,sm6350-pinctrl.yaml
@@ -53,6 +53,7 @@ $defs:
     description:
       Pinctrl node's client devices use subnodes for desired pin configuration.
       Client device subnodes use below standard properties.
+    $ref: qcom,tlmm-common.yaml#/$defs/qcom-tlmm-state
 
     properties:
       pins:
@@ -110,16 +111,6 @@ $defs:
     required:
       - pins
 
-    allOf:
-      - $ref: "qcom,tlmm-common.yaml#/$defs/qcom-tlmm-state"
-      - if:
-          properties:
-            pins:
-              pattern: "^gpio([0-9]|[1-9][0-9]|1[0-4][0-9]|15[0-7])$"
-        then:
-          required:
-            - function
-
     additionalProperties: false
 
 examples:
-- 
2.34.1

