Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 24A6B627E63
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Nov 2022 13:47:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237253AbiKNMre (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Nov 2022 07:47:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237358AbiKNMrM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Nov 2022 07:47:12 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3545B21A6;
        Mon, 14 Nov 2022 04:46:53 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id BF6276113D;
        Mon, 14 Nov 2022 12:46:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4A04CC433C1;
        Mon, 14 Nov 2022 12:46:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1668430012;
        bh=F+epNH5SqnmIUoQlpP4BNK1fKsgfSdgaSzTkz1qX9+Y=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=FH3AayK7SudHPtg1lwDrbn+jpO8Bl0MC6LshCNF58ACEbunH/kMoTZDUts4sL+WRw
         W7XHnIqozrdswPQfccJfK3zp2M2MQjUn3i2YJiM3Fwq2GR2cY7V6sMR8SxdcqkD0Op
         eVRqNiUInmXPl24zRyXl4iYTvYdoluPNtqGMg2tTdozB6bqn1taHnqIyQ4QXVXGq+n
         Be5pTy2PbyhPrO9oZOTzQt6dl3wWm+md6+N9u3du86HlSvbtXTNYBy0+fEiC9NSB4W
         xun6ZHaxdysW1EXmMnk89QBfODp3w4IatMGgluOFzQ1bU5xioe9rk93AawaJcM23Ff
         XZmqcY7ni3EfA==
Date:   Mon, 14 Nov 2022 21:46:49 +0900
From:   Masami Hiramatsu (Google) <mhiramat@kernel.org>
To:     Zheng Yejian <zhengyejian1@huawei.com>
Cc:     <rostedt@goodmis.org>, <linux-kernel@vger.kernel.org>,
        <linux-trace-kernel@vger.kernel.org>
Subject: Re: [PATCH] tracing: Fix potential null-pointer-access of entry in
 list 'tr->err_log'
Message-Id: <20221114214649.ecc18c3ee3f74377ce80e66d@kernel.org>
In-Reply-To: <20221114104632.3547266-1-zhengyejian1@huawei.com>
References: <20221114104632.3547266-1-zhengyejian1@huawei.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 14 Nov 2022 18:46:32 +0800
Zheng Yejian <zhengyejian1@huawei.com> wrote:

> Entries in list 'tr->err_log' will be reused after entry number
> exceed TRACING_LOG_ERRS_MAX.
> 
> The cmd string of the to be reused entry will be freed first then
> allocated a new one. If the allocation failed, then the entry will
> still be in list 'tr->err_log' but its 'cmd' field is set to be NULL,
> later access of 'cmd' is risky.
> 
> Currently above problem can cause the loss of 'cmd' information of first
> entry in 'tr->err_log'. When execute `cat /sys/kernel/tracing/error_log`,
> reproduce logs like:
>   [   37.495100] trace_kprobe: error: Maxactive is not for kprobe(null) ^
>   [   38.412517] trace_kprobe: error: Maxactive is not for kprobe
>     Command: p4:myprobe2 do_sys_openat2
>             ^

This looks good to me.

Acked-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>

BTW, I'm interested in how did you reproduce it. Did you inject a memory
allocation failure to reproduce it?

Thank you,

> 
> Fixes: 1581a884b7ca ("tracing: Remove size restriction on tracing_log_err cmd strings")
> Signed-off-by: Zheng Yejian <zhengyejian1@huawei.com>
> ---
>  kernel/trace/trace.c | 9 +++++----
>  1 file changed, 5 insertions(+), 4 deletions(-)
> 
> diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
> index 47a44b055a1d..5ae776598106 100644
> --- a/kernel/trace/trace.c
> +++ b/kernel/trace/trace.c
> @@ -7802,6 +7802,7 @@ static struct tracing_log_err *get_tracing_log_err(struct trace_array *tr,
>  						   int len)
>  {
>  	struct tracing_log_err *err;
> +	char *cmd;
>  
>  	if (tr->n_err_log_entries < TRACING_LOG_ERRS_MAX) {
>  		err = alloc_tracing_log_err(len);
> @@ -7810,12 +7811,12 @@ static struct tracing_log_err *get_tracing_log_err(struct trace_array *tr,
>  
>  		return err;
>  	}
> -
> +	cmd = kzalloc(len, GFP_KERNEL);
> +	if (!cmd)
> +		return ERR_PTR(-ENOMEM);
>  	err = list_first_entry(&tr->err_log, struct tracing_log_err, list);
>  	kfree(err->cmd);
> -	err->cmd = kzalloc(len, GFP_KERNEL);
> -	if (!err->cmd)
> -		return ERR_PTR(-ENOMEM);
> +	err->cmd = cmd;
>  	list_del(&err->list);
>  
>  	return err;
> -- 
> 2.25.1
> 


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
