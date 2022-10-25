Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F2CC60CF34
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Oct 2022 16:38:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232005AbiJYOhp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Oct 2022 10:37:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233130AbiJYOhB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Oct 2022 10:37:01 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A558A16DC34;
        Tue, 25 Oct 2022 07:36:46 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id EEE97CE1D6F;
        Tue, 25 Oct 2022 14:36:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DD88FC433D6;
        Tue, 25 Oct 2022 14:36:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666708603;
        bh=Ry1myEvEooHC4WberZz2kmf54A7z45QuArv22A/8GmM=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=jPPnQ877LrhTPGx33Vbt9czG8fAS1PvLkma7344IC5nwRePxJH1NOYf0ASL7oYHKJ
         XpDzRvlO+pzc0lBl1XBfHtowJP2Ip1/DifWSgrNEvX4puvb2IK3wxn2wHkYDKdOaqE
         +iAi8Wezo94UojESzfs+Pmu8Vqij/PIvlyks/D8rJYhX3JKPBhRGEFdd5EStniFxpY
         NP4gf7neq+RYS8i5zwn3z71zmz+bELFufgCeWXUjbwroSk97X9g022a3sSL+FoRFth
         IZD/+j7n1mtgzG4AULnF66TE2EIunkuIFpA+3vcVhyc3usN3JG9U5050KO828brlF6
         XAqIykZmp/CEQ==
Date:   Tue, 25 Oct 2022 23:36:39 +0900
From:   Masami Hiramatsu (Google) <mhiramat@kernel.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Linux Trace Kernel <linux-trace-kernel@vger.kernel.org>,
        Jiri Olsa <jolsa@kernel.org>
Subject: Re: [PATCH] tracing/fprobe: Fix to check whether fprobe is
 registered correctly
Message-Id: <20221025233639.dcae9874bb27a3a7a9833300@kernel.org>
In-Reply-To: <20221024102230.6b02c978@gandalf.local.home>
References: <166653477373.988423.13256491425983587550.stgit@mhiramat.roam.corp.google.com>
        <20221024102230.6b02c978@gandalf.local.home>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 24 Oct 2022 10:22:30 -0400
Steven Rostedt <rostedt@goodmis.org> wrote:

> On Sun, 23 Oct 2022 23:19:33 +0900
> "Masami Hiramatsu (Google)" <mhiramat@kernel.org> wrote:
> 
> > From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> > 
> > Since commit ab51e15d535e ("fprobe: Introduce FPROBE_FL_KPROBE_SHARED flag
> > for fprobe") introduced fprobe_kprobe_handler() for fprobe::f_op::func,
> > unregister_fprobe() fails to unregister the registered if user specifies
> > FPROBE_FL_KPROBE_SHARED flag.
> > To check it correctly, it should confirm the fprobe::f_op::func is either
> > fprobe_handler() or fprobe_kprobe_handler().
> > 
> > Fixes: ab51e15d535e ("fprobe: Introduce FPROBE_FL_KPROBE_SHARED flag for fprobe")
> > Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> > ---
> >  kernel/trace/fprobe.c |    3 ++-
> >  1 file changed, 2 insertions(+), 1 deletion(-)
> > 
> > diff --git a/kernel/trace/fprobe.c b/kernel/trace/fprobe.c
> > index aac63ca9c3d1..9000d8ea6274 100644
> > --- a/kernel/trace/fprobe.c
> > +++ b/kernel/trace/fprobe.c
> > @@ -301,7 +301,8 @@ int unregister_fprobe(struct fprobe *fp)
> >  {
> >  	int ret;
> >  
> > -	if (!fp || fp->ops.func != fprobe_handler)
> > +	if (!fp || (fp->ops.func != fprobe_handler &&
> > +		    fp->ops.func != fprobe_kprobe_handler))
> >  		return -EINVAL;
> >  
> >  	/*
> 
> Should we make this more paranoid?
> 
> 	if (!fp ||
> 	    (fprobe_shared_with_kprobes(fp) && fp->ops.func != fprobe_kprobe_handler) ||
> 	    (!fprobe_shared_with_kprobes(fp) && fp->ops.func != fprobe_handler))
> 
> Or is that over-kill?

Yeah, I think it is over-kill since this is just for a safety check, like
checking NULL in free(). Or, are there any way to check the ftrace_ops is
registered?

Thank you,

> 
> -- Steve


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
