Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F6C4616312
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Nov 2022 13:52:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231183AbiKBMwj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Nov 2022 08:52:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231171AbiKBMwf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Nov 2022 08:52:35 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05352240B5
        for <linux-kernel@vger.kernel.org>; Wed,  2 Nov 2022 05:52:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=YtVLJDGnn7ITBTMOUDCPITBmCHvZxC85F8h8cyu+d2Y=; b=wStI0I+5aFJGZYgieIMHRamzlN
        cJkv1hLJsWQC+ELiG6ND3SV24GosCkHQwLhwwcWKeJDN9QG9s17YH+lTZ7TxTu2rUlJbbK7rGZpJQ
        ki2+vtvMbzI9xMPZIV01B9SJKr377vPE4EBaFZeW725TOZiIcr1akKi7yE4Gr73HYA6Le7Yhpv8En
        cer5fWFmOe9J/7YMoASt+1mGiT62hsKI3tqM5208K+RE6GZTmbJ1SObHfJaPLoXmC54t1k34ZYemz
        LDoz/EF/AeHXUiGKuBXOCIOxzHPPp3+n1Hf7R2SeWOl7TsP5GwImV5K14dW5q8M9ZwOGo41rQC686
        fgRfTlHg==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1oqDER-005WTr-On; Wed, 02 Nov 2022 12:52:35 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id A188630007E;
        Wed,  2 Nov 2022 13:52:29 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 9346B20B1E7E2; Wed,  2 Nov 2022 13:52:29 +0100 (CET)
Date:   Wed, 2 Nov 2022 13:52:29 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Alexander Potapenko <glider@google.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Dmitry Vyukov <dvyukov@google.com>,
        Marco Elver <elver@google.com>
Subject: Re: [PATCH 1/5] kmsan: core: kmsan_in_runtime() should return true
 in NMI context
Message-ID: <Y2JoDQyeqw9kO0KP@hirez.programming.kicks-ass.net>
References: <20221102110611.1085175-1-glider@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221102110611.1085175-1-glider@google.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 02, 2022 at 12:06:07PM +0100, Alexander Potapenko wrote:
> Without that, every call to __msan_poison_alloca() in NMI may end up
> allocating memory, which is NMI-unsafe.
> 
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Dmitry Vyukov <dvyukov@google.com>
> Cc: Marco Elver <elver@google.com>
> Cc: Peter Zijlstra (Intel) <peterz@infradead.org>
> Link: https://lore.kernel.org/lkml/20221025221755.3810809-1-glider@google.com/
> Signed-off-by: Alexander Potapenko <glider@google.com>

Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>

> ---
>  mm/kmsan/kmsan.h | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/mm/kmsan/kmsan.h b/mm/kmsan/kmsan.h
> index 961eb658020aa..3cd2050a33e6a 100644
> --- a/mm/kmsan/kmsan.h
> +++ b/mm/kmsan/kmsan.h
> @@ -125,6 +125,8 @@ static __always_inline bool kmsan_in_runtime(void)
>  {
>  	if ((hardirq_count() >> HARDIRQ_SHIFT) > 1)
>  		return true;
> +	if (in_nmi())
> +		return true;
>  	return kmsan_get_context()->kmsan_in_runtime;
>  }
>  
> -- 
> 2.38.1.273.g43a17bfeac-goog
> 
