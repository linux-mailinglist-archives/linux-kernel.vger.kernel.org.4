Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 87EE66B8A07
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Mar 2023 06:02:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229665AbjCNFCv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Mar 2023 01:02:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229486AbjCNFCt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Mar 2023 01:02:49 -0400
Received: from 167-179-156-38.a7b39c.syd.nbn.aussiebb.net (167-179-156-38.a7b39c.syd.nbn.aussiebb.net [167.179.156.38])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F90B6F4A2;
        Mon, 13 Mar 2023 22:02:46 -0700 (PDT)
Received: from loth.rohan.me.apana.org.au ([192.168.167.2])
        by formenos.hmeau.com with smtp (Exim 4.94.2 #2 (Debian))
        id 1pbwo3-003zBJ-Lv; Tue, 14 Mar 2023 13:02:40 +0800
Received: by loth.rohan.me.apana.org.au (sSMTP sendmail emulation); Tue, 14 Mar 2023 13:02:39 +0800
Date:   Tue, 14 Mar 2023 13:02:39 +0800
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Linux Crypto List <linux-crypto@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: [PATCH] crypto: hash - Fix kdoc errors about HASH_ALG_COMMON
Message-ID: <ZA//781k0UXRIKdW@gondor.apana.org.au>
References: <20230314141947.18574ae8@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230314141947.18574ae8@canb.auug.org.au>
X-Spam-Status: No, score=2.7 required=5.0 tests=BAYES_00,HELO_DYNAMIC_IPADDR2,
        PDS_RDNS_DYNAMIC_FP,RDNS_DYNAMIC,SPF_HELO_NONE,SPF_PASS,TVD_RCVD_IP,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: **
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 14, 2023 at 02:19:47PM +1100, Stephen Rothwell wrote:
> Hi all,
> 
> After merging the crypto tree, today's linux-next build (htmldocs)
> produced these warnings:
> 
> include/crypto/hash.h:69: error: Cannot parse struct or union!
> include/crypto/hash.h:69: error: Cannot parse struct or union!
> include/crypto/hash.h:245: warning: Function parameter or member 'HASH_ALG_COMMON' not described in 'shash_alg'
> include/crypto/hash.h:69: error: Cannot parse struct or union!
> include/crypto/hash.h:69: error: Cannot parse struct or union!
> include/crypto/hash.h:69: error: Cannot parse struct or union!
> include/crypto/hash.h:69: error: Cannot parse struct or union!
> include/crypto/hash.h:69: error: Cannot parse struct or union!
> include/crypto/hash.h:69: error: Cannot parse struct or union!
> 
> Introduced by commit
> 
>   0e4e6d7094df ("crypto: hash - Count error stats differently")

Thanks for the report Stephen.  I hope this patch makes them go
away:

---8<---
The HASH_ALG_COMMON macro cannot be parsed by kdoc so mark it as
a normal comment instead of kdoc.  Also add HASH_ALG_COMMON as a
structure member of shash_alg.

Fixes: 0e4e6d7094df ("crypto: hash - Count error stats differently")
Reported-by: Stephen Rothwell <sfr@canb.auug.org.au>
Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>

diff --git a/include/crypto/hash.h b/include/crypto/hash.h
index 2aa61e7679db..1ed674ba8429 100644
--- a/include/crypto/hash.h
+++ b/include/crypto/hash.h
@@ -41,7 +41,7 @@ struct crypto_istat_hash {
 #define HASH_ALG_COMMON_STAT
 #endif
 
-/**
+/*
  * struct hash_alg_common - define properties of message digest
  * @stat: Statistics for hash algorithm.
  * @digestsize: Size of the result of the transformation. A buffer of this size
@@ -219,6 +219,7 @@ struct shash_desc {
  * @stat: Statistics for hash algorithm.
  * @base: internally used
  * @halg: see struct hash_alg_common
+ * @HASH_ALG_COMMON: see struct hash_alg_common
  */
 struct shash_alg {
 	int (*init)(struct shash_desc *desc);
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
