Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 88E3B5E9CCC
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Sep 2022 11:02:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233151AbiIZJCX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Sep 2022 05:02:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234582AbiIZJBr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Sep 2022 05:01:47 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D24C53F1E1
        for <linux-kernel@vger.kernel.org>; Mon, 26 Sep 2022 02:01:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=qGz/4WBzDws5s0dWIslPd0rxEq1gYJueg7G4eGqmaEw=; b=OlAutqAnyNEQv/PgRvhkRsTEkt
        572PGSiCWQybcUZTj6jlzXoMa1KdQ27EERRK274n2GohZGYyW9s1ri6E1PYKXlWGwyQLwhQ+//isR
        tUWy5hoV18lE3ateeyEC3b7Ghs8nn6o9R5f6F1oeNdPp0mQ3zAatCfquJ2la5GWuHk+CIPn3H3Fcm
        ZN2GfwIW3MsMfPOx6P59KKMxWTvrGF2uNLiMt4K1wVmi+YnJDtnDcoyRymudBeowSqDufdK2pyJH+
        tf8Ly7M738CQ4ZOX87JnIZZWx40sKZiAq37pZJAehTqdrt61yzlIIU3V5F2wl8S99yeHkhF19fC7n
        CCjru+dQ==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1ocjzL-00Fzbe-Kj; Mon, 26 Sep 2022 09:01:20 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id C05CF300023;
        Mon, 26 Sep 2022 11:01:17 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id A7DF929A12A26; Mon, 26 Sep 2022 11:01:17 +0200 (CEST)
Date:   Mon, 26 Sep 2022 11:01:17 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     YingChi Long <me@inclyc.cn>
Cc:     tglx@linutronix.de, ndesaulniers@google.com,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        "Chang S. Bae" <chang.seok.bae@intel.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] x86/fpu: use __alignof__ to avoid UB in TYPE_ALIGN
Message-ID: <YzFqXbVptttrzoDe@hirez.programming.kicks-ass.net>
References: <20220925153151.2467884-1-me@inclyc.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220925153151.2467884-1-me@inclyc.cn>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Sep 25, 2022 at 11:31:50PM +0800, YingChi Long wrote:
> WG14 N2350 made very clear that it is an UB having type definitions with
> in "offsetof". This patch change the implementation of macro
> "TYPE_ALIGN" to builtin "__alignof__" to avoid undefined behavior.
> 
> I've grepped all source files to find any type definitions within
> "offsetof".
> 
>     offsetof\(struct .*\{ .*,
> 
> This implementation of macro "TYPE_ALIGN" seemes to be the only case of
> type definitions within offsetof in the kernel codebase.
> 
> Signed-off-by: YingChi Long <me@inclyc.cn>
> Link: https://www.open-std.org/jtc1/sc22/wg14/www/docs/n2350.htm
> ---
>  arch/x86/kernel/fpu/init.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/x86/kernel/fpu/init.c b/arch/x86/kernel/fpu/init.c
> index 621f4b6cac4a..41425ba0b6b1 100644
> --- a/arch/x86/kernel/fpu/init.c
> +++ b/arch/x86/kernel/fpu/init.c
> @@ -134,7 +134,7 @@ static void __init fpu__init_system_generic(void)
>  }
>  
>  /* Get alignment of the TYPE. */
> -#define TYPE_ALIGN(TYPE) offsetof(struct { char x; TYPE test; }, test)
> +#define TYPE_ALIGN(TYPE) __alignof__(TYPE)

IIRC there's a problem with alignof() in that it will return the ABI
alignment instead of that preferred or natural alignment for some types.

Notably I think 'long long' has 4 byte alignment on i386 and some other
32bit archs.

That said; please just replace the *one* instance of TYPE_ALIGN entirely
and get rid of the thing.
