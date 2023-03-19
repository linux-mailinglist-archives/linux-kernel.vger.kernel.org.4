Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4DB7B6C03A3
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Mar 2023 18:54:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229735AbjCSRy4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Mar 2023 13:54:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229610AbjCSRyw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Mar 2023 13:54:52 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EAC1D173F;
        Sun, 19 Mar 2023 10:54:49 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id A4759B80AB6;
        Sun, 19 Mar 2023 17:54:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2F732C433EF;
        Sun, 19 Mar 2023 17:54:46 +0000 (UTC)
Date:   Sun, 19 Mar 2023 13:54:43 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Jiri Olsa <olsajiri@gmail.com>
Cc:     Florent Revest <revest@chromium.org>, linux-kernel@vger.kernel.org,
        linux-trace-kernel@vger.kernel.org, mhiramat@kernel.org,
        mark.rutland@arm.com, ast@kernel.org, daniel@iogearbox.net,
        kpsingh@kernel.org
Subject: Re: [PATCH 5/7] ftrace: Store direct called addresses in their ops
Message-ID: <20230319135443.1d29db2d@rorschach.local.home>
In-Reply-To: <ZBcqUoUTZSNyIjLx@krava>
References: <20230316173811.1223508-1-revest@chromium.org>
        <20230316173811.1223508-6-revest@chromium.org>
        <ZBcqUoUTZSNyIjLx@krava>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 19 Mar 2023 16:29:22 +0100
Jiri Olsa <olsajiri@gmail.com> wrote:

> > +++ b/kernel/trace/ftrace.c
> > @@ -2582,9 +2582,8 @@ ftrace_add_rec_direct(unsigned long ip, unsigned long addr,
> >  static void call_direct_funcs(unsigned long ip, unsigned long pip,
> >  			      struct ftrace_ops *ops, struct ftrace_regs *fregs)
> >  {
> > -	unsigned long addr;
> > +	unsigned long addr = ops->direct_call;  
> 
> nice, should it be read with READ_ONCE ?

Is there a "read tearing" too?

-- Steve

> 
> jirka
> 
> >  
> > -	addr = ftrace_find_rec_direct(ip);
> >  	if (!addr)
> >  		return;
> >  
> > @@ -5380,6 +5379,7 @@ int register_ftrace_direct(struct ftrace_ops *ops, unsigned long addr)
> >  	ops->func = call_direct_funcs;
> >  	ops->flags = MULTI_FLAGS;
> >  	ops->trampoline = FTRACE_REGS_ADDR;
> > +	ops->direct_call = addr;
> >  
> >  	err = register_ftrace_function_nolock(ops);
> >  
> > @@ -5454,6 +5454,7 @@ __modify_ftrace_direct(struct ftrace_ops *ops, unsigned long addr)
> >  	/* Enable the tmp_ops to have the same functions as the direct ops */
> >  	ftrace_ops_init(&tmp_ops);
> >  	tmp_ops.func_hash = ops->func_hash;
> > +	tmp_ops.direct_call = addr;
> >  
> >  	err = register_ftrace_function_nolock(&tmp_ops);
> >  	if (err)
> > @@ -5475,6 +5476,8 @@ __modify_ftrace_direct(struct ftrace_ops *ops, unsigned long addr)
> >  			entry->direct = addr;
> >  		}
> >  	}
> > +	/* Prevent store tearing if a trampoline concurrently accesses the value */
> > +	WRITE_ONCE(ops->direct_call, addr);
> >  
> >  	mutex_unlock(&ftrace_lock);
