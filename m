Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D2F1F6C2E98
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Mar 2023 11:20:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229822AbjCUKUe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Mar 2023 06:20:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230047AbjCUKU1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Mar 2023 06:20:27 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 17E91F961;
        Tue, 21 Mar 2023 03:20:25 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 44FE8AD7;
        Tue, 21 Mar 2023 03:21:08 -0700 (PDT)
Received: from FVFF77S0Q05N (unknown [10.57.54.220])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D14EE3F766;
        Tue, 21 Mar 2023 03:20:22 -0700 (PDT)
Date:   Tue, 21 Mar 2023 10:20:20 +0000
From:   Mark Rutland <mark.rutland@arm.com>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Florent Revest <revest@chromium.org>,
        Jiri Olsa <olsajiri@gmail.com>, linux-kernel@vger.kernel.org,
        linux-trace-kernel@vger.kernel.org, mhiramat@kernel.org,
        ast@kernel.org, daniel@iogearbox.net, kpsingh@kernel.org
Subject: Re: [PATCH 5/7] ftrace: Store direct called addresses in their ops
Message-ID: <ZBmE5Ipp8FwpPqVZ@FVFF77S0Q05N>
References: <20230316173811.1223508-1-revest@chromium.org>
 <20230316173811.1223508-6-revest@chromium.org>
 <ZBcqUoUTZSNyIjLx@krava>
 <20230319135443.1d29db2d@rorschach.local.home>
 <ZBdagJQFA/Z7Phj5@krava>
 <CABRcYmL_JCAGSoX98dZUhGkmek+5iL4kd+F_POJ65GfnZLADcg@mail.gmail.com>
 <20230320173155.55f38adc@gandalf.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230320173155.55f38adc@gandalf.local.home>
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 20, 2023 at 05:31:55PM -0400, Steven Rostedt wrote:
> On Mon, 20 Mar 2023 18:45:08 +0100
> Florent Revest <revest@chromium.org> wrote:
> 
> > On Sun, Mar 19, 2023 at 7:55 PM Jiri Olsa <olsajiri@gmail.com> wrote:
> > >
> > > On Sun, Mar 19, 2023 at 01:54:43PM -0400, Steven Rostedt wrote:  
> > > > On Sun, 19 Mar 2023 16:29:22 +0100
> > > > Jiri Olsa <olsajiri@gmail.com> wrote:
> > > >  
> > > > > > +++ b/kernel/trace/ftrace.c
> > > > > > @@ -2582,9 +2582,8 @@ ftrace_add_rec_direct(unsigned long ip, unsigned long addr,
> > > > > >  static void call_direct_funcs(unsigned long ip, unsigned long pip,
> > > > > >                         struct ftrace_ops *ops, struct ftrace_regs *fregs)
> > > > > >  {
> > > > > > - unsigned long addr;
> > > > > > + unsigned long addr = ops->direct_call;  
> > > > >
> > > > > nice, should it be read with READ_ONCE ?  
> > > >
> > > > Is there a "read tearing" too?  
> > >
> > > don't know, saw the comment in __modify_ftrace_direct and got curious
> > > why it's not in here.. feel free to ignore, I'll look it up
> > >
> > > jirka  
> > 
> > Mhh, that's a good question. Based on my current understanding, it
> > seems that it should have a READ_ONCE, indeed. However, I'd like Mark
> > to confirm/deny this. :)
> > 
> > If this should be a READ_ONCE, I can send a v2 series with this fixed.
> 
> After re-reading: https://lwn.net/Articles/793253/
> 
> I think we should add the READ_ONCE() (also with a comment).

I think so, too.

AFAICT there's nothing that prevents __modify_ftrace_direct() and
call_direct_funcs() from concurrently accessing ftrace_ops::direct_call, so we
need READ_ONCE() in call_direct_funcs() to prevent load tearing and other
issues mentioned in the article linked above.

The existing code has a similar pattern where __modify_ftrace_direct() and
ftrace_find_rec_direct() access ftrace_func_entry::direct concurrently. Do we
want a preparatory patch fixing that for stable?

Thanks,
Mark.
