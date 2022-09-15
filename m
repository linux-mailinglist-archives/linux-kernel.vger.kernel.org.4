Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1785A5B9CFA
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Sep 2022 16:24:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230104AbiIOOXw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Sep 2022 10:23:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229999AbiIOOXp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Sep 2022 10:23:45 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44CA02F001;
        Thu, 15 Sep 2022 07:23:44 -0700 (PDT)
Date:   Thu, 15 Sep 2022 14:23:41 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1663251822;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=BwlUJp0ha5hGvi4OuVHKyiA3BjHfx9/RXMl32q15g0Y=;
        b=jkG0cgBqHPyDV3nA9i+Zwll6End0qxGYo286+O7qtretIinsge5B8/oWVvRNHA5tc4Ie2O
        ADNOvqJuTVYOvY+DL7u5ovNIpn8KY9RGyRqOXp011EFJC47xo0JA70NA60IruV8OJMsi6t
        ZF6AFR8DeVRhZkg4MdZ5RS8cAWFf340O0M45xMBm4BvInbXFJEMUN8K9IQX9lXy/KTTcf9
        mKk40nKYiZfjmZ/f/V8IetmuDJBzfVe+IkgAH1pra990j44JmkgNaFdaRBArY4Iidq8PRF
        dWLQpgvM/qhbcAyipIuxRhNGFqODyrbOQflSs/GP9QJkKMGNJPsWFwXVLncJeQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1663251822;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=BwlUJp0ha5hGvi4OuVHKyiA3BjHfx9/RXMl32q15g0Y=;
        b=pOVCeMnIH1ZSzj/TJ6oaTWD7FlfTyXLUTWaFqf2Aja2a19eiK5US2sD3JySGYSQ8eCziH5
        k4joppKih5jd78Dg==
From:   "tip-bot2 for Namhyung Kim" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: locking/core] locking: Add __sched to semaphore functions
Cc:     Namhyung Kim <namhyung@kernel.org>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20220909000803.4181857-1-namhyung@kernel.org>
References: <20220909000803.4181857-1-namhyung@kernel.org>
MIME-Version: 1.0
Message-ID: <166325182156.401.3796755990517584127.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the locking/core branch of tip:

Commit-ID:     0d97db026509c1a13f732b22670ab1f0ac9d8d87
Gitweb:        https://git.kernel.org/tip/0d97db026509c1a13f732b22670ab1f0ac9d8d87
Author:        Namhyung Kim <namhyung@kernel.org>
AuthorDate:    Thu, 08 Sep 2022 17:08:03 -07:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Thu, 15 Sep 2022 16:14:03 +02:00

locking: Add __sched to semaphore functions

The internal functions are marked with __sched already, let's do the same
for external functions too so that we can skip them in the stack trace.

Signed-off-by: Namhyung Kim <namhyung@kernel.org>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lkml.kernel.org/r/20220909000803.4181857-1-namhyung@kernel.org
---
 kernel/locking/semaphore.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/kernel/locking/semaphore.c b/kernel/locking/semaphore.c
index f2654d2..34bfae7 100644
--- a/kernel/locking/semaphore.c
+++ b/kernel/locking/semaphore.c
@@ -51,7 +51,7 @@ static noinline void __up(struct semaphore *sem);
  * Use of this function is deprecated, please use down_interruptible() or
  * down_killable() instead.
  */
-void down(struct semaphore *sem)
+void __sched down(struct semaphore *sem)
 {
 	unsigned long flags;
 
@@ -74,7 +74,7 @@ EXPORT_SYMBOL(down);
  * If the sleep is interrupted by a signal, this function will return -EINTR.
  * If the semaphore is successfully acquired, this function returns 0.
  */
-int down_interruptible(struct semaphore *sem)
+int __sched down_interruptible(struct semaphore *sem)
 {
 	unsigned long flags;
 	int result = 0;
@@ -101,7 +101,7 @@ EXPORT_SYMBOL(down_interruptible);
  * -EINTR.  If the semaphore is successfully acquired, this function returns
  * 0.
  */
-int down_killable(struct semaphore *sem)
+int __sched down_killable(struct semaphore *sem)
 {
 	unsigned long flags;
 	int result = 0;
@@ -131,7 +131,7 @@ EXPORT_SYMBOL(down_killable);
  * Unlike mutex_trylock, this function can be used from interrupt context,
  * and the semaphore can be released by any task or interrupt.
  */
-int down_trylock(struct semaphore *sem)
+int __sched down_trylock(struct semaphore *sem)
 {
 	unsigned long flags;
 	int count;
@@ -156,7 +156,7 @@ EXPORT_SYMBOL(down_trylock);
  * If the semaphore is not released within the specified number of jiffies,
  * this function returns -ETIME.  It returns 0 if the semaphore was acquired.
  */
-int down_timeout(struct semaphore *sem, long timeout)
+int __sched down_timeout(struct semaphore *sem, long timeout)
 {
 	unsigned long flags;
 	int result = 0;
@@ -180,7 +180,7 @@ EXPORT_SYMBOL(down_timeout);
  * Release the semaphore.  Unlike mutexes, up() may be called from any
  * context and even by tasks which have never called down().
  */
-void up(struct semaphore *sem)
+void __sched up(struct semaphore *sem)
 {
 	unsigned long flags;
 
