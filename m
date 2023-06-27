Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A60D37400CB
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Jun 2023 18:23:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230249AbjF0QXM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Jun 2023 12:23:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229680AbjF0QXK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Jun 2023 12:23:10 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A2CE1FF0;
        Tue, 27 Jun 2023 09:23:09 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2E743611D4;
        Tue, 27 Jun 2023 16:23:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3CD1BC433C0;
        Tue, 27 Jun 2023 16:23:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1687882988;
        bh=X7C7c+mN0VpeHK+Ecm9oxh43Gqr/gyJV3O7Y5jth8xA=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=tSPi7/uDtxqfHqRTF6IbAWQW8/3OiYU+wZWpSb0uiTAc+vMsUawt2XKn4Hp6EbklJ
         1okL5JcYassR84iRuRkwC741bSR8W25HoTWBcUYgYoaMEhnLGwEF22tQNhCFX8bSHF
         FjsX4JlAPveulCI5S4GXjzrrsBkedfdH34gXrFSvJrR804Tbmmg4tsOvLO87kpEZaN
         ui0iclTiL4bRAqDa+J1BW5LcfIBPbRKAy9vQPLDtBdh+v2cDXZgRKYY2bjcuSkFGty
         ZULNPOykMMaMTMMRC0jglcUoRQ0uZuV7P0O1PfLLLqA1kHqL9qZeTuY+jsugYkYhMJ
         n7YOKmDVk2t0A==
Date:   Wed, 28 Jun 2023 01:23:05 +0900
From:   Masami Hiramatsu (Google) <mhiramat@kernel.org>
To:     Masami Hiramatsu (Google) <mhiramat@kernel.org>
Cc:     Jiri Olsa <jolsa@kernel.org>, Steven Rostedt <rostedt@goodmis.org>,
        Mark Rutland <mark.rutland@arm.com>,
        lkml <linux-kernel@vger.kernel.org>,
        linux-trace-kernel@vger.kernel.org, bpf@vger.kernel.org
Subject: Re: [PATCH] fprobe: Release rethook after the ftrace_ops is
 unregistered
Message-Id: <20230628012305.978e34d44f1a53fe20327fde@kernel.org>
In-Reply-To: <20230627233306.b9b04d75f86944466f6534c2@kernel.org>
References: <20230615115236.3476617-1-jolsa@kernel.org>
        <20230627233306.b9b04d75f86944466f6534c2@kernel.org>
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

On Tue, 27 Jun 2023 23:33:06 +0900
Masami Hiramatsu (Google) <mhiramat@kernel.org> wrote:

> > diff --git a/kernel/trace/fprobe.c b/kernel/trace/fprobe.c
> > index 18d36842faf5..0121e8c0d54e 100644
> > --- a/kernel/trace/fprobe.c
> > +++ b/kernel/trace/fprobe.c
> > @@ -364,19 +364,13 @@ int unregister_fprobe(struct fprobe *fp)
> >  		    fp->ops.saved_func != fprobe_kprobe_handler))
> >  		return -EINVAL;
> >  
> > -	/*
> > -	 * rethook_free() starts disabling the rethook, but the rethook handlers
> > -	 * may be running on other processors at this point. To make sure that all
> > -	 * current running handlers are finished, call unregister_ftrace_function()
> > -	 * after this.
> > -	 */

Oh, wait, here is an important comment. If a rethook handler is still running
(because it hooks target function exit), returning from unregister_fprobe()
right after rethook_free() may cause another issue.

rethook_free() clears 'rh->handler', so after calling rethook_free(), we
can ensure no NEW rethook handler (means fprobe_exit_handler()) is called.
However, it doesn't mean there is no current running fprobe_exit_handler().
Thus if unregister_fprobe() caller releases the 'fp' right after returning
from unregister_fprobe(), current running fprobe_exit_handler() can access
'fp' (use-after-free).

Thus we need to add below code with this patch;
	/*
	 * The rethook handlers may be running on other processors at this point.
	 * To make sure that all current running handlers are finished, disable
	 * rethook by clearing handler and call unregister_ftrace_function()
	 * to ensure all running rethook handlers exit. And call rethook_free().
	 */
	if (fp->rethook)
		WRITE_ONCE(fp->rethook->handler, NULL);

> > -	if (fp->rethook)
> > -		rethook_free(fp->rethook);
> > -
> >  	ret = unregister_ftrace_function(&fp->ops);
> >  	if (ret < 0)
> >  		return ret;
> >  
> > +	if (fp->rethook)
> > +		rethook_free(fp->rethook);
> > +
> >  	ftrace_free_filter(&fp->ops);
> >  
> >  	return ret;

Thank you,

> > -- 
> > 2.40.1
> > 
> 
> 
> -- 
> Masami Hiramatsu (Google) <mhiramat@kernel.org>


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
