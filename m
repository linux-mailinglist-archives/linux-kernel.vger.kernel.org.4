Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 18E1E616313
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Nov 2022 13:53:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231192AbiKBMxA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Nov 2022 08:53:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231171AbiKBMw4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Nov 2022 08:52:56 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C449E23391
        for <linux-kernel@vger.kernel.org>; Wed,  2 Nov 2022 05:52:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=Yd6e4en4bklJiNM6GZtjiZJXoygCKmqjbRziwSCUFLo=; b=LIf40PV0usRaztBevGb7nX492e
        hhtBZxHKfhiRkLI0CBRbf6fjMMIDRX92fnziwCt/JoLZ+rDMnIrVmPz4/58pSD/LaqFJUbAnZSjiV
        Hk3/UbcUOvTzMMfsci0clnbu9pyUco6r4e1U2VyzXO21eYdnXux8DDiEPjoycLrF1aq28mQ9G3wMa
        jeOmqp0MsTC8sn+U8IDER4tH6VTDIfT1j/kk25p1ptfVb3T/Hy/DK28WPgsSoskHbLqt/5fNES2FN
        UnldtqvI1ql9mqp/bXjUyi+sfFkXtxgCvVin3BKiyOGomKUym9eOhPFxGI/elofK+iLpX25RYo3Py
        qfcF5w0g==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1oqDEg-005WUS-Ex; Wed, 02 Nov 2022 12:52:50 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 3D082300454;
        Wed,  2 Nov 2022 13:52:45 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 2E3D020B1E7E2; Wed,  2 Nov 2022 13:52:45 +0100 (CET)
Date:   Wed, 2 Nov 2022 13:52:45 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Alexander Potapenko <glider@google.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Kees Cook <keescook@chromium.org>, x86@kernel.org
Subject: Re: [PATCH 2/5] x86/uaccess: instrument copy_from_user_nmi()
Message-ID: <Y2JoHd+l/l7WAWap@hirez.programming.kicks-ass.net>
References: <20221102110611.1085175-1-glider@google.com>
 <20221102110611.1085175-2-glider@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221102110611.1085175-2-glider@google.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 02, 2022 at 12:06:08PM +0100, Alexander Potapenko wrote:
> Make sure usercopy hooks from linux/instrumented.h are invoked for
> copy_from_user_nmi().
> This fixes KMSAN false positives reported when dumping opcodes for a
> stack trace.
> 
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Dave Hansen <dave.hansen@linux.intel.com>
> Cc: Kees Cook <keescook@chromium.org>
> Cc: Peter Zijlstra (Intel) <peterz@infradead.org>
> Cc: x86@kernel.org
> Signed-off-by: Alexander Potapenko <glider@google.com>

Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>

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
> -- 
> 2.38.1.273.g43a17bfeac-goog
> 
