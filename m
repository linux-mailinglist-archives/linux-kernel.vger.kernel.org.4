Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 33B926D8940
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Apr 2023 23:07:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233991AbjDEVHu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Apr 2023 17:07:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231429AbjDEVHp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Apr 2023 17:07:45 -0400
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F4E240D3
        for <linux-kernel@vger.kernel.org>; Wed,  5 Apr 2023 14:07:34 -0700 (PDT)
Received: by mail-wr1-x42f.google.com with SMTP id d17so37477546wrb.11
        for <linux-kernel@vger.kernel.org>; Wed, 05 Apr 2023 14:07:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1680728852;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZgdWiHR+IYLQHfWPOEf2PZY4P0OirI09EEfz2Wyd5Sc=;
        b=gDTrM6r2vBZJzbfQTIl8IYEV0+r2qD/0jX6GJ0kdik7zn1V0V09fNEnxsCks2lbqp7
         dz9UhDmWbwkLCrJkux5HDgW3mEZt9rwFYltvP7wVcQqwcA9bCbgTq1kTapV1bTSNe41K
         uZ1JzWRXG2CsC3TsF1ZrY4jCJO0kCxcEb7UwstE/JjP8zQ8FOvYmAXpb79fI3bjEKHmK
         ueg79R8HiUp/u48hhdA7qXnPmSe2bjSW10Y+yJ5KNlWR/8zBXSDWET/4CWoZgon+jawb
         1Z9cHCFFXZME6WDPgEfHrKXVxMj5e18CIHUaJK7no0M2H+er23NZWi9DJjGSzMxTAsbc
         yzjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680728852;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZgdWiHR+IYLQHfWPOEf2PZY4P0OirI09EEfz2Wyd5Sc=;
        b=lSbaUMdZc+X2Mv5bEgdiJcWPdHAIqgbg5HUN9b3YKV9JvgjLZuLcgQFIOwl96NFMqV
         Ng4+iPZ4KBcrkYNrsfg0FSdEAX2Ag8I0yyLP9PvS4t56RXexP2wYOR4P9f03gj4PvJS9
         bLOOgtJzy9SdAgXnQ6ZuPVMdHqLjKANIn56rD5wnjmiT9tmd+63oy0NkdQ8mX+xUS71w
         39qWROUjrBZGrNbTUG+gUGckj47IUFvuv8ODfBRkFHW40GamzxA+f18TLJxap4SYIfsb
         u4/gFhkHTPGbYSA1NgtqMTe1saoLMXN2bko8UyHGyGA7giT9m6z5gPs+rXOQESLpAn+d
         ZKeA==
X-Gm-Message-State: AAQBX9dfyVJjq/TAyhbWUfvk90J49ZcRfMze/hqaQpTzGWgWmU0sIhlZ
        A3mevcnXW1hgs55Yr7pltyTY4c9V0HPapqHn/fAw0Q==
X-Google-Smtp-Source: AKy350ZINLpcgcNf0K14QnTJzP6bSy1KYCk9pQUHGfBXpil2xXVlz+0lc+cNFKSQ3YnQZdTGVhs1hA==
X-Received: by 2002:a5d:688d:0:b0:2de:bb7c:bae7 with SMTP id h13-20020a5d688d000000b002debb7cbae7mr4542690wru.14.1680728852292;
        Wed, 05 Apr 2023 14:07:32 -0700 (PDT)
Received: from elver.google.com ([2a00:79e0:9c:201:b875:bb0:f141:cefd])
        by smtp.gmail.com with ESMTPSA id r8-20020adfdc88000000b002de99432fc8sm15945844wrj.49.2023.04.05.14.07.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Apr 2023 14:07:31 -0700 (PDT)
Date:   Wed, 5 Apr 2023 23:07:24 +0200
From:   Marco Elver <elver@google.com>
To:     syzbot <syzbot+3b14b2ed9b3d06dcaa07@syzkaller.appspotmail.com>
Cc:     linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com,
        Thomas Gleixner <tglx@linutronix.de>,
        Anna-Maria Behnsen <anna-maria@linutronix.de>,
        Jacob Keller <jacob.e.keller@intel.com>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>
Subject: Re: WARNING in timer_wait_running
Message-ID: <ZC3jDC6R/SGLk5vj@elver.google.com>
References: <000000000000566d5405ae2f6f70@google.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="Z5mOnECGihyyY82T"
Content-Disposition: inline
In-Reply-To: <000000000000566d5405ae2f6f70@google.com>
User-Agent: Mutt/2.2.9 (2022-11-12)
X-Spam-Status: No, score=-15.7 required=5.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,ENV_AND_HDR_SPF_MATCH,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL,
        USER_IN_DEF_SPF_WL autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--Z5mOnECGihyyY82T
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

