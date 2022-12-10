Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DE63C6490D6
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Dec 2022 22:34:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229704AbiLJVeR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 10 Dec 2022 16:34:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229475AbiLJVeP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Dec 2022 16:34:15 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86E2413FBA
        for <linux-kernel@vger.kernel.org>; Sat, 10 Dec 2022 13:34:14 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 928C060A65
        for <linux-kernel@vger.kernel.org>; Sat, 10 Dec 2022 21:34:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DAD0FC433D2;
        Sat, 10 Dec 2022 21:34:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1670708052;
        bh=uMhZzPEArHPhXyGDt+hkW/iaMUWCmUw8KwfG5lGSxk0=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=f4k7RunYHoOoIMo0Nnm4+Gm2fCAZ+5uwbAouuV2lYslgbpCe3bBZYwLwnaQcoUAyK
         T7SuuzHPSWKBKtBPCWr8Y58J8PIBqAZpGBIHlE056CFemRYu7OLKHNug87HN343nOK
         8GMNWtavLHDfXT/qDYKKfOVS1jQcmeae1fVGBHGlSPmAd884yIH+9QgdHyCCJB25Ef
         SjaOJynkaElif+29I5onxQHw6s5XgjzEXpB61h4Ja+QbjnuNYx3Cv+c6JZ/EGiYkDt
         WO45V4x0DTpF4RcmCLJcjsHqBXcN/0l0ap0mky+ExLGRa2ICD4ww33J2EfosKOzbEA
         hc/dgCWR69BzA==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 7F9155C09A2; Sat, 10 Dec 2022 13:34:12 -0800 (PST)
Date:   Sat, 10 Dec 2022 13:34:12 -0800
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     linux-kernel@vger.kernel.org,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Karol Herbst <karolherbst@gmail.com>,
        Pekka Paalanen <ppaalanen@gmail.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>, Borislav Petkov <bp@alien8.de>
Subject: Re: [for-next][PATCH 13/25] x86/mm/kmmio: Use
 rcu_read_lock_sched_notrace()
Message-ID: <20221210213412.GF4001@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <20221210135750.425719934@goodmis.org>
 <20221210135825.241167123@goodmis.org>
 <20221210174753.GD4001@paulmck-ThinkPad-P17-Gen-1>
 <20221210133425.4657985e@gandalf.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221210133425.4657985e@gandalf.local.home>
X-Spam-Status: No, score=-7.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Dec 10, 2022 at 01:34:25PM -0500, Steven Rostedt wrote:
> On Sat, 10 Dec 2022 09:47:53 -0800
> "Paul E. McKenney" <paulmck@kernel.org> wrote:
> 
> > > Note, the preempt_disable() is still needed as it uses preempt_enable_no_resched().
> > > 
> 
>  ...
> 
> > Executable code can be the best form of comment.  ;-)
> > 
> > This does mess with preempt_count() redundantly, but the overhead from
> > that should be way down in the noise.
> 
> I was going to remove it, but then I realized that it would be a functional
> change, as from the comment above, it uses "preempt_enable_no_resched(),
> which there is not a rcu_read_unlock_sched() variant.

If this happens often enough, it might be worth adding something like
rcu_read_unlock_sched_no_resched(), but we clearly are not there yet.
Especially not with a name like that!  ;-)

							Thanx, Paul

> > Acked-by: Paul E. McKenney <paulmck@kernel.org>
> 
> Thanks! I'll add this to the commit.
> 
> -- Steve
