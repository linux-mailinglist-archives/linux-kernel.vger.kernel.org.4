Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D704A721FF1
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Jun 2023 09:43:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229538AbjFEHna (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Jun 2023 03:43:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230311AbjFEHm4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Jun 2023 03:42:56 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54188DB;
        Mon,  5 Jun 2023 00:42:55 -0700 (PDT)
Date:   Mon, 05 Jun 2023 07:42:52 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1685950973;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Qw4cYUW8ZUoP4ccFH55Bc9+6nY6pcmlB9jT84aOWEKQ=;
        b=ljIhzQ6bpvgBelb7c0qfVlU6cp4qFxPSiz/ho6f66RIJlt81XupCfwRDWPtiGjR1YXiRyY
        3k+pXnL+IbHFX9IQTq2s+oEvE8l83uXR0NUtWq+UQTzUOBE3J93LB5j3CZ/nCp3BQ4XNxH
        u3YG3n8PgwSiOl0Z9a4PytfqJzW/dUvUUNxsd4OceMBli5VZNhSoSblLK/GZRek/GS6lG6
        QAP3eUXyY+XG6U/opUgwMmpULXfPH+Ow6DxEU9WWynbAT84Xx+EQBoV6K9+hde2qVzQPqi
        WaQs21Y3WoGajhy1MjW0m5xcjMlZTIQgamTs9ZWW/B/ay0bgio/EIqkYV16W4w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1685950973;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Qw4cYUW8ZUoP4ccFH55Bc9+6nY6pcmlB9jT84aOWEKQ=;
        b=aBV+DSEqz8FMzrJ6A07GsVZOhfY1NFEEo/AVmIglkRr1PRj+wrDmCvS3Iogq0gCuKSicR9
        4uptym5hXJ2yVlCw==
From:   "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: locking/core] cyrpto/b128ops: Remove struct u128
Cc:     "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Mark Rutland <mark.rutland@arm.com>,
        Herbert Xu <herbert@gondor.apana.org.au>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20230531132323.314826687@infradead.org>
References: <20230531132323.314826687@infradead.org>
MIME-Version: 1.0
Message-ID: <168595097260.404.2219524989563222493.tip-bot2@tip-bot2>
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

Commit-ID:     f413e724818c6482146218b3bcaf3d75b1317fc4
Gitweb:        https://git.kernel.org/tip/f413e724818c6482146218b3bcaf3d75b1317fc4
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Wed, 31 May 2023 15:08:34 +02:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Mon, 05 Jun 2023 09:36:35 +02:00

cyrpto/b128ops: Remove struct u128

Per git-grep u128_xor() and its related struct u128 are unused except
to implement {be,le}128_xor(). Remove them to free up the namespace.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Arnd Bergmann <arnd@arndb.de>
Reviewed-by: Mark Rutland <mark.rutland@arm.com>
Acked-by: Herbert Xu <herbert@gondor.apana.org.au>
Tested-by: Mark Rutland <mark.rutland@arm.com>
Link: https://lore.kernel.org/r/20230531132323.314826687@infradead.org
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
