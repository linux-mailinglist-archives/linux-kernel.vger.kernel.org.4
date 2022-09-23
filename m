Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8BCA85E7373
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Sep 2022 07:30:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230119AbiIWFai (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Sep 2022 01:30:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230062AbiIWFaH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Sep 2022 01:30:07 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D9FB1DF
        for <linux-kernel@vger.kernel.org>; Thu, 22 Sep 2022 22:29:28 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5EDEF61166
        for <linux-kernel@vger.kernel.org>; Fri, 23 Sep 2022 05:29:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2CC61C433C1;
        Fri, 23 Sep 2022 05:29:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1663910958;
        bh=0PmBlwmWJtXvSbEjPSQW/ovLrlEEbdGA8nJaneip4P0=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=GEqqXJimMpdMCUdBcAta82S2sX01A4acu6jhIOIwtUSBTN6Ct2dEWLNyfwpz688RI
         qeDo1JUmvLpGuqFOJS1ZiGobDJGtxaesTGv5orcH59NETmprxBGXX68LqexZPcs4Zo
         duc66O7UgnuNeyCSmAx29smEFQ/By03bZA251KN+j2kS5NSVOLrta5IZ3BGXt41GnL
         iqZGULqGnJximaugcvn6mOFxNGW+h4iwbGCexWD3PzzL3XATcc+RgedEff8Zhnm1wu
         8rs8/2cm2G+Jt2RjTmMFrQCduGZ5VykHz84hjdCmnRCYS+os29bnz1Mc2ST+NjnN96
         QA9VKema0yg6g==
Date:   Fri, 23 Sep 2022 14:29:14 +0900
From:   Masami Hiramatsu (Google) <mhiramat@kernel.org>
To:     Tao Chen <chentao.kernel@linux.alibaba.com>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>,
        Tzvetomir Stoyanov <tz.stoyanov@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] tracing/eprobe: Fix alloc event dir failed when event
 name no set
Message-Id: <20220923142914.3488abb9f60422f27584896e@kernel.org>
In-Reply-To: <1663504148-40723-1-git-send-email-chentao.kernel@linux.alibaba.com>
References: <1663504148-40723-1-git-send-email-chentao.kernel@linux.alibaba.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-9.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 18 Sep 2022 20:29:08 +0800
Tao Chen <chentao.kernel@linux.alibaba.com> wrote:

> The event dir will alloc failed when event name no set, using the
> command:
> "echo "e:esys/ syscalls/sys_enter_openat file=\$filename:string"
> >> dynamic_events"
> It seems that dir name="syscalls/sys_enter_openat" is not allowed
> in debugfs. So just use the "sys_enter_openat" as the event name.

Good catch! 

> 
> Fixes: 7491e2c44278 ("tracing: Add a probe that attaches to trace
> events")

But actually, this code was introduced by below commit, so Fixes tag
must be updated. (this is important because stable backport version
will be decided by this tag.)

Fixes: 95c104c378dc ("tracing: Auto generate event name when creating a group of events")

Acked-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>

Thank you!

> Signed-off-by: Tao Chen <chentao.kernel@linux.alibaba.com>
> ---
>  kernel/trace/trace_eprobe.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/kernel/trace/trace_eprobe.c b/kernel/trace/trace_eprobe.c
> index 1783e3478912..a8938e54cd34 100644
> --- a/kernel/trace/trace_eprobe.c
> +++ b/kernel/trace/trace_eprobe.c
> @@ -968,8 +968,7 @@ static int __trace_eprobe_create(int argc, const char *argv[])
>  	}
>  
>  	if (!event) {
> -		strscpy(buf1, argv[1], MAX_EVENT_NAME_LEN);
> -		sanitize_event_name(buf1);
> +		strscpy(buf1, sys_event, MAX_EVENT_NAME_LEN);
>  		event = buf1;
>  	}
>  
> -- 
> 2.32.0
> 


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
