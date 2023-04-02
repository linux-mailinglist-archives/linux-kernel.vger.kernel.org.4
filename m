Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 160596D36E4
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Apr 2023 12:07:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230475AbjDBKHk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 2 Apr 2023 06:07:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230354AbjDBKHg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Apr 2023 06:07:36 -0400
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5A16A269
        for <linux-kernel@vger.kernel.org>; Sun,  2 Apr 2023 03:07:29 -0700 (PDT)
Received: by mail-pj1-x1035.google.com with SMTP id qe8-20020a17090b4f8800b0023f07253a2cso27711197pjb.3
        for <linux-kernel@vger.kernel.org>; Sun, 02 Apr 2023 03:07:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1680430048;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Wgd39WnlXQz4tbC4i1NLP3F+sroosdBDzPGDIcLrLlo=;
        b=s4g1ikQ+ejs90B/h+ovPQPulj/2nnkWFkwF/BWJhTgGHftvFNZnL24rvn30DXcNU50
         nnAL0fowvVZyVv5jbVqQSCokgGs6oa4xgi74jaRbXdfS3hM7xqyOuLKbxRp9RJJe+NwP
         qHCyhVg8yVCCsJHUMvX3ev6XhKqkCyk8M+d3P0Mvigr9uk5uy+bPxxOZ+mtB/Ytm0PFG
         8lcbogFR8mCIxHH+/6/hSzcxnpTmQQ5yx+gRIyNEsVwtlcGXGsWuf1F43ETKUcjeCa4h
         wleDwDhBwFqkXKx6lgitC9ACgb0bkVhzO6zfyThTvLxYEDr2bbIVfrnV8IP6x4mG+xS4
         28kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680430048;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Wgd39WnlXQz4tbC4i1NLP3F+sroosdBDzPGDIcLrLlo=;
        b=TozvL2vOol1TjmCP9M/5XuQdS4/G1SV1csbOXIJpopFKT21ySuuV4H9q0eyoW5gBkT
         1v7ZBB9rZ5s7bizJqDxDActqe3za5nPx8S/4Ow4PUkX5iARaf3ztbIDU0ReG8JxZLjf7
         nMzLc9Jfy6fKS+6GBsPbGa/0iyfLdyisSh/899M0ITi9FtWdxipTD1r2RUlEYwWXMT6X
         grxZIOapoKYU0bp+CAXgwLYCU5NqKVBoi6ICZOLwRrqZaQvq3Eje868zuuXvoaQCJaV8
         hKt2NuGFhSB53WoVl4+TZ+UQ9iPDP62HQdtdCl08bHndE61YLULK4CHPS1BkjTUHj6Lq
         YfsQ==
X-Gm-Message-State: AO0yUKVDYHR0IBeRKzyWKtR4tIH6rHFhZfWqCh69Nr4PGkrQMDn/ZuWL
        nMG7Un2Na1qoGv2Nbh+m5PL4zA==
X-Google-Smtp-Source: AK7set9kCxxfQ4C59fJFyCT5aLCMfMeEI0o+RAvOdLaYmW91DsAXt1m3mFm2bW4qUJDjDKk7LuQM6g==
X-Received: by 2002:a05:6a20:2e90:b0:da:2fdf:385e with SMTP id bj16-20020a056a202e9000b000da2fdf385emr28030089pzb.49.1680430048593;
        Sun, 02 Apr 2023 03:07:28 -0700 (PDT)
Received: from localhost.localdomain ([223.233.66.184])
        by smtp.gmail.com with ESMTPSA id a26-20020a62bd1a000000b0062dba4e4706sm4788739pff.191.2023.04.02.03.07.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 02 Apr 2023 03:07:28 -0700 (PDT)
From:   Bhupesh Sharma <bhupesh.sharma@linaro.org>
To:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org
Cc:     agross@kernel.org, linux-kernel@vger.kernel.org,
        linux-crypto@vger.kernel.org, andersson@kernel.org,
        bhupesh.sharma@linaro.org, bhupesh.linux@gmail.com,
        krzysztof.kozlowski@linaro.org, robh+dt@kernel.org,
        konrad.dybcio@linaro.org, vladimir.zapolskiy@linaro.org,
        rfoss@kernel.org, neil.armstrong@linaro.org
Subject: [PATCH v5 02/11] dt-bindings: dma: Increase iommu maxItems for BAM DMA
Date:   Sun,  2 Apr 2023 15:35:00 +0530
Message-Id: <20230402100509.1154220-3-bhupesh.sharma@linaro.org>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20230402100509.1154220-1-bhupesh.sharma@linaro.org>
References: <20230402100509.1154220-1-bhupesh.sharma@linaro.org>
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

