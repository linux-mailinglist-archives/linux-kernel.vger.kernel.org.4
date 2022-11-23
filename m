Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC512634CE6
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Nov 2022 02:24:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235242AbiKWBYW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Nov 2022 20:24:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234830AbiKWBXz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Nov 2022 20:23:55 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 052DE7CB99
        for <linux-kernel@vger.kernel.org>; Tue, 22 Nov 2022 17:23:55 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id BA849B81E4B
        for <linux-kernel@vger.kernel.org>; Wed, 23 Nov 2022 01:23:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3A56CC433C1;
        Wed, 23 Nov 2022 01:23:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1669166632;
        bh=qPfxX+m8lCHM/zjzvq+qtO+659L/qs8JOHH93oU7u5A=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=svmhc6WYTgLXsI/x9Ai3F5/Pek/+azjjx5I4GbOilVcQ5bgBNuNlYge1aUQFRbi0/
         8whb5goDS9awZk8tiZLnHhqy/r46F2zBoJnmQx9F0PBHHMkhBivB3huktZgGGYl0cW
         0iPRGsunI4mZ8lGxXTQdpunTzQDi2TlP3U1RxStuQ0WpaLqW8DALYRtBJKKGBTcYkN
         1AXtRIABXS8ZeRs9BYl9BH/2C0piGsRjCB1VgXBuPpn3+3eetO+5hUU0AZ0eRG4cgV
         lSx7fSpld56sFlNxhqkmxs5MS9C7YA8KksFO7VltcpCWle/GBMfiqZJQ1gH9Uu2+hB
         XpwTcWqZRtvYw==
Date:   Tue, 22 Nov 2022 17:23:50 -0800
From:   Josh Poimboeuf <jpoimboe@kernel.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     "Paul E. McKenney" <paulmck@kernel.org>, sfr@canb.auug.org.au,
        linux-kernel@vger.kernel.org
Subject: Re: objtool warning for next-20221118
Message-ID: <20221123012350.kelmmadh65lyswqz@treble>
References: <20221121040736.GA3738360@paulmck-ThinkPad-P17-Gen-1>
 <Y3thrQxfcvZSXFlr@hirez.programming.kicks-ass.net>
 <20221121145215.GF4001@paulmck-ThinkPad-P17-Gen-1>
 <20221122051605.4hcbslwxez2trdvt@treble>
 <Y3yJxQJ9DwxTx7km@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Y3yJxQJ9DwxTx7km@hirez.programming.kicks-ass.net>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 22, 2022 at 09:35:17AM +0100, Peter Zijlstra wrote:
> On Mon, Nov 21, 2022 at 09:16:05PM -0800, Josh Poimboeuf wrote:
> 
> > It's complaining about an unreachable instruction after a call to
> > arch_cpu_idle_dead().  In this case objtool detects the fact
> > arch_cpu_idle_dead() doesn't return due to its call to the
> > non-CONFIG_SMP version of play_dead().  But GCC has no way of detecting
> > that because the caller is in another translation unit.
> > 
> > As far as I can tell, that function should never return.  Though it
> > seems to have some dubious semantics (see xen_pv_play_dead() for
> > example, which *does* seem to return?).  I'm thinking it would be an
> > improvement to enforce that noreturn behavior across all arches and
> > platforms, sprinkling __noreturn and BUG() on arch_cpu_idle_dead() and
> > maybe some of it callees, where needed.
> > 
> > Peter, what do you think?  I could attempt a patch.
> 
> I'm thinking the Xen case makes all this really rather difficult :/
> 
> While normally a CPU is brought up through a trampoline, Xen seems to
> have implemented it by simply returning from play_dead(), and afaict
> that is actually a valid way to go about doing it.

o_O

How the @#$% is that a valid way of doing it?  Why not just do it the
normal way?

> Perhaps the best way would be to stick a REACHABLE annotation in
> arch_cpu_idle_dead() or something?

It what universe would we expect a function named "play_dead" to instead
finish bringing the CPU up and return?

That's just awful...  I don't see anything "valid" about it.

-- 
Josh
