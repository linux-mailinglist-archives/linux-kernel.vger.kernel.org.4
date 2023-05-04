Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C50436F6856
	for <lists+linux-kernel@lfdr.de>; Thu,  4 May 2023 11:33:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229915AbjEDJdk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 May 2023 05:33:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230023AbjEDJdJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 May 2023 05:33:09 -0400
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93A1E49C0;
        Thu,  4 May 2023 02:33:07 -0700 (PDT)
Received: by mail-pf1-x42f.google.com with SMTP id d2e1a72fcca58-6438d95f447so165567b3a.3;
        Thu, 04 May 2023 02:33:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683192787; x=1685784787;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=lBOT6ucg6ng9qBkKlorD62fyrVLYVgD1ftPso5pMrEM=;
        b=D8eFhT00Xes9DNAgtmKZUycfUY1lAYrerwL3VrA7JsqResg/EsYF6SZLQZfnhyH1Sz
         FRCZK2pVrKdZlpolhCOuwWUtNg5lNEb2+D32SQfupFBKOwKYqADlYTzfpCsSNaeiHlP2
         JiJ9nqLsRj4oSSmUvtd0ZTx1zkWm06FkfMeF3LCCUaOxUjTLxplv/CMLkXPU3u5+qY5D
         FnUj+ZqHBY32dlGnWzk/rYxY97prPDXSuK2iWJOE8/UJ6qErny5+dYVChzgKL40yxyCp
         aUq1IjyCTg1l5GxtZuN3fL0AWhnKctJhsJanvYgxBYGJoUrq7ZwNsI0wh/l9UFrsKrKZ
         HUdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683192787; x=1685784787;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lBOT6ucg6ng9qBkKlorD62fyrVLYVgD1ftPso5pMrEM=;
        b=OfySO9Us7HO/MQXc2yo5qb19L2uwb8lJtNAli+QxO7P00keeTW01BDUPypu/8UrdzS
         rBvJwiY+9VP3xFv/rIpkviBjN5cxMOwvMxCFwnfaoW9i88jcH1POsWaeKB3heVYUMztm
         N0hFuOL8jeuYdN99DsGIBNJwitL/Ji7sD+HQYFr0WHA/ke2fDE9Sr4OOiy6x2vMYi3VF
         cgJ9FAwHpkcU9AjtXZh83uGXAGgMCb9Cq6ysUOZRgpqlnHOzmVoKv0QqJLgyfP5K9fmh
         NO/sb4xdfk8XC3A0vpU/Cr/nJPWTSGoNFmG2ILVmLTRM1/Qp1dmqj8dnLvP0B2wDqo2Q
         gYuw==
X-Gm-Message-State: AC+VfDzfw4cQqvFYIQS2jFyPh2UbxW5XeoB6Zb941vKm12RMdZu7gvJK
        Gux3CxFxNo/YaLPE0cfV85wGkal7euWc8TWX
X-Google-Smtp-Source: ACHHUZ6Os3kbSJ6nqmpuqdft3dAzDrQockhYs2liKbJvHrfD1U7kv4v6rrtNxLoYs1Xtm8nbRnxmdw==
X-Received: by 2002:a05:6a00:ad3:b0:643:aa2:4dd0 with SMTP id c19-20020a056a000ad300b006430aa24dd0mr1706733pfl.9.1683192786747;
        Thu, 04 May 2023 02:33:06 -0700 (PDT)
Received: from d.home.yangfl.dn42 ([104.28.245.199])
        by smtp.gmail.com with ESMTPSA id q14-20020aa7842e000000b00640dbf177b8sm18765163pfn.37.2023.05.04.02.33.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 May 2023 02:33:06 -0700 (PDT)
From:   David Yang <mmyangfl@gmail.com>
To:     linux-crypto@vger.kernel.org
Cc:     David Yang <mmyangfl@gmail.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] crypto: hash - Add default handlers for digest, export, import
Date:   Thu,  4 May 2023 17:32:55 +0800
Message-Id: <20230504093255.350365-1-mmyangfl@gmail.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The document of struct ahash_alg explicitly states that @finup,
combination of @update and @final, is optional, while said nothing about
@digest, which is combination of @init and @finup (@update and @final).

This gives a illusion that @digest might be optional. However
crypto_ahash_init_tfm() strangely does expect a non-NULL @digest,
otherwise it'll result in NULL pointer dereference.

