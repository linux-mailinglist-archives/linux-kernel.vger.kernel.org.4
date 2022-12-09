Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6209C648A5E
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Dec 2022 22:51:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229956AbiLIVvs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Dec 2022 16:51:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229468AbiLIVvq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Dec 2022 16:51:46 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 026D3389ED
        for <linux-kernel@vger.kernel.org>; Fri,  9 Dec 2022 13:51:46 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 67EF2B82918
        for <linux-kernel@vger.kernel.org>; Fri,  9 Dec 2022 21:51:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 29DA3C433EF;
        Fri,  9 Dec 2022 21:51:42 +0000 (UTC)
Date:   Fri, 9 Dec 2022 16:51:39 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Mark Rutland <mark.rutland@arm.com>
Cc:     Ard Biesheuvel <ardb@kernel.org>, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, will@kernel.org,
        samitolvanen@google.com, keescook@chromium.org, mhiramat@kernel.org
Subject: Re: [PATCH] ftrace: Allow WITH_ARGS flavour of graph tracer with
 shadow call stack
Message-ID: <20221209165139.37d033ee@gandalf.local.home>
In-Reply-To: <Y5NI2TKtGbDKyt53@FVFF77S0Q05N>
References: <20221209143402.3332369-1-ardb@kernel.org>
        <Y5NI2TKtGbDKyt53@FVFF77S0Q05N>
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

On Fri, 9 Dec 2022 14:40:25 +0000
Mark Rutland <mark.rutland@arm.com> wrote:

> On Fri, Dec 09, 2022 at 03:34:02PM +0100, Ard Biesheuvel wrote:
> > The recent switch on arm64 from DYNAMIC_FTRACE_WITH_REGS to
> > DYNAMIC_FTRACE_WITH_ARGS failed to take into account that we currently
> > require the former in order to allow the function graph tracer to be
> > enabled in combination with shadow call stacks. This means that this is
> > no longer permitted at all, in spite of the fact that either flavour of
> > ftrace works perfectly fine in this combination.
> > 
> > Given that arm64 is the only arch that implements shadow call stacks in
> > the first place, let's update the condition to just reflect the arm64
> > change. When other architectures adopt shadow call stack support, this
> > can be revisited if needed.
> > 
> > Signed-off-by: Ard Biesheuvel <ardb@kernel.org>  
> 
> My bad; sorry about this, and thanks for the fix!
> 
> Acked-by: Mark Rutland <mark.rutland@arm.com>
> 
> We should probably also add:
> 
> Fixes: 26299b3f6ba26bfc ("ftrace: arm64: move from REGS to ARGS")

Actually, I believe it is:

Fixes: ddc9863e9e90 ("scs: Disable when function graph tracing is enabled")

As according to the comments, scs is broken with function graph unless
function graph is using the ftrace mechanism. And that is only true if
WITH_ARGS is set, not REGS.

Acked-by: Steven Rostedt (Google) <rostedt@goodmis.org>

-- Steve
