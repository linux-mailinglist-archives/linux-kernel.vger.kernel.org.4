Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 741D474A7FF
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jul 2023 02:16:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232177AbjGGAPW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Jul 2023 20:15:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231688AbjGGAPV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jul 2023 20:15:21 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6232F19A7;
        Thu,  6 Jul 2023 17:15:19 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id AA76A60D2E;
        Fri,  7 Jul 2023 00:15:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 70709C433C9;
        Fri,  7 Jul 2023 00:15:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1688688918;
        bh=rpSZSrfeOyTrCZMQuvLO9nZWV0sJ3Q8D+Q+vMcmRWXY=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=b+rbgkYxKL7z1snC8uyDjlKk+JX84O7lk+YCZ4Hfa0ZcCJ6wNG2CTfjs7IvfR8GuC
         fGdHH7MK+d5EOxOXvgIHu3SbMBzmF3EEENg2L7ABq40hJUCD+gI9TIRi9fniT0deMG
         CG6R8iodZkbMPiZeGvCi55/oeKnGJ9oRLz4XF87mqkzLO7ZPcRZ5PKDdhhZ0PzoscE
         rI4pdRE6ZR1sk0P+xNfUfUIpBGomQ3P9ZYuuO2IWmpzL182pu+YYTnVJoiRcfxAi55
         0FQPANq2Joxjk8OIZDKcZM2D7WgveuTSXmRlrswHAQ0G0yKFDmX7BxfV1PY80Nwviu
         vDCEsCAU1FFnw==
Date:   Fri, 7 Jul 2023 09:15:13 +0900
From:   Masami Hiramatsu (Google) <mhiramat@kernel.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Ze Gao <zegao2021@gmail.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
        Ze Gao <zegao@tencent.com>, Yafang <laoar.shao@gmail.com>
Subject: Re: [PATCH v2] fprobe: add unlock to match a succeeded
 ftrace_test_recursion_trylock
Message-Id: <20230707091513.b0bbdf38dd276e054e293185@kernel.org>
In-Reply-To: <20230706120916.3c6abf15@gandalf.local.home>
References: <20230703092336.268371-1-zegao@tencent.com>
        <20230706120916.3c6abf15@gandalf.local.home>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 6 Jul 2023 12:09:16 -0400
Steven Rostedt <rostedt@goodmis.org> wrote:

> On Mon,  3 Jul 2023 17:23:36 +0800
> Ze Gao <zegao2021@gmail.com> wrote:
> 
> > Unlock ftrace recursion lock when fprobe_kprobe_handler() is failed
> > because of some running kprobe.
> > 
> > Fixes: 3cc4e2c5fbae ("fprobe: make fprobe_kprobe_handler recursion free")
> > Reported-by: Yafang <laoar.shao@gmail.com>
> > Closes: https://lore.kernel.org/linux-trace-kernel/CALOAHbC6UpfFOOibdDiC7xFc5YFUgZnk3MZ=3Ny6we=AcrNbew@mail.gmail.com/
> > Signed-off-by: Ze Gao <zegao@tencent.com>
> 
> Reviewed-by: Steven Rostedt (Google) <rostedt@goodmis.org>
> 
> > ---
> >  kernel/trace/fprobe.c | 4 +++-
> >  1 file changed, 3 insertions(+), 1 deletion(-)
> > 
> > diff --git a/kernel/trace/fprobe.c b/kernel/trace/fprobe.c
> > index 18d36842faf5..93b3e361bb97 100644
> > --- a/kernel/trace/fprobe.c
> > +++ b/kernel/trace/fprobe.c
> > @@ -102,12 +102,14 @@ static void fprobe_kprobe_handler(unsigned long ip, unsigned long parent_ip,
> >  
> >  	if (unlikely(kprobe_running())) {
> 
> Off topic for this patch, but Masami, what's the purpose of not calling the
> fprobe when a kprobe is running? Does that mean it has probed another kprobe?

This is for the user who is sharing their handler with kprobes (like eBPF),
which may expect that the handler is not called recursively. (e.g. an interrupt
happens while kprobe handler is running and that interrupt calls a function
which is fprobed)

> 
> Probably could add a comment here to explain the issue.

OK, it is also documented in Documentation/trace/fprobe.rst, but it is better
to comment in the code too.

Thanks,

> 
> -- Steve
> 
> 
> >  		fp->nmissed++;
> > -		return;
> > +		goto recursion_unlock;
> >  	}
> >  
> >  	kprobe_busy_begin();
> >  	__fprobe_handler(ip, parent_ip, ops, fregs);
> >  	kprobe_busy_end();
> > +
> > +recursion_unlock:
> >  	ftrace_test_recursion_unlock(bit);
> >  }
> >  
> 


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