Add default handlers for digest, export, import according to the behavior
in the document, and mark them optional.

Signed-off-by: David Yang <mmyangfl@gmail.com>
---
 crypto/ahash.c        | 28 +++++++++++++++++++++++++---
 include/crypto/hash.h | 12 ++++++------
 2 files changed, 31 insertions(+), 9 deletions(-)

diff --git a/crypto/ahash.c b/crypto/ahash.c
index b8a607928e72..53abbfe58a5f 100644
--- a/crypto/ahash.c
+++ b/crypto/ahash.c
@@ -417,6 +417,28 @@ static int ahash_def_finup(struct ahash_request *req)
 	return ahash_def_finup_finish1(req, err);
 }
 
+static int ahash_def_digest(struct ahash_request *req)
+{
+	struct crypto_ahash *tfm = crypto_ahash_reqtfm(req);
+	int err;
+
+	err = tfm->init(req);
+	if (err)
+		return err;
+
+	return ahash_def_finup(req);
+}
+
+static int ahash_def_noexport(struct ahash_request *req, void *out)
+{
+	return -EINVAL;
+}
+
+static int ahash_def_noimport(struct ahash_request *req, const void *in)
+{
+	return -EINVAL;
+}
+
 static void crypto_ahash_exit_tfm(struct crypto_tfm *tfm)
 {
 	struct crypto_ahash *hash = __crypto_ahash_cast(tfm);
@@ -439,9 +461,9 @@ static int crypto_ahash_init_tfm(struct crypto_tfm *tfm)
 	hash->update = alg->update;
 	hash->final = alg->final;
 	hash->finup = alg->finup ?: ahash_def_finup;
-	hash->digest = alg->digest;
-	hash->export = alg->export;
-	hash->import = alg->import;
+	hash->digest = alg->digest ?: ahash_def_digest;
+	hash->export = alg->export ?: ahash_def_noexport;
+	hash->import = alg->import ?: ahash_def_noimport;
 
 	if (alg->setkey) {
 		hash->setkey = alg->setkey;
diff --git a/include/crypto/hash.h b/include/crypto/hash.h
index e69542d86a2b..17dee80ac76a 100644
--- a/include/crypto/hash.h
+++ b/include/crypto/hash.h
@@ -1,7 +1,7 @@
 /* SPDX-License-Identifier: GPL-2.0-or-later */
 /*
  * Hash: Hash algorithms under the crypto API
- * 
+ *
  * Copyright (c) 2008 Herbert Xu <herbert@gondor.apana.org.au>
  */
 
@@ -110,7 +110,7 @@ struct ahash_request {
  *	   added to allow such hardware to be used at least by IPsec. Data
  *	   processing can happen synchronously [SHASH] or asynchronously [AHASH]
  *	   at this point.
- * @digest: Combination of @init and @update and @final. This function
+ * @digest: **[optional]** Combination of @init and @update and @final. This function
  *	    effectively behaves as the entire chain of operations, @init,
  *	    @update and @final issued in sequence. Just like @finup, this was
  *	    added for hardware which cannot do even the @finup, but can only do
@@ -129,15 +129,15 @@ struct ahash_request {
  *	    this function. This function must be called before any other of the
  *	    @init, @update, @final, @finup, @digest is called. No data
  *	    processing happens at this point.
- * @export: Export partial state of the transformation. This function dumps the
- *	    entire state of the ongoing transformation into a provided block of
+ * @export: **[optional]** Export partial state of the transformation. This function
+ *	    dumps the entire state of the ongoing transformation into a provided block of
  *	    data so it can be @import 'ed back later on. This is useful in case
  *	    you want to save partial result of the transformation after
  *	    processing certain amount of data and reload this partial result
  *	    multiple times later on for multiple re-use. No data processing
  *	    happens at this point. Driver must not use req->result.
- * @import: Import partial state of the transformation. This function loads the
- *	    entire state of the ongoing transformation from a provided block of
+ * @import: **[optional]** Import partial state of the transformation. This function
+ *	    loads the entire state of the ongoing transformation from a provided block of
  *	    data so the transformation can continue from this point onward. No
  *	    data processing happens at this point. Driver must not use
  *	    req->result.
-- 
2.39.2

