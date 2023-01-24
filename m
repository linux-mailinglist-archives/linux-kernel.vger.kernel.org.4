Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 77DFF67A702
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Jan 2023 00:42:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234323AbjAXXm2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Jan 2023 18:42:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234039AbjAXXmP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jan 2023 18:42:15 -0500
Received: from mail-pl1-x64a.google.com (mail-pl1-x64a.google.com [IPv6:2607:f8b0:4864:20::64a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8FBC4997F
        for <linux-kernel@vger.kernel.org>; Tue, 24 Jan 2023 15:42:11 -0800 (PST)
Received: by mail-pl1-x64a.google.com with SMTP id j16-20020a170902da9000b00194c056109eso9750165plx.18
        for <linux-kernel@vger.kernel.org>; Tue, 24 Jan 2023 15:42:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=8/JrJgyN+mBphtoymyqpedRSMPQyxXzI/fFyz6RiTZs=;
        b=Nm2AcpMznwiKEnd1/Ey177FD+c9SBaCTTy/WvSRxfjzHfyp0s7lkLF374MJHtE8g2+
         ek0C0I6omsMdcME2Lcqxsqo+u6HUdoXO/njA7NR9XOLk7A4BNx4MFuNTQsMSndgDb38e
         3oHoX95tyxRlgkRFhejIrMxK+4jBm7BYjQO9fEJ4f5GguGeyq4RU2KakiHpqX/X3RLPZ
         gy6wZFlqqMuho8v/EkxfGr0k+Z/hSIWozfDG9w1qag3eB1UfPwAfi0hZiFBAmZ8zQrza
         L+BmvAAViLJ7gLA8kmIR+Hn/0FAgjmOL7BfIOVEp2GbKwARAEM/maRzRzmydo+Ysolq0
         UaNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8/JrJgyN+mBphtoymyqpedRSMPQyxXzI/fFyz6RiTZs=;
        b=PNbJxellyaH0Kmz219Dt29B9h1pD8PUuOX4Pj5HXEx5fee4dlmRqbeBkToj2HzLhvi
         3s61CUEGl6d7RcyMmhMrDLEPVTG0xCQdVFoADcVxy7vTmDvH/KyYVuMhno1Sj4w+3aCX
         8HhjXETNc8T+O7vuWU55biRVVvPb+kEfbABAB1YrfP/MdqdDw2bCc7SCb7BWNMzP6eBn
         LYc3E0MYl5blukLEeVjsYGDnUEWYY6qzkOmEO6iwKa2bKsuOSWUo8PIrviJSeVQ7h5Y3
         t1ogOJlIrJkiz1Sq8EdnFrc70GRBnext7HjoP7ky/tZtw3dMLIEjc1V/svXL1jF89p4J
         bHTQ==
X-Gm-Message-State: AO0yUKVVRuDAqx+sgr2mv4H5CQkOm74lWqB4P1i8oUUwv28hat0nAi+Q
        J8KNX6e4hiVExAkoNu534F+j0oNkqq8=
X-Google-Smtp-Source: AK7set9Wmizd7z7vYQNwsPVm1tjNYb58BQTNA+fVhqRtFYtQnvfvdrcASe/ybe+Nzt4gphhpeAngbZTqAgE=
X-Received: from avagin.kir.corp.google.com ([2620:0:1008:11:cf1b:2f7f:3ca1:6488])
 (user=avagin job=sendgmr) by 2002:a05:6a00:22c9:b0:590:e49:9ce7 with SMTP id
 f9-20020a056a0022c900b005900e499ce7mr428597pfj.13.1674603731171; Tue, 24 Jan
 2023 15:42:11 -0800 (PST)
Date:   Tue, 24 Jan 2023 15:41:55 -0800
In-Reply-To: <20230124234156.211569-1-avagin@google.com>
Mime-Version: 1.0
References: <20230124234156.211569-1-avagin@google.com>
X-Mailer: git-send-email 2.39.1.405.gd4c25cc71f-goog
Message-ID: <20230124234156.211569-6-avagin@google.com>
Subject: [PATCH 5/6] selftest/seccomp: add a new test for the sync mode of seccomp_user_notify
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

Test output:
 #  RUN           global.user_notification_sync ...
 #            OK  global.user_notification_sync
 ok 51 global.user_notification_sync

Signed-off-by: Andrei Vagin <avagin@gmail.com>
---
 tools/testing/selftests/seccomp/seccomp_bpf.c | 55 +++++++++++++++++++
 1 file changed, 55 insertions(+)

diff --git a/tools/testing/selftests/seccomp/seccomp_bpf.c b/tools/testing/selftests/seccomp/seccomp_bpf.c
index 9c2f448bb3a9..05b8de6d1fcb 100644
--- a/tools/testing/selftests/seccomp/seccomp_bpf.c
+++ b/tools/testing/selftests/seccomp/seccomp_bpf.c
@@ -4243,6 +4243,61 @@ TEST(user_notification_addfd_rlimit)
 	close(memfd);
 }
 
+#ifndef SECCOMP_USER_NOTIF_FD_SYNC_WAKE_UP
+#define SECCOMP_USER_NOTIF_FD_SYNC_WAKE_UP (1UL << 0)
+#define SECCOMP_IOCTL_NOTIF_SET_FLAGS  SECCOMP_IOW(4, __u64)
+#endif
+
+TEST(user_notification_sync)
+{
+	struct seccomp_notif req = {};
+	struct seccomp_notif_resp resp = {};
+	int status, listener;
+	pid_t pid;
+	long ret;
+
+	ret = prctl(PR_SET_NO_NEW_PRIVS, 1, 0, 0, 0);
+	ASSERT_EQ(0, ret) {
+		TH_LOG("Kernel does not support PR_SET_NO_NEW_PRIVS!");
+	}
+
+	listener = user_notif_syscall(__NR_getppid,
+				      SECCOMP_FILTER_FLAG_NEW_LISTENER);
+	ASSERT_GE(listener, 0);
+
+	/* Try to set invalid flags. */
+	EXPECT_SYSCALL_RETURN(-EINVAL,
+		ioctl(listener, SECCOMP_IOCTL_NOTIF_SET_FLAGS, 0xffffffff, 0));
+
+	ASSERT_EQ(ioctl(listener, SECCOMP_IOCTL_NOTIF_SET_FLAGS,
+			SECCOMP_USER_NOTIF_FD_SYNC_WAKE_UP, 0), 0);
+
+	pid = fork();
+	ASSERT_GE(pid, 0);
+	if (pid == 0) {
+		ret = syscall(__NR_getppid);
+		ASSERT_EQ(ret, USER_NOTIF_MAGIC) {
+			_exit(1);
+		}
+		_exit(0);
+	}
+
+	req.pid = 0;
+	ASSERT_EQ(ioctl(listener, SECCOMP_IOCTL_NOTIF_RECV, &req), 0);
+
+	ASSERT_EQ(req.data.nr,  __NR_getppid);
+
+	resp.id = req.id;
+	resp.error = 0;
+	resp.val = USER_NOTIF_MAGIC;
+	resp.flags = 0;
+	ASSERT_EQ(ioctl(listener, SECCOMP_IOCTL_NOTIF_SEND, &resp), 0);
+
+	ASSERT_EQ(waitpid(pid, &status, 0), pid);
+	ASSERT_EQ(status, 0);
+}
+
+
 /* Make sure PTRACE_O_SUSPEND_SECCOMP requires CAP_SYS_ADMIN. */
 FIXTURE(O_SUSPEND_SECCOMP) {
 	pid_t pid;
-- 
2.39.1.405.gd4c25cc71f-goog

