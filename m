Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 66891664E15
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Jan 2023 22:32:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234860AbjAJVcN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Jan 2023 16:32:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235077AbjAJVbP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jan 2023 16:31:15 -0500
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4893D687AF
        for <linux-kernel@vger.kernel.org>; Tue, 10 Jan 2023 13:30:26 -0800 (PST)
Received: by mail-yb1-xb4a.google.com with SMTP id r7-20020a25c107000000b006ff55ac0ee7so14015119ybf.15
        for <linux-kernel@vger.kernel.org>; Tue, 10 Jan 2023 13:30:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FgcxAE8iGG15WhvuAYkbURArrO/+on6Wx5AvlcLvta0=;
        b=leQdTYFdesAubkyBEKP4EGB8ajqVdgQISQqYPoEnT4j3qT2fDYjMXTQf7D9X0QtgyW
         iu6lh7wwkhKof9tuX5F8NR5c2e2zAy44O0cYUjjzdgWE8W2Rx3vcdQsJBexc6eR5vzlA
         ZXcacO0h8NcLqxDZOaSqjHbfjTJRkbwB6xy1W6R8le92hNg4V7iHGGqEtSPkBwPiz9cl
         1FsATCzRCkGyfsUGwOq9xZzX3QAK4fm7KjTdbUtGZanZDPIMuLqCdhlqFrFO/9RnOl42
         62JhQfumK/6MwxKQ+Kotogs3voCIG1rOdjDIGY2pxnTI3s0MlsAZAMML3L/Y8DhTIWO9
         jNLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=FgcxAE8iGG15WhvuAYkbURArrO/+on6Wx5AvlcLvta0=;
        b=KJmAeYIuiTsPn7D9P5iG92EWtE+h2dvYervCFQNkcRESz6T5aBq+SZ3jcBCwStuiip
         I9iC8fjiDEvtH/btC1CdyocgXYXSiplziElkylgdQa9TJFNoaRIRCOVlG4Hr/Y39JgL0
         Iat+U10i03i8ShnMYNdsEzP0jq7Jqivz6S20UZqGEjIlYKiPV6o5pBcsTAc8khuqPtim
         BUQIgWSTc87ZwFHMDV2njhpekFKfTLQ2t0IBkdCr89r1esRQQFxUzjDU7c+eRGrOFcGr
         iOzexuNZLBN1M2oYLN0zvK7kuad9B0r2R6OuOQv9c3ShTwNk4ocM9cFp3cFk6MJ9F2di
         8RVQ==
X-Gm-Message-State: AFqh2kpaRAjfefEm1XaW5OIidTtfpr95+cdzanDA8aOfGKj1i2hvD5xR
        G+tRhEYzGsSxh9L24xJc8jTzyQMF+yk=
X-Google-Smtp-Source: AMrXdXt4sillpyrhcyoyGEWUU4IQTVShzCbFUy55/MCxI+FFS/AsF5aHBZazdJjIT9mWZr1W1DXt8RQkO3k=
X-Received: from avagin.kir.corp.google.com ([2620:0:1008:11:6203:13b5:2d85:b75c])
 (user=avagin job=sendgmr) by 2002:a5b:9cc:0:b0:722:f042:1036 with SMTP id
 y12-20020a5b09cc000000b00722f0421036mr8150828ybq.34.1673386225217; Tue, 10
 Jan 2023 13:30:25 -0800 (PST)
Date:   Tue, 10 Jan 2023 13:30:09 -0800
In-Reply-To: <20230110213010.2683185-1-avagin@google.com>
Mime-Version: 1.0
References: <20230110213010.2683185-1-avagin@google.com>
X-Mailer: git-send-email 2.39.0.314.g84b9a713c41-goog
Message-ID: <20230110213010.2683185-5-avagin@google.com>
Subject: [PATCH 4/5] seccomp: add the synchronous mode for seccomp_unotify
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
Content-Transfer-Encoding: quoted-printable
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

