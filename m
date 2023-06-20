Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E6BBE7375A8
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Jun 2023 22:08:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229954AbjFTUIs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Jun 2023 16:08:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229912AbjFTUIp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Jun 2023 16:08:45 -0400
Received: from mail-io1-xd30.google.com (mail-io1-xd30.google.com [IPv6:2607:f8b0:4864:20::d30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D738A10D2;
        Tue, 20 Jun 2023 13:08:43 -0700 (PDT)
Received: by mail-io1-xd30.google.com with SMTP id ca18e2360f4ac-77e364a9a87so150383539f.3;
        Tue, 20 Jun 2023 13:08:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687291723; x=1689883723;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=I3L5aiCn/v38TxGv1xMVfWkWkGI2DT+dcXWc59iN2KA=;
        b=cVBiOEwtKYX0Hn6ZIKe4OUSaDwe0q1qo8Ht9mu684OFOJyedCSEsUjC6Wq11HwLQsI
         +xk7loHNJsqCNzbit5kymz+5BweAeYalqExBus7oLNPtmM18Ht6B4IFE2dlUDigWfdxd
         sRncN08ydORgpaBOmbAWV3DeVeJA+jJXZ6UQ9RXcrMbXgkmnbltSZBjiiHUe0M67sLv4
         2PgfZGuuWFZ+MGpjotiedfCoVRz7YJuRPvfqxo/vVOECnbL5bD9oL7EjvtPv5YnciQaT
         umMkB6b5aPecfsuWdjPVTRojGk58m3/NsfMQxIpTYZWA3FFe/2Ww1rmYDLpQnzp2Z9zg
         m7ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687291723; x=1689883723;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=I3L5aiCn/v38TxGv1xMVfWkWkGI2DT+dcXWc59iN2KA=;
        b=SPFp0uyxjuRIS8HKFpaiM0hpUGujvnDfg0x8IvIln/P4fNEJbmI8PJLYYUu+5M2wYj
         vKRx/JUBN6ngCQLQl54LUIKNGfgdgxyAOJt84ymT6Fv2qg7z2FJfGJI8jV80GfghgLIf
         Ahn3ay3Z2fbjtbe9QImrtR9rgOKK8N0rvf4qHfMzjtx2kNxQIsvaDQHX1l5GVuQ8+EzA
         64zAB9rqVoUXV5EU9FLcZa1Hx/4lGEjKHmYND/BelC9HPxmEMKlk082B8dGXdbOP7eHU
         Zra++sPBhA+UjA7B7ZTJOaO5TDCh6fxh/c8BITN5aeJSS8DT6V+IdXBR5EdLR8YrxQO+
         Fi9A==
X-Gm-Message-State: AC+VfDytaDcQHB4i9Wiqz0ZqGAc2kw8ZySnBLPKK2Sh9ZDpyEgAwCxsh
        EmhWjYqmOm+0aAcZxuynLYY+VkKmsiUVlw==
X-Google-Smtp-Source: ACHHUZ5q+w4lEU9D1Neg+PUv86lhh+GOtSrfLqkjFoJzVG4sIFnsELku7XWZUQFFRcvw+ZMJMB5RXQ==
X-Received: by 2002:a6b:f102:0:b0:763:b459:a701 with SMTP id e2-20020a6bf102000000b00763b459a701mr14662357iog.1.1687291722995;
        Tue, 20 Jun 2023 13:08:42 -0700 (PDT)
Received: from azeems-kspp.c.googlers.com.com (54.70.188.35.bc.googleusercontent.com. [35.188.70.54])
        by smtp.gmail.com with ESMTPSA id i5-20020a02c605000000b0040fc56ad9fasm870737jan.9.2023.06.20.13.08.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Jun 2023 13:08:42 -0700 (PDT)
From:   Azeem Shaikh <azeemshaikh38@gmail.com>
To:     Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Biggers <ebiggers@kernel.org>
Cc:     linux-hardening@vger.kernel.org,
        Azeem Shaikh <azeemshaikh38@gmail.com>,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2] crypto: Replace strlcpy with strscpy
Date:   Tue, 20 Jun 2023 20:08:32 +0000
Message-ID: <20230620200832.3379741-1-azeemshaikh38@gmail.com>
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

Direct replacement is safe here since return value of -errno
is used to check for truncation instead of sizeof(dest).

[1] https://www.kernel.org/doc/html/latest/process/deprecated.html#strlcpy
[2] https://github.com/KSPP/linux/issues/89

Signed-off-by: Azeem Shaikh <azeemshaikh38@gmail.com>
---
v2:
 * Use "int len" instead of "unsigned len" to hold return value of strscpy.

v1:
 * https://lore.kernel.org/all/20230613002258.3535506-1-azeemshaikh38@gmail.com/

 crypto/lrw.c |    6 +++---
 crypto/xts.c |    6 +++---
 2 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/crypto/lrw.c b/crypto/lrw.c
index 1b0f76ba3eb5..59260aefed28 100644
--- a/crypto/lrw.c
+++ b/crypto/lrw.c
@@ -357,10 +357,10 @@ static int lrw_create(struct crypto_template *tmpl, struct rtattr **tb)
 	 * cipher name.
 	 */
 	if (!strncmp(cipher_name, "ecb(", 4)) {
-		unsigned len;
+		int len;
 
-		len = strlcpy(ecb_name, cipher_name + 4, sizeof(ecb_name));
-		if (len < 2 || len >= sizeof(ecb_name))
+		len = strscpy(ecb_name, cipher_name + 4, sizeof(ecb_name));
+		if (len < 2)
 			goto err_free_inst;
 
 		if (ecb_name[len - 1] != ')')
diff --git a/crypto/xts.c b/crypto/xts.c
index 09be909a6a1a..548b302c6c6a 100644
--- a/crypto/xts.c
+++ b/crypto/xts.c
@@ -396,10 +396,10 @@ static int xts_create(struct crypto_template *tmpl, struct rtattr **tb)
 	 * cipher name.
 	 */
 	if (!strncmp(cipher_name, "ecb(", 4)) {
-		unsigned len;
+		int len;
 
-		len = strlcpy(ctx->name, cipher_name + 4, sizeof(ctx->name));
-		if (len < 2 || len >= sizeof(ctx->name))
+		len = strscpy(ctx->name, cipher_name + 4, sizeof(ctx->name));
+		if (len < 2)
 			goto err_free_inst;
 
 		if (ctx->name[len - 1] != ')')
-- 
2.41.0.162.gfafddb0af9-goog


