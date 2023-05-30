Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 59B3C715E4E
	for <lists+linux-kernel@lfdr.de>; Tue, 30 May 2023 14:02:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230494AbjE3MCK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 May 2023 08:02:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232142AbjE3MCE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 May 2023 08:02:04 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AAD3B9D
        for <linux-kernel@vger.kernel.org>; Tue, 30 May 2023 05:02:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=6oONK4evoFrXTBuyX0JuTX5RulQ6P3tEFP80GGtL6jw=; b=WrNe0rHJr46NC3XpvGWLYbXxMM
        4YZCosb6DWYi8OOtaNjj6z0ut3JnOTNDiU4rwZp8FEzJ0yl1ncTIyNi3wYtWOk1Hf2bI4xxl2yf8a
        RUrWhoj/7GPFPk68tAoLtYMrPp6QHtZIQ1yu9u4SIjkVlK88RLGC3IZNaalyYvsr6xnXbyApDCtzC
        Vw0fvSvjn1t4ItUGCc+nAcIu3Y9U1KyIKmcJGwC1RK3+7Npul+and9BSvsc7lXUANRMUr3bLXRChl
        1tdqAV7URqqtKMx2NZW67Ulwz+l09olXyXhB3SfMwKXb3qxND1wjSs09IqJ6Irt6t8W4oh6fkpwyU
        oV8K2Uiw==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1q3y2v-00DiV3-1l;
        Tue, 30 May 2023 12:01:50 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id C5EDC300194;
        Tue, 30 May 2023 14:01:48 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 9E905207AE7AC; Tue, 30 May 2023 14:01:48 +0200 (CEST)
Date:   Tue, 30 May 2023 14:01:48 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     LKML <linux-kernel@vger.kernel.org>, x86@kernel.org,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>, Borislav Petkov <bp@alien8.de>
Subject: Re: [PATCH] x86/alternatives: Add cond_resched() to
 text_poke_bp_batch()
Message-ID: <20230530120148.GD156198@hirez.programming.kicks-ass.net>
References: <20230528084652.5f3b48f0@rorschach.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230528084652.5f3b48f0@rorschach.local.home>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, May 28, 2023 at 08:46:52AM -0400, Steven Rostedt wrote:
> From: "Steven Rostedt (Google)" <rostedt@goodmis.org>
> 
> Debugging in the kernel has started slowing down the kernel by a
> noticeable amount. The ftrace start up tests are triggering the softlockup
> watchdog on some boxes. This is caused by the start up tests that enable
> function and function graph tracing several times. Sprinkling
> cond_resched() just in the start up test code was not enough to stop the
> softlockup from triggering. It would sometimes trigger in the
> text_poke_bp_batch() code.
> 
> The text_poke_bp_batch() is run in schedulable context. Add
> cond_resched() between each phase (adding the int3, updating the code, and
> removing the int3). This keeps the softlockup from triggering in the start
> up tests.
> 
> Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
> ---
>  arch/x86/kernel/alternative.c | 13 ++++++++++++-
>  1 file changed, 12 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/x86/kernel/alternative.c b/arch/x86/kernel/alternative.c
> index f615e0cb6d93..e024eddd457f 100644
> --- a/arch/x86/kernel/alternative.c
> +++ b/arch/x86/kernel/alternative.c
> @@ -1953,6 +1953,14 @@ static void text_poke_bp_batch(struct text_poke_loc *tp, unsigned int nr_entries
>  	 */
>  	atomic_set_release(&bp_desc.refs, 1);
>  
> +	/*
> +	 * Function tracing can enable thousands of places that need to be
> +	 * updated. This can take quite some time, and with full kernel debugging
> +	 * enabled, this could cause the softlockup watchdog to trigger.
> +	 * Add cond_resched() calls to each phase.
> +	 */
> +	cond_resched();

But but but... you can only have TP_VEC_MAX pokes queued, which is 256
on normal setups.

Please explain how this leads to problems and why you need _3_
reschedule points here.
