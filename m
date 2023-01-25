Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1382F67A794
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Jan 2023 01:23:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234593AbjAYAXn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Jan 2023 19:23:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234250AbjAYAX2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jan 2023 19:23:28 -0500
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0BF8F4CE4E
        for <linux-kernel@vger.kernel.org>; Tue, 24 Jan 2023 16:23:24 -0800 (PST)
Received: by mail-ej1-x62e.google.com with SMTP id ud5so43542466ejc.4
        for <linux-kernel@vger.kernel.org>; Tue, 24 Jan 2023 16:23:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dZ27p7zF4T27+K/nN0SUmKAuxZywkQG/U6QyG5d8NyA=;
        b=QJ/19TCg14yqvOQLmIFg24XehYjzB9j13SdaTs1rKJ83AU1VbzHGuKuUMnia3DaMML
         LYwAkiPjcpm6NzEf2MRfedGuZXWLPbji4TBfQVe1kb2+bizrSabk+mvVD4ucmqmdHomI
         sOzZQOyU62Vj1y/SnnJ7ovCeQmu4/ovGgcCLS58UHYkmDqA9IS737Fa8dcPPHHX8FyKU
         X6ffSN2Y1q2FZbNMIoB5MCFOrEAHXpIJuP732o9D10rrJkvmhIKXIgz+muzpARYPOoYa
         4oXKc+9TN6pU4/ulqMYkpcDIyOvjw7ARw0qoWqgw9n9iDD42cWOsF+YLPNx9JYP0EXLl
         oJsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dZ27p7zF4T27+K/nN0SUmKAuxZywkQG/U6QyG5d8NyA=;
        b=fE9EVATpSImB6mM2c663kUs9tSI0E8ZeBb9Shy8E/EK4x10EsTMAuUYWnGPFR4Bb80
         GPfugIoeeRNC3jWVPpx6zu49FAD09mLHr1y+mdah+qpLrqcMjaKcyw2WVhyLcrWI7Qvq
         yMvwtZPQ1O6VvVScYzX1G6WkPPeG9S+NhNwTZtkq4O1wSUb6PD1OdU2LClVpDE/ZuHMJ
         ZMeeIKNNq/kDVpZc/VPtNcfURdKYhKpKjR/MWkjGFnQNqAKvB0GvBW35m+e7aL035+Qi
         6o60JsS11dMI0HQ3zNZkHXw00xguBV1ZaKIIMY9TUroERHyu2MVj3ma+xdCUoiLNsNLo
         LL1w==
X-Gm-Message-State: AFqh2koAKaHU4IDll2JN1mWlVLIQdDMG9aEnsIOyFz+ueW9XicnMCDGO
        rJ3uQN6mrhTq0tP9SsSlHQrjog==
X-Google-Smtp-Source: AMrXdXuPVo13SXKzlv8efr0eXOVX+Rwf2H5jTBFY9jVwKrKrye2EFI7PJBI7aI+BIoZC8hmeQf5ZAg==
X-Received: by 2002:a17:906:a3cf:b0:861:3ed5:e029 with SMTP id ca15-20020a170906a3cf00b008613ed5e029mr44674312ejb.49.1674606202741;
        Tue, 24 Jan 2023 16:23:22 -0800 (PST)
Received: from fedora.local (c-05d8225c.014-348-6c756e10.bbcust.telenor.se. [92.34.216.5])
        by smtp.gmail.com with ESMTPSA id if10-20020a170906df4a00b00738795e7d9bsm1584606ejc.2.2023.01.24.16.23.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Jan 2023 16:23:22 -0800 (PST)
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Wed, 25 Jan 2023 01:23:08 +0100
Subject: [PATCH v3 3/6] crypto: stm32/hash: Use existing busy poll function
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20221227-ux500-stm32-hash-v3-3-32ee12cd6f06@linaro.org>
References: <20221227-ux500-stm32-hash-v3-0-32ee12cd6f06@linaro.org>
In-Reply-To: <20221227-ux500-stm32-hash-v3-0-32ee12cd6f06@linaro.org>
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
        Linus Walleij <linus.walleij@linaro.org>,
        Rob Herring <robh@kernel.org>
X-Mailer: b4 0.11.1
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When exporting state we are waiting indefinitely in the same
was as the ordinary stm32_hash_wait_busy() poll-for-completion
function but without a timeout, which means we could hang in
an eternal loop. Fix this by waiting for completion like the
rest of the code.

Acked-by: Lionel Debieve <lionel.debieve@foss.st.com>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
ChangeLog v2->v3:
- No changes
ChangeLog v1->v2:
- Pick up Lionel's ACK
---
 drivers/crypto/stm32/stm32-hash.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/crypto/stm32/stm32-hash.c b/drivers/crypto/stm32/stm32-hash.c
index 0473ced7b4ea..cc0a4e413a82 100644
--- a/drivers/crypto/stm32/stm32-hash.c
+++ b/drivers/crypto/stm32/stm32-hash.c
@@ -960,11 +960,13 @@ static int stm32_hash_export(struct ahash_request *req, void *out)
 	struct stm32_hash_dev *hdev = stm32_hash_find_dev(ctx);
 	u32 *preg;
 	unsigned int i;
+	int ret;
 
 	pm_runtime_get_sync(hdev->dev);
 
-	while ((stm32_hash_read(hdev, HASH_SR) & HASH_SR_BUSY))
-		cpu_relax();
+	ret = stm32_hash_wait_busy(hdev);
+	if (ret)
+		return ret;
 
 	rctx->hw_context = kmalloc_array(3 + HASH_CSR_REGISTER_NUMBER,
 					 sizeof(u32),

-- 
2.39.0
