Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C9B36320DD
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Nov 2022 12:40:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230442AbiKULj7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Nov 2022 06:39:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229475AbiKULjj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Nov 2022 06:39:39 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45E85AA462
        for <linux-kernel@vger.kernel.org>; Mon, 21 Nov 2022 03:38:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=xnc8nrimE8ZadiLzj8YpVfbtMkFptDEBBCizLKH9Aho=; b=VKlX+D3bIqajcYrTsTiDrH8EJF
        p/weJ6/+0TBazPOjZ1tD6Pls1MPJFb4zg9qQJ2JwC0Ovt000qe1LmAIkxSaSJr6mARX6CgEgRJQA4
        PDCVFgIqymgIwVmZf4rAch6927esOgcb6UpdHT/B5vSz/j5zk+M1glZbnyNY5xsUYsjvuo6bE4lFZ
        eGrpOL9x35u7XeJMbkZOjGFq0L1H7dOob63H0CzFF2jlDYEe+PcQssQZEVX9lfsHgs0f84jCw823a
        5rki2s7jChJWtgLoiYaBIxaBTHI87+++nPdDCB2d75jpy0XFWWZCblcpF4iOomLx4MZBmtwGvaFli
        mvcTYUfQ==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1ox57z-005APH-Lv; Mon, 21 Nov 2022 11:38:24 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 50BF6300244;
        Mon, 21 Nov 2022 12:38:12 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 36098207A328C; Mon, 21 Nov 2022 12:38:12 +0100 (CET)
Date:   Mon, 21 Nov 2022 12:38:12 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Alexander Potapenko <glider@google.com>
Cc:     tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, x86@kernel.org,
        linux-kernel@vger.kernel.org, Eric Biggers <ebiggers@kernel.org>
Subject: Re: [PATCH] x86: suppress KMSAN reports in arch_within_stack_frames()
Message-ID: <Y3tjJPtzyi9PD9VD@hirez.programming.kicks-ass.net>
References: <20221118172305.3321253-1-glider@google.com>
 <Y3tRgGUKCxUoLeM8@hirez.programming.kicks-ass.net>
 <CAG_fn=Wpy8KA0cLBHapd7BdtnPHsRTpYip+z9TjfB1aUHUGH3g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAG_fn=Wpy8KA0cLBHapd7BdtnPHsRTpYip+z9TjfB1aUHUGH3g@mail.gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 21, 2022 at 11:28:39AM +0100, Alexander Potapenko wrote:

> > > +__no_kmsan_checks
> > >  static inline int arch_within_stack_frames(const void * const stack,
> > >                                          const void * const stackend,
> > >                                          const void *obj, unsigned long len)
> >
> > Seems OK; but now I'm confused as to the exact distinction between
> > __no_sanitize_memory and __no_kmsan_checks.
> >
> > The comments there about seem to suggest __no_sanitize_memory ensures no
> > instrumentation at all, and __no_kmsan_checks some instrumentation but
> > doesn't actually check anything -- so what's left then?
> 
> __no_sanitize_memory prohibits all instrumentation whatsoever, whereas
> __no_kmsan_checks adds instrumentation that suppresses potential false
> positives around this function.
> 
> Quoting include/linux/compiler-clang.h:
> 
> /*
>  * The __no_kmsan_checks attribute ensures that a function does not produce
>  * false positive reports by:
>  *  - initializing all local variables and memory stores in this function;
>  *  - skipping all shadow checks;
>  *  - passing initialized arguments to this function's callees.
>  */
> 
> Does this answer your question?

So I read that comment; and it didn't click. So you're explicitly
initializing variables/arguments and explicitly not checking shadow
state vs, not doing explicit initialization and checking shadow state?

That is, it doesn't do the normal checks and adds explicit
initialization to avoid triggering discontent in surrounding functions?

