Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 032096AFFBC
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Mar 2023 08:32:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229835AbjCHHcl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Mar 2023 02:32:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229841AbjCHHce (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Mar 2023 02:32:34 -0500
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B36B0A7295
        for <linux-kernel@vger.kernel.org>; Tue,  7 Mar 2023 23:32:21 -0800 (PST)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-536be78056eso160482717b3.1
        for <linux-kernel@vger.kernel.org>; Tue, 07 Mar 2023 23:32:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1678260741;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=eiPiVq4qnV5b3yyOHukFyCYe6YsVtSEQ0lj3gSUnBVU=;
        b=Nc5RYpMPMcJmlMk8UTyky0FVierCho4KPLKPoggzP9J288W8hSAzN7Nt/ILUPiMFol
         7a3b7CX70eq/+Byb31yem1HSegPxIZqw1QD7EraC/qnTvl8KGW2P8tbqjWSqbFdUnxiO
         QhoqxfYm8GTR8vJZwIhhtIjIwJ8OxnUcFhocWX4k6ZYfLlNxjBIKAYRTvYAenm6kCJ55
         e2oqd0X5MvmYOv1Dhn8Z9ClBPU9VPd0uXVryuyYDO0BAFCKsAoeEM/gec8NvjRK8p69i
         5Tg5FFypJJhpDSOMOuo9D7eFHl7f1lnIqU6W+nx+0SSnMapnyv6K/abDJwIG1p6ym3+4
         EJHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678260741;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=eiPiVq4qnV5b3yyOHukFyCYe6YsVtSEQ0lj3gSUnBVU=;
        b=Kv9BdiBf7hs2gcew48vG5S0Wq583yT8W7NgQAFjkX/xK4QoLNb1Qj7o76s8TiLvYel
         10prIVLJWjBFojnV3GbaLPgZd5Q+ds3dZgQEzXP4LqA4EBE0Eg6puIWIGVOV1+jl8KYA
         CIhIYrebS/pFlqlcrExqZJuVucMpqbD+2rBFrlUemkHBaHujcLx+BTY1xNhQ+Nq1oi/i
         pZtj7y1LHJLatUDz8BOLzLD8saY/MNS8rH7nvfx4tA7sQ3LP97s6yJKUZiXyqmHs5ZGI
         AkrBe5k/uwtB1VhLNs8yGibcoXp1iEwVFdVulUFQHDv1zOjmcbtPKe0fPjfQrWYhwyHA
         MaVg==
X-Gm-Message-State: AO0yUKU4AdPePHR/b0aC+QrgQkbhIg/Vw/Vs4PuVvam0BaOXkAj88krU
        qGYu9fS5Ua0WEG66sI4Iei6qcXtkI0c=
X-Google-Smtp-Source: AK7set8qvEHThPBqFtM4csDHhQ7h5MWe3xxPdzBqrQ71ITAES3t7H95wYlw1p6MVlrSvgAPTabY7hme9UNg=
X-Received: from avagin.kir.corp.google.com ([2620:0:1008:11:b53:99a6:b4fe:b30b])
 (user=avagin job=sendgmr) by 2002:a0d:ea13:0:b0:533:54d1:9e40 with SMTP id
 t19-20020a0dea13000000b0053354d19e40mr4ywe.21.1678260740739; Tue, 07 Mar 2023
 23:32:20 -0800 (PST)
Date:   Tue,  7 Mar 2023 23:32:00 -0800
In-Reply-To: <20230308073201.3102738-1-avagin@google.com>
Mime-Version: 1.0
References: <20230308073201.3102738-1-avagin@google.com>
X-Mailer: git-send-email 2.40.0.rc0.216.gc4246ad0f0-goog
Message-ID: <20230308073201.3102738-6-avagin@google.com>
Subject: [PATCH 5/6] selftest/seccomp: add a new test for the sync mode of seccomp_user_notify
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
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Test output:
 #  RUN           global.user_notification_sync ...
 #            OK  global.user_notification_sync
 ok 51 global.user_notification_sync

Signed-off-by: Andrei Vagin <avagin@google.com>
---
 tools/testing/selftests/seccomp/seccomp_bpf.c | 55 +++++++++++++++++++
 1 file changed, 55 insertions(+)

diff --git a/tools/testing/selftests/seccomp/seccomp_bpf.c b/tools/testing/selftests/seccomp/seccomp_bpf.c
index 43ec36b179dc..f6a04d88e02f 100644
--- a/tools/testing/selftests/seccomp/seccomp_bpf.c
+++ b/tools/testing/selftests/seccomp/seccomp_bpf.c
@@ -4255,6 +4255,61 @@ TEST(user_notification_addfd_rlimit)
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
2.40.0.rc0.216.gc4246ad0f0-goog

