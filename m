Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A07960DE19
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Oct 2022 11:31:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233113AbiJZJbU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Oct 2022 05:31:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233325AbiJZJbJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Oct 2022 05:31:09 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53EA5A599B
        for <linux-kernel@vger.kernel.org>; Wed, 26 Oct 2022 02:31:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=k561CKc6O1U1Gi5CEAUuXAJYDxt0c2P7n4SCwQkBNOs=; b=S/lY5GPtb/jr+6VJQyAIQ2h820
        4XBR71Ag9+QwvT+jk6JOTIRv20JgHIOXMCP4an1T4u9KVfjDmagwPkq8kUrbtX0PtTHJ/MElvIgOi
        wfZVORiSCl2bVor74hEhrq9CN9smf+wf4tXOWhUIuPA0mQCKvcwRpq/17TADRGOJbdeAxIp3Wom9D
        XDOWKJJQPzjGZzp2E3/Qa3q3yNK7YHhXo2w+44q16hCBHzjod7XII9JymLqlfftc3a7j7XDF9Ngmd
        HNdV7elp3xAfWDfnAqAKXCH092yGJEkIlmH6H+xE+i/pAwuegvoMLPF6KLTtuY+HkGOZmpXsCx4xc
        LUOmlJfQ==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1onckR-006YDk-57; Wed, 26 Oct 2022 09:30:57 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 4D4383000DD;
        Wed, 26 Oct 2022 11:30:54 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 34E352C268BC3; Wed, 26 Oct 2022 11:30:54 +0200 (CEST)
Date:   Wed, 26 Oct 2022 11:30:54 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Alexander Potapenko <glider@google.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Kees Cook <keescook@chromium.org>, x86@kernel.org
Subject: Re: [PATCH] x86/uaccess: instrument copy_from_user_nmi()
Message-ID: <Y1j+Tt9mnMDU0zO+@hirez.programming.kicks-ass.net>
References: <20221025221755.3810809-1-glider@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221025221755.3810809-1-glider@google.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 26, 2022 at 12:17:55AM +0200, Alexander Potapenko wrote:
> Make sure usercopy hooks from linux/instrumented.h are invoked for
> copy_from_user_nmi().
> This fixes KMSAN false positives reported when dumping opcodes for a
> stack trace.
> 
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Dave Hansen <dave.hansen@linux.intel.com>
> Cc: Kees Cook <keescook@chromium.org>
> Cc: x86@kernel.org
> Signed-off-by: Alexander Potapenko <glider@google.com>
> ---
>  arch/x86/lib/usercopy.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/arch/x86/lib/usercopy.c b/arch/x86/lib/usercopy.c
> index f1bb186171562..24b48af274173 100644
> --- a/arch/x86/lib/usercopy.c
> +++ b/arch/x86/lib/usercopy.c
> @@ -6,6 +6,7 @@
>  
>  #include <linux/uaccess.h>
>  #include <linux/export.h>
> +#include <linux/instrumented.h>
>  
>  #include <asm/tlbflush.h>
>  
> @@ -44,7 +45,9 @@ copy_from_user_nmi(void *to, const void __user *from, unsigned long n)
>  	 * called from other contexts.
>  	 */
>  	pagefault_disable();
> +	instrument_copy_from_user_before(to, from, n);
>  	ret = raw_copy_from_user(to, from, n);
> +	instrument_copy_from_user_after(to, from, n, ret);
>  	pagefault_enable();
>  
>  	return ret;

Is all that instrumentation NMI safe? ISTR having seen locks in some of
that *SAN stuff.

Also did this want:

Fixes: 59298997df89 ("x86/uaccess: avoid check_object_size() in copy_from_user_nmi()")

?
