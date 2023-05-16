Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B6CE7044B9
	for <lists+linux-kernel@lfdr.de>; Tue, 16 May 2023 07:33:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230015AbjEPFd2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 May 2023 01:33:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229891AbjEPFd0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 May 2023 01:33:26 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 352F535AC;
        Mon, 15 May 2023 22:33:25 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C63F1624FD;
        Tue, 16 May 2023 05:33:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BD67BC433EF;
        Tue, 16 May 2023 05:33:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684215204;
        bh=PmuiakI4/1KEPTV0KMYZFkTULU+PVjxrYSH2hkmiMlQ=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=BpOlRoob/f9Du4uNPtsFIQrZTVSIvAOOj82McsiRStz0zZXM7ENaC1aHYXPXYrG7V
         BmNwG77QmeIb0eI50vaEZnZ+aY9JT/73E7CQW11DNpx4J6fFevb/wWD8nMLF5ru222
         SbljtK9ocp5iq/oi8gVqcVmyCLUWlN/EUFptYOisfjnLGl+M1+WYMv4hPIiYCQVNEy
         eRu3GP28BSwhkuucYeW9S7jyqR4sUNmCb187//HWxEmJBD09solIYeVOWT3I/CnfNG
         Pq70NkdOg3XBE0re3zkbSmH2WAS0ldN6RWB4q7i52AW9QC2/4wbNBjN00GdfyJeSv3
         44eBrtRseR4yg==
Date:   Tue, 16 May 2023 14:33:20 +0900
From:   Masami Hiramatsu (Google) <mhiramat@kernel.org>
To:     Masami Hiramatsu (Google) <mhiramat@kernel.org>
Cc:     Ze Gao <zegao2021@gmail.com>, Steven Rostedt <rostedt@goodmis.org>,
        Ze Gao <zegao@tencent.com>, linux-kernel@vger.kernel.org,
        linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH 1/4] rethook: use preempt_{disable, enable}_notrace in
 rethook_trampoline_handler
Message-Id: <20230516143320.f0eb438f981039e59ee4a5b1@kernel.org>
In-Reply-To: <20230516132502.c51be728bd086b8c9005ce57@kernel.org>
References: <cover.1684120990.git.zegao@tencent.com>
        <a17a14abfb81cb0eea77c2ee10d7fc98d5d5a73e.1684120990.git.zegao@tencent.com>
        <20230516132502.c51be728bd086b8c9005ce57@kernel.org>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-10.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 16 May 2023 13:25:02 +0900
Masami Hiramatsu (Google) <mhiramat@kernel.org> wrote:

> Hi Ze Gao,
> 
> Thanks for the patch.
> 
> On Mon, 15 May 2023 11:26:38 +0800
> Ze Gao <zegao2021@gmail.com> wrote:
> 
> > This patch replace preempt_{disable, enable} with its corresponding
> > notrace version in rethook_trampoline_handler so no worries about stack
> > recursion or overflow introduced by preempt_count_{add, sub} under
> > fprobe + rethook context.
> 
> So, have you ever see that recursion of preempt_count overflow case?
> 
> I intended to use the normal preempt_disable() here because it does NOT
> prohibit any function-trace call (Note that both kprobes and
> fprobe checks recursive call by itself) but it is used for preempt_onoff
> tracer.

OK, I got the point.

  rethook_trampoline_handler() {
    preempt_disable() {
      preempt_count_add() { => fprobe and set rethook
      } => rethook_trampoline_handler() {
        preempt_disable() {
          ...   

So the problem is that the preempt_disable() macro calls preempt_count_add()
which can be tracable.

So, let's make it notrace.

Acked-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>

and

Fixes: 54ecbe6f1ed5 ("rethook: Add a generic return hook")
Cc: stable@vger.kernel.org

Thank you,

> 
> Thanks,
> 
> > 
> > Signed-off-by: Ze Gao <zegao@tencent.com>
> > ---
> >  kernel/trace/rethook.c | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> > 
> > diff --git a/kernel/trace/rethook.c b/kernel/trace/rethook.c
> > index 32c3dfdb4d6a..60f6cb2b486b 100644
> > --- a/kernel/trace/rethook.c
> > +++ b/kernel/trace/rethook.c
> > @@ -288,7 +288,7 @@ unsigned long rethook_trampoline_handler(struct pt_regs *regs,
> >  	 * These loops must be protected from rethook_free_rcu() because those
> >  	 * are accessing 'rhn->rethook'.
> >  	 */
> > -	preempt_disable();
> > +	preempt_disable_notrace();
> >  
> >  	/*
> >  	 * Run the handler on the shadow stack. Do not unlink the list here because
> > @@ -321,7 +321,7 @@ unsigned long rethook_trampoline_handler(struct pt_regs *regs,
> >  		first = first->next;
> >  		rethook_recycle(rhn);
> >  	}
> > -	preempt_enable();
> > +	preempt_enable_notrace();
> >  
> >  	return correct_ret_addr;
> >  }
> > -- 
> > 2.40.1
> > 
> 
> 
> -- 
> Masami Hiramatsu (Google) <mhiramat@kernel.org>


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
