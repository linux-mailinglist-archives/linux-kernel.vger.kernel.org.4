Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2FFE970A747
	for <lists+linux-kernel@lfdr.de>; Sat, 20 May 2023 12:49:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231651AbjETKtV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 20 May 2023 06:49:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231409AbjETKtI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 20 May 2023 06:49:08 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F9FBE5D;
        Sat, 20 May 2023 03:49:07 -0700 (PDT)
Date:   Sat, 20 May 2023 10:49:04 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1684579745;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=aH2Ohb05YwZe/otHvSs0r1c79czQSc9dK7wj6jHNME8=;
        b=nTbaTzh6aXgROOF+Hq16W3DA/QPy1SBux6oo0LAszaNFP5YuSVIFKEsljTfTy9f5OkGjEJ
        zDMWN8Uq7g8zioYdU+6O1whdUIlnRQQymmgQ3dgGHTCKD6KdJf3vP1TGkhDXW8dmicIQGr
        EfVdOmc1Mk95X2n3Bsal4/5PdMsXnyeAQuIQD0reX48E5grc/myy/m6e4PJnRwFnie6LAs
        YVsUgFIcZ2nwriPp+bgAiWalVturI+S6BAN4NgxYPydOgbG+kfa6ZR0ZKeGphp4Pa7+wlV
        1TFUamOvkETkfWmKf8OL8N8NkmNUvwmaENjymo4gYpxT+zs5ePtopZke1/3asA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1684579745;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=aH2Ohb05YwZe/otHvSs0r1c79czQSc9dK7wj6jHNME8=;
        b=l//Iih+LaVgiukaUpZ0p6OjTkxEpnGBfKwQm1Kdrb0oS4SGiZnS3L4oSj6kobddtEE/glh
        EJwpkewjIaymQnCw==
From:   "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: locking/core] types: Introduce [us]128
Cc:     "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Herbert Xu <herbert@gondor.apana.org.au>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20230515080554.047618712@infradead.org>
References: <20230515080554.047618712@infradead.org>
MIME-Version: 1.0
Message-ID: <168457974454.404.3651021680456124884.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the locking/core branch of tip:

Commit-ID:     1fbd899da7d7a5eb7dd81404d37342b4de95f48f
Gitweb:        https://git.kernel.org/tip/1fbd899da7d7a5eb7dd81404d37342b4de95f48f
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Mon, 15 May 2023 09:57:01 +02:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Fri, 19 May 2023 12:35:11 +02:00

types: Introduce [us]128

Introduce [us]128 (when available). Unlike [us]64, ensure they are
always naturally aligned.

This also enables 128bit wide atomics (which require natural
alignment) such as cmpxchg128().

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Arnd Bergmann <arnd@arndb.de>
Acked-by: Herbert Xu <herbert@gondor.apana.org.au>
Link: https://lore.kernel.org/r/20230515080554.047618712@infradead.org
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
