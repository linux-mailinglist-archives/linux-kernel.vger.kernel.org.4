Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E54E71F9E3
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Jun 2023 08:10:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233732AbjFBGKH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Jun 2023 02:10:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233709AbjFBGKF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Jun 2023 02:10:05 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B59FE19A
        for <linux-kernel@vger.kernel.org>; Thu,  1 Jun 2023 23:10:04 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 35AB3636D6
        for <linux-kernel@vger.kernel.org>; Fri,  2 Jun 2023 06:10:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1EC3DC433D2;
        Fri,  2 Jun 2023 06:10:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685686203;
        bh=VEgyKFf172jYb5rXa1Yhw5aH3Ng0UE/Y4wpRvGCLU54=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=sSNccwcUEAiE0z5n1fVv6tegZ2SYCD7RW6bf8jDQpxUDGIt2f3aKA6KFU+Vt11Q74
         6nEu2+0ty813Wtv+o2O7UU6gNwtQqlfgDSrDfMP3bFFjoz0mXmRSQQMS5bPKQGdmQ6
         9Gyiqm2bANIrzjDoDNIGDI9ZqjvB9+ds6h83GWbi1dHIqlcLXrN5mt+Qtaobg0lqrr
         rUE7ci8/CAd3UQ/DBPXWapSzH22AKYd4dY334rjBE/MUVU9lRn7juDIi4VydouLF8a
         e/c5lWpf1AZL16Tk7fBPvhpXSeeIweE1nYrBDX8W9XHIN+GwTqfwGH6n5awm93rWZo
         sZuvOOGYUAeeA==
Date:   Thu, 1 Jun 2023 23:10:01 -0700
From:   Chris Li <chrisl@kernel.org>
To:     Huang Ying <ying.huang@intel.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, David Hildenbrand <david@redhat.com>,
        Yosry Ahmed <yosryahmed@google.com>,
        Hugh Dickins <hughd@google.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Matthew Wilcox <willy@infradead.org>,
        Michal Hocko <mhocko@suse.com>,
        Minchan Kim <minchan@kernel.org>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        Yang Shi <shy828301@gmail.com>, Yu Zhao <yuzhao@google.com>
Subject: Re: [PATCH -V3 5/5] swap: comments get_swap_device() with usage rule
Message-ID: <ZHmHuW42JV95Uohj@google.com>
References: <20230529061355.125791-1-ying.huang@intel.com>
 <20230529061355.125791-6-ying.huang@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230529061355.125791-6-ying.huang@intel.com>
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 29, 2023 at 02:13:55PM +0800, Huang Ying wrote:
> The general rule to use a swap entry is as follows.
> 
> When we get a swap entry, if there aren't some other ways to prevent
> swapoff, such as the folio in swap cache is locked, page table lock is
> held, etc., the swap entry may become invalid because of swapoff.
> Then, we need to enclose all swap related functions with
> get_swap_device() and put_swap_device(), unless the swap functions
> call get/put_swap_device() by themselves.
> 
> Add the rule as comments of get_swap_device().
> 
> Signed-off-by: "Huang, Ying" <ying.huang@intel.com>
> Reviewed-by: David Hildenbrand <david@redhat.com>
> Reviewed-by: Yosry Ahmed <yosryahmed@google.com>
> Cc: Hugh Dickins <hughd@google.com>
> Cc: Johannes Weiner <hannes@cmpxchg.org>
> Cc: Matthew Wilcox <willy@infradead.org>
> Cc: Michal Hocko <mhocko@suse.com>
> Cc: Minchan Kim <minchan@kernel.org>
> Cc: Tim Chen <tim.c.chen@linux.intel.com>
> Cc: Yang Shi <shy828301@gmail.com>
> Cc: Yu Zhao <yuzhao@google.com>
> Cc: Chris Li <chrisl@kernel.org>
> ---
>  mm/swapfile.c | 12 +++++++++---
>  1 file changed, 9 insertions(+), 3 deletions(-)
> 
> diff --git a/mm/swapfile.c b/mm/swapfile.c
> index 4dbaea64635d..3d0e932497f0 100644
> --- a/mm/swapfile.c
> +++ b/mm/swapfile.c
> @@ -1219,6 +1219,13 @@ static unsigned char __swap_entry_free_locked(struct swap_info_struct *p,
>  }
>  
>  /*
> + * When we get a swap entry, if there aren't some other ways to
> + * prevent swapoff, such as the folio in swap cache is locked, page
> + * table lock is held, etc., the swap entry may become invalid because
> + * of swapoff.  Then, we need to enclose all swap related functions
> + * with get_swap_device() and put_swap_device(), unless the swap
> + * functions call get/put_swap_device() by themselves.
> + *
>   * Check whether swap entry is valid in the swap device.  If so,
>   * return pointer to swap_info_struct, and keep the swap entry valid
>   * via preventing the swap device from being swapoff, until
> @@ -1227,9 +1234,8 @@ static unsigned char __swap_entry_free_locked(struct swap_info_struct *p,
>   * Notice that swapoff or swapoff+swapon can still happen before the
>   * percpu_ref_tryget_live() in get_swap_device() or after the
>   * percpu_ref_put() in put_swap_device() if there isn't any other way
> - * to prevent swapoff, such as page lock, page table lock, etc.  The
> - * caller must be prepared for that.  For example, the following
> - * situation is possible.
> + * to prevent swapoff.  The caller must be prepared for that.  For
> + * example, the following situation is possible.
>   *
>   *   CPU1				CPU2
>   *   do_swap_page()
> -- 
> 2.39.2
>

Reviewed-by: Chris Li (Google) <chrisl@kernel.org>

Chris
 
