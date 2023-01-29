Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 17A0A68016B
	for <lists+linux-kernel@lfdr.de>; Sun, 29 Jan 2023 22:03:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234784AbjA2VDY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 29 Jan 2023 16:03:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234378AbjA2VDX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Jan 2023 16:03:23 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C93717CE2
        for <linux-kernel@vger.kernel.org>; Sun, 29 Jan 2023 13:03:22 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C974C60E05
        for <linux-kernel@vger.kernel.org>; Sun, 29 Jan 2023 21:03:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EDB91C433EF;
        Sun, 29 Jan 2023 21:03:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1675026201;
        bh=FgIJHyHT1wke5O7zZ5KlkHLLwBp9RrwSoOUMgqvFsIc=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=xH+LEYEB6s3JjqX0GRxgde8UOr6Gg5LNSqjSuu3TvESEM6TxEq5fEpZCcUQ3PVkE/
         NUCBBmqZFVVTcXI/6qFGn7i5K5FebKkmoO86zZKL6S4LBFvyDY97cgqy9WKQy5IQmQ
         8dgn/se2dlsln0Naac2nt5doA7m9161Gu+yL5lUw=
Date:   Sun, 29 Jan 2023 13:03:20 -0800
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Longlong Xia <xialonglong1@huawei.com>
Cc:     <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
        <ying.huang@intel.com>, <chenwandun@huawei.com>,
        <wangkefeng.wang@huawei.com>, <sunnanyong@huawei.com>
Subject: Re: [PATCH] mm/swapfile: add cond_resched() in get_swap_pages()
Message-Id: <20230129130320.7e2e4445ecc4b172c61c7b9c@linux-foundation.org>
In-Reply-To: <20230128094757.1060525-1-xialonglong1@huawei.com>
References: <20230128094757.1060525-1-xialonglong1@huawei.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 28 Jan 2023 09:47:57 +0000 Longlong Xia <xialonglong1@huawei.com> wrote:

> The softlockup still occurs in get_swap_pages() under memory pressure.
> 64 CPU cores, 64GB memory, and 28 zram devices, the disksize of each
> zram device is 50MB with same priority as si. Use the stress-ng tool
> to increase memory pressure, causing the system to oom frequently.
> 
> The plist_for_each_entry_safe() loops in get_swap_pages() could reach
> tens of thousands of times to find available space (extreme case:
> cond_resched() is not called in scan_swap_map_slots()). Let's add
> cond_resched() into get_swap_pages() when failed to find available
> space to avoid softlockup.
> 
> ...
>
> --- a/mm/swapfile.c
> +++ b/mm/swapfile.c
> @@ -1100,6 +1100,7 @@ int get_swap_pages(int n_goal, swp_entry_t swp_entries[], int entry_size)
>  			goto check_out;
>  		pr_debug("scan_swap_map of si %d failed to find offset\n",
>  			si->type);
> +		cond_resched();
>  
>  		spin_lock(&swap_avail_lock);
>  nextsi:

This must be pretty rare?  My googling for "scan_swap_map of si %d
failed to find offset" turns up zero reports, but I guess few people
enable pr_debug.

I wonder if we should remove that pr_debug().  I mean, it's known that
this happens, what value does the printk add?

I'm thinking this fix should be backported into -stable kernels.

