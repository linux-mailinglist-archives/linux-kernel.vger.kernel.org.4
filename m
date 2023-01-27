Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4429E67E2EB
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Jan 2023 12:17:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230480AbjA0LRu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Jan 2023 06:17:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229702AbjA0LRq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jan 2023 06:17:46 -0500
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA0DDBB8E
        for <linux-kernel@vger.kernel.org>; Fri, 27 Jan 2023 03:17:44 -0800 (PST)
Received: by mail-wr1-x432.google.com with SMTP id m7so4652551wru.8
        for <linux-kernel@vger.kernel.org>; Fri, 27 Jan 2023 03:17:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wTC3NAL1hZxJOCcXWMuQzdITVQ+oLa3AAEmCazUtZWo=;
        b=hEx6RsUPVvdUG0Kd/aRU6sx1omgwF8N6yyNSVnQcHUplMLP+cIV/0E46SdP1j4NsWz
         wZcLED0fIRwNIf4Efik6Tc7JJX0b52BQWG5tjEI1yz1K3eAm9FZtJ5yQLvg48nsdmGcE
         vxXx2D2YuTiWUUucXARfE1rVDc5RwKxQIhAGOaSNmBZDI8XIPZvQ6UXoZMUv1Xs0I+Lz
         Ya8QEUIp8LK9JPu/tmacrF+IhGXEEVnFMdVjBUw+9U37guMbxow4jxDs/h/LnpE1WjYu
         VN2i0V0w46Vr5GI6GybqivrRflo19LU3e22K0zYAl/YvhmB15Y2ytXP6T21dzDttLPy0
         GCbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wTC3NAL1hZxJOCcXWMuQzdITVQ+oLa3AAEmCazUtZWo=;
        b=GVpv4J4i+nNgdDMyPn/7xoP9uPkoXA9ng+ffRzDZNNiL+ROczOzMSYOt1TkQ57gT2F
         umW5ZEtdGTwi2nsin1NRIWKQdDju9VdbEQnxEbmykZ1Rlag+/qVOMHYslqTBNmAlj1+F
         HDACSiYsFnrKxMomE0g8HGjZu77ZUI+WBD0Vdcnwn3wqrR4cqiOKmmkAQ9wW5d+lQQLn
         ggN3XB680rrjt8oasBitXSj2Zrbd6ZfwHkl+evOwW/259M6rLEEcpQfWlclZyZeuonR0
         WgopqipRPWpN0Gp+9zmrB8l1L8eCNE60akh92QT3tXrGjm+almAs8lvMNbHs8C8REu60
         7Jdg==
X-Gm-Message-State: AO0yUKXSKLGP2t8zcRcF55HH6Q01Ci2pbufuIkCFBQ1GuyoWc2zEqUB3
        h6rZugjhx5X3FxUJ5HRk06H8sA==
X-Google-Smtp-Source: AK7set8Sw1D7yywK+jFzmHSAoz53Rze36VA1TH0uLDaNGLKEkONvoOEW57lRbuzWU/qDIfz8j1mSMQ==
X-Received: by 2002:a5d:5348:0:b0:2bf:b9a4:f688 with SMTP id t8-20020a5d5348000000b002bfb9a4f688mr8574014wrv.23.1674818263380;
        Fri, 27 Jan 2023 03:17:43 -0800 (PST)
Received: from localhost.localdomain ([5.133.47.210])
        by smtp.gmail.com with ESMTPSA id c13-20020adffb0d000000b002bfd190fd60sm1843314wrr.108.2023.01.27.03.17.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Jan 2023 03:17:42 -0800 (PST)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH 02/37] dt-bindings: nvmem: Fix qcom,qfprom compatibles enum ordering
Date:   Fri, 27 Jan 2023 11:15:30 +0000
Message-Id: <20230127111605.25958-3-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230127111605.25958-1-srinivas.kandagatla@linaro.org>
References: <20230127111605.25958-1-srinivas.kandagatla@linaro.org>
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

