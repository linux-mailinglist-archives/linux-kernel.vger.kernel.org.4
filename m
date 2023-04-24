Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D75F06EC7E0
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Apr 2023 10:27:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231133AbjDXI1T (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Apr 2023 04:27:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230139AbjDXI1N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Apr 2023 04:27:13 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19ABB2100
        for <linux-kernel@vger.kernel.org>; Mon, 24 Apr 2023 01:27:03 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id ABA1261EF1
        for <linux-kernel@vger.kernel.org>; Mon, 24 Apr 2023 08:27:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8847BC433D2;
        Mon, 24 Apr 2023 08:27:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1682324822;
        bh=ArQaSLrgnDLJiG4YpyX6jzpSZ+gme4NU8my4Qc+0eRY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=O2fLYGmgfOvLB67GrW7cS+var44Sps+k99SwAn1NlSiNR4+ljmpYtBeUap6buflYM
         by/6tnUZyWMB7kF6u2/APzLyXWRzHhKDBmWkS+0462YoBYzdv3zCFaU9UEM0XSWoUH
         ol7Wya0djuGh+g9BB88zIorvvJefpZUVR2XE904wc4XYjS28uOaP+W/6//f0/o5P87
         Neaujym5Po2AuO/jwnBxvISsXx7ukHT0axqPWulBOW6WccV3TAk6vQY8yKGlhIg4p7
         tiR2kUa11iOP/wLaXjT/LPzmTg2wSZE8JgOrYzWzLgof2NP3PH17cNnW6ympCYSP6U
         Et/LpUA5PcYyg==
Date:   Mon, 24 Apr 2023 10:26:58 +0200
From:   Frederic Weisbecker <frederic@kernel.org>
To:     "bibo, mao" <maobibo@loongson.cn>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Huacai Chen <chenhuacai@kernel.org>,
        WANG Xuerui <kernel@xen0n.name>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Anna-Maria Behnsen <anna-maria@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: Loongson (and other $ARCHs?) idle VS timer enqueue
Message-ID: <ZEY9UvvuTXYx3QEA@lothringen>
References: <ZEKDZEQmKExv0O7Q@lothringen>
 <87leil2r7v.ffs@tglx>
 <20230422081700.GB1214746@hirez.programming.kicks-ass.net>
 <ZEPteS82TbIhMQxe@lothringen>
 <20230422150409.GL1214746@hirez.programming.kicks-ass.net>
 <7d91fa2a-57c5-6c78-8e2d-7fbdd6a11cba@loongson.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <7d91fa2a-57c5-6c78-8e2d-7fbdd6a11cba@loongson.cn>
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Apr 23, 2023 at 09:52:49PM +0800, bibo, mao wrote:
> 
> 
> 在 2023/4/22 23:04, Peter Zijlstra 写道:
> > On Sat, Apr 22, 2023 at 04:21:45PM +0200, Frederic Weisbecker wrote:
> > > On Sat, Apr 22, 2023 at 10:17:00AM +0200, Peter Zijlstra wrote:
> > > > diff --git a/arch/loongarch/kernel/genex.S b/arch/loongarch/kernel/genex.S
> > > > index 44ff1ff64260..5a102ff80de0 100644
> > > > --- a/arch/loongarch/kernel/genex.S
> > > > +++ b/arch/loongarch/kernel/genex.S
> > > > @@ -40,6 +40,7 @@ SYM_FUNC_START(handle_vint)
> > > >   	ori	t0, t0, 0x1f
> > > >   	xori	t0, t0, 0x1f
> > > >   	bne	t0, t1, 1f
> > > > +	addi.d	t0, t0, 0x20
> > > >   	LONG_S	t0, sp, PT_ERA
> > > >   1:	move	a0, sp
> > > >   	move	a1, sp
> > > 
> > > But the interrupts are enabled in C from arch_cpu_idle(), which
> > > only then calls the ASM __arch_cpu_idle(). So if the interrupt happens
> > > somewhere in between the call, the rollback (or fast-forward now)
> > > doesn't apply.
> I do not know much details about scheduler and timer, if the interrupt
> happens between the call, will flag _TIF_NEED_RESCHED be set? If it is set,
> the rollback will still apply.

Nop, TIF_NEED_RESCHED is set only if a task is ready to run after the interrupt,
not if the interrupt only modified/added a timer.

> > @@ -40,6 +40,7 @@ SYM_FUNC_START(handle_vint)
> >   	ori	t0, t0, 0x1f
> >   	xori	t0, t0, 0x1f
> >   	bne	t0, t1, 1f
> > +	addi.d	t0, t0, 0x20
> It is more reasonable with this patch, this will jump out of idle function
> directly after interrupt returns. If so, can we remove checking
> _TIF_NEED_RESCHED in idle ASM function?

Indeed we can remove the check to TIF_RESCHED!

Thanks!
