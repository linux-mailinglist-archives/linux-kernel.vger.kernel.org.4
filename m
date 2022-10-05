Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 43EDD5F52FF
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Oct 2022 12:59:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229711AbiJEK7W (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Oct 2022 06:59:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229479AbiJEK7T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Oct 2022 06:59:19 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 606CD6AE8F
        for <linux-kernel@vger.kernel.org>; Wed,  5 Oct 2022 03:59:18 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 1BD20B81D88
        for <linux-kernel@vger.kernel.org>; Wed,  5 Oct 2022 10:59:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7917FC433D6
        for <linux-kernel@vger.kernel.org>; Wed,  5 Oct 2022 10:59:15 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
        dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="aQyqy5xf"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
        t=1664967552;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=SeIqOnySPgviGSYFWL8DwzU96/adio0utr2HXDNSrFs=;
        b=aQyqy5xf/1KEy7mwN63jbEMu5QbExsdgQCPFK04YYzXwTnzPDrI/GmJ0KXdfApq/vMzdso
        7y7w2oV8vnETy/FvygT56kdaMX6cOZbXFI0eamDFLjvqHGK/BVDllRIbOT010qUexr5wJu
        +cBtjpTz9jfk3ck/7s8BC+0uHDNQiBA=
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 82cb4499 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
        Wed, 5 Oct 2022 10:59:11 +0000 (UTC)
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
To:     linux-kernel@vger.kernel.org
Cc:     "Jason A. Donenfeld" <Jason@zx2c4.com>
Subject: [PATCH] random: clear new batches when bringing new CPUs online
Date:   Wed,  5 Oct 2022 12:58:59 +0200
Message-Id: <20221005105859.10203-1-Jason@zx2c4.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-6.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The commit that added the new get_random_{u8,u16}() functions neglected
to update the code that clears the batches when bringing up a new CPU,
as well as the various comments.

Fixes: 585cd5fe9f73 ("random: add 8-bit and 16-bit batches")
Signed-off-by: Jason A. Donenfeld <Jason@zx2c4.com>
---
 drivers/char/random.c | 24 ++++++++++++++----------
 1 file changed, 14 insertions(+), 10 deletions(-)

diff --git a/drivers/char/random.c b/drivers/char/random.c
index a007e3dad80f..14e4c4dc7c7f 100644
--- a/drivers/char/random.c
+++ b/drivers/char/random.c
@@ -119,9 +119,9 @@ static void try_to_generate_entropy(void);
 /*
  * Wait for the input pool to be seeded and thus guaranteed to supply
  * cryptographically secure random numbers. This applies to: the /dev/urandom
- * device, the get_random_bytes function, and the get_random_{u32,u64,int,long}
- * family of functions. Using any of these functions without first calling
- * this function forfeits the guarantee of security.
+ * device, the get_random_bytes function, and the get_random_{u8,u16,u32,u64,
+ * int,long} family of functions. Using any of these functions without first
+ * calling this function forfeits the guarantee of security.
  *
  * Returns: 0 if the input pool has been seeded.
  *          -ERESTARTSYS if the function was interrupted by a signal.
@@ -157,6 +157,8 @@ EXPORT_SYMBOL(wait_for_random_bytes);
  * There are a few exported interfaces for use by other drivers:
  *
  *	void get_random_bytes(void *buf, size_t len)
+ *	u8 get_random_u8()
+ *	u16 get_random_u16()
  *	u32 get_random_u32()
  *	u64 get_random_u64()
  *	unsigned int get_random_int()
@@ -164,10 +166,10 @@ EXPORT_SYMBOL(wait_for_random_bytes);
  *
  * These interfaces will return the requested number of random bytes
  * into the given buffer or as a return value. This is equivalent to
- * a read from /dev/urandom. The u32, u64, int, and long family of
- * functions may be higher performance for one-off random integers,
- * because they do a bit of buffering and do not invoke reseeding
- * until the buffer is emptied.
+ * a read from /dev/urandom. The u8, u16, u32, u64, int, and long
+ * family of functions may be higher performance for one-off random
+ * integers, because they do a bit of buffering and do not invoke
+ * reseeding until the buffer is emptied.
  *
  *********************************************************************/
 
@@ -504,10 +506,10 @@ type get_random_ ##type(void)							\
 }										\
 EXPORT_SYMBOL(get_random_ ##type);
 
-DEFINE_BATCHED_ENTROPY(u64)
-DEFINE_BATCHED_ENTROPY(u32)
-DEFINE_BATCHED_ENTROPY(u16)
 DEFINE_BATCHED_ENTROPY(u8)
+DEFINE_BATCHED_ENTROPY(u16)
+DEFINE_BATCHED_ENTROPY(u32)
+DEFINE_BATCHED_ENTROPY(u64)
 
 #ifdef CONFIG_SMP
 /*
@@ -522,6 +524,8 @@ int __cold random_prepare_cpu(unsigned int cpu)
 	 * randomness.
 	 */
 	per_cpu_ptr(&crngs, cpu)->generation = ULONG_MAX;
+	per_cpu_ptr(&batched_entropy_u8, cpu)->position = UINT_MAX;
+	per_cpu_ptr(&batched_entropy_u16, cpu)->position = UINT_MAX;
 	per_cpu_ptr(&batched_entropy_u32, cpu)->position = UINT_MAX;
 	per_cpu_ptr(&batched_entropy_u64, cpu)->position = UINT_MAX;
 	return 0;
-- 
2.37.3

