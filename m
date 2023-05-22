Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D231870B943
	for <lists+linux-kernel@lfdr.de>; Mon, 22 May 2023 11:43:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232568AbjEVJnZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 May 2023 05:43:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232599AbjEVJnT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 May 2023 05:43:19 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD9C8B4
        for <linux-kernel@vger.kernel.org>; Mon, 22 May 2023 02:42:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1684748555;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Do07Fhmu/G1ekKU27xEBHKcUKlQWkvuStGz3aFQISYI=;
        b=IoKdiO1TRYlk1lOaPnP5YujJ+p45qnqO/3FoguoskPcd+zCJ8disk8+q2h8QMLtWFQB4o7
        H33IB5s6KeJ5oy17gfBat+4sXJpjMtzMxwBZSEmiVR6UVOjsJdUoUnBR2eBpxWheYEjCRb
        5AJeEZQhW4Z9u4Y1yI9d1qsOuagxur8=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-589-6c76RTScNsiN24YkIMD1yg-1; Mon, 22 May 2023 05:42:33 -0400
X-MC-Unique: 6c76RTScNsiN24YkIMD1yg-1
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-30479b764f9so2110779f8f.0
        for <linux-kernel@vger.kernel.org>; Mon, 22 May 2023 02:42:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684748553; x=1687340553;
        h=content-transfer-encoding:in-reply-to:subject:organization:from
         :references:cc:to:content-language:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Do07Fhmu/G1ekKU27xEBHKcUKlQWkvuStGz3aFQISYI=;
        b=k9+24RynMKIvvyHziY80gWuQHPa8vR7fxkOTHZxwsa1/oJzu2CF9+6OUsfnITbNG4N
         VovLZ8oYENRt6DIoxuL6sOFx0Ux2Ek6vA+nhFo7bM2WdQOaS9aHZhn/5m/q9IwLSCfB/
         EN+SLy4jrN8G8fSzVj3KbqqyB/+pSvDs2H74ywg2LtCeS3wzLXQJNMdWSIEbJt7fy0B1
         SY2MJFtR1WufjZX8HqCeghJkK5lbp8e5ctNeLmCQw1oow7H+wugaf71hwppjybzRWasl
         RLMqZyY+rIqCrkeFxHKCt19OtsmXQ6DgKUPmTxo4My/MKT0ZFRfc+9xRcyEbut6Z5FeA
         gt9w==
X-Gm-Message-State: AC+VfDyhSl/KSb4mpw2LUS1bZG0moMMeSZnSdDfxo1VqTvkFcCWTyUjY
        Nqjagz4JQTDEnSMT9mLTPwOr2oGea1L5kwQkX01RWNAzTFJg3sKTz9Bb+yT7Gc4UD1nbgSaFidZ
        A35ZatVfQ8aNS5k7ePjx31mRV
X-Received: by 2002:adf:e984:0:b0:309:2b6:5c83 with SMTP id h4-20020adfe984000000b0030902b65c83mr6791927wrm.1.1684748552717;
        Mon, 22 May 2023 02:42:32 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ5GFjHLXxcU7kHH08QtqYxFdFl9Z3iIwNczbSyw49WBfSkwQClIFuhNR5wz4vNadm54JXPVxg==
X-Received: by 2002:adf:e984:0:b0:309:2b6:5c83 with SMTP id h4-20020adfe984000000b0030902b65c83mr6791904wrm.1.1684748552210;
        Mon, 22 May 2023 02:42:32 -0700 (PDT)
Received: from ?IPV6:2003:cb:c742:c800:d74f:aec6:f8ac:558? (p200300cbc742c800d74faec6f8ac0558.dip0.t-ipconnect.de. [2003:cb:c742:c800:d74f:aec6:f8ac:558])
        by smtp.gmail.com with ESMTPSA id z12-20020a5d640c000000b00307c8d6b4a0sm7119870wru.26.2023.05.22.02.42.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 22 May 2023 02:42:31 -0700 (PDT)
Message-ID: <b4dce681-e53c-a6fd-2dab-62a82ebc6dff@redhat.com>
Date:   Mon, 22 May 2023 11:42:30 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Content-Language: en-US
To:     David Rientjes <rientjes@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@kernel.org>, Alex Shi <alexs@kernel.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Matthew Wilcox <willy@infradead.org>,
        Alexander Duyck <alexanderduyck@fb.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Linus Torvalds <torvalds@linux-foundation.org>
