Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D4E176570B5
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Dec 2022 00:04:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230037AbiL0XEi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Dec 2022 18:04:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231382AbiL0XEC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Dec 2022 18:04:02 -0500
Received: from mail-lj1-x235.google.com (mail-lj1-x235.google.com [IPv6:2a00:1450:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E820DF95
        for <linux-kernel@vger.kernel.org>; Tue, 27 Dec 2022 15:03:56 -0800 (PST)
Received: by mail-lj1-x235.google.com with SMTP id e13so12488427ljn.0
        for <linux-kernel@vger.kernel.org>; Tue, 27 Dec 2022 15:03:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=i2N7NNifAQ86WoZ7rTUxWJfmzgVYj68lx1CkkjLHfuc=;
        b=oKTHfe5WpDJ+0S0x9Q64mivXn6gj2tUZMKKd+8RnEujrrZl0qNLXkvCbulXJooqt04
         EoqpfufbUrXy9fHKA/OlX/D7kQNF3+6GgR5OXGr5Gkp61L/j4g6Pb6bS64LBj7/OVVX0
         42UnDcK2eAj9hkH+31lKbADQ5LIwKAK6CiSzZkIrvYw9oUvs5icpP537v50zIj435cCu
         B0TADlrv2/+zvFxwe8Y8/mmkevlhPAIZ0zCY+4W2dKqmmFRJD8SXZyQMXRUdrRXq2KZR
         nYV7FVyieFgWYBAHV4DIim/oxTMFmGRoFTXhYm2Aab//s3485UxwOZ0URpjJj6ppgvJu
         AkwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=i2N7NNifAQ86WoZ7rTUxWJfmzgVYj68lx1CkkjLHfuc=;
        b=6NiyWxP3OlrFq2w+mFaJsAeJ8PAP9mUgb6pGUabv4JA4XUSLpqD1ZGTt+mirdytdrW
         D7HhatgRcBc9Zt5HuEx6BJUKpCmV4LIXgdOP6Ojg9vZYWCOh4rYZ/K6TjvIl9kqIY0Zn
         zl2hwO1qhnZ4Y1+EU1xRV7EayI3GMT0QPcwCJFXEjN8Yxc5pTQseQXlyfL0p9AdyQIjh
         DfkE2o265JP7LsOy9r47ScymiP+7/QOYcBLinPejaQwXlbCcZ4zKn8JAHIvIi5dtdkTz
         kmeaBwUL4qylnaeljaeLPxU73DM1/WdpE7bs8IUNbgqEAekeWXh8WD+Xj9XglRk/PRhd
         CkIg==
X-Gm-Message-State: AFqh2kqlnpAHSZrcv9r8+R76Qtj+DxcAsWRI+FXT6Wz6JVg8k73ZbiZt
        lCvztFN7MCrgkGwg8xe71f22yw==
X-Google-Smtp-Source: AMrXdXvrQu86e9KN1tewvOMgrDxWfgLXTRrdS3k1l5PdDsuMATBoNzZFvn6HMaqHHB4dG5xK1SAnpA==
X-Received: by 2002:a2e:954f:0:b0:27f:c258:b24a with SMTP id t15-20020a2e954f000000b0027fc258b24amr1866334ljh.11.1672182235821;
        Tue, 27 Dec 2022 15:03:55 -0800 (PST)
Received: from Fecusia.local (c-05d8225c.014-348-6c756e10.bbcust.telenor.se. [92.34.216.5])
        by smtp.gmail.com with ESMTPSA id bg25-20020a05651c0b9900b0027fbd4ee003sm876925ljb.124.2022.12.27.15.03.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Dec 2022 15:03:49 -0800 (PST)
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Wed, 28 Dec 2022 00:03:34 +0100
Subject: [PATCH 2/7] crypto: stm32/hash: Simplify code
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20221227-ux500-stm32-hash-v1-2-b637ac4cda01@linaro.org>
References: <20221227-ux500-stm32-hash-v1-0-b637ac4cda01@linaro.org>
In-Reply-To: <20221227-ux500-stm32-hash-v1-0-b637ac4cda01@linaro.org>
To:     Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Lionel Debieve <lionel.debieve@foss.st.com>
Cc:     linux-crypto@vger.kernel.org, devicetree@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Linus Walleij <linus.walleij@linaro.org>
X-Mailer: b4 0.11.1
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We are passing (rctx->flags & HASH_FLAGS_FINUP) as indicator
for the final request but we already know this to be true since
we are in the (final) arm of an if-statement set from the same
flag. Just open-code it as true.

Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 drivers/crypto/stm32/stm32-hash.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/crypto/stm32/stm32-hash.c b/drivers/crypto/stm32/stm32-hash.c
index d33006d43f76..0473ced7b4ea 100644
--- a/drivers/crypto/stm32/stm32-hash.c
+++ b/drivers/crypto/stm32/stm32-hash.c
@@ -399,8 +399,7 @@ static int stm32_hash_update_cpu(struct stm32_hash_dev *hdev)
 	if (final) {
 		bufcnt = rctx->bufcnt;
 		rctx->bufcnt = 0;
-		err = stm32_hash_xmit_cpu(hdev, rctx->buffer, bufcnt,
-					  (rctx->flags & HASH_FLAGS_FINUP));
+		err = stm32_hash_xmit_cpu(hdev, rctx->buffer, bufcnt, 1);
 	}
 
 	return err;

-- 
2.38.1
