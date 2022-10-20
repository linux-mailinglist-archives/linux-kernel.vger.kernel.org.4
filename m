Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A4FD26054B5
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Oct 2022 03:11:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229742AbiJTBL2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Oct 2022 21:11:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230122AbiJTBLJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Oct 2022 21:11:09 -0400
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2F351669A6
        for <linux-kernel@vger.kernel.org>; Wed, 19 Oct 2022 18:11:06 -0700 (PDT)
Received: by mail-pj1-x1029.google.com with SMTP id t10-20020a17090a4e4a00b0020af4bcae10so1569025pjl.3
        for <linux-kernel@vger.kernel.org>; Wed, 19 Oct 2022 18:11:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3p8cEHauNcqkL4kG4wAOXzGDd6JhummGET3RKuVhg5o=;
        b=KpqBtiFvdg/rxYhqM8UMKgbw4wfAZWNEAYm6f/68Q4ilz5ADiqoLnrVN0BBGvFgXei
         r/+yi4zJTHczr6toKOde2bi66paH32nklVclydKHdR0lWfYuPU0coxQDSs+gLyFFK3MS
         5zvTuLbDFjyxYhd0agNdb5v9azLZai/Qmp7QI8/y4lPClYkC3VyF1uWG3UQu+Li41DOY
         sVHj7uwTaQV48gMmayCCWArAVMjDdzw/fzXdYlRmwtoPbPvzrTeWFnDU7bkVWvvrSXt4
         C71MEv4mxVHvceGaWpiW49DgdVzhJ9YZiU3oG0aRzHhHcvY1oiq2XAaIHT6JG9weW0nK
         O+sA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3p8cEHauNcqkL4kG4wAOXzGDd6JhummGET3RKuVhg5o=;
        b=kLC4TLG2SfxO7wv/qwbNVNPNxiJEBwuI8YGWKUOftwnHPFWvpf929F8ACJSbKebum2
         kMRy3+dnVDfOho5gPa+5pmJjAdAk4b8LqdmGLBBRpHP8Hv2EgTGVusPiM41TRsbr41DF
         JRP8rfseycEPgnUHY3cifRNLre3DnQGNRqbXLpXcJ96PC041Cu0bz8k4VdJdIKVz8Rgm
         HN/CK/eQzrnANYlgR4TrcNjDbjtcBuAdee6Vu4lBiDkUmMRCu7kG0HptkFSgkdQxTmCA
         dPWIEG4A7Vg5um7ItO/jW3v/+2jP9zdm+utDcOw3xhXLqfz1qQLiVOxgUBHBSUZlckjb
         orvA==
X-Gm-Message-State: ACrzQf1UwYHixHOsq1EA8Xox293m9IvFqiB2HT724hEXh1dxOuXeHKer
        bLzHWDYTgJYsU4xNh01uIGxluTslSLwKKA==
X-Google-Smtp-Source: AMsMyM58Jo49H8jNbjcvyjUgRENHVrDoKhhZwlbmV3jvVupCpdkudE9FXwA35EtzrETAiEThczN/Zw==
X-Received: by 2002:a17:903:2344:b0:17f:7dc9:cde5 with SMTP id c4-20020a170903234400b0017f7dc9cde5mr11207629plh.47.1666228265632;
        Wed, 19 Oct 2022 18:11:05 -0700 (PDT)
Received: from laptop.hsd1.wa.comcast.net ([2601:600:8500:5f14:d627:c51e:516e:a105])
        by smtp.gmail.com with ESMTPSA id b14-20020a170902650e00b00174fa8cbf31sm11242938plk.303.2022.10.19.18.11.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Oct 2022 18:11:05 -0700 (PDT)
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
Subject: [PATCH 4/5] seccomp: add the synchronous mode for seccomp_unotify
Date:   Wed, 19 Oct 2022 18:10:47 -0700
Message-Id: <20221020011048.156415-5-avagin@gmail.com>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20221020011048.156415-1-avagin@gmail.com>
References: <20221020011048.156415-1-avagin@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

seccomp_unotify allows more privileged processes does actions on behalf
of less privileged processes.

In many cases, the workflow is fully synchronous. It means a target
process triggers a system call and passes controls to a supervisor
process that handles the system call and returns controls to the target
process. In this context, "synchronous" means that only one process is
running and another one is waiting.

There is the WF_CURRENT_CPU flag that is used to advise the scheduler to
move the wakee to the current CPU. For such synchronous workflows, it
makes context switches a few times faster.

Right now, each interaction takes 12µs. With this patch, it takes about
3µs.

This change introduce the SECCOMP_USER_NOTIF_FD_SYNC_WAKE_UP flag that
it used to enable the sync mode.

