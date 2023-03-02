Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C91A26A7FB7
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Mar 2023 11:11:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229694AbjCBKLD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Mar 2023 05:11:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229982AbjCBKLB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Mar 2023 05:11:01 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76B283D919
        for <linux-kernel@vger.kernel.org>; Thu,  2 Mar 2023 02:10:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1677751808;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=LUPUq9rwM+2uCcwp+cjvg22RkhBv6eu14BsYsubV2S4=;
        b=TFgoaezw1ZICY41EGsUSdUxkJcgCx51RBfdg5Gd/xa/hVyY++9fY7piM6xfgmNZ2Ah1gML
        SHCP5hCOZnOGgNVCsGsEEcHN9xmtnQcscT1F5nwoAw3Si4N1VcDOnANjbvLQDSaiP4O6CK
        Wok0cw3CIGDRN7+9FWTEd147cBRvpxY=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-279-icqTaHY8PIWNyOk7ZAVIgQ-1; Thu, 02 Mar 2023 05:10:06 -0500
X-MC-Unique: icqTaHY8PIWNyOk7ZAVIgQ-1
Received: by mail-wm1-f69.google.com with SMTP id m28-20020a05600c3b1c00b003e7d4662b83so1069150wms.0
        for <linux-kernel@vger.kernel.org>; Thu, 02 Mar 2023 02:10:06 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LUPUq9rwM+2uCcwp+cjvg22RkhBv6eu14BsYsubV2S4=;
        b=jAA/XwXvTvRyv8fEJzanxJ8Ne2dYIB7Oln15fGTiS3UzCKlZI2AWI+mL8P4qmGXZBb
         ivchN9EYdhHs/48KRHRxmOFWwSvcnIRAwDIXmVf5V12D+DIg/f0g3JW7BBeIXvU46kzT
         SUX/mJZR4LgVF/ZFSCYFh+mOu/0zTvToIPmlWr1HlZ34EA/4Sz7d2lS22mvTMPDn9A3e
         GvoXtuzQPvak5+iSixXuSbrgQI5YGXxfXUAyIqhmL+hYmk3CsQcop/sAbF1cJnUIH7Kx
         7WQ3qUhTPRf34qL0KGHgn6Ci78xjzoGf5UtnkjiRkUQ+3n1csdmZk5hshcR+i9rQJooz
         nWTw==
X-Gm-Message-State: AO0yUKVss2QOdoyUH0ehUESpvGGJhSLoVfBjNedqm9ZLojMXVnCfqhu8
        QUY9dtFVi4KDwQ103R+IUTdzYk5pkDIzZNb8eTWSPH831wgfgI1hdqOl6egnZPzSrqF0ddyG5hv
        1hUZWHY5GGEngFWDVsP1v7RiH
X-Received: by 2002:a05:600c:4590:b0:3eb:3945:d3f1 with SMTP id r16-20020a05600c459000b003eb3945d3f1mr6873241wmo.5.1677751805512;
        Thu, 02 Mar 2023 02:10:05 -0800 (PST)
X-Google-Smtp-Source: AK7set9K2AzGQBPeisGsiHzjscpGYd24l7mhU6n0z2IIo/uIK6J3kzQV4bxrLrhC3WeAmqQld33fvA==
X-Received: by 2002:a05:600c:4590:b0:3eb:3945:d3f1 with SMTP id r16-20020a05600c459000b003eb3945d3f1mr6873222wmo.5.1677751805149;
        Thu, 02 Mar 2023 02:10:05 -0800 (PST)
Received: from ?IPV6:2003:cb:c70e:4f00:87ba:e9e9:3821:677b? (p200300cbc70e4f0087bae9e93821677b.dip0.t-ipconnect.de. [2003:cb:c70e:4f00:87ba:e9e9:3821:677b])
        by smtp.gmail.com with ESMTPSA id j8-20020a056000124800b002c71d206329sm14655629wrx.55.2023.03.02.02.10.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 02 Mar 2023 02:10:04 -0800 (PST)
Message-ID: <3329f63e-5671-1500-0730-cd46ba461d04@redhat.com>
Date:   Thu, 2 Mar 2023 11:10:03 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH v2 01/11] mm/vmstat: remove remote node draining
Content-Language: en-US
To:     Marcelo Tosatti <mtosatti@redhat.com>
Cc:     Christoph Lameter <cl@linux.com>,
        Aaron Tomlin <atomlin@atomlin.com>,
        Frederic Weisbecker <frederic@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Mel Gorman <mgorman@suse.de>, Vlastimil Babka <vbabka@suse.cz>
