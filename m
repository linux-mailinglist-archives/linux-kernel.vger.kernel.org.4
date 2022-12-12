Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B5A14649CDA
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Dec 2022 11:44:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232225AbiLLKoR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Dec 2022 05:44:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232098AbiLLKlR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Dec 2022 05:41:17 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 6F4A9F037
        for <linux-kernel@vger.kernel.org>; Mon, 12 Dec 2022 02:36:28 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 952741FB;
        Mon, 12 Dec 2022 02:37:08 -0800 (PST)
Received: from FVFF77S0Q05N (unknown [10.57.40.60])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id AC2723F5A1;
        Mon, 12 Dec 2022 02:36:26 -0800 (PST)
Date:   Mon, 12 Dec 2022 10:36:23 +0000
From:   Mark Rutland <mark.rutland@arm.com>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Ard Biesheuvel <ardb@kernel.org>, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, will@kernel.org,
        samitolvanen@google.com, keescook@chromium.org, mhiramat@kernel.org
Subject: Re: [PATCH] ftrace: Allow WITH_ARGS flavour of graph tracer with
 shadow call stack
Message-ID: <Y5cEJ55sEvs0QsNF@FVFF77S0Q05N>
References: <20221209143402.3332369-1-ardb@kernel.org>
 <Y5NI2TKtGbDKyt53@FVFF77S0Q05N>
 <20221209165139.37d033ee@gandalf.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221209165139.37d033ee@gandalf.local.home>
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 09, 2022 at 04:51:39PM -0500, Steven Rostedt wrote:
> On Fri, 9 Dec 2022 14:40:25 +0000
> Mark Rutland <mark.rutland@arm.com> wrote:
> 
> > On Fri, Dec 09, 2022 at 03:34:02PM +0100, Ard Biesheuvel wrote:
> > > The recent switch on arm64 from DYNAMIC_FTRACE_WITH_REGS to
> > > DYNAMIC_FTRACE_WITH_ARGS failed to take into account that we currently
> > > require the former in order to allow the function graph tracer to be
> > > enabled in combination with shadow call stacks. This means that this is
> > > no longer permitted at all, in spite of the fact that either flavour of
> > > ftrace works perfectly fine in this combination.
> > > 
> > > Given that arm64 is the only arch that implements shadow call stacks in
> > > the first place, let's update the condition to just reflect the arm64
> > > change. When other architectures adopt shadow call stack support, this
> > > can be revisited if needed.
> > > 
> > > Signed-off-by: Ard Biesheuvel <ardb@kernel.org>  
> > 
> > My bad; sorry about this, and thanks for the fix!
> > 
> > Acked-by: Mark Rutland <mark.rutland@arm.com>
> > 
> > We should probably also add:
> > 
> > Fixes: 26299b3f6ba26bfc ("ftrace: arm64: move from REGS to ARGS")
> 
> Actually, I believe it is:
> 
> Fixes: ddc9863e9e90 ("scs: Disable when function graph tracing is enabled")

Ah; it's slightly more subtle since these were on different branches that got
merged. Either's correct in its own branch, and the merge is where things went
wrong.

I think the overall least confusing thing is to bite the bullet and list both
REGS and ARGS, i.e.

  depends on DYNAMIC_FTRACE_WITH_ARGS || DYNAMIC_FTRACE_WITH_REGS || !FUNCTION_GRAPH_TRACER

... and for the fixes tag have:

  Fixes: ddc9863e9e90 ("scs: Disable when function graph tracing is enabled")

That way the commit is correct regardless of the REGS -> ARGS conversion, and
will work if backported independently.

Thanks,
Mark.
