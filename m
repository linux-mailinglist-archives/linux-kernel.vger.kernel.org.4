Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD699635BBB
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Nov 2022 12:30:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237293AbiKWLaG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Nov 2022 06:30:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236684AbiKWL3a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Nov 2022 06:29:30 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 250FE5580
        for <linux-kernel@vger.kernel.org>; Wed, 23 Nov 2022 03:29:00 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0902E1FB;
        Wed, 23 Nov 2022 03:29:07 -0800 (PST)
Received: from FVFF77S0Q05N (unknown [10.57.7.154])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 505BA3F587;
        Wed, 23 Nov 2022 03:28:59 -0800 (PST)
Date:   Wed, 23 Nov 2022 11:28:56 +0000
From:   Mark Rutland <mark.rutland@arm.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        Uros Bizjak <ubizjak@gmail.com>, linux-kernel@vger.kernel.org,
        Josh Poimboeuf <jpoimboe@kernel.org>,
        Jason Baron <jbaron@akamai.com>,
        Ard Biesheuvel <ardb@kernel.org>
Subject: Re: [PATCH] jump_label: use atomic_try_cmpxchg in
 static_key_slow_inc_cpuslocked
Message-ID: <Y34D+CnkhVRcneet@FVFF77S0Q05N>
References: <20221019140850.3395-1-ubizjak@gmail.com>
 <20221122161446.28907755@gandalf.local.home>
 <Y33jK7p2Xc6KD1ax@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y33jK7p2Xc6KD1ax@hirez.programming.kicks-ass.net>
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 23, 2022 at 10:08:59AM +0100, Peter Zijlstra wrote:
> On Tue, Nov 22, 2022 at 04:14:46PM -0500, Steven Rostedt wrote:
> 
> > > +	for (int v = atomic_read(&key->enabled); v > 0; )
> > 
> > Although it's permitted by the compiler, the kernel style is to not add
> > declarations in conditionals.
> 
> I'm thinking the whole motivation for upping to C99 was exactly so that
> we could start using this pattern.

That was one reason, yes. Marco and I wanted to be able to use C99-style
declarations in for loops to make it easier/possible to build macros with
locally-scoped control variables.

I personally prefer using C99-style declarations in for loops, but I don't have
a strong feeling that we *must* do so.

Thanks,
Mark.