Signed-off-by: Andrei Vagin <avagin@gmail.com>
---
 include/uapi/linux/seccomp.h |  4 ++++
 kernel/seccomp.c             | 31 +++++++++++++++++++++++++++++--
 2 files changed, 33 insertions(+), 2 deletions(-)

diff --git a/include/uapi/linux/seccomp.h b/include/uapi/linux/seccomp.h
index 0fdc6ef02b94..dbfc9b37fcae 100644
--- a/include/uapi/linux/seccomp.h
+++ b/include/uapi/linux/seccomp.h
@@ -115,6 +115,8 @@ struct seccomp_notif_resp {
 	__u32 flags;
 };
 
+#define SECCOMP_USER_NOTIF_FD_SYNC_WAKE_UP (1UL << 0)
+
 /* valid flags for seccomp_notif_addfd */
 #define SECCOMP_ADDFD_FLAG_SETFD	(1UL << 0) /* Specify remote fd */
 #define SECCOMP_ADDFD_FLAG_SEND		(1UL << 1) /* Addfd and return it, atomically */
@@ -150,4 +152,6 @@ struct seccomp_notif_addfd {
 #define SECCOMP_IOCTL_NOTIF_ADDFD	SECCOMP_IOW(3, \
 						struct seccomp_notif_addfd)
 
+#define SECCOMP_IOCTL_NOTIF_SET_FLAGS	SECCOMP_IOW(4, __u64)
+
 #endif /* _UAPI_LINUX_SECCOMP_H */
diff --git a/kernel/seccomp.c b/kernel/seccomp.c
index 876022e9c88c..0a62d44f4898 100644
--- a/kernel/seccomp.c
+++ b/kernel/seccomp.c
@@ -143,9 +143,12 @@ struct seccomp_kaddfd {
  *           filter->notify_lock.
  * @next_id: The id of the next request.
  * @notifications: A list of struct seccomp_knotif elements.
+ * @flags: A set of SECCOMP_USER_NOTIF_FD_* flags.
  */
+
 struct notification {
 	atomic_t requests;
+	u32 flags;
 	u64 next_id;
 	struct list_head notifications;
 };
@@ -1117,7 +1120,10 @@ static int seccomp_do_user_notification(int this_syscall,
 	INIT_LIST_HEAD(&n.addfd);
 
 	atomic_add(1, &match->notif->requests);
-	wake_up_poll(&match->wqh, EPOLLIN | EPOLLRDNORM);
+	if (match->notif->flags & SECCOMP_USER_NOTIF_FD_SYNC_WAKE_UP)
+		wake_up_poll_on_current_cpu(&match->wqh, EPOLLIN | EPOLLRDNORM);
+	else
+		wake_up_poll(&match->wqh, EPOLLIN | EPOLLRDNORM);
 
 	/*
 	 * This is where we wait for a reply from userspace.
@@ -1593,7 +1599,10 @@ static long seccomp_notify_send(struct seccomp_filter *filter,
 	knotif->error = resp.error;
 	knotif->val = resp.val;
 	knotif->flags = resp.flags;
-	complete(&knotif->ready);
+	if (filter->notif->flags & SECCOMP_USER_NOTIF_FD_SYNC_WAKE_UP)
+		complete_on_current_cpu(&knotif->ready);
+	else
+		complete(&knotif->ready);
 out:
 	mutex_unlock(&filter->notify_lock);
 	return ret;
@@ -1623,6 +1632,22 @@ static long seccomp_notify_id_valid(struct seccomp_filter *filter,
 	return ret;
 }
 
+static long seccomp_notify_set_flags(struct seccomp_filter *filter,
+				    unsigned long flags)
+{
+	long ret;
+
+	if (flags & ~SECCOMP_USER_NOTIF_FD_SYNC_WAKE_UP)
+		return -EINVAL;
+
+	ret = mutex_lock_interruptible(&filter->notify_lock);
+	if (ret < 0)
+		return ret;
+	filter->notif->flags = flags;
+	mutex_unlock(&filter->notify_lock);
+	return 0;
+}
+
 static long seccomp_notify_addfd(struct seccomp_filter *filter,
 				 struct seccomp_notif_addfd __user *uaddfd,
 				 unsigned int size)
@@ -1752,6 +1777,8 @@ static long seccomp_notify_ioctl(struct file *file, unsigned int cmd,
 	case SECCOMP_IOCTL_NOTIF_ID_VALID_WRONG_DIR:
 	case SECCOMP_IOCTL_NOTIF_ID_VALID:
 		return seccomp_notify_id_valid(filter, buf);
+	case SECCOMP_IOCTL_NOTIF_SET_FLAGS:
+		return seccomp_notify_set_flags(filter, arg);
 	}
 
 	/* Extensible Argument ioctls */
-- 
2.37.2

