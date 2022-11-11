Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 449F262546E
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Nov 2022 08:32:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232890AbiKKHcJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Nov 2022 02:32:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232778AbiKKHcH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Nov 2022 02:32:07 -0500
Received: from mail-pj1-x104a.google.com (mail-pj1-x104a.google.com [IPv6:2607:f8b0:4864:20::104a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61F355B599
        for <linux-kernel@vger.kernel.org>; Thu, 10 Nov 2022 23:32:06 -0800 (PST)
Received: by mail-pj1-x104a.google.com with SMTP id m2-20020a17090a730200b0021020cce6adso4945807pjk.3
        for <linux-kernel@vger.kernel.org>; Thu, 10 Nov 2022 23:32:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=d0z4ZqOjCKmXyUs7iMz5v/b1E02qlP3LIlnJ4q8w9/A=;
        b=M2IwOqcnfMwLGJzeNATGonrvMokklJg6m4PkurdIvL6eESyXf/bcAb1uGW/mTJusqJ
         3ym30/nIwEo8rDGbooAue+HnPKoZcRPTQL0MJQC44VC3GwzMrF0NF0UR+H2JzrnZCZy+
         1FXb04DEx8lTBuF2ZOQBQL9qDFze3rmI3uQ0tyd52Uwjuu3aTPZhMkt/PUx9TR6jZZTA
         M3L1Xot34AO8kq5MIPWtN5YKvbXEcrJOniRATzYR5z0s44Y4/edXXWGq9loQzJfsJL9/
         1z2znHxCGZrY+xOeIV4X3AkMiAGi7bXDw3T5KBPVjsFE7Fov9RQCMTu7eEqjJk60dIdO
         sBYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=d0z4ZqOjCKmXyUs7iMz5v/b1E02qlP3LIlnJ4q8w9/A=;
        b=O5M9dhcGerAyCEz9RaNB8DVBUABscPg/3n/ntOruGvw301kAgW2OXjWWUgU4O2b4wM
         mZAwJrsUCW/RDMP4+OM8l3QZ2aab4qNSIlPl9bqclUPzVqMMMTYS6FEkCoh6iF8OyAfZ
         Pt2ZvKVWPy4QvpTSP/fC8G+kXI+G61mgqmWZlN0cXen64J0hUB+T0kYVwGybl1GTdVgH
         DUmIYwsglWSrSG4oEv1zmv0doI1PjfxvNz6LKTrzm2d+MEFrxdSiqOscqmknj4ch9CHL
         YHZu+4FSW546uga5dshbBQmf6PxuRsA64i+ifeu7W4wQDfw+fW5F7KSyY/+IgiO30oBP
         3+bw==
X-Gm-Message-State: ANoB5pmb27C57Eb8h2TRgb45AUeR2ZtIN39X086rZ148kw6cBQQBx8y5
        vlV7U2yzbranNgOitQTO0bXXtA3dgvs=
X-Google-Smtp-Source: AA0mqf610DQIjF+O0DgqpzNYgYex1vf8d0ahdx+2NgJAd3e7xYmyU5YHtBQTIoTtXiwW8BokTUSi4CrnnpE=
X-Received: from avagin.kir.corp.google.com ([2620:0:1008:11:8cf3:f53:2863:82a3])
 (user=avagin job=sendgmr) by 2002:aa7:93b3:0:b0:56a:af55:629c with SMTP id
 x19-20020aa793b3000000b0056aaf55629cmr1351902pff.82.1668151925950; Thu, 10
 Nov 2022 23:32:05 -0800 (PST)
Date:   Thu, 10 Nov 2022 23:31:50 -0800
In-Reply-To: <20221111073154.784261-1-avagin@google.com>
Mime-Version: 1.0
References: <20221111073154.784261-1-avagin@google.com>
X-Mailer: git-send-email 2.38.1.493.g58b659f92b-goog
Message-ID: <20221111073154.784261-2-avagin@google.com>
Subject: [PATCH 1/5] seccomp: don't use semaphore and wait_queue together
From:   Andrei Vagin <avagin@google.com>
To:     Kees Cook <keescook@chromium.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Christian Brauner <brauner@kernel.org>
Cc:     linux-kernel@vger.kernel.org, Andrei Vagin <avagin@gmail.com>,
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
2.38.1.493.g58b659f92b-goog