seccomp_unotify allows more privileged processes do actions on behalf
of less privileged processes.

In many cases, the workflow is fully synchronous. It means a target
process triggers a system call and passes controls to a supervisor
process that handles the system call and returns controls to the target
process. In this context, "synchronous" means that only one process is
running and another one is waiting.

There is the WF_CURRENT_CPU flag that is used to advise the scheduler to
move the wakee to the current CPU. For such synchronous workflows, it
makes context switches a few times faster.

Right now, each interaction takes 12=C2=B5s. With this patch, it takes abou=
t
3=C2=B5s.

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
=20
+#define SECCOMP_USER_NOTIF_FD_SYNC_WAKE_UP (1UL << 0)
+
 /* valid flags for seccomp_notif_addfd */
 #define SECCOMP_ADDFD_FLAG_SETFD	(1UL << 0) /* Specify remote fd */
 #define SECCOMP_ADDFD_FLAG_SEND		(1UL << 1) /* Addfd and return it, atomic=
ally */
@@ -150,4 +152,6 @@ struct seccomp_notif_addfd {
 #define SECCOMP_IOCTL_NOTIF_ADDFD	SECCOMP_IOW(3, \
 						struct seccomp_notif_addfd)
=20
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
@@ -1117,7 +1120,10 @@ static int seccomp_do_user_notification(int this_sys=
call,
 	INIT_LIST_HEAD(&n.addfd);
=20
 	atomic_add(1, &match->notif->requests);
-	wake_up_poll(&match->wqh, EPOLLIN | EPOLLRDNORM);
+	if (match->notif->flags & SECCOMP_USER_NOTIF_FD_SYNC_WAKE_UP)
+		wake_up_poll_on_current_cpu(&match->wqh, EPOLLIN | EPOLLRDNORM);
+	else
+		wake_up_poll(&match->wqh, EPOLLIN | EPOLLRDNORM);
=20
 	/*
 	 * This is where we wait for a reply from userspace.
@@ -1593,7 +1599,10 @@ static long seccomp_notify_send(struct seccomp_filte=
r *filter,
 	knotif->error =3D resp.error;
 	knotif->val =3D resp.val;
 	knotif->flags =3D resp.flags;
-	complete(&knotif->ready);
+	if (filter->notif->flags & SECCOMP_USER_NOTIF_FD_SYNC_WAKE_UP)
+		complete_on_current_cpu(&knotif->ready);
+	else
+		complete(&knotif->ready);
 out:
 	mutex_unlock(&filter->notify_lock);
 	return ret;
@@ -1623,6 +1632,22 @@ static long seccomp_notify_id_valid(struct seccomp_f=
ilter *filter,
 	return ret;
 }
=20
+static long seccomp_notify_set_flags(struct seccomp_filter *filter,
+				    unsigned long flags)
+{
+	long ret;
+
+	if (flags & ~SECCOMP_USER_NOTIF_FD_SYNC_WAKE_UP)
+		return -EINVAL;
+
+	ret =3D mutex_lock_interruptible(&filter->notify_lock);
+	if (ret < 0)
+		return ret;
+	filter->notif->flags =3D flags;
+	mutex_unlock(&filter->notify_lock);
+	return 0;
+}
+
 static long seccomp_notify_addfd(struct seccomp_filter *filter,
 				 struct seccomp_notif_addfd __user *uaddfd,
 				 unsigned int size)
@@ -1752,6 +1777,8 @@ static long seccomp_notify_ioctl(struct file *file, u=
nsigned int cmd,
 	case SECCOMP_IOCTL_NOTIF_ID_VALID_WRONG_DIR:
 	case SECCOMP_IOCTL_NOTIF_ID_VALID:
 		return seccomp_notify_id_valid(filter, buf);
+	case SECCOMP_IOCTL_NOTIF_SET_FLAGS:
+		return seccomp_notify_set_flags(filter, arg);
 	}
=20
 	/* Extensible Argument ioctls */
--=20
2.39.0.314.g84b9a713c41-goog

