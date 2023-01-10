Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B92A8664E13
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Jan 2023 22:32:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234837AbjAJVcB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Jan 2023 16:32:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234103AbjAJVbT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jan 2023 16:31:19 -0500
Received: from mail-pg1-x54a.google.com (mail-pg1-x54a.google.com [IPv6:2607:f8b0:4864:20::54a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 592BC6953A
        for <linux-kernel@vger.kernel.org>; Tue, 10 Jan 2023 13:30:27 -0800 (PST)
Received: by mail-pg1-x54a.google.com with SMTP id i70-20020a638749000000b004b2b09ec530so3351765pge.3
        for <linux-kernel@vger.kernel.org>; Tue, 10 Jan 2023 13:30:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=bkELdbPnw9+w61A8fpDNrJsicK3/uTJLSpCSm5duGgo=;
        b=dgV9j6PjmL+d29HbfIHOLglcm3Ui8wA2gq+75miT4vD/C/CLZ3DxYtlOdM+D9OVFpB
         H9vIp/JvWx8LOffaSAl7VtdVcPRUZR7NVGaxUgyaeyWic1iPgn7eYsnTSpCui8gRGZX4
         vfmeD/UrL1t7W13Y27A4PTyyuVwWk7eCwh7oczcNObs3oJzom7c2ZsleZeYL3ph0vzU+
         Ubb8+lSuyGj5zyy6sLo/5Njz6sdjL8jb2QIMImuaTbisLMhvX/PM6MP2ZJoKXymtf/g9
         IvTdjiFwZSeQz3VkOK81Mhac4fNtL1yEEfKqmdDuqiMVPK0Jf8j+Yd+bjTHn6YTC2jq+
         lAKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=bkELdbPnw9+w61A8fpDNrJsicK3/uTJLSpCSm5duGgo=;
        b=cXOHM2cRc7s3KgDf8pv12dXth76xLtvDPYvC2ejFG8yqXn5yVxnR+6MQb+Y1Tnh5CE
         LhTRjT2oMdzOFEZtXzQUmWMrQ66a0yH2ziLp1yz+ZqGKcQHBaE2QazrFTtUWqBAuGSWG
         9IVtjUbIb4kSlWapJVghaUvZ+uSWBInTQOtV1+YX1zwSv3d75of2HR2mMT6b5AMDsKOW
         VeYJPfWDxA6lFMBU6wQ+K4H5ylLoymz2yqcMgFUYc4SFCcGxxz9XOVqzosqG1Jo7LPAT
         9Nea0JQJtHtTsBYpJNEsjlgql1glssykv3+2S8GmFi7AKHJJxMuNmZXDAuDDJO9A15Jw
         kqfg==
X-Gm-Message-State: AFqh2kp/VA6lnmclDnUytFR6SY8DfNk0TMhD9S7cAr97QRvDNN9atYRr
        uJgD9Z0ToLKIRmsTrty7GgGuInhfvVo=
X-Google-Smtp-Source: AMrXdXtaEuSi7cf5KVjZXoaz5qjgVykb8pKVmq0/Xn3l3FPcNyjnVlP58xa6RMXCC+dzEXHZUF444DEeO6E=
X-Received: from avagin.kir.corp.google.com ([2620:0:1008:11:6203:13b5:2d85:b75c])
 (user=avagin job=sendgmr) by 2002:a17:90a:f315:b0:225:b164:8886 with SMTP id
 ca21-20020a17090af31500b00225b1648886mr4979473pjb.65.1673386226828; Tue, 10
 Jan 2023 13:30:26 -0800 (PST)
Date:   Tue, 10 Jan 2023 13:30:10 -0800
In-Reply-To: <20230110213010.2683185-1-avagin@google.com>
Mime-Version: 1.0
References: <20230110213010.2683185-1-avagin@google.com>
X-Mailer: git-send-email 2.39.0.314.g84b9a713c41-goog
Message-ID: <20230110213010.2683185-6-avagin@google.com>
Subject: [PATCH 5/5] selftest/seccomp: add a new test for the sync mode of seccomp_user_notify
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
index 9c2f448bb3a9..e4207cddd668 100644
--- a/tools/testing/selftests/seccomp/seccomp_bpf.c
+++ b/tools/testing/selftests/seccomp/seccomp_bpf.c
@@ -4243,6 +4243,94 @@ TEST(user_notification_addfd_rlimit)
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
2.39.0.314.g84b9a713c41-goog

