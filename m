Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB02F74B055
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jul 2023 13:57:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231959AbjGGL5M (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Jul 2023 07:57:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229458AbjGGL5L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jul 2023 07:57:11 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21FCE1FCE
        for <linux-kernel@vger.kernel.org>; Fri,  7 Jul 2023 04:56:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1688730982;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=+zNBj9eYnDea9EN+o9qg7xJQFBC+d+IwoAvBLbNge90=;
        b=AABUd5X9+JY4xXJyvP4xFCon306MM55VhvA/TvXAji2/UbgTNOVs1lf70SpYKQmIo5uj4R
        x+ih550HZv769tvci8se+igvgpmFBeGzwLVS2CThpiLlONjTfjMujnOaMMHLQzsJyvTrmE
        YefdEknib93mrndaolOUXC9jghV3v9s=
Received: from mail-lf1-f71.google.com (mail-lf1-f71.google.com
 [209.85.167.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-185-ylkRbBPtOw2P2U_zfJVGoQ-1; Fri, 07 Jul 2023 07:56:17 -0400
X-MC-Unique: ylkRbBPtOw2P2U_zfJVGoQ-1
Received: by mail-lf1-f71.google.com with SMTP id 2adb3069b0e04-4f84a8b00e3so1760628e87.0
        for <linux-kernel@vger.kernel.org>; Fri, 07 Jul 2023 04:56:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688730976; x=1691322976;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+zNBj9eYnDea9EN+o9qg7xJQFBC+d+IwoAvBLbNge90=;
        b=Z4aXBhRBNT4rxpBf4mZOE8M/i9E3eyuD2m7AI7OZkucSnDCYVdfjzhXqrI3cXSUL1m
         vIrYedVcEeUc/zww5f/0xPx/M1qMPqI5H4aevz37iGoFHvBwXtj5/5+HZoR6LwbZlGZz
         JXKyag31mYfk8HEdZIiXxLjtnS5BQ+UAMSN0sybUWg5tXcSvtm7N0ozW4ZyhZqJPkpDQ
         p3QAsMAbTzXOjI5ZPx0tiggC9da/pLLSrhvHh06BOgVsDucp3hEDb4v7jum/qmUwOv7P
         fMnYDsdbcSFSe1zkypsbs+UCFCKlz2knTNbBK+GPDeNd/5SLsGUYtA7d+0MFNov5kkBp
         vZIg==
X-Gm-Message-State: ABy/qLZtO32LxSRWaTSq2dzPvmYjHAn6Dhh5mX5lNgUccjgUS+Zvp6Fc
        tOxK/H8LidG2PzSvOv6Zb70/V5AEO/MdKkPQAkuwAUyhL6nwIvbzcDm+1qUPPtSwNSD2dkwGM2m
        yovYWx5zzQ6cfqUhMxPUuH7AW
X-Received: by 2002:a19:3817:0:b0:4f8:6ac1:15a9 with SMTP id f23-20020a193817000000b004f86ac115a9mr3528061lfa.31.1688730976194;
        Fri, 07 Jul 2023 04:56:16 -0700 (PDT)
X-Google-Smtp-Source: APBJJlH1NgRVc3OyU27DGp44pw0IZffZSzCCo4rAZ1Zy7J5nsJoOjuSMd5Nz/ESPaFv4Afa474lRAQ==
X-Received: by 2002:a19:3817:0:b0:4f8:6ac1:15a9 with SMTP id f23-20020a193817000000b004f86ac115a9mr3528046lfa.31.1688730975779;
        Fri, 07 Jul 2023 04:56:15 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f04:3c00:248f:bf5b:b03e:aac7? (p200300d82f043c00248fbf5bb03eaac7.dip0.t-ipconnect.de. [2003:d8:2f04:3c00:248f:bf5b:b03e:aac7])
        by smtp.gmail.com with ESMTPSA id k14-20020a7bc30e000000b003fbd2a9e94asm2257133wmj.31.2023.07.07.04.56.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 07 Jul 2023 04:56:15 -0700 (PDT)
Message-ID: <b0328149-16c6-a687-4c28-5f537e190ae4@redhat.com>
Date:   Fri, 7 Jul 2023 13:56:14 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH 2/2] mm: compaction: skip the memory hole rapidly when
 isolating free pages
Content-Language: en-US
To:     Baolin Wang <baolin.wang@linux.alibaba.com>,
        akpm@linux-foundation.org
Cc:     mgorman@techsingularity.net, vbabka@suse.cz, ying.huang@intel.com,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <b21cd8e2e32b9a1d9bc9e43ebf8acaf35e87f8df.1688715750.git.baolin.wang@linux.alibaba.com>
 <d2ba7e41ee566309b594311207ffca736375fc16.1688715750.git.baolin.wang@linux.alibaba.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <d2ba7e41ee566309b594311207ffca736375fc16.1688715750.git.baolin.wang@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07.07.23 10:51, Baolin Wang wrote:
> On my machine with below memory layout, and I can see it will take more
> time to skip the larger memory hole (range: 0x100000000 - 0x1800000000)
> when isolating free pages. So adding a new helper to skip the memory
> hole rapidly, which can reduce the time consumed from about 70us to less
> than 1us.

Can you clarify how this relates to the previous commit and mention that 
commit?

> 
> [    0.000000] Zone ranges:
> [    0.000000]   DMA      [mem 0x0000000040000000-0x00000000ffffffff]
> [    0.000000]   DMA32    empty
> [    0.000000]   Normal   [mem 0x0000000100000000-0x0000001fa7ffffff]
> [    0.000000] Movable zone start for each node
> [    0.000000] Early memory node ranges
> [    0.000000]   node   0: [mem 0x0000000040000000-0x0000000fffffffff]
> [    0.000000]   node   0: [mem 0x0000001800000000-0x0000001fa3c7ffff]
> [    0.000000]   node   0: [mem 0x0000001fa3c80000-0x0000001fa3ffffff]
> [    0.000000]   node   0: [mem 0x0000001fa4000000-0x0000001fa402ffff]
> [    0.000000]   node   0: [mem 0x0000001fa4030000-0x0000001fa40effff]
> [    0.000000]   node   0: [mem 0x0000001fa40f0000-0x0000001fa73cffff]
> [    0.000000]   node   0: [mem 0x0000001fa73d0000-0x0000001fa745ffff]
> [    0.000000]   node   0: [mem 0x0000001fa7460000-0x0000001fa746ffff]
> [    0.000000]   node   0: [mem 0x0000001fa7470000-0x0000001fa758ffff]
> [    0.000000]   node   0: [mem 0x0000001fa7590000-0x0000001fa7ffffff]
> 
> Signed-off-by: Baolin Wang <baolin.wang@linux.alibaba.com>
> ---
>   mm/compaction.c | 30 +++++++++++++++++++++++++++++-
>   1 file changed, 29 insertions(+), 1 deletion(-)
> 
> diff --git a/mm/compaction.c b/mm/compaction.c
> index 43358efdbdc2..9641e2131901 100644
> --- a/mm/compaction.c
> +++ b/mm/compaction.c
> @@ -249,11 +249,31 @@ static unsigned long skip_offline_sections(unsigned long start_pfn)
>   
>   	return 0;
>   }
> +
> +static unsigned long skip_offline_sections_reverse(unsigned long start_pfn)
> +{
> +	unsigned long start_nr = pfn_to_section_nr(start_pfn);
> +
> +	if (!start_nr || online_section_nr(start_nr))
> +		return 0;
> +
> +	while (start_nr-- > 0) {
> +		if (online_section_nr(start_nr))
> +			return section_nr_to_pfn(start_nr) + PAGES_PER_SECTION - 1;
> +	}
> +
> +	return 0;
> +}
>   #else
>   static unsigned long skip_offline_sections(unsigned long start_pfn)
>   {
>   	return 0;
>   }
> +
> +static unsigned long skip_offline_sections_reverse(unsigned long start_pfn)
> +{
> +	return 0;
> +}
>   #endif
>   
>   /*
> @@ -1668,8 +1688,16 @@ static void isolate_freepages(struct compact_control *cc)
>   
>   		page = pageblock_pfn_to_page(block_start_pfn, block_end_pfn,
>   									zone);
> -		if (!page)
> +		if (!page) {
> +			unsigned long next_pfn;
> +
> +			next_pfn = skip_offline_sections_reverse(block_start_pfn);
> +			if (next_pfn)
> +				block_start_pfn = max(pageblock_start_pfn(next_pfn),
> +						      low_pfn);
> +
>   			continue;
> +		}
>   
>   		/* Check the block is suitable for migration */
>   		if (!suitable_migration_target(cc, page))


LGTM

Acked-by: David Hildenbrand <david@redhat.com>

-- 
Cheers,

David / dhildenb

