Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8A94567A791
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Jan 2023 01:23:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234341AbjAYAXh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Jan 2023 19:23:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234171AbjAYAX2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jan 2023 19:23:28 -0500
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A388F4DBFF
        for <linux-kernel@vger.kernel.org>; Tue, 24 Jan 2023 16:23:25 -0800 (PST)
Received: by mail-ej1-x630.google.com with SMTP id bk15so43433389ejb.9
        for <linux-kernel@vger.kernel.org>; Tue, 24 Jan 2023 16:23:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XtSwGpV2j0nQXiZ+LcNdnpcv1hVjkJ1W08Bggr7Cjy0=;
        b=TIneo37BFcCoCvPMeBd+WYwoMRhtkaoPCmdy6r3Ws0YPEw99fpwL9/3Z9uvGBE8G5I
         J0pATloRutbCl+kMFdBctuX/JUuWrbwmXJqt0ZIKbXvl7cfejdjxN0iGJojYnm0HawTY
         +Pk9+qH+/lIxmXXnq7Iqzbfl3chdCfS7pl6Zw8sfTy99Ez9YeHDDZtnR/8UxtIMQJpvl
         88AJ+ATsMy51AlyxKQeUZjZIO7qOp1rNA9txjGTgCxfK6LtYcawgt68/Xu/YTlTQ7Lzt
         qB4+3/1iG6jrEY+Fs3ZJLGVFvwtVrxbJxaqyEmQrEFShhadwx4/8EKqUefbFNUlelut9
         M2wQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XtSwGpV2j0nQXiZ+LcNdnpcv1hVjkJ1W08Bggr7Cjy0=;
        b=s6luloXAanDEm3/UrPBj1V5zbzGaSiBG/Aag94exK55caQjXCNcuYWjnMnQp+dZhIe
         cu6chistenYInMLH10Xg6a8sbIx7AWoMsF8AEQ5cWVE44AB9GFc2P5HR04jp1MRbvzo/
         xdGuuh3Lya1NlNdECR/hTwlbYxY9MBy1KoBPSW1Wm/YVmwNC9P6f920k6WgY6HeBtLS1
         XG8ln0CJ2ojciIHDsrBwQdfMRTlfHvqVuuB2fqGfG2Xl3Q3w0FXGCh/6EfLadpcjsEca
         XDgnX35Al0lnUz9fDqn9GYMpNRL/HaOkN/xQHSAmSxadn+ZT55P175Q2k/BW9MZ3H+4d
         w6Ag==
X-Gm-Message-State: AFqh2krLpVgtWTf7UFmxdWwpu24vy4IRNdn29L+xKP7CkbePlONAhJ3s
        sXSHVHjvwiRY+ZUBUqlEor/4Jg==
X-Google-Smtp-Source: AMrXdXsWPHwaqA3WsFV3Zsw9CNtSgOoeqJLePtVfjlhhSr1kf3GR4doCP1rTJ0p7Jd0Cz9n8wGI1Zg==
X-Received: by 2002:a17:906:8298:b0:86d:be0:607d with SMTP id h24-20020a170906829800b0086d0be0607dmr32534825ejx.70.1674606204058;
        Tue, 24 Jan 2023 16:23:24 -0800 (PST)
Received: from fedora.local (c-05d8225c.014-348-6c756e10.bbcust.telenor.se. [92.34.216.5])
        by smtp.gmail.com with ESMTPSA id if10-20020a170906df4a00b00738795e7d9bsm1584606ejc.2.2023.01.24.16.23.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Jan 2023 16:23:23 -0800 (PST)
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Wed, 25 Jan 2023 01:23:09 +0100
Subject: [PATCH v3 4/6] crypto: stm32/hash: Wait for idle before final CPU xmit
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20221227-ux500-stm32-hash-v3-4-32ee12cd6f06@linaro.org>
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

When calculating the hash using the CPU, right before the final
hash calculation, heavy testing on Ux500 reveals that it is wise
to wait for the hardware to go idle before calculating the
final hash.

The default test vectors mostly worked fine, but when I used the
extensive tests and stress the hardware I ran into this problem.

Acked-by: Lionel Debieve <lionel.debieve@foss.st.com>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
ChangeLog v2->v3:
- No changes
ChangeLog v1->v2:
- Pick up Lionel's ACK
---
 drivers/crypto/stm32/stm32-hash.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/crypto/stm32/stm32-hash.c b/drivers/crypto/stm32/stm32-hash.c
index cc0a4e413a82..d4eefd8292ff 100644
--- a/drivers/crypto/stm32/stm32-hash.c
+++ b/drivers/crypto/stm32/stm32-hash.c
@@ -362,6 +362,9 @@ static int stm32_hash_xmit_cpu(struct stm32_hash_dev *hdev,
 		stm32_hash_write(hdev, HASH_DIN, buffer[count]);
 
 	if (final) {
+		if (stm32_hash_wait_busy(hdev))
+			return -ETIMEDOUT;
+
 		stm32_hash_set_nblw(hdev, length);
 		reg = stm32_hash_read(hdev, HASH_STR);
 		reg |= HASH_STR_DCAL;

-- 
2.39.0
