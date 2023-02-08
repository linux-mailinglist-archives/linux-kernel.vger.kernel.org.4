Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B98068F6A6
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Feb 2023 19:11:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231143AbjBHSLH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Feb 2023 13:11:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229718AbjBHSLF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Feb 2023 13:11:05 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B9DD17160
        for <linux-kernel@vger.kernel.org>; Wed,  8 Feb 2023 10:10:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=6ckI3WTqph30NpxWFPDE4cvDOQBvbkyW3uZldKIaVSY=; b=JMPfVqhJbVn/kncnVS1BMxmG6J
        7sJHcR2ZcAolixI6M2MPAPnXWiuciSLsUMPrQleNPoAP5IvNhrdaZQfFVV8ePo6qqEP75miGAirfZ
        vk/ymwQJTYe7EUO26Xli+xTMEZLhLbJ8+6rsxLiBn93PmLcqbg+TMe16aAx815GFkG5NruFfsbTFN
        HWDKlIv91/hNuJXwL812aDfO1jQ3bIhdcrC4v8UMyi7ggxcqOoN5kk71Ft3U5xl1gdlCgy9vmWKxn
        Pq+bl2/gZjdJ0ZtW8pDASUNLM+nn1LBJp22WegAbq3DTWtgR6z2nKEbC+Fp0VY5fCiZ/7X9HdMVBk
        H69h1HXg==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pPotn-001RIT-AH; Wed, 08 Feb 2023 18:10:27 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 228CB300129;
        Wed,  8 Feb 2023 19:10:27 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 128FE20F05D4E; Wed,  8 Feb 2023 19:10:27 +0100 (CET)
Date:   Wed, 8 Feb 2023 19:10:26 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Arnd Bergmann <arnd@kernel.org>
Cc:     Josh Poimboeuf <jpoimboe@kernel.org>,
        Andrey Ryabinin <ryabinin.a.a@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        kasan-dev@googlegroups.com, Marco Elver <elver@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Alexander Potapenko <glider@google.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Andrey Konovalov <andreyknvl@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Kuan-Ying Lee <Kuan-Ying.Lee@mediatek.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/4] kasan: mark addr_has_metadata __always_inline
Message-ID: <Y+Plku4Cf5Xkzq10@hirez.programming.kicks-ass.net>
References: <20230208164011.2287122-1-arnd@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230208164011.2287122-1-arnd@kernel.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 08, 2023 at 05:39:55PM +0100, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> When the compiler decides not to inline this function, objdump
> complains about incorrect UACCESS state:
> 
> mm/kasan/generic.o: warning: objtool: __asan_load2+0x11: call to addr_has_metadata() with UACCESS enabled
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>

> ---
>  mm/kasan/kasan.h | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/mm/kasan/kasan.h b/mm/kasan/kasan.h
> index 3231314e071f..9377b0789edc 100644
> --- a/mm/kasan/kasan.h
> +++ b/mm/kasan/kasan.h
> @@ -297,7 +297,7 @@ static inline const void *kasan_shadow_to_mem(const void *shadow_addr)
>  		<< KASAN_SHADOW_SCALE_SHIFT);
>  }
>  
> -static inline bool addr_has_metadata(const void *addr)
> +static __always_inline bool addr_has_metadata(const void *addr)
>  {
>  	return (kasan_reset_tag(addr) >=
>  		kasan_shadow_to_mem((void *)KASAN_SHADOW_START));
> @@ -316,7 +316,7 @@ bool kasan_check_range(unsigned long addr, size_t size, bool write,
>  
>  #else /* CONFIG_KASAN_GENERIC || CONFIG_KASAN_SW_TAGS */
>  
> -static inline bool addr_has_metadata(const void *addr)
> +static __always_inline bool addr_has_metadata(const void *addr)
>  {
>  	return (is_vmalloc_addr(addr) || virt_addr_valid(addr));
>  }
> -- 
> 2.39.1
> 
