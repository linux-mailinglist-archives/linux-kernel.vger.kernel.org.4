Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8581B6D7575
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Apr 2023 09:31:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237159AbjDEHbP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Apr 2023 03:31:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237078AbjDEHbD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Apr 2023 03:31:03 -0400
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F7F74C13
        for <linux-kernel@vger.kernel.org>; Wed,  5 Apr 2023 00:31:00 -0700 (PDT)
Received: by mail-pl1-x62b.google.com with SMTP id z19so33660891plo.2
        for <linux-kernel@vger.kernel.org>; Wed, 05 Apr 2023 00:31:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1680679860;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Wgd39WnlXQz4tbC4i1NLP3F+sroosdBDzPGDIcLrLlo=;
        b=c+K/1+I+HXNSCA+LfMD5CMiAizpy7/+k/uIoMuC0C64a0F9DISCIQMHQO5y0+xkGtQ
         1uyEmMvwMQuEZvegvvGNiGVVC/AKHF7l7FoNmYmk1bWPbMFU4hSCkb9hkk5GfeCYESH8
         QJijlyfA9be1obqzhMYszoL78c+/zxKEFbYvG/DlUEcFLD+bc4Dl8RA9nrzcAXvvsULs
         pyH6tyq/HiKR4IKXS2XhKjlUwNY3oclfps4Df3rM/l33od7rPMA5G22V8HimencOLYYz
         sM+vXe913MQpsbXK/J7yUfV0Qeq4xRv3Cb9I3AYZvDYycyMCW2mPKZeDAFUiaJLdHXFh
         tCkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680679860;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Wgd39WnlXQz4tbC4i1NLP3F+sroosdBDzPGDIcLrLlo=;
        b=gunL+j+tjCWBnfdMf6BcehiYiWj/3TRNw5vk6pm/kOBv4x7eO8DjsU8x9d8se+R+1m
         IX3xxM4z7F8agT3AEPyXQqup3iwUmVSAujL6XXinoQk7oqcBXml6KGiPy/x/VN5SIW3+
         /V9uH0/CFDBFxn4ZtNjouoHrXal8fJeZDgRP0M/hbrRKcnwiWFQhI9AD3s9h7BIg+NIJ
         HVYzp3X4qae9JUsxEEyA2AjEKz/0/HGu1A1ppjbnszwXvJ2PcgHcCP4Pxw3ppsUIw8uU
         enmsPcpTe5C9ZDMQ0opnpGGEGPqRvJMJ+JuQ2qSB+xRUsY1v68X5fAmTV7bgcOjkJTcR
         WxrQ==
X-Gm-Message-State: AAQBX9eQSJ4y9OtkB3tQXhe+Do+ucFWTm626gv5n0pXfnvBO+ggyteLa
        BcUZfxrlDkKwgSmwTLPqY38IXDywhEl2jFjNRls=
X-Google-Smtp-Source: AKy350ZeQM8mCNtvwzU2cxCF1iY0OeNfPnYG4fOJ1QjHI8BKr3pmLDSpqHbdIHkojl358gPdvXgdLQ==
X-Received: by 2002:a05:6a20:4fa7:b0:da:bace:b06a with SMTP id gh39-20020a056a204fa700b000dabaceb06amr4335745pzb.50.1680679859776;
        Wed, 05 Apr 2023 00:30:59 -0700 (PDT)
Received: from localhost.localdomain ([223.233.67.41])
        by smtp.gmail.com with ESMTPSA id l7-20020a635b47000000b004facdf070d6sm8781507pgm.39.2023.04.05.00.30.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Apr 2023 00:30:59 -0700 (PDT)
From:   Bhupesh Sharma <bhupesh.sharma@linaro.org>
To:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org
Cc:     agross@kernel.org, linux-kernel@vger.kernel.org,
        linux-crypto@vger.kernel.org, andersson@kernel.org,
        bhupesh.sharma@linaro.org, bhupesh.linux@gmail.com,
        krzysztof.kozlowski@linaro.org, robh+dt@kernel.org,
        konrad.dybcio@linaro.org, vladimir.zapolskiy@linaro.org,
        rfoss@kernel.org, neil.armstrong@linaro.org, djakov@kernel.org
Subject: [PATCH v6 02/11] dt-bindings: dma: Increase iommu maxItems for BAM DMA
Date:   Wed,  5 Apr 2023 12:58:27 +0530
Message-Id: <20230405072836.1690248-3-bhupesh.sharma@linaro.org>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20230405072836.1690248-1-bhupesh.sharma@linaro.org>
References: <20230405072836.1690248-1-bhupesh.sharma@linaro.org>
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

Since SM8450 BAM DMA engine supports five iommu entries,
increase the maxItems in the iommu property section, without
which 'dtbs_check' reports the following error:

  arch/arm64/boot/dts/qcom/sm8450-sony-xperia-nagara-pdx224.dtb:
    dma-controller@1dc4000: iommus: is too long

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Signed-off-by: Bhupesh Sharma <bhupesh.sharma@linaro.org>
---
 Documentation/devicetree/bindings/dma/qcom,bam-dma.yaml | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/dma/qcom,bam-dma.yaml b/Documentation/devicetree/bindings/dma/qcom,bam-dma.yaml
index c663b6102f50..5636d38f712a 100644
--- a/Documentation/devicetree/bindings/dma/qcom,bam-dma.yaml
+++ b/Documentation/devicetree/bindings/dma/qcom,bam-dma.yaml
@@ -44,7 +44,7 @@ properties:
 
   iommus:
     minItems: 1
-    maxItems: 4
+    maxItems: 5
 
   num-channels:
     $ref: /schemas/types.yaml#/definitions/uint32
-- 
2.38.1

