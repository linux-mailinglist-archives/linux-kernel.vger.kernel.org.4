Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA7DF70BCDD
	for <lists+linux-kernel@lfdr.de>; Mon, 22 May 2023 14:04:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233441AbjEVMEl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 May 2023 08:04:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230219AbjEVMEj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 May 2023 08:04:39 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4ED8C6
        for <linux-kernel@vger.kernel.org>; Mon, 22 May 2023 05:03:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1684757022;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=V3Lhaor4pwQIZ8FBVp2472SUVuBYL6WQS2OjZrMkJpc=;
        b=hc/DdOk+f6jP5uHVQf/grA3HqYDlPyBhj7e4e51hZXd5TZOfwSKfeLZRcIZy/SXLc0kAKj
        Ll6qwDt96ey2Sbg6E3FjOciwE5UVO8QoB/FYPaAlJUOeSTsnpuoWtIPBUVXe2oszS17H7U
        +kDBSN2ezOBF+GAd1ZuTsK0pqV+eA6k=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-116-KpEo1mbgMU-hJwzffbG0cA-1; Mon, 22 May 2023 08:03:40 -0400
X-MC-Unique: KpEo1mbgMU-hJwzffbG0cA-1
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-3f6089a9689so516495e9.1
        for <linux-kernel@vger.kernel.org>; Mon, 22 May 2023 05:03:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684757019; x=1687349019;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=V3Lhaor4pwQIZ8FBVp2472SUVuBYL6WQS2OjZrMkJpc=;
        b=U9AhAW1EtYxg0zTh8e483OnM+NgaSGWf/ipuMFuDll3H486belbUYwZr6DX5Mn2/it
         IcceeFkxQQ1bIApv0w55jWl5tRsvRtNxkAYkhSQmlmJKBK9uzAjN1ep5FUJziF1HkZhi
         4IfaQa/kUk/7Myr2caJk48sHTayyd4c+MzLkNDBGd5MkeI5SO7brUjVkk9guAWtbrNj+
         zyxIx06VecwLJ76nYgtdKfKOsQgN30CkpRKDvx6ZwY9ze6ysE8gpEzPos/VRGKBbwBJw
         CDDkAoeF+3xznzHS1iSPdozef+z8CRxW7nwMTD7WvPGR75n8hs5BJ5XZJ5iYGWXKYSRc
         OxOQ==
X-Gm-Message-State: AC+VfDwl4Aymuf1iCEi46HcxljdqY+YiqVub00/4puAKFsmAdvqt84gh
        MhqL1Q6sZUZFHaIBK1QhWCi2gg4fbwbCg4Qf7ssgW3jBO+ZuDM/qvhtSqXz46k38pgge10Nhl2m
        +X+rnAVFZAzxumREGveVJzZnp
X-Received: by 2002:adf:ef48:0:b0:2f8:f3da:72cf with SMTP id c8-20020adfef48000000b002f8f3da72cfmr8194259wrp.18.1684757019589;
        Mon, 22 May 2023 05:03:39 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ7LKj7uvbKNKZrF7jijaIoeN9nK+rx43j6qxUUp9A6OUqm0WGQT1iXH4yKW15xAYitBjN7vpg==
X-Received: by 2002:adf:ef48:0:b0:2f8:f3da:72cf with SMTP id c8-20020adfef48000000b002f8f3da72cfmr8194173wrp.18.1684757018360;
        Mon, 22 May 2023 05:03:38 -0700 (PDT)
Received: from ?IPV6:2003:cb:c742:c800:d74f:aec6:f8ac:558? (p200300cbc742c800d74faec6f8ac0558.dip0.t-ipconnect.de. [2003:cb:c742:c800:d74f:aec6:f8ac:558])
        by smtp.gmail.com with ESMTPSA id m9-20020a7bce09000000b003f4247fbb5fsm11290703wmc.10.2023.05.22.05.03.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 22 May 2023 05:03:37 -0700 (PDT)
Message-ID: <200a094f-7ca9-8a64-1c9b-7cf2e546f3eb@redhat.com>
Date:   Mon, 22 May 2023 14:03:36 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH -V2 3/5] swap: remove __swp_swapcount()
Content-Language: en-US
To:     Huang Ying <ying.huang@intel.com>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Hugh Dickins <hughd@google.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Matthew Wilcox <willy@infradead.org>,
        Michal Hocko <mhocko@suse.com>,
        Minchan Kim <minchan@kernel.org>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        Yang Shi <shy828301@gmail.com>, Yu Zhao <yuzhao@google.com>
