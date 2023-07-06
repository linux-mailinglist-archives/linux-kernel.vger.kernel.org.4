Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 97B9274A195
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jul 2023 17:53:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230290AbjGFPxU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Jul 2023 11:53:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232555AbjGFPxS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jul 2023 11:53:18 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 383CF1FFD;
        Thu,  6 Jul 2023 08:52:57 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id F245B60CF4;
        Thu,  6 Jul 2023 15:52:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E3372C433C9;
        Thu,  6 Jul 2023 15:52:20 +0000 (UTC)
Date:   Thu, 6 Jul 2023 11:52:16 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
Cc:     Dan Carpenter <dan.carpenter@linaro.org>,
        linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] tracing/probes: Delete dead code in
 trace_eprobe_tp_update_arg()
Message-ID: <20230706115216.72997ad5@gandalf.local.home>
In-Reply-To: <20230702080238.1379c4fe777bf22e5b146af5@kernel.org>
References: <f657e0c7-46c3-4e8f-a472-35ec98229660@moroto.mountain>
        <20230702080238.1379c4fe777bf22e5b146af5@kernel.org>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2 Jul 2023 08:02:38 +0900
Masami Hiramatsu (Google) <mhiramat@kernel.org> wrote:

> On Mon, 26 Jun 2023 16:35:06 +0300
> Dan Carpenter <dan.carpenter@linaro.org> wrote:
> 
> > This code was recently refactored and now the "ret" variable is always
> > zero.  Delete the check for non-zero.
> >   

Yep! The code use to be:

	if (ep->tp.args[i].code->op == FETCH_OP_TP_ARG) {
		ret = trace_eprobe_tp_arg_update(ep, i);
		if (ret)
			trace_probe_log_err(0, BAD_ATTACH_ARG);
	}

	/* Handle symbols "@" */
	if (!ret)
		ret = traceprobe_update_arg(&ep->tp.args[i]);

	return ret;
}

and is now:

        ret = traceprobe_parse_probe_arg(&ep->tp, i, argv[i], &ctx);
        if (ret)
                return ret;

        /* Handle symbols "@" */
        if (!ret)
                ret = traceprobe_update_arg(&ep->tp.args[i]);

        return ret;
}

so that last ret check is redundant.

> 
> Good catch!
> 
> Acked-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>

Reviewed-by: Steven Rostedt (Google) <rostedt@goodmis.org>

> 
> > Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
> > ---
> > This code was changed in 1b8b0cd754cd (tracing/probes: Move event
> > parameter fetching code to common parser)  
> 
> OK, this will be picked to the 6.5 fix.

Thanks Masami and Dan,

-- Steve

> 
> Thank you!
> 
> > 
> >  kernel/trace/trace_eprobe.c | 5 +----
> >  1 file changed, 1 insertion(+), 4 deletions(-)
> > 
> > diff --git a/kernel/trace/trace_eprobe.c b/kernel/trace/trace_eprobe.c
> > index cb0077ba2b49..b5181d690b4d 100644
> > --- a/kernel/trace/trace_eprobe.c
> > +++ b/kernel/trace/trace_eprobe.c
> > @@ -797,10 +797,7 @@ static int trace_eprobe_tp_update_arg(struct trace_eprobe *ep, const char *argv[
> >  		return ret;
> >  
> >  	/* Handle symbols "@" */
> > -	if (!ret)
> > -		ret = traceprobe_update_arg(&ep->tp.args[i]);
> > -
> > -	return ret;
> > +	return traceprobe_update_arg(&ep->tp.args[i]);
> >  }
> >  
> >  static int trace_eprobe_parse_filter(struct trace_eprobe *ep, int argc, const char *argv[])
> > -- 
> > 2.39.2
> >   
> 
> 

