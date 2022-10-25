Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4DC5560D5F0
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Oct 2022 22:59:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232000AbiJYU7w (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Oct 2022 16:59:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231628AbiJYU7r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Oct 2022 16:59:47 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A313912D07
        for <linux-kernel@vger.kernel.org>; Tue, 25 Oct 2022 13:59:46 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3DE1961B7F
        for <linux-kernel@vger.kernel.org>; Tue, 25 Oct 2022 20:59:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DF4BAC433C1;
        Tue, 25 Oct 2022 20:59:44 +0000 (UTC)
Date:   Tue, 25 Oct 2022 16:59:56 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     torvalds@linux-foundation.org, dave.hansen@intel.com,
        linux-kernel@vger.kernel.org, x86@kernel.org,
        keescook@chromium.org, seanjc@google.com
Subject: Re: [PATCH 4/5] x86/ftrace: Remove SYSTEM_BOOTING exceptions
Message-ID: <20221025165956.415d82d9@gandalf.local.home>
In-Reply-To: <20221025201057.945960823@infradead.org>
References: <20221025200656.951281799@infradead.org>
        <20221025201057.945960823@infradead.org>
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

On Tue, 25 Oct 2022 22:07:00 +0200
Peter Zijlstra <peterz@infradead.org> wrote:

> Now that text_poke is available before ftrace, remove the
> SYSTEM_BOOTING exceptions.
> 
> Specifically, this cures a W+X case during boot.

We have W+X all over the place (the entire kernel text). And I don't think
we really want this.

This will slow down boots in general, as it will cause all static_branches
to use this memory page logic. And I don't think we really want to do
that at boot up when we don't need to.

I would change this to:

	if (unlikely(system_state == SYSTEM_BOOTING) &&
	    core_kernel_text((unsigned long)addr)) {

This way we still do memcpy() on all core kernel text which is still
writable. It was the ftrace allocated trampoline that caused issues, not
the locations that were being updated.

-- Steve



> 
> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> ---
>  arch/x86/kernel/alternative.c |   10 ----------
>  arch/x86/kernel/ftrace.c      |    3 +--
>  2 files changed, 1 insertion(+), 12 deletions(-)
> 
> --- a/arch/x86/kernel/alternative.c
> +++ b/arch/x86/kernel/alternative.c
> @@ -1681,11 +1681,6 @@ void __ref text_poke_queue(void *addr, c
>  {
>  	struct text_poke_loc *tp;
>  
> -	if (unlikely(system_state == SYSTEM_BOOTING)) {
> -		text_poke_early(addr, opcode, len);
> -		return;
> -	}
> -
>  	text_poke_flush(addr);
>  
>  	tp = &tp_vec[tp_vec_nr++];
> @@ -1707,11 +1702,6 @@ void __ref text_poke_bp(void *addr, cons
>  {
>  	struct text_poke_loc tp;
>  
> -	if (unlikely(system_state == SYSTEM_BOOTING)) {
> -		text_poke_early(addr, opcode, len);
> -		return;
> -	}
> -
>  	text_poke_loc_init(&tp, addr, opcode, len, emulate);
>  	text_poke_bp_batch(&tp, 1);
>  }
> --- a/arch/x86/kernel/ftrace.c
> +++ b/arch/x86/kernel/ftrace.c
> @@ -415,8 +415,7 @@ create_trampoline(struct ftrace_ops *ops
>  
>  	set_vm_flush_reset_perms(trampoline);
>  
> -	if (likely(system_state != SYSTEM_BOOTING))
> -		set_memory_ro((unsigned long)trampoline, npages);
> +	set_memory_ro((unsigned long)trampoline, npages);
>  	set_memory_x((unsigned long)trampoline, npages);
>  	return (unsigned long)trampoline;
>  fail:
> 