References: <20230522070905.16773-1-ying.huang@intel.com>
 <20230522070905.16773-4-ying.huang@intel.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <20230522070905.16773-4-ying.huang@intel.com>
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

On 22.05.23 09:09, Huang Ying wrote:
> __swp_swapcount() just encloses the calling to swap_swapcount() with
> get/put_swap_device().  It is called in __read_swap_cache_async()
> only, which encloses the calling with get/put_swap_device() already.
> So, __read_swap_cache_async() can call swap_swapcount() directly.

The previous patch contained the hunk

-		if (!__swp_swapcount(entry) && swap_slot_cache_enabled)
-			return NULL;
+		if (!swap_swapcount(si, entry) && swap_slot_cache_enabled)
+			goto fail;
  

So something is a bit off here. Either that hunk should go here, or
this patch description has to be adjusted.


But I guess patch #2 doesn't compile on its own because this patch
here adds swap_swapcount() to include/linux/swap.h ?

> 
> Signed-off-by: "Huang, Ying" <ying.huang@intel.com>
> Cc: David Hildenbrand <david@redhat.com>
> Cc: Hugh Dickins <hughd@google.com>
> Cc: Johannes Weiner <hannes@cmpxchg.org>
> Cc: Matthew Wilcox <willy@infradead.org>
> Cc: Michal Hocko <mhocko@suse.com>
> Cc: Minchan Kim <minchan@kernel.org>
> Cc: Tim Chen <tim.c.chen@linux.intel.com>
> Cc: Yang Shi <shy828301@gmail.com>
> Cc: Yu Zhao <yuzhao@google.com>
> ---
>   include/linux/swap.h |  4 ++--
>   mm/swapfile.c        | 20 +-------------------
>   2 files changed, 3 insertions(+), 21 deletions(-)
> 
> diff --git a/include/linux/swap.h b/include/linux/swap.h
> index 3c69cb653cb9..f6bd51aa05ea 100644
> --- a/include/linux/swap.h
> +++ b/include/linux/swap.h
> @@ -512,7 +512,7 @@ int find_first_swap(dev_t *device);
>   extern unsigned int count_swap_pages(int, int);
>   extern sector_t swapdev_block(int, pgoff_t);
>   extern int __swap_count(swp_entry_t entry);
> -extern int __swp_swapcount(swp_entry_t entry);
> +extern int swap_swapcount(struct swap_info_struct *si, swp_entry_t entry);
>   extern int swp_swapcount(swp_entry_t entry);
>   extern struct swap_info_struct *page_swap_info(struct page *);
>   extern struct swap_info_struct *swp_swap_info(swp_entry_t entry);
> @@ -590,7 +590,7 @@ static inline int __swap_count(swp_entry_t entry)
>   	return 0;
>   }
>   
> -static inline int __swp_swapcount(swp_entry_t entry)
> +static inline int swap_swapcount(struct swap_info_struct *si, swp_entry_t entry)
>   {
>   	return 0;
>   }
> diff --git a/mm/swapfile.c b/mm/swapfile.c
> index 8419cba9c192..e9cce775fb25 100644
> --- a/mm/swapfile.c
> +++ b/mm/swapfile.c
> @@ -1443,7 +1443,7 @@ int __swap_count(swp_entry_t entry)
>    * This does not give an exact answer when swap count is continued,
>    * but does include the high COUNT_CONTINUED flag to allow for that.
>    */
> -static int swap_swapcount(struct swap_info_struct *si, swp_entry_t entry)
> +int swap_swapcount(struct swap_info_struct *si, swp_entry_t entry)
>   {
>   	pgoff_t offset = swp_offset(entry);
>   	struct swap_cluster_info *ci;
> @@ -1455,24 +1455,6 @@ static int swap_swapcount(struct swap_info_struct *si, swp_entry_t entry)
>   	return count;
>   }
>   
> -/*
> - * How many references to @entry are currently swapped out?
> - * This does not give an exact answer when swap count is continued,
> - * but does include the high COUNT_CONTINUED flag to allow for that.
> - */
> -int __swp_swapcount(swp_entry_t entry)
> -{
> -	int count = 0;
> -	struct swap_info_struct *si;
> -
> -	si = get_swap_device(entry);
> -	if (si) {
> -		count = swap_swapcount(si, entry);
> -		put_swap_device(si);
> -	}
> -	return count;
> -}
> -
>   /*
>    * How many references to @entry are currently swapped out?
>    * This considers COUNT_CONTINUED so it returns exact answer.

-- 
Thanks,

David / dhildenb

