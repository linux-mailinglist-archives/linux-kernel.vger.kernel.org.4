Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9680F700864
	for <lists+linux-kernel@lfdr.de>; Fri, 12 May 2023 14:49:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240854AbjELMtT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 May 2023 08:49:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229630AbjELMtQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 May 2023 08:49:16 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 879FB198E
        for <linux-kernel@vger.kernel.org>; Fri, 12 May 2023 05:49:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=hGgFm+JrBl0d+9jKBbLJqj0nl+O+HgOWypxGVAGqUgI=; b=Jmb5bPsXieu8Vc7IIGoifS826t
        vvpUV4BwcIuzLvi/Eh0jahngUFSeAltY7W5lzzySCj1nDDNsnJPBEEfrmuW4ErW4HZiKBZqNbRfEw
        zZOsCw2Kwpxg0+VsjpLeActVLuPBUC/VjW/lJ6ByDn5ZkHIhbIN/TjQfFvEssQND9xmCasihA0CCJ
        2mMtPSmpnwegbZepanv87QnfcyfX7Inmtm/AuJfBUZp36XV/mYaVi1XGidv6pKzr4QnCbtCee0afV
        jnLKnoJfrPU+a4fdrMQHcmsqX6hvkBf3AbjqYD9gLaXdUNDv/V8LhJsEjbeZcLak1TcO91LCzUufq
        Y3TMtxAw==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1pxSCu-00995I-0G;
        Fri, 12 May 2023 12:49:12 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id B29A3300451;
        Fri, 12 May 2023 14:49:11 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 9A8A12C8D25C7; Fri, 12 May 2023 14:49:11 +0200 (CEST)
Date:   Fri, 12 May 2023 14:49:11 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Borislav Petkov <bp@alien8.de>
Cc:     X86 ML <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] x86/alternative: Optimize returns patching
Message-ID: <20230512124911.GZ4253@hirez.programming.kicks-ass.net>
References: <20230512120952.7924-1-bp@alien8.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230512120952.7924-1-bp@alien8.de>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 12, 2023 at 02:09:52PM +0200, Borislav Petkov wrote:
> From: "Borislav Petkov (AMD)" <bp@alien8.de>
> 
> Instead of decoding each instruction in the return sites range only to
> realize that that return site is a jump to the default return thunk
> which is needed - X86_FEATURE_RETHUNK is enabled - lift that check
> before the loop and get rid of that loop overhead.
> 
> Add comments about what gets patched, while at it.
> 
> Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>

Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>

> ---
>  arch/x86/kernel/alternative.c | 13 ++++++++++---
>  1 file changed, 10 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/x86/kernel/alternative.c b/arch/x86/kernel/alternative.c
> index b78d55f0dfad..3bb0a5f61e8c 100644
> --- a/arch/x86/kernel/alternative.c
> +++ b/arch/x86/kernel/alternative.c
> @@ -693,13 +693,12 @@ static int patch_return(void *addr, struct insn *insn, u8 *bytes)
>  {
>  	int i = 0;
>  
> +	/* Patch the custom return thunks... */
>  	if (cpu_feature_enabled(X86_FEATURE_RETHUNK)) {
> -		if (x86_return_thunk == __x86_return_thunk)
> -			return -1;
> -
>  		i = JMP32_INSN_SIZE;
>  		__text_gen_insn(bytes, JMP32_INSN_OPCODE, addr, x86_return_thunk, i);
>  	} else {
> +		/* ... or patch them out if not needed. */
>  		bytes[i++] = RET_INSN_OPCODE;
>  	}
>  
> @@ -712,6 +711,14 @@ void __init_or_module noinline apply_returns(s32 *start, s32 *end)
>  {
>  	s32 *s;
>  
> +	/*
> +	 * Do not patch out the default return thunks if those needed are the
> +	 * ones generated by the compiler.
> +	 */
> +	if (cpu_feature_enabled(X86_FEATURE_RETHUNK) &&
> +	    (x86_return_thunk == __x86_return_thunk))
> +		return;
> +
>  	for (s = start; s < end; s++) {
>  		void *dest = NULL, *addr = (void *)s + *s;
>  		struct insn insn;
> -- 
> 2.35.1
> 