References: <c9abf109-80f2-88f5-4aae-d6fd4a30bcd3@google.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
Subject: Re: [patch] mm, debug: allow suppressing panic on CONFIG_DEBUG_VM
 checks
In-Reply-To: <c9abf109-80f2-88f5-4aae-d6fd4a30bcd3@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Let me CC Linus, he might have an opinion on this.

On 22.05.23 01:07, David Rientjes wrote:
> CONFIG_DEBUG_VM is used to enable additional MM debug checks at runtime.
> This can be used to catch latent kernel bugs.
> 
> Because this is mainly used for debugging, it is seldom enabled in
> production environments, including due to the added performance overhead.
> Thus, the choice between VM_BUG_ON() and VM_WARN_ON() is somewhat loosely
> defined.
> 
> VM_BUG_ON() is often used because debuggers would like to collect crash
> dumps when unexpected conditions occur.
> 
> When CONFIG_DEBUG_VM is enabled on a very small set of production
> deployments to catch any unexpected condition, however, VM_WARN_ON()
> could be used as a substitute.  In these configurations, it would be
> useful to surface the unexpected condition in the kernel log but not
> panic the system.
> 
> In other words, it would be useful if checks done by CONFIG_DEBUG_ON
> could both generate crash dumps for kernel developers *and* surface
> issues but not crash depending on how it's configured.
> 
>   [ If it is really unsafe to continue operation, then BUG_ON() would be
>     used instead so that the kernel panics regardless of whether
>     CONFIG_DEBUG_VM is enabled or not. ]
> 
> Introduce the ability to suppress kernel panics when VM_BUG_ON*() variants
> are used.  This leverages the existing vm_debug= kernel command line
> option.
> 
> Additionally, this can reduce the risk of systems boot looping if
> VM_BUG_ON() conditions are encountered during bootstrap.
> 
> Signed-off-by: David Rientjes <rientjes@google.com>
> ---
> Note: the vm_debug= kernel parameter is only extensible for new debug
> options, not for disabling existing debug options.
> 
> When adding the ability to selectively disable existing debug options,
> such as in this patch, admins would need to know this future set of debug
> options in advance.  In other words, if admins would like to preserve the
> existing behavior of BUG() when VM_BUG_ON() is used after this patch, they
> would have had to have the foresight to use vm_debug=B.
> 
> It would be useful to rewrite the vm_debug= interface to select the
> specific options to disable rather than "disable all, and enable those
> that are specified."  This could be done by making vm_debug only disable
> the listed debug options rather than enabling them.
> 
> This change could be done before this patch is merged if that's the agreed
> path forward.


In general, I am not a fan of this. Someone told the system to 
VM_BUG_ON, but we ignore that and default to a warning. Yes, VM_BUG on 
get compiled out without CONFIG_DEBUG_VM, but we detected something 
(with more checks enabled!) that doesn't want the system to continue 
(could be an unrecoverable situation leading to data loss, for example).

Yes, we want to convert more VM_BUG to VM_WARN (or rather WARN+recovery 
code as documented in coding-style.rst ), or even simply remove some of 
the old VM_BUG leftovers that might no longer be required. But then I'd 
much invest more time doing that step by step (keeping the VM_BUG + BUG 
that are absolutely reasonable) instead of adding such a config options.


