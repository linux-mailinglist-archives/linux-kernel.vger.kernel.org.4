Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8CBAC64FD3A
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Dec 2022 01:29:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229926AbiLRA3J (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 17 Dec 2022 19:29:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229611AbiLRA3F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Dec 2022 19:29:05 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC388E0FD;
        Sat, 17 Dec 2022 16:29:04 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7C14560C6C;
        Sun, 18 Dec 2022 00:29:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C680DC433D2;
        Sun, 18 Dec 2022 00:29:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1671323343;
        bh=dJ0VIVPcXPTWNRisC8SY/1kJmpgI3E9N+0Wq11gx1M8=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=Uuc/HGDIjHjvFHYFUEQkm3NcIRlpnps/eBFBe2PqLPYjvZX52qToEO5/Qz2lCMyn1
         TRSTquqmmSLwPNQO9wN++M+aIwxLifU8U/RDOofHa11hssb74mCFN90hWiibWqYLMf
         0gEE4W3VlT4LrVwTk13sirIE/yum6IHFvCd/rvVREJXwDClo1ovE4azklFTW4gC+L0
         nkROYDCTfFjfuZcdJ4JcA4Tm0klmqIixMkXmdVSW5An3yiS5J9khsG9a+CJJcO9Jv2
         TYnB17gZSBHvcJ/g+2ROMIBOHQGJa62Kg+ZLJT7e7PTsVIaVIwOF8oK2sEYVEyJahw
         vIKrIghTW3fQg==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 5E4CA5C0744; Sat, 17 Dec 2022 16:29:03 -0800 (PST)
Date:   Sat, 17 Dec 2022 16:29:03 -0800
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Masami Hiramatsu <mhiramat@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux Trace Kernel <linux-trace-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: [PATCH] tracing: Do not synchronize freeing of trigger filter on
 boot up
Message-ID: <20221218002903.GM4001@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <20221215100241.73a30da8@gandalf.local.home>
 <20221215170256.GG4001@paulmck-ThinkPad-P17-Gen-1>
 <20221215135102.556ee076@gandalf.local.home>
 <20221215190158.GK4001@paulmck-ThinkPad-P17-Gen-1>
 <20221215173913.5432bfbf@gandalf.local.home>
 <20221215231027.GS4001@paulmck-ThinkPad-P17-Gen-1>
 <20221215184202.7ebb3055@gandalf.local.home>
 <20221216010118.GU4001@paulmck-ThinkPad-P17-Gen-1>
 <20221216044022.GA2467686@paulmck-ThinkPad-P17-Gen-1>
 <20221216060810.4e541bc4@gandalf.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221216060810.4e541bc4@gandalf.local.home>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 16, 2022 at 06:08:10AM -0500, Steven Rostedt wrote:
> On Thu, 15 Dec 2022 20:40:22 -0800
> "Paul E. McKenney" <paulmck@kernel.org> wrote:
> 
> > On Thu, Dec 15, 2022 at 05:01:18PM -0800, Paul E. McKenney wrote:
> > > On Thu, Dec 15, 2022 at 06:42:02PM -0500, Steven Rostedt wrote:  
> > > > On Thu, 15 Dec 2022 15:10:27 -0800
> > > > "Paul E. McKenney" <paulmck@kernel.org> wrote:
> > > >   
> > > > > The nice thing about the current placement of rcu_scheduler_starting()
> > > > > is that there is not yet any other task to switch to.  ;-)  
> > > > 
> > > > Fair enough. Anyway the last patch appears to do the job.
> > > > 
> > > > Reported-by: Steven Rostedt (Google) <rostedt@goodmis.org>
> > > > Tested-by: Steven Rostedt (Google) <rostedt@goodmis.org>  
> > > 
> > > Applied, thank you!  
> > 
> > And I should have checked up on urgency.  Normal process would hold this
> > one until the v6.3 merge window, but please let me know if you would
> > like it in v6.2.  It is after all a bug fix.
> > 
> 
> Yes, any fix that fixes a lockdep splat is considered urgent and should be
> pushed ASAP. As it makes finding other lockdep splats more difficult (as
> the first splat shuts down lockdep).
> 
> Please send this during the merge window, as I have to carry it internally
> until it makes it into mainline.

This is now rebased and marked with tag rcu-urgent.2022.12.17a.
If testing goes well, I will send it by the middle of next week.

							Thanx, Paul
