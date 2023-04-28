Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C98716F110D
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Apr 2023 06:32:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345313AbjD1EcE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Apr 2023 00:32:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230350AbjD1EcC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Apr 2023 00:32:02 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB7DD1FF0
        for <linux-kernel@vger.kernel.org>; Thu, 27 Apr 2023 21:32:01 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6A69163F67
        for <linux-kernel@vger.kernel.org>; Fri, 28 Apr 2023 04:32:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 99E67C433D2;
        Fri, 28 Apr 2023 04:32:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1682656320;
        bh=NbRkJRYRrpSanpZI8cnamGI71x8F04vsDkhzvRB4Gp8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=lfwEE9QdlySRC1qEQyYl5zf60kVtzOpNyxov7QyrG66FbdDqXQ83+JvqfybDQvhQP
         5hHe7QWmvRNHQ88r7rT8ug68vvsJSQfuRE+U+jSDzeiYcmlCO8NSGZJorRFUkRCybT
         khYetLHwj6Qzo73fJHkUpW8GzQqa5E/arrzyiwNYj+noMGG+f/tqufA5JBZLoqYEzu
         roj+UWNRThw6G7UnNgb0KTDA0fgxrR/A/XwV8X4VFkKQX0tYb3p3JXfV30iZvDyAwp
         biUCLn0FrRRLrMyhM04YpGNC9WjDnWtnjGB7d336CtEiWmamQJ1iTaRt+ND5GW3/mb
         o/v9MXrgcEXhg==
Date:   Thu, 27 Apr 2023 21:31:58 -0700
From:   Josh Poimboeuf <jpoimboe@kernel.org>
To:     Oleg Nesterov <oleg@redhat.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Vernon Lovejoy <vlovejoy@redhat.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] x86/show_trace_log_lvl: ensure stack pointer is aligned,
 again
Message-ID: <20230428043158.r5omehiaqawcac2y@treble>
References: <20230427140054.GA17800@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230427140054.GA17800@redhat.com>
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 27, 2023 at 04:00:54PM +0200, Oleg Nesterov wrote:
> diff --git a/arch/x86/kernel/dumpstack.c b/arch/x86/kernel/dumpstack.c
> index 0bf6779187dd..71ab445a29c3 100644
> --- a/arch/x86/kernel/dumpstack.c
> +++ b/arch/x86/kernel/dumpstack.c
> @@ -214,6 +214,7 @@ static void show_trace_log_lvl(struct task_struct *task, struct pt_regs *regs,
>  	 * - hardirq stack
>  	 * - entry stack
>  	 */
> +	stack = PTR_ALIGN(stack, sizeof(long));
>  	for ( ; stack; stack = PTR_ALIGN(stack_info.next_sp, sizeof(long))) {
>  		const char *stack_name;

Seems reasonable, though 'stack' is already initialized a few lines
above this, so it would be cleaner to do the PTR_ALIGN then.  Or even
better, just move it all to the for loop:

	for (stack = PTR_ALIGN(stack ? : get_stack_pointer(task, regs));
	     stack;
	     stack = PTR_ALIGN(stack_info.next_sp, sizeof(long))) {

-- 
Josh
