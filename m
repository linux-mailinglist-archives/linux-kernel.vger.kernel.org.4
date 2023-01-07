Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 258E7660E94
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Jan 2023 13:08:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232272AbjAGMIq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 7 Jan 2023 07:08:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230258AbjAGMIn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 Jan 2023 07:08:43 -0500
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB7805C90F
        for <linux-kernel@vger.kernel.org>; Sat,  7 Jan 2023 04:08:42 -0800 (PST)
Received: by mail-lf1-x12f.google.com with SMTP id b3so5734525lfv.2
        for <linux-kernel@vger.kernel.org>; Sat, 07 Jan 2023 04:08:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=vTceZJU+jlw4wCFKinH2H3cM1GRd+uz51sDHaYzOEgs=;
        b=Y22T6VVcEpesOBF0FqcuOpa9AoYpws0EbO3NHp5LFWxTDotbWCUDQRV2M5e+mpTNqa
         C8+zD9b/s29SpA9VMZkILpSmMBAwuvl7apxV48gFjsowdeTfp5IjBN7ruMsHb1bsBl/V
         FUvXXDGgrK8VmhOT6bp9IUUJ0h2XIFJ1+VM3JiT7Qb8fa4gJJCE7b9EyyesZv15xjxWV
         scjZ9dGGMapY4ZnfvQzoiPhYIWb0+cJ7ad342qCEk8VgAOlp1HN7j+Ng+sUQhwMAGdLA
         7YwTE9Hp72L577p8QOv0fTiagMS0mZNyeA5F/MQrkja8F5V3lcz3SfSZPZiT9WuTmbxi
         9C8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vTceZJU+jlw4wCFKinH2H3cM1GRd+uz51sDHaYzOEgs=;
        b=LLL9EvtwQu0aaooZWVk2EBO71ghtmIm8vXNP8NE58k+DpKqoT8RurtFzzkO8B/Y+zL
         a0GzPCKjeIFU0xfg1Fv4Gb6TwICAZjcxkwpF/iw454WSeErE0XBet/6JaDY+hGMT+Fbx
         ZsRr+0Z922WVX/M9yP6dSYoO4NHfyUhZOmqp2YxOVC7w0jMhag1VUACSOpaOLSRYqayE
         gk1IrICd5pNgO6o7XBJHVfh1WpjchaPRf82GONu6Qzj8ypHH7+RKDXhvHwCRPEOAjLDI
         PEQe2Tr4AXZb6fbNVH30NRTFkHrJuYHNOQxftsBggeCB0e6ovd8X7XnG3+SgVpCXUdGZ
         k3uw==
X-Gm-Message-State: AFqh2kpFoeysuJ3jm2lz/2HbycXzSJW5ytFt/4QfUOxyZ094CkR1sBI/
        d/XDv2Z4B69VcydFiIveSWcEsA==
X-Google-Smtp-Source: AMrXdXvzKgyQxnUBbRZRCSO0pWyoVoCbTMRgEZofRRHd2IZf3l3H8r0AafVXsoeUXOduQ9hz1iJ9Kw==
X-Received: by 2002:a05:6512:1049:b0:4a4:68b8:c2ec with SMTP id c9-20020a056512104900b004a468b8c2ecmr18855552lfb.67.1673093320986;
        Sat, 07 Jan 2023 04:08:40 -0800 (PST)
Received: from localhost.localdomain (abxi45.neoplus.adsl.tpnet.pl. [83.9.2.45])
        by smtp.gmail.com with ESMTPSA id h14-20020a05651c124e00b0027fd474e7aasm340858ljh.74.2023.01.07.04.08.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 07 Jan 2023 04:08:40 -0800 (PST)
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
Subject: [PATCH v2 1/2] dt-bindings: remoteproc: qcom,sm8150-pas: Add SM6375 MPSS
Date:   Sat,  7 Jan 2023 13:08:37 +0100
Message-Id: <20230107120838.1903498-1-konrad.dybcio@linaro.org>
X-Mailer: git-send-email 2.39.0
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

Add SM6375 MPSS to the 8150 binding, as it's so similar it falls into
the pre-existing ifelse clauses.

Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
Depends on: https://lore.kernel.org/linux-arm-msm/20230107120623.1903056-1-konrad.dybcio@linaro.org/T/#t
v1 -> v2:
- Rebase on top of recent changes
- move to sm8150 pas file

 .../devicetree/bindings/remoteproc/qcom,sm8150-pas.yaml         | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/remoteproc/qcom,sm8150-pas.yaml b/Documentation/devicetree/bindings/remoteproc/qcom,sm8150-pas.yaml
index 082ae70a3fcb..67cfdc017a02 100644
--- a/Documentation/devicetree/bindings/remoteproc/qcom,sm8150-pas.yaml
+++ b/Documentation/devicetree/bindings/remoteproc/qcom,sm8150-pas.yaml
@@ -17,6 +17,7 @@ properties:
   compatible:
     enum:
       - qcom,sm6375-cdsp-pas
+      - qcom,sm6375-mpss-pas
       - qcom,sm8150-adsp-pas
       - qcom,sm8150-cdsp-pas
       - qcom,sm8150-mpss-pas
@@ -77,6 +78,7 @@ allOf:
         compatible:
           enum:
             - qcom,sm6375-cdsp-pas
+            - qcom,sm6375-mpss-pas
             - qcom,sm8150-adsp-pas
             - qcom,sm8150-cdsp-pas
             - qcom,sm8250-cdsp-pas
-- 
2.39.0

