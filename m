Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E74970BA25
	for <lists+linux-kernel@lfdr.de>; Mon, 22 May 2023 12:28:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232183AbjEVK2X (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 May 2023 06:28:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232779AbjEVK1f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 May 2023 06:27:35 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 930DB18B;
        Mon, 22 May 2023 03:27:32 -0700 (PDT)
Date:   Mon, 22 May 2023 10:27:29 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1684751250;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=VzyXP4hVCcK/17zriU+/w8Hkk7jEXR8ezZjpNt1ijzw=;
        b=KV7rQe3QqrzhCajSCyUPwCF7iMiJUYmaYX//d/vm6b5yfJRCWkHrLbbB81swygc/xMjyEG
        aW7EwXQKN59Xytwt47YPP+0rcJeo26TwFi9upOD/bbIB8eiKaVIcIoVw5diqUG3Q7IqPYi
        CyYTvZ8QDCb75DlaRkAEMusjI7gEsAU4FywpsS3R5gsQ+MBXCnqMIW0EFolQ/NJR8Dyvt/
        WNnDN+pe9+Y8Yqr7OkFKh2LobwPWRLYjd17XqRbj8Mogpb5OB3n5enGCAG/ivJ9+NdC/rU
        Ez55sBKJsHA0rnCaVR9pw1utMooz9+MpE22gzZJPf5yMhZxAwzEB2RYsrhOapg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1684751250;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=VzyXP4hVCcK/17zriU+/w8Hkk7jEXR8ezZjpNt1ijzw=;
        b=X4F3f7HZiDY+E1qAi5RygmT+22tyBF5mhiu2Fm93r1Bs/B9LjTcgp/go5vwxY10nMMZhZE
        UDU/Y8w/GVpd0rCg==
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
Message-ID: <168475124977.404.12847931801053325944.tip-bot2@tip-bot2>
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

Commit-ID:     a42d381f16c00d894ef56e579035d8db3552bc61
Gitweb:        https://git.kernel.org/tip/a42d381f16c00d894ef56e579035d8db3552bc61
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Mon, 15 May 2023 09:57:00 +02:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Mon, 22 May 2023 10:49:48 +02:00

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