> ---
>   .../admin-guide/kernel-parameters.txt         |  1 +
>   include/linux/mmdebug.h                       | 20 ++++++++++++++-----
>   mm/debug.c                                    | 14 ++++++++++++-
>   3 files changed, 29 insertions(+), 6 deletions(-)
> 
> diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
> --- a/Documentation/admin-guide/kernel-parameters.txt
> +++ b/Documentation/admin-guide/kernel-parameters.txt
> @@ -6818,6 +6818,7 @@
>   			debugging features.
>   
>   			Available options are:
> +			  B	Enable panic on MM debug checks
>   			  P	Enable page structure init time poisoning
>   			  -	Disable all of the above options
>   
> diff --git a/include/linux/mmdebug.h b/include/linux/mmdebug.h
> --- a/include/linux/mmdebug.h
> +++ b/include/linux/mmdebug.h
> @@ -13,34 +13,44 @@ void dump_page(struct page *page, const char *reason);
>   void dump_vma(const struct vm_area_struct *vma);
>   void dump_mm(const struct mm_struct *mm);
>   
> +extern bool debug_vm_bug_enabled;
> +
>   #ifdef CONFIG_DEBUG_VM
> -#define VM_BUG_ON(cond) BUG_ON(cond)
> +#define VM_BUG_ON(cond)							\
> +	do {								\
> +		if (unlikely(cond)) {					\
> +			if (likely(debug_vm_bug_enabled))		\
> +				BUG();					\
> +			else						\
> +				WARN_ON(1);				\
> +		}							\
> +	} while (0)
>   #define VM_BUG_ON_PAGE(cond, page)					\
>   	do {								\
>   		if (unlikely(cond)) {					\
>   			dump_page(page, "VM_BUG_ON_PAGE(" __stringify(cond)")");\
> -			BUG();						\
> +			VM_BUG_ON(1);					\
>   		}							\
>   	} while (0)
>   #define VM_BUG_ON_FOLIO(cond, folio)					\
>   	do {								\
>   		if (unlikely(cond)) {					\
>   			dump_page(&folio->page, "VM_BUG_ON_FOLIO(" __stringify(cond)")");\
> -			BUG();						\
> +			VM_BUG_ON(1);					\
>   		}							\
>   	} while (0)
>   #define VM_BUG_ON_VMA(cond, vma)					\
>   	do {								\
>   		if (unlikely(cond)) {					\
>   			dump_vma(vma);					\
> -			BUG();						\
> +			VM_BUG_ON(1);					\
>   		}							\
>   	} while (0)
>   #define VM_BUG_ON_MM(cond, mm)						\
>   	do {								\
>   		if (unlikely(cond)) {					\
>   			dump_mm(mm);					\
> -			BUG();						\
> +			VM_BUG_ON(1);					\
>   		}							\
>   	} while (0)
>   #define VM_WARN_ON_ONCE_PAGE(cond, page)	({			\
> diff --git a/mm/debug.c b/mm/debug.c
> --- a/mm/debug.c
> +++ b/mm/debug.c
> @@ -224,10 +224,15 @@ void dump_mm(const struct mm_struct *mm)
>   }
>   EXPORT_SYMBOL(dump_mm);
>   
> +/* If disabled, warns but does not panic on added CONFIG_DEBUG_VM checks */
> +bool debug_vm_bug_enabled = true;
> +EXPORT_SYMBOL(debug_vm_bug_enabled);
> +
>   static bool page_init_poisoning __read_mostly = true;
>   
>   static int __init setup_vm_debug(char *str)
>   {
> +	bool __debug_vm_bug_enabled = true;
>   	bool __page_init_poisoning = true;
>   
>   	/*
> @@ -237,13 +242,17 @@ static int __init setup_vm_debug(char *str)
>   	if (*str++ != '=' || !*str)
>   		goto out;
>   
> +	__debug_vm_bug_enabled = false;
>   	__page_init_poisoning = false;
>   	if (*str == '-')
>   		goto out;
>   
>   	while (*str) {
>   		switch (tolower(*str)) {
> -		case'p':
> +		case 'b':
> +			__debug_vm_bug_enabled = true;
> +			break;
> +		case 'p':
>   			__page_init_poisoning = true;
>   			break;
>   		default:
> @@ -254,9 +263,12 @@ static int __init setup_vm_debug(char *str)
>   		str++;
>   	}
>   out:
> +	if (debug_vm_bug_enabled && !__debug_vm_bug_enabled)
> +		pr_warn("Panic on MM debug checks disabled by kernel command line option 'vm_debug'\n");
>   	if (page_init_poisoning && !__page_init_poisoning)
>   		pr_warn("Page struct poisoning disabled by kernel command line option 'vm_debug'\n");
>   
> +	debug_vm_bug_enabled = __debug_vm_bug_enabled;
>   	page_init_poisoning = __page_init_poisoning;
>   
>   	return 1;
> 

-- 
Thanks,

David / dhildenb

