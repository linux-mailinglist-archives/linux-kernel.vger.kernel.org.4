Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DE2F16F4EE1
	for <lists+linux-kernel@lfdr.de>; Wed,  3 May 2023 04:34:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229705AbjECCeI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 May 2023 22:34:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229677AbjECCd6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 May 2023 22:33:58 -0400
Received: from mail-pg1-x549.google.com (mail-pg1-x549.google.com [IPv6:2607:f8b0:4864:20::549])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D590D3C26
        for <linux-kernel@vger.kernel.org>; Tue,  2 May 2023 19:33:54 -0700 (PDT)
Received: by mail-pg1-x549.google.com with SMTP id 41be03b00d2f7-528ab7097afso3875925a12.1
        for <linux-kernel@vger.kernel.org>; Tue, 02 May 2023 19:33:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1683081234; x=1685673234;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=kO+DuhhQhtfwQumbn93KBsOv9eGyW13juEx1DZY9eo8=;
        b=a6o+B30XzCwYla9TMl4aF7xYlJdinfkn5QrcDKbO/kRfUcLzUZgqHEQ+SObPwAqORx
         Eq0Ju3xXQQtN6rhLYdUjENVIBwLODb7QZ4B2DYBV4KkNhtZrKrYQHHBo46qCpA/ph6tR
         dM+6//+jahItnFuFomapyiOWGgu7NRob3RIbp7gJb+7WiLfXrwapkNVMdNNsf5bvtTkP
         qz6c2BQFSt9KbIA2TiRsq334NOijed/UPAu3Tb8uIjBy1mbHeT8DzxOJGUNIOwS5a2Ay
         wjRyRJQX4JODOBelKXynhlvUnRTHrKP84hPfpqhCiFMA034s5onAWxpkt+jN46W5kfx+
         4lyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683081234; x=1685673234;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=kO+DuhhQhtfwQumbn93KBsOv9eGyW13juEx1DZY9eo8=;
        b=TKSEGM4dwxiM5DpNgX0jsqEAxlJQsvdluCr4Hg4XU+ASgQngBbn7aKJIeDlqmn0ev5
         p8VxEQWU2uBw5xBI+ZWhSBmimZ5fF5yORfxDKrUqaOZ/baTe18GhsYAg+z0n1f+DF7m1
         nH7oPffPOxKM99+vTEbZrAXqS4BA+YnlLWpfhD4AQXdP66na9+ysz83Zxm+s52WNYi1q
         09+w0c3j0tOP5xG0CF0+C64ooUoe9hicSZMmb6Rki4jtPXAePgDkF4KZTVUgrFfyhTsX
         62ScnP/JSG7zj9Z/MAHm/a+LE6xHVRiA9K0azmFaxxRE/ua1XEUPGH2yyyZ3CM+6KCwQ
         oViQ==
X-Gm-Message-State: AC+VfDxsMy2pwVUOaqVTt0ctIddOTmuWCR+jxeKUN+RlLaKdoVZ7+6Nf
        C02lPn5CZAOXAdt+O0vaxRX8xcytnG2OmYBgz6DykAb93hGE3EZg3lEUsn9Ck4BnG97l7NOVkg3
        CBA7ZZZi6mGF63K2Lu/8IHZiRsikJOke7knG9W+k6ILRr8mogsga/RdcJkecrwIK1jEoatF4=
X-Google-Smtp-Source: ACHHUZ4YCoa72gMmDmchh9220KUKUvHBCc2tTAY0DqvL93rzNHxqR+eE11WtIZ9yIssZEKWdWdXzJbCgKziS
X-Received: from jstultz-noogler2.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:600])
 (user=jstultz job=sendgmr) by 2002:a63:28c6:0:b0:52c:4227:aa60 with SMTP id
 bs189-20020a6328c6000000b0052c4227aa60mr138888pgb.7.1683081233936; Tue, 02
 May 2023 19:33:53 -0700 (PDT)
Date:   Wed,  3 May 2023 02:33:51 +0000
Mime-Version: 1.0
X-Mailer: git-send-email 2.40.1.495.gc816e09b53d-goog
Message-ID: <20230503023351.2832796-1-jstultz@google.com>
Subject: [PATCH v3] locking/rwsem: Add __always_inline annotation to
 __down_read_common() and inlined callers
From:   John Stultz <jstultz@google.com>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     John Stultz <jstultz@google.com>, Minchan Kim <minchan@kernel.org>,
        Tim Murray <timmurray@google.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
        Waiman Long <longman@redhat.com>,
        Boqun Feng <boqun.feng@gmail.com>, kernel-team@android.com,
        stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Apparently despite it being marked inline, the compiler
may not inline __down_read_common() which makes it difficult
to identify the cause of lock contention, as the blocked
function in traceevents will always be listed as
__down_read_common().

So this patch adds __always_inline annotation to the common
function (as well as the inlined helper callers) to force it to
be inlined so the blocking function will be listed (via Wchan)
in traceevents.

Cc: Minchan Kim <minchan@kernel.org>
Cc: Tim Murray <timmurray@google.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Will Deacon <will@kernel.org>
Cc: Waiman Long <longman@redhat.com>
Cc: Boqun Feng <boqun.feng@gmail.com>
Cc: kernel-team@android.com
Cc: stable@vger.kernel.org
Fixes: c995e638ccbb ("locking/rwsem: Fold __down_{read,write}*()")
Reviewed-by: Waiman Long <longman@redhat.com>
Reported-by: Tim Murray <timmurray@google.com>
Signed-off-by: John Stultz <jstultz@google.com>
---
v2: Reworked to use __always_inline instead of __sched as
    suggested by Waiman Long

v3: Add __always_inline annotations to currently inlined users
    of __down_read_common() to avoid the compiler later doing the
    same thing there. (Suggested by Peter).
---
 kernel/locking/rwsem.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/kernel/locking/rwsem.c b/kernel/locking/rwsem.c
index acb5a50309a1..9eabd585ce7a 100644
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
@@ -1258,17 +1258,17 @@ static inline int __down_read_common(struct rw_semaphore *sem, int state)
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
-- 
2.40.1.495.gc816e09b53d-goog

