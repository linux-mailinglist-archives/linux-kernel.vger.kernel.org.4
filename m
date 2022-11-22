Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2DC556334A5
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Nov 2022 06:16:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231368AbiKVFQM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Nov 2022 00:16:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229468AbiKVFQI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Nov 2022 00:16:08 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1FB332D741
        for <linux-kernel@vger.kernel.org>; Mon, 21 Nov 2022 21:16:08 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 910A861553
        for <linux-kernel@vger.kernel.org>; Tue, 22 Nov 2022 05:16:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C2CBDC433D6;
        Tue, 22 Nov 2022 05:16:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1669094167;
        bh=oOjMbAIorQTr/Rs4n9T+lH2Eo+E+O5Q+WKpoUX0VaG4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=SB2wp065pvRNR7c2axOoTaDgPANHVnQQ2gI/wDJGubFI93tGNLw8edsaV6baSAy4U
         XPtCBkrRwu9z+603ShJM/GC/+C96JDon/7PBupUVRou94vCyY93++cDyjBCBRe2hFj
         t7SUkQfz580MFRwl8qdVneVRFKhar7D/NCLwHhHNHdJa5Ax6YlFRuly4cVGhGBqI9v
         EjelYqBFo9yP2i0XtK036Cg2UVwh8+NleerDQMAbbvl6RvEUs4IbhyLVXBBApJ5Qs3
         MYrfkLYdjvXVoB2/FD4OcU981xlJ3sKzcTksbk040TR9SI532eCmWoG9ZrZ/4piuWx
         gaO8wWgJaLlZA==
Date:   Mon, 21 Nov 2022 21:16:05 -0800
From:   Josh Poimboeuf <jpoimboe@kernel.org>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     Peter Zijlstra <peterz@infradead.org>, sfr@canb.auug.org.au,
        linux-kernel@vger.kernel.org
Subject: Re: objtool warning for next-20221118
Message-ID: <20221122051605.4hcbslwxez2trdvt@treble>
References: <20221121040736.GA3738360@paulmck-ThinkPad-P17-Gen-1>
 <Y3thrQxfcvZSXFlr@hirez.programming.kicks-ass.net>
 <20221121145215.GF4001@paulmck-ThinkPad-P17-Gen-1>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20221121145215.GF4001@paulmck-ThinkPad-P17-Gen-1>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 21, 2022 at 06:52:15AM -0800, Paul E. McKenney wrote:
> On Mon, Nov 21, 2022 at 12:31:57PM +0100, Peter Zijlstra wrote:
> > On Sun, Nov 20, 2022 at 08:07:36PM -0800, Paul E. McKenney wrote:
> > > Hello!
> > > 
> > > I have started getting this from rcutorture scenario TREE09:
> > > 
> > > vmlinux.o: warning: objtool: do_idle+0x25f: unreachable instruction
> > > 
> > > Should I be worried?
> > 
> > Typically not a scary warning that.
> > 
> > > If so, please let me know what additional information you need.
> > 
> > .config and compiler version so that I might recreate and observe what
> > it's complaining about would help :-)
> 
> Fair enough!  ;-)
> 
> .config is attached, and the compiler versions are:
> 
> gcc version 8.5.0 20210514 (Red Hat 8.5.0-15) (GCC)
> gcc version 9.4.0 (Ubuntu 9.4.0-1ubuntu1~20.04.1) 
> 
> From an RCU perspective, the key points about TREE09's .config is
> CONFIG_PREEMPTION=y and CONFIG_SMP=n, but running on a single-CPU qemu
> instance.

It's complaining about an unreachable instruction after a call to
arch_cpu_idle_dead().  In this case objtool detects the fact
arch_cpu_idle_dead() doesn't return due to its call to the
non-CONFIG_SMP version of play_dead().  But GCC has no way of detecting
that because the caller is in another translation unit.

As far as I can tell, that function should never return.  Though it
seems to have some dubious semantics (see xen_pv_play_dead() for
example, which *does* seem to return?).  I'm thinking it would be an
improvement to enforce that noreturn behavior across all arches and
platforms, sprinkling __noreturn and BUG() on arch_cpu_idle_dead() and
maybe some of it callees, where needed.

Peter, what do you think?  I could attempt a patch.

-- 
Josh
