Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D797D6F71C6
	for <lists+linux-kernel@lfdr.de>; Thu,  4 May 2023 20:15:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229696AbjEDSPF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 May 2023 14:15:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229459AbjEDSPE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 May 2023 14:15:04 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 935005586
        for <linux-kernel@vger.kernel.org>; Thu,  4 May 2023 11:14:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1683224060;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=fE5gSveVpC4p34I8FumCtZHMWqB3+IapDlr+S7oddeo=;
        b=ON7njbbn6rbivSI/R/V+wgCZIagj9DPb4TCdobr4Xple5cZDCwTMd12+uNrmLujFJ2PpKL
        Duko840BYXnhJlwDruBhHAidc9EucNeQQJ/ZeqCHT+Bac8tvzq7S19BKnoq/Fumv9MyxDh
        SVrhHT49WzhLdpCe6AdIxjUJsqdFdF4=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-136-ZH-lHVvXPe6erw0WWGr4MA-1; Thu, 04 May 2023 14:14:15 -0400
X-MC-Unique: ZH-lHVvXPe6erw0WWGr4MA-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com [10.11.54.9])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 926BB884EC5;
        Thu,  4 May 2023 18:14:14 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.45.225.24])
        by smtp.corp.redhat.com (Postfix) with SMTP id 20FD2492C13;
        Thu,  4 May 2023 18:14:11 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
        oleg@redhat.com; Thu,  4 May 2023 20:14:02 +0200 (CEST)
Date:   Thu, 4 May 2023 20:13:59 +0200
From:   Oleg Nesterov <oleg@redhat.com>
To:     Josh Poimboeuf <jpoimboe@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        David Laight <David.Laight@ACULAB.COM>
Cc:     Vernon Lovejoy <vlovejoy@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] x86/show_trace_log_lvl: ensure stack pointer is
 aligned, again
Message-ID: <20230504181359.GA4932@redhat.com>
References: <20230429100955.GA20567@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230429100955.GA20567@redhat.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.9
X-Spam-Status: No, score=-2.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Josh,

This version does exactly what you requested in reply to v1.

	https://lore.kernel.org/lkml/20230428043158.r5omehiaqawcac2y@treble/

What else should we do? Make V3 following David's suggestion

	https://lore.kernel.org/lkml/aa8537d81dc747a097e9e30491b5081b@AcuMS.aculab.com/

? Or what?

On 04/29, Oleg Nesterov wrote:
>
> From: Vernon Lovejoy <vlovejoy@redhat.com>
> 
> The commit e335bb51cc15 ("x86/unwind: Ensure stack pointer is aligned")
> tried to align the stack pointer in show_trace_log_lvl(), otherwise the
> "stack < stack_info.end" check can't guarantee that the last read does
> not go past the end of the stack.
> 
> However, we have the same problem with the initial value of the stack
> pointer, it can also be unaligned. So without this patch this trivial
> kernel module
> 
> 	#include <linux/module.h>
> 
> 	static int init(void)
> 	{
> 		asm volatile("sub    $0x4,%rsp");
> 		dump_stack();
> 		asm volatile("add    $0x4,%rsp");
> 
> 		return -EAGAIN;
> 	}
> 
> 	module_init(init);
> 	MODULE_LICENSE("GPL");
> 
> crashes the kernel.
> 
> Fixes: e335bb51cc15 ("x86/unwind: Ensure stack pointer is aligned")
> Signed-off-by: Vernon Lovejoy <vlovejoy@redhat.com>
> Signed-off-by: Oleg Nesterov <oleg@redhat.com>
> ---
>  arch/x86/kernel/dumpstack.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/x86/kernel/dumpstack.c b/arch/x86/kernel/dumpstack.c
> index 0bf6779187dd..f82d896eb99d 100644
> --- a/arch/x86/kernel/dumpstack.c
> +++ b/arch/x86/kernel/dumpstack.c
> @@ -195,7 +195,6 @@ static void show_trace_log_lvl(struct task_struct *task, struct pt_regs *regs,
>  	printk("%sCall Trace:\n", log_lvl);
>  
>  	unwind_start(&state, task, regs, stack);
> -	stack = stack ? : get_stack_pointer(task, regs);
>  	regs = unwind_get_entry_regs(&state, &partial);
>  
>  	/*
> @@ -214,7 +213,10 @@ static void show_trace_log_lvl(struct task_struct *task, struct pt_regs *regs,
>  	 * - hardirq stack
>  	 * - entry stack
>  	 */
> -	for ( ; stack; stack = PTR_ALIGN(stack_info.next_sp, sizeof(long))) {
> +	for (stack = PTR_ALIGN(stack ?: get_stack_pointer(task, regs), sizeof(long));
> +	     stack;
> +	     stack = PTR_ALIGN(stack_info.next_sp, sizeof(long)))
> +	{
>  		const char *stack_name;
>  
>  		if (get_stack_info(stack, task, &stack_info, &visit_mask)) {
> -- 
> 2.25.1.362.g51ebf55
> 

