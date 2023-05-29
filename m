Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 84AF571422B
	for <lists+linux-kernel@lfdr.de>; Mon, 29 May 2023 04:52:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231436AbjE2Cw4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 28 May 2023 22:52:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229559AbjE2Cwy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 May 2023 22:52:54 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FE30AC
        for <linux-kernel@vger.kernel.org>; Sun, 28 May 2023 19:52:52 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0B4D461FCE
        for <linux-kernel@vger.kernel.org>; Mon, 29 May 2023 02:52:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A677DC433D2;
        Mon, 29 May 2023 02:52:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685328771;
        bh=V44sYxF5Gr1oeSfD+weyLs2bjxgWuAZCS8Jb97MeiQI=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=gJ5Tl8KFgHfE3QYkIdP5LB0KXl1Gc5Qpr8o98J6bf/Hb91Eopm8oetOklMt1nw7ez
         lrUTQ6NWB93LeEzm+wqG7ZQ32ZhC4xOuitHDCakySIG6ubwgspfRBTECWCUmCgUgOl
         uXoX+nsdQLP5y/Y8VbCbG2sDIziTDErTkuYYZAaAxZP9H5QuLS6bbRzZNJPZOtdijQ
         AdrI9LGmtwH9QCBVRiT5Gfo/dU88UQDl8eVOykezglckVODo5iOQkFgWVLFiCbfW+7
         CuETsIati44F8JFVI/jiN/ybfavosyE0swcORoD5VpoND8Ptcd8pCXXWZ922kHkajY
         Hoyz1KxE9CvCw==
Date:   Mon, 29 May 2023 11:52:46 +0900
From:   Masami Hiramatsu (Google) <mhiramat@kernel.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     LKML <linux-kernel@vger.kernel.org>, x86@kernel.org,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>, Borislav Petkov <bp@alien8.de>,
        Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH] x86/alternatives: Add cond_resched() to
 text_poke_bp_batch()
Message-Id: <20230529115246.a61734ce4e6d7644e2faec72@kernel.org>
In-Reply-To: <20230528084652.5f3b48f0@rorschach.local.home>
References: <20230528084652.5f3b48f0@rorschach.local.home>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 28 May 2023 08:46:52 -0400
Steven Rostedt <rostedt@goodmis.org> wrote:

> From: "Steven Rostedt (Google)" <rostedt@goodmis.org>
> 
> Debugging in the kernel has started slowing down the kernel by a
> noticeable amount. The ftrace start up tests are triggering the softlockup
> watchdog on some boxes. This is caused by the start up tests that enable
> function and function graph tracing several times. Sprinkling
> cond_resched() just in the start up test code was not enough to stop the
> softlockup from triggering. It would sometimes trigger in the
> text_poke_bp_batch() code.
> 
> The text_poke_bp_batch() is run in schedulable context. Add
> cond_resched() between each phase (adding the int3, updating the code, and
> removing the int3). This keeps the softlockup from triggering in the start
> up tests.
> 
> Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
> ---
>  arch/x86/kernel/alternative.c | 13 ++++++++++++-
>  1 file changed, 12 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/x86/kernel/alternative.c b/arch/x86/kernel/alternative.c
> index f615e0cb6d93..e024eddd457f 100644
> --- a/arch/x86/kernel/alternative.c
> +++ b/arch/x86/kernel/alternative.c
> @@ -1953,6 +1953,14 @@ static void text_poke_bp_batch(struct text_poke_loc *tp, unsigned int nr_entries
>  	 */
>  	atomic_set_release(&bp_desc.refs, 1);
>  
> +	/*
> +	 * Function tracing can enable thousands of places that need to be
> +	 * updated. This can take quite some time, and with full kernel debugging
> +	 * enabled, this could cause the softlockup watchdog to trigger.
> +	 * Add cond_resched() calls to each phase.
> +	 */
> +	cond_resched();

Hmm, why don't you put this between the first step (put int3) and the
second step (put other bytes)? I guess those would takes more time.

Thank you,

> +
>  	/*
>  	 * Corresponding read barrier in int3 notifier for making sure the
>  	 * nr_entries and handler are correctly ordered wrt. patching.
> @@ -2030,6 +2038,7 @@ static void text_poke_bp_batch(struct text_poke_loc *tp, unsigned int nr_entries
>  		 * better safe than sorry (plus there's not only Intel).
>  		 */
>  		text_poke_sync();
> +		cond_resched();
>  	}
>  
>  	/*
> @@ -2049,8 +2058,10 @@ static void text_poke_bp_batch(struct text_poke_loc *tp, unsigned int nr_entries
>  		do_sync++;
>  	}
>  
> -	if (do_sync)
> +	if (do_sync) {
>  		text_poke_sync();
> +		cond_resched();
> +	}
>  
>  	/*
>  	 * Remove and wait for refs to be zero.
> -- 
> 2.39.2
> 


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
