Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F01625F8C2F
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Oct 2022 18:10:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230193AbiJIQKh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 9 Oct 2022 12:10:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230013AbiJIQKe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Oct 2022 12:10:34 -0400
Received: from mail.ispras.ru (mail.ispras.ru [83.149.199.84])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05040240A3
        for <linux-kernel@vger.kernel.org>; Sun,  9 Oct 2022 09:10:32 -0700 (PDT)
Received: from mail.ispras.ru (unknown [83.149.199.84])
        by mail.ispras.ru (Postfix) with ESMTPSA id F416040786A1;
        Sun,  9 Oct 2022 16:10:29 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.ispras.ru F416040786A1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ispras.ru;
        s=default; t=1665331830;
        bh=43eIcp+GCtcDevNxcG0lVGU+/GyQSay0DJzKe92v7XQ=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=ez/Ywufu19t/QnFHJgc+6Lr0YIlfAhwty9aYL2+ZM7GBvkRB0lU3SSK0Zy1fUUvBL
         1pB8mND6+tuJTXScSGcF+XxAYjN6Z2iFxdYO1TgpeFzAfKWoLcPWUeVRZxTOKSERo4
         B78g5nWOL4ZjSDeAbNsvNohEON/mE0DX95/SkBfA=
MIME-Version: 1.0
Date:   Sun, 09 Oct 2022 19:10:29 +0300
From:   Alexey Izbyshev <izbyshev@ispras.ru>
To:     Andrei Vagin <avagin@google.com>
Cc:     Kees Cook <keescook@chromium.org>, linux-kernel@vger.kernel.org,
        Andrei Vagin <avagin@gmail.com>,
        Christian Brauner <brauner@kernel.org>,
        Dmitry Safonov <0x7f454c46@gmail.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Florian Weimer <fweimer@redhat.com>
Subject: Re: [PATCH 2/2] selftests/timens: add a test for vfork+exit
In-Reply-To: <20220921003120.209637-2-avagin@google.com>
References: <20220921003120.209637-1-avagin@google.com>
 <20220921003120.209637-2-avagin@google.com>
