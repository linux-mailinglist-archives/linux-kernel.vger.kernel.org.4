Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B66BF6E0CCB
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Apr 2023 13:38:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230108AbjDMLij (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Apr 2023 07:38:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229506AbjDMLie (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Apr 2023 07:38:34 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50AB626B8;
        Thu, 13 Apr 2023 04:38:33 -0700 (PDT)
Date:   Thu, 13 Apr 2023 11:38:30 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1681385911;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=CrJur1YwyQC6UpMSRQKfbtGbDIthO3tAdBH2QlbRHgw=;
        b=MkPd6b6Ors5JGQF0ule2UsJ2c83QdqqGoAlZ7VwtsRIA+ov/N1B3kcIzSuZQZTYrnR4POM
        MrlZPldmMV5GN4iGKwG1aJ95jt4p6WuLSJ26ScL/Ye/Tftqce3djxCPnLfawN6L6qInAMX
        WQ9e91RHPOLEFjivyFasgS/qiIjc7MYFpVEGWswNyYusO6SRmaXaDH2CIWQ+b0EqE2AFTr
        0YUFi59qb11R34qDF3szZfQcFjZe9UVzsmsduRYvBG3EPqV7k7PEWkS1oYISyZ+5irVW25
        XAVBxBpjksoBbDMGm56OHCMqcYeuFiLRzkHACgXj8G+PpUfo6UgHnAP7i6hjvA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1681385911;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=CrJur1YwyQC6UpMSRQKfbtGbDIthO3tAdBH2QlbRHgw=;
        b=6Lc8pazT1Bbb+O4OcIsyxJcmzNj53EODMq8VOG/07xewXcPE2ERaE4lXOh+28qt8pKRlbN
        L4mCpIYM9OOxoWAw==
From:   "tip-bot2 for Uros Bizjak" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: locking/core] locking/generic: Wire up local{,64}_try_cmpxchg
Cc:     Uros Bizjak <ubizjak@gmail.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Mark Rutland <mark.rutland@arm.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20230405141710.3551-3-ubizjak@gmail.com>
References: <20230405141710.3551-3-ubizjak@gmail.com>
MIME-Version: 1.0
Message-ID: <168138591104.404.18396770570686121527.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the locking/core branch of tip:

Commit-ID:     1e9653c8289cf4b3c8690b558cdbe717d99e673a
Gitweb:        https://git.kernel.org/tip/1e9653c8289cf4b3c8690b558cdbe717d99e673a
Author:        Uros Bizjak <ubizjak@gmail.com>
AuthorDate:    Wed, 05 Apr 2023 16:17:07 +02:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Wed, 12 Apr 2023 16:46:34 +02:00

locking/generic: Wire up local{,64}_try_cmpxchg

Implement generic support for local{,64}_try_cmpxchg.

Redirect to the atomic_ family of functions when the target
does not provide its own local.h definitions.

For 64-bit targets, implement local64_try_cmpxchg and
local64_cmpxchg using typed C wrappers that call local_
family of functions and provide additional checking
of their input arguments.

Signed-off-by: Uros Bizjak <ubizjak@gmail.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Acked-by: Mark Rutland <mark.rutland@arm.com>
Link: https://lore.kernel.org/r/20230405141710.3551-3-ubizjak@gmail.com
---
 include/asm-generic/local.h   |  1 +
 include/asm-generic/local64.h | 12 +++++++++++-
 2 files changed, 12 insertions(+), 1 deletion(-)

diff --git a/include/asm-generic/local.h b/include/asm-generic/local.h
index fca7f1d..7f97018 100644
--- a/include/asm-generic/local.h
+++ b/include/asm-generic/local.h
@@ -42,6 +42,7 @@ typedef struct
 #define local_inc_return(l) atomic_long_inc_return(&(l)->a)
 
 #define local_cmpxchg(l, o, n) atomic_long_cmpxchg((&(l)->a), (o), (n))
+#define local_try_cmpxchg(l, po, n) atomic_long_try_cmpxchg((&(l)->a), (po), (n))
 #define local_xchg(l, n) atomic_long_xchg((&(l)->a), (n))
 #define local_add_unless(l, _a, u) atomic_long_add_unless((&(l)->a), (_a), (u))
 #define local_inc_not_zero(l) atomic_long_inc_not_zero(&(l)->a)
diff --git a/include/asm-generic/local64.h b/include/asm-generic/local64.h
index 765be0b..14963a7 100644
--- a/include/asm-generic/local64.h
+++ b/include/asm-generic/local64.h
@@ -42,7 +42,16 @@ typedef struct {
 #define local64_sub_return(i, l) local_sub_return((i), (&(l)->a))
 #define local64_inc_return(l)	local_inc_return(&(l)->a)
 
-#define local64_cmpxchg(l, o, n) local_cmpxchg((&(l)->a), (o), (n))
+static inline s64 local64_cmpxchg(local64_t *l, s64 old, s64 new)
+{
+	return local_cmpxchg(&l->a, old, new);
+}
+
+static inline bool local64_try_cmpxchg(local64_t *l, s64 *old, s64 new)
+{
+	return local_try_cmpxchg(&l->a, (long *)old, new);
+}
+
 #define local64_xchg(l, n)	local_xchg((&(l)->a), (n))
 #define local64_add_unless(l, _a, u) local_add_unless((&(l)->a), (_a), (u))
 #define local64_inc_not_zero(l)	local_inc_not_zero(&(l)->a)
@@ -81,6 +90,7 @@ typedef struct {
 #define local64_inc_return(l)	atomic64_inc_return(&(l)->a)
 
 #define local64_cmpxchg(l, o, n) atomic64_cmpxchg((&(l)->a), (o), (n))
+#define local64_try_cmpxchg(l, po, n) atomic64_try_cmpxchg((&(l)->a), (po), (n))
 #define local64_xchg(l, n)	atomic64_xchg((&(l)->a), (n))
 #define local64_add_unless(l, _a, u) atomic64_add_unless((&(l)->a), (_a), (u))
 #define local64_inc_not_zero(l)	atomic64_inc_not_zero(&(l)->a)
