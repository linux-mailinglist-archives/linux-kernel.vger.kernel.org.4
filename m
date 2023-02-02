Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D0F868739D
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Feb 2023 04:05:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231688AbjBBDFD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Feb 2023 22:05:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231697AbjBBDEs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Feb 2023 22:04:48 -0500
Received: from mail-pl1-x64a.google.com (mail-pl1-x64a.google.com [IPv6:2607:f8b0:4864:20::64a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5BCD1167C
        for <linux-kernel@vger.kernel.org>; Wed,  1 Feb 2023 19:04:44 -0800 (PST)
Received: by mail-pl1-x64a.google.com with SMTP id x6-20020a1709029a4600b0019747acb19cso284637plv.5
        for <linux-kernel@vger.kernel.org>; Wed, 01 Feb 2023 19:04:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vmKwcK8nOOGhNuEtAlRRmLDd6QNY/0CCAJIdQUNwbyw=;
        b=WhSUIlvPiP3t5Byp86BE1TnJ8KqwB3vuESXiHWZr7bEaClkelX4feC4ncvGcBO0C+f
         a54h37SiNBF0GMyZYRdy7z0INyzyaC4eoVO9IriJLi1iQoCcTMZxh3YAhEdsCq9tCEZv
         GbtIgZg71Z6r5kUcVlmeT5vIlQcDWG5/bMTlUIowY8VRXv7OLNKhxy8hmT7E2yQ/S+p2
         SmjZJEV+T6C88Ajwr5SC5w1dXM/4xD9k9CGkdF0dEdbOZ5zfCjo4qR/5J4QiOrstcj1N
         28jCmuv1pplFDgdvqUwZbj74afDfGdeHMDLrjALR0ZBHK3LOGeyzYa94pp9p2IBmSPDV
         27hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=vmKwcK8nOOGhNuEtAlRRmLDd6QNY/0CCAJIdQUNwbyw=;
        b=ADu0viS2ufHyuYH62bGN5YzWc0Z0EGMwca9/qWBMFTqZvuWhzdjwAc6lC0NPESOqbj
         dsWOvVRwWV532s9PCQjQIUF9RU/V0gYJMA8NuOTPWHhwKGfKadxDUtKUg7bmWQNfowo3
         PBz0IATpjV5mCYuKwEiLrMia8RenncZ+N/ASE0MILwQIImQGTHA6lobM/Ih+qIx8MnOd
         ZDyLA9+WaFkMhCE9PXGqd7M1OyGcb8WKTuw7Jeo8sv02wtdIKeo58rwqhsaH9FqHoY3c
         ZplHvxvKnHX7zwrq9s3O1pp0SXUh9r8/1FIlj+zIvt8VYsduB7Smui3qttz4+giriZqz
         VJeA==
X-Gm-Message-State: AO0yUKUJpWxslg7P/izuTXulZnRYZx22JGoiQ/uq+QEmGwYLz+xq+PFc
        ibbvZ+6JehGZvzqQK1DflJ9CnfI2ZmI=
X-Google-Smtp-Source: AK7set8iJefZdCxQTodQno+AdNd417q5wQWzUK0/fJhTuHNxFMzHEZiXiWRnmqzYxSiXc9O5M2oo1BIRsM0=
X-Received: from avagin.kir.corp.google.com ([2620:0:1008:11:eee0:dc42:a911:8b59])
 (user=avagin job=sendgmr) by 2002:a17:90a:8903:b0:226:9980:67f3 with SMTP id
 u3-20020a17090a890300b00226998067f3mr44814pjn.1.1675307083813; Wed, 01 Feb
 2023 19:04:43 -0800 (PST)
Date:   Wed,  1 Feb 2023 19:04:27 -0800
In-Reply-To: <20230202030429.3304875-1-avagin@google.com>
Mime-Version: 1.0
References: <20230202030429.3304875-1-avagin@google.com>
X-Mailer: git-send-email 2.39.1.456.gfc5497dd1b-goog
Message-ID: <20230202030429.3304875-5-avagin@google.com>
Subject: [PATCH 4/6] seccomp: add the synchronous mode for seccomp_unotify
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

Signed-off-by: Andrei Vagin <avagin@google.com>
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
2.39.1.456.gfc5497dd1b-goog

