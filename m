Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 11CB574D019
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jul 2023 10:38:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231292AbjGJIiH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jul 2023 04:38:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230446AbjGJIhy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jul 2023 04:37:54 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EDFBBC7;
        Mon, 10 Jul 2023 01:37:52 -0700 (PDT)
Date:   Mon, 10 Jul 2023 08:37:51 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1688978271;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=b5NJHJ+H28lGHwbhSa9F6XeQ+mXfL8Cc5aFSC6L775s=;
        b=U5jqE1oDQwhYZmqxQ6xXeEkdAnF44QO7HfBYnXkMjxD/fb/6SnPanxQaSWx5VqsaT1giqt
        CKCU4XCMoSBheHoOdxCT9DyqXlddDoa80Rq+GLVYfgh/BAPrpBPP41BC5IjvAe2FnmtHdH
        aodbGfSQfsAJLWdbjLGcdwAsjmEsI4rgl7MxtV5HPXIPsPfc2/2zFKkvFk37giky6AoRYh
        /9pIoIrklhHoaHs/1OJ9fz1/l4PFa6yvj5Kk/WqH2rrmLrdCafuJlymMxa07trp7l22wdq
        F1wrkADXX5R8jw1uOFCoGfXvosoAAG68ZSpwxI6xDBHKjR0/ELRDQF44GOSWog==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1688978271;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=b5NJHJ+H28lGHwbhSa9F6XeQ+mXfL8Cc5aFSC6L775s=;
        b=pR6E+3nn4EWwcvQeAzwUSb21dc1QGjkPsjQOnSgdgw3nebxB2AfVQoZWdNPukn6SDx08gr
        /OG7PPS9qgksMOBg==
From:   "tip-bot2 for Uros Bizjak" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: perf/core] locking/arch: Avoid variable shadowing in
 local_try_cmpxchg()
Cc:     Charlemagne Lasse <charlemagnelasse@gmail.com>,
        Uros Bizjak <ubizjak@gmail.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20230708090048.63046-1-ubizjak@gmail.com>
References: <20230708090048.63046-1-ubizjak@gmail.com>
MIME-Version: 1.0
Message-ID: <168897827110.404.18144213137097595757.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the perf/core branch of tip:

Commit-ID:     d6b45484c130f4095313ae3edeb4aae662c12fb1
Gitweb:        https://git.kernel.org/tip/d6b45484c130f4095313ae3edeb4aae662c12fb1
Author:        Uros Bizjak <ubizjak@gmail.com>
AuthorDate:    Sat, 08 Jul 2023 11:00:36 +02:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Mon, 10 Jul 2023 09:52:36 +02:00

locking/arch: Avoid variable shadowing in local_try_cmpxchg()

Several architectures define arch_try_local_cmpxchg macro using
internal temporary variables named ___old, __old or _old. Remove
temporary varible in local_try_cmpxchg to avoid variable shadowing.

No functional change intended.

Fixes: d994f2c8e241 ("locking/arch: Wire up local_try_cmpxchg()")
Closes: https://lore.kernel.org/lkml/CAFGhKbyxtuk=LoW-E3yLXgcmR93m+Dfo5-u9oQA_YC5Fcy_t9g@mail.gmail.com/
Reported-by: Charlemagne Lasse <charlemagnelasse@gmail.com>
Signed-off-by: Uros Bizjak <ubizjak@gmail.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lkml.kernel.org/r/20230708090048.63046-1-ubizjak@gmail.com
---
 arch/loongarch/include/asm/local.h | 4 ++--
 arch/mips/include/asm/local.h      | 4 ++--
 arch/x86/include/asm/local.h       | 4 ++--
 3 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/arch/loongarch/include/asm/local.h b/arch/loongarch/include/asm/local.h
index 83e995b..c496758 100644
--- a/arch/loongarch/include/asm/local.h
+++ b/arch/loongarch/include/asm/local.h
@@ -63,8 +63,8 @@ static inline long local_cmpxchg(local_t *l, long old, long new)
 
 static inline bool local_try_cmpxchg(local_t *l, long *old, long new)
 {
-	typeof(l->a.counter) *__old = (typeof(l->a.counter) *) old;
-	return try_cmpxchg_local(&l->a.counter, __old, new);
+	return try_cmpxchg_local(&l->a.counter,
+				 (typeof(l->a.counter) *) old, new);
 }
 
 #define local_xchg(l, n) (atomic_long_xchg((&(l)->a), (n)))
diff --git a/arch/mips/include/asm/local.h b/arch/mips/include/asm/local.h
index 5daf6fe..e6ae3df 100644
--- a/arch/mips/include/asm/local.h
+++ b/arch/mips/include/asm/local.h
@@ -101,8 +101,8 @@ static __inline__ long local_cmpxchg(local_t *l, long old, long new)
 
 static __inline__ bool local_try_cmpxchg(local_t *l, long *old, long new)
 {
-	typeof(l->a.counter) *__old = (typeof(l->a.counter) *) old;
-	return try_cmpxchg_local(&l->a.counter, __old, new);
+	return try_cmpxchg_local(&l->a.counter,
+				 (typeof(l->a.counter) *) old, new);
 }
 
 #define local_xchg(l, n) (atomic_long_xchg((&(l)->a), (n)))
diff --git a/arch/x86/include/asm/local.h b/arch/x86/include/asm/local.h
index 56d4ef6..635132a 100644
--- a/arch/x86/include/asm/local.h
+++ b/arch/x86/include/asm/local.h
@@ -127,8 +127,8 @@ static inline long local_cmpxchg(local_t *l, long old, long new)
 
 static inline bool local_try_cmpxchg(local_t *l, long *old, long new)
 {
-	typeof(l->a.counter) *__old = (typeof(l->a.counter) *) old;
-	return try_cmpxchg_local(&l->a.counter, __old, new);
+	return try_cmpxchg_local(&l->a.counter,
+				 (typeof(l->a.counter) *) old, new);
 }
 
 /* Always has a lock prefix */
