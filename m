Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE29E6403C4
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Dec 2022 10:51:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233052AbiLBJvL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Dec 2022 04:51:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232881AbiLBJvH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Dec 2022 04:51:07 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE444C868A
        for <linux-kernel@vger.kernel.org>; Fri,  2 Dec 2022 01:51:04 -0800 (PST)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1669974663;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Ar2q+838KTHdpHcfF+Mqs2PKITZg5yuDz+eUw9tEx7o=;
        b=Hz7ys8gJDOaoLb1SeF9fMCcTTlda+gdJJx/TTGnaVnwHjrL4OYg663DpgDeijsJh51N/Vp
        Dxcm3m3QNxO0clfdkOAZJFrQrsS1M4siElyoyUMOzVpn3bg+PZHUDWFfeKvrA89Eqd0JHl
        HTrYgqIGhmG5lpVRWmb4dOPi3TrzgSkZ4kKXhs48ozDk41l5BGxosgaWKK657NkPYprAl4
        3ik7AM4ik5No63iGGY8qUMQdaZ0WIt8v8KLfizbfKtOknAaBgsym+NW8FoxfNMOrNROp4q
        kED6EgiYRjjNawAvYJ16a+rQUQdeTji+Kes+FFyFIfbKQv5L4C0T9fOlArp8GA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1669974663;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Ar2q+838KTHdpHcfF+Mqs2PKITZg5yuDz+eUw9tEx7o=;
        b=N0gp+Go0MpnPaykTOChv9gdinMHnKjtxTGdIiJIWV10sDFR21Kuu4rQUdFT67dWt8efGOR
        VSte3QRFhzPK12BA==
To:     Steven Rostedt <rostedt@goodmis.org>,
        LKML <linux-kernel@vger.kernel.org>
Cc:     Pekka Paalanen <ppaalanen@gmail.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>, x86@kernel.org
Subject: Re: [BUG] lockdep splat using mmio tracer
In-Reply-To: <20221201213126.620b7dd3@gandalf.local.home>
References: <20221201213126.620b7dd3@gandalf.local.home>
Date:   Fri, 02 Dec 2022 10:51:02 +0100
Message-ID: <875yeuqgl5.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 01 2022 at 21:31, Steven Rostedt wrote:
> I hit this while testing ftrace on an x86 32 bit VM (I've just started
> converting my tests to run on a VM, which is find new found bugs).

Which is find new found grammar twists for the english language :)

> [ 1111.130669] ================================   
> [ 1111.130670] WARNING: inconsistent lock state   
> [ 1111.130672] 6.1.0-rc6-test-00020-gbc591e45c100-dirty #245 Not tainted
> [ 1111.130674] --------------------------------   
> [ 1111.130675] inconsistent {INITIAL USE} -> {IN-NMI} usage.
> [ 1111.130676] kworker/0:0/3433 [HC1[1]:SC0[0]:HE0:SE1] takes:
> [ 1111.130679] d3dc2b90 (kmmio_lock){....}-{2:2}, at: kmmio_die_notifier+0x70/0x140
> [ 1111.130690] {INITIAL USE} state was registered at:
> [ 1111.130691]   lock_acquire+0xa2/0x2b0
> [ 1111.130696]   _raw_spin_lock_irqsave+0x36/0x60 
> [ 1111.130701]   register_kmmio_probe+0x43/0x210  
> [ 1111.130704]   mmiotrace_ioremap+0x188/0x1b0
> [ 1111.130706]   __ioremap_caller.constprop.0+0x257/0x340
> [ 1111.130711]   ioremap_wc+0x12/0x20

That's regular task context, while the int3, which is raised by the
actual MMIO access, is considered to be NMI context. int3 has to be
considered an NMI type exception because int3 can be hit anywhere, even
in actual NMI context.

> [ 1111.130924]  lock_acquire.cold+0x31/0x37
> [ 1111.130927]  ? kmmio_die_notifier+0x70/0x140   
> [ 1111.130935]  ? get_ins_imm_val+0xf0/0xf0
> [ 1111.130938]  _raw_spin_lock+0x2a/0x40
> [ 1111.130942]  ? kmmio_die_notifier+0x70/0x140   
> [ 1111.130945]  kmmio_die_notifier+0x70/0x140
> [ 1111.130948]  ? arm_kmmio_fault_page+0xa0/0xa0  
> [ 1111.130951]  atomic_notifier_call_chain+0x75/0x120
> [ 1111.130955]  notify_die+0x44/0x90
> [ 1111.130959]  exc_debug+0xd0/0x2a0
> [ 1111.130965]  ? exc_int3+0x100/0x100
> [ 1111.130968]  handle_exception+0x133/0x133
> [ 1111.130970] EIP: qxl_draw_dirty_fb+0x2ae/0x440 [qxl]

So for the mmio tracer there is no way that this happens:

> [ 1111.130788]   lock(kmmio_lock);
> [ 1111.130789]   <Interrupt>
> [ 1111.130790]     lock(kmmio_lock);

but obviously lockdep cannot know that :)

The quick and dirty, but IMO safe way out of this, is to convert that
lock to an arch_spinlock and evade lockdep.

> I never hit this before, but then again, mmio tracer is showing output on
> the VM which it did not do on the baremetal machine.

It's exactly the same problem on bare metal.

Thanks,

        tglx
