Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A1CD36AFFBB
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Mar 2023 08:32:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229754AbjCHHch (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Mar 2023 02:32:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229816AbjCHHcX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Mar 2023 02:32:23 -0500
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43B69AA242
        for <linux-kernel@vger.kernel.org>; Tue,  7 Mar 2023 23:32:19 -0800 (PST)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-5376fa4106eso161313527b3.7
        for <linux-kernel@vger.kernel.org>; Tue, 07 Mar 2023 23:32:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1678260738;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=N/zczmyojBS9P2rt92Hh+NQdVJTLpoFAFXyTJQmiZyg=;
        b=s/G0ZGPiIu+LtCsClWoP3xJ4KF91NU9KO2/f3Oh5EMHV82JxNgVxUMHBhQuFe1RB/9
         DmKSSpQH7/fOcJAsj+Wyfo2s/+jJuYmpBczyP1qMXTPlnvdWYEPGFJXBS4Bukyj6cuww
         JWq41rlZsYcERqCNTo2ogmEp4xUy1qZ0qh55tryMjF5UnbIaJ8n/U4IuJs6kzivuOQr6
         X5GYVGxDIKJ3fR3qnboPFaaEMzcDZrZEFxxvI9i+CPkVPs6i/lTZwqQd3T5x7I8iWjTj
         XIWyjkqfCza7F0XOBQcHGgg7YqlL3vpzxijs1x4on9MXLAOovFhpXbl8tgNYLvgCkumF
         xkUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678260738;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=N/zczmyojBS9P2rt92Hh+NQdVJTLpoFAFXyTJQmiZyg=;
        b=6SLd3K55yncXuIqlsU6Nt65qlGKESGs72uiecg7crtPacDtX/ragsrnmtMp+W/KsGc
         ov4S8F33Eu7SC8FwwKrQbihMbIQMsqjaFWY40osa9PXpNEBHequERcApn1JOq1372i1u
         00ysBjVazqV5vyQFukVzHHozYRDpn3RTPkGQ93fr3KOzj8MSy9Y2haFXjDqE1/VPwsbe
         2FqcbWuzBrRQsrP4pOpTQSXN14mGyFNkXrK6o97dltusT6zjTx4CFLjGWrpFmlvsu/ll
         EOyzOki09/aGU+p1v7blUhI8syH6MhJQM+hnR/h/ueIRJvK9S9TVBMhfmqXMRyqZE2X0
         jTKA==
X-Gm-Message-State: AO0yUKUKLb+o9pWYmoBEEjjyJvP339XcDlGvQmp8k7DjmMWRaCsC3sd5
        S036QpHASxPDDexsPguFLsgxdpyXjTA=
X-Google-Smtp-Source: AK7set/Rgn2XNpF1h9Xp6zthH1vqCWX2SvKTkS0/og89DfLnEwI/k79nooHRWKBJ+JEi/gk2Z0/kL0IuCbo=
X-Received: from avagin.kir.corp.google.com ([2620:0:1008:11:b53:99a6:b4fe:b30b])
 (user=avagin job=sendgmr) by 2002:a25:ae1c:0:b0:9f5:af6b:6f69 with SMTP id
 a28-20020a25ae1c000000b009f5af6b6f69mr13442474ybj.5.1678260738463; Tue, 07
 Mar 2023 23:32:18 -0800 (PST)
Date:   Tue,  7 Mar 2023 23:31:59 -0800
In-Reply-To: <20230308073201.3102738-1-avagin@google.com>
Mime-Version: 1.0
References: <20230308073201.3102738-1-avagin@google.com>
X-Mailer: git-send-email 2.40.0.rc0.216.gc4246ad0f0-goog
Message-ID: <20230308073201.3102738-5-avagin@google.com>
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
index 9fca9345111c..d323edeae7da 100644
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
 	atomic_inc(&match->notif->requests);
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
2.40.0.rc0.216.gc4246ad0f0-goog

