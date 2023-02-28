Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D76796A5C72
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Feb 2023 16:54:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230150AbjB1Pyl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Feb 2023 10:54:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229745AbjB1Pyk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Feb 2023 10:54:40 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E79D14487
        for <linux-kernel@vger.kernel.org>; Tue, 28 Feb 2023 07:53:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1677599632;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=9urmB+eiv6j/Lo/lx4LKexV35abQKB6hzTKK5DXDMQo=;
        b=ctTO0t8+kA02DwxhZbwtG8V0gVbpXMdeppNYDdkdaMPUTrO7qR42t2xeNARdPmh3xy635+
        ndpqHOgMONsbBwX2ROVWlMfNd5ugul97AUX6MZuGszBmIshS0Ug088yuPKzRF/Kopd02Cp
        7y/swUJt6Qiem3gGIkXTaYe7sLwFWpg=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-662-X5XqMR_XM5OmN5wzHJ-wIA-1; Tue, 28 Feb 2023 10:53:51 -0500
X-MC-Unique: X5XqMR_XM5OmN5wzHJ-wIA-1
Received: by mail-wm1-f72.google.com with SMTP id p22-20020a7bcc96000000b003e2036a1516so7069613wma.7
        for <linux-kernel@vger.kernel.org>; Tue, 28 Feb 2023 07:53:50 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:subject:organization:from
         :references:cc:to:content-language:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9urmB+eiv6j/Lo/lx4LKexV35abQKB6hzTKK5DXDMQo=;
        b=KH604pJXITxfXt6fk7dGqJLq4W7IRjITYr2pgdv9mtgbgzCqcIaA3du79EvddekSQP
         h+W9tR7z7j06C2VoejNMt/C68lMLmFkE+Z06mbZB/UtjQKO3adiTjVEFlBY2+9qTKy9/
         K0vSoc4kRHJUuno3wIBxyUoFOvfBU8Ir9dW8IYytQNeUUF+vgKuj9Sx0ueoRiU1iZCDE
         AsxsCXuItYzkG7aIQF1F6Z2Naa8X70yhthjPOLkik6iLLbmuvkuH/QkfM7cLM/hndnGl
         Cku9sNVU98rnEoIfHAw4Mw9QYlEzxm3qiVAyX7Iez5iALKhBXuNqLVdcosVMQJIY5lDj
         elfw==
X-Gm-Message-State: AO0yUKXVO7Na+RON6/mcj3qt9pwln3boif7P5vUMZ2ggC63xnVVrOFnA
        6YzXs495AO9iXpSQGAPWZTq1/JqHoFUTNy3vcCWV5BxjhbWmkUHJRFXmNw2dVNP97eo+mZ/yu/8
        gmzaHTLKH56okva107kfzlKM5v71Ltw==
X-Received: by 2002:a5d:4bcc:0:b0:2cc:4d13:908d with SMTP id l12-20020a5d4bcc000000b002cc4d13908dmr2573544wrt.11.1677599629955;
        Tue, 28 Feb 2023 07:53:49 -0800 (PST)
X-Google-Smtp-Source: AK7set9z87rAKtDOAB1eeCRczD4u3n/GbdmdNmJXV6/ODc8cOWP2y6Tp9WUpx79HbnQobf6rUJ+lbQ==
X-Received: by 2002:a5d:4bcc:0:b0:2cc:4d13:908d with SMTP id l12-20020a5d4bcc000000b002cc4d13908dmr2573522wrt.11.1677599629577;
        Tue, 28 Feb 2023 07:53:49 -0800 (PST)
Received: from ?IPV6:2003:cb:c706:b800:3757:baed:f95e:20ac? (p200300cbc706b8003757baedf95e20ac.dip0.t-ipconnect.de. [2003:cb:c706:b800:3757:baed:f95e:20ac])
        by smtp.gmail.com with ESMTPSA id n7-20020a5d4c47000000b002c5534db60bsm10053533wrt.71.2023.02.28.07.53.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 28 Feb 2023 07:53:48 -0800 (PST)
Message-ID: <6b6cd2fe-2309-b471-8950-3c4334462e69@redhat.com>
Date:   Tue, 28 Feb 2023 16:53:47 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Content-Language: en-US
To:     Marcelo Tosatti <mtosatti@redhat.com>,
        Christoph Lameter <cl@linux.com>
Cc:     Aaron Tomlin <atomlin@atomlin.com>,
        Frederic Weisbecker <frederic@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Mel Gorman <mgorman@suse.de>
References: <20230209150150.380060673@redhat.com>
 <20230209153204.656996515@redhat.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
