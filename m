Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B562262D33D
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Nov 2022 07:07:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239281AbiKQGHf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Nov 2022 01:07:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239302AbiKQGHR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Nov 2022 01:07:17 -0500
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F2E82A71A;
        Wed, 16 Nov 2022 22:07:12 -0800 (PST)
Received: by mail-wm1-x333.google.com with SMTP id l39-20020a05600c1d2700b003cf93c8156dso999320wms.4;
        Wed, 16 Nov 2022 22:07:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=B/4dSPCEiDUe3Xyt1vQbKBrfveGFoVaGx8ciHb9QLPU=;
        b=WUBVCwSUcsGVoF5A63XFfDYRW1n0W7vigFBveEkiddsyxkiK9JwbQ2C8nQfM6NuS8j
         1YiOGDJe/57NZX+qOTUggz6zwUvRm+U1wLbURpOIUesmnmvuK42IioAj0pWaJ8NqqT8L
         9+yLc1PiTJx3NP6rtLtzWC+Gnjx2593eesxm3O33ss8pcUZqy2mwMgNq7DRCJWgc1u30
         tbfRqwKb/anPwHPrrop0+4r6bcFvIgHRDb9ieqt45zUGDsyfgHbirdVGWZutcibNcqd9
         8aJ0T+3Cut4F3djKa7abbi2qEkD3OTGCRbO8L+xPzveL7/xciSYhx27Ccm4Ckn9sx9kU
         PswQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=B/4dSPCEiDUe3Xyt1vQbKBrfveGFoVaGx8ciHb9QLPU=;
        b=3VsvI8b5D1p+4Dpp7wzV01PwgxbkpgttdeoMk69wG4oCOPui6E3LOWUomyTG+ePcq/
         gaStrdDWjN2Cyb7yftOXQGw0JQcCKH8MyWKwNraZTzig2+UAZu2aqF8lvcpO6JdOmKtt
         zUCLmFpjo/BXzrXm1Q6KRfCrEFZsIx1aPCnZHKROF8pJDsRqMNW4JNa1R6VG6q5nYKPT
         h8gRKTmyOq206+fZk55q1/rrxVk7ah9JxtR6UF+7cw+024XFwIFV1sw5d4knjjacrxir
         2xHJlOeo0hqa/V3zkkztbKb0dbTBwvYvxwEhyLxlWHiMWGyLvIAlTwUpkD/M/Mmb+Nu3
         UqQA==
X-Gm-Message-State: ANoB5pl8CTDfOzvwWtMfRHGkoK4JhtadREqhpMjA841G5rCEPpyfSqPL
        3XD5i5aDjNptYOf3M9gmQ8M=
X-Google-Smtp-Source: AA0mqf6nbH1NYbfiNWEsx3ll18zbt1NmXbZvFY47Q26qtUlN3NrLlCKI8CekDyokCXbhnOmaguJOdg==
X-Received: by 2002:a05:600c:3c8a:b0:3cf:6fe0:b16a with SMTP id bg10-20020a05600c3c8a00b003cf6fe0b16amr4030910wmb.28.1668665230759;
        Wed, 16 Nov 2022 22:07:10 -0800 (PST)
Received: from kista.localdomain (82-149-19-102.dynamic.telemach.net. [82.149.19.102])
        by smtp.gmail.com with ESMTPSA id r11-20020a5d694b000000b0023691d62cffsm16542568wrw.70.2022.11.16.22.07.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Nov 2022 22:07:10 -0800 (PST)
From:   Jernej Skrabec <jernej.skrabec@gmail.com>
To:     mchehab@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, wens@csie.org,
        samuel@sholland.org
Cc:     linux-media@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
        linux-kernel@vger.kernel.org,
        Jernej Skrabec <jernej.skrabec@gmail.com>
Subject: [PATCH v2 1/2] media: dt-bindings: allwinner: video-engine: Fix number of IOMMU channels
Date:   Thu, 17 Nov 2022 07:07:03 +0100
Message-Id: <20221117060704.367945-2-jernej.skrabec@gmail.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221117060704.367945-1-jernej.skrabec@gmail.com>
References: <20221117060704.367945-1-jernej.skrabec@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Cedrus (video engine) on Allwinner H6 actually uses two IOMMU channel,
not just one. However, Cedrus on SoCs like D1 only uses one channel.

Allow up to 2 IOMMU channels.

Fixes: 62a8ccf3a248 ("arm64: dts: allwinner: h6: Fix Cedrus IOMMU usage")
Signed-off-by: Jernej Skrabec <jernej.skrabec@gmail.com>
---
 .../bindings/media/allwinner,sun4i-a10-video-engine.yaml       | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/media/allwinner,sun4i-a10-video-engine.yaml b/Documentation/devicetree/bindings/media/allwinner,sun4i-a10-video-engine.yaml
index 541325f900a1..6446004d59d9 100644
--- a/Documentation/devicetree/bindings/media/allwinner,sun4i-a10-video-engine.yaml
+++ b/Documentation/devicetree/bindings/media/allwinner,sun4i-a10-video-engine.yaml
@@ -55,7 +55,8 @@ properties:
     description: Phandle to the device SRAM
 
   iommus:
-    maxItems: 1
+    minItems: 1
+    maxItems: 2
 
   memory-region:
     maxItems: 1
-- 
2.38.1

