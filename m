Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD6D86FDE75
	for <lists+linux-kernel@lfdr.de>; Wed, 10 May 2023 15:26:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237016AbjEJNZ7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 May 2023 09:25:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236652AbjEJNZ5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 May 2023 09:25:57 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77C775BAE;
        Wed, 10 May 2023 06:25:55 -0700 (PDT)
Date:   Wed, 10 May 2023 13:25:52 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1683725152;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=9M+nf6U/P/tUi5DBkLwJC4aUssS4FE6HYCt3SW4Jmd8=;
        b=Bas0f/6u5hhtyYakWKF11FdpYb+JIqlbHy0mYSqaMZBN+v0uoTVXbjsxojji0IKF99UBwI
        TZdJvw8HTyMjfQxJztens8gjbp+GiiEcDfxT8JFD/gytyv6Van7Xc0XAqpzrbDnG9UOn6q
        UcjS1ytBEpg+DG+NQqojbzZuPv/GEnFwxfXSyhtCmP0C/xGzXk1vM/qUECn5qGv7kpKHfI
        2PwcSTHvdvd7YcnknMO28l34E5q7bOeLuIt4UzCTPi+a+YFVlukaAdZRAT9duUzaB8aokD
        v+xmfPRbvxWxrIh+4NtlZ18tMUPH29YwcEdq38HbfduBYO3vxKbaFttenC3xxQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1683725152;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=9M+nf6U/P/tUi5DBkLwJC4aUssS4FE6HYCt3SW4Jmd8=;
        b=arfrKUKunBDqCYqAvI4ZAwZb3s+HPhVN9XvULsPvu3ABnDWTrtQ8BSQMjA7SQxSwjjTs/8
        Rj5iPWYO9WYnBgDg==
From:   "tip-bot2 for John Stultz" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: locking/urgent] locking/rwsem: Add __always_inline annotation
 to __down_read_common() and inlined callers
Cc:     Tim Murray <timmurray@google.com>,
        John Stultz <jstultz@google.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Waiman Long <longman@redhat.com>, stable@vger.kernel.org,
        x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20230503023351.2832796-1-jstultz@google.com>
References: <20230503023351.2832796-1-jstultz@google.com>
MIME-Version: 1.0
Message-ID: <168372515216.404.11878802112685684036.tip-bot2@tip-bot2>
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

The following commit has been merged into the locking/urgent branch of tip:

Commit-ID:     92cc5d00a431e96e5a49c0b97e5ad4fa7536bd4b
Gitweb:        https://git.kernel.org/tip/92cc5d00a431e96e5a49c0b97e5ad4fa7536bd4b
Author:        John Stultz <jstultz@google.com>
AuthorDate:    Wed, 03 May 2023 02:33:51 
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Mon, 08 May 2023 10:58:24 +02:00

locking/rwsem: Add __always_inline annotation to __down_read_common() and inlined callers

Apparently despite it being marked inline, the compiler
may not inline __down_read_common() which makes it difficult
to identify the cause of lock contention, as the blocked
function in traceevents will always be listed as
__down_read_common().

So this patch adds __always_inline annotation to the common
function (as well as the inlined helper callers) to force it to
be inlined so the blocking function will be listed (via Wchan)
in traceevents.

Fixes: c995e638ccbb ("locking/rwsem: Fold __down_{read,write}*()")
Reported-by: Tim Murray <timmurray@google.com>
Signed-off-by: John Stultz <jstultz@google.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Waiman Long <longman@redhat.com>
Cc: stable@vger.kernel.org
Link: https://lkml.kernel.org/r/20230503023351.2832796-1-jstultz@google.com
---
 kernel/locking/rwsem.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/kernel/locking/rwsem.c b/kernel/locking/rwsem.c
index acb5a50..9eabd58 100644
--- a/kernel/locking/rwsem.c
+++ b/kernel/locking/rwsem.c
@@ -1240,7 +1240,7 @@ static struct rw_semaphore *rwsem_downgrade_wake(struct rw_semaphore *sem)
 /*
  * lock for reading
  */
-static inline int __down_read_common(struct rw_semaphore *sem, int state)
+static __always_inline int __down_read_common(struct rw_semaphore *sem, int state)
 {
 	int ret = 0;
 	long count;
@@ -1258,17 +1258,17 @@ out:
 	return ret;
 }
 
-static inline void __down_read(struct rw_semaphore *sem)
+static __always_inline void __down_read(struct rw_semaphore *sem)
 {
 	__down_read_common(sem, TASK_UNINTERRUPTIBLE);
 }
 
-static inline int __down_read_interruptible(struct rw_semaphore *sem)
+static __always_inline int __down_read_interruptible(struct rw_semaphore *sem)
 {
 	return __down_read_common(sem, TASK_INTERRUPTIBLE);
 }
 
-static inline int __down_read_killable(struct rw_semaphore *sem)
+static __always_inline int __down_read_killable(struct rw_semaphore *sem)
 {
 	return __down_read_common(sem, TASK_KILLABLE);
 }
