Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2EBB75F76A0
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Oct 2022 12:09:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229636AbiJGKJC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Oct 2022 06:09:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229453AbiJGKJA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Oct 2022 06:09:00 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F81195E4A
        for <linux-kernel@vger.kernel.org>; Fri,  7 Oct 2022 03:08:55 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 45454218F8;
        Fri,  7 Oct 2022 10:08:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1665137334; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=QCUtX+6Pp4BHdc+B7LF5dBVoNepGL493nNhdOWATKJA=;
        b=Oz1lqOvovtbmDHYNQxD/+K61Yr9/o3KejO6qDZ1dSCFg4dbsoJGuTB83E3FJLQ4svSP3YZ
        TwPhSnrp9eMo2hkEjHKWmdlpYap3RiZdfYjSr5xPosMGavstHiJ5a2FXCzjquvm+bZgeHQ
        T4xVT8WyCNjbeZOPjNXIWB6O5XenG08=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1665137334;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=QCUtX+6Pp4BHdc+B7LF5dBVoNepGL493nNhdOWATKJA=;
        b=VX2fui18sfZZxAPBvRU5oeB4LaDciqC+et2vB4JNXDam0Zc65zkRGaw5OiyzeHPhQ8FM2W
        tSEXh7q4DIN4c8DA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 0C79013A9A;
        Fri,  7 Oct 2022 10:08:54 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id F19xArb6P2NkIwAAMHmgww
        (envelope-from <vbabka@suse.cz>); Fri, 07 Oct 2022 10:08:54 +0000
Message-ID: <cd103df8-d0da-ab15-5755-c20631055986@suse.cz>
Date:   Fri, 7 Oct 2022 12:08:53 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.1
Subject: Re: [PATCH] mm: add stackdepot information on page->private for
 tracking
Content-Language: en-US
To:     "zhaoyang.huang" <zhaoyang.huang@unisoc.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Matthew Wilcox <willy@infradead.org>,
        Marco Elver <elver@google.com>,
        Imran Khan <imran.f.khan@oracle.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Zhaoyang Huang <huangzhaoyang@gmail.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, ke.wang@unisoc.com,
        steve.kang@unisoc.com
References: <1665026390-16096-1-git-send-email-zhaoyang.huang@unisoc.com>
From:   Vlastimil Babka <vbabka@suse.cz>
In-Reply-To: <1665026390-16096-1-git-send-email-zhaoyang.huang@unisoc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/6/22 05:19, zhaoyang.huang wrote:
> From: Zhaoyang Huang <zhaoyang.huang@unisoc.com>
> 
> Private is vacant for most of Non-LRU pages while the user has explicitly
> operation on page->private via set_page_private, I would like introduce
> stackdepot information on page->private for a simplified tracking mechanism
> which could be help for kernel driver's memory leak.
> 
> Signed-off-by: Zhaoyang Huang <zhaoyang.huang@unisoc.com>

This duplicates the existing page_owner functionality in a way that
unconditionally adds overhead to all kernels that have CONFIG_STACKDEPOT
enabled build-time (and also misses the need to initialize stackdepot properly).

Also wouldn't be suprised if some existing page->private users were actually
confused by the field suddenly being non-zero without their own action.

> ---
>  mm/page_alloc.c | 28 +++++++++++++++++++++++++++-
>  1 file changed, 27 insertions(+), 1 deletion(-)
> 
> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> index e5486d4..b79a503 100644
> --- a/mm/page_alloc.c
> +++ b/mm/page_alloc.c
> @@ -75,6 +75,7 @@
>  #include <linux/khugepaged.h>
>  #include <linux/buffer_head.h>
>  #include <linux/delayacct.h>
> +#include <linux/stackdepot.h>
>  #include <asm/sections.h>
>  #include <asm/tlbflush.h>
>  #include <asm/div64.h>
> @@ -2464,6 +2465,25 @@ static inline bool should_skip_init(gfp_t flags)
>  	return (flags & __GFP_SKIP_ZERO);
>  }
>  
> +#ifdef CONFIG_STACKDEPOT
> +static noinline depot_stack_handle_t set_track_prepare(void)
> +{
> +       depot_stack_handle_t trace_handle;
> +       unsigned long entries[16];
> +       unsigned int nr_entries;
> +
> +       nr_entries = stack_trace_save(entries, ARRAY_SIZE(entries), 3);
> +       trace_handle = stack_depot_save(entries, nr_entries, GFP_NOWAIT);
> +
> +       return trace_handle;
> +}
> +#else
> +static inline depot_stack_handle_t set_track_prepare(void)
> +{
> +       return 0;
> +}
> +#endif
> +
>  inline void post_alloc_hook(struct page *page, unsigned int order,
>  				gfp_t gfp_flags)
>  {
> @@ -2471,8 +2491,14 @@ inline void post_alloc_hook(struct page *page, unsigned int order,
>  			!should_skip_init(gfp_flags);
>  	bool init_tags = init && (gfp_flags & __GFP_ZEROTAGS);
>  	int i;
> +	depot_stack_handle_t stack_handle = set_track_prepare();
>  
> -	set_page_private(page, 0);
> +	/*
> +	 * Don't worry, user will cover private directly without checking
> +	 * this field and has ability to trace the page. This also will not
> +	 * affect expected state when freeing
> +	 */
> +	set_page_private(page, stack_handle);
>  	set_page_refcounted(page);
>  
>  	arch_alloc_page(page, order);

