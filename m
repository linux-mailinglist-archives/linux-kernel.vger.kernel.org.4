Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 90CA362FF5A
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Nov 2022 22:27:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230247AbiKRV1p (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Nov 2022 16:27:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229483AbiKRV1n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Nov 2022 16:27:43 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6CFC4A28A7
        for <linux-kernel@vger.kernel.org>; Fri, 18 Nov 2022 13:27:43 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0A21E625DE
        for <linux-kernel@vger.kernel.org>; Fri, 18 Nov 2022 21:27:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 29640C433D6;
        Fri, 18 Nov 2022 21:27:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1668806862;
        bh=RKeUbLAWkAqKAQpRa/aMhHUQToW5rk/wNnEtKf8AAVs=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=AHI++KLcg8f1oKeTyVJj9GgaijJqkIhGCizaWFzcfqfKY2Na6sQIY8Rv/9j6Dlnp2
         PCy1lMm98PDg76enX/+l1cj3fSgb4vf1ZSWgQaiGwTESXq2ViX5/xhK05feuKPEMcb
         0zs/sY66agmdTG8jixrCs7AyIZFi7lqGyH6tqnso=
Date:   Fri, 18 Nov 2022 13:27:41 -0800
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Chen Wandun <chenwandun@huawei.com>
Cc:     <hugh@veritas.com>, <linux-mm@kvack.org>,
        <linux-kernel@vger.kernel.org>, <wangkefeng.wang@huawei.com>,
        <sunnanyong@huawei.com>, <xialonglong1@huawei.com>,
        Huang Ying <ying.huang@intel.com>
Subject: Re: [RFC PATCH] swapfile: fix soft lockup in scan_swap_map_slots
Message-Id: <20221118132741.aaf6f9081b5a1018cc9a5402@linux-foundation.org>
In-Reply-To: <20221118133850.3360369-1-chenwandun@huawei.com>
References: <20221118133850.3360369-1-chenwandun@huawei.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 18 Nov 2022 21:38:50 +0800 Chen Wandun <chenwandun@huawei.com> wrote:

> A soft lockup occur in scan free swap slot by constructing
> huge memory pressure.
> The test scenario is: 64 CPU cores, 64GB memory, and 28
> zram devices, the disksize of each zram device is 50MB.
> 
> LATENCY_LIMIT is used to prevent soft lockup in function
> scan_swap_map_slots, but the real loop number would more
> than LATENCY_LIMIT because of "goto checks and goto scan"
> repeatly without decrease of latency limit.
> 
> In order to fix it, move decrease latency_ration code in advance.
> 
> There is also a suspicious place that will cause soft lockup in
> function get_swap_pages, in this function, the "goto start_over"
> may result in continuous scanning of swap partition, if there is
> no cond_sched in scan_swap_map_slots, it would cause soft lockup
> (I am not sure about this).
> 
> ...
>

Looks sensible.

> --- a/mm/swapfile.c
> +++ b/mm/swapfile.c
> @@ -972,23 +972,23 @@ static int scan_swap_map_slots(struct swap_info_struct *si,
>  scan:
>  	spin_unlock(&si->lock);
>  	while (++offset <= READ_ONCE(si->highest_bit)) {
> -		if (swap_offset_available_and_locked(si, offset))
> -			goto checks;
>  		if (unlikely(--latency_ration < 0)) {
>  			cond_resched();
>  			latency_ration = LATENCY_LIMIT;
>  			scanned_many = true;
>  		}
> +		if (swap_offset_available_and_locked(si, offset))
> +			goto checks;
>  	}
>  	offset = si->lowest_bit;
>  	while (offset < scan_base) {
> -		if (swap_offset_available_and_locked(si, offset))
> -			goto checks;
>  		if (unlikely(--latency_ration < 0)) {
>  			cond_resched();
>  			latency_ration = LATENCY_LIMIT;
>  			scanned_many = true;
>  		}
> +		if (swap_offset_available_and_locked(si, offset))
> +			goto checks;
>  		offset++;
>  	}
>  	spin_lock(&si->lock);

But this does somewhat alter the `scanned_many' logic.  We'll now set
'scanned_many` earlier.  What are the effects of this?

The ed43af10975eef7e changelog outlines tests which could be performed
to ensure we aren't regressing from this.