[-Bcc wrongly added folks]
[+Cc kernel/time maintainers]

On Mon, Aug 31, 2020 at 10:07AM -0700, syzbot wrote:
> Hello,
> 
> syzbot found the following issue on:
> 
> HEAD commit:    1127b219 Merge tag 'fallthrough-fixes-5.9-rc3' of git://gi..
> git tree:       upstream
> console output: https://syzkaller.appspot.com/x/log.txt?x=1501768e900000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=978db74cb30aa994
> dashboard link: https://syzkaller.appspot.com/bug?extid=3b14b2ed9b3d06dcaa07

Dashboard has recent reports (also below) and reproducer (also attached).

> compiler:       gcc (GCC) 10.1.0-syz 20200507
> userspace arch: i386

Not just i386.

> The issue was bisected to:
> 
> commit b1012ca8dc4f9b1a1fe8e2cb1590dd6d43ea3849
> Author: Lu Baolu <baolu.lu@linux.intel.com>
> Date:   Thu Jul 23 01:34:37 2020 +0000
> 
>     iommu/vt-d: Skip TE disabling on quirky gfx dedicated iommu

This bisection is wrong.

> IMPORTANT: if you fix the issue, please add the following tag to the commit:
> Reported-by: syzbot+3b14b2ed9b3d06dcaa07@syzkaller.appspotmail.com

[...]
> WARNING: CPU: 0 PID: 10581 at kernel/time/posix-timers.c:849 timer_wait_running+0x218/0x250 kernel/time/posix-timers.c:849
[ .. snip ancient warning ..]

Up-to-date warning:

 | WARNING: CPU: 1 PID: 6695 at kernel/time/posix-timers.c:849 timer_wait_running+0x255/0x290 kernel/time/posix-timers.c:849
 | Modules linked in:
 | CPU: 1 PID: 6695 Comm: syz-executor.3 Not tainted 6.3.0-rc3-syzkaller-00338-gda8e7da11e4b #0
 | Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 03/02/2023
 | RIP: 0010:timer_wait_running+0x255/0x290 kernel/time/posix-timers.c:849
 | Code: 00 48 c7 c2 80 fe 4e 8a be 06 03 00 00 48 c7 c7 e0 fe 4e 8a c6 05 63 cb ed 0c 01 e8 85 77 ef ff e9 5b fe ff ff e8 2b 7d 0e 00 <0f> 0b e9 b2 fe ff ff e8 0f 8a 5f 00 e9 fe fd ff ff e8 25 8a 5f 00
 | RSP: 0018:ffffc90003ecfd50 EFLAGS: 00010293
 | RAX: 0000000000000000 RBX: 0000000000000000 RCX: 0000000000000000
 | RDX: ffff888020e4ba80 RSI: ffffffff81746785 RDI: ffffffff8a4f0ad8
 | RBP: ffff88807c696d38 R08: 0000000000000001 R09: 0000000000000001
 | R10: fffffbfff1cef98a R11: 0000000000000021 R12: ffffc90003ecfdb0
 | R13: 0000000000000000 R14: ffffffff8a4f0a60 R15: ffffc90003ecfdb0
 | FS:  00007fae387fe700(0000) GS:ffff8880b9900000(0000) knlGS:0000000000000000
 | CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
 | CR2: 00007f0d105821b8 CR3: 000000002a283000 CR4: 00000000003526e0
 | DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
 | DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
 | Call Trace:
 |  <TASK>
 |  do_timer_settime.part.0+0x119/0x1d0 kernel/time/posix-timers.c:929
 |  do_timer_settime kernel/time/posix-timers.c:938 [inline]
 |  __do_sys_timer_settime kernel/time/posix-timers.c:952 [inline]
 |  __se_sys_timer_settime kernel/time/posix-timers.c:938 [inline]
 |  __x64_sys_timer_settime+0x21d/0x310 kernel/time/posix-timers.c:938
 |  do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 |  do_syscall_64+0x39/0xb0 arch/x86/entry/common.c:80
 |  entry_SYSCALL_64_after_hwframe+0x63/0xcd
 | RIP: 0033:0x7fae3948c0f9
 | Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 f1 19 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
 | RSP: 002b:00007fae387fe168 EFLAGS: 00000246 ORIG_RAX: 00000000000000df
 | RAX: ffffffffffffffda RBX: 00007fae395ac050 RCX: 00007fae3948c0f9
 | RDX: 0000000020000080 RSI: 0000000000000000 RDI: 0000000000000000
 | RBP: 00007fae394e7b39 R08: 0000000000000000 R09: 0000000000000000
 | R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
 | R13: 00007fae396cfb1f R14: 00007fae387fe300 R15: 0000000000022000
 |  </TASK>

