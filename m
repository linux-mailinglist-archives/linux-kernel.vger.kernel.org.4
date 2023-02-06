Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E397D68BA18
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Feb 2023 11:28:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230413AbjBFK2Z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Feb 2023 05:28:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230392AbjBFK2S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Feb 2023 05:28:18 -0500
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A13BC166DC
        for <linux-kernel@vger.kernel.org>; Mon,  6 Feb 2023 02:28:17 -0800 (PST)
Received: by mail-wm1-x32a.google.com with SMTP id f47-20020a05600c492f00b003dc584a7b7eso10380252wmp.3
        for <linux-kernel@vger.kernel.org>; Mon, 06 Feb 2023 02:28:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wTC3NAL1hZxJOCcXWMuQzdITVQ+oLa3AAEmCazUtZWo=;
        b=coJ1KrAQZuALbf5TZA2QK0yc8M8+YC6IOP9jy67LmzfUSrIhaA59DL/yV3dv1zPCS5
         nV/qiuW5g1lbj2dxWQj7hNcNw386PhM2nHtdoR0uWVWVRCx/wp4Nm6i2KFhkZV1m5vHc
         rUgCtFCyHe+/scV4EcfzULGqv5Z7P4pAE9AiVNikyNNycoBXdeFwNj6aU3DwlbZKMwVw
         ob5W52qqNkzBPko/JrgLCWiBipARRazj+/3Locu5grBdnFpHrcJMEPrSaTNKE8aEcsJP
         Pns4R0yt+SWxmqm3Tdh/ub7FRHuiPQNnujsiN0X4OhsZdVa+ybaMSzfkIen9/wv5HGyA
         iNzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wTC3NAL1hZxJOCcXWMuQzdITVQ+oLa3AAEmCazUtZWo=;
        b=Yig23y4tKf7MsPtb6aNxd2441vzFoErIl0/QSj++csmSn5RSdOGRdB+PsUpycX1SFJ
         R2xlnxGXpgCT1ISFObrvhAbPDk5UTr/qSQmMm7m6mejCVEUUvDZ9oUcV6BlWFVKpgp+a
         gpf5UM5CyUYf69+mLRwVxGgA7mR0u6pxa1p9x6Mpq8r6zpEPAXjaAKGumbNFh/YHtv9l
         CF7vJeajd++OJQ/awkftQ8LtkCSHY/E8nOobI/GRFIk7SoJF5u1kOSWloOVEtXSLSGpy
         rUEfjqh9kr31QqtUbN5i3pdGuyWfXFQBbhZG3M3XBmCm5IvwF3umDQo7sBQ9DWDLXvaR
         6SxA==
X-Gm-Message-State: AO0yUKWhPqakbvnG6jZq9xUsGUBv0MwI5EeNeSpLnLCLV+tMx+8KnjQ8
        iCHZlLvffVPpMAKNKdX0aSZcDb6YxizmFP+9
X-Google-Smtp-Source: AK7set+9Tgk6o3qHR0hqcyy/xm8nsCsz1JkFC8+EGf6EBnSObjAcE9sl6Z3fvL71T4NlPBPP5AsHhA==
X-Received: by 2002:a05:600c:35c7:b0:3e0:1a9:b1e0 with SMTP id r7-20020a05600c35c700b003e001a9b1e0mr3108242wmq.25.1675679296104;
        Mon, 06 Feb 2023 02:28:16 -0800 (PST)
Received: from localhost.localdomain ([5.133.47.210])
        by smtp.gmail.com with ESMTPSA id g10-20020a05600c310a00b003de77597f16sm11002446wmo.21.2023.02.06.02.28.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Feb 2023 02:28:15 -0800 (PST)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [RESEND PATCH 02/37] dt-bindings: nvmem: Fix qcom,qfprom compatibles enum ordering
Date:   Mon,  6 Feb 2023 10:27:24 +0000
Message-Id: <20230206102759.669838-3-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230206102759.669838-1-srinivas.kandagatla@linaro.org>
References: <20230206102759.669838-1-srinivas.kandagatla@linaro.org>
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

From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>

Move qcom,msm8974-qfprom after qcom,msm8916-qfprom to respect
alphabetical ordering.

Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 Documentation/devicetree/bindings/nvmem/qcom,qfprom.yaml | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/nvmem/qcom,qfprom.yaml b/Documentation/devicetree/bindings/nvmem/qcom,qfprom.yaml
index 8e89b15b535f..cc39514e8c84 100644
--- a/Documentation/devicetree/bindings/nvmem/qcom,qfprom.yaml
+++ b/Documentation/devicetree/bindings/nvmem/qcom,qfprom.yaml
@@ -19,8 +19,8 @@ properties:
           - qcom,apq8064-qfprom
           - qcom,apq8084-qfprom
           - qcom,ipq8064-qfprom
-          - qcom,msm8974-qfprom
           - qcom,msm8916-qfprom
+          - qcom,msm8974-qfprom
           - qcom,msm8996-qfprom
           - qcom,msm8998-qfprom
           - qcom,qcs404-qfprom
-- 
2.25.1

