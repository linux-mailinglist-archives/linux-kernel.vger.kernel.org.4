Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 99D5D60569C
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Oct 2022 07:05:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229738AbiJTFFO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Oct 2022 01:05:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229649AbiJTFFK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Oct 2022 01:05:10 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3CA1A6C3A
        for <linux-kernel@vger.kernel.org>; Wed, 19 Oct 2022 22:04:51 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id BC524CE24F8
        for <linux-kernel@vger.kernel.org>; Thu, 20 Oct 2022 05:04:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 97E4FC433C1;
        Thu, 20 Oct 2022 05:04:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666242287;
        bh=S4bgYk27v6fr5ccei0OpH1tdK6q8fftrSVTC5nw3ZQY=;
        h=Date:From:To:CC:Subject:In-Reply-To:References:From;
        b=f0AkW092X8nrvk8jWLncPghZF6G2blYVjNAnELz+f1+KA5R+Ay0GcMGUSQSCKRRfN
         x33Y7MkY6G/up59ywRa43NKcCWaZUPtMdZmbltwk1dqMr6ZnPkWV1qtUp30+1SEAwl
         x6EfpCR4/2npffSNRHS/PNP8W2HnoLGc2/RdlOEJDDZ71bsFmVqEomSWwYOlDpRbxx
         fePq5Ws7usSQhvISwwDJOj7DMHyyC7K1A7timdYTbLi7LFn2yIhmDH/3UWUPWPkSHT
         miNbxeGwIlxXremmtvsHsNuco8LFZWAwYqT/pBuJIxavV8l/l79TSDLfsQjOZcWDj1
         zUlSNCJzQytsQ==
Date:   Wed, 19 Oct 2022 22:04:44 -0700
From:   Kees Cook <kees@kernel.org>
To:     Andrei Vagin <avagin@gmail.com>, linux-kernel@vger.kernel.org
CC:     Andy Lutomirski <luto@amacapital.net>,
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
Subject: =?US-ASCII?Q?Re=3A_=5BPATCH_5/5=5D_selftest/seccomp=3A_add_a_new_?= =?US-ASCII?Q?test_for_the_sync_mode_of_seccomp=5Fuser=5Fnotify?=
User-Agent: K-9 Mail for Android
In-Reply-To: <20221020011048.156415-6-avagin@gmail.com>
References: <20221020011048.156415-1-avagin@gmail.com> <20221020011048.156415-6-avagin@gmail.com>
Message-ID: <B33DF09C-9121-4342-926E-B7B1988036B9@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-7.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On October 19, 2022 6:10:48 PM PDT, Andrei Vagin <avagin@gmail=2Ecom> wrote=
:
>Test output:
>RUN           global=2Euser_notification_sync =2E=2E=2E
>seccomp_bpf=2Ec:4279:user_notification_sync:basic: 8655 nsec/syscall
>seccomp_bpf=2Ec:4279:user_notification_sync:sync:	 2919 nsec/syscall
>OK  global=2Euser_notification_sync

This looks like a benchmark, not a functionality test=2E But maybe the tes=
t is "is sync faster than async?"

