Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1719F68739F
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Feb 2023 04:05:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231707AbjBBDFM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Feb 2023 22:05:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231733AbjBBDEs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Feb 2023 22:04:48 -0500
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7879C38659
        for <linux-kernel@vger.kernel.org>; Wed,  1 Feb 2023 19:04:46 -0800 (PST)
Received: by mail-yb1-xb49.google.com with SMTP id a4-20020a5b0004000000b006fdc6aaec4fso472130ybp.20
        for <linux-kernel@vger.kernel.org>; Wed, 01 Feb 2023 19:04:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=eiBfk+BfeZMyiGmDtQ57nkoCct1hYoOMf69qzZGcvyo=;
        b=iCBw856I6Vh3uVjkTHXCwcpAedCJ/h5ZCWWLNJT+8sqP5ggv3TqZKfn/l3Ws4tNtBl
         eeg8aEBPq8gnFwOLML6sLsoVxT5NCFSJaGQJywPx2+wZnF7eT+Dodghc/YuhOVY2FiHF
         sfGnZ7h0enxgTNWAozbRL/bTJum5r4dsXCP6my1494BMC1WwYMkNIH55BRjbKeYmJEbq
         C8tejG+ZsgAPV61sAUq5BGzh7iVkqZq/GuKjGvx7wzFTLQJhjlIUjCuOnRmIpCb1nl4b
         g/Mp5SqlAESICg+QpmsyyWyyGfUrAxWcQ3LCW5U0uFce39qp8bu9ioATngi1gkUyDmz+
         Rbeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=eiBfk+BfeZMyiGmDtQ57nkoCct1hYoOMf69qzZGcvyo=;
        b=Wp32NEQuYB9ATLguUJVeIIW0Getzh/UUxYlHWijQfYcuo9Wug4fCLtrxFXkbRA/ANT
         0AFOi7tfatwD5xZGnd+YoTFIUNJw51qtW1f69V77VKs2WRfmJgf6/txIE03MN6oXJuwo
         LD/5NlofV+eNZiBbTNTCpnK2Fd69AKZmohT5NK0WLM5OpwMoApWq0y5TboPWuoQhKweT
         tAUA0JGHX7KqT3BLG6igOU+Jw8hKZ56yDGmIOJJU7vBAbbR1JDYHukvofRlXs/NnIWf+
         7blh+sFysM4QC1UCzHrjti+Lko11mgYf7XlwUAqf8S76sD1dKEXk1vJGwQubGBg6Lzat
         TNeA==
X-Gm-Message-State: AO0yUKXkJshdBn3BoP+XP1+karQNWrp+OLyGQ+4b/leY6G5X8h2vTWYt
        GyIU85TCIZXS4d/uQHNDIpXEdcev/+Q=
X-Google-Smtp-Source: AK7set93Rg3m5yAKnnWb1/pTmzEBuFHY0Z3gSQAvcaiA6u64XI6NQTXZ4IQ/TXWc518UrLNXz152WzOdpb0=
X-Received: from avagin.kir.corp.google.com ([2620:0:1008:11:eee0:dc42:a911:8b59])
 (user=avagin job=sendgmr) by 2002:a0d:d497:0:b0:51d:3714:b2eb with SMTP id
 w145-20020a0dd497000000b0051d3714b2ebmr491482ywd.431.1675307086103; Wed, 01
 Feb 2023 19:04:46 -0800 (PST)
Date:   Wed,  1 Feb 2023 19:04:28 -0800
In-Reply-To: <20230202030429.3304875-1-avagin@google.com>
Mime-Version: 1.0
References: <20230202030429.3304875-1-avagin@google.com>
X-Mailer: git-send-email 2.39.1.456.gfc5497dd1b-goog
Message-ID: <20230202030429.3304875-6-avagin@google.com>
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
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
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
2.39.1.456.gfc5497dd1b-goog

