Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F3DB664C4E
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Jan 2023 20:20:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239568AbjAJTUN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Jan 2023 14:20:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239785AbjAJTTi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jan 2023 14:19:38 -0500
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8EEB6532A7
        for <linux-kernel@vger.kernel.org>; Tue, 10 Jan 2023 11:19:37 -0800 (PST)
Received: by mail-lf1-x129.google.com with SMTP id j17so20037274lfr.3
        for <linux-kernel@vger.kernel.org>; Tue, 10 Jan 2023 11:19:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SCPDekvQnYc0U1/C4X/WLhbgW1GiOmXO0Y/OcmXjz4g=;
        b=NSZZg6ljcsHxy6iaetUWCUDZodgGFOXzmB2NnPy61OSJYetit7Z9I8LaZ4CwJkLft8
         xIKfNYaRL+yTamvlPx5opIis+tDTIcHllt5Nw80vtfJZKnOOxpzdj5SiEwySzXZRhBB0
         dmr40mHf99sJyh/VpoprShIUHYK8CDZ1i1+yH0/D9x8q4rsDlhtu6jH2zCIPKnXSuYdT
         zexhuUbAXWBr8uXQ2VF/fEARnBMRMFuWQ4Tjhbfzgtbqn6Uh2Jd1cCMkoomVAouxIinX
         YHTnoiunhyuIgkNRsa1j3xT6Ts4rdqMVLj68WG/yv6/Uu/0yR0lLenip8lE9jZZ8PM+Y
         USRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SCPDekvQnYc0U1/C4X/WLhbgW1GiOmXO0Y/OcmXjz4g=;
        b=HoDfeajf07OTeSFDCrd5ILGGpypocQbZEU2YOOO0AUCARTcSREEa+dGNGkG9zMBr9/
         iCfJivCYSkHxOTKQQNN9wdowxj0khnOlS9ShGGtPpJwkyGuDVT6rro16YY6ZFl4n2+UX
         G0xfLj4I/C9wnATVvYEsfVp7c0tWvzHodsdpoVWYwfQS58hWqw8E7SSQV1Ygrf0/8E6l
         3RO3DSpbK2rWu4MkBDGXDH2CL1tW3Yv6WabPn0xe8yRM2sWa1sqthG/LwNht8A9WWMdC
         9ehk/KeGzY+bxpiVZMAZ7WhnsTXyARTn67K/pzIkXfIkcKNzE+um5ctz2DlT5tf2yHYn
         gIEA==
X-Gm-Message-State: AFqh2kpIOJU9UArR87hUvXRi3P6MwTfgQwvMtLnHtw0z/V1aX4yDCmb8
        I23Ff7DDQbAIqaUeQfVMfDuUnA==
X-Google-Smtp-Source: AMrXdXvDjquxxa8PiOfFXuBQYP6yfkkdy3dZOWGEdXqtXrF1ljgiWwju5LbgngDIZZH3szBERdHNFQ==
X-Received: by 2002:a05:6512:1390:b0:4cb:4307:eda5 with SMTP id p16-20020a056512139000b004cb4307eda5mr1903598lfa.25.1673378375936;
        Tue, 10 Jan 2023 11:19:35 -0800 (PST)
Received: from Fecusia.local (c-05d8225c.014-348-6c756e10.bbcust.telenor.se. [92.34.216.5])
        by smtp.gmail.com with ESMTPSA id x28-20020a056512131c00b004b549ad99adsm2297725lfu.304.2023.01.10.11.19.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Jan 2023 11:19:35 -0800 (PST)
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Tue, 10 Jan 2023 20:19:13 +0100
Subject: [PATCH v2 2/6] crypto: stm32/hash: Simplify code
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20221227-ux500-stm32-hash-v2-2-bc443bc44ca4@linaro.org>
References: <20221227-ux500-stm32-hash-v2-0-bc443bc44ca4@linaro.org>
In-Reply-To: <20221227-ux500-stm32-hash-v2-0-bc443bc44ca4@linaro.org>
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

Acked-by: Lionel Debieve <lionel.debieve@foss.st.com>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
ChangeLog v1->v2:
- Pick up Lionel's ACK
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
2.39.0
