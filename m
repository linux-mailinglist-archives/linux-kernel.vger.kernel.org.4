Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DCBBD6492E9
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Dec 2022 07:25:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229703AbiLKGZ4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 11 Dec 2022 01:25:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230142AbiLKGZk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Dec 2022 01:25:40 -0500
Received: from formenos.hmeau.com (helcar.hmeau.com [216.24.177.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F7C9DE98;
        Sat, 10 Dec 2022 22:22:44 -0800 (PST)
Received: from loth.rohan.me.apana.org.au ([192.168.167.2])
        by formenos.hmeau.com with smtp (Exim 4.94.2 #2 (Debian))
        id 1p4FjJ-006AjA-Hk; Sun, 11 Dec 2022 14:22:30 +0800
Received: by loth.rohan.me.apana.org.au (sSMTP sendmail emulation); Sun, 11 Dec 2022 14:22:29 +0800
Date:   Sun, 11 Dec 2022 14:22:29 +0800
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     "Chen, Rong A" <rong.a.chen@intel.com>
Cc:     kernel test robot <lkp@intel.com>,
        "Jason A. Donenfeld" <zx2c4@kernel.org>,
        oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
        Linux Crypto Mailing List <linux-crypto@vger.kernel.org>
Subject: [PATCH] crypto: lib/blake2s - Split up test function to halve stack
 usage
Message-ID: <Y5V3JUL+r4k/XrL9@gondor.apana.org.au>
References: <202211072109.qvrnjNKo-lkp@intel.com>
 <Y5Flnb8jadyDebx3@gondor.apana.org.au>
 <d25ac395-4335-be88-9dc5-364f5715554f@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d25ac395-4335-be88-9dc5-364f5715554f@intel.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 08, 2022 at 02:37:45PM +0800, Chen, Rong A wrote:
>
> Thanks for the information, I checked the result of the fix commit,
> it reduced the stack frame but the warning still exists:
> 
> lib/crypto/blake2s-selftest.c:632:1: warning: the frame size of 1056 bytes
> is larger than 1024 bytes [-Wframe-larger-than=]

Sorry, I didn't realise that you could still reproduce it.  I tried
reproducing it on multiple architectures and failed (all were in
the 900 range).

Anyhow, this patch reduces it by half for me so hopefully it should
put this to rest.

---8<---
Reduce the stack usage further by splitting up the test function.

Also squash blocks and unaligned_blocks into one array.

Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>

diff --git a/lib/crypto/blake2s-selftest.c b/lib/crypto/blake2s-selftest.c
index 7d77dea15587..484b89332c83 100644
--- a/lib/crypto/blake2s-selftest.c
+++ b/lib/crypto/blake2s-selftest.c
@@ -545,7 +545,7 @@ static const u8 blake2s_testvecs[][BLAKE2S_HASH_SIZE] __initconst = {
     0xd6, 0x98, 0x6b, 0x07, 0x10, 0x65, 0x52, 0x65, },
 };
 
-bool __init blake2s_selftest(void)
+static bool __init blake2s_digest_test(void)
 {
 	u8 key[BLAKE2S_KEY_SIZE];
 	u8 buf[ARRAY_SIZE(blake2s_testvecs)];
@@ -589,11 +589,20 @@ bool __init blake2s_selftest(void)
 		}
 	}
 
+	return success;
+}
+
+static bool __init blake2s_random_test(void)
+{
+	struct blake2s_state state;
+	bool success = true;
+	int i, l;
+
 	for (i = 0; i < 32; ++i) {
 		enum { TEST_ALIGNMENT = 16 };
-		u8 unaligned_block[BLAKE2S_BLOCK_SIZE + TEST_ALIGNMENT - 1]
+		u8 blocks[BLAKE2S_BLOCK_SIZE * 2 + TEST_ALIGNMENT - 1]
 					__aligned(TEST_ALIGNMENT);
-		u8 blocks[BLAKE2S_BLOCK_SIZE * 2];
+		u8 *unaligned_block = blocks + BLAKE2S_BLOCK_SIZE;
 		struct blake2s_state state1, state2;
 
 		get_random_bytes(blocks, sizeof(blocks));
@@ -630,3 +639,13 @@ bool __init blake2s_selftest(void)
 
 	return success;
 }
+
+bool __init blake2s_selftest(void)
+{
+	bool success;
+
+	success = blake2s_digest_test();
+	success &= blake2s_random_test();
+
+	return success;
+}
Thanks,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
