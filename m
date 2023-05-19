Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7BD937091AC
	for <lists+linux-kernel@lfdr.de>; Fri, 19 May 2023 10:29:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229951AbjESI3J (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 May 2023 04:29:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229611AbjESI3H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 May 2023 04:29:07 -0400
Received: from 167-179-156-38.a7b39c.syd.nbn.aussiebb.net (167-179-156-38.a7b39c.syd.nbn.aussiebb.net [167.179.156.38])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89943E56;
        Fri, 19 May 2023 01:29:04 -0700 (PDT)
Received: from loth.rohan.me.apana.org.au ([192.168.167.2])
        by formenos.hmeau.com with smtp (Exim 4.94.2 #2 (Debian))
        id 1pzvTU-00AnM5-Tz; Fri, 19 May 2023 16:28:34 +0800
Received: by loth.rohan.me.apana.org.au (sSMTP sendmail emulation); Fri, 19 May 2023 16:28:32 +0800
From:   "Herbert Xu" <herbert@gondor.apana.org.au>
Date:   Fri, 19 May 2023 16:28:32 +0800
Subject: [PATCH 1/3] crypto: cmac - Use modern init_tfm/exit_tfm
References: <ZGcyuyjJwZhdYS/G@gondor.apana.org.au>
To:     Dmitry Safonov <dima@arista.com>,
        Linux Crypto Mailing List <linux-crypto@vger.kernel.org>,
        linux-kernel@vger.kernel.org, David Ahern <dsahern@kernel.org>,
        Eric Dumazet <edumazet@google.com>,
        Paolo Abeni <pabeni@redhat.com>,
        Jakub Kicinski <kuba@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Andy Lutomirski <luto@amacapital.net>,
        Ard Biesheuvel <ardb@kernel.org>,
        Bob Gilligan <gilligan@arista.com>,
        Dan Carpenter <error27@gmail.com>,
        David Laight <David.Laight@aculab.com>,
        Dmitry Safonov <0x7f454c46@gmail.com>,
        Eric Biggers <ebiggers@kernel.org>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Francesco Ruggeri <fruggeri05@gmail.com>,
        Hideaki YOSHIFUJI <yoshfuji@linux-ipv6.org>,
        Ivan Delalande <colona@arista.com>,
        Leonard Crestez <cdleonard@gmail.com>,
        Salam Noureddine <noureddine@arista.com>,
        netdev@vger.kernel.org
Message-Id: <E1pzvTU-00AnM5-Tz@formenos.hmeau.com>
X-Spam-Status: No, score=2.7 required=5.0 tests=BAYES_00,HELO_DYNAMIC_IPADDR2,
        RDNS_DYNAMIC,SPF_HELO_NONE,SPF_PASS,TVD_RCVD_IP,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: **
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use the modern init_tfm/exit_tfm interface instead of the obsolete
cra_init/cra_exit interface.
   
Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>
---

 crypto/cmac.c |   18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/crypto/cmac.c b/crypto/cmac.c
index f4a5d3bfb376..bcc6f19a4f64 100644
--- a/crypto/cmac.c
+++ b/crypto/cmac.c
@@ -198,13 +198,14 @@ static int crypto_cmac_digest_final(struct shash_desc *pdesc, u8 *out)
 	return 0;
 }
 
-static int cmac_init_tfm(struct crypto_tfm *tfm)
+static int cmac_init_tfm(struct crypto_shash *tfm)
 {
+	struct shash_instance *inst = shash_alg_instance(tfm);
+	struct cmac_tfm_ctx *ctx = crypto_shash_ctx(tfm);
+	struct crypto_cipher_spawn *spawn;
 	struct crypto_cipher *cipher;
-	struct crypto_instance *inst = (void *)tfm->__crt_alg;
-	struct crypto_cipher_spawn *spawn = crypto_instance_ctx(inst);
-	struct cmac_tfm_ctx *ctx = crypto_tfm_ctx(tfm);
 
+	spawn = shash_instance_ctx(inst);
 	cipher = crypto_spawn_cipher(spawn);
 	if (IS_ERR(cipher))
 		return PTR_ERR(cipher);
@@ -214,9 +215,9 @@ static int cmac_init_tfm(struct crypto_tfm *tfm)
 	return 0;
 };
 
-static void cmac_exit_tfm(struct crypto_tfm *tfm)
+static void cmac_exit_tfm(struct crypto_shash *tfm)
 {
-	struct cmac_tfm_ctx *ctx = crypto_tfm_ctx(tfm);
+	struct cmac_tfm_ctx *ctx = crypto_shash_ctx(tfm);
 	crypto_free_cipher(ctx->child);
 }
 
@@ -274,13 +275,12 @@ static int cmac_create(struct crypto_template *tmpl, struct rtattr **tb)
 		   ~(crypto_tfm_ctx_alignment() - 1))
 		+ alg->cra_blocksize * 2;
 
-	inst->alg.base.cra_init = cmac_init_tfm;
-	inst->alg.base.cra_exit = cmac_exit_tfm;
-
 	inst->alg.init = crypto_cmac_digest_init;
 	inst->alg.update = crypto_cmac_digest_update;
 	inst->alg.final = crypto_cmac_digest_final;
 	inst->alg.setkey = crypto_cmac_digest_setkey;
+	inst->alg.init_tfm = cmac_init_tfm;
+	inst->alg.exit_tfm = cmac_exit_tfm;
 
 	inst->free = shash_free_singlespawn_instance;
 