References: <20230209150150.380060673@redhat.com>
 <20230209153204.656996515@redhat.com>
 <6b6cd2fe-2309-b471-8950-3c4334462e69@redhat.com> <Y/5XoAnv43zYzxLR@tpad>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <Y/5XoAnv43zYzxLR@tpad>
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

[...]

> 
>> (2) drain_zone_pages() documents that we're draining the PCP
>>      (bulk-freeing them) of the current CPU on remote nodes. That bulk-
>>      freeing will properly adjust free memory counters. What exactly is
>>      the impact when no longer doing that? Won't the "snapshot" of some
>>      counters eventually be wrong? Do we care?
> 
> Don't see why the snapshot of counters will be wrong.
> 
> Instead of freeing pages on pcp list of remote nodes after they are
> considered idle ("3 seconds idle till flush"), what will happen is that
> drain_all_pages() will free those pcps, for example after an allocation
> fails on direct reclaim:
> 
>          page = get_page_from_freelist(gfp_mask, order, alloc_flags, ac);
> 
>          /*
>           * If an allocation failed after direct reclaim, it could be because
>           * pages are pinned on the per-cpu lists or in high alloc reserves.
>           * Shrink them and try again
>           */
>          if (!page && !drained) {
>                  unreserve_highatomic_pageblock(ac, false);
>                  drain_all_pages(NULL);
>                  drained = true;
>                  goto retry;
>          }
> 
> In both cases the pages are freed (and counters maintained) here:
> 
> static inline void __free_one_page(struct page *page,
>                  unsigned long pfn,
>                  struct zone *zone, unsigned int order,
>                  int migratetype, fpi_t fpi_flags)
> {
>          struct capture_control *capc = task_capc(zone);
>          unsigned long buddy_pfn = 0;
>          unsigned long combined_pfn;
>          struct page *buddy;
>          bool to_tail;
> 
>          VM_BUG_ON(!zone_is_initialized(zone));
>          VM_BUG_ON_PAGE(page->flags & PAGE_FLAGS_CHECK_AT_PREP, page);
> 
>          VM_BUG_ON(migratetype == -1);
>          if (likely(!is_migrate_isolate(migratetype)))
>                  __mod_zone_freepage_state(zone, 1 << order, migratetype);
> 
>          VM_BUG_ON_PAGE(pfn & ((1 << order) - 1), page);
>          VM_BUG_ON_PAGE(bad_range(zone, page), page);
> 
>          while (order < MAX_ORDER - 1) {
>                  if (compaction_capture(capc, page, order, migratetype)) {
>                          __mod_zone_freepage_state(zone, -(1 << order),
>                                                                  migratetype);
>                          return;
>                  }
> 
>> Describing the difference between instructed refresh of vmstat and "remotely
>> drain per-cpu lists" in order to move free memory from the pcp to the buddy
>> would be great.
> 
> The difference is that now remote PCPs will be drained on demand, either via
> kcompactd or direct reclaim (through drain_all_pages), when memory is
> low.
> 
> For example, with the following test:
> 
> dd if=/dev/zero of=file bs=1M count=32000 on a tmpfs filesystem:
> 
>        kcompactd0-116     [005] ...1 228232.042873: drain_all_pages <-kcompactd_do_work
>        kcompactd0-116     [005] ...1 228232.042873: __drain_all_pages <-kcompactd_do_work
>                dd-479485  [003] ...1 228232.455130: __drain_all_pages <-__alloc_pages_slowpath.constprop.0
>                dd-479485  [011] ...1 228232.721994: __drain_all_pages <-__alloc_pages_slowpath.constprop.0
>       gnome-shell-3750    [015] ...1 228232.723729: __drain_all_pages <-__alloc_pages_slowpath.constprop.0
> 
> The commit message was indeed incorrect. Updated one:
> 
> "mm/vmstat: remove remote node draining
> 
> Draining of pages from the local pcp for a remote zone should not be
> necessary, since once the system is low on memory (or compaction on a
> zone is in effect), drain_all_pages should be called freeing any unused
> pcps."
> 
> Thanks!

Thanks for the explanation, that makes sense to me. Feel free to add my

Acked-by: David Hildenbrand <david@redhat.com>

... hoping that some others (Mel, Vlastimil?) can have another look.

-- 
Thanks,

David / dhildenb

