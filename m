Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8840E72D669
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Jun 2023 02:26:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238636AbjFMA0H (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Jun 2023 20:26:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240400AbjFMAZl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Jun 2023 20:25:41 -0400
Received: from mail-il1-x133.google.com (mail-il1-x133.google.com [IPv6:2607:f8b0:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E45884EF6;
        Mon, 12 Jun 2023 17:23:35 -0700 (PDT)
Received: by mail-il1-x133.google.com with SMTP id e9e14a558f8ab-33e4e59da95so30486155ab.2;
        Mon, 12 Jun 2023 17:23:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686615796; x=1689207796;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=8206uVleRcmenlUn2i22dXepe92OExv7mWA9sV/K12U=;
        b=BSEHyGmwIli/13S+jTzcgBSD9+BkQSBkh7qCUMxdWHD8DeHngnFoEQhJH0IWxsp8Os
         dfDojs1txQZDK7SupkV16NSLbrcwdSeGNOHo1U8nl6+S/+dSN1KqNrnpOi61VnhLeJjg
         WzaqQUge0NeLtbnBj2NI2kTX6OFkfPkevnwVkXihzMAHIuvj0TyKsa8MT1qmlyoER6fy
         2XcAyKg7TI51lpyceo6YRGVu+n9TxonWKRq3ODpqTsKRxXBdhtSK2hlX9ETQ0Ix895Ou
         9jU7SZFo4a+5rIlBHO0Kt4OUewkDP5ncdafeWUaoi2dU7RGtzwZA5hTN3AvcKBTyYyUg
         e+XQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686615796; x=1689207796;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8206uVleRcmenlUn2i22dXepe92OExv7mWA9sV/K12U=;
        b=hJuj2K7u9nFtT3SSd8R9kdgKSB6ZLi7urIH7FFWF7cyu+7gT8zE+wy1C2+D4my+h8/
         KWBOROe8+uh09kvt6bBMfgybAnrSYhsDsv6NrLJjcDQuPnENHz98VbYqY6RUNcELUJoa
         F5vSuHq7Xv864mDis+/CC2a7pfwjlSfexbS5y+EcVv3fIzpw444GdzCRi7q7vIP/Iim9
         kdDqD0ozI3Ea6ntF/bRK5N0R+RhO3mwV6m26FpcRIDdmse8FXFTIa8khBTrPJnq1sQ4+
         aHHFk1GujdPQUvkbqM6i9BWbBD7VIt89hm2k1kTsQonAEr4rGwUA6NRjB2rJnkwgW0ER
         zgrg==
X-Gm-Message-State: AC+VfDxINk+xwGsQMeYVjmbKTKi77kW8DH2dDBO14AEGlYy38Cx/Sgi6
        t2LZ7ebg1Dmg2i1q0dRnWux2jBgu238IsA==
X-Google-Smtp-Source: ACHHUZ5qMXaQ/+xAecmpHRzkNglZHV6P9CREnw86RKoOd4pQjnoeXtHmDzB9XspotZ0vLvRbDdmG6g==
X-Received: by 2002:a05:6e02:4ca:b0:33a:efd3:add3 with SMTP id f10-20020a056e0204ca00b0033aefd3add3mr9704388ils.14.1686615796412;
        Mon, 12 Jun 2023 17:23:16 -0700 (PDT)
Received: from azeems-kspp.c.googlers.com.com (54.70.188.35.bc.googleusercontent.com. [35.188.70.54])
        by smtp.gmail.com with ESMTPSA id p6-20020a92c606000000b003319d8574e2sm3534076ilm.25.2023.06.12.17.23.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Jun 2023 17:23:15 -0700 (PDT)
From:   Azeem Shaikh <azeemshaikh38@gmail.com>
To:     Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>
Cc:     linux-hardening@vger.kernel.org,
        Azeem Shaikh <azeemshaikh38@gmail.com>,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] crypto: Replace strlcpy with strscpy
Date:   Tue, 13 Jun 2023 00:22:58 +0000
Message-ID: <20230613002258.3535506-1-azeemshaikh38@gmail.com>
X-Mailer: git-send-email 2.41.0.162.gfafddb0af9-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

strlcpy() reads the entire source buffer first.
This read may exceed the destination size limit.
This is both inefficient and can lead to linear read
overflows if a source string is not NUL-terminated [1].
In an effort to remove strlcpy() completely [2], replace
strlcpy() here with strscpy().

Direct replacement is safe here since return value of -E2BIG
is used to check for truncation instead of sizeof(dest).

[1] https://www.kernel.org/doc/html/latest/process/deprecated.html#strlcpy
[2] https://github.com/KSPP/linux/issues/89

Signed-off-by: Azeem Shaikh <azeemshaikh38@gmail.com>
---
 crypto/lrw.c |    4 ++--
 crypto/xts.c |    4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/crypto/lrw.c b/crypto/lrw.c
index 1b0f76ba3eb5..bb8c1575645b 100644
--- a/crypto/lrw.c
+++ b/crypto/lrw.c
@@ -359,8 +359,8 @@ static int lrw_create(struct crypto_template *tmpl, struct rtattr **tb)
 	if (!strncmp(cipher_name, "ecb(", 4)) {
 		unsigned len;
 
-		len = strlcpy(ecb_name, cipher_name + 4, sizeof(ecb_name));
-		if (len < 2 || len >= sizeof(ecb_name))
+		len = strscpy(ecb_name, cipher_name + 4, sizeof(ecb_name));
+		if (len < 2)
 			goto err_free_inst;
 
 		if (ecb_name[len - 1] != ')')
diff --git a/crypto/xts.c b/crypto/xts.c
index 09be909a6a1a..8a9f9653426e 100644
--- a/crypto/xts.c
+++ b/crypto/xts.c
@@ -398,8 +398,8 @@ static int xts_create(struct crypto_template *tmpl, struct rtattr **tb)
 	if (!strncmp(cipher_name, "ecb(", 4)) {
 		unsigned len;
 
-		len = strlcpy(ctx->name, cipher_name + 4, sizeof(ctx->name));
-		if (len < 2 || len >= sizeof(ctx->name))
+		len = strscpy(ctx->name, cipher_name + 4, sizeof(ctx->name));
+		if (len < 2)
 			goto err_free_inst;
 
 		if (ctx->name[len - 1] != ')')
-- 
2.41.0.162.gfafddb0af9-goog


