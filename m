Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4847B602EBF
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Oct 2022 16:47:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230326AbiJROr5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Oct 2022 10:47:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230272AbiJROry (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Oct 2022 10:47:54 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59722D77D5
        for <linux-kernel@vger.kernel.org>; Tue, 18 Oct 2022 07:47:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=kzV0xBAqYeM4CQwWeNDGhj3bcn64aQixREWVnecx2HM=; b=A8QuBlfRgB25HDjMK4IocfrsXD
        wyyXHFkYBUs5q97tTqDN0N315gQAf/x1EgMRPsKsqL/7QV6SFd7OSvCiS835qW5/+61jFxIbQvTqM
        V82EzDqhW/qvLsDd8C0fwuEwSLRQRMGR6nyBtGzdYEPiyBBOoZZQwLjDvMS3znCT9mpoHfl7kLKHw
        2+8LZyO+s5KT7k5S9Zs7bRJhTrqf6RgF7PeGr3mbFSj6VkdfU+MrFrqh9erMS+6Rf3cYCSzkcnTZ1
        aTBygXewzNwcIo8Dog4dhNye8nDW1/GmzGjuc++JronxavbDf8KI76YH5jmJIevvdvqNzh5ZJdA2s
        QdDK9maA==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1oknse-004VeC-Ti; Tue, 18 Oct 2022 14:47:45 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 7CCA130012F;
        Tue, 18 Oct 2022 16:47:44 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 550482133E7EC; Tue, 18 Oct 2022 16:47:44 +0200 (CEST)
Date:   Tue, 18 Oct 2022 16:47:44 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     x86@kernel.org
Cc:     Kees Cook <keescook@chromium.org>,
        Sami Tolvanen <samitolvanen@google.com>,
        Joao Moreira <joao@overdrivepizza.com>,
        linux-kernel@vger.kernel.org, Mark Rutland <mark.rutland@arm.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        "H.J. Lu" <hjl.tools@gmail.com>
Subject: Re: [PATCH] x86/ibt: Implement FineIBT
Message-ID: <Y068kIjJr/5kJa23@hirez.programming.kicks-ass.net>
References: <Y06rtoE9BsERG9uv@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y06rtoE9BsERG9uv@hirez.programming.kicks-ass.net>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 18, 2022 at 03:35:50PM +0200, Peter Zijlstra wrote:
> +asm(	".pushsection .rodata			\n"
> +	"fineibt_caller_start:			\n"
> +	"	movl	$0x12345678, %r10d	\n"
> +	"	sub	$16, %r11		\n"
> +	ASM_NOP4
> +	"fineibt_caller_end:			\n"
> +	".popsection				\n"
> +);

Note: this hard relies on the indirection using %r11 and %r11
being clobbered by the call-abi. That is, there is no expectation on the
value of %r11 after this.

If GCC were to grow kCFI support this needs additional changes; one
option would be to use the 4 byte nop to rewrite it into something like:

	movl	$0x12345678, %r10d
	movl	%[reg], %r11
	sub	$16, %r11

> +static int cfi_rewrite_callers(s32 *start, s32 *end)
> +{
> +	s32 *s;
> +
> +	for (s = start; s < end; s++) {
> +		void *addr = (void *)s + *s;
> +		u32 hash;
> +
> +		addr -= fineibt_caller_size;
> +		hash = decode_caller_hash(addr);
> +		if (hash) {
> +			text_poke_early(addr, fineibt_caller_start, fineibt_caller_size);
> +			WARN_ON(*(u32 *)(addr + fineibt_caller_hash) != 0x12345678);
> +			text_poke_early(addr + fineibt_caller_hash, &hash, 4);
> +		}
> +		/* rely on apply_retpolines() */
> +	}
> +
> +	return 0;
> +}
