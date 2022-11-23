Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E552636E15
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Nov 2022 00:07:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229700AbiKWXGU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Nov 2022 18:06:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229701AbiKWXGO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Nov 2022 18:06:14 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BDD2914E6C9
        for <linux-kernel@vger.kernel.org>; Wed, 23 Nov 2022 15:06:13 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 55BE461F6A
        for <linux-kernel@vger.kernel.org>; Wed, 23 Nov 2022 23:06:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B911FC433C1;
        Wed, 23 Nov 2022 23:06:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1669244772;
        bh=ZzGMwLn+tzktg0fi2o+yuqh09BA6oMf3uGWo0EbNvwc=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=l6JbyTRG58lvK6Fqyx3zOBXiLj8QYK+dhQ5azvH3ThxKEWqfJoi5/kK0Ozy9mxzWR
         6VnfJYHhpXf79HbsJvmTESzAKI2fe8T1k0jr6XPuHvFrLKUSIfrqwHaUS6qftSCMnC
         U1/CiVu1zrhiLD49ChkgD6qPi9ZAi2Pb913ESD7xmOWxW9KDXQWUYqJwef8JEyHczT
         TT5Bj3wshkrzifPBMu73g9WPymKzImrMTVl+zQuH+ZjQQtaSnKoMLxKw5M2ZWU8uYh
         Ejb2R1joXqN+kHoil+S/kCD+ZZP6wUf38kOR8zS+UM1alRalfHlK8cWjuQ0wIcMxUl
         nH/HUmLHUknUA==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 647FB5C0DF2; Wed, 23 Nov 2022 15:06:12 -0800 (PST)
Date:   Wed, 23 Nov 2022 15:06:12 -0800
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Josh Poimboeuf <jpoimboe@kernel.org>
Cc:     Peter Zijlstra <peterz@infradead.org>, sfr@canb.auug.org.au,
        linux-kernel@vger.kernel.org
Subject: Re: objtool warning for next-20221118
Message-ID: <20221123230612.GM4001@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <Y3thrQxfcvZSXFlr@hirez.programming.kicks-ass.net>
 <20221121145215.GF4001@paulmck-ThinkPad-P17-Gen-1>
 <20221122051605.4hcbslwxez2trdvt@treble>
 <Y3yJxQJ9DwxTx7km@hirez.programming.kicks-ass.net>
 <20221123002258.GR4001@paulmck-ThinkPad-P17-Gen-1>
 <20221123014812.7gptbvvndzemt5nc@treble>
 <20221123174951.GZ4001@paulmck-ThinkPad-P17-Gen-1>
 <20221123181941.fh4hrr3pazelwtxc@treble>
 <20221123191242.GG4001@paulmck-ThinkPad-P17-Gen-1>
 <20221123223214.gxwyrakfj7nbs2fb@treble>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221123223214.gxwyrakfj7nbs2fb@treble>
X-Spam-Status: No, score=-7.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 23, 2022 at 02:32:14PM -0800, Josh Poimboeuf wrote:
> On Wed, Nov 23, 2022 at 11:12:42AM -0800, Paul E. McKenney wrote:
> > On Wed, Nov 23, 2022 at 10:19:41AM -0800, Josh Poimboeuf wrote:
> > > On Wed, Nov 23, 2022 at 09:49:51AM -0800, Paul E. McKenney wrote:
> > > > > > > Perhaps the best way would be to stick a REACHABLE annotation in
> > > > > > > arch_cpu_idle_dead() or something?
> > > > > > 
> > > > > > When I apply this on -next, I still get the objtool complaint.
> > > > > > Is there something else I should also be doing?
> > > > > 
> > > > > Silly GCC is folding the inline asm.  This works (but still doesn't seem
> > > > > like the right approach):
> > > > > 
> > > > > diff --git a/arch/x86/kernel/process.c b/arch/x86/kernel/process.c
> > > > > index 26e8f57c75ad..128e7d78fedf 100644
> > > > > --- a/arch/x86/kernel/process.c
> > > > > +++ b/arch/x86/kernel/process.c
> > > > > @@ -702,7 +702,7 @@ static void (*x86_idle)(void);
> > > > >  #ifndef CONFIG_SMP
> > > > >  static inline void play_dead(void)
> > > > >  {
> > > > > -	BUG();
> > > > > +	_BUG_FLAGS(ASM_UD2, 0, ASM_REACHABLE);
> > > > >  }
> > > > >  #endif
> > > > 
> > > > I tried this, and still get:
> > > > 
> > > > vmlinux.o: warning: objtool: do_idle+0x156: unreachable instruction
> > > > 
> > > > Maybe my gcc is haunted?
> > > 
> > > Weird, it worked for me.  I have
> > > 
> > >   gcc version 12.2.1 20220819 (Red Hat 12.2.1-2) (GCC)
> > 
> > Me, I have these, so quite a bit older:
> > 
> > gcc version 8.5.0 20210514 (Red Hat 8.5.0-15) (GCC)
> > gcc version 9.4.0 (Ubuntu 9.4.0-1ubuntu1~20.04.1)
> > 
> > > and I can't really fathom why that wouldn't work.  Maybe it's a
> > > different issue?  The "unreachable instruction" warning is limited to
> > > one, so when a first warning gets fixed, a second warning might suddenly
> > > become visible.
> > > 
> > > Can you attach arch/x86/kernel/process.o?
> > 
> > Attached!
> 
> Hm, for whatever reason, that .o file is indeed missing the reachable
> annotation.  <scratches head>

There are at least three definitions.  Might I be getting the wrong one?

I have CONFIG_DEBUG_BUGVERBOSE=y and CONFIG_GENERIC_BUG=y, so I would
expect to be using the first one:

#define _BUG_FLAGS(ins, flags, extra)					\
do {									\
	asm_inline volatile("1:\t" ins "\n"				\
		     ".pushsection __bug_table,\"aw\"\n"		\
		     "2:\t" __BUG_REL(1b) "\t# bug_entry::bug_addr\n"	\
		     "\t"  __BUG_REL(%c0) "\t# bug_entry::file\n"	\
		     "\t.word %c1"        "\t# bug_entry::line\n"	\
		     "\t.word %c2"        "\t# bug_entry::flags\n"	\
		     "\t.org 2b+%c3\n"					\
		     ".popsection\n"					\
		     extra						\
		     : : "i" (__FILE__), "i" (__LINE__),		\
			 "i" (flags),					\
			 "i" (sizeof(struct bug_entry)));		\
} while (0)

> I confirmed the patch also fixes the warning with:
> 
>   gcc version 8.5.0 20210514 (Red Hat 8.5.0-10) (GCC)
> 
> No idea why it's not working for you... but maybe it doesn't matter as
> I'm still thinking we should go with a different approach.

OK, then I will await your update.

							Thanx, Paul
