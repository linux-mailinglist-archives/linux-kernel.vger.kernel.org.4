Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F40735BE4B3
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Sep 2022 13:41:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230033AbiITLlb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Sep 2022 07:41:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230307AbiITLlO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Sep 2022 07:41:14 -0400
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA3E17171D
        for <linux-kernel@vger.kernel.org>; Tue, 20 Sep 2022 04:41:12 -0700 (PDT)
Received: by mail-pj1-x102b.google.com with SMTP id q3so2727976pjg.3
        for <linux-kernel@vger.kernel.org>; Tue, 20 Sep 2022 04:41:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=Ow7jg7iL4OBsAsTVBpxDnjt3oRi+Efs0B5EUHKrVg58=;
        b=u4imFhzk0rcWxWia/6Eb8RWqVZp7FRaBXwhvqBSQsj+wnFAfG3Eq2VnrbHowHbUXGT
         vnXztbOcsy5EdsL+f0nZioHCAJ7pOiVp5GEvXrplkKWhmVlNEdcdNRZvPoj4iRpQDHj6
         7Geb76bWw+eM0+XLX95FguUPnXZEeREBwbkzS0MQmzG3wuGoEaar0/bQuApnhqhSnS9X
         7p+PqCIjIVmGjlVCM84bG++O6eFlKmJBmFikj9lILL8sY7GHVQTDBJTQDrOKGJCI6EuY
         zg18mxx87PYZv9jtCyEm7KZs2ClUc50CCsU08RPpfE6jooYU4mpySVXwpyu5mkSmuoZM
         ujrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=Ow7jg7iL4OBsAsTVBpxDnjt3oRi+Efs0B5EUHKrVg58=;
        b=5tz6dyzFHHmcQsDCU87tQWoq78DXh2tMYSVW8lTtL+s2qlL2fZ9pqO4Yf7+fgKqQJj
         MmGdM99tEt9ORRpMquNisSc99q9z76Jy7CqBseO+EAgLcQIxEsIlGF6BD3alI6VzbFC6
         8yVi4QEffMfNG9oJQleIVNvO2xOaInFYCmZPinGKxkNqSoDAaHkOjFW0pUEgE6oQanAV
         bv6ex+d/HylO1eEd02TngIzIM2A+CAPCY7ADHRGVA11HfqNme4Icb5tM56f6vQu1Xus6
         jI0e9qSXnLq3uvTBRTN4Fxv/Yf2rtijjZAdhuAX0hc1IvJAqzhGRbPDeBOiiGX7ZYGo0
         qqxg==
X-Gm-Message-State: ACrzQf1MPPF2lRmEK8vS/UPCe6ZyI+xcGPw/OZR9eVS3v3klpblHmHw/
        TZ7jY7FDTNWP17nBZslzXBO0Zg==
X-Google-Smtp-Source: AMsMyM71JT1mEhC7wdZI3cGQS2uyvkFvIR5GXCiEuGs3YyQ/VsR//PE6NxgcG9fopZr8UvuyDFiJHQ==
X-Received: by 2002:a17:90b:4b11:b0:202:998b:71b1 with SMTP id lx17-20020a17090b4b1100b00202998b71b1mr3536363pjb.208.1663674072459;
        Tue, 20 Sep 2022 04:41:12 -0700 (PDT)
Received: from localhost.localdomain ([2401:4900:1c61:6535:ca5f:67d1:670d:e188])
        by smtp.gmail.com with ESMTPSA id p30-20020a63741e000000b00434e57bfc6csm1348793pgc.56.2022.09.20.04.41.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Sep 2022 04:41:11 -0700 (PDT)
From:   Bhupesh Sharma <bhupesh.sharma@linaro.org>
To:     linux-crypto@vger.kernel.org, devicetree@vger.kernel.org
Cc:     agross@kernel.org, herbert@gondor.apana.org.au,
        linux-kernel@vger.kernel.org, robh+dt@kernel.org,
        linux-arm-msm@vger.kernel.org, thara.gopinath@gmail.com,
        robh@kernel.org, krzysztof.kozlowski@linaro.org,
        andersson@kernel.org, bhupesh.sharma@linaro.org,
        bhupesh.linux@gmail.com, davem@davemloft.net,
        Jordan Crouse <jorcrous@amazon.com>
Subject: [PATCH v7 2/9] dt-bindings: qcom-qce: Add 'interconnects' and 'interconnect-names'
Date:   Tue, 20 Sep 2022 17:10:44 +0530
Message-Id: <20220920114051.1116441-3-bhupesh.sharma@linaro.org>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20220920114051.1116441-1-bhupesh.sharma@linaro.org>
References: <20220920114051.1116441-1-bhupesh.sharma@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add 'interconnects' and 'interconnect-names' as optional properties
to the device-tree binding documentation for Qualcomm crypto IP.

These properties describe the interconnect path between crypto and main
memory and the interconnect type respectively.

Cc: Bjorn Andersson <andersson@kernel.org>
Acked-by: Rob Herring <robh@kernel.org>
Tested-by: Jordan Crouse <jorcrous@amazon.com>
Signed-off-by: Bhupesh Sharma <bhupesh.sharma@linaro.org>
---
 Documentation/devicetree/bindings/crypto/qcom-qce.yaml | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/Documentation/devicetree/bindings/crypto/qcom-qce.yaml b/Documentation/devicetree/bindings/crypto/qcom-qce.yaml
index 8df47e8513b8..94f96ebc5dac 100644
--- a/Documentation/devicetree/bindings/crypto/qcom-qce.yaml
+++ b/Documentation/devicetree/bindings/crypto/qcom-qce.yaml
@@ -32,6 +32,14 @@ properties:
       - const: bus
       - const: core
 
+  interconnects:
+    maxItems: 1
+    description:
+      Interconnect path between qce crypto and main memory.
+
+  interconnect-names:
+    const: memory
+
   dmas:
     items:
       - description: DMA specifiers for rx dma channel.
-- 
2.37.1

