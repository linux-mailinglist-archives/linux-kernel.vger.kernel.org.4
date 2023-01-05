Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F17765ED83
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Jan 2023 14:44:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231917AbjAENom (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Jan 2023 08:44:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230261AbjAENok (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jan 2023 08:44:40 -0500
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9D2132E98
        for <linux-kernel@vger.kernel.org>; Thu,  5 Jan 2023 05:44:38 -0800 (PST)
Received: by mail-wm1-x32d.google.com with SMTP id k26-20020a05600c1c9a00b003d972646a7dso1331108wms.5
        for <linux-kernel@vger.kernel.org>; Thu, 05 Jan 2023 05:44:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=fiP50d/4wrLXIRRquNuNAlbq+XVfP1x5KxwsWe04iCI=;
        b=ayIh1ZezmhZyoOvJH4Y4i6j4YOiT/mzHfaQquyz6M0DNzoGTO/FkJqiy0/NabjhGAu
         ciRMpWroIqj8n3Ieeg0Y0PHDNxzwrVCiZ6Vt9gcB2VZr4UOqMPlRIGreOYxu1Bs/8cR+
         0R0O0ikmPBeNASwr0n09Wlx2ShMMkqbsBaaXzkitGNZG2hknu892hjMBfeOzx+kve/r1
         /5NDgl8AtNRjjhGemJ5sdusxm8Py7yTfnTWVNwPi6p5Elw5A1J/PbIQbxwvuYh/nKgue
         mb6kNeZ3HgZg4VHT7li4uSr9w3S/rUOKbZnUferzgd5ZnZ1lae2W74OeG1WRPT0Ifmej
         MJfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fiP50d/4wrLXIRRquNuNAlbq+XVfP1x5KxwsWe04iCI=;
        b=je7Af/1WYsQfx4n8hl2XvwSBRL7svPG7Tlt/FdA7giE8EkcpKGay6Ko1LkByY0njxn
         +XXisi1ugqGplYX1PE4C/aMBuVMCVKqcUEa6ESn6hbIYZtu4BqVO8dOF/BSViva8dDoH
         XZPooqdapTtTNNOstA6Ok2TMY6Lc3AdbxKeqcLxzE9qg2axwq3lOg4Pu82OsvD0RN6j2
         mboNjlUxOEsOuKz4qtidSEcYLKOinZFnL94GAKYBGLelqyglOCafsINjiehNj75AqOD0
         w3qx9YhtLCmnEdYqdgCe8R0105sCPzSuH/cA8T9k4vdwkcqhjB9scYVEL/aujb5uIAYl
         ojCg==
X-Gm-Message-State: AFqh2kphk0IspUKWggE6ltnlcj66pEXDjW6oxQ4jQ3LjCWMtmg60zX3U
        q3vNK/8uqjCFrScXzH3oMbpD4b2f7uplsADJIOw=
X-Google-Smtp-Source: AMrXdXtUqfb7QiUL+ZC8a+J4Q3lia3PQQSTmEVhBfgJ9MoiBUgkL63B6Pn8eP3xH41zSzc7wkhuG9w==
X-Received: by 2002:a05:600c:3ca0:b0:3cf:ceac:94bb with SMTP id bg32-20020a05600c3ca000b003cfceac94bbmr178270wmb.0.1672926277125;
        Thu, 05 Jan 2023 05:44:37 -0800 (PST)
Received: from localhost ([2a00:79e0:9d:4:d5b5:a846:e188:66d0])
        by smtp.gmail.com with ESMTPSA id n14-20020a05600c3b8e00b003b49bd61b19sm2736241wms.15.2023.01.05.05.44.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Jan 2023 05:44:36 -0800 (PST)
From:   Jann Horn <jannh@google.com>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     linux-kernel@vger.kernel.org, Oleg Nesterov <oleg@redhat.com>
Subject: [PATCH] time: Prevent union confusion from unexpected restart_syscall()
Date:   Thu,  5 Jan 2023 14:44:03 +0100
Message-Id: <20230105134403.754986-1-jannh@google.com>
X-Mailer: git-send-email 2.39.0.314.g84b9a713c41-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The nanosleep syscalls use the restart_block mechanism, with a quirk:
The `type` and `rmtp`/`compat_rmtp` fields are set up unconditionally on
syscall entry, while the rest of the restart_block is only set up in the
unlikely case that the syscall is actually interrupted by a signal (or
pseudo-signal) that doesn't have a signal handler.

If the restart_block was set up by a previous syscall
(futex(..., FUTEX_WAIT, ...) or poll()) and hasn't been invalidated
somehow since then, this will clobber some of the union fields used by
futex_wait_restart()/do_restart_poll().
If userspace afterwards wrongly calls the restart_syscall syscall,
futex_wait_restart()/do_restart_poll() will read struct fields that have
been clobbered.

This doesn't actually lead to anything particularly interesting because
none of the union fields contain trusted kernel data, and
futex(..., FUTEX_WAIT, ...) and poll() aren't syscalls where it makes much
sense to apply seccomp filters to their arguments.
So the current consequences are just of the "if userspace does bad stuff,
it can damage itself, and that's not a problem" flavor.

But still, it seems like a hazard for future developers, so invalidate the
restart_block when partly setting it up in the nanosleep syscalls.

Signed-off-by: Jann Horn <jannh@google.com>
---
reproducer, demonstrates nanosleep() clobbering the upper half of
current->restart_block.poll.ufds (with TT_NATIVE==1) and
current->restart_block.poll.nfds (with 42):

user@vm:~/restart_syscall$ cat restart_syscall_union_confusion.c 
#define _GNU_SOURCE
#include <err.h>
#include <errno.h>
#include <stdlib.h>
#include <time.h>
#include <unistd.h>
#include <stdio.h>
#include <poll.h>
#include <fcntl.h>
#include <signal.h>
#include <sys/mman.h>
#include <sys/select.h>
#include <sys/wait.h>
#include <sys/syscall.h>

#define SYSCHK(x) ({          \
  typeof(x) __res = (x);      \
  if (__res == (typeof(x))-1) \
    err(1, "SYSCHK(" #x ")"); \
  __res;                      \
})

int main(void) {
  int child = SYSCHK(fork());
  if (child == 0) {
    struct pollfd *pollfds = SYSCHK(mmap((void*)0x100000000, 0x1000,
            PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS|MAP_FIXED_NOREPLACE,
            -1, 0));
    int dev_null_fd = SYSCHK(open("/dev/null", O_WRONLY));
    for (int i=0; i<100; i++)
      pollfds[i] = (struct pollfd) { .fd = dev_null_fd, .events = POLLOUT };

    errno = 0;
    int res = poll(NULL, 0, 2000);
    printf("poll = %d (%m)\n", res);

    // this writes current->restart_block.nanosleep.{type,rmtp}
    struct timespec ts_sleep = { .tv_nsec = 1000 };
    SYSCHK(nanosleep(&ts_sleep, (void*)42UL));

    errno = 0;
    int ret = syscall(__NR_restart_syscall);
    if (ret == -1 && errno == EINTR) {
      printf("restart_syscall() returned EINTR, probably do_no_restart_syscall\n");
    } else {
      printf("restart_syscall() = %d (%m)\n", ret);
    }
    for (int i=0; i<50; i++)
      printf("pollfds[%d].revents = 0x%x\n", i, pollfds[i].revents);

    exit(0);
  } else {
    // parent
    sleep(1);
    printf("sending SIGSTOP\n");
    kill(child, SIGSTOP);
    sleep(1);
    printf("sending SIGCONT\n");
    kill(child, SIGCONT);

    printf("waiting for child...\n");
    int status;
    SYSCHK(waitpid(child, &status, 0));
  }
}
user@vm:~/restart_syscall$ gcc -o restart_syscall_union_confusion restart_syscall_union_confusion.c 
user@vm:~/restart_syscall$ ./restart_syscall_union_confusion 
sending SIGSTOP
sending SIGCONT
waiting for child...
poll = 0 (Success)
restart_syscall() = 42 (Success)
pollfds[0].revents = 0x4
pollfds[1].revents = 0x4
pollfds[2].revents = 0x4
pollfds[3].revents = 0x4
pollfds[4].revents = 0x4
pollfds[5].revents = 0x4
pollfds[6].revents = 0x4
pollfds[7].revents = 0x4
pollfds[8].revents = 0x4
pollfds[9].revents = 0x4
pollfds[10].revents = 0x4
pollfds[11].revents = 0x4
pollfds[12].revents = 0x4
pollfds[13].revents = 0x4
pollfds[14].revents = 0x4
pollfds[15].revents = 0x4
pollfds[16].revents = 0x4
pollfds[17].revents = 0x4
pollfds[18].revents = 0x4
pollfds[19].revents = 0x4
pollfds[20].revents = 0x4
pollfds[21].revents = 0x4
pollfds[22].revents = 0x4
pollfds[23].revents = 0x4
pollfds[24].revents = 0x4
pollfds[25].revents = 0x4
pollfds[26].revents = 0x4
pollfds[27].revents = 0x4
pollfds[28].revents = 0x4
pollfds[29].revents = 0x4
pollfds[30].revents = 0x4
pollfds[31].revents = 0x4
pollfds[32].revents = 0x4
pollfds[33].revents = 0x4
pollfds[34].revents = 0x4
pollfds[35].revents = 0x4
pollfds[36].revents = 0x4
pollfds[37].revents = 0x4
pollfds[38].revents = 0x4
pollfds[39].revents = 0x4
pollfds[40].revents = 0x4
pollfds[41].revents = 0x4
pollfds[42].revents = 0x0
pollfds[43].revents = 0x0
pollfds[44].revents = 0x0
pollfds[45].revents = 0x0
pollfds[46].revents = 0x0
pollfds[47].revents = 0x0
pollfds[48].revents = 0x0
pollfds[49].revents = 0x0


 kernel/time/hrtimer.c      | 2 ++
 kernel/time/posix-stubs.c  | 2 ++
 kernel/time/posix-timers.c | 2 ++
 3 files changed, 6 insertions(+)

diff --git a/kernel/time/hrtimer.c b/kernel/time/hrtimer.c
index 3ae661ab6260..e4f0e3b0c4f4 100644
--- a/kernel/time/hrtimer.c
+++ b/kernel/time/hrtimer.c
@@ -2126,6 +2126,7 @@ SYSCALL_DEFINE2(nanosleep, struct __kernel_timespec __user *, rqtp,
 	if (!timespec64_valid(&tu))
 		return -EINVAL;
 
+	current->restart_block.fn = do_no_restart_syscall;
 	current->restart_block.nanosleep.type = rmtp ? TT_NATIVE : TT_NONE;
 	current->restart_block.nanosleep.rmtp = rmtp;
 	return hrtimer_nanosleep(timespec64_to_ktime(tu), HRTIMER_MODE_REL,
@@ -2147,6 +2148,7 @@ SYSCALL_DEFINE2(nanosleep_time32, struct old_timespec32 __user *, rqtp,
 	if (!timespec64_valid(&tu))
 		return -EINVAL;
 
+	current->restart_block.fn = do_no_restart_syscall;
 	current->restart_block.nanosleep.type = rmtp ? TT_COMPAT : TT_NONE;
 	current->restart_block.nanosleep.compat_rmtp = rmtp;
 	return hrtimer_nanosleep(timespec64_to_ktime(tu), HRTIMER_MODE_REL,
diff --git a/kernel/time/posix-stubs.c b/kernel/time/posix-stubs.c
index 90ea5f373e50..828aeecbd1e8 100644
--- a/kernel/time/posix-stubs.c
+++ b/kernel/time/posix-stubs.c
@@ -147,6 +147,7 @@ SYSCALL_DEFINE4(clock_nanosleep, const clockid_t, which_clock, int, flags,
 		return -EINVAL;
 	if (flags & TIMER_ABSTIME)
 		rmtp = NULL;
+	current->restart_block.fn = do_no_restart_syscall;
 	current->restart_block.nanosleep.type = rmtp ? TT_NATIVE : TT_NONE;
 	current->restart_block.nanosleep.rmtp = rmtp;
 	texp = timespec64_to_ktime(t);
@@ -240,6 +241,7 @@ SYSCALL_DEFINE4(clock_nanosleep_time32, clockid_t, which_clock, int, flags,
 		return -EINVAL;
 	if (flags & TIMER_ABSTIME)
 		rmtp = NULL;
+	current->restart_block.fn = do_no_restart_syscall;
 	current->restart_block.nanosleep.type = rmtp ? TT_COMPAT : TT_NONE;
 	current->restart_block.nanosleep.compat_rmtp = rmtp;
 	texp = timespec64_to_ktime(t);
diff --git a/kernel/time/posix-timers.c b/kernel/time/posix-timers.c
index 5dead89308b7..0c8a87a11b39 100644
--- a/kernel/time/posix-timers.c
+++ b/kernel/time/posix-timers.c
@@ -1270,6 +1270,7 @@ SYSCALL_DEFINE4(clock_nanosleep, const clockid_t, which_clock, int, flags,
 		return -EINVAL;
 	if (flags & TIMER_ABSTIME)
 		rmtp = NULL;
+	current->restart_block.fn = do_no_restart_syscall;
 	current->restart_block.nanosleep.type = rmtp ? TT_NATIVE : TT_NONE;
 	current->restart_block.nanosleep.rmtp = rmtp;
 
@@ -1297,6 +1298,7 @@ SYSCALL_DEFINE4(clock_nanosleep_time32, clockid_t, which_clock, int, flags,
 		return -EINVAL;
 	if (flags & TIMER_ABSTIME)
 		rmtp = NULL;
+	current->restart_block.fn = do_no_restart_syscall;
 	current->restart_block.nanosleep.type = rmtp ? TT_COMPAT : TT_NONE;
 	current->restart_block.nanosleep.compat_rmtp = rmtp;
 

base-commit: 41c03ba9beea760bd2d2ac9250b09a2e192da2dc
-- 
2.39.0.314.g84b9a713c41-goog

