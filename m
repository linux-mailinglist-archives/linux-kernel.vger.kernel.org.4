Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 56849636D32
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Nov 2022 23:32:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229684AbiKWWc0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Nov 2022 17:32:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229646AbiKWWcU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Nov 2022 17:32:20 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 677D31055A9
        for <linux-kernel@vger.kernel.org>; Wed, 23 Nov 2022 14:32:17 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0C44661F52
        for <linux-kernel@vger.kernel.org>; Wed, 23 Nov 2022 22:32:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 48CF2C433D6;
        Wed, 23 Nov 2022 22:32:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1669242736;
        bh=K8EpGiSxouT+B3+NBXCF70URW9KNafmq//7W+BT261k=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=bl6aq1kQjEKjhrJc13pSTVBRCNgQ6nOjUpauzwqNVcw5zi64fD17oLR0PEQXy+PYp
         LpA98X2TA/wxE0nRo62X0N886HsnBpmcRhYpeReAPjBUYwu1rStoVBlIYGlRg3ITgw
         VxG/Ekg+ChxVbJQN1hLUmyiHT7yuBd/7zoiDwVJn02anUcUbGluZh5EDWnXVXNhzKp
         W345r4O8PNZcSQPhxNImcfNao+FotY/p35zy6Y3tD61OkCFn6MqZk0vacBWftD1IfM
         uGF4nTd03v6uaO0apbYsPPMNSvtljgWLhKYpVR4pwvmqP07CDraiHt/1XUiYY6+a0x
         DeshJHfVIi4mw==
Date:   Wed, 23 Nov 2022 14:32:14 -0800
From:   Josh Poimboeuf <jpoimboe@kernel.org>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     Peter Zijlstra <peterz@infradead.org>, sfr@canb.auug.org.au,
        linux-kernel@vger.kernel.org
Subject: Re: objtool warning for next-20221118
Message-ID: <20221123223214.gxwyrakfj7nbs2fb@treble>
References: <20221121040736.GA3738360@paulmck-ThinkPad-P17-Gen-1>
 <Y3thrQxfcvZSXFlr@hirez.programming.kicks-ass.net>
 <20221121145215.GF4001@paulmck-ThinkPad-P17-Gen-1>
 <20221122051605.4hcbslwxez2trdvt@treble>
 <Y3yJxQJ9DwxTx7km@hirez.programming.kicks-ass.net>
 <20221123002258.GR4001@paulmck-ThinkPad-P17-Gen-1>
 <20221123014812.7gptbvvndzemt5nc@treble>
 <20221123174951.GZ4001@paulmck-ThinkPad-P17-Gen-1>
 <20221123181941.fh4hrr3pazelwtxc@treble>
 <20221123191242.GG4001@paulmck-ThinkPad-P17-Gen-1>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20221123191242.GG4001@paulmck-ThinkPad-P17-Gen-1>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 23, 2022 at 11:12:42AM -0800, Paul E. McKenney wrote:
> On Wed, Nov 23, 2022 at 10:19:41AM -0800, Josh Poimboeuf wrote:
> > On Wed, Nov 23, 2022 at 09:49:51AM -0800, Paul E. McKenney wrote:
> > > > > > Perhaps the best way would be to stick a REACHABLE annotation in
> > > > > > arch_cpu_idle_dead() or something?
> > > > > 
> > > > > When I apply this on -next, I still get the objtool complaint.
> > > > > Is there something else I should also be doing?
> > > > 
> > > > Silly GCC is folding the inline asm.  This works (but still doesn't seem
> > > > like the right approach):
> > > > 
> > > > diff --git a/arch/x86/kernel/process.c b/arch/x86/kernel/process.c
> > > > index 26e8f57c75ad..128e7d78fedf 100644
> > > > --- a/arch/x86/kernel/process.c
> > > > +++ b/arch/x86/kernel/process.c
> > > > @@ -702,7 +702,7 @@ static void (*x86_idle)(void);
> > > >  #ifndef CONFIG_SMP
> > > >  static inline void play_dead(void)
> > > >  {
> > > > -	BUG();
> > > > +	_BUG_FLAGS(ASM_UD2, 0, ASM_REACHABLE);
> > > >  }
> > > >  #endif
> > > 
> > > I tried this, and still get:
> > > 
> > > vmlinux.o: warning: objtool: do_idle+0x156: unreachable instruction
> > > 
> > > Maybe my gcc is haunted?
> > 
> > Weird, it worked for me.  I have
> > 
> >   gcc version 12.2.1 20220819 (Red Hat 12.2.1-2) (GCC)
> 
> Me, I have these, so quite a bit older:
> 
> gcc version 8.5.0 20210514 (Red Hat 8.5.0-15) (GCC)
> gcc version 9.4.0 (Ubuntu 9.4.0-1ubuntu1~20.04.1)
> 
> > and I can't really fathom why that wouldn't work.  Maybe it's a
> > different issue?  The "unreachable instruction" warning is limited to
> > one, so when a first warning gets fixed, a second warning might suddenly
> > become visible.
> > 
> > Can you attach arch/x86/kernel/process.o?
> 
> Attached!

Hm, for whatever reason, that .o file is indeed missing the reachable
annotation.  <scratches head>

I confirmed the patch also fixes the warning with:

  gcc version 8.5.0 20210514 (Red Hat 8.5.0-10) (GCC)

No idea why it's not working for you... but maybe it doesn't matter as
I'm still thinking we should go with a different approach.

-- 
Josh
