Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 219E570A74A
	for <lists+linux-kernel@lfdr.de>; Sat, 20 May 2023 12:49:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231630AbjETKtc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 20 May 2023 06:49:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231586AbjETKtJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 20 May 2023 06:49:09 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CCFC4E49;
        Sat, 20 May 2023 03:49:07 -0700 (PDT)
Date:   Sat, 20 May 2023 10:49:05 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1684579745;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=d9heDPoj8Z+mlwzB7nznnw7IVG9CDvfDKPj3o7QB/QI=;
        b=lbCnvci1LFsz8fckqAtPkqvVx0bT8X0mGeRIPDnayPs5yOAYfYRpZBqtPEIRn1V2xbHxYx
        eSug79/hchrmu420WeDzvno0Y61e/jihNov1Fgth2nfp30M44vpps2/GUo90QGZcQWj4XA
        uveSDuXP5wLUKFcMzo/uJ639QI4IbOL8SrAmHqDo9CqPnxvdvf6nroe862dmc89yJgX3S9
        8wTjRYqL4n4Urm0NVcRUm0b0im2uEnBtmtQh3M4Y7jLGGbYozySyG4bdyg4GGK2I5TRlR9
        k1RXjULxNMYHq1DEFvMLY2ym95rALVZ3AoqycZXq+DJW8alpSNrsYI4tF0AvIA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1684579745;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=d9heDPoj8Z+mlwzB7nznnw7IVG9CDvfDKPj3o7QB/QI=;
        b=pXQKucuo86m0ZT05l/H5JkWBT4PjmxfQmsPdvX1oj7q1UxINKHAIp3HuXJYTfoSxLa+t6y
        71QBAVYjS9bq6RAw==
From:   "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: locking/core] cyrpto/b128ops: Remove struct u128
Cc:     "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Herbert Xu <herbert@gondor.apana.org.au>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20230515080553.979680310@infradead.org>
References: <20230515080553.979680310@infradead.org>
MIME-Version: 1.0
Message-ID: <168457974513.404.3421776135547286788.tip-bot2@tip-bot2>
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

Commit-ID:     f49a2237d34009e1623fd04a5f3c34ea39dd5792
Gitweb:        https://git.kernel.org/tip/f49a2237d34009e1623fd04a5f3c34ea39dd5792
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Mon, 15 May 2023 09:57:00 +02:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Fri, 19 May 2023 12:35:10 +02:00

cyrpto/b128ops: Remove struct u128

Per git-grep u128_xor() and its related struct u128 are unused except
to implement {be,le}128_xor(). Remove them to free up the namespace.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Arnd Bergmann <arnd@arndb.de>
Acked-by: Herbert Xu <herbert@gondor.apana.org.au>
Link: https://lore.kernel.org/r/20230515080553.979680310@infradead.org
---
 include/crypto/b128ops.h | 14 +++-----------
 1 file changed, 3 insertions(+), 11 deletions(-)

diff --git a/include/crypto/b128ops.h b/include/crypto/b128ops.h
index 0b8e6bc..f3b37cb 100644
--- a/include/crypto/b128ops.h
+++ b/include/crypto/b128ops.h
@@ -50,10 +50,6 @@
 #include <linux/types.h>
 
 typedef struct {
-	u64 a, b;
-} u128;
-
-typedef struct {
 	__be64 a, b;
 } be128;
 
@@ -61,20 +57,16 @@ typedef struct {
 	__le64 b, a;
 } le128;
 
-static inline void u128_xor(u128 *r, const u128 *p, const u128 *q)
+static inline void be128_xor(be128 *r, const be128 *p, const be128 *q)
 {
 	r->a = p->a ^ q->a;
 	r->b = p->b ^ q->b;
 }
 
-static inline void be128_xor(be128 *r, const be128 *p, const be128 *q)
-{
-	u128_xor((u128 *)r, (u128 *)p, (u128 *)q);
-}
-
 static inline void le128_xor(le128 *r, const le128 *p, const le128 *q)
 {
-	u128_xor((u128 *)r, (u128 *)p, (u128 *)q);
+	r->a = p->a ^ q->a;
+	r->b = p->b ^ q->b;
 }
 
 #endif /* _CRYPTO_B128OPS_H */
