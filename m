Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 49E106AFFB8
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Mar 2023 08:32:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229785AbjCHHcX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Mar 2023 02:32:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229786AbjCHHcS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Mar 2023 02:32:18 -0500
Received: from mail-pf1-x44a.google.com (mail-pf1-x44a.google.com [IPv6:2607:f8b0:4864:20::44a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 856D9A838D
        for <linux-kernel@vger.kernel.org>; Tue,  7 Mar 2023 23:32:12 -0800 (PST)
Received: by mail-pf1-x44a.google.com with SMTP id w3-20020aa78583000000b005d244af158eso8586521pfn.23
        for <linux-kernel@vger.kernel.org>; Tue, 07 Mar 2023 23:32:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1678260732;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=KdP6YpLIkrgOw0lYy0bdzpscqpNI4s/RcyKWmelvr0E=;
        b=QLqdFxWJJTCcjLfJJw26wi68d2otuqveE486Q1LDW5sQla52Ywi+1Tl4jv3D4AxLUw
         3avLGCXQb+mv1yWcYc08B7I0oRGzwex3vI06gsV9j61XaiBQsgKuYpRXvXpAalOSSNev
         9uW+1N9swUVFYiNNUrLahwCYNt8pSOAyNrjbAuij0LyQiw2yMX2MGn3B10pJ9i8bTgk8
         pmgTIp307skmeFk5+T/6dvS64gc5D0SRFQVxDOobzth79IinQln6GNfwHB1AE9clAVAn
         dBp7xSgYLwfXWfxPMz/dmFQ/DMUnjXmUJAoQl3bjX5c4uxyGngzH+SlozLWaWG8rRxiF
         LfNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678260732;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KdP6YpLIkrgOw0lYy0bdzpscqpNI4s/RcyKWmelvr0E=;
        b=QFiuRgX2xCLHr9YfL6uOxZiJ8F1YwAawOOYt2Xzm8/B/hKkW5k4UnluRs6YLUQmMHS
         CDqDa4zXovp10OK3jiJVCHmXG7uH2UKd5W9JHvEEPfkgd40P06WM5EYsHmFXAdfPiTHE
         1gEzFP2FQ0rbIJsCx6K72w0yThWQMEqWRlk5IUgnmsymYvXYqpcN++0FzEes7RnRrTub
         tMSmjtaxzT+ddK8utoouvNH4HdWu5iCDKhZFof3fQkKAGaGnHa/R///Dfc42QPWGzgfy
         1xk3NrmhT3WdIOEtfIH6tXyaVAR19NOekq+8ToEt77XtHYqytMNrKGd/O962ZaEDKKBU
         POuQ==
X-Gm-Message-State: AO0yUKUDaHwfIb8Eau5/KHuPxT6LBvSPghaxDu2HxRZjn41z03bAdpBe
        GaYo8t/jTARp86P6FN2qWHJeLEV9ID0=
X-Google-Smtp-Source: AK7set8B3jj38rn8ptglrW7yWvEHIdy5OdCXZtLU8YjO4V8UaFgGNiU2Ro861eQ0I/L5FK8DARZmS6xetmo=
X-Received: from avagin.kir.corp.google.com ([2620:0:1008:11:b53:99a6:b4fe:b30b])
 (user=avagin job=sendgmr) by 2002:a17:902:f783:b0:19c:140d:aada with SMTP id
 q3-20020a170902f78300b0019c140daadamr6499087pln.2.1678260731766; Tue, 07 Mar
 2023 23:32:11 -0800 (PST)
Date:   Tue,  7 Mar 2023 23:31:56 -0800
In-Reply-To: <20230308073201.3102738-1-avagin@google.com>
Mime-Version: 1.0
References: <20230308073201.3102738-1-avagin@google.com>
X-Mailer: git-send-email 2.40.0.rc0.216.gc4246ad0f0-goog
Message-ID: <20230308073201.3102738-2-avagin@google.com>
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
index cebf26445f9e..9fca9345111c 100644
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
+	atomic_inc(&match->notif->requests);
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
+	if (atomic_dec_if_positive(&filter->notif->requests) >= 0)
+		return 0;
+
+	for (;;) {
+		ret = prepare_to_wait_event(&filter->wqh, &wait, TASK_INTERRUPTIBLE);
+
+		if (atomic_dec_if_positive(&filter->notif->requests) >= 0)
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
+			atomic_inc(&filter->notif->requests);
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
2.40.0.rc0.216.gc4246ad0f0-goog

