Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0BE225B364D
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Sep 2022 13:26:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230178AbiIIL0e (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Sep 2022 07:26:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230134AbiIIL0c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Sep 2022 07:26:32 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C905EED9B1
        for <linux-kernel@vger.kernel.org>; Fri,  9 Sep 2022 04:26:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1662722791;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=kR/RcJLHJFia6a8A9ACmf1sg9LF38Xuw8q80+jnlzbY=;
        b=izVmjnRcnsY6ocTEoI8XZOXhXxVXwSTyr6LGndDfhmR3AWACxYPHDA2mzuoYLPytnW++sy
        vckD9RHs9v3fhH4Um5ZkukepmwmDrvFlxIDDro1thWykat9SiRY9OYA8z5Bb2QCAVSlXfG
        67S2YtDE3Hh/zf6fgNPUJV+XgEixhNI=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-241-l34_qgucO8qw3_w2KvIcIg-1; Fri, 09 Sep 2022 07:26:29 -0400
X-MC-Unique: l34_qgucO8qw3_w2KvIcIg-1
Received: by mail-wm1-f72.google.com with SMTP id ay21-20020a05600c1e1500b003b45fd14b53so340683wmb.1
        for <linux-kernel@vger.kernel.org>; Fri, 09 Sep 2022 04:26:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date;
        bh=kR/RcJLHJFia6a8A9ACmf1sg9LF38Xuw8q80+jnlzbY=;
        b=VNr6cNmE0Bc0Xh7nak7GR4KXhtvzss5o+p4Lm2j1Ppzp60RnlqenVRrj+vx4nNC4w1
         jACcxp/876Qbq6vub2wrQtUzoF8u3/Q2Yp3DmVInkltRPbM7seMIZt4RAvfHV9fWjyjS
         wWJ7xdWmjB4IsG9aw1iLHNnD4XPRfrz21c+51WJJ4lRkm9FHvfkfIZdZ1CEtlbj8b8fQ
         sp3TByUBsLukwT7t9ck/rNMbe1KVgg7vun9p9zBVJoikPCU9mR9NBm/bbJ8Oc+RQnM1t
         0ciqrgLIVLGkIDA8LI2TLUu7Ic57aSoQFDL0UGEVyUTe/1G6nHGE87g0z5Z1ofkzeBwJ
         lHgw==
X-Gm-Message-State: ACgBeo0bLMZ6M2QrtOsT5gxWkiXv04cn6hhhOSh80TEg4f5ZGmg7n+ai
        eAQCWSGhXSSyXSdu0Jb8OTCsQn0MLXHEV55B7yiE9sUwnr24BmvgmXl+i+YJoR1His+cRXEglaQ
        FVZdJ5lCVSQfKUQlEvpLSElvj
X-Received: by 2002:a5d:540a:0:b0:22a:35f1:2d61 with SMTP id g10-20020a5d540a000000b0022a35f12d61mr3412113wrv.535.1662722788787;
        Fri, 09 Sep 2022 04:26:28 -0700 (PDT)
X-Google-Smtp-Source: AA6agR62UifyovjdPp3tDA4qvJpx07dZgSWFKthlevjwUzAF2jmh5ifmuo5h4yToY37AdrztkDwMxg==
X-Received: by 2002:a5d:540a:0:b0:22a:35f1:2d61 with SMTP id g10-20020a5d540a000000b0022a35f12d61mr3412096wrv.535.1662722788480;
        Fri, 09 Sep 2022 04:26:28 -0700 (PDT)
Received: from ?IPV6:2003:cb:c704:6300:1fe0:42e1:62c5:91b6? (p200300cbc70463001fe042e162c591b6.dip0.t-ipconnect.de. [2003:cb:c704:6300:1fe0:42e1:62c5:91b6])
        by smtp.gmail.com with ESMTPSA id z12-20020a5d654c000000b00228e1e90822sm237846wrv.112.2022.09.09.04.26.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 09 Sep 2022 04:26:27 -0700 (PDT)
Message-ID: <fc214e71-4d71-5cd1-73e0-9389142eca83@redhat.com>
Date:   Fri, 9 Sep 2022 13:26:27 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.0
Subject: Re: [PATCH 02/16] mm/page_alloc: make zone_pcp_update() static
Content-Language: en-US
To:     Miaohe Lin <linmiaohe@huawei.com>, akpm@linux-foundation.org
Cc:     osalvador@suse.de, linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <20220909092451.24883-1-linmiaohe@huawei.com>
 <20220909092451.24883-3-linmiaohe@huawei.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <20220909092451.24883-3-linmiaohe@huawei.com>
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
> Since commit b92ca18e8ca5 ("mm/page_alloc: disassociate the pcp->high
> from pcp->batch"), zone_pcp_update() is only used in mm/page_alloc.c.
> Move zone_pcp_update() up to avoid forward declaration and then make
> it static. No functional change intended.
> 
> Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
> ---
>   mm/internal.h   |  1 -
>   mm/page_alloc.c | 22 +++++++++++-----------
>   2 files changed, 11 insertions(+), 12 deletions(-)
> 
> diff --git a/mm/internal.h b/mm/internal.h
> index 4e5f3d0d5538..2424fcde6538 100644
> --- a/mm/internal.h
> +++ b/mm/internal.h
> @@ -367,7 +367,6 @@ extern int user_min_free_kbytes;
>   extern void free_unref_page(struct page *page, unsigned int order);
>   extern void free_unref_page_list(struct list_head *list);
>   
> -extern void zone_pcp_update(struct zone *zone, int cpu_online);
>   extern void zone_pcp_reset(struct zone *zone);
>   extern void zone_pcp_disable(struct zone *zone);
>   extern void zone_pcp_enable(struct zone *zone);
> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> index 4b97a03fa2dd..2deac2fe3372 100644
> --- a/mm/page_alloc.c
> +++ b/mm/page_alloc.c
> @@ -7238,6 +7238,17 @@ void __meminit setup_zone_pageset(struct zone *zone)
>   	zone_set_pageset_high_and_batch(zone, 0);
>   }
>   
> +/*
> + * The zone indicated has a new number of managed_pages; batch sizes and percpu
> + * page high values need to be recalculated.
> + */
> +static void zone_pcp_update(struct zone *zone, int cpu_online)
> +{
> +	mutex_lock(&pcp_batch_high_lock);
> +	zone_set_pageset_high_and_batch(zone, cpu_online);
> +	mutex_unlock(&pcp_batch_high_lock);
> +}
> +
>   /*
>    * Allocate per cpu pagesets and initialize them.
>    * Before this call only boot pagesets were available.
> @@ -9469,17 +9480,6 @@ void free_contig_range(unsigned long pfn, unsigned long nr_pages)
>   }
>   EXPORT_SYMBOL(free_contig_range);
>   
> -/*
> - * The zone indicated has a new number of managed_pages; batch sizes and percpu
> - * page high values need to be recalculated.
> - */
> -void zone_pcp_update(struct zone *zone, int cpu_online)
> -{
> -	mutex_lock(&pcp_batch_high_lock);
> -	zone_set_pageset_high_and_batch(zone, cpu_online);
> -	mutex_unlock(&pcp_batch_high_lock);
> -}
> -
>   /*
>    * Effectively disable pcplists for the zone by setting the high limit to 0
>    * and draining all cpus. A concurrent page freeing on another CPU that's about

Reviewed-by: David Hildenbrand <david@redhat.com>

-- 
Thanks,

David / dhildenb

