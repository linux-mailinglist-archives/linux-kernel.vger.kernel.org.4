Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE9F16406CA
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Dec 2022 13:27:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233332AbiLBM1T (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Dec 2022 07:27:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233446AbiLBM1Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Dec 2022 07:27:16 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79860CBA66
        for <linux-kernel@vger.kernel.org>; Fri,  2 Dec 2022 04:27:12 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id AC88AB82158
        for <linux-kernel@vger.kernel.org>; Fri,  2 Dec 2022 12:27:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CBB64C433C1;
        Fri,  2 Dec 2022 12:27:08 +0000 (UTC)
Date:   Fri, 2 Dec 2022 07:27:04 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Pekka Paalanen <ppaalanen@gmail.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>, x86@kernel.org
Subject: Re: [BUG] lockdep splat using mmio tracer
Message-ID: <20221202072704.1158f038@gandalf.local.home>
In-Reply-To: <875yeuqgl5.ffs@tglx>
References: <20221201213126.620b7dd3@gandalf.local.home>
        <875yeuqgl5.ffs@tglx>
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

On Fri, 02 Dec 2022 10:51:02 +0100
Thomas Gleixner <tglx@linutronix.de> wrote:

> On Thu, Dec 01 2022 at 21:31, Steven Rostedt wrote:
> > I hit this while testing ftrace on an x86 32 bit VM (I've just started
> > converting my tests to run on a VM, which is find new found bugs).  
> 
> Which is find new found grammar twists for the english language :)

That's what I get for writing bug reports past my bedtime. ;-)

> 
> > [ 1111.130669] ================================   
> > [ 1111.130670] WARNING: inconsistent lock state   
> > [ 1111.130672] 6.1.0-rc6-test-00020-gbc591e45c100-dirty #245 Not tainted
> > [ 1111.130674] --------------------------------   
> > [ 1111.130675] inconsistent {INITIAL USE} -> {IN-NMI} usage.
> > [ 1111.130676] kworker/0:0/3433 [HC1[1]:SC0[0]:HE0:SE1] takes:
> > [ 1111.130679] d3dc2b90 (kmmio_lock){....}-{2:2}, at: kmmio_die_notifier+0x70/0x140
> > [ 1111.130690] {INITIAL USE} state was registered at:
> > [ 1111.130691]   lock_acquire+0xa2/0x2b0
> > [ 1111.130696]   _raw_spin_lock_irqsave+0x36/0x60 
> > [ 1111.130701]   register_kmmio_probe+0x43/0x210  
> > [ 1111.130704]   mmiotrace_ioremap+0x188/0x1b0
> > [ 1111.130706]   __ioremap_caller.constprop.0+0x257/0x340
> > [ 1111.130711]   ioremap_wc+0x12/0x20  
> 
> That's regular task context, while the int3, which is raised by the
> actual MMIO access, is considered to be NMI context. int3 has to be
> considered an NMI type exception because int3 can be hit anywhere, even
> in actual NMI context.

Yep, that's what I figured.

> 
> > [ 1111.130924]  lock_acquire.cold+0x31/0x37
> > [ 1111.130927]  ? kmmio_die_notifier+0x70/0x140   
> > [ 1111.130935]  ? get_ins_imm_val+0xf0/0xf0
> > [ 1111.130938]  _raw_spin_lock+0x2a/0x40
> > [ 1111.130942]  ? kmmio_die_notifier+0x70/0x140   
> > [ 1111.130945]  kmmio_die_notifier+0x70/0x140
> > [ 1111.130948]  ? arm_kmmio_fault_page+0xa0/0xa0  
> > [ 1111.130951]  atomic_notifier_call_chain+0x75/0x120
> > [ 1111.130955]  notify_die+0x44/0x90
> > [ 1111.130959]  exc_debug+0xd0/0x2a0
> > [ 1111.130965]  ? exc_int3+0x100/0x100
> > [ 1111.130968]  handle_exception+0x133/0x133
> > [ 1111.130970] EIP: qxl_draw_dirty_fb+0x2ae/0x440 [qxl]  
> 
> So for the mmio tracer there is no way that this happens:
> 
> > [ 1111.130788]   lock(kmmio_lock);
> > [ 1111.130789]   <Interrupt>
> > [ 1111.130790]     lock(kmmio_lock);  
> 
> but obviously lockdep cannot know that :)
> 
> The quick and dirty, but IMO safe way out of this, is to convert that
> lock to an arch_spinlock and evade lockdep.

Thanks, I'll write up a patch for this.

> 
> > I never hit this before, but then again, mmio tracer is showing output on
> > the VM which it did not do on the baremetal machine.  
> 
> It's exactly the same problem on bare metal.

Yep, but for some reason it never triggered on baremetal for me.

-- Steve


