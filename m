Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB57A744E02
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Jul 2023 15:47:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229738AbjGBNrJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 2 Jul 2023 09:47:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229604AbjGBNq7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Jul 2023 09:46:59 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CBD59E55;
        Sun,  2 Jul 2023 06:46:58 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3D74F60C25;
        Sun,  2 Jul 2023 13:46:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 98C73C433CB;
        Sun,  2 Jul 2023 13:46:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1688305617;
        bh=32sB5x+MX8ZMp2xOTBFmVGZwfLZCYs96ggH76CMoVQM=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=Itaz14xRH2JlcNguM5VPnqwdwlbBTmM5nZ/LDCGYL25YN1g6NkydyRA374wbwex/U
         AQ0aW58Lb0RqJXqv/Iu5/P6yji6adLGzWVUH3Gg9j+iuY6bM+uimzVw75ldDfMlwFN
         T4y4X3/XUsc3lFcA7qs0BXluWB+LTQZsfz+LlWVctXlaTmcBMyPmRMibjhN4Tpd3WR
         cdKDDSq/yyNTuguy7/mE6ikMIhKR3KFG8PJ7wWcXtNyRqz7rTvK/XhTqDLMNraqKs5
         HD/FC7L85HxpQzuaqhpkhDC3PFwmq+ghhkcUETuGSdX87/VJ0xVoeTsljMIy4cGIG/
         uVqOPtjImKVyQ==
Date:   Sun, 2 Jul 2023 22:46:54 +0900
From:   Masami Hiramatsu (Google) <mhiramat@kernel.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Dan Carpenter <dan.carpenter@linaro.org>,
        linux-trace-kernel@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/2] tracing/probes: Fix to exit fetching if an error is
 detected
Message-Id: <20230702224654.154e491598712ed0f9504430@kernel.org>
In-Reply-To: <20230701211617.401fbbd6@rorschach.local.home>
References: <8819b154-2ba1-43c3-98a2-cbde20892023@moroto.mountain>
        <168804802668.2028538.4634073314317984220.stgit@mhiramat.roam.corp.google.com>
        <20230701211617.401fbbd6@rorschach.local.home>
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

On Sat, 1 Jul 2023 21:16:17 -0400
Steven Rostedt <rostedt@goodmis.org> wrote:

> On Thu, 29 Jun 2023 23:13:46 +0900
> "Masami Hiramatsu (Google)" <mhiramat@kernel.org> wrote:
> 
> > From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> > 
> > Fix to exit fetching arguments if an error is detected when storing
> > strings. Without this fix, if an array is specified with string types
> > it may point wrong address to store the data.
> 
>   "it may store that data at the wrong address".

Good catch! Yes, while updating the data location, the remaining length
and offset becomes wrong and next array element (string) will be stored
in wrong memory address.

> 
> > 
> > Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
> > Closes: https://lore.kernel.org/all/8819b154-2ba1-43c3-98a2-cbde20892023@moroto.mountain/
> > Fixes: 9b960a38835f ("tracing: probeevent: Unify fetch_insn processing common part")
> > Cc: stable@vger.kernel.org
> > Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> > ---
> >  kernel/trace/trace_probe_tmpl.h |    2 ++
> >  1 file changed, 2 insertions(+)
> > 
> > diff --git a/kernel/trace/trace_probe_tmpl.h b/kernel/trace/trace_probe_tmpl.h
> > index 4735c5cb76fa..d6f2bf69f9bc 100644
> > --- a/kernel/trace/trace_probe_tmpl.h
> > +++ b/kernel/trace/trace_probe_tmpl.h
> > @@ -193,6 +193,8 @@ process_fetch_insn_bottom(struct fetch_insn *code, unsigned long val,
> >  	default:
> >  		return -EILSEQ;
> >  	}
> > +	if (ret < 0)
> > +		return ret;
> 
> Reviewed-by: Steven Rostedt (Google) <rostedt@goodmis.org>

Thanks!

> 
> -- Steve
> 
> >  	code++;
> >  
> >  	/* 4th stage: modify stored value if needed */
> 


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
