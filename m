Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AAEA76C3FA8
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Mar 2023 02:20:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229838AbjCVBUt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Mar 2023 21:20:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229550AbjCVBUp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Mar 2023 21:20:45 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A0F8271F
        for <linux-kernel@vger.kernel.org>; Tue, 21 Mar 2023 18:20:44 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 4AA65B81A3C
        for <linux-kernel@vger.kernel.org>; Wed, 22 Mar 2023 01:20:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 333BBC433D2;
        Wed, 22 Mar 2023 01:20:41 +0000 (UTC)
Date:   Tue, 21 Mar 2023 21:20:38 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Josh Poimboeuf <jpoimboe@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Frederic Weisbecker <fweisbec@gmail.com>,
        "Paul E. McKenney" <paulmck@kernel.org>
Subject: Re: [PATCH] context_tracking: Have ct_state() use
 preempt_disable_notrace()
Message-ID: <20230321212038.40325918@gandalf.local.home>
In-Reply-To: <20230322005821.oh4pbn4vdf4jrdsh@treble>
References: <20230321204524.44733a13@gandalf.local.home>
        <20230322005821.oh4pbn4vdf4jrdsh@treble>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.8 required=5.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 21 Mar 2023 17:58:21 -0700
Josh Poimboeuf <jpoimboe@kernel.org> wrote:

> On Tue, Mar 21, 2023 at 08:45:24PM -0400, Steven Rostedt wrote:
> > From: "Steven Rostedt (Google)" <rostedt@goodmis.org>
> > 
> > One of my tests triggered:
> > 
> >  ------------[ cut here ]------------
> >  WARNING: CPU: 0 PID: 1 at include/trace/events/preemptirq.h:51 trace_preempt_off+0x7c/0x80
> >  Modules linked in:
> >  CPU: 0 PID: 1 Comm: init Not tainted 6.3.0-rc3-test-00011-ge11b521a7b69-dirty #31
> >  Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.0-debian-1.16.0-5 04/01/2014
> >  RIP: 0010:trace_preempt_off+0x7c/0x80
> >  Code: 74 0f 48 8b 78 08 48 89 f2 48 89 de e8 5d f9 ff ff 65 ff 0d 6e d6 ce 68 75 a2 0f 1f 44 00 00 eb 9b e8 28 ea f3 ff 84 c0 75 a5 <0f> 0b eb a1 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 f3 0f
> >  RSP: 0000:ffffaf0880013f00 EFLAGS: 00010046
> >  RAX: 0000000000000000 RBX: ffffffff97fafe59 RCX: 0000000000000001
> >  RDX: 0000000000000000 RSI: ffffffff986f4b71 RDI: ffffffff986fa0dd
> >  RBP: ffffffff97fafe59 R08: 0000000000000000 R09: 0000000000000000
> >  R10: 0000000000000000 R11: 0000000000000000 R12: 0000000000000000
> >  R13: 0000000000000014 R14: 0000000000000000 R15: 0000000000000000
> >  FS:  0000000000000000(0000) GS:ffff8adf7bc00000(0000) knlGS:0000000000000000
> >  CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> >  CR2: 00007f125de099c0 CR3: 000000010498a001 CR4: 0000000000170ef0
> >  Call Trace:
> >   <TASK>
> >   irqentry_enter_from_user_mode+0x39/0x80
> >   irqentry_enter+0x51/0x60
> >   exc_page_fault+0x3d/0x200
> >   asm_exc_page_fault+0x26/0x30  
> 
> I think this was just fixed in -tip today:
> 
>   https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git/commit/?id=f87d28673b71b35b248231a2086f9404afbb7f28
> 

Thanks. Either way, I need a fix to let me pass my tests on my own code ;-)

-- Steve