Subject: Re: [PATCH v2 01/11] mm/vmstat: remove remote node draining
In-Reply-To: <20230209153204.656996515@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09.02.23 16:01, Marcelo Tosatti wrote:
> Draining of pages from the local pcp for a remote zone was necessary
> since:
> 
> "Note that remote node draining is a somewhat esoteric feature that is
> required on large NUMA systems because otherwise significant portions
> of system memory can become trapped in pcp queues. The number of pcp is
> determined by the number of processors and nodes in a system. A system
> with 4 processors and 2 nodes has 8 pcps which is okay. But a system
> with 1024 processors and 512 nodes has 512k pcps with a high potential
> for large amount of memory being caught in them."
> 
> Since commit 443c2accd1b6679a1320167f8f56eed6536b806e
> ("mm/page_alloc: remotely drain per-cpu lists"), drain_all_pages() is able
> to remotely free those pages when necessary.
> 

I'm a bit new to that piece of code, so sorry for the dummy questions. 
I'm staring at linux master,

(1) I think you're removing the single user of drain_zone_pages(). So we
     should remove drain_zone_pages() as well.

(2) drain_zone_pages() documents that we're draining the PCP
     (bulk-freeing them) of the current CPU on remote nodes. That bulk-
     freeing will properly adjust free memory counters. What exactly is
     the impact when no longer doing that? Won't the "snapshot" of some
     counters eventually be wrong? Do we care?

Describing the difference between instructed refresh of vmstat and 
"remotely drain per-cpu lists" in order to move free memory from the pcp 
to the buddy would be great.

Because removing this code here looks nice, but I am not 100% sure about 
the implications. CCing Mel as well.


> Signed-off-by: Marcelo Tosatti <mtosatti@redhat.com>
> 
> Index: linux-vmstat-remote/include/linux/mmzone.h
> ===================================================================
> --- linux-vmstat-remote.orig/include/linux/mmzone.h
> +++ linux-vmstat-remote/include/linux/mmzone.h
> @@ -577,9 +577,6 @@ struct per_cpu_pages {
>   	int high;		/* high watermark, emptying needed */
>   	int batch;		/* chunk size for buddy add/remove */
>   	short free_factor;	/* batch scaling factor during free */
> -#ifdef CONFIG_NUMA
> -	short expire;		/* When 0, remote pagesets are drained */
> -#endif
>   
>   	/* Lists of pages, one per migrate type stored on the pcp-lists */
>   	struct list_head lists[NR_PCP_LISTS];
> Index: linux-vmstat-remote/mm/vmstat.c
> ===================================================================
> --- linux-vmstat-remote.orig/mm/vmstat.c
> +++ linux-vmstat-remote/mm/vmstat.c
> @@ -803,7 +803,7 @@ static int fold_diff(int *zone_diff, int
>    *
>    * The function returns the number of global counters updated.
>    */
> -static int refresh_cpu_vm_stats(bool do_pagesets)
> +static int refresh_cpu_vm_stats(void)
>   {
>   	struct pglist_data *pgdat;
>   	struct zone *zone;
> @@ -814,9 +814,6 @@ static int refresh_cpu_vm_stats(bool do_
>   
>   	for_each_populated_zone(zone) {
>   		struct per_cpu_zonestat __percpu *pzstats = zone->per_cpu_zonestats;
> -#ifdef CONFIG_NUMA
> -		struct per_cpu_pages __percpu *pcp = zone->per_cpu_pageset;
> -#endif
>   
>   		for (i = 0; i < NR_VM_ZONE_STAT_ITEMS; i++) {
>   			int v;
> @@ -826,44 +823,8 @@ static int refresh_cpu_vm_stats(bool do_
>   
>   				atomic_long_add(v, &zone->vm_stat[i]);
>   				global_zone_diff[i] += v;
> -#ifdef CONFIG_NUMA
> -				/* 3 seconds idle till flush */
> -				__this_cpu_write(pcp->expire, 3);
> -#endif
>   			}
>   		}
> -#ifdef CONFIG_NUMA
> -
> -		if (do_pagesets) {
> -			cond_resched();
> -			/*
> -			 * Deal with draining the remote pageset of this
> -			 * processor
> -			 *
> -			 * Check if there are pages remaining in this pageset
> -			 * if not then there is nothing to expire.
> -			 */
> -			if (!__this_cpu_read(pcp->expire) ||
> -			       !__this_cpu_read(pcp->count))
> -				continue;
> -
> -			/*
> -			 * We never drain zones local to this processor.
> -			 */
> -			if (zone_to_nid(zone) == numa_node_id()) {
> -				__this_cpu_write(pcp->expire, 0);
> -				continue;
> -			}
> -
> -			if (__this_cpu_dec_return(pcp->expire))
> -				continue;
> -
> -			if (__this_cpu_read(pcp->count)) {
> -				drain_zone_pages(zone, this_cpu_ptr(pcp));
> -				changes++;
> -			}
> -		}
> -#endif
>   	}

I think you can then also get rid of the "changes" local variable and do 
a "return fold_diff(global_zone_diff, global_node_diff);" directly.


-- 
Thanks,

David / dhildenb

