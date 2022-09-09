Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E45405B3677
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Sep 2022 13:36:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230484AbiIILfJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Sep 2022 07:35:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230358AbiIILfH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Sep 2022 07:35:07 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 856278A1F1
        for <linux-kernel@vger.kernel.org>; Fri,  9 Sep 2022 04:35:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1662723304;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=D71aNJwUf2Cj4QI1/Yh0CfylC8ya9cAVpDQe3Gn0t0U=;
        b=h8Ef/GlC+nSrQKt8JB+/SIwnHt6IKU/RzmKciYm5MXqTdHlvpBPLA1A6j7eOQ7kD6/IaGP
        Aqa4uLRoMCDdS/FI/NTQTH/K3etMbFOgfAxi5NZI4yOIeXHydT4fPaJ7+OmrMhuDCcMuWC
        E1jdK/JIh5SQWKraFcdcBAtv4q5eSYw=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-558-mZoF75Y9M7-t31XA4fy0lQ-1; Fri, 09 Sep 2022 07:35:03 -0400
X-MC-Unique: mZoF75Y9M7-t31XA4fy0lQ-1
Received: by mail-wm1-f72.google.com with SMTP id i66-20020a1c3b45000000b003b339a8556eso725227wma.4
        for <linux-kernel@vger.kernel.org>; Fri, 09 Sep 2022 04:35:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date;
        bh=D71aNJwUf2Cj4QI1/Yh0CfylC8ya9cAVpDQe3Gn0t0U=;
        b=QbJ1/yBAVpTlgAxIHp2kXprmH+Rb9rN/UTxKlw1aKM+zDLjUVUjZDotcakaJPkdIr6
         82/ZfCrcCn5gan8jD/g2LsCQC4Tun0YMMH5uOIUqv1SCWEzzemkJHyFyc49LcMK9yqw8
         7LaMlwtbxug+dOWRkDHwV0wltNdGjtDGCJbbH/pmJ6TpuhEt+MGOc4HQRLMKpIxBhZWs
         pYxq+kEu7sKf3fpXr//o+e5yUSOy+8R4XxLYJW7SlfVWRXfvbcThwMrjCIqOccypInhy
         uz9Qpo1JcfuEAh/r4GnrfE6PvMADaaf1KIV6wTeK2bpC6YWHi4nsWAA3Nwzf4fJI9Gu0
         7Gaw==
X-Gm-Message-State: ACgBeo06e5UaZlBbTdznQQ+bLe5ctmUbTlxYV7IIZwk+FpOyuUJHKhdG
        xvYsJgP6IK9AebYlluEx5uscGRY45HV3xCfsE9JXb7XPoazjCqZOdtVY1Giy+32jJPU2z03Oe5/
        g3U6ReOqY6RDD7/WBYGupPIXJ
X-Received: by 2002:a7b:c016:0:b0:3a5:fff2:62f4 with SMTP id c22-20020a7bc016000000b003a5fff262f4mr5408585wmb.104.1662723302376;
        Fri, 09 Sep 2022 04:35:02 -0700 (PDT)
X-Google-Smtp-Source: AA6agR7AB3xHdA3oy9QrqeLron6tO5huUdFpE1KVoEoG2zOSPQ+PqLdhNehQpCIw1kmBkg1i82LMZA==
X-Received: by 2002:a7b:c016:0:b0:3a5:fff2:62f4 with SMTP id c22-20020a7bc016000000b003a5fff262f4mr5408562wmb.104.1662723302069;
        Fri, 09 Sep 2022 04:35:02 -0700 (PDT)
Received: from ?IPV6:2003:cb:c704:6300:1fe0:42e1:62c5:91b6? (p200300cbc70463001fe042e162c591b6.dip0.t-ipconnect.de. [2003:cb:c704:6300:1fe0:42e1:62c5:91b6])
        by smtp.gmail.com with ESMTPSA id i15-20020a1c540f000000b003a32251c3f9sm426510wmb.5.2022.09.09.04.35.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 09 Sep 2022 04:35:01 -0700 (PDT)
Message-ID: <f83025e2-d516-72f2-7053-4c5f9626dcf0@redhat.com>
Date:   Fri, 9 Sep 2022 13:34:52 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.0
Subject: Re: [PATCH 12/16] mm/page_alloc: use helper macro SZ_1{K,M}
Content-Language: en-US
To:     Miaohe Lin <linmiaohe@huawei.com>, akpm@linux-foundation.org
Cc:     osalvador@suse.de, linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <20220909092451.24883-1-linmiaohe@huawei.com>
 <20220909092451.24883-13-linmiaohe@huawei.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <20220909092451.24883-13-linmiaohe@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09.09.22 11:24, Miaohe Lin wrote:
> Use helper macro SZ_1K and SZ_1M to do the size conversion. Minor
> readability improvement.
> 
> Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
> ---
>   mm/page_alloc.c | 8 ++++----
>   1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> index 7a8a6bb08a15..e1c7f98cff96 100644
> --- a/mm/page_alloc.c
> +++ b/mm/page_alloc.c
> @@ -7053,7 +7053,7 @@ static int zone_batchsize(struct zone *zone)
>   	 * size is striking a balance between allocation latency
>   	 * and zone lock contention.
>   	 */
> -	batch = min(zone_managed_pages(zone) >> 10, (1024 * 1024) / PAGE_SIZE);
> +	batch = min(zone_managed_pages(zone) >> 10, SZ_1M / PAGE_SIZE);
>   	batch /= 4;		/* We effectively *= 4 below */
>   	if (batch < 1)
>   		batch = 1;
> @@ -8528,8 +8528,8 @@ void __init mem_init_print_info(void)
>   #endif
>   		")\n",
>   		K(nr_free_pages()), K(physpages),
> -		codesize >> 10, datasize >> 10, rosize >> 10,
> -		(init_data_size + init_code_size) >> 10, bss_size >> 10,
> +		codesize / SZ_1K, datasize / SZ_1K, rosize / SZ_1K,
> +		(init_data_size + init_code_size) / SZ_1K, bss_size / SZ_1K,
>   		K(physpages - totalram_pages() - totalcma_pages),
>   		K(totalcma_pages)
>   #ifdef	CONFIG_HIGHMEM
> @@ -9055,7 +9055,7 @@ void *__init alloc_large_system_hash(const char *tablename,
>   
>   		/* It isn't necessary when PAGE_SIZE >= 1MB */

Huh, how could we ever have that. Smells like dead code.

>   		if (PAGE_SHIFT < 20)

What about adjusting that as well? The it exactly matches the comment

if (PAGE_SIZE >= SZ_1M)

> -			numentries = round_up(numentries, (1<<20)/PAGE_SIZE);
> +			numentries = round_up(numentries, SZ_1M / PAGE_SIZE);
>   
>   #if __BITS_PER_LONG > 32
>   		if (!high_limit) {

-- 
Thanks,

David / dhildenb

