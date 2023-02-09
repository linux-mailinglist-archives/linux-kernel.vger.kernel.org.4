Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2FCB5690B9C
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Feb 2023 15:23:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230362AbjBIOXN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Feb 2023 09:23:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229669AbjBIOXL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Feb 2023 09:23:11 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01225BBAA;
        Thu,  9 Feb 2023 06:23:10 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9089E61A78;
        Thu,  9 Feb 2023 14:23:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 65144C433EF;
        Thu,  9 Feb 2023 14:23:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1675952590;
        bh=7t9V1Y+e3HxImDhyqdNp5TwDhgi6y9vhqTcKBEh1YbA=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=QX6JkWaeEaJI9KWIxbQYTrr92t6Zq09eCHJcVEbXl6kDOxyQgsn6/3lzHVts99IAV
         +H/oP5Z0Yu7zubrldaY7KwZ63mKQ3J2O6zW2JwJoadHt+spESwOGEmbSBrrVjPBBqu
         hljJPquI9mZX15U/Icfj+eXGf9hs4yflSmrOvEObMGUjDJGQh3s8hG2lgnjCyx1p9/
         SBSqZzNHb59hh3vTUBjEWPVfNi6mGYmCkTasj+Xn914ywjbC6DMPKsN8bLrFNEoclu
         kATcXPYeaVIWcNDC5b/5tDq2ElV0MNqHgaBBybsQE90OUXSOzqhfvs5bbOtOAIptxW
         TZCTYw6RQVNtg==
Date:   Thu, 9 Feb 2023 23:23:05 +0900
From:   Masami Hiramatsu (Google) <mhiramat@kernel.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux Trace Kernel <linux-trace-kernel@vger.kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Shuah Khan <shuah@kernel.org>,
        Shuah Khan <skhan@linuxfoundation.org>
Subject: Re: [PATCH] tracing/selftests: Ignore __pfx_ symbols in kprobe test
Message-Id: <20230209232305.672dd0249e0db41552b28763@kernel.org>
In-Reply-To: <Y+PkVD1+myADYns+@hirez.programming.kicks-ass.net>
References: <20230207135147.5ce618d6@gandalf.local.home>
        <20230207135402.38f73bb6@gandalf.local.home>
        <Y+PkVD1+myADYns+@hirez.programming.kicks-ass.net>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-8.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 8 Feb 2023 19:05:08 +0100
Peter Zijlstra <peterz@infradead.org> wrote:

> On Tue, Feb 07, 2023 at 01:54:02PM -0500, Steven Rostedt wrote:
> > On Tue, 7 Feb 2023 13:51:47 -0500
> > Steven Rostedt <rostedt@goodmis.org> wrote:
> > 
> > > From: "Steven Rostedt (Google)" <rostedt@goodmis.org>
> > > 
> > > The kprobe probepoint.tc test started failing because of the added __pfx_
> > > symbols that were added because of -fpatchable-function-entry=X,Y causing
> > > unwinders to see them as part of the previous functions. But kprobes can
> > > not be added on top of them. The selftest looks for tracefs_create_dir and
> > > picks it and the previous and following functions to add at their address.
> > > This caused it to include __pfx_tracefs_create_dir which is invalid to
> > > attach a kprobe to and caused the test to fail.
> > > 
> > > Fixes: 9f2899fe36a62 ("objtool: Add option to generate prefix symbols")
> > > Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
> > 
> > This is assuming that kprobes can not be added on top of these. But another
> > solution could be to have kprobes just pick the function the __pfx_ is for.
> > Would that be a better solution?
> 
> Simply refusing them is simplest. I don't see a compelling reason to
> make this complicated.

Yeah, and __pfx_ symbols has some "range", that means it is hard to translate
the probe address if user specify __pfx_*+offset.

BTW, currently kprobe event rejects this __pfx_ symbols because it is notrace
symbols, thus we can trace it if CONFIG_KPROBE_EVENTS_ON_NOTRACE=y.
But I guess it should not probe that place always because it should never
executed right?

Thank you,


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
