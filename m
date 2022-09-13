Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0BAAF5B6C3D
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Sep 2022 13:12:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231648AbiIMLMe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Sep 2022 07:12:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231358AbiIMLMb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Sep 2022 07:12:31 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 6438852088
        for <linux-kernel@vger.kernel.org>; Tue, 13 Sep 2022 04:12:30 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8C31C1063;
        Tue, 13 Sep 2022 04:12:36 -0700 (PDT)
Received: from [10.163.58.193] (unknown [10.163.58.193])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 2A3403F71A;
        Tue, 13 Sep 2022 04:12:27 -0700 (PDT)
Message-ID: <a6c5567a-995c-0d5e-d979-b1b0882173b0@arm.com>
Date:   Tue, 13 Sep 2022 16:42:24 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH 15/16] mm/page_alloc: remove obsolete
 gfpflags_normal_context()
Content-Language: en-US
To:     Miaohe Lin <linmiaohe@huawei.com>, akpm@linux-foundation.org
Cc:     david@redhat.com, osalvador@suse.de, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
References: <20220909092451.24883-1-linmiaohe@huawei.com>
 <20220909092451.24883-16-linmiaohe@huawei.com>
From:   Anshuman Khandual <anshuman.khandual@arm.com>
In-Reply-To: <20220909092451.24883-16-linmiaohe@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.5 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 9/9/22 14:54, Miaohe Lin wrote:
> Since commit dacb5d8875cc ("tcp: fix page frag corruption on page
> fault"), there's no caller of gfpflags_normal_context(). Remove it
> as this helper is strictly tied to the sk page frag usage and there
> won't be other user in the future.
> 
> Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>

Reviewed-by: Anshuman Khandual <anshuman.khandual@arm.com>

> ---
>  include/linux/gfp.h | 23 -----------------------
>  1 file changed, 23 deletions(-)
> 
> diff --git a/include/linux/gfp.h b/include/linux/gfp.h
> index ea6cb9399152..ef4aea3b356e 100644
> --- a/include/linux/gfp.h
> +++ b/include/linux/gfp.h
> @@ -36,29 +36,6 @@ static inline bool gfpflags_allow_blocking(const gfp_t gfp_flags)
>  	return !!(gfp_flags & __GFP_DIRECT_RECLAIM);
>  }
>  
> -/**
> - * gfpflags_normal_context - is gfp_flags a normal sleepable context?
> - * @gfp_flags: gfp_flags to test
> - *
> - * Test whether @gfp_flags indicates that the allocation is from the
> - * %current context and allowed to sleep.
> - *
> - * An allocation being allowed to block doesn't mean it owns the %current
> - * context.  When direct reclaim path tries to allocate memory, the
> - * allocation context is nested inside whatever %current was doing at the
> - * time of the original allocation.  The nested allocation may be allowed
> - * to block but modifying anything %current owns can corrupt the outer
> - * context's expectations.
> - *
> - * %true result from this function indicates that the allocation context
> - * can sleep and use anything that's associated with %current.
> - */
> -static inline bool gfpflags_normal_context(const gfp_t gfp_flags)
> -{
> -	return (gfp_flags & (__GFP_DIRECT_RECLAIM | __GFP_MEMALLOC)) ==
> -		__GFP_DIRECT_RECLAIM;
> -}
> -
>  #ifdef CONFIG_HIGHMEM
>  #define OPT_ZONE_HIGHMEM ZONE_HIGHMEM
>  #else
