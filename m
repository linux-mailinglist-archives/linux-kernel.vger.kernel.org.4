Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A85A970BC6E
	for <lists+linux-kernel@lfdr.de>; Mon, 22 May 2023 13:55:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233543AbjEVLy7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 May 2023 07:54:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233109AbjEVLyv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 May 2023 07:54:51 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 879CC9B
        for <linux-kernel@vger.kernel.org>; Mon, 22 May 2023 04:54:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1684756444;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=CmC7PRo1R7ZhJzowWuw/vFq8NrjJylR4K7gsroB369c=;
        b=fBOAjSzwz15pUukHZwZP9+9pm+Ju1apQLlCGtxl/PJf79F6jxWs0VbuviIUz+JVHd1RsmH
        TB4+ObX80AJ9LkWAiWTQr52sBt+GNKoF8WJ+57O9pHodCpzZhWJGIgjLQgEFI/bjNMi0Hi
        xQejeAkkM4tL+8J1z2fHhnc/UPmGChI=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-486-CKDAJogAOdeWtZlHmJVr3Q-1; Mon, 22 May 2023 07:54:03 -0400
X-MC-Unique: CKDAJogAOdeWtZlHmJVr3Q-1
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-3f50aa22cd2so35781025e9.1
        for <linux-kernel@vger.kernel.org>; Mon, 22 May 2023 04:54:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684756442; x=1687348442;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=CmC7PRo1R7ZhJzowWuw/vFq8NrjJylR4K7gsroB369c=;
        b=bltPbxpN4HJhuq9+kRm6h6DRuyvaxMZEYA/DBjT/EwGnlSYcAM7Xd/H881f7OgkvRL
         t+0zhYKuZMtxItaqXq670tCfjSQBkh9AeKOl7GKa4MQd10kD0yLb9Nb5+i5pLE7wQJmk
         c/C38cACNXBGtA3lnyVImrH2INgjnCXev57a0+VutQmMAGmZkwYp3Zz3Ms5Yrcjf62bn
         0riSKCVXTDX+Mpt5tl0TU2jhzOu/Zz/37qYz0c2RnbLXK+VbIlYashYQ4I4CXuAhZ6s6
         plZRAUl1pdwEAP7C5xr/gcgUh7kkbb/2dLlr3FeaO1bZrM+fHDsV7834yvZBFSOFaYtK
         jAnA==
X-Gm-Message-State: AC+VfDy8iv0HY6h1LKamawZkvPP5rriQ88CpbsgB6Wt7KBXOBdmDQWvK
        9L5WHm4TRq38ANuWlPV6FIvzpH3QZrjLirMFCt9yD7o1FHd+fnQTbuH4qMZwcIpO4UtLyQERGEG
        uaklkSeHIAg3QM4xB2hGA9mdI
X-Received: by 2002:a1c:7c19:0:b0:3f4:2374:3512 with SMTP id x25-20020a1c7c19000000b003f423743512mr6552770wmc.18.1684756442345;
        Mon, 22 May 2023 04:54:02 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ4EPlHuucVkDjDnagnkVzUlBwaBGqffjMZWuezvJJQlG5N32bC3QNWJX63pbfCrWjUb7Cmuzg==
X-Received: by 2002:a1c:7c19:0:b0:3f4:2374:3512 with SMTP id x25-20020a1c7c19000000b003f423743512mr6552753wmc.18.1684756442017;
        Mon, 22 May 2023 04:54:02 -0700 (PDT)
Received: from ?IPV6:2003:cb:c742:c800:d74f:aec6:f8ac:558? (p200300cbc742c800d74faec6f8ac0558.dip0.t-ipconnect.de. [2003:cb:c742:c800:d74f:aec6:f8ac:558])
        by smtp.gmail.com with ESMTPSA id n6-20020a7bcbc6000000b003f42d8dd7ffsm8028624wmi.19.2023.05.22.04.54.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 22 May 2023 04:54:01 -0700 (PDT)
Message-ID: <09cee859-6510-ed3c-67da-c1452a534460@redhat.com>
Date:   Mon, 22 May 2023 13:54:00 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH -V2 1/5] swap: Remove get/put_swap_device() in
 __swap_count()
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
 <20230522070905.16773-2-ying.huang@intel.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <20230522070905.16773-2-ying.huang@intel.com>
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
> __swap_count() is called in do_swap_page() only, which encloses the
> call site with get/put_swap_device() already.
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
>   mm/swapfile.c | 10 ++--------
>   1 file changed, 2 insertions(+), 8 deletions(-)
> 
> diff --git a/mm/swapfile.c b/mm/swapfile.c
> index 274bbf797480..8419cba9c192 100644
> --- a/mm/swapfile.c
> +++ b/mm/swapfile.c
> @@ -1432,16 +1432,10 @@ void swapcache_free_entries(swp_entry_t *entries, int n)
>   
>   int __swap_count(swp_entry_t entry)
>   {
> -	struct swap_info_struct *si;
> +	struct swap_info_struct *si = swp_swap_info(entry);
>   	pgoff_t offset = swp_offset(entry);
> -	int count = 0;
>   
> -	si = get_swap_device(entry);
> -	if (si) {
> -		count = swap_count(si->swap_map[offset]);
> -		put_swap_device(si);
> -	}
> -	return count;
> +	return swap_count(si->swap_map[offset]);
>   }
>   
>   /*

That locking was added in eb085574a752 ("mm, swap: fix race between 
swapoff and some swap operations"). Before 2799e77529c ("swap: fix 
do_swap_page() race with swapoff") added the get_swap_device() to 
do_swap_page().

Reviewed-by: David Hildenbrand <david@redhat.com>

-- 
Thanks,

David / dhildenb

