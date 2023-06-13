Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9DC8372E4C5
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Jun 2023 16:01:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242417AbjFMOBS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Jun 2023 10:01:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239765AbjFMOBP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Jun 2023 10:01:15 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C882EF4
        for <linux-kernel@vger.kernel.org>; Tue, 13 Jun 2023 07:01:14 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5DEBD63523
        for <linux-kernel@vger.kernel.org>; Tue, 13 Jun 2023 14:01:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0EBAFC433F0;
        Tue, 13 Jun 2023 14:01:12 +0000 (UTC)
Date:   Tue, 13 Jun 2023 10:01:11 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     LKML <linux-kernel@vger.kernel.org>, x86@kernel.org
Cc:     Masami Hiramatsu <mhiramat@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Borislav Petkov <bp@alien8.de>
Subject: Re: [PATCH v2] x86/alternatives: Add cond_resched() to
 text_poke_bp_batch()
Message-ID: <20230613100111.44a7c43a@gandalf.local.home>
In-Reply-To: <20230531092419.4d051374@rorschach.local.home>
References: <20230531092419.4d051374@rorschach.local.home>
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


Peter,

Can you ack this? And then I can push it through my tree.

Thanks!

-- Steve


On Wed, 31 May 2023 09:24:19 -0400
Steven Rostedt <rostedt@goodmis.org> (by way of Steven Rostedt <rostedt@goodmis.org>) wrote:

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
> When function tracing enables all functions, it will call
> text_poke_queue() to queue the places that need to be patched. Every
> 256 entries will do a "flush" that calls text_poke_bp_batch() to do the
> update of the 256 locations. As this is in a scheduleable context,
> calling cond_resched() at the start of text_poke_bp_batch() will ensure
> that other tasks could get a chance to run while the patching is
> happening. This keeps the softlockup from triggering in the start up
> tests.
> 
> Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
> ---
> Changes since v1: https://lkml.kernel.org/r/20230528084652.5f3b48f0@rorschach.local.home
> 
>  - Just call cond_resched() once in text_poke_bp_batch() and not for
>    each phase, as it only needs to be called once every 256 entries.
> 
>  arch/x86/kernel/alternative.c | 10 ++++++++++
>  1 file changed, 10 insertions(+)
> 
> diff --git a/arch/x86/kernel/alternative.c b/arch/x86/kernel/alternative.c
> index f615e0cb6d93..412ad66cd240 100644
> --- a/arch/x86/kernel/alternative.c
> +++ b/arch/x86/kernel/alternative.c
> @@ -1953,6 +1953,16 @@ static void text_poke_bp_batch(struct text_poke_loc *tp, unsigned int nr_entries
>  	 */
>  	atomic_set_release(&bp_desc.refs, 1);
>  
> +	/*
> +	 * Function tracing can enable thousands of places that need to be
> +	 * updated. This can take quite some time, and with full kernel debugging
> +	 * enabled, this could cause the softlockup watchdog to trigger.
> +	 * This function gets called every 256 entries added to be patched.
> +	 * Call cond_resched() here to make sure that other tasks can get scheduled
> +	 * while processing all the functions being patched.
> +	 */
> +	cond_resched();
> +
>  	/*
>  	 * Corresponding read barrier in int3 notifier for making sure the
>  	 * nr_entries and handler are correctly ordered wrt. patching.

