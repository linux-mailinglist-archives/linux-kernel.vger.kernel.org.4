Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 32ED7721FEE
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Jun 2023 09:43:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231765AbjFEHnW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Jun 2023 03:43:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230348AbjFEHm4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Jun 2023 03:42:56 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56AF9DC;
        Mon,  5 Jun 2023 00:42:55 -0700 (PDT)
Date:   Mon, 05 Jun 2023 07:42:52 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1685950972;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=87LHS78qU0tXTJ4OWMNRvsdB8W6EhQkin3Tqf0S3DQs=;
        b=cagHLG0YrqGzvwb4ezKjZaql413Ins33mX+jnhNgGHGJIRYevw+Fw4ej2Io6MAPCwqaDZ6
        AR9Sb9bYdQHjnffT+4JJqQOszqVNGDcCFriJHcH4IjT3nK78tazt/flWVBm61EzFoJ++eX
        A4e9Zt28kf0P9hipVFBQPaN1SFMuN5nvrSYCi/OsnHptDPGjKbM9QauS887XQ+G8kJUpCT
        NDbIf6Lr341XJs+MntHhsAlpWLPQFP/vyt0EmI9W0XFt2Uyqx9m7pI3c7M6sNUdfKlJ8Ka
        G4z4oAJR+ePD9hfqRue7B9y0J8u6sg8o8YbJR1chepXD+A/d1V5i5Q4p0pZL3w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1685950972;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=87LHS78qU0tXTJ4OWMNRvsdB8W6EhQkin3Tqf0S3DQs=;
        b=ZnQvlu2bWsc1G++UbjofJynkkGdAnfNTKO9Md7TZsQoPq8DO50blo7HgYSOhsQzl2k2mjz
        3jeBWCoOxYcG8pAQ==
From:   "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: locking/core] types: Introduce [us]128
Cc:     "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Mark Rutland <mark.rutland@arm.com>,
        Herbert Xu <herbert@gondor.apana.org.au>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20230531132323.385005581@infradead.org>
References: <20230531132323.385005581@infradead.org>
MIME-Version: 1.0
Message-ID: <168595097228.404.8187769988838401263.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the locking/core branch of tip:

Commit-ID:     224d80c584d3016cb8d83d1c33914fdd3508aa8c
Gitweb:        https://git.kernel.org/tip/224d80c584d3016cb8d83d1c33914fdd3508aa8c
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Wed, 31 May 2023 15:08:35 +02:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Mon, 05 Jun 2023 09:36:35 +02:00

types: Introduce [us]128

Introduce [us]128 (when available). Unlike [us]64, ensure they are
always naturally aligned.

This also enables 128bit wide atomics (which require natural
alignment) such as cmpxchg128().

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Arnd Bergmann <arnd@arndb.de>
Reviewed-by: Mark Rutland <mark.rutland@arm.com>
Acked-by: Herbert Xu <herbert@gondor.apana.org.au>
Tested-by: Mark Rutland <mark.rutland@arm.com>
Link: https://lore.kernel.org/r/20230531132323.385005581@infradead.org
---
 include/linux/types.h          | 5 +++++
 include/uapi/linux/types.h     | 4 ++++
 lib/crypto/curve25519-hacl64.c | 2 --
 lib/crypto/poly1305-donna64.c  | 2 --
 4 files changed, 9 insertions(+), 4 deletions(-)

diff --git a/include/linux/types.h b/include/linux/types.h
index 688fb94..becb8cd 100644
--- a/include/linux/types.h
+++ b/include/linux/types.h
@@ -10,6 +10,11 @@
 #define DECLARE_BITMAP(name,bits) \
 	unsigned long name[BITS_TO_LONGS(bits)]
 
+#ifdef __SIZEOF_INT128__
+typedef __s128 s128;
+typedef __u128 u128;
+#endif
+
 typedef u32 __kernel_dev_t;
 
 typedef __kernel_fd_set		fd_set;
diff --git a/include/uapi/linux/types.h b/include/uapi/linux/types.h
index 308433b..6375a06 100644
--- a/include/uapi/linux/types.h
+++ b/include/uapi/linux/types.h
@@ -13,6 +13,10 @@
 
 #include <linux/posix_types.h>
 
+#ifdef __SIZEOF_INT128__
+typedef __signed__ __int128 __s128 __attribute__((aligned(16)));
+typedef unsigned __int128 __u128 __attribute__((aligned(16)));
+#endif
 
 /*
  * Below are truly Linux-specific types that should never collide with
diff --git a/lib/crypto/curve25519-hacl64.c b/lib/crypto/curve25519-hacl64.c
index 771d82d..c40e5d9 100644
--- a/lib/crypto/curve25519-hacl64.c
+++ b/lib/crypto/curve25519-hacl64.c
@@ -14,8 +14,6 @@
 #include <crypto/curve25519.h>
 #include <linux/string.h>
 
-typedef __uint128_t u128;
-
 static __always_inline u64 u64_eq_mask(u64 a, u64 b)
 {
 	u64 x = a ^ b;
diff --git a/lib/crypto/poly1305-donna64.c b/lib/crypto/poly1305-donna64.c
index d34cf40..988702c 100644
--- a/lib/crypto/poly1305-donna64.c
+++ b/lib/crypto/poly1305-donna64.c
@@ -10,8 +10,6 @@
 #include <asm/unaligned.h>
 #include <crypto/internal/poly1305.h>
 
-typedef __uint128_t u128;
-
 void poly1305_core_setkey(struct poly1305_core_key *key,
 			  const u8 raw_key[POLY1305_BLOCK_SIZE])
 {
