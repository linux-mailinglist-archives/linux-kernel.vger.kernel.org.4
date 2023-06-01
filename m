Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 340067191FA
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Jun 2023 06:48:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231283AbjFAEsV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Jun 2023 00:48:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231292AbjFAEsR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Jun 2023 00:48:17 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E35C1B3
        for <linux-kernel@vger.kernel.org>; Wed, 31 May 2023 21:48:11 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id BE0D7640B7
        for <linux-kernel@vger.kernel.org>; Thu,  1 Jun 2023 04:48:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 73882C433EF;
        Thu,  1 Jun 2023 04:48:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685594890;
        bh=CgXPoyKHYGO3GT0ju7ToK2FjkfQdcbI/dg4c4DfUo2I=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=kWqk3us4m/KblY0s7NnWjdeQtLjYpejuxy+mwwx0q9Slh5C1IKOWkVW8yh0FUfGkC
         PxbJ9YchXAyaM7kQC0LEclfSSLMQJgcf9mO5xKzv5QjtSxUSr2Ui7s6NzZwa5NyMhh
         sMfv3okLF3RQjP2EXI4XwWrZahMXIii1MYruTAiFT09JyuBRtjwXtuiGY0tq2hJtC4
         xHBtxsKXLLRLEkTUhzNhwx5xdw1u0RCw9tFaPF12+AjIB7HhSCMY+Jb3m1eWA7QQ25
         GLcMV5SR34sUJBMXqX9vY9W2RfL5R/KwrZf/982Ud2uPPmLE5l9oNCotxOyftED2GR
         BB50iXHP1EEsg==
Date:   Thu, 1 Jun 2023 13:48:06 +0900
From:   Masami Hiramatsu (Google) <mhiramat@kernel.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     LKML <linux-kernel@vger.kernel.org>, x86@kernel.org,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Borislav Petkov <bp@alien8.de>
Subject: Re: [PATCH v2] x86/alternatives: Add cond_resched() to
 text_poke_bp_batch()
Message-Id: <20230601134806.a1c9eab11d0bbdbb1379f6c4@kernel.org>
In-Reply-To: <20230531092419.4d051374@rorschach.local.home>
References: <20230531092419.4d051374@rorschach.local.home>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 31 May 2023 09:24:19 -0400
Steven Rostedt <rostedt@goodmis.org> wrote:

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

Looks good to me.

Acked-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>

Thank you!

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
> -- 
> 2.39.2
> 


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
