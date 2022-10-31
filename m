Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7DE51613366
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Oct 2022 11:15:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229909AbiJaKP2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Oct 2022 06:15:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229620AbiJaKPX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Oct 2022 06:15:23 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B84FCE3B
        for <linux-kernel@vger.kernel.org>; Mon, 31 Oct 2022 03:15:21 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id ABBD533712;
        Mon, 31 Oct 2022 10:15:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1667211315; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=9NSYUTg7UfCJA+CQRR8S+uUBhAxqW3ri0yU6NXT2ryE=;
        b=AcuKRECfDXYjYNPUktvOEBKP9Y0tVTVk7/3W1GHkRWddmNwa+8k91t+TV+ixrMuDqrhWHe
        JmgdKjKRqcUIsk+465p6RwhRG+cBEnwkSRhfOvEF8LyyJG9HjcKSVYDx91JqFE1qngLuIz
        GPiClrNoZyZN5SAp54aIZPTdNuV04jM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1667211315;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=9NSYUTg7UfCJA+CQRR8S+uUBhAxqW3ri0yU6NXT2ryE=;
        b=8Mm8FxEH+lKsazmIC1gH5khi2+2/lsvlozLz0q65Bnu54lqqrCrTZQFFUu96003BtRk+ln
        on5jxT7ZxQb1L2DA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 807D713451;
        Mon, 31 Oct 2022 10:15:15 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id Z+pJHjOgX2N3dAAAMHmgww
        (envelope-from <vbabka@suse.cz>); Mon, 31 Oct 2022 10:15:15 +0000
Message-ID: <f53653bd-aab1-637e-c034-62761f262a03@suse.cz>
Date:   Mon, 31 Oct 2022 11:15:15 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.0
Subject: Re: [PATCHv3] mm: use stack_depot for recording kmemleak's backtrace
Content-Language: en-US
To:     "zhaoyang.huang" <zhaoyang.huang@unisoc.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Matthew Wilcox <willy@infradead.org>,
        Zhaoyang Huang <huangzhaoyang@gmail.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, ke.wang@unisoc.com,
        steve.kang@unisoc.com
References: <1667101354-4669-1-git-send-email-zhaoyang.huang@unisoc.com>
From:   Vlastimil Babka <vbabka@suse.cz>
In-Reply-To: <1667101354-4669-1-git-send-email-zhaoyang.huang@unisoc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/30/22 04:42, zhaoyang.huang wrote:
> From: Zhaoyang Huang <zhaoyang.huang@unisoc.com>
> 
> Using stack_depot to record kmemleak's backtrace which has been implemented
> on slub for reducing redundant information.
> 
> Signed-off-by: Zhaoyang Huang <zhaoyang.huang@unisoc.com>
> Acked-by: Catalin Marinas <catalin.marinas@arm.com>
> Cc: ke.wang <ke.wang@unisoc.com>
> Cc: Matthew Wilcox (Oracle) <willy@infradead.org>
> Cc: Vlastimil Babka <vbabka@suse.cz>
> Cc: Zhaoyang Huang <huangzhaoyang@gmail.com>
> Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
> ---
> changes of v2: fix bugs of stack_depot_init related issue
> changes of v3: have DEBUG_KMEMLEAK select STACK_DEPOT by default
>                remove unuse functions
> ---
> ---
>  lib/Kconfig.debug |  1 +
>  mm/kmemleak.c     | 48 +++++++++++++++++++++++++++++-------------------
>  2 files changed, 30 insertions(+), 19 deletions(-)
> 
> diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
> index bcbe60d..0def8e0 100644
> --- a/lib/Kconfig.debug
> +++ b/lib/Kconfig.debug
> @@ -717,6 +717,7 @@ config DEBUG_KMEMLEAK
>  	select STACKTRACE if STACKTRACE_SUPPORT
>  	select KALLSYMS
>  	select CRC32
> +	select STACKDEPOT

Should be also "if STACKTRACE_SUPPORT" as for the "select STACKTRACE" above,
but then you would have to deal with the case that stackdepot isn't
available - e.g. like in mm/slub.c use #ifdef CONFIG_STACKDEPOT where needed.

