Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B027703C9A
	for <lists+linux-kernel@lfdr.de>; Mon, 15 May 2023 20:27:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242935AbjEOS1V (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 May 2023 14:27:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242682AbjEOS1U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 May 2023 14:27:20 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7CD6A10E47
        for <linux-kernel@vger.kernel.org>; Mon, 15 May 2023 11:26:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1684175190;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=BWesIG2yc20DgCzCmWgCKSDzsu6SyLz1YIsPYlToYHs=;
        b=ftp1eVstRrPLpOW9lV2qbm2ZGFt+Lz5HCVPN9+JXNwaoI1HZY9A3eMsqA/MDmV8Zxxod+j
        rEdmbN8aO/OLCLA4bLLqgqpcAMqFYRvuw00NLMCgR2VpZlR2thYAYnyNJaTDfuQCHvD8kH
        lxxbb2k/J+JwbsYlZ7gt06VWmKATzBM=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-516-AmXCK6BgMeObu1Q2z57TLQ-1; Mon, 15 May 2023 14:26:25 -0400
X-MC-Unique: AmXCK6BgMeObu1Q2z57TLQ-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id DBC80811E7C;
        Mon, 15 May 2023 18:26:24 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.45.226.147])
        by smtp.corp.redhat.com (Postfix) with SMTP id 4628A1121314;
        Mon, 15 May 2023 18:26:23 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
        oleg@redhat.com; Mon, 15 May 2023 20:26:11 +0200 (CEST)
Date:   Mon, 15 May 2023 20:26:08 +0200
From:   Oleg Nesterov <oleg@redhat.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Vernon Lovejoy <vlovejoy@redhat.com>, linux-kernel@vger.kernel.org,
        David Laight <David.Laight@ACULAB.COM>,
        Josh Poimboeuf <jpoimboe@kernel.org>
Subject: Re: [PATCH v3] x86/show_trace_log_lvl: ensure stack pointer is
 aligned, again
Message-ID: <20230515182608.GA21285@redhat.com>
References: <20230512104232.GA10227@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230512104232.GA10227@redhat.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.3
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Josh, this is boring.

We are changing this simple fix for the second time, precisely following
your recommendations. And for the second time, you mysteriously disappear
afterward.

Please tell us if you finally agree with this version or if you think we
should make changes again.

Thanks.

On 05/12, Oleg Nesterov wrote:
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
>  arch/x86/kernel/dumpstack.c | 7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/x86/kernel/dumpstack.c b/arch/x86/kernel/dumpstack.c
> index 0bf6779187dd..f18ca44c904b 100644
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
> @@ -214,9 +213,13 @@ static void show_trace_log_lvl(struct task_struct *task, struct pt_regs *regs,
>  	 * - hardirq stack
>  	 * - entry stack
>  	 */
> -	for ( ; stack; stack = PTR_ALIGN(stack_info.next_sp, sizeof(long))) {
> +	for (stack = stack ?: get_stack_pointer(task, regs);
> +	     stack;
> +	     stack = stack_info.next_sp) {
>  		const char *stack_name;
>  
> +		stack = PTR_ALIGN(stack, sizeof(long));
> +
>  		if (get_stack_info(stack, task, &stack_info, &visit_mask)) {
>  			/*
>  			 * We weren't on a valid stack.  It's possible that
> -- 
> 2.25.1.362.g51ebf55
> 

