Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 23FA15B365B
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Sep 2022 13:31:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230345AbiIIL2w (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Sep 2022 07:28:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230181AbiIIL2s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Sep 2022 07:28:48 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67CA113867C
        for <linux-kernel@vger.kernel.org>; Fri,  9 Sep 2022 04:28:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1662722924;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=zADjijewHqE/ifMUiS21SSfRedrzbyoD3zQRtee5o1s=;
        b=aySK+C/CSgOySxetymwlRu/ir9zIj/2RJoORs5rMhyz17r4jLnpENDt/DF2vsdLQETTfUP
        V7yNgiKKrkbZSj/GPnLEf0J+tkSqlM3i/V5dyfNnVqyYPdqWjCOHzT/rtz3VLXs3KsKGvp
        BCuhOSEQaw8Vf0OjMtSw0yeib9biiWk=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-190-LLctdqQjPJG4BjWT4BGsKg-1; Fri, 09 Sep 2022 07:28:43 -0400
X-MC-Unique: LLctdqQjPJG4BjWT4BGsKg-1
Received: by mail-wr1-f72.google.com with SMTP id v15-20020adf8b4f000000b002285ec61b3aso280482wra.6
        for <linux-kernel@vger.kernel.org>; Fri, 09 Sep 2022 04:28:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date;
        bh=zADjijewHqE/ifMUiS21SSfRedrzbyoD3zQRtee5o1s=;
        b=7Fn66ngN1tIEYHuct+PifFmsp7YSlBlx7m8whio3i/ArX4J+myYt+57Nhj8lmfswc4
         eIdUzicgt1owiGQLIqpKi6lm2mjqA9FJdeRo4mAu889Y76S8VLfdqwZYSiuMER69nmYv
         WmtMJ91keSurBLMin2CWKJ+4PnONgPFEG89vihNQVl76etd/DK9HtQBCjUqlFbNJVx3D
         a9V4N6MJ4QJIjgCV2ptM+5aDqeoX+ypNWWSZhTrQDQcrJrxxcyBsYeqK8qD/HBpi4Va6
         8J5JZOkM0lcsXsmMcyacMJn6yzcAW5k4nToj5Cl/44uMVEyclFCR4pzUDf1ykKX6cy0Q
         DShA==
X-Gm-Message-State: ACgBeo2Ykbnd+smiNNrIEwcHRlNIfSyQBRqn4OIIjHsHq9LnjQCCMsYI
        PpJjP2gh5w7EKottI4Ym1xLEVQkKwkCMWtHs5zd/V1KOV9fj8BasMcQNFvW5lDM/stFtpDPdgkx
        NT2J1ICKX3tT77xs3bpYYeYX9
X-Received: by 2002:adf:fb52:0:b0:225:2ada:b741 with SMTP id c18-20020adffb52000000b002252adab741mr7921755wrs.56.1662722922182;
        Fri, 09 Sep 2022 04:28:42 -0700 (PDT)
X-Google-Smtp-Source: AA6agR6EXjNEJoF9ivl3Lb7bmTMXb8vStG/mECAtj/fEXGvK9a7Rd6A9BshsJOiCYcMrA9NoxQZ5Og==
X-Received: by 2002:adf:fb52:0:b0:225:2ada:b741 with SMTP id c18-20020adffb52000000b002252adab741mr7921748wrs.56.1662722921959;
        Fri, 09 Sep 2022 04:28:41 -0700 (PDT)
Received: from ?IPV6:2003:cb:c704:6300:1fe0:42e1:62c5:91b6? (p200300cbc70463001fe042e162c591b6.dip0.t-ipconnect.de. [2003:cb:c704:6300:1fe0:42e1:62c5:91b6])
        by smtp.gmail.com with ESMTPSA id h17-20020a05600c2cb100b003a5ca627333sm467212wmc.8.2022.09.09.04.28.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 09 Sep 2022 04:28:41 -0700 (PDT)
Message-ID: <77c1ccc6-9125-ea91-45d8-7e087b38e196@redhat.com>
Date:   Fri, 9 Sep 2022 13:28:40 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.0
Subject: Re: [PATCH 06/16] mm/page_alloc: fix freeing static percpu memory
Content-Language: en-US
To:     Miaohe Lin <linmiaohe@huawei.com>, akpm@linux-foundation.org
Cc:     osalvador@suse.de, linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <20220909092451.24883-1-linmiaohe@huawei.com>
 <20220909092451.24883-7-linmiaohe@huawei.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <20220909092451.24883-7-linmiaohe@huawei.com>
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
> The size of struct per_cpu_zonestat can be 0 on !SMP && !NUMA. In that
> case, zone->per_cpu_zonestats will always equal to boot_zonestats. But
> in zone_pcp_reset(), zone->per_cpu_zonestats is freed via free_percpu()
> directly without checking against boot_zonestats first. boot_zonestats
> will be released by free_percpu() unexpectedly.
> 
> Fixes: 28f836b6777b ("mm/page_alloc: split per cpu page lists and zone stats")
> Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
> ---
>   mm/page_alloc.c | 6 ++++--
>   1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> index 3497919f4ef5..a35ef385d906 100644
> --- a/mm/page_alloc.c
> +++ b/mm/page_alloc.c
> @@ -9510,9 +9510,11 @@ void zone_pcp_reset(struct zone *zone)
>   			drain_zonestat(zone, pzstats);
>   		}
>   		free_percpu(zone->per_cpu_pageset);
> -		free_percpu(zone->per_cpu_zonestats);
>   		zone->per_cpu_pageset = &boot_pageset;
> -		zone->per_cpu_zonestats = &boot_zonestats;
> +		if (zone->per_cpu_zonestats != &boot_zonestats) {
> +			free_percpu(zone->per_cpu_zonestats);
> +			zone->per_cpu_zonestats = &boot_zonestats;
> +		}
>   	}
>   }
>   

Reviewed-by: David Hildenbrand <david@redhat.com>

-- 
Thanks,

David / dhildenb

