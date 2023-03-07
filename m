Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 45BDF6AF6BB
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Mar 2023 21:30:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229789AbjCGUa0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Mar 2023 15:30:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229551AbjCGUaZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Mar 2023 15:30:25 -0500
X-Greylist: delayed 3593 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 07 Mar 2023 12:30:22 PST
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id C2CD49FE51;
        Tue,  7 Mar 2023 12:30:22 -0800 (PST)
Received: from gate.crashing.org (localhost.localdomain [127.0.0.1])
        by gate.crashing.org (8.14.1/8.14.1) with ESMTP id 327IhHtC031905;
        Tue, 7 Mar 2023 12:43:17 -0600
Received: (from segher@localhost)
        by gate.crashing.org (8.14.1/8.14.1/Submit) id 327IhGNk031902;
        Tue, 7 Mar 2023 12:43:16 -0600
X-Authentication-Warning: gate.crashing.org: segher set sender to segher@kernel.crashing.org using -f
Date:   Tue, 7 Mar 2023 12:43:16 -0600
From:   Segher Boessenkool <segher@kernel.crashing.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Nick Desaulniers <ndesaulniers@google.com>,
        Stephane Eranian <eranian@google.com>,
        linux-kernel@vger.kernel.org, tony.luck@intel.com,
        reinette.chatre@intel.com, fenghua.yu@intel.com,
        peternewman@google.com, james.morse@arm.com, babu.moger@amd.com,
        ananth.narayan@amd.com, vschneid@redhat.com,
        Nathan Chancellor <nathan@kernel.org>,
        clang-built-linux <llvm@lists.linux.dev>,
        Borislav Petkov <bp@alien8.de>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        "H. Peter Anvin" <hpa@zytor.com>, linux-toolchains@vger.kernel.org
Subject: Re: [PATCH] x86/resctrl: avoid compiler optimization in __resctrl_sched_in
Message-ID: <20230307184315.GS25951@gate.crashing.org>
References: <20230303231133.1486085-1-eranian@google.com> <20230306120106.GE1267364@hirez.programming.kicks-ass.net> <CAKwvOdnRvd5KK01awAyeyt5S36TPPW4_8Z6YL1r4gB-pBrHTbg@mail.gmail.com> <20230307113545.GB2017917@hirez.programming.kicks-ass.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230307113545.GB2017917@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.4.2.3i
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

On Tue, Mar 07, 2023 at 12:35:45PM +0100, Peter Zijlstra wrote:
> So per that summary, I'm going to nit-pick and state we very much want
> CSE. CSE good. What we don't want it violating store-load ordering.

So you need to describe exactly what you *do* want.  There is no way to
forbid most otherwise valid things.  But you can express pretty much all
dependencies.

> Oh, geez, what a twisty tale that... So Linus knew back in '09 that "p"
> was icky, but it sorta was the only thing and it 'worked' -- until now
> :/

The "p" constraint is just like any other address_constraint, in most
aspects.  Since this is very specific to "p", that limits what is going
on to really just one thing.

For "p", after reload, strict_memory_address_addr_space_p is used.  That
is, targetm.addr_space.legitimate_address_p with strict set to true.  On
x86 that limits what registers can be used?  So I guess that made things
accidentally work before?

> So ideally we'd get something that respects the whole store-load
> ordering but still allows agressive CSE. And works for both toolchains.
> Small ask, I know :-)

Well, what is the ordering you need respected, *exactly*?


Segher
