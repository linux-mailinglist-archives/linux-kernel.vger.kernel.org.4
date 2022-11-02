Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B913A616314
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Nov 2022 13:53:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231197AbiKBMxH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Nov 2022 08:53:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231199AbiKBMxE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Nov 2022 08:53:04 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 143CE24F11
        for <linux-kernel@vger.kernel.org>; Wed,  2 Nov 2022 05:53:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=h2SE5RwKBCcdzUwbfaFdZfsZyswNYZ6Fa+MR9Z7llwo=; b=JOtPhia4qQjDFmq7/FCisGmLAq
        C/3jwbcF1PMvrLjIB7K7o4ODEpIVynbT2B+DuP624X/aoG43q56GDsTicBTkA2l5T+tVcIwGvw5fx
        S4fCJVaBG8fAueb4d0qxhCX3w1hnnLC6ClEntC7kib+bSTUWTKRh6AMNSNNypctakH7lVplAxpFhT
        bPXwtvwbtBr0oI1miYeSM5nnwYLfu6BZExWN2DDqZMre0rJxmZoLpUG+R3rsAtKGx1FUbB+FtkUH4
        4rM2uvoEPfVAkgJHadM5YF6nkyOpFCIzLJhqC2ExdTlANpKQVaBEmt+n1YJbFtaoySKzwp5G8IJ8Z
        RPp17Dng==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1oqDEw-005WV4-0O; Wed, 02 Nov 2022 12:53:06 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id C57C530031B;
        Wed,  2 Nov 2022 13:53:00 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id B6B0720B1E7E3; Wed,  2 Nov 2022 13:53:00 +0100 (CET)
Date:   Wed, 2 Nov 2022 13:53:00 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Alexander Potapenko <glider@google.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Dmitry Vyukov <dvyukov@google.com>,
        Marco Elver <elver@google.com>
Subject: Re: [PATCH 4/5] kmsan: make sure PREEMPT_RT is off
Message-ID: <Y2JoLOXtvmcVx8mU@hirez.programming.kicks-ass.net>
References: <20221102110611.1085175-1-glider@google.com>
 <20221102110611.1085175-4-glider@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221102110611.1085175-4-glider@google.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 02, 2022 at 12:06:10PM +0100, Alexander Potapenko wrote:
> As pointed out by Peter Zijlstra, __msan_poison_alloca() does not play
> well with IRQ code when PREEMPT_RT is on, because in that mode even
> GFP_ATOMIC allocations cannot be performed.
> 
> Fixing this would require making stackdepot completely lockless, which
> is quite challenging and may be excessive for the time being.
> 
> Instead, make sure KMSAN is incompatible with PREEMPT_RT, like other
> debug configs are.
> 
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Dmitry Vyukov <dvyukov@google.com>
> Cc: Marco Elver <elver@google.com>
> Cc: Peter Zijlstra (Intel) <peterz@infradead.org>
> Link: https://lore.kernel.org/lkml/20221025221755.3810809-1-glider@google.com/
> Signed-off-by: Alexander Potapenko <glider@google.com>

Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>

> ---
>  lib/Kconfig.kmsan | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/lib/Kconfig.kmsan b/lib/Kconfig.kmsan
> index b2489dd6503fa..ef2c8f256c57d 100644
> --- a/lib/Kconfig.kmsan
> +++ b/lib/Kconfig.kmsan
> @@ -12,6 +12,7 @@ config KMSAN
>  	bool "KMSAN: detector of uninitialized values use"
>  	depends on HAVE_ARCH_KMSAN && HAVE_KMSAN_COMPILER
>  	depends on SLUB && DEBUG_KERNEL && !KASAN && !KCSAN
> +	depends on !PREEMPT_RT
>  	select STACKDEPOT
>  	select STACKDEPOT_ALWAYS_INIT
>  	help
> -- 
> 2.38.1.273.g43a17bfeac-goog
> 
