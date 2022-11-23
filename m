Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E2996636028
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Nov 2022 14:40:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238085AbiKWNkJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Nov 2022 08:40:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238286AbiKWNju (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Nov 2022 08:39:50 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1869B9A27D
        for <linux-kernel@vger.kernel.org>; Wed, 23 Nov 2022 05:26:52 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id BF65FB81FEA
        for <linux-kernel@vger.kernel.org>; Wed, 23 Nov 2022 13:26:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CA220C43151;
        Wed, 23 Nov 2022 13:26:48 +0000 (UTC)
Date:   Wed, 23 Nov 2022 08:26:47 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Uros Bizjak <ubizjak@gmail.com>, linux-kernel@vger.kernel.org,
        Josh Poimboeuf <jpoimboe@kernel.org>,
        Jason Baron <jbaron@akamai.com>,
        Ard Biesheuvel <ardb@kernel.org>
Subject: Re: [PATCH] jump_label: use atomic_try_cmpxchg in
 static_key_slow_inc_cpuslocked
Message-ID: <20221123082647.4531eabf@gandalf.local.home>
In-Reply-To: <Y33jK7p2Xc6KD1ax@hirez.programming.kicks-ass.net>
References: <20221019140850.3395-1-ubizjak@gmail.com>
        <20221122161446.28907755@gandalf.local.home>
        <Y33jK7p2Xc6KD1ax@hirez.programming.kicks-ass.net>
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

On Wed, 23 Nov 2022 10:08:59 +0100
Peter Zijlstra <peterz@infradead.org> wrote:

> On Tue, Nov 22, 2022 at 04:14:46PM -0500, Steven Rostedt wrote:
> 
> > > +	for (int v = atomic_read(&key->enabled); v > 0; )  
> > 
> > Although it's permitted by the compiler, the kernel style is to not add
> > declarations in conditionals.  
> 
> I'm thinking the whole motivation for upping to C99 was exactly so that
> we could start using this pattern.

OK, if you are fine with it then sure. I personally like seeing all
variables declared in one place. Maybe because I've been trained that way,
and I can easily be confused when I see a variable somewhere and don't see
it in the beginning declarations.

-- Steve
