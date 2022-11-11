Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 013D1625473
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Nov 2022 08:32:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233180AbiKKHc2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Nov 2022 02:32:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233067AbiKKHcU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Nov 2022 02:32:20 -0500
Received: from mail-pj1-x104a.google.com (mail-pj1-x104a.google.com [IPv6:2607:f8b0:4864:20::104a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69B05748EC
        for <linux-kernel@vger.kernel.org>; Thu, 10 Nov 2022 23:32:14 -0800 (PST)
Received: by mail-pj1-x104a.google.com with SMTP id k9-20020a17090a39c900b0021671e97a25so2444647pjf.1
        for <linux-kernel@vger.kernel.org>; Thu, 10 Nov 2022 23:32:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=FAikKIJpzJSZ8sMNRJucytFkAgb3856FUSnbWMixKa4=;
        b=X9bFZQmFEuyvlCDNautd2g7zE3QogsaL6ZRQn93JPv/cnHnA6KIs9Yxe7ezHRW73pC
         9t5iV3cM1zS8a6Oh2W3NmHoerCu7A//qi+0muJGW3dlQ8tm00Z3vua5jt9MZz8ogbxiO
         PE46s5PQLq7NobrPMsr+DvJndUHWmrAftNk7hIJe16h6ePFabb9BCekR7a6GDyTZu5mS
         QN3xxaOAEKwyOEN3OAeFnd43T6yPSgSigFtOOdXguEBq+jMAVxLL9Chdqlq/hvDhJweM
         Ikac8ETwe/l+HajtWjMGBdIBGd3UFp0fwXDFy4IlWHL3u134CttULEdja4jQLIxsF71q
         2ffQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=FAikKIJpzJSZ8sMNRJucytFkAgb3856FUSnbWMixKa4=;
        b=cfIcwgN0mKzj4QDFmxT9UYgV5kArtCip1JvWb3RSWeU22b91WgjD9vMGeYwUum3YSj
         c4UHb0JZW1LCVDAJ2b6I09kBdm1Zuc8BhJmSXqoHqMlsRyfkSwa1Em21bYxirP1o5zNz
         SUb7EQ0qDF8wkKtqaqk0/rPsgQKSmfhd+dDYZroYlan4SypGGq8kJ1Zn1TDOQZIVdKuI
         EILofWOztztdTnhYGoAtFlKwU9h2jU+KOq1id2p/emM8thmT2hy2Z1n/+naKbaernv3D
         aJi2nOGCwNzVR8ISqMsq+TzsGQnNOswk2hX2kR7oIE9oYbG/yYq8WZxCRStInL7x9yQZ
         saNw==
X-Gm-Message-State: ANoB5pmjWbFfUdTdkfPrkcTr8UVbhffTHwZEUFmSE3nZU5K6XaAS/fF2
        P7dQcU0AUEeNGTetu5AwUq+WQ0In+eg=
X-Google-Smtp-Source: AA0mqf4+KQYtBQAdTednfDxg6uq+PIssPfJaX3LmO0fPkFDzgB+8PtCQYsqgibBwGaJhEJRfdi6a45e1feY=
X-Received: from avagin.kir.corp.google.com ([2620:0:1008:11:8cf3:f53:2863:82a3])
 (user=avagin job=sendgmr) by 2002:a17:90b:b08:b0:212:d796:d30f with SMTP id
 bf8-20020a17090b0b0800b00212d796d30fmr672058pjb.9.1668151933972; Thu, 10 Nov
 2022 23:32:13 -0800 (PST)
Date:   Thu, 10 Nov 2022 23:31:54 -0800
In-Reply-To: <20221111073154.784261-1-avagin@google.com>
Mime-Version: 1.0
References: <20221111073154.784261-1-avagin@google.com>
X-Mailer: git-send-email 2.38.1.493.g58b659f92b-goog
Message-ID: <20221111073154.784261-6-avagin@google.com>
Subject: [PATCH 5/5] selftest/seccomp: add a new test for the sync mode of seccomp_user_notify
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

Test output:
RUN           global.user_notification_sync ...
seccomp_bpf.c:4279:user_notification_sync:basic: 8655 nsec/syscall
seccomp_bpf.c:4279:user_notification_sync:sync:	 2919 nsec/syscall
OK  global.user_notification_sync

Signed-off-by: Andrei Vagin <avagin@gmail.com>
---
 tools/testing/selftests/seccomp/seccomp_bpf.c | 88 +++++++++++++++++++
 1 file changed, 88 insertions(+)

diff --git a/tools/testing/selftests/seccomp/seccomp_bpf.c b/tools/testing/selftests/seccomp/seccomp_bpf.c
index 4ae6c8991307..605c120ba2c2 100644
--- a/tools/testing/selftests/seccomp/seccomp_bpf.c
+++ b/tools/testing/selftests/seccomp/seccomp_bpf.c
@@ -4241,6 +4241,94 @@ TEST(user_notification_addfd_rlimit)
 	close(memfd);
 }
 
+/* USER_NOTIF_BENCH_TIMEOUT is 100 miliseconds. */
+#define USER_NOTIF_BENCH_TIMEOUT  100000000ULL
+#define NSECS_PER_SEC            1000000000ULL
+
+#ifndef SECCOMP_USER_NOTIF_FD_SYNC_WAKE_UP
+#define SECCOMP_USER_NOTIF_FD_SYNC_WAKE_UP (1UL << 0)
+#define SECCOMP_IOCTL_NOTIF_SET_FLAGS  SECCOMP_IOW(4, __u64)
+#endif
+
+static uint64_t user_notification_sync_loop(struct __test_metadata *_metadata,
+					    char *test_name, int listener)
+{
+	struct timespec ts;
+	uint64_t start, end, nr;
+	struct seccomp_notif req = {};
+	struct seccomp_notif_resp resp = {};
+
+	clock_gettime(CLOCK_MONOTONIC, &ts);
+	start = ts.tv_nsec + ts.tv_sec * NSECS_PER_SEC;
+	for (end = start, nr = 0; end - start < USER_NOTIF_BENCH_TIMEOUT; nr++) {
+		memset(&req, 0, sizeof(req));
+		req.pid = 0;
+		ASSERT_EQ(ioctl(listener, SECCOMP_IOCTL_NOTIF_RECV, &req), 0);
+
+		ASSERT_EQ(req.data.nr,  __NR_getppid);
+
+		resp.id = req.id;
+		resp.error = 0;
+		resp.val = USER_NOTIF_MAGIC;
+		resp.flags = 0;
+		ASSERT_EQ(ioctl(listener, SECCOMP_IOCTL_NOTIF_SEND, &resp), 0);
+
+		clock_gettime(CLOCK_MONOTONIC, &ts);
+		end = ts.tv_nsec + ts.tv_sec * NSECS_PER_SEC;
+	}
+	TH_LOG("%s:\t%lld nsec/syscall", test_name, USER_NOTIF_BENCH_TIMEOUT / nr);
+	return nr;
+}
+
+TEST(user_notification_sync)
+{
+	pid_t pid;
+	long ret;
+	int status, listener;
+	unsigned long calls, sync_calls;
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
+	pid = fork();
+	ASSERT_GE(pid, 0);
+
+	if (pid == 0) {
+		while (1) {
+			ret = syscall(__NR_getppid);
+			if (ret == USER_NOTIF_MAGIC)
+				continue;
+			break;
+		}
+		_exit(1);
+	}
+
+	calls = user_notification_sync_loop(_metadata, "basic", listener);
+
+	/* Try to set invalid flags. */
+	EXPECT_SYSCALL_RETURN(-EINVAL,
+		ioctl(listener, SECCOMP_IOCTL_NOTIF_SET_FLAGS, 0xffffffff, 0));
+
+	ASSERT_EQ(ioctl(listener, SECCOMP_IOCTL_NOTIF_SET_FLAGS,
+			SECCOMP_USER_NOTIF_FD_SYNC_WAKE_UP, 0), 0);
+
+	sync_calls = user_notification_sync_loop(_metadata, "sync", listener);
+
+	EXPECT_GT(sync_calls, calls);
+
+	kill(pid, SIGKILL);
+	ASSERT_EQ(waitpid(pid, &status, 0), pid);
+	ASSERT_EQ(true, WIFSIGNALED(status));
+	ASSERT_EQ(SIGKILL, WTERMSIG(status));
+}
+
+
 /* Make sure PTRACE_O_SUSPEND_SECCOMP requires CAP_SYS_ADMIN. */
 FIXTURE(O_SUSPEND_SECCOMP) {
 	pid_t pid;
-- 
2.38.1.493.g58b659f92b-goog

