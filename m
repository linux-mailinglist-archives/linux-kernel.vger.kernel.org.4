Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B5D16DF336
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Apr 2023 13:27:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230258AbjDLL1O (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Apr 2023 07:27:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230063AbjDLL1M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Apr 2023 07:27:12 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50D611FE0
        for <linux-kernel@vger.kernel.org>; Wed, 12 Apr 2023 04:26:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1681298736;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=nCSXTF4XVSA+wnYR5OnBmbwxnANHNL0gZw+wB32qq0c=;
        b=S7fbPiHQzOPDEHXWqwqnYS3LMq2tGx1Jq7wHfkHqTBytNA6nRU7oX/Kaus/xuxDsul9b6y
        Isxd3KO9x4z7Px/8m2TjQY6Q3d78ef9Qg3FbJ4tyxA+q1SYpAMpG/ut5/aU2WWz4IQGKGK
        dbplVZgvWWDZtZE0pMn5RLpY0b3DdvM=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-108-GZq_LYYEN2WuCDxkzim48w-1; Wed, 12 Apr 2023 07:25:35 -0400
X-MC-Unique: GZq_LYYEN2WuCDxkzim48w-1
Received: by mail-wr1-f71.google.com with SMTP id w3-20020adf8bc3000000b002efb4354084so1369888wra.10
        for <linux-kernel@vger.kernel.org>; Wed, 12 Apr 2023 04:25:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1681298734; x=1683890734;
        h=content-transfer-encoding:in-reply-to:subject:organization:from
         :references:cc:to:content-language:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nCSXTF4XVSA+wnYR5OnBmbwxnANHNL0gZw+wB32qq0c=;
        b=FHKgAac9+LCGH5zkmgqNz1YE5gk23j3X+bjxxzd8K+HmwqZH6WFk26TT6e/UmGDJwR
         ttajDL1Zn9HeegC5Mrbi89Urq4Gzi8w8BW6O0Hp/ri7zTDqQd0Pa4g79lcW0YYHxgrbw
         kPe0SfcK6KX+NE4M+WUtZ//DYLJmdUDUQibJCa37t4pDBdcpaUhiFYCoUGzyQn0xn9wR
         2K8vt5BwzjQbrGo8MOUmDle0p5oQK/0EndsI6kkOy/njxJAS9BLTn6EtzmFOFuoH3GTp
         P5qDxtDo62VblIkQf6k4grTZAUZehqg2PIQGi9FrFPqX+l1QOyniGcLGM1LNRYdgZ3Li
         3NfA==
X-Gm-Message-State: AAQBX9fyY0/Cn10/iV2c+w5IKQ1Uku/Hd+DIWpO1DG4PyuFOGhy4aQ3o
        q6E2tOKpFo2U4xcoyz/35tDaYpmB4ZON51U7/l6iez1nhhXgFvqvvmHJf+A23PG4SaqTuw77oVr
        JZAll3W6QSbdnaebUKLwYO3Z/pzvVKGHp
X-Received: by 2002:a7b:c4c7:0:b0:3e2:589:2512 with SMTP id g7-20020a7bc4c7000000b003e205892512mr1658470wmk.21.1681298734150;
        Wed, 12 Apr 2023 04:25:34 -0700 (PDT)
X-Google-Smtp-Source: AKy350b/SiLavUkrvwZgIj2TJWW+TQt7NrOH6hxC/XCMk5hAWGy3BRFgYcoxYNV6pNUr8efUGpf8Kw==
X-Received: by 2002:a7b:c4c7:0:b0:3e2:589:2512 with SMTP id g7-20020a7bc4c7000000b003e205892512mr1658451wmk.21.1681298733719;
        Wed, 12 Apr 2023 04:25:33 -0700 (PDT)
Received: from ?IPV6:2003:cb:c702:4b00:c6fa:b613:dbdc:ab? (p200300cbc7024b00c6fab613dbdc00ab.dip0.t-ipconnect.de. [2003:cb:c702:4b00:c6fa:b613:dbdc:ab])
        by smtp.gmail.com with ESMTPSA id n11-20020a5d420b000000b002ceacff44c7sm16944160wrq.83.2023.04.12.04.25.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 12 Apr 2023 04:25:33 -0700 (PDT)
Message-ID: <94bfa3cc-674e-25b0-e7e2-d74c970acef7@redhat.com>
Date:   Wed, 12 Apr 2023 13:25:32 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Content-Language: en-US
To:     Baolin Wang <baolin.wang@linux.alibaba.com>,
        akpm@linux-foundation.org
Cc:     mgorman@techsingularity.net, vbabka@suse.cz, mhocko@suse.com,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <62e231a8f2e50c04dcadc7a0cfaa6dea5ce1ec05.1681296022.git.baolin.wang@linux.alibaba.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
Subject: Re: [PATCH] mm/page_alloc: consider pfn holes after pfn_valid() in
 __pageblock_pfn_to_page()
In-Reply-To: <62e231a8f2e50c04dcadc7a0cfaa6dea5ce1ec05.1681296022.git.baolin.wang@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12.04.23 12:45, Baolin Wang wrote:
> Now the __pageblock_pfn_to_page() is used by set_zone_contiguous(),
> which checks whether the given zone contains holes, and uses pfn_valid()
> to check if the end pfn is valid. However pfn_valid() can not make sure
> the end pfn is not a hole if the size of a pageblock is larger than the
> size of a sub-mem_section, since the struct page getting by pfn_to_page()
> may represent a hole or an unusable page frame, which may cause incorrect
> zone contiguous is set.
> 
> Though another user of pageblock_pfn_to_page() in compaction seems work
> well now, it is better to avoid scanning or touching these offline pfns.
> So like commit 2d070eab2e82 ("mm: consider zone which is not fully
> populated to have holes"), we should also use pfn_to_online_page() for
> the end pfn to make sure it is a valid pfn with usable page frame.
> Meanwhile the pfn_valid() for end pfn can be dropped now.
> 
> Moreover we've already used pfn_to_online_page() for start pfn to make
> sure it is online and valid, so the pfn_valid() for the start pfn is
> unnecessary, drop it.

pageblocks are supposed to fall into a single memory section, so in most 
cases, if the start is online, so is the end.

The exception to this rule is when we have a mixture of ZONE_DEVICE and 
ZONE_* within the same section.

Then, indeed the end might not be online.

BUT, if the end is valid (-> ZONE_DEVICE), then the zone_id will differ. 
[let's ignore any races for now, up to this point they are mostly of 
theoretical nature]

So I don't think this change actually fixes something.


Getting rid of the pfn_valid(start_pfn)  makes sense. Replacing the 
pfn_valid(end_pfn) by a pfn_to_online_page(end_pfn) could make that 
function less efficient.

> 
> Signed-off-by: Baolin Wang <baolin.wang@linux.alibaba.com>
> ---
>   mm/page_alloc.c | 7 +++----
>   1 file changed, 3 insertions(+), 4 deletions(-)
> 
> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> index d0eb280ec7e4..8076f519c572 100644
> --- a/mm/page_alloc.c
> +++ b/mm/page_alloc.c
> @@ -1512,9 +1512,6 @@ struct page *__pageblock_pfn_to_page(unsigned long start_pfn,
>   	/* end_pfn is one past the range we are checking */
>   	end_pfn--;
>   
> -	if (!pfn_valid(start_pfn) || !pfn_valid(end_pfn))
> -		return NULL;
> -
>   	start_page = pfn_to_online_page(start_pfn);
>   	if (!start_page)
>   		return NULL;
> @@ -1522,7 +1519,9 @@ struct page *__pageblock_pfn_to_page(unsigned long start_pfn,
>   	if (page_zone(start_page) != zone)
>   		return NULL;
>   
> -	end_page = pfn_to_page(end_pfn);
> +	end_page = pfn_to_online_page(end_pfn);
> +	if (!end_page)
> +		return NULL;
>   
>   	/* This gives a shorter code than deriving page_zone(end_page) */
>   	if (page_zone_id(start_page) != page_zone_id(end_page))

-- 
Thanks,

David / dhildenb

