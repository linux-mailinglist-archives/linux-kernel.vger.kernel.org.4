Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F32495BDCEC
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Sep 2022 08:12:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230070AbiITGMe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Sep 2022 02:12:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229918AbiITGMb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Sep 2022 02:12:31 -0400
Received: from loongson.cn (mail.loongson.cn [114.242.206.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id A74233AE46
        for <linux-kernel@vger.kernel.org>; Mon, 19 Sep 2022 23:12:29 -0700 (PDT)
Received: from [10.180.13.185] (unknown [10.180.13.185])
        by localhost.localdomain (Coremail) with SMTP id AQAAf8DxvmvCWSljb3geAA--.37195S3;
        Tue, 20 Sep 2022 14:12:18 +0800 (CST)
Subject: Re: [PATCH] mm: vmscan: fix extreme overreclaim and swap floods
To:     Johannes Weiner <hannes@cmpxchg.org>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Mel Gorman <mgorman@techsingularity.net>,
        Hugh Dickins <hughd@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, kernel-team@fb.com,
        Yosry Ahmed <yosryahmed@google.com>
References: <20220802162811.39216-1-hannes@cmpxchg.org>
From:   Hongchen Zhang <zhanghongchen@loongson.cn>
Message-ID: <17f04d65-020e-a52d-41e8-0d540e32b475@loongson.cn>
Date:   Tue, 20 Sep 2022 14:12:17 +0800
User-Agent: Mozilla/5.0 (X11; Linux loongarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20220802162811.39216-1-hannes@cmpxchg.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-CM-TRANSID: AQAAf8DxvmvCWSljb3geAA--.37195S3
X-Coremail-Antispam: 1UD129KBjvJXoW3WFW3KFyDZrWxWr15ur47twb_yoW7Kw4rpF
        Z3Jw4jy3ykJr1fKa9rXa18WFyayrWxGrW3AryrGw1Iy3W3Gr1vyr42kwnxCFy7CrWkur1a
        vrZ09r9rua1jqFJanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUv0b7Iv0xC_Kw4lb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I2
        0VC2zVCF04k26cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rw
        A2F7IY1VAKz4vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Gr0_Xr1l84ACjcxK6xII
        jxv20xvEc7CjxVAFwI0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW8Jr0_Cr1UM28EF7xvwV
        C2z280aVCY1x0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC
        0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr
        1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcVAKI48JMxk0xIA0c2IEe2xFo4CEbIxvr21l
        c2xSY4AK6svPMxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I
        8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8
        ZwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x
        0267AKxVWUJVW8JwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_
        Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7IU5
        6c_DUUUUU==
X-CM-SenderInfo: x2kd0w5krqwupkhqwqxorr0wxvrqhubq/
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Johannes,

On 2022/8/3 am 12:28, Johannes Weiner wrote:
> During proactive reclaim, we sometimes observe severe overreclaim,
> with several thousand times more pages reclaimed than requested.
> 
> This trace was obtained from shrink_lruvec() during such an instance:
> 
>      prio:0 anon_cost:1141521 file_cost:7767
>      nr_reclaimed:4387406 nr_to_reclaim:1047 (or_factor:4190)
>      nr=[7161123 345 578 1111]
> 
> While he reclaimer requested 4M, vmscan reclaimed close to 16G, most
> of it by swapping. These requests take over a minute, during which the
> write() to memory.reclaim is unkillably stuck inside the kernel.
> 
> Digging into the source, this is caused by the proportional reclaim
> bailout logic. This code tries to resolve a fundamental conflict: to
> reclaim roughly what was requested, while also aging all LRUs fairly
> and in accordance to their size, swappiness, refault rates etc. The
> way it attempts fairness is that once the reclaim goal has been
> reached, it stops scanning the LRUs with the smaller remaining scan
> targets, and adjusts the remainder of the bigger LRUs according to how
> much of the smaller LRUs was scanned. It then finishes scanning that
> remainder regardless of the reclaim goal.
> 
> This works fine if priority levels are low and the LRU lists are
> comparable in size. However, in this instance, the cgroup that is
> targeted by proactive reclaim has almost no files left - they've
> already been squeezed out by proactive reclaim earlier - and the
> remaining anon pages are hot. Anon rotations cause the priority level
> to drop to 0, which results in reclaim targeting all of anon (a lot)
> and all of file (almost nothing). By the time reclaim decides to bail,
> it has scanned most or all of the file target, and therefor must also
> scan most or all of the enormous anon target. This target is thousands
> of times larger than the reclaim goal, thus causing the overreclaim.
> 
> The bailout code hasn't changed in years, why is this failing now?
> The most likely explanations are two other recent changes in anon
> reclaim:
> 
> 1. Before the series starting with commit 5df741963d52 ("mm: fix LRU
>     balancing effect of new transparent huge pages"), the VM was
>     overall relatively reluctant to swap at all, even if swap was
>     configured. This means the LRU balancing code didn't come into play
>     as often as it does now, and mostly in high pressure situations
>     where pronounced swap activity wouldn't be as surprising.
> 
> 2. For historic reasons, shrink_lruvec() loops on the scan targets of
>     all LRU lists except the active anon one, meaning it would bail if
>     the only remaining pages to scan were active anon - even if there
>     were a lot of them.
> 
>     Before the series starting with commit ccc5dc67340c ("mm/vmscan:
>     make active/inactive ratio as 1:1 for anon lru"), most anon pages
>     would live on the active LRU; the inactive one would contain only a
>     handful of preselected reclaim candidates. After the series, anon
>     gets aged similarly to file, and the inactive list is the default
>     for new anon pages as well, making it often the much bigger list.
> 
>     As a result, the VM is now more likely to actually finish large
>     anon targets than before.
> 
> Change the code such that only one SWAP_CLUSTER_MAX-sized nudge toward
> the larger LRU lists is made before bailing out on a met reclaim goal.
> 
> This fixes the extreme overreclaim problem.
> 
> Fairness is more subtle and harder to evaluate. No obvious misbehavior
> was observed on the test workload, in any case. Conceptually, fairness
> should primarily be a cumulative effect from regular, lower priority
> scans. Once the VM is in trouble and needs to escalate scan targets to
> make forward progress, fairness needs to take a backseat. This is also
> acknowledged by the myriad exceptions in get_scan_count(). This patch
> makes fairness decrease gradually, as it keeps fairness work static
> over increasing priority levels with growing scan targets. This should
> make more sense - although we may have to re-visit the exact values.
> 
> Signed-off-by: Johannes Weiner <hannes@cmpxchg.org>
> ---
>   mm/vmscan.c | 10 ++++------
>   1 file changed, 4 insertions(+), 6 deletions(-)
> 
> diff --git a/mm/vmscan.c b/mm/vmscan.c
> index f7d9a683e3a7..1cc0c6666787 100644
> --- a/mm/vmscan.c
> +++ b/mm/vmscan.c
> @@ -2897,8 +2897,8 @@ static void shrink_lruvec(struct lruvec *lruvec, struct scan_control *sc)
>   	enum lru_list lru;
>   	unsigned long nr_reclaimed = 0;
>   	unsigned long nr_to_reclaim = sc->nr_to_reclaim;
> +	bool proportional_reclaim;
>   	struct blk_plug plug;
> -	bool scan_adjusted;
>   
>   	get_scan_count(lruvec, sc, nr);
>   
> @@ -2916,8 +2916,8 @@ static void shrink_lruvec(struct lruvec *lruvec, struct scan_control *sc)
>   	 * abort proportional reclaim if either the file or anon lru has already
>   	 * dropped to zero at the first pass.
>   	 */
> -	scan_adjusted = (!cgroup_reclaim(sc) && !current_is_kswapd() &&
> -			 sc->priority == DEF_PRIORITY);
> +	proportional_reclaim = (!cgroup_reclaim(sc) && !current_is_kswapd() &&
> +				sc->priority == DEF_PRIORITY);
>   
>   	blk_start_plug(&plug);
>   	while (nr[LRU_INACTIVE_ANON] || nr[LRU_ACTIVE_FILE] ||
> @@ -2937,7 +2937,7 @@ static void shrink_lruvec(struct lruvec *lruvec, struct scan_control *sc)
>   
>   		cond_resched();
>   
> -		if (nr_reclaimed < nr_to_reclaim || scan_adjusted)
> +		if (nr_reclaimed < nr_to_reclaim || proportional_reclaim)
>   			continue;
>   
>   		/*
> @@ -2988,8 +2988,6 @@ static void shrink_lruvec(struct lruvec *lruvec, struct scan_control *sc)
>   		nr_scanned = targets[lru] - nr[lru];
>   		nr[lru] = targets[lru] * (100 - percentage) / 100;
>   		nr[lru] -= min(nr[lru], nr_scanned);
We should not just remove the following line because kswapd may also 
call this function and there is no side effect to do scan adjust for 
kswapd,so it may be better to change like this:
+    if (current_is_kswapd())
		scan_adjusted = true;
> -
> -		scan_adjusted = true
>   	}
>   	blk_finish_plug(&plug);
>   	sc->nr_reclaimed += nr_reclaimed;
> 

Thanks
Hongchen Zhang