However, the "select STACKTRACE if STACKTRACE_SUPPORT" above was AFAICS
already subtly broken as the existing stacktrace handling calls in kmemleak
would also fail to compile/link on architectures/configs where
STACKTRACE_SUPPORT was not available and thus STACKTRACE not selected.
I assume it all relies on "depends on DEBUG_KERNEL && HAVE_DEBUG_KMEMLEAK"
where HAVE_DEBUG_KMEMLEAK is explicitly selected in a number of
arch/$arch/Kconfig files, and I assume all those have STACKTRACE_SUPPORT
selected as well.

But it's subtle and in that case we could just be more explicit, like
page_owner is, which just requires STACKTRACE/STACKDEPOT explicitly on
Kconfig level:

depends on DEBUG_KERNEL && STACKTRACE_SUPPORT
  (for kmemleak we would add HAVE_DEBUG_KMEMLEAK too)
select STACKTRACE
select STACKDEPOT

bonus points for moving the kmemleak config from lib/Kconfig.debug to
mm/Kconfig.debug - looks like we missed it in the cleanups earlier this year.

>  	help
>  	  Say Y here if you want to enable the memory leak
>  	  detector. The memory allocation/freeing is traced in a way

...

>  
> -/*
> - * Save stack trace to the given array of MAX_TRACE size.
> - */
> -static int __save_stack_trace(unsigned long *trace)
> +static noinline depot_stack_handle_t set_track_prepare(void)
>  {
> -	return stack_trace_save(trace, MAX_TRACE, 2);
> +	depot_stack_handle_t trace_handle;
> +	unsigned long entries[MAX_TRACE];
> +	unsigned int nr_entries;
> +
> +	if (!kmemleak_initialized)
> +		return 0;

I suspect this check might not be necessary if you switched from
stack_depot_init() to stack_depot_want_early_init(), see how page_owner does
this in early_page_owner_param().

Here we have kmemleak_boot_config() but it's more tricky as not having any
kmemleak param means it should be enabled by default and then the function
is not called at all, hm. Maybe use an early_initcall()?

> +	nr_entries = stack_trace_save(entries, ARRAY_SIZE(entries), 3);
> +	trace_handle = stack_depot_save(entries, nr_entries, GFP_NOWAIT);
> +
> +	return trace_handle;
>  }
>  
>  /*
> @@ -654,7 +664,7 @@ static struct kmemleak_object *__create_object(unsigned long ptr, size_t size,
>  	}
>  
>  	/* kernel backtrace */
> -	object->trace_len = __save_stack_trace(object->trace);
> +	object->trace_handle = set_track_prepare();
>  
>  	raw_spin_lock_irqsave(&kmemleak_lock, flags);
>  
> @@ -694,7 +704,6 @@ static struct kmemleak_object *__create_object(unsigned long ptr, size_t size,
>  	rb_link_node(&object->rb_node, rb_parent, link);
>  	rb_insert_color(&object->rb_node, is_phys ? &object_phys_tree_root :
>  					  &object_tree_root);
> -
>  	list_add_tail_rcu(&object->object_list, &object_list);
>  out:
>  	raw_spin_unlock_irqrestore(&kmemleak_lock, flags);
> @@ -1094,7 +1103,7 @@ void __ref kmemleak_update_trace(const void *ptr)
>  	}
>  
>  	raw_spin_lock_irqsave(&object->lock, flags);
> -	object->trace_len = __save_stack_trace(object->trace);
> +	object->trace_handle = set_track_prepare();
>  	raw_spin_unlock_irqrestore(&object->lock, flags);
>  
>  	put_object(object);
> @@ -2064,6 +2073,7 @@ void __init kmemleak_init(void)
>  	if (kmemleak_error)
>  		return;
>  
> +	stack_depot_init();
>  	jiffies_min_age = msecs_to_jiffies(MSECS_MIN_AGE);
>  	jiffies_scan_wait = msecs_to_jiffies(SECS_SCAN_WAIT * 1000);
>  

