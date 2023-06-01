Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1023471A2C2
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Jun 2023 17:31:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235063AbjFAPbH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Jun 2023 11:31:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235085AbjFAPa7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Jun 2023 11:30:59 -0400
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 91641198;
        Thu,  1 Jun 2023 08:30:39 -0700 (PDT)
Received: from W11-BEAU-MD.localdomain (unknown [76.135.27.212])
        by linux.microsoft.com (Postfix) with ESMTPSA id 4DA7B20FC4F7;
        Thu,  1 Jun 2023 08:30:27 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 4DA7B20FC4F7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1685633427;
        bh=hc9nGqrPH8riQQfJDxNUI70MfSIahTTT1yY8knG+iNo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=PFSKKE7KoS3ygfgDLQSRCUOMa1qQLU5bvXgYrhVGC3Cj7YRc53eNVc/sAkMQOqgWl
         NiOQDHeXeHy69Mc4Ege5qkp/zAcCta0riz4tsy2nxh9e6Kc4IrbSD0bTQ5+HBpLLkj
         OAMpGXafvd6gJU+Teh6x8syXqspc5FmaLiUFGW2Q=
Date:   Thu, 1 Jun 2023 08:30:23 -0700
From:   Beau Belgrave <beaub@linux.microsoft.com>
To:     sunliming <sunliming@kylinos.cn>
Cc:     rostedt@goodmis.org, mhiramat@kernel.org,
        linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH] tracing/user_events: Fix the incorrect trace record for
 null arguments events
Message-ID: <20230601153023.GB71@W11-BEAU-MD.localdomain>
References: <20230601094158.575019-1-sunliming@kylinos.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230601094158.575019-1-sunliming@kylinos.cn>
X-Spam-Status: No, score=-19.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,
        USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 01, 2023 at 05:41:58PM +0800, sunliming wrote:
> The user_events support events that has null arguments. But the trace event
> is discard and not really committed when the arguments is null, fix this
> problem.
> 

Thanks for the patch, this is a good catch! Can you reword this a bit?
"fix this problem" could be reworded to "Fix this by not attempting to
copy in non-zero data".

Would you mind adding this case to either the perf or ftrace self-test?
It's a really good edge case.

Thanks,
-Beau

> Signed-off-by: sunliming <sunliming@kylinos.cn>
> ---
>  kernel/trace/trace_events_user.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/kernel/trace/trace_events_user.c b/kernel/trace/trace_events_user.c
> index 0d91dac206ff..296bdfa674cb 100644
> --- a/kernel/trace/trace_events_user.c
> +++ b/kernel/trace/trace_events_user.c
> @@ -1399,7 +1399,7 @@ static void user_event_ftrace(struct user_event *user, struct iov_iter *i,
>  	if (unlikely(!entry))
>  		return;
>  
> -	if (unlikely(!copy_nofault(entry + 1, i->count, i)))
> +	if (unlikely(i->count && !copy_nofault(entry + 1, i->count, i)))
>  		goto discard;
>  
>  	if (!list_empty(&user->validators) &&
> @@ -1440,7 +1440,7 @@ static void user_event_perf(struct user_event *user, struct iov_iter *i,
>  
>  		perf_fetch_caller_regs(regs);
>  
> -		if (unlikely(!copy_nofault(perf_entry + 1, i->count, i)))
> +		if (unlikely(i->count && !copy_nofault(perf_entry + 1, i->count, i)))
>  			goto discard;
>  
>  		if (!list_empty(&user->validators) &&
> -- 
> 2.25.1
