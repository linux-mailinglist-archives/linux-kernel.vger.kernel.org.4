Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F9A15B6853
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Sep 2022 09:03:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230315AbiIMHDA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Sep 2022 03:03:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229821AbiIMHC6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Sep 2022 03:02:58 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 383DA14D14
        for <linux-kernel@vger.kernel.org>; Tue, 13 Sep 2022 00:02:56 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id DF4A7106F;
        Tue, 13 Sep 2022 00:03:02 -0700 (PDT)
Received: from [10.162.42.9] (unknown [10.162.42.9])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 123293F73B;
        Tue, 13 Sep 2022 00:03:21 -0700 (PDT)
Message-ID: <ea96d35e-46ae-c168-3186-ddf58ad6806c@arm.com>
Date:   Tue, 13 Sep 2022 12:32:50 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH 01/16] mm/page_alloc: ensure kswapd doesn't accidentally
 go to sleep
Content-Language: en-US
To:     Miaohe Lin <linmiaohe@huawei.com>, akpm@linux-foundation.org
Cc:     david@redhat.com, osalvador@suse.de, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
References: <20220909092451.24883-1-linmiaohe@huawei.com>
 <20220909092451.24883-2-linmiaohe@huawei.com>
From:   Anshuman Khandual <anshuman.khandual@arm.com>
In-Reply-To: <20220909092451.24883-2-linmiaohe@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-9.1 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 9/9/22 14:54, Miaohe Lin wrote:
> If ALLOC_KSWAPD is set, wake_all_kswapds() will be called to ensure
> kswapd doesn't accidentally go to sleep. But when reserve_flags is
> set, alloc_flags will be overwritten and ALLOC_KSWAPD is thus lost.
> Preserve the ALLOC_KSWAPD flag in alloc_flags to ensure kswapd won't
> go to sleep accidentally.

Currently wake_all_kswapds() gets skipped subsequently if ALLOC_KSWAPD
is lost, but this only happens when the 'retry:' loops is taken ?

> 
> Fixes: 0a79cdad5eb2 ("mm: use alloc_flags to record if kswapd can wake")
> Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
> ---
>  mm/page_alloc.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> index ba5c9402a5cb..4b97a03fa2dd 100644
> --- a/mm/page_alloc.c
> +++ b/mm/page_alloc.c
> @@ -5147,7 +5147,8 @@ __alloc_pages_slowpath(gfp_t gfp_mask, unsigned int order,
>  
>  	reserve_flags = __gfp_pfmemalloc_flags(gfp_mask);
>  	if (reserve_flags)
> -		alloc_flags = gfp_to_alloc_flags_cma(gfp_mask, reserve_flags);
> +		alloc_flags = gfp_to_alloc_flags_cma(gfp_mask, reserve_flags) |
> +					  (alloc_flags & ALLOC_KSWAPD);
>  
>  	/*
>  	 * Reset the nodemask and zonelist iterators if memory policies can be