I've seen this warning in the wild recently, and it's been around since
2020 according to syzbot.

The warning was added in ec8f954a40da8 ("posix-timers: Use a callback
for cancel synchronization on PREEMPT_RT").

Why is it wrong for timer_wait_running to be NULL?

[ attached C reproducer ]

Thanks,
-- Marco

--Z5mOnECGihyyY82T
Content-Type: text/x-csrc; charset=us-ascii
Content-Disposition: attachment; filename="timer-warn.c"

// https://syzkaller.appspot.com/bug?id=e2edd7e2c1186400e65f86f07324a8e062308159
// autogenerated by syzkaller (https://github.com/google/syzkaller)

#define _GNU_SOURCE

#include <dirent.h>
#include <endian.h>
#include <errno.h>
#include <fcntl.h>
#include <linux/futex.h>
#include <pthread.h>
#include <signal.h>
#include <stdarg.h>
#include <stdbool.h>
#include <stdint.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <sys/prctl.h>
#include <sys/stat.h>
#include <sys/syscall.h>
#include <sys/types.h>
#include <sys/wait.h>
#include <time.h>
#include <unistd.h>

static void sleep_ms(uint64_t ms) { usleep(ms * 1000); }

static uint64_t current_time_ms(void) {
  struct timespec ts;
  if (clock_gettime(CLOCK_MONOTONIC, &ts)) exit(1);
  return (uint64_t)ts.tv_sec * 1000 + (uint64_t)ts.tv_nsec / 1000000;
}

static void thread_start(void* (*fn)(void*), void* arg) {
  pthread_t th;
  pthread_attr_t attr;
  pthread_attr_init(&attr);
  pthread_attr_setstacksize(&attr, 128 << 10);
  int i = 0;
  for (; i < 100; i++) {
    if (pthread_create(&th, &attr, fn, arg) == 0) {
      pthread_attr_destroy(&attr);
      return;
    }
    if (errno == EAGAIN) {
      usleep(50);
      continue;
    }
    break;
  }
  exit(1);
}

typedef struct {
  int state;
} event_t;

static void event_init(event_t* ev) { ev->state = 0; }

static void event_reset(event_t* ev) { ev->state = 0; }

static void event_set(event_t* ev) {
  if (ev->state) exit(1);
  __atomic_store_n(&ev->state, 1, __ATOMIC_RELEASE);
  syscall(SYS_futex, &ev->state, FUTEX_WAKE | FUTEX_PRIVATE_FLAG, 1000000);
}

static void event_wait(event_t* ev) {
  while (!__atomic_load_n(&ev->state, __ATOMIC_ACQUIRE))
    syscall(SYS_futex, &ev->state, FUTEX_WAIT | FUTEX_PRIVATE_FLAG, 0, 0);
}

static int event_isset(event_t* ev) {
  return __atomic_load_n(&ev->state, __ATOMIC_ACQUIRE);
}

static int event_timedwait(event_t* ev, uint64_t timeout) {
  uint64_t start = current_time_ms();
  uint64_t now = start;
  for (;;) {
    uint64_t remain = timeout - (now - start);
    struct timespec ts;
    ts.tv_sec = remain / 1000;
    ts.tv_nsec = (remain % 1000) * 1000 * 1000;
    syscall(SYS_futex, &ev->state, FUTEX_WAIT | FUTEX_PRIVATE_FLAG, 0, &ts);
    if (__atomic_load_n(&ev->state, __ATOMIC_ACQUIRE)) return 1;
    now = current_time_ms();
    if (now - start > timeout) return 0;
  }
}

static bool write_file(const char* file, const char* what, ...) {
  char buf[1024];
  va_list args;
  va_start(args, what);
  vsnprintf(buf, sizeof(buf), what, args);
  va_end(args);
  buf[sizeof(buf) - 1] = 0;
  int len = strlen(buf);
  int fd = open(file, O_WRONLY | O_CLOEXEC);
  if (fd == -1) return false;
  if (write(fd, buf, len) != len) {
    int err = errno;
    close(fd);
    errno = err;
    return false;
  }
  close(fd);
  return true;
}

static void kill_and_wait(int pid, int* status) {
  kill(-pid, SIGKILL);
  kill(pid, SIGKILL);
  for (int i = 0; i < 100; i++) {
    if (waitpid(-1, status, WNOHANG | __WALL) == pid) return;
    usleep(1000);
  }
  DIR* dir = opendir("/sys/fs/fuse/connections");
  if (dir) {
    for (;;) {
      struct dirent* ent = readdir(dir);
      if (!ent) break;
      if (strcmp(ent->d_name, ".") == 0 || strcmp(ent->d_name, "..") == 0)
        continue;
      char abort[300];
      snprintf(abort, sizeof(abort), "/sys/fs/fuse/connections/%s/abort",
               ent->d_name);
      int fd = open(abort, O_WRONLY);
      if (fd == -1) {
        continue;
      }
      if (write(fd, abort, 1) < 0) {
      }
      close(fd);
    }
    closedir(dir);
  } else {
  }
  while (waitpid(-1, status, __WALL) != pid) {
  }
}

static void setup_test() {
  prctl(PR_SET_PDEATHSIG, SIGKILL, 0, 0, 0);
  setpgrp();
  write_file("/proc/self/oom_score_adj", "1000");
}

struct thread_t {
  int created, call;
  event_t ready, done;
};

static struct thread_t threads[16];
static void execute_call(int call);
static int running;

static void* thr(void* arg) {
  struct thread_t* th = (struct thread_t*)arg;
  for (;;) {
    event_wait(&th->ready);
    event_reset(&th->ready);
    execute_call(th->call);
    __atomic_fetch_sub(&running, 1, __ATOMIC_RELAXED);
    event_set(&th->done);
  }
  return 0;
}

static void execute_one(void) {
  int i, call, thread;
  for (call = 0; call < 4; call++) {
    for (thread = 0; thread < (int)(sizeof(threads) / sizeof(threads[0]));
         thread++) {
      struct thread_t* th = &threads[thread];
      if (!th->created) {
        th->created = 1;
        event_init(&th->ready);
        event_init(&th->done);
        event_set(&th->done);
        thread_start(thr, th);
      }
      if (!event_isset(&th->done)) continue;
      event_reset(&th->done);
      th->call = call;
      __atomic_fetch_add(&running, 1, __ATOMIC_RELAXED);
      event_set(&th->ready);
      event_timedwait(&th->done, 50);
      break;
    }
  }
  for (i = 0; i < 100 && __atomic_load_n(&running, __ATOMIC_RELAXED); i++)
    sleep_ms(1);
}

static void execute_one(void);

#define WAIT_FLAGS __WALL

static void loop(void) {
  int iter = 0;
  for (;; iter++) {
    int pid = fork();
    if (pid < 0) exit(1);
    if (pid == 0) {
      setup_test();
      execute_one();
      exit(0);
    }
    int status = 0;
    uint64_t start = current_time_ms();
    for (;;) {
      if (waitpid(-1, &status, WNOHANG | WAIT_FLAGS) == pid) break;
      sleep_ms(1);
      if (current_time_ms() - start < 5000) continue;
      kill_and_wait(pid, &status);
      break;
    }
  }
}

uint64_t r[1] = {0x0};

void execute_call(int call) {
  intptr_t res = 0;
  switch (call) {
    case 0:
      res = syscall(__NR_timer_create, 2ul, 0ul, 0x20002180ul);
      if (res != -1) r[0] = *(uint32_t*)0x20002180;
      break;
    case 1:
      *(uint64_t*)0x2006b000 = 0;
      *(uint64_t*)0x2006b008 = 8;
      *(uint64_t*)0x2006b010 = 0;
      *(uint64_t*)0x2006b018 = 9;
      syscall(__NR_timer_settime, 0, 0ul, 0x2006b000ul, 0ul);
      break;
    case 2:
      syscall(__NR_mmap, 0x20000000ul, 0xb36000ul, 0xb635773f05ebbeeful,
              0x8031ul, -1, 0ul);
      break;
    case 3:
      *(uint64_t*)0x20002100 = 0x77359400;
      *(uint64_t*)0x20002108 = 0;
      *(uint64_t*)0x20002110 = 0;
      *(uint64_t*)0x20002118 = 0;
      syscall(__NR_timer_settime, r[0], 1ul, 0x20002100ul, 0ul);
      break;
  }
}
int main(void) {
  syscall(__NR_mmap, 0x1ffff000ul, 0x1000ul, 0ul, 0x32ul, -1, 0ul);
  syscall(__NR_mmap, 0x20000000ul, 0x1000000ul, 7ul, 0x32ul, -1, 0ul);
  syscall(__NR_mmap, 0x21000000ul, 0x1000ul, 0ul, 0x32ul, -1, 0ul);
  loop();
  return 0;
}

--Z5mOnECGihyyY82T--
