Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E2BB744E31
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Jul 2023 16:50:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229761AbjGBOuI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 2 Jul 2023 10:50:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229584AbjGBOuG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Jul 2023 10:50:06 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C23BEE67;
        Sun,  2 Jul 2023 07:50:05 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 530BA60C23;
        Sun,  2 Jul 2023 14:50:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 761F3C433C8;
        Sun,  2 Jul 2023 14:50:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1688309404;
        bh=caaD9xa4mjdhhwGViCS3V1TFGGKeEWO2ZEZGbloxTvk=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=NB6iwd1pL00TBTCFvdHPO+WZ8G4wX4JEkBnD00XuecOhJRPx6u+xywB94gTgFfoUH
         yLroSKzDtLoQxAGaOgNjOKPtsbFTz+hj0ALXiacNYP8E1ilMB/6Bl1vWBTxhon7LoL
         fqwQFvAyI2bazacFUdI1/3iAu2H8A9HZf6joxoQSTzjkCREW9tLgESFC6CrxCY52VP
         8onONA5pPElOh78cmAVE82+qmhlpPYQkPkAHIdeYhBs+VQqqtOz5lX1/8lr7/eyj0g
         9pv3PQKXhzZOYm85o0qUXI+I/RH4oNUtDnXUZc2MAEuUmrCjx2b2/g02XxfQRw3M53
         BfE60WrYh/XpA==
Date:   Sun, 2 Jul 2023 23:50:01 +0900
From:   Masami Hiramatsu (Google) <mhiramat@kernel.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     "Tzvetomir Stoyanov (VMware)" <tz.stoyanov@gmail.com>,
        mhiramat@kernel.org, dan.carpenter@linaro.org,
        linux-trace-devel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] kernel/trace: Fix cleanup logic of
 enable_trace_eprobe
Message-Id: <20230702235001.5bd26b8cd85028fc2bce94e6@kernel.org>
In-Reply-To: <20230701090254.72323659@rorschach.local.home>
References: <20230630121627.833560-1-tz.stoyanov@gmail.com>
        <20230701090254.72323659@rorschach.local.home>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 1 Jul 2023 09:02:54 -0400
Steven Rostedt <rostedt@goodmis.org> wrote:

> On Fri, 30 Jun 2023 15:16:27 +0300
> "Tzvetomir Stoyanov (VMware)" <tz.stoyanov@gmail.com> wrote:
> 
> 
> Hi Tzvetomir,
> 
> FYI, linux-trace-devel is for the tracing user space code, please Cc to
> linux-trace-kernel for kernel patches. That makes it fall into the
> proper patchwork.
> 
> I noticed this because I couldn't find your patch in:
> 
>   https://patchwork.kernel.org/project/linux-trace-kernel/list/
> 
> Also, the Subject should just start with "tracing:".
> 
> > The enable_trace_eprobe() function enables all event probes, attached
> > to given trace probe. If an error occurs in enabling one of the event
> > probes, all others should be roll backed. There is a bug in that roll
> > back logic - instead of all event probes, only the failed one is
> > disabled.
> > 
> > Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
> > Fixes: 7491e2c44278 ("tracing: Add a probe that attaches to trace events")
> > Signed-off-by: Tzvetomir Stoyanov (VMware) <tz.stoyanov@gmail.com>
> > ---
> > v2: Added one-time warning, as suggested by Steven Rostedt.
> 
> It's always a nice touch (optional, but something I always do) to
> add a link to the previous version:
> 
>  Changes since v2: https://lore.kernel.org/all/20230628121811.338655-1-tz.stoyanov@gmail.com/
>      - Added one-time warning (Steven Rostedt)
> 
> > 
> >  kernel/trace/trace_eprobe.c | 14 ++++++++++++--
> >  1 file changed, 12 insertions(+), 2 deletions(-)
> > 
> > diff --git a/kernel/trace/trace_eprobe.c b/kernel/trace/trace_eprobe.c
> > index 67e854979d53..6629fa217c99 100644
> > --- a/kernel/trace/trace_eprobe.c
> > +++ b/kernel/trace/trace_eprobe.c
> > @@ -702,8 +702,18 @@ static int enable_trace_eprobe(struct trace_event_call *call,
> >  
> >  	if (ret) {
> >  		/* Failed to enable one of them. Roll back all */
> > -		if (enabled)
> > -			disable_eprobe(ep, file->tr);
> > +		if (enabled) {
> > +			/*
> > +			 * It's a bug if one failed for something other than memory
> > +			 * not being available but another eprobe succeeded.
> > +			 */
> > +			WARN_ON_ONCE(ret != -ENOMEM);
> > +
> > +			list_for_each_entry(pos, trace_probe_probe_list(tp), list) {
> > +				ep = container_of(pos, struct trace_eprobe, tp);
> > +				disable_eprobe(ep, file->tr);
> > +			}
> 
> I think we may need the counter again ;-)
> 
> But for another reason. We only want to call disable for what we
> enabled, to avoid any unforeseen side effects.
> 
> 
> 	cnt = 0;
>         list_for_each_entry(pos, trace_probe_probe_list(tp), list) {
>                 ep = container_of(pos, struct trace_eprobe, tp);
>                 ret = enable_eprobe(ep, file);
>                 if (ret)
>                         break;
>                 enabled = true;
> 		cnt++;
>         }
> 
>         if (ret) {
>                 /* Failed to enable one of them. Roll back all */
>                 if (enabled) {
> 			list_for_each_entry(pos, trace_probe_probe_list(tp), list) {
> 				ep = container_of(pos, struct trace_eprobe, tp);
> 				disable_eprobe(ep, file->tr);
> 				if (!--cnt)
> 					break;
> 			}
> 		}

+1. It seems that enable_eprobe() doesn't change ep, we need a counter to
count how many eprobes are enabled in the first loop for roll-back the
already enabled eprobes in the 2nd loop.

Thank you,


> 
> Thoughts?
> 
> -- Steve
> 
> 
> 
> > +		}
> >  		if (file)
> >  			trace_probe_remove_file(tp, file);
> >  		else
> 


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
