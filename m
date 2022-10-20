Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6FFBE6054B0
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Oct 2022 03:11:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229979AbiJTBLF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Oct 2022 21:11:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229755AbiJTBLC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Oct 2022 21:11:02 -0400
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95B481645EB
        for <linux-kernel@vger.kernel.org>; Wed, 19 Oct 2022 18:11:01 -0700 (PDT)
Received: by mail-pl1-x62d.google.com with SMTP id c24so18897775plo.3
        for <linux-kernel@vger.kernel.org>; Wed, 19 Oct 2022 18:11:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MSR840Eg0KSO7RPBBBPHvoR30CLZFIHcH+FNf/fc5cI=;
        b=l+CJQs4pADn878a0a4dqqLU5neAcFyZiJHhd1n/aek+VbEfNXwAY+ShQNj0RZ7zeHS
         H6ubAfJtsH7bNV13I9MtI2TdwsoRnDZyvxNNMuCY9ZaWhJ56bySUCz+WiMjvAqIA/6sN
         S/YHGxVxcCKbAc7IwxuVeeq3XwULZCC0gciZeeYeLb0B0p3E98bGhDHd1HddknTO+TeS
         FeNCt8WoP1HTb4IBmY23D2fGJfrVfh0bbVjNbyFI+MZIX+xUa368nTUHgq+YgZjwkRwr
         ThgEm7olehdHIDyvegW74ncxM8QSHMNvGHtvAnTDyL65QY8l5LDd26vt2A3sbXxbO0XI
         i8OA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MSR840Eg0KSO7RPBBBPHvoR30CLZFIHcH+FNf/fc5cI=;
        b=stZU4b9xmux3s1u3+ERRvLAClWa83dssai5PsXaMx7yvpfSfj5xMnosYbeDxHchkp7
         g05S8lC/35kdrl8K4MWFxR8nuluiVyOzwnEk4FJulroqg+9pCgymIyU+gM5r+8t8LAc8
         aBzJ4z2gbxigfaWafbQqqR0MdHt4smM7xovKizYU+YI4Ty4gGAN6CF9n9F9mfBQwUl4k
         0bgeKIWD0uSrjHd+xQECZmF4RTYXBq54q3SAAkHGYgQqenKMZRsbbKkD73K7+tWiMjee
         sydo6dSi755SNCA+PxhiL81eQ4PVgU08esTeT+jE70djE+fo/IHxdSp9hmUCo7QRWXme
         O6zA==
X-Gm-Message-State: ACrzQf2ikJ8RRbN9OMwmwxZHLnoeOa+hsiol3Axoxfq6N4hOduqZ0rr3
        2XKPGn37G53W+MJlWIwUfwwegOjLas5tyw==
X-Google-Smtp-Source: AMsMyM48KwZQSYfklPuN2QtN7LAe4KpLMMegizKpjQ3QkZu+EQHwkdw1IaZhjDwfVoyphnIbXWtYCg==
X-Received: by 2002:a17:90b:4fcc:b0:20f:81ca:ec18 with SMTP id qa12-20020a17090b4fcc00b0020f81caec18mr12706080pjb.176.1666228260538;
        Wed, 19 Oct 2022 18:11:00 -0700 (PDT)
Received: from laptop.hsd1.wa.comcast.net ([2601:600:8500:5f14:d627:c51e:516e:a105])
        by smtp.gmail.com with ESMTPSA id b14-20020a170902650e00b00174fa8cbf31sm11242938plk.303.2022.10.19.18.10.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Oct 2022 18:10:59 -0700 (PDT)
From:   Andrei Vagin <avagin@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     Andrei Vagin <avagin@gmail.com>,
        Andy Lutomirski <luto@amacapital.net>,
        Christian Brauner <brauner@kernel.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Kees Cook <keescook@chromium.org>,
        Ingo Molnar <mingo@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Peter Oskolkov <posk@google.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Tycho Andersen <tycho@tycho.pizza>,
        Will Drewry <wad@chromium.org>,
        Vincent Guittot <vincent.guittot@linaro.org>
Subject: [PATCH 1/5] seccomp: don't use semaphore and wait_queue together
Date:   Wed, 19 Oct 2022 18:10:44 -0700
Message-Id: <20221020011048.156415-2-avagin@gmail.com>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20221020011048.156415-1-avagin@gmail.com>
References: <20221020011048.156415-1-avagin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Here is no reason to use two different primitives that do similar things.

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
2.37.2

