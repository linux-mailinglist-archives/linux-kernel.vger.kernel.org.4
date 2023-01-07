Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E6A23660E8B
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Jan 2023 13:06:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232563AbjAGMGt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 7 Jan 2023 07:06:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232495AbjAGMGk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 Jan 2023 07:06:40 -0500
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3CC035C938
        for <linux-kernel@vger.kernel.org>; Sat,  7 Jan 2023 04:06:35 -0800 (PST)
Received: by mail-lf1-x12f.google.com with SMTP id v25so5672086lfe.12
        for <linux-kernel@vger.kernel.org>; Sat, 07 Jan 2023 04:06:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hOiHupmcGyEf5UGEte8W6FCxWinJIDVJiVA55jrOYzc=;
        b=GIlO3UN55vL3h7JbdJvH33jKpscEKWu6I5VytHsyJHn7XTOuXw+XIaszHE25w2myzU
         4vgAfKMJ5UYtzlccwzKOwJ64J5s+tKse/9JtEXVvggowUDd6kmXl9Lxxs2bpMj2W6xTF
         SpWj4yPYkB3/72h05lp87WvlrhDazS/pNCeDBBnqAbs+En4xmMeSrJEwqPQNxmjPc1Ci
         pW+T1l3+BhPJeRFU1Q2t0THYG5NwsDviKcfy+xkv3r9NctZ9TLwyOVi2OzZzIcpV/E/I
         zKxRRFK/m/zX3uJW3WHa/rJJEj9WO9RUmP+FtpZY/72lNx/mAvadC/C76Sk+sfhKb2lJ
         UL9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hOiHupmcGyEf5UGEte8W6FCxWinJIDVJiVA55jrOYzc=;
        b=UuGkh+aGLN5lwHJmJqg/djiphD+G5Pg0wUqcDJ57V5bsR8f/Uh4S32ypGvOgjaX6ZP
         JUDRtsd6GOZpalsBralWsuJUd8bVliSDGfyzOZPojxzA45SPj0MC4wOSsqZEexrmxi5L
         zBK7Ta/clZRsucLzS35rzTSFqeB9q33fj/MtOjHyp35jLPpY2SrOxstDTXHUj2+0+q7R
         9uZ1DqDglZP8jtgfaXKRGucwQcN+y9HI87g54LNbXuu+YZiKDUtmq4d1JS2/k81k+hlK
         QsUnirg2AITMZJ7qsmOQZ5XUHzw7ZOeGPDHKUEJcit4X+I+nl+xPJr6pfyQc6LjqC5lt
         wAAQ==
X-Gm-Message-State: AFqh2kpgXUoUIrDIPUFS672+A4STHCehsco130ylgHx1cSzJKH2loLTA
        OR8ZrqWFxLkkuMaxUBKVLdu7Hg==
X-Google-Smtp-Source: AMrXdXszbs3bt64CyDgYipBy5p8y1VLbYTo03RqArCREdFRnc69lP5EZzaewo1+P06yBp+PT+8+uCg==
X-Received: by 2002:a05:6512:3c9e:b0:4b6:a6e4:ab7a with SMTP id h30-20020a0565123c9e00b004b6a6e4ab7amr19349343lfv.8.1673093193582;
        Sat, 07 Jan 2023 04:06:33 -0800 (PST)
Received: from localhost.localdomain (abxi45.neoplus.adsl.tpnet.pl. [83.9.2.45])
        by smtp.gmail.com with ESMTPSA id m2-20020a056512114200b004caf992bba9sm551424lfg.268.2023.01.07.04.06.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 07 Jan 2023 04:06:33 -0800 (PST)
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
To:     linux-arm-msm@vger.kernel.org, andersson@kernel.org,
        agross@kernel.org, krzysztof.kozlowski@linaro.org
Cc:     marijn.suijten@somainline.org,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Manivannan Sadhasivam <mani@kernel.org>,
        linux-remoteproc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 2/3] dt-bindings: remoteproc: qcom,sm8150-pas: Add SM6375 CDSP
Date:   Sat,  7 Jan 2023 13:06:22 +0100
Message-Id: <20230107120623.1903056-2-konrad.dybcio@linaro.org>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230107120623.1903056-1-konrad.dybcio@linaro.org>
References: <20230107120623.1903056-1-konrad.dybcio@linaro.org>
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

Add entries for SM6375 CDSP, as it's essentially identical to the one
on SM8150.

Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
v1 -> v2:
- Rebase on top of recent changes, move to 8150 pas yaml

 .../devicetree/bindings/remoteproc/qcom,sm8150-pas.yaml        | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/Documentation/devicetree/bindings/remoteproc/qcom,sm8150-pas.yaml b/Documentation/devicetree/bindings/remoteproc/qcom,sm8150-pas.yaml
index b934252cf02b..082ae70a3fcb 100644
--- a/Documentation/devicetree/bindings/remoteproc/qcom,sm8150-pas.yaml
+++ b/Documentation/devicetree/bindings/remoteproc/qcom,sm8150-pas.yaml
@@ -16,6 +16,7 @@ description:
 properties:
   compatible:
     enum:
+      - qcom,sm6375-cdsp-pas
       - qcom,sm8150-adsp-pas
       - qcom,sm8150-cdsp-pas
       - qcom,sm8150-mpss-pas
@@ -51,6 +52,7 @@ allOf:
       properties:
         compatible:
           enum:
+            - qcom,sm6375-cdsp-pas
             - qcom,sm8150-adsp-pas
             - qcom,sm8150-cdsp-pas
             - qcom,sm8150-slpi-pas
@@ -74,6 +76,7 @@ allOf:
       properties:
         compatible:
           enum:
+            - qcom,sm6375-cdsp-pas
             - qcom,sm8150-adsp-pas
             - qcom,sm8150-cdsp-pas
             - qcom,sm8250-cdsp-pas
-- 
2.39.0