>
>Signed-off-by: Andrei Vagin <avagin@gmail=2Ecom>
>---
> tools/testing/selftests/seccomp/seccomp_bpf=2Ec | 80 +++++++++++++++++++
> 1 file changed, 80 insertions(+)
>
>diff --git a/tools/testing/selftests/seccomp/seccomp_bpf=2Ec b/tools/test=
ing/selftests/seccomp/seccomp_bpf=2Ec
>index 4ae6c8991307=2E=2E01f872415c17 100644
>--- a/tools/testing/selftests/seccomp/seccomp_bpf=2Ec
>+++ b/tools/testing/selftests/seccomp/seccomp_bpf=2Ec
>@@ -4241,6 +4241,86 @@ TEST(user_notification_addfd_rlimit)
> 	close(memfd);
> }
>=20
>+/* USER_NOTIF_BENCH_TIMEOUT is 100 miliseconds=2E */
>+#define USER_NOTIF_BENCH_TIMEOUT  100000000ULL
>+#define NSECS_PER_SEC            1000000000ULL
>+
>+#ifndef SECCOMP_USER_NOTIF_FD_SYNC_WAKE_UP
>+#define SECCOMP_USER_NOTIF_FD_SYNC_WAKE_UP (1UL << 0)
>+#define SECCOMP_IOCTL_NOTIF_SET_FLAGS  SECCOMP_IOW(4, __u64)
>+#endif
>+
>+static void user_notification_sync_loop(struct __test_metadata *_metadat=
a,
>+					char *test_name, int listener)
>+{
>+	struct timespec ts;
>+	uint64_t start, end, nr;
>+	struct seccomp_notif req =3D {};
>+	struct seccomp_notif_resp resp =3D {};
>+
>+	clock_gettime(CLOCK_MONOTONIC, &ts);
>+	start =3D ts=2Etv_nsec + ts=2Etv_sec * NSECS_PER_SEC;
>+	for (end =3D start, nr =3D 0; end - start < USER_NOTIF_BENCH_TIMEOUT; n=
r++) {
>+		memset(&req, 0, sizeof(req));
>+		req=2Epid =3D 0;
>+		EXPECT_EQ(ioctl(listener, SECCOMP_IOCTL_NOTIF_RECV, &req), 0);
>+
>+		EXPECT_EQ(req=2Edata=2Enr,  __NR_getppid);
>+
>+		resp=2Eid =3D req=2Eid;
>+		resp=2Eerror =3D 0;
>+		resp=2Eval =3D USER_NOTIF_MAGIC;
>+		resp=2Eflags =3D 0;
>+		EXPECT_EQ(ioctl(listener, SECCOMP_IOCTL_NOTIF_SEND, &resp), 0);

I think these EXPECTs should be ASSERTs=2E=2E=2E

>+
>+		clock_gettime(CLOCK_MONOTONIC, &ts);
>+		end =3D ts=2Etv_nsec + ts=2Etv_sec * NSECS_PER_SEC;
>+	}
>+	TH_LOG("%s:\t%lld nsec/syscall", test_name, USER_NOTIF_BENCH_TIMEOUT / =
nr);
>+}
>+
>+TEST(user_notification_sync)
>+{
>+	pid_t pid;
>+	long ret;
>+	int status, listener;
>+
>+	ret =3D prctl(PR_SET_NO_NEW_PRIVS, 1, 0, 0, 0);
>+	ASSERT_EQ(0, ret) {
>+		TH_LOG("Kernel does not support PR_SET_NO_NEW_PRIVS!");
>+	}
>+
>+	listener =3D user_notif_syscall(__NR_getppid,
>+				      SECCOMP_FILTER_FLAG_NEW_LISTENER);
>+	ASSERT_GE(listener, 0);
>+
>+	pid =3D fork();
>+	ASSERT_GE(pid, 0);
>+
>+	if (pid =3D=3D 0) {
>+		while (1) {
>+			ret =3D syscall(__NR_getppid);
>+			if (ret =3D=3D USER_NOTIF_MAGIC)
>+				continue;
>+			break;
>+		}
>+		_exit(1);
>+	}
>+
>+	user_notification_sync_loop(_metadata, "basic", listener);
>+
>+	EXPECT_EQ(ioctl(listener, SECCOMP_IOCTL_NOTIF_SET_FLAGS,
>+			SECCOMP_USER_NOTIF_FD_SYNC_WAKE_UP, 0), 0);

Same here=2E

Also can you test that invalid SET_FLAGS are correctly rejected here?

>+
>+	user_notification_sync_loop(_metadata, "sync", listener);
>+

If the timings are collected, add a test that sync is <=3D async here?

>+	kill(pid, SIGKILL);
>+	EXPECT_EQ(waitpid(pid, &status, 0), pid);
>+	EXPECT_EQ(true, WIFSIGNALED(status));
>+	EXPECT_EQ(SIGKILL, WTERMSIG(status));
>+}
>+
>+
> /* Make sure PTRACE_O_SUSPEND_SECCOMP requires CAP_SYS_ADMIN=2E */
> FIXTURE(O_SUSPEND_SECCOMP) {
> 	pid_t pid;

Otherwise, yeah, looks good=2E


--=20
Kees Cook
