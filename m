Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5316567A6FE
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Jan 2023 00:42:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233929AbjAXXmI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Jan 2023 18:42:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233425AbjAXXmF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jan 2023 18:42:05 -0500
Received: from mail-pf1-x449.google.com (mail-pf1-x449.google.com [IPv6:2607:f8b0:4864:20::449])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C8B0366AD
        for <linux-kernel@vger.kernel.org>; Tue, 24 Jan 2023 15:42:04 -0800 (PST)
Received: by mail-pf1-x449.google.com with SMTP id 74-20020a62184d000000b0058b9f769609so7372490pfy.3
        for <linux-kernel@vger.kernel.org>; Tue, 24 Jan 2023 15:42:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=xszjUWrkTFV6nH5PVQmd1FHGHVSzRQgiwaL4b/IJnWk=;
        b=hTF/rOOwLOSId0uqhOxiwPXbw3/AXfGx+3kN23wQ14X/2W7FixnuFbx/Tx6JHDwQXz
         3tP7WJa3k/2ZilKHOpQmLQ1aPQtsM6W9ZA44Ye/92hWta06p1j2LWKloC6IG/F0H5ZTj
         TSgVAaQ1+Dgfvq2UI3a2IcCw8yhkZnCGzpV6jAgfi5esnr30KxmO6iI7tMPSb6Fzs6wC
         0DHDbnkKfA9g+2tJSzW3M8WBpev21WzZWhWbNoleSeuJDiZ4lODqxa/uxyIJDpNP6qTk
         Zw3YnweayXtLDiSYst8UKW40KJrsZUQaKb+QbMjDzz5SyjXSJHfHBR/6AHW8wSPOZLsF
         z8Uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xszjUWrkTFV6nH5PVQmd1FHGHVSzRQgiwaL4b/IJnWk=;
        b=iNex4cZgj1gCwN1Mf+P9byUJnGinw/vpWLrAB8c/qRCWV7gC5LnUSbLzb8gBGV0fo5
         24Zla62fcp1zrK+lradpRYftOAnS1kxrKQVRdXK+txYHcK83dc17YktIGmRhs6+VXbw0
         DOHp322oqsrL3hD51rNkXti3/EMRJSzN3PHiqUOHj+pajSRP1/5nt+Q6NCQoNlGUpnwt
         bkSW/UYabeHfzlLEQnJ/Mfe8DxMJNRz5t3HhHls7a8PRwxLER4xsWe6wsYzVkIpt4B3Z
         H/m4616nHsIIkHVqn71ODKjWLEmK71rz3CQsPdYLUKltCOHOTK1jNcP1q2F/5Lq8YuoL
         XMzA==
X-Gm-Message-State: AFqh2kqzwZWup5tLn2cH/smiMXJMxgyL8At+nLU8Hzp6LNFF37ea6dKh
        8vNPxvmpBJTiF3UU9XCOyx2xPR+GsM4=
X-Google-Smtp-Source: AMrXdXtIEI/cn0GR6RcO+wSmBlnZE7hMC+n22dknnJy8OuktSe4bzlSt+uSc/nMutTRbF23eNo7aGIrcvmI=
X-Received: from avagin.kir.corp.google.com ([2620:0:1008:11:cf1b:2f7f:3ca1:6488])
 (user=avagin job=sendgmr) by 2002:a62:1c86:0:b0:58d:a84a:190b with SMTP id
 c128-20020a621c86000000b0058da84a190bmr3121261pfc.48.1674603723879; Tue, 24
 Jan 2023 15:42:03 -0800 (PST)
Date:   Tue, 24 Jan 2023 15:41:51 -0800
In-Reply-To: <20230124234156.211569-1-avagin@google.com>
Mime-Version: 1.0
References: <20230124234156.211569-1-avagin@google.com>
X-Mailer: git-send-email 2.39.1.405.gd4c25cc71f-goog
Message-ID: <20230124234156.211569-2-avagin@google.com>
Subject: [PATCH 1/6] seccomp: don't use semaphore and wait_queue together
From:   Andrei Vagin <avagin@google.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     linux-kernel@vger.kernel.org, Kees Cook <keescook@chromium.org>,
        Christian Brauner <brauner@kernel.org>,
        Chen Yu <yu.c.chen@intel.com>, Andrei Vagin <avagin@gmail.com>,
        Andy Lutomirski <luto@amacapital.net>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Ingo Molnar <mingo@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Peter Oskolkov <posk@google.com>,
        Tycho Andersen <tycho@tycho.pizza>,
        Will Drewry <wad@chromium.org>,
        Vincent Guittot <vincent.guittot@linaro.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Andrei Vagin <avagin@gmail.com>

