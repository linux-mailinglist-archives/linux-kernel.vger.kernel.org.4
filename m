Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7DA0B6054B6
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Oct 2022 03:11:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230390AbiJTBLc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Oct 2022 21:11:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230150AbiJTBLK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Oct 2022 21:11:10 -0400
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0DAD4169128
        for <linux-kernel@vger.kernel.org>; Wed, 19 Oct 2022 18:11:08 -0700 (PDT)
Received: by mail-pl1-x62a.google.com with SMTP id z20so18850604plb.10
        for <linux-kernel@vger.kernel.org>; Wed, 19 Oct 2022 18:11:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=q+qrgR/MUitgGFEN28UdJxxU/RHOuYqlke4g/Y2iteA=;
        b=PItxHKiLj7J1/b4y394GFbYMnhiM8mYdu7R5SmT7+rG7QCwJLP9WX/xaTofobo5zcF
         BFFbGFIOcE56vQVKV+aLrB/kkys2OJPRGMdh3LkbM7ILqHzQSPTpMkpsfYrJjbBFozb9
         CrVUWsRr2XPaeINndMHVm+D5mafY3zu1gKOhP9/xXI79mRF3gpEfoBG3+6G2Zh0X1r+6
         CPSXlEkiXzPX6WaTdZmS89/mnmTJQqxrwe9Kvfpkh2emabi/3l4P/FzsupCLxw/b7Qh3
         dpQOFRpXpHkug6mZQP+WZPn9VDBHONioWZqI5Ic5YwAnmWQ1Pi+dRlDNUXYEWECgtbpA
         wGZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=q+qrgR/MUitgGFEN28UdJxxU/RHOuYqlke4g/Y2iteA=;
        b=sQkk0obZrz+uD3bHXJ0nXpTOVF161sYG/qKb6XBqEEA5RcIntX2vEjfwmp13DeRLSE
         DjYzEVKjLAJgDS1FYPH5Q/r0KoNb7zAfOwgHC9vrMTlLWYJecarGJ3SAhDCOXqawDxrn
         N9+m1YzPeXp1IxJhYuoiugPW3fGHn+9h7K0jzbozfrQifqEqpMVu3qN2hvOcyfNxYcFK
         iPe+aThZ9ZipwF6RWgolBiMjfICwzn3TZdvq+y8U8gZWyQOFJBc0pu7hUsn0g+DojGcW
         svLftBVEghQI1V4KzJEVSRDr9lQRmKoLj/g1dUUwbbXB4O4EYMwRU4elzOW9DSiTHRwE
         12XQ==
X-Gm-Message-State: ACrzQf0wcKxA99Psp6Qp5CeAT4nqcpiWsTTFHXR4OUMXwerPFihVsxFh
        0hC1IWqUYSblxUt9sYEmquUr63gxtQU0kQ==
X-Google-Smtp-Source: AMsMyM6W8l1/D68cbEN7AH/zxubj1mhzo9lUFVqu/5WIYWNGXtcjYbVMYgQmarBjSwBZ92kWpOXzQw==
X-Received: by 2002:a17:90a:1c02:b0:1e0:df7:31f2 with SMTP id s2-20020a17090a1c0200b001e00df731f2mr47334791pjs.222.1666228266940;
        Wed, 19 Oct 2022 18:11:06 -0700 (PDT)
Received: from laptop.hsd1.wa.comcast.net ([2601:600:8500:5f14:d627:c51e:516e:a105])
        by smtp.gmail.com with ESMTPSA id b14-20020a170902650e00b00174fa8cbf31sm11242938plk.303.2022.10.19.18.11.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Oct 2022 18:11:06 -0700 (PDT)
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
Subject: [PATCH 5/5] selftest/seccomp: add a new test for the sync mode of seccomp_user_notify
Date:   Wed, 19 Oct 2022 18:10:48 -0700
Message-Id: <20221020011048.156415-6-avagin@gmail.com>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20221020011048.156415-1-avagin@gmail.com>
References: <20221020011048.156415-1-avagin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Test output:
RUN           global.user_notification_sync ...
seccomp_bpf.c:4279:user_notification_sync:basic: 8655 nsec/syscall
seccomp_bpf.c:4279:user_notification_sync:sync:	 2919 nsec/syscall
OK  global.user_notification_sync

Signed-off-by: Andrei Vagin <avagin@gmail.com>
---
 tools/testing/selftests/seccomp/seccomp_bpf.c | 80 +++++++++++++++++++
 1 file changed, 80 insertions(+)

diff --git a/tools/testing/selftests/seccomp/seccomp_bpf.c b/tools/testing/selftests/seccomp/seccomp_bpf.c
index 4ae6c8991307..01f872415c17 100644
--- a/tools/testing/selftests/seccomp/seccomp_bpf.c
+++ b/tools/testing/selftests/seccomp/seccomp_bpf.c
@@ -4241,6 +4241,86 @@ TEST(user_notification_addfd_rlimit)
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
+static void user_notification_sync_loop(struct __test_metadata *_metadata,
+					char *test_name, int listener)
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
+		EXPECT_EQ(ioctl(listener, SECCOMP_IOCTL_NOTIF_RECV, &req), 0);
+
+		EXPECT_EQ(req.data.nr,  __NR_getppid);
+
+		resp.id = req.id;
+		resp.error = 0;
+		resp.val = USER_NOTIF_MAGIC;
+		resp.flags = 0;
+		EXPECT_EQ(ioctl(listener, SECCOMP_IOCTL_NOTIF_SEND, &resp), 0);
+
+		clock_gettime(CLOCK_MONOTONIC, &ts);
+		end = ts.tv_nsec + ts.tv_sec * NSECS_PER_SEC;
+	}
+	TH_LOG("%s:\t%lld nsec/syscall", test_name, USER_NOTIF_BENCH_TIMEOUT / nr);
+}
+
+TEST(user_notification_sync)
+{
+	pid_t pid;
+	long ret;
+	int status, listener;
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
+	user_notification_sync_loop(_metadata, "basic", listener);
+
+	EXPECT_EQ(ioctl(listener, SECCOMP_IOCTL_NOTIF_SET_FLAGS,
+			SECCOMP_USER_NOTIF_FD_SYNC_WAKE_UP, 0), 0);
+
+	user_notification_sync_loop(_metadata, "sync", listener);
+
+	kill(pid, SIGKILL);
+	EXPECT_EQ(waitpid(pid, &status, 0), pid);
+	EXPECT_EQ(true, WIFSIGNALED(status));
+	EXPECT_EQ(SIGKILL, WTERMSIG(status));
+}
+
+
 /* Make sure PTRACE_O_SUSPEND_SECCOMP requires CAP_SYS_ADMIN. */
 FIXTURE(O_SUSPEND_SECCOMP) {
 	pid_t pid;
-- 
2.37.2

