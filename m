Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5CDBB717B52
	for <lists+linux-kernel@lfdr.de>; Wed, 31 May 2023 11:10:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235354AbjEaJJq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 May 2023 05:09:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235017AbjEaJJk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 May 2023 05:09:40 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36982E48
        for <linux-kernel@vger.kernel.org>; Wed, 31 May 2023 02:09:06 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9033560BB5
        for <linux-kernel@vger.kernel.org>; Wed, 31 May 2023 09:09:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B7A77C433EF;
        Wed, 31 May 2023 09:09:03 +0000 (UTC)
Date:   Wed, 31 May 2023 05:08:59 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     LKML <linux-kernel@vger.kernel.org>, x86@kernel.org,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>, Borislav Petkov <bp@alien8.de>
Subject: Re: [PATCH] x86/alternatives: Add cond_resched() to
 text_poke_bp_batch()
Message-ID: <20230531050859.218a6632@rorschach.local.home>
In-Reply-To: <20230530120148.GD156198@hirez.programming.kicks-ass.net>
References: <20230528084652.5f3b48f0@rorschach.local.home>
        <20230530120148.GD156198@hirez.programming.kicks-ass.net>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 30 May 2023 14:01:48 +0200
Peter Zijlstra <peterz@infradead.org> wrote:


> > diff --git a/arch/x86/kernel/alternative.c b/arch/x86/kernel/alternative.c
> > index f615e0cb6d93..e024eddd457f 100644
> > --- a/arch/x86/kernel/alternative.c
> > +++ b/arch/x86/kernel/alternative.c
> > @@ -1953,6 +1953,14 @@ static void text_poke_bp_batch(struct text_poke_loc *tp, unsigned int nr_entries
> >  	 */
> >  	atomic_set_release(&bp_desc.refs, 1);
> >  
> > +	/*
> > +	 * Function tracing can enable thousands of places that need to be
> > +	 * updated. This can take quite some time, and with full kernel debugging
> > +	 * enabled, this could cause the softlockup watchdog to trigger.
> > +	 * Add cond_resched() calls to each phase.
> > +	 */
> > +	cond_resched();  
> 
> But but but... you can only have TP_VEC_MAX pokes queued, which is 256
> on normal setups.
> 
> Please explain how this leads to problems and why you need _3_
> reschedule points here.

I removed all but this first one and it works fine.

I'll resend with the update.

-- Steve
