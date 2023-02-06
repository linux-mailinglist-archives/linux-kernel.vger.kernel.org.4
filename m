Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8097268BE87
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Feb 2023 14:44:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229992AbjBFNoM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Feb 2023 08:44:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229930AbjBFNoI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Feb 2023 08:44:08 -0500
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6340C10F4
        for <linux-kernel@vger.kernel.org>; Mon,  6 Feb 2023 05:44:06 -0800 (PST)
Received: by mail-wr1-x433.google.com with SMTP id bk16so10382407wrb.11
        for <linux-kernel@vger.kernel.org>; Mon, 06 Feb 2023 05:44:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wTC3NAL1hZxJOCcXWMuQzdITVQ+oLa3AAEmCazUtZWo=;
        b=QkPiV36RXZpXn/hyY4s2C9T2aTMpZXkIT0lTJ7/lXBGFHOj3a1BlALnkfuZvbuZ/zA
         pSm5a25VP0/NDC8cLtDrxxo7/H7JKpAMJeb81GleHau46/dro09zmLF72WQvYju/VSdT
         g39QpfYbmga654OteJvGttZCDr1VSpDJ5VBLSNtf3QkGMfPj9mtpi9I4QUdr5krXIYN3
         ddLnY1Yoy9q/p5mQZXSy6ODBT8tQaE31y0o9cWyuy0UIcg/u3NioMjkv6SRvcvlpo5Ro
         p7PweOTLWHwc5H6iJtf29copYfhTDN+YHK7CTop68ipbCXVwrrL2Q+6d1uVs0g7Hndac
         YZxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wTC3NAL1hZxJOCcXWMuQzdITVQ+oLa3AAEmCazUtZWo=;
        b=sqhX4YycwIRgvBh84kI9OSjnWFPAxYJPFBxiESBV8VXBy1fseix21M6q+sfWmKGd5g
         DiZy6D8Y5QL8r4HdG5Q0EXp9NnARlCHH2kCTILySDT6Mj/HIrqBjNWPvgFrp8o4ltWqy
         YEdLYtSrOT5jC5kstr4IbcTQodQOuEWk/JKKAb11201nEfZPv04waIQyFeNdexrWRtuk
         l3bN1qlwJ+LSQ1uBMAkytJj5vY+UBwfPLwZVgsDt39Nk8DUYuLgNil0ngLpp29YMfEx2
         B4lsvcn7AyiKH8ZEbcEq5hj+piSVKZR3E+9QYcnj/B7HZ4W7qLs06NbbhIOEIG9GRNJN
         80mw==
X-Gm-Message-State: AO0yUKWx2BQdNuGE+WsWFACSWjOSwTtPTXZV46Ok8gGyDE7P1fbYtf57
        jiEeZiHerZ0Y6asIyRHaTfLaVg==
X-Google-Smtp-Source: AK7set9O3OUe0JjsDlRUkT1jBp5ZQ3xrhAeScb3AJp2JbDyXbRwjIZIcumRRIdPT6YUgP6nL4RdN/Q==
X-Received: by 2002:a5d:6d8e:0:b0:2bf:da39:5628 with SMTP id l14-20020a5d6d8e000000b002bfda395628mr21380852wrs.41.1675691044937;
        Mon, 06 Feb 2023 05:44:04 -0800 (PST)
Received: from localhost.localdomain ([5.133.47.210])
        by smtp.gmail.com with ESMTPSA id o15-20020adfa10f000000b002bddaea7a0bsm9008037wro.57.2023.02.06.05.44.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Feb 2023 05:44:04 -0800 (PST)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH v2 02/22] dt-bindings: nvmem: Fix qcom,qfprom compatibles enum ordering
Date:   Mon,  6 Feb 2023 13:43:36 +0000
Message-Id: <20230206134356.839737-3-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230206134356.839737-1-srinivas.kandagatla@linaro.org>
References: <20230206134356.839737-1-srinivas.kandagatla@linaro.org>
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

