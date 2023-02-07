Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8EB2B68DD9F
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Feb 2023 17:11:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232568AbjBGQLN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Feb 2023 11:11:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232057AbjBGQLK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Feb 2023 11:11:10 -0500
Received: from mailout2n.rrzn.uni-hannover.de (mailout2n.rrzn.uni-hannover.de [130.75.2.113])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA9E81204F
        for <linux-kernel@vger.kernel.org>; Tue,  7 Feb 2023 08:11:02 -0800 (PST)
Received: from [10.23.33.223] (lab.sra.uni-hannover.de [130.75.33.87])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by mailout2n.rrzn.uni-hannover.de (Postfix) with ESMTPSA id 4787B1F53B;
        Tue,  7 Feb 2023 17:11:00 +0100 (CET)
Message-ID: <68ba44d8-6899-c018-dcb3-36f3a96e6bea@sra.uni-hannover.de>
Date:   Tue, 7 Feb 2023 17:11:00 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH] mm: reduce lock contention of pcp buffer refill
Content-Language: en-US, de-DE
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Vlastimil Babka <vbabka@suse.cz>,
        Mel Gorman <mgorman@techsingularity.net>
References: <20230201162549.68384-1-halbuer@sra.uni-hannover.de>
 <20230202152501.297639031e96baad35cdab17@linux-foundation.org>
From:   Alexander Halbuer <halbuer@sra.uni-hannover.de>
In-Reply-To: <20230202152501.297639031e96baad35cdab17@linux-foundation.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: clamav-milter 0.103.7 at mailout2n
X-Virus-Status: Clean
X-Spam-Status: No, score=-5.3 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/3/23 00:25, Andrew Morton wrote:
> On Wed,  1 Feb 2023 17:25:49 +0100 Alexander Halbuer <halbuer@sra.uni-hannover.de> wrote:
>
>> The `rmqueue_bulk` function batches the allocation of multiple elements to
>> refill the per-CPU buffers into a single hold of the zone lock. Each
>> element is allocated and checked using the `check_pcp_refill` function.
>> The check touches every related struct page which is especially expensive
>> for higher order allocations (huge pages). This patch reduces the time
>> holding the lock by moving the check out of the critical section similar
>> to the `rmqueue_buddy` function which allocates a single element.
>> Measurements of parallel allocation-heavy workloads show a reduction of
>> the average huge page allocation latency of 50 percent for two cores and
>> nearly 90 percent for 24 cores.
> Sounds nice.
>
> Were you able to test how much benefit we get by simply removing the
> check_new_pages() call from rmqueue_bulk()?
I did some further investigations and measurements to quantify potential
performance gains. Benchmarks ran on a machine with 24 physical cores
fixed at 2.1 GHz. The results show significant performance gains with the
patch applied in parallel scenarios. Eliminating the check reduces
allocation latency further, especially for low core counts.

The following tables show the average allocation latencies for huge pages
and normal pages for three different configurations:
The unpatched kernel, the patched kernel, and an additional version
without the check.

Huge pages
+-------+---------+-------+----------+---------+----------+
| Cores | Default | Patch |    Patch | NoCheck |  NoCheck |
|       |    (ns) |  (ns) |     Diff |    (ns) |     Diff |
+-------+---------+-------+----------+---------+----------+
|     1 |     127 |   124 |  (-2.4%) |     118 |  (-7.1%) |
|     2 |     140 |   140 |  (-0.0%) |     134 |  (-4.3%) |
|     3 |     143 |   142 |  (-0.7%) |     134 |  (-6.3%) |
|     4 |     178 |   159 | (-10.7%) |     156 | (-12.4%) |
|     6 |     269 |   239 | (-11.2%) |     237 | (-11.9%) |
|     8 |     363 |   321 | (-11.6%) |     319 | (-12.1%) |
|    10 |     454 |   409 |  (-9.9%) |     409 |  (-9.9%) |
|    12 |     545 |   494 |  (-9.4%) |     488 | (-10.5%) |
|    14 |     639 |   578 |  (-9.5%) |     574 | (-10.2%) |
|    16 |     735 |   660 | (-10.2%) |     653 | (-11.2%) |
|    20 |     915 |   826 |  (-9.7%) |     815 | (-10.9%) |
|    24 |    1105 |   992 | (-10.2%) |     982 | (-11.1%) |
+-------+---------+-------+----------+---------+----------+

Normal pages
+-------+---------+-------+----------+---------+----------+
| Cores | Default | Patch |    Patch | NoCheck |  NoCheck |
|       |    (ns) |  (ns) |     Diff |    (ns) |     Diff |
+-------+---------+-------+----------+---------+----------+
|     1 |    2790 |  2767 |  (-0.8%) |     171 | (-93.9%) |
|     2 |    6685 |  3484 | (-47.9%) |     519 | (-92.2%) |
|     3 |   10501 |  3599 | (-65.7%) |     855 | (-91.9%) |
|     4 |   14264 |  3635 | (-74.5%) |    1139 | (-92.0%) |
|     6 |   21800 |  3551 | (-83.7%) |    1713 | (-92.1%) |
|     8 |   29563 |  3570 | (-87.9%) |    2268 | (-92.3%) |
|    10 |   37210 |  3845 | (-89.7%) |    2872 | (-92.3%) |
|    12 |   44780 |  4452 | (-90.1%) |    3417 | (-92.4%) |
|    14 |   52576 |  5100 | (-90.3%) |    4020 | (-92.4%) |
|    16 |   60118 |  5785 | (-90.4%) |    4604 | (-92.3%) |
|    20 |   75037 |  7270 | (-90.3%) |    6486 | (-91.4%) |
|    24 |   90226 |  8712 | (-90.3%) |    7061 | (-92.2%) |
+-------+---------+-------+----------+---------+----------+

>
> Vlastimil, I find this quite confusing:
>
> #ifdef CONFIG_DEBUG_VM
> /*
>  * With DEBUG_VM enabled, order-0 pages are checked for expected state when
>  * being allocated from pcp lists. With debug_pagealloc also enabled, they are
>  * also checked when pcp lists are refilled from the free lists.
>  */
> static inline bool check_pcp_refill(struct page *page, unsigned int order)
> {
> 	if (debug_pagealloc_enabled_static())
> 		return check_new_pages(page, order);
> 	else
> 		return false;
> }
>
> static inline bool check_new_pcp(struct page *page, unsigned int order)
> {
> 	return check_new_pages(page, order);
> }
> #else
> /*
>  * With DEBUG_VM disabled, free order-0 pages are checked for expected state
>  * when pcp lists are being refilled from the free lists. With debug_pagealloc
>  * enabled, they are also checked when being allocated from the pcp lists.
>  */
> static inline bool check_pcp_refill(struct page *page, unsigned int order)
> {
> 	return check_new_pages(page, order);
> }
> static inline bool check_new_pcp(struct page *page, unsigned int order)
> {
> 	if (debug_pagealloc_enabled_static())
> 		return check_new_pages(page, order);
> 	else
> 		return false;
> }
> #endif /* CONFIG_DEBUG_VM */
>
> and the 4462b32c9285b5 changelog is a struggle to follow.
>
> Why are we performing *any* checks when CONFIG_DEBUG_VM=n and when
> debug_pagealloc_enabled is false?
>
> Anyway, these checks sounds quite costly so let's revisit their
> desirability?
>
