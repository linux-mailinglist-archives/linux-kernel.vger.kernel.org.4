Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 04F9364B44A
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Dec 2022 12:36:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235174AbiLMLgd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Dec 2022 06:36:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235122AbiLMLgO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Dec 2022 06:36:14 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5AE491B9C7
        for <linux-kernel@vger.kernel.org>; Tue, 13 Dec 2022 03:36:13 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 13FDCB81189
        for <linux-kernel@vger.kernel.org>; Tue, 13 Dec 2022 11:36:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3A31EC433D2;
        Tue, 13 Dec 2022 11:36:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1670931370;
        bh=EEs6Mg/sfionQP7S0xqd9qRSjYMzb50AzeLFtoibb38=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Y4Uia4vz6ZrDjEJndsHjuxlMYImiRUf2YysatZDeEeJfhcMBwgAnMFDBBHj3GDiGI
         yPmaELiRVXq9iYDQf/Sfrz7RXKiOzJTMWer7onCopp/XCoLuBbXk6BBStzdn9qAqd5
         C5f6tVBXNST0Q/eYq5aJGrOd+x/uDHxtoT2LGbxs+fceIASjTU+XxK0iB+2+RQd3H6
         XTSjcK4/L8+P1+rVgLJRA3pyVthAMDOaK2DjZoyHPRTJ/0QJbvPXJNtwPwvIt82yYt
         Zi56tJa6/+/cAwYC45RtbAeBEvNNWOnMEowSk8stcRwRGXCSVrLBKpDfcf3I1Mwbg1
         9Pbcvrluuw4pQ==
Date:   Tue, 13 Dec 2022 11:36:05 +0000
From:   Will Deacon <will@kernel.org>
To:     Mark Rutland <mark.rutland@arm.com>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        Ard Biesheuvel <ardb@kernel.org>, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, samitolvanen@google.com,
        keescook@chromium.org, mhiramat@kernel.org
Subject: Re: [PATCH] ftrace: Allow WITH_ARGS flavour of graph tracer with
 shadow call stack
Message-ID: <20221213113604.GA5719@willie-the-truck>
References: <20221209143402.3332369-1-ardb@kernel.org>
 <Y5NI2TKtGbDKyt53@FVFF77S0Q05N>
 <20221209165139.37d033ee@gandalf.local.home>
 <Y5cEJ55sEvs0QsNF@FVFF77S0Q05N>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y5cEJ55sEvs0QsNF@FVFF77S0Q05N>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 12, 2022 at 10:36:23AM +0000, Mark Rutland wrote:
> On Fri, Dec 09, 2022 at 04:51:39PM -0500, Steven Rostedt wrote:
> > On Fri, 9 Dec 2022 14:40:25 +0000
> > Mark Rutland <mark.rutland@arm.com> wrote:
> > 
> > > On Fri, Dec 09, 2022 at 03:34:02PM +0100, Ard Biesheuvel wrote:
> > > > The recent switch on arm64 from DYNAMIC_FTRACE_WITH_REGS to
> > > > DYNAMIC_FTRACE_WITH_ARGS failed to take into account that we currently
> > > > require the former in order to allow the function graph tracer to be
> > > > enabled in combination with shadow call stacks. This means that this is
> > > > no longer permitted at all, in spite of the fact that either flavour of
> > > > ftrace works perfectly fine in this combination.
> > > > 
> > > > Given that arm64 is the only arch that implements shadow call stacks in
> > > > the first place, let's update the condition to just reflect the arm64
> > > > change. When other architectures adopt shadow call stack support, this
> > > > can be revisited if needed.
> > > > 
> > > > Signed-off-by: Ard Biesheuvel <ardb@kernel.org>  
> > > 
> > > My bad; sorry about this, and thanks for the fix!
> > > 
> > > Acked-by: Mark Rutland <mark.rutland@arm.com>
> > > 
> > > We should probably also add:
> > > 
> > > Fixes: 26299b3f6ba26bfc ("ftrace: arm64: move from REGS to ARGS")
> > 
> > Actually, I believe it is:
> > 
> > Fixes: ddc9863e9e90 ("scs: Disable when function graph tracing is enabled")
> 
> Ah; it's slightly more subtle since these were on different branches that got
> merged. Either's correct in its own branch, and the merge is where things went
> wrong.
> 
> I think the overall least confusing thing is to bite the bullet and list both
> REGS and ARGS, i.e.
> 
>   depends on DYNAMIC_FTRACE_WITH_ARGS || DYNAMIC_FTRACE_WITH_REGS || !FUNCTION_GRAPH_TRACER
> 
> ... and for the fixes tag have:
> 
>   Fixes: ddc9863e9e90 ("scs: Disable when function graph tracing is enabled")
> 
> That way the commit is correct regardless of the REGS -> ARGS conversion, and
> will work if backported independently.

Ard -- please can you respin as per Mark's suggestion above? I can then send
it as a fix later this week.

Cheers,

Will
