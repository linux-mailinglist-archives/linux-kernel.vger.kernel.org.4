Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 78BAD6C4976
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Mar 2023 12:45:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230160AbjCVLpv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Mar 2023 07:45:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229998AbjCVLpo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Mar 2023 07:45:44 -0400
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46C83559D8
        for <linux-kernel@vger.kernel.org>; Wed, 22 Mar 2023 04:45:43 -0700 (PDT)
Received: by mail-pl1-x634.google.com with SMTP id u5so18988218plq.7
        for <linux-kernel@vger.kernel.org>; Wed, 22 Mar 2023 04:45:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1679485543;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=45NVBVpYiF52cvaoHl0w4JJTLlfK1ZDLXhzA7w3zmPk=;
        b=QCpJz+I0YyR3Y8UkVEK9iQ/AZAdzUodv2rQnOxKrEWSDxgDV8DY3JtFwCbJO3t7JDj
         Hob3jgIEaE9lZrWnPa51rwhT6QLJPKYyxoWIx2O8OMR9uNx30QTb7rYeeeCvC3s13pgs
         FCOkhAlHaCtfQWJjPqj3eleMj1fK1fSQ+lnWysUNn8qgmb8OIbL5ZOeneaqpdiHptTMj
         nz5mMwZgXyKpHqt+brMwl2eWRlXy19BoENSXjZaGvpbN9i2H0hIUStbYS+rUbE5qztd1
         1dWyqLnzkSERcbqocR3FCVVj7pRHI7QTWS9cIOn6ruJMn5BMFfa9EmVoOGuHyWjOypwR
         mPDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679485543;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=45NVBVpYiF52cvaoHl0w4JJTLlfK1ZDLXhzA7w3zmPk=;
        b=FIq3XghpMufk60kULppDI1qma9q3FATxCBCrXBbJe6FgjdmBrpgOjrYO/06lInDCNo
         hv0L5S38qbt2PTVr4HHivkncRBisVgQOaPky9PrmJkc9vJWc0IZKqPMXmzRhkGb1T+OC
         31Y6XJuMJklogs8y4z23xIOIR2bGvldayBsNGLhmzXKaA/xHIKYcJB1CfRuYRAVsB+ng
         LJvUrwcR7t3YNvW5GJl5Noh9ivmbpYEnCkJ3mKGvV4m5hKFEafpL05PYCkq7ZTzHUFhG
         K7s+TLemmTu8fl5LcEtQGyvLNT/Poqn88eTqFybWmW2ExyyltB4iH6ntRzuGOZ2MGWQp
         LxQw==
X-Gm-Message-State: AO0yUKXEHAHXG8YF5U05kr5HCZEP01/myIbeEPSKVzCPyi/HAEYo+rut
        7p8QUopCFzZwF5fskLYIDeLLCA==
X-Google-Smtp-Source: AK7set+7LE4DiuKvUMqEeTlogwTHF5bRE41vSvH34T1W4F5A9KNupKEL1ddxRbsh/OcpIErQ4Jog8Q==
X-Received: by 2002:a17:90b:4c43:b0:23d:21c9:193 with SMTP id np3-20020a17090b4c4300b0023d21c90193mr3430944pjb.2.1679485542718;
        Wed, 22 Mar 2023 04:45:42 -0700 (PDT)
Received: from localhost.localdomain ([2401:4900:1c60:d4c3:8671:83c0:33ae:5a96])
        by smtp.gmail.com with ESMTPSA id jd1-20020a170903260100b0019b0afc24e8sm10386649plb.250.2023.03.22.04.45.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Mar 2023 04:45:42 -0700 (PDT)
From:   Bhupesh Sharma <bhupesh.sharma@linaro.org>
To:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org
Cc:     agross@kernel.org, linux-kernel@vger.kernel.org,
        linux-crypto@vger.kernel.org, andersson@kernel.org,
        bhupesh.sharma@linaro.org, bhupesh.linux@gmail.com,
        krzysztof.kozlowski@linaro.org, robh+dt@kernel.org,
        konrad.dybcio@linaro.org, vladimir.zapolskiy@linaro.org,
        rfoss@kernel.org, neil.armstrong@linaro.org
Subject: [PATCH v2 02/10] dt-bindings: dma: Increase iommu maxItems for BAM DMA
Date:   Wed, 22 Mar 2023 17:15:11 +0530
Message-Id: <20230322114519.3412469-3-bhupesh.sharma@linaro.org>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20230322114519.3412469-1-bhupesh.sharma@linaro.org>
References: <20230322114519.3412469-1-bhupesh.sharma@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since SM8450 BAM DMA engine supports five iommu entries,
increase the maxItems in the iommu property section, without
which 'dtbs_check' reports the following error:

  arch/arm64/boot/dts/qcom/sm8450-sony-xperia-nagara-pdx224.dtb:
    dma-controller@1dc4000: iommus: is too long

Signed-off-by: Bhupesh Sharma <bhupesh.sharma@linaro.org>
---
 Documentation/devicetree/bindings/dma/qcom,bam-dma.yaml | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/dma/qcom,bam-dma.yaml b/Documentation/devicetree/bindings/dma/qcom,bam-dma.yaml
index 624208d20a34..5469c9c2a1df 100644
--- a/Documentation/devicetree/bindings/dma/qcom,bam-dma.yaml
+++ b/Documentation/devicetree/bindings/dma/qcom,bam-dma.yaml
@@ -46,7 +46,7 @@ properties:
 
   iommus:
     minItems: 1
-    maxItems: 4
+    maxItems: 5
 
   num-channels:
     $ref: /schemas/types.yaml#/definitions/uint32
-- 
2.38.1

