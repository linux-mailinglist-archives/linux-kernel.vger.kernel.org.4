Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E375664E10
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Jan 2023 22:31:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234473AbjAJVb1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Jan 2023 16:31:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234768AbjAJVaj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jan 2023 16:30:39 -0500
Received: from mail-pj1-x1049.google.com (mail-pj1-x1049.google.com [IPv6:2607:f8b0:4864:20::1049])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC8D163D3C
        for <linux-kernel@vger.kernel.org>; Tue, 10 Jan 2023 13:30:19 -0800 (PST)
Received: by mail-pj1-x1049.google.com with SMTP id y2-20020a17090a784200b00225c0839b80so5313179pjl.5
        for <linux-kernel@vger.kernel.org>; Tue, 10 Jan 2023 13:30:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=v9qYSQFUkDmaIwPSOBMoDxk/OX6P7cFe8UAy56cpW5Q=;
        b=PdzJiw/LwFz0AEVC5fhfbbgcYl/W+56IRf1pubwDGgzlCHDfwj/JoqCetiyqFWUHtd
         Ro4/Tyzn2sAiVpnrLQeNXuLbJik3qrlTVkVr+61viJFbLB2hxAl0dfuCcmcRWcs8sNPi
         nZ128TjngolTkzPUMcSEsbCEqXTAhqCLylANSfZxiTeKfAN0MBPeLOvYtf9OCBLhX/La
         0pyaT8EC0s6DRvN1Hon3jy/IXXNp8rE24EsVxjPzzh44WjK8UlzTL0qbNK6leU5TaXfV
         LilatZ38mgnFPkhtDv+otL08/VlBlq7uoZS3/aWeeSm+Pi3NKKW3sg4tPQbWuyDGDWkg
         mNcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=v9qYSQFUkDmaIwPSOBMoDxk/OX6P7cFe8UAy56cpW5Q=;
        b=KhedbA/Vy69WGzk2ZpUx/Gr38HiP8iTClvg6QDV6fsYcjw+WdXZZ4XhrhZTDqfr021
         FG6yHItX+L8ngCnW7QwlGuYQVYqVoOMZyIfFagDa4Xc6Y4Dl/QzbA0/FNWrvcNcnmJrC
         rZGpX/8IsC07i2t1Hs1vbr6EV+IONeG/x0kY6r18RWjAefxtPZw7DTt3JZmKsaysXBD8
         t/SEb5wgEmQsAZZOUX7mQ4snlYt3Dw9t2SSv3UoQps9wCJYEJCU0Zrr+CyPVQvWMYDEz
         /2zmlv5nHNNXa3kAIj9aLi31wfilLNbFGUVFCIDQ8T1rnzokLH21YITRdJoL46Y7ZQ89
         +Zcw==
X-Gm-Message-State: AFqh2krVrwSdV7jkFUoNE9azBBLQNY22PD3QT+TpuSOPlhDdFXETXbZ4
        Pq2ZNCf/ibdgNFhp3sBlB/+cXIh9dx8=
X-Google-Smtp-Source: AMrXdXv0UO1DLWnD3xEnF2pGZeOJmyREmFwlqto5nxU5NFNojg5kSz8G4jjYFFz+bC3JK2T8Q2z5SUFV7G0=
X-Received: from avagin.kir.corp.google.com ([2620:0:1008:11:6203:13b5:2d85:b75c])
 (user=avagin job=sendgmr) by 2002:a62:e715:0:b0:58a:ebaa:9586 with SMTP id
 s21-20020a62e715000000b0058aebaa9586mr303794pfh.36.1673386219357; Tue, 10 Jan
 2023 13:30:19 -0800 (PST)
Date:   Tue, 10 Jan 2023 13:30:06 -0800
In-Reply-To: <20230110213010.2683185-1-avagin@google.com>
Mime-Version: 1.0
References: <20230110213010.2683185-1-avagin@google.com>
X-Mailer: git-send-email 2.39.0.314.g84b9a713c41-goog
Message-ID: <20230110213010.2683185-2-avagin@google.com>
Subject: [PATCH 1/5] seccomp: don't use semaphore and wait_queue together
From:   Andrei Vagin <avagin@google.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>
Cc:     linux-kernel@vger.kernel.org, Kees Cook <keescook@chromium.org>,
        Christian Brauner <brauner@kernel.org>,
        Andrei Vagin <avagin@gmail.com>,
        Andy Lutomirski <luto@amacapital.net>,
        Juri Lelli <juri.lelli@redhat.com>,
        Peter Oskolkov <posk@google.com>,
        Tycho Andersen <tycho@tycho.pizza>,
        Will Drewry <wad@chromium.org>
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
2.39.0.314.g84b9a713c41-goog

