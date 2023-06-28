Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F46B741468
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Jun 2023 16:59:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230413AbjF1O6r (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Jun 2023 10:58:47 -0400
Received: from dfw.source.kernel.org ([139.178.84.217]:49060 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229456AbjF1O6p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Jun 2023 10:58:45 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A0B6261349
        for <linux-kernel@vger.kernel.org>; Wed, 28 Jun 2023 14:58:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A33AEC433C0;
        Wed, 28 Jun 2023 14:58:43 +0000 (UTC)
Date:   Wed, 28 Jun 2023 10:58:39 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        sunliming <sunliming@kylinos.cn>,
        Beau Belgrave <beaub@linux.microsoft.com>
Subject: Re: [GIT PULL v2] tracing: tracing: user_event fix for 6.4
Message-ID: <20230628105839.68cd8780@rorschach.local.home>
In-Reply-To: <20230628105425.3f39f755@rorschach.local.home>
References: <20230628105425.3f39f755@rorschach.local.home>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

Hold off on pulling this. I'll make a v3 to include a stable and Fixes
tag as this didn't make it into the release that the code was added.

-- Steve


On Wed, 28 Jun 2023 10:54:25 -0400
Steven Rostedt <rostedt@goodmis.org> wrote:

> Linus,
> 
> tracing: Fix user event write on buffer disabled
> 
> The user events write currently returns the size of what was suppose to be
> written when tracing is disabled and nothing was written. Instead, behave like
> trace_marker and return -EBADF, as that is what is returned if a file is opened
> for read only, and a write is performed on it. Writing to the buffer
> that is disabled is like trying to write to a file opened for read
> only, as the buffer still can be read, but just not written to.
> 
> This also includes test cases for this use case.
> 
> 
> Please pull the latest trace-v6.4-rc7-v2 tree, which can be found at:
> 
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/trace/linux-trace.git
> trace-v6.4-rc7-v2
> 
> Tag SHA1: 02efa9f9b19b0d881812bae9b3e28d539b67a863
> Head SHA1: e155047e53d25f09d055c08ae9d6c269520e90d8
> 
> 
> sunliming (3):
>       tracing/user_events: Fix incorrect return value for writing operation when events are disabled
>       selftests/user_events: Enable the event before write_fault test in ftrace self-test
>       selftests/user_events: Add test cases when event is disabled
> 
> ----
>  kernel/trace/trace_events_user.c                  | 3 ++-
>  tools/testing/selftests/user_events/ftrace_test.c | 8 ++++++++
>  2 files changed, 10 insertions(+), 1 deletion(-)
> ---------------------------
> diff --git a/kernel/trace/trace_events_user.c b/kernel/trace/trace_events_user.c
> index 8df0550415e7..09f7d9167b8e 100644
> --- a/kernel/trace/trace_events_user.c
> +++ b/kernel/trace/trace_events_user.c
> @@ -2096,7 +2096,8 @@ static ssize_t user_events_write_core(struct file *file, struct iov_iter *i)
>  
>  		if (unlikely(faulted))
>  			return -EFAULT;
> -	}
> +	} else
> +		return -EBADF;
>  
>  	return ret;
>  }
> diff --git a/tools/testing/selftests/user_events/ftrace_test.c b/tools/testing/selftests/user_events/ftrace_test.c
> index eb6904d89f14..5beb0aef1d81 100644
> --- a/tools/testing/selftests/user_events/ftrace_test.c
> +++ b/tools/testing/selftests/user_events/ftrace_test.c
> @@ -324,6 +324,10 @@ TEST_F(user, write_events) {
>  	io[0].iov_base = &reg.write_index;
>  	io[0].iov_len = sizeof(reg.write_index);
>  
> +	/* Write should return -EBADF when event is not enabled */
> +	ASSERT_EQ(-1, writev(self->data_fd, (const struct iovec *)io, 3));
> +	ASSERT_EQ(EBADF, errno);
> +
>  	/* Enable event */
>  	self->enable_fd = open(enable_file, O_RDWR);
>  	ASSERT_NE(-1, write(self->enable_fd, "1", sizeof("1")))
> @@ -400,6 +404,10 @@ TEST_F(user, write_fault) {
>  	ASSERT_EQ(0, ioctl(self->data_fd, DIAG_IOCSREG, &reg));
>  	ASSERT_EQ(0, reg.write_index);
>  
> +	/* Enable event */
> +	self->enable_fd = open(enable_file, O_RDWR);
> +	ASSERT_NE(-1, write(self->enable_fd, "1", sizeof("1")))
> +
>  	/* Write should work normally */
>  	ASSERT_NE(-1, writev(self->data_fd, (const struct iovec *)io, 2));
>  