The main reason is to use new wake_up helpers that will be added in the
following patches. But here are a few other reasons:

* if we use two different ways, we always need to call them both. This
  patch fixes seccomp_notify_recv where we forgot to call wake_up_poll
  in the error path.

* If we use one primitive, we can control how many waiters are woken up
  for each request. Our goal is to wake up just one that will handle a
  request. Right now, wake_up_poll can wake up one waiter and
  up(&match->notif->request) can wake up one more.

Signed-off-by: Andrei Vagin <avagin@gmail.com>
---
 kernel/seccomp.c | 41 ++++++++++++++++++++++++++++++++++++-----
 1 file changed, 36 insertions(+), 5 deletions(-)

diff --git a/kernel/seccomp.c b/kernel/seccomp.c
index e9852d1b4a5e..876022e9c88c 100644
--- a/kernel/seccomp.c
+++ b/kernel/seccomp.c
@@ -145,7 +145,7 @@ struct seccomp_kaddfd {
  * @notifications: A list of struct seccomp_knotif elements.
  */
 struct notification {
-	struct semaphore request;
+	atomic_t requests;
 	u64 next_id;
 	struct list_head notifications;
 };
@@ -1116,7 +1116,7 @@ static int seccomp_do_user_notification(int this_syscall,
 	list_add_tail(&n.list, &match->notif->notifications);
 	INIT_LIST_HEAD(&n.addfd);
 
-	up(&match->notif->request);
+	atomic_add(1, &match->notif->requests);
 	wake_up_poll(&match->wqh, EPOLLIN | EPOLLRDNORM);
 
 	/*
@@ -1450,6 +1450,37 @@ find_notification(struct seccomp_filter *filter, u64 id)
 	return NULL;
 }
 
+static int recv_wake_function(wait_queue_entry_t *wait, unsigned int mode, int sync,
+				  void *key)
+{
+	/* Avoid a wakeup if event not interesting for us. */
+	if (key && !(key_to_poll(key) & (EPOLLIN | EPOLLERR)))
+		return 0;
+	return autoremove_wake_function(wait, mode, sync, key);
+}
+
+static int recv_wait_event(struct seccomp_filter *filter)
+{
+	DEFINE_WAIT_FUNC(wait, recv_wake_function);
+	int ret;
+
+	if (atomic_add_unless(&filter->notif->requests, -1, 0) != 0)
+		return 0;
+
+	for (;;) {
+		ret = prepare_to_wait_event(&filter->wqh, &wait, TASK_INTERRUPTIBLE);
+
+		if (atomic_add_unless(&filter->notif->requests, -1, 0) != 0)
+			break;
+
+		if (ret)
+			return ret;
+
+		schedule();
+	}
+	finish_wait(&filter->wqh, &wait);
+	return 0;
+}
 
 static long seccomp_notify_recv(struct seccomp_filter *filter,
 				void __user *buf)
@@ -1467,7 +1498,7 @@ static long seccomp_notify_recv(struct seccomp_filter *filter,
 
 	memset(&unotif, 0, sizeof(unotif));
 
-	ret = down_interruptible(&filter->notif->request);
+	ret = recv_wait_event(filter);
 	if (ret < 0)
 		return ret;
 
@@ -1515,7 +1546,8 @@ static long seccomp_notify_recv(struct seccomp_filter *filter,
 			if (should_sleep_killable(filter, knotif))
 				complete(&knotif->ready);
 			knotif->state = SECCOMP_NOTIFY_INIT;
-			up(&filter->notif->request);
+			atomic_add(1, &filter->notif->requests);
+			wake_up_poll(&filter->wqh, EPOLLIN | EPOLLRDNORM);
 		}
 		mutex_unlock(&filter->notify_lock);
 	}
@@ -1777,7 +1809,6 @@ static struct file *init_listener(struct seccomp_filter *filter)
 	if (!filter->notif)
 		goto out;
 
-	sema_init(&filter->notif->request, 0);
 	filter->notif->next_id = get_random_u64();
 	INIT_LIST_HEAD(&filter->notif->notifications);
 
-- 
2.39.1.405.gd4c25cc71f-goog