User-Agent: Roundcube Webmail/1.4.4
Message-ID: <00ffd40b257346d26dfc0f03d144ec71@ispras.ru>
X-Sender: izbyshev@ispras.ru
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022-09-21 03:31, Andrei Vagin wrote:
> From: Andrei Vagin <avagin@gmail.com>
> 
> * check that a child process is in parent's time namespace after vfork.
> * check that a child process is in the target namespace after exec.
> 
> Output on success:
>  1..5
>  ok 1 parent before vfork
>  ok 2 child before exec
>  ok 3 child after exec
>  ok 4 wait for child
>  ok 5 parent after vfork
>  # Totals: pass:5 fail:0 xfail:0 xpass:0 skip:0 error:0
> 
> Signed-off-by: Andrei Vagin <avagin@gmail.com>
> ---
>  tools/testing/selftests/timens/.gitignore   |   1 +
>  tools/testing/selftests/timens/Makefile     |   2 +-
>  tools/testing/selftests/timens/vfork_exec.c | 132 ++++++++++++++++++++
>  3 files changed, 134 insertions(+), 1 deletion(-)
>  create mode 100644 tools/testing/selftests/timens/vfork_exec.c
> 
> diff --git a/tools/testing/selftests/timens/.gitignore
> b/tools/testing/selftests/timens/.gitignore
> index fe1eb8271b35..cae8dca0fbff 100644
> --- a/tools/testing/selftests/timens/.gitignore
> +++ b/tools/testing/selftests/timens/.gitignore
> @@ -8,3 +8,4 @@ procfs
>  timens
>  timer
>  timerfd
> +vfork_exec
> diff --git a/tools/testing/selftests/timens/Makefile
> b/tools/testing/selftests/timens/Makefile
> index 3a5936cc10ab..f0d51d4d2c87 100644
> --- a/tools/testing/selftests/timens/Makefile
> +++ b/tools/testing/selftests/timens/Makefile
> @@ -1,4 +1,4 @@
> -TEST_GEN_PROGS := timens timerfd timer clock_nanosleep procfs exec 
> futex
> +TEST_GEN_PROGS := timens timerfd timer clock_nanosleep procfs exec
> futex vfork_exec
>  TEST_GEN_PROGS_EXTENDED := gettime_perf
> 
>  CFLAGS := -Wall -Werror -pthread
> diff --git a/tools/testing/selftests/timens/vfork_exec.c
> b/tools/testing/selftests/timens/vfork_exec.c
> new file mode 100644
> index 000000000000..9fd8a64d25a9
> --- /dev/null
> +++ b/tools/testing/selftests/timens/vfork_exec.c
> @@ -0,0 +1,132 @@
> +// SPDX-License-Identifier: GPL-2.0
> +#define _GNU_SOURCE
> +#include <errno.h>
> +#include <fcntl.h>
> +#include <sched.h>
> +#include <stdio.h>
> +#include <stdbool.h>
> +#include <sys/stat.h>
> +#include <sys/syscall.h>
> +#include <sys/types.h>
> +#include <sys/wait.h>
> +#include <time.h>
> +#include <unistd.h>
> +#include <string.h>
> +#include <pthread.h>
> +
> +#include "log.h"
> +#include "timens.h"
> +
> +#define OFFSET (36000)
> +
> +static void *tcheck(void *arg)
> +{
> +	struct timespec *now = arg, tst;
> +	int i;
> +
> +	for (i = 0; i < 2; i++) {
> +		_gettime(CLOCK_MONOTONIC, &tst, i);
> +		if (abs(tst.tv_sec - now->tv_sec) > 5) {
> +			pr_fail("thread: unexpected value: %ld (%ld)\n",
> +				tst.tv_sec, now->tv_sec);
> +			return (void *)1UL;
> +		}
> +	}
> +	return NULL;
> +}
> +
> +static int check_in_thread(struct timespec *now)
> +{
> +	pthread_t th;
> +	void *retval;
> +
> +	if (pthread_create(&th, NULL, tcheck, now))
> +		return pr_perror("thread");
> +	if (pthread_join(th, &retval))
> +		return pr_perror("pthread_join");
> +	return !(retval == NULL);
> +}
> +
> +static int check(char *tst_name, struct timespec *now)
> +{
> +	struct timespec tst;
> +	int i;
> +
> +	for (i = 0; i < 2; i++) {
> +		_gettime(CLOCK_MONOTONIC, &tst, i);
> +		if (abs(tst.tv_sec - now->tv_sec) > 5)
> +			return pr_fail("%s: unexpected value: %ld (%ld)\n",
> +					tst.tv_sec, now->tv_sec);

There is a missing argument for "%s" in pr_fail(). I'm actually 
surprised that there is no __attribute__((format)) on 
ksft_test_result_fail() that would allow GCC to catch this.

> +	}
> +	if (check_in_thread(now))
> +		return 1;
> +	ksft_test_result_pass("%s\n", tst_name);
> +	return 0;
> +}
> +
> +int main(int argc, char *argv[])
> +{
> +	struct timespec now;
> +	int status;
> +	pid_t pid;
> +
> +	if (argc > 1) {
> +		char *endptr;
> +
> +		ksft_cnt.ksft_pass = 2;
> +		now.tv_sec = strtoul(argv[1], &endptr, 0);
> +		if (*endptr != 0)
> +			return pr_perror("strtoul");
> +
> +		return check("child after exec", &now);
> +	}
> +
> +	nscheck();
> +
> +	ksft_set_plan(5);
> +
> +	clock_gettime(CLOCK_MONOTONIC, &now);
> +
> +	if (unshare_timens())
> +		return 1;
> +
> +	if (_settime(CLOCK_MONOTONIC, OFFSET))
> +		return 1;
> +
> +	if (check("parent before vfork", &now))
> +		return 1;
> +
> +	pid = vfork();
> +	if (pid < 0)
> +		return pr_perror("fork");
> +
> +	if (pid == 0) {
> +		char now_str[64];
> +		char *cargv[] = {"exec", now_str, NULL};
> +		char *cenv[] = {NULL};
> +
> +		// Check that we are still in the source timens.
> +		if (check("child before exec", &now))
> +			return 1;

I know this is just a test, but...

Creating threads in a vfork()-child is quite dangerous (like most other 
things that touch the libc state, which is shared with the parent 
process). Here it works probably only because pthread_create() followed 
by pthread_join() restores everything into more-or-less the original 
state before returning control to the parent, but this is something that 
libcs don't guarantee and that can break at any moment.

Also, returning from a vfork()-child is explicitly forbidden by the 
vfork() contract because the parent would then return to an invalid 
stack frame that could be arbitrarily clobbered by code executed in the 
child after main() returned. Moreover, if I'm not mistaken, on x86 with 
Intel CET-enabled glibc (assuming the support for CET is ever merged 
into the kernel) such return would cause the parent to always trap 
because the shadow stack will become inconsistent with the normal stack. 
Instead, _exit() should be used here...

> +
> +		/* Check for proper vvar offsets after execve. */
> +		snprintf(now_str, sizeof(now_str), "%ld", now.tv_sec + OFFSET);
> +		execve("/proc/self/exe", cargv, cenv);
> +		return pr_perror("execve");

...and here.

> +	}
> +
> +	if (waitpid(pid, &status, 0) != pid)
> +		return pr_perror("waitpid");
> +
> +	if (status)
> +		ksft_exit_fail();
> +	ksft_inc_pass_cnt();
> +	ksft_test_result_pass("wait for child\n");
> +
> +	// Check that we are still in the source timens.
> +	if (check("parent after vfork", &now))
> +		return 1;
> +
> +	ksft_exit_pass();
> +	return 0;
> +}

Otherwise, both patches look good to me, thanks!

Sorry for being late,
Alexey
