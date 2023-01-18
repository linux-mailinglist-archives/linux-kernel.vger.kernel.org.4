Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8449F6715C1
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Jan 2023 09:03:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230171AbjARIAp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Jan 2023 03:00:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230017AbjARHzj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jan 2023 02:55:39 -0500
Received: from mailout4.samsung.com (mailout4.samsung.com [203.254.224.34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A10655CE4F
        for <linux-kernel@vger.kernel.org>; Tue, 17 Jan 2023 23:30:49 -0800 (PST)
Received: from epcas1p2.samsung.com (unknown [182.195.41.46])
        by mailout4.samsung.com (KnoxPortal) with ESMTP id 20230118073045epoutp04689d2b0900c6000ba652f70ee8e4e025~7VrppfAyN3027130271epoutp04A
        for <linux-kernel@vger.kernel.org>; Wed, 18 Jan 2023 07:30:45 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20230118073045epoutp04689d2b0900c6000ba652f70ee8e4e025~7VrppfAyN3027130271epoutp04A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1674027045;
        bh=Mk/gVMHoQkviJHB/RZY8wpTqchJN8FLsYyp7/T+vxaQ=;
        h=Subject:Reply-To:From:To:CC:In-Reply-To:Date:References:From;
        b=LjjFrmPF/eR4V4aDWQbDX3tAhLGjY9Z+JMk+Kdt5vYyfrVjFCXAypSYw6IymdOPWC
         P+sVC3tfaq+jViAFLdecdzVxGjMmsrfNfXlU8Olrbk04sqQ4IGLGEgN3Y4iyLWDZhk
         8woMEAgkvKTI/lbPQ9Km5km5wSUFcsbg/g3/gh1o=
Received: from epsnrtp2.localdomain (unknown [182.195.42.163]) by
        epcas1p1.samsung.com (KnoxPortal) with ESMTP id
        20230118073044epcas1p1d8eeb0bd5f2af8e3a8cf72bcd29944f7~7VrpOPmqA2248322483epcas1p1L;
        Wed, 18 Jan 2023 07:30:44 +0000 (GMT)
Received: from epsmges1p1.samsung.com (unknown [182.195.38.241]) by
        epsnrtp2.localdomain (Postfix) with ESMTP id 4Nxcqm2DPWz4x9Px; Wed, 18 Jan
        2023 07:30:44 +0000 (GMT)
X-AuditID: b6c32a35-7ba26a8000014e05-9f-63c7a024ce89
Received: from epcas1p4.samsung.com ( [182.195.41.48]) by
        epsmges1p1.samsung.com (Symantec Messaging Gateway) with SMTP id
        FD.01.19973.420A7C36; Wed, 18 Jan 2023 16:30:44 +0900 (KST)
Mime-Version: 1.0
Subject: Re: [PATCH] dma-buf: system_heap: avoid reclaim for order 4
Reply-To: jaewon31.kim@samsung.com
Sender: Jaewon Kim <jaewon31.kim@samsung.com>
From:   Jaewon Kim <jaewon31.kim@samsung.com>
To:     John Stultz <jstultz@google.com>
CC:     "sumit.semwal@linaro.org" <sumit.semwal@linaro.org>,
        "daniel.vetter@ffwll.ch" <daniel.vetter@ffwll.ch>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "hannes@cmpxchg.org" <hannes@cmpxchg.org>,
        "mhocko@kernel.org" <mhocko@kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "jaewon31.kim@gmail.com" <jaewon31.kim@gmail.com>,
        "T.J. Mercier" <tjmercier@google.com>
X-Priority: 3
X-Content-Kind-Code: NORMAL
In-Reply-To: <CANDhNCpKY5Af059ok8ZcgJ=wt7NaorZxqQXaTS848CwY0LNFiw@mail.gmail.com>
X-Drm-Type: N,general
X-Msg-Generator: Mail
X-Msg-Type: PERSONAL
X-Reply-Demand: N
Message-ID: <20230118073043epcms1p8b5cfde0d773e296770775581b6ce7105@epcms1p8>
Date:   Wed, 18 Jan 2023 16:30:43 +0900
X-CMS-MailID: 20230118073043epcms1p8b5cfde0d773e296770775581b6ce7105
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrEJsWRmVeSWpSXmKPExsWy7bCmga7KguPJBg1tvBZz1q9hs1j48C6z
        xepNvhbdm2cyWvS+f8Vk8efERjaLy7vmsFncW/Of1eL1t2XMFqfufma3eLf+C5sDt8fhN++Z
        PfZ+W8DisXPWXXaPBZtKPTat6mTz2PRpErvHnWt72DxOzPjN4tG3ZRWjx+dNcgFcUdk2GamJ
        KalFCql5yfkpmXnptkrewfHO8aZmBoa6hpYW5koKeYm5qbZKLj4Bum6ZOUAXKymUJeaUAoUC
        EouLlfTtbIryS0tSFTLyi0tslVILUnIKzAr0ihNzi0vz0vXyUkusDA0MjEyBChOyM/Z+PsRe
        sCW84tyCHSwNjAccuxg5OSQETCTe3T/NAmILCexglHjUKtnFyMHBKyAo8XeHMEhYWMBF4vbq
        PmaIEiWJsz+usEPEdSWauleDtbIJaEu8XzCJFcQWEVCReDj3J1sXIxcHs8BJZokrfw6xQezi
        lZjR/pQFwpaW2L58KyOIzSkQKLF34S5miLioxM3Vb9lh7PfH5jNC2CISrffOQtUISjz4uRsq
        LiVxrvs4E4RdLrFjzn6oXRUSv/uXQc3Rl7jSPxOshlfAV2L2lFawQ1kEVCVOvrnPClHjItHT
        +QGsl1lAXmL72znMoHBgFtCUWL9LH6JEUWLn77mMECV8Eu++9rDCvLVj3hOoE9QkWp59hYrL
        SPz99wzK9pBoXtPEAgoTIYF+Jon+9VdZJzAqzEIE9Swkm2chbF7AyLyKUSy1oDg3PbXYsMAQ
        HrnJ+bmbGMGJV8t0B+PEtx/0DjEycTAeYpTgYFYS4fXbdThZiDclsbIqtSg/vqg0J7X4EKMp
        0M8TmaVEk/OBqT+vJN7QxNLAxMzIxMLY0thMSZzXJmJdspBAemJJanZqakFqEUwfEwenVAPT
        AVObM9aTL87f/Hzf9S0bbTlu/N83iT3gxpzeSVsTl9z+2BGYflWjR3DNjuM7voedUT0Td2XV
        96zPki+LanJP/q/edlPvzKH4gp2a9nd/t4rYqltmL/FQa1bp8hE/tYp1ahqHv7nF1VOTr17n
        Wh56hPv0tRjB7+f5PocZmE58nmifaKvbevH76ewHk3fH8M7qSnU7vXZlTIxnXhXjJIYF05UY
        1WP2P1+mcNWjnOPLt/6YlW9KTC/efc2mrPIk4rfXqxz3wMjvz/dfPzcx+t+KZUc+ZvlEBU6V
        Lepf/Vfe6pLrcukZsxvXPn0ftSQxMnCHLvfUzDfX5Z98jdKYa1GSd1tN+fyePSzsB88vCJzu
        ukaJpTgj0VCLuag4EQA3viykRQQAAA==
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20230117082521epcas1p22a709521a9e6d2346d06ac220786560d
References: <CANDhNCpKY5Af059ok8ZcgJ=wt7NaorZxqQXaTS848CwY0LNFiw@mail.gmail.com>
        <20230117082508.8953-1-jaewon31.kim@samsung.com>
        <20230117083103epcms1p63382eee1cce1077248a4b634681b0aca@epcms1p6>
        <CGME20230117082521epcas1p22a709521a9e6d2346d06ac220786560d@epcms1p8>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>On Tue, Jan 17, 2023 at 12:31 AM Jaewon Kim <jaewon31.kim@samsung.com> wrote:
>> > Using order 4 pages would be helpful for many IOMMUs, but it could spend
>> > quite much time in page allocation perspective.
>> >
>> > The order 4 allocation with __GFP_RECLAIM may spend much time in
>> > reclaim and compation logic. __GFP_NORETRY also may affect. These cause
>> > unpredictable delay.
>> >
>> > To get reasonable allocation speed from dma-buf system heap, use
>> > HIGH_ORDER_GFP for order 4 to avoid reclaim.
>
>Thanks for sharing this!
>The case where the allocation gets stuck behind reclaim under pressure
>does sound undesirable, but I'd be a bit hesitant to tweak numbers
>that have been used for a long while (going back to ion) without a bit
>more data.
>
>It might be good to also better understand the tradeoff of potential
>on-going impact to performance from using low order pages when the
>buffer is used.  Do you have any details like or tests that you could
>share to help ensure this won't impact other users?
>
>TJ: Do you have any additional thoughts on this?
>
>thanks
>-john

Let me share what I tested with trace events of compaction, direct_reclaim.
This log was captured within one dma-buf alloc for 1,957,888 byte size.
It shows direct reclaim spent 4.973 msec total so that it could reclaim 209 pages total.
But it spent 12.606 msec in compaction.
I might miss preempted time but I think compaction is quite time consuming job.

Sorry I don't know how much the current gfp is helpful to IOMMU.
I think the default should be set like my change to improve allocation,
and the current gfp could be set if need through other options like cmdline.

-5972    [006] ....  7971.248176: mm_compaction_begin: zone_start=0x40000 migrate_pfn=0x40000 free_pfn=0xffc00 zone_end=0x100000, mode=async                     
-5972    [006] ....  7971.248394: mm_compaction_end: zone_start=0x40000 migrate_pfn=0xac800 free_pfn=0xffc00 zone_end=0x100000, mode=async status=contended      
-5972    [006] ....  7971.248399: mm_vmscan_direct_reclaim_begin: order=4 gfp_flags=GFP_HIGHUSER|__GFP_NOWARN|__GFP_COMP|__GFP_ZERO                              
-5972    [006] ....  7971.248922: mm_vmscan_direct_reclaim_end: nr_reclaimed=17                                                                                  
-5972    [006] ....  7971.248974: mm_compaction_begin: zone_start=0x40000 migrate_pfn=0xacc00 free_pfn=0xffc00 zone_end=0x100000, mode=async                     
-5972    [006] ....  7971.249063: mm_compaction_end: zone_start=0x40000 migrate_pfn=0xb5c00 free_pfn=0xffc00 zone_end=0x100000, mode=async status=contended      
-5972    [006] ....  7971.249067: mm_vmscan_direct_reclaim_begin: order=4 gfp_flags=GFP_HIGHUSER|__GFP_NOWARN|__GFP_COMP|__GFP_ZERO                              
-5972    [006] ....  7971.249768: mm_vmscan_direct_reclaim_end: nr_reclaimed=18                                                                                  
-5972    [006] ....  7971.249843: mm_compaction_begin: zone_start=0x40000 migrate_pfn=0xb6000 free_pfn=0xafc00 zone_end=0x100000, mode=async                     
-5972    [006] ....  7971.249845: mm_compaction_end: zone_start=0x40000 migrate_pfn=0xb6000 free_pfn=0xafc00 zone_end=0x100000, mode=async status=partial_skipped
-5972    [006] ....  7971.249849: mm_vmscan_direct_reclaim_begin: order=4 gfp_flags=GFP_HIGHUSER|__GFP_NOWARN|__GFP_COMP|__GFP_ZERO                              
-5972    [006] ....  7971.250116: mm_vmscan_direct_reclaim_end: nr_reclaimed=22                                                                                  
-5972    [006] ....  7971.250152: mm_compaction_begin: zone_start=0x40000 migrate_pfn=0x40000 free_pfn=0xaf800 zone_end=0x100000, mode=async                     
-5972    [006] ....  7971.250305: mm_compaction_end: zone_start=0x40000 migrate_pfn=0xac400 free_pfn=0xaf800 zone_end=0x100000, mode=async status=success        
-5972    [006] ....  7971.250375: mm_compaction_begin: zone_start=0x40000 migrate_pfn=0xac800 free_pfn=0xaf800 zone_end=0x100000, mode=async                     
-5972    [006] ....  7971.250380: mm_compaction_end: zone_start=0x40000 migrate_pfn=0xaf800 free_pfn=0xaf800 zone_end=0x100000, mode=async status=partial_skipped
-5972    [006] ....  7971.250384: mm_vmscan_direct_reclaim_begin: order=4 gfp_flags=GFP_HIGHUSER|__GFP_NOWARN|__GFP_COMP|__GFP_ZERO                              
-5972    [006] ....  7971.250597: mm_vmscan_direct_reclaim_end: nr_reclaimed=20                                                                                  
-5972    [006] ....  7971.251289: mm_compaction_begin: zone_start=0x40000 migrate_pfn=0x40000 free_pfn=0xaf000 zone_end=0x100000, mode=async                     
-5972    [006] ....  7971.251497: mm_compaction_end: zone_start=0x40000 migrate_pfn=0xac400 free_pfn=0xaf000 zone_end=0x100000, mode=async status=contended      
-5972    [006] ....  7971.251502: mm_vmscan_direct_reclaim_begin: order=4 gfp_flags=GFP_HIGHUSER|__GFP_NOWARN|__GFP_COMP|__GFP_ZERO                              
-5972    [006] ....  7971.251797: mm_vmscan_direct_reclaim_end: nr_reclaimed=22                                                                                  
-5972    [006] ....  7971.251890: mm_compaction_begin: zone_start=0x40000 migrate_pfn=0x5b400 free_pfn=0xb0400 zone_end=0x100000, mode=sync                      
-5972    [006] ....  7971.252740: mm_compaction_end: zone_start=0x40000 migrate_pfn=0x63800 free_pfn=0xb0400 zone_end=0x100000, mode=sync status=success         
-5972    [006] ....  7971.252774: mm_compaction_begin: zone_start=0x40000 migrate_pfn=0x63c00 free_pfn=0xb0000 zone_end=0x100000, mode=async                     
-5972    [006] ....  7971.253325: mm_compaction_end: zone_start=0x40000 migrate_pfn=0x74e20 free_pfn=0xade92 zone_end=0x100000, mode=async status=success        
-5972    [006] ....  7971.253333: mm_compaction_begin: zone_start=0x40000 migrate_pfn=0x83400 free_pfn=0xafc00 zone_end=0x100000, mode=async                     
-5972    [006] ....  7971.253683: mm_compaction_end: zone_start=0x40000 migrate_pfn=0xac400 free_pfn=0xafc00 zone_end=0x100000, mode=async status=contended      
-5972    [006] ....  7971.253688: mm_vmscan_direct_reclaim_begin: order=4 gfp_flags=GFP_HIGHUSER|__GFP_NOWARN|__GFP_COMP|__GFP_ZERO                              
-5972    [006] ....  7971.254134: mm_vmscan_direct_reclaim_end: nr_reclaimed=22                                                                                  
-5972    [006] ....  7971.254206: mm_compaction_begin: zone_start=0x40000 migrate_pfn=0xad000 free_pfn=0xafc00 zone_end=0x100000, mode=async                     
-5972    [006] ....  7971.254289: mm_compaction_end: zone_start=0x40000 migrate_pfn=0xae1c0 free_pfn=0xae000 zone_end=0x100000, mode=async status=partial_skipped
-5972    [006] ....  7971.254304: mm_compaction_begin: zone_start=0x40000 migrate_pfn=0x40000 free_pfn=0xffc00 zone_end=0x100000, mode=async                     
-5972    [006] ....  7971.254510: mm_compaction_end: zone_start=0x40000 migrate_pfn=0x74db0 free_pfn=0xadcc1 zone_end=0x100000, mode=async status=success        
-5972    [006] ....  7971.254519: mm_compaction_begin: zone_start=0x40000 migrate_pfn=0x75000 free_pfn=0xffc00 zone_end=0x100000, mode=async                     
-5972    [006] ....  7971.254612: mm_compaction_end: zone_start=0x40000 migrate_pfn=0xac400 free_pfn=0xffc00 zone_end=0x100000, mode=async status=contended      
-5972    [006] ....  7971.254617: mm_vmscan_direct_reclaim_begin: order=4 gfp_flags=GFP_HIGHUSER|__GFP_NOWARN|__GFP_COMP|__GFP_ZERO                              
-5972    [006] ....  7971.255303: mm_vmscan_direct_reclaim_end: nr_reclaimed=22                                                                                  
-5972    [006] ....  7971.255307: mm_compaction_begin: zone_start=0x40000 migrate_pfn=0x75000 free_pfn=0xffc00 zone_end=0x100000, mode=sync                      
-5972    [006] ....  7971.260198: mm_compaction_end: zone_start=0x40000 migrate_pfn=0x751e5 free_pfn=0xaa83f zone_end=0x100000, mode=sync status=success         
-5972    [006] ....  7971.260236: mm_compaction_begin: zone_start=0x40000 migrate_pfn=0x40000 free_pfn=0xffc00 zone_end=0x100000, mode=async                     
-5972    [006] ....  7971.260883: mm_compaction_end: zone_start=0x40000 migrate_pfn=0xb5c00 free_pfn=0xffc00 zone_end=0x100000, mode=async status=contended      
-5972    [006] ....  7971.260891: mm_vmscan_direct_reclaim_begin: order=4 gfp_flags=GFP_HIGHUSER|__GFP_NOWARN|__GFP_COMP|__GFP_ZERO                              
-5972    [006] ....  7971.261174: mm_vmscan_direct_reclaim_end: nr_reclaimed=22                                                                                  
-5972    [006] ....  7971.261178: mm_compaction_begin: zone_start=0x40000 migrate_pfn=0x75000 free_pfn=0xffc00 zone_end=0x100000, mode=sync                      
-5972    [006] ....  7971.264861: mm_compaction_end: zone_start=0x40000 migrate_pfn=0x75681 free_pfn=0xffc00 zone_end=0x100000, mode=sync status=success         
-5972    [006] ....  7971.264873: mm_compaction_begin: zone_start=0x40000 migrate_pfn=0xbbc00 free_pfn=0xffc00 zone_end=0x100000, mode=async                     
-5972    [006] ....  7971.264889: mm_compaction_end: zone_start=0x40000 migrate_pfn=0xc1400 free_pfn=0xffc00 zone_end=0x100000, mode=async status=contended      
-5972    [006] ....  7971.264891: mm_vmscan_direct_reclaim_begin: order=4 gfp_flags=GFP_HIGHUSER|__GFP_NOWARN|__GFP_COMP|__GFP_ZERO                              
-5972    [006] ....  7971.265141: mm_vmscan_direct_reclaim_end: nr_reclaimed=22                                                                                  
-5972    [002] ....  7971.265585: mm_compaction_begin: zone_start=0x40000 migrate_pfn=0xc1800 free_pfn=0xffc00 zone_end=0x100000, mode=async                     
-5972    [002] ....  7971.265669: mm_compaction_end: zone_start=0x40000 migrate_pfn=0xc2c00 free_pfn=0xffc00 zone_end=0x100000, mode=async status=contended      
-5972    [002] ....  7971.265678: mm_vmscan_direct_reclaim_begin: order=4 gfp_flags=GFP_HIGHUSER|__GFP_NOWARN|__GFP_COMP|__GFP_ZERO                              
-5972    [002] ....  7971.266987: mm_vmscan_direct_reclaim_end: nr_reclaimed=22                                                                                  
-5972    [006] ....  7971.267466: mm_compaction_begin: zone_start=0x40000 migrate_pfn=0x40000 free_pfn=0xffc00 zone_end=0x100000, mode=sync                      
-5972    [006] ....  7971.267778: mm_compaction_end: zone_start=0x40000 migrate_pfn=0x5d000 free_pfn=0xffc00 zone_end=0x100000, mode=sync status=success         
-5972    [006] ....  7971.267927: mm_compaction_begin: zone_start=0x40000 migrate_pfn=0x5c000 free_pfn=0xffc00 zone_end=0x100000, mode=async                     
-5972    [006] ....  7971.268092: mm_compaction_end: zone_start=0x40000 migrate_pfn=0x74d70 free_pfn=0xffc00 zone_end=0x100000, mode=async status=success        

Thank you
Jaewon Kim
