Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F2DD6EE422
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Apr 2023 16:43:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234297AbjDYOn3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Apr 2023 10:43:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234175AbjDYOn1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Apr 2023 10:43:27 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D557B268F;
        Tue, 25 Apr 2023 07:43:26 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6FC7162ACA;
        Tue, 25 Apr 2023 14:43:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8532CC4339B;
        Tue, 25 Apr 2023 14:43:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1682433805;
        bh=yu5XudPSm8Hf0iGdr9YVHx9Rr6jvIBiIKYFbeWm+AfE=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=ZDpFkNkusx7+yCfV2AUsN3QqyoViX+tEQObnbdGAVJ0dl3ipPavoOXOl2SVht2wTm
         +VR3KWEY7C0pygqgKRKDBCiIpQqi4j9lZs9FJIwCbnfJpjZJ/yYOdc+yXqSUbTaGg9
         A2B2g2O4CaS7MgcRF9j+V8UP9R6QZJw9eyDYlWOOSehVo//pR2RUmevLrnlWUkuMp0
         aAWk+cHuS4R+uHBPdfSeknWy8+ZFV5InzzmQ2fxz5ABs4wojS3eGvihQ6lGTDqbVzt
         D6EI7pPqPIsbkTm4+K1RK0olVvLAqXTAS4KFj7iOvKkgbUNkM9kmAwNQHWTL7UEVmj
         GkADSovtsmt5A==
Date:   Tue, 25 Apr 2023 23:43:22 +0900
From:   Masami Hiramatsu (Google) <mhiramat@kernel.org>
To:     Beau Belgrave <beaub@linux.microsoft.com>
Cc:     rostedt@goodmis.org, mathieu.desnoyers@efficios.com,
        dcook@linux.microsoft.com, alanau@linux.microsoft.com,
        linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] tracing/user_events: Ensure write index cannot be
 negative
Message-Id: <20230425234322.64936672edb26dd2afdb3a55@kernel.org>
In-Reply-To: <20230411211709.15018-2-beaub@linux.microsoft.com>
References: <20230411211709.15018-1-beaub@linux.microsoft.com>
        <20230411211709.15018-2-beaub@linux.microsoft.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-8.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 11 Apr 2023 14:17:07 -0700
Beau Belgrave <beaub@linux.microsoft.com> wrote:

> The write index indicates which event the data is for and accesses a
> per-file array. The index is passed by user processes during write()
> calls as the first 4 bytes. Ensure that it cannot be negative by
> returning -EINVAL to prevent out of bounds accesses.
> 
> Update ftrace self-test to ensure this occurs properly.
> 
> Fixes: 7f5a08c79df3 ("user_events: Add minimal support for trace_event into ftrace")
> Reported-by: Doug Cook <dcook@linux.microsoft.com>
> Signed-off-by: Beau Belgrave <beaub@linux.microsoft.com>

Looks good to me.

Acked-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>

Thanks!

> ---
>  kernel/trace/trace_events_user.c                  | 3 +++
>  tools/testing/selftests/user_events/ftrace_test.c | 5 +++++
>  2 files changed, 8 insertions(+)
> 
> diff --git a/kernel/trace/trace_events_user.c b/kernel/trace/trace_events_user.c
> index cc8c6d8b69b5..e7dff24aa724 100644
> --- a/kernel/trace/trace_events_user.c
> +++ b/kernel/trace/trace_events_user.c
> @@ -1821,6 +1821,9 @@ static ssize_t user_events_write_core(struct file *file, struct iov_iter *i)
>  	if (unlikely(copy_from_iter(&idx, sizeof(idx), i) != sizeof(idx)))
>  		return -EFAULT;
>  
> +	if (idx < 0)
> +		return -EINVAL;
> +
>  	rcu_read_lock_sched();
>  
>  	refs = rcu_dereference_sched(info->refs);
> diff --git a/tools/testing/selftests/user_events/ftrace_test.c b/tools/testing/selftests/user_events/ftrace_test.c
> index aceafacfb126..91272f9d6fce 100644
> --- a/tools/testing/selftests/user_events/ftrace_test.c
> +++ b/tools/testing/selftests/user_events/ftrace_test.c
> @@ -296,6 +296,11 @@ TEST_F(user, write_events) {
>  	ASSERT_NE(-1, writev(self->data_fd, (const struct iovec *)io, 3));
>  	after = trace_bytes();
>  	ASSERT_GT(after, before);
> +
> +	/* Negative index should fail with EINVAL */
> +	reg.write_index = -1;
> +	ASSERT_EQ(-1, writev(self->data_fd, (const struct iovec *)io, 3));
> +	ASSERT_EQ(EINVAL, errno);
>  }
>  
>  TEST_F(user, write_fault) {
> -- 
> 2.25.1
> 


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
