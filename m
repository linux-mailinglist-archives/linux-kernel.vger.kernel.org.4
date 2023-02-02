Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B80A68739A
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Feb 2023 04:04:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230189AbjBBDEm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Feb 2023 22:04:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229630AbjBBDEj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Feb 2023 22:04:39 -0500
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70783F9
        for <linux-kernel@vger.kernel.org>; Wed,  1 Feb 2023 19:04:38 -0800 (PST)
Received: by mail-yb1-xb4a.google.com with SMTP id k204-20020a256fd5000000b007b8b040bc50so527691ybc.1
        for <linux-kernel@vger.kernel.org>; Wed, 01 Feb 2023 19:04:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=xxNz1I6f1ntPCey48VXsGK/J5ar2tTOh4Waqg/8Yo5s=;
        b=UuLCw0Xv/mTrMv3zluwN0thXeO+NQ0dikgAAZB90G1dHXsYWmHsCgbCHlTUXEMEfZ8
         gEEg0d/y02gM0sesKJRteW43UijVtmvp211AGjlJKl7r/n82zxtm7XJjBmRIIY/kVukR
         be8SUS4/HEu7/21XjrLcgrdepzwnQN/oku5GfZ26Z+8AESIFvO0wtRn2ExRYu8tCtca1
         QRziFUN1gmTVezcAmNUR3UIe5qUD9JLeL/kCIxR6ffe5S5R3utE+kQHGYrQOYH4PPO1T
         iQGAqahpD2aRZFDmKvtKK656DjDrYBAoDqFG2RmaC9sgeujPiUCDlnCRpOzE/2SeI5Xz
         6Ylg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xxNz1I6f1ntPCey48VXsGK/J5ar2tTOh4Waqg/8Yo5s=;
        b=Nx7Yyy4G8RRF5h35wX9u2sHZHNad993QWU4/OGU4SRd5sRlFJjUDDBIm9HWr+pgdGy
         Z2nXyFV4bodsXI/QpoF3/pZNCsS+MYriOpeOTfxweOoM/FyYXCrB44ucpyiyAB8/mWRa
         Uj0SwPX/5FePYxEc5mtVE2EMrPIrA7L2kwTYRqMzmytO4mpM9BElsHIt4D57txHfDdn0
         wLnfQOI38lSYXOa/IDhsdPUMXcsp/R6cyy9qSZyDMrcTBsY9fLZcQtp7a+w+8ROHhoM9
         JC8IBxw4x7CAxWZ3pU2Z4CKhdGxFv+I0WJJPYch23CYn5cXU4AeVAGGiNxaGWMjv051P
         hZSQ==
X-Gm-Message-State: AO0yUKULhQ7tEppRRwME4ogMyoH7bcWhJ3l73DCcGpBxW8mQ4f/HZ1WF
        MahZak0ik/UgaOEgkRxAb/OCrOI4X+0=
X-Google-Smtp-Source: AK7set/yoSx2eEf7BdMUJ9XaUZQ4OAFBxRb3k/uoeX3yl7Itji67j6nBg1Qf5oOGOVRRVj6LnfwQKCUTRVc=
X-Received: from avagin.kir.corp.google.com ([2620:0:1008:11:eee0:dc42:a911:8b59])
 (user=avagin job=sendgmr) by 2002:a81:1c4:0:b0:4fe:3a3c:d911 with SMTP id
 187-20020a8101c4000000b004fe3a3cd911mr488130ywb.311.1675307077693; Wed, 01
 Feb 2023 19:04:37 -0800 (PST)
Date:   Wed,  1 Feb 2023 19:04:24 -0800
In-Reply-To: <20230202030429.3304875-1-avagin@google.com>
Mime-Version: 1.0
References: <20230202030429.3304875-1-avagin@google.com>
X-Mailer: git-send-email 2.39.1.456.gfc5497dd1b-goog
Message-ID: <20230202030429.3304875-2-avagin@google.com>
Subject: [PATCH 1/6] seccomp: don't use semaphore and wait_queue together
From:   Andrei Vagin <avagin@google.com>
To:     Kees Cook <keescook@chromium.org>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     linux-kernel@vger.kernel.org,
        Christian Brauner <brauner@kernel.org>,
        Chen Yu <yu.c.chen@intel.com>, avagin@gmail.com,
        Andrei Vagin <avagin@google.com>,
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

The main reason is to use new wake_up helpers that will be added in the
following patches. But here are a few other reasons:

* if we use two different ways, we always need to call them both. This
  patch fixes seccomp_notify_recv where we forgot to call wake_up_poll
  in the error path.

* If we use one primitive, we can control how many waiters are woken up
  for each request. Our goal is to wake up just one that will handle a
  request. Right now, wake_up_poll can wake up one waiter and
  up(&match->notif->request) can wake up one more.

Signed-off-by: Andrei Vagin <avagin@google.com>
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
2.39.1.456.gfc5497dd1b-goog

