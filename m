Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB3EF72FD58
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Jun 2023 13:47:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244272AbjFNLrL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Jun 2023 07:47:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239824AbjFNLrC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Jun 2023 07:47:02 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60918A2
        for <linux-kernel@vger.kernel.org>; Wed, 14 Jun 2023 04:47:01 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id DD21F63F8D
        for <linux-kernel@vger.kernel.org>; Wed, 14 Jun 2023 11:47:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2C5BAC433C0;
        Wed, 14 Jun 2023 11:46:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686743220;
        bh=hUgVO/GCrrBC8yyi34t2DrgRbyXURmTA1orcAkAe0pA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=CphnQVIG1x8bMDw09c1e9AWm29ATdgRMUlx3PSedKkyJy0ap3QEs4UV+c07hXSFeO
         0jPIssvrXAQehQdPfmilN6fdB4VSupZzo/I7vCFkRPHKQbalUvoYU1dRARwQ3JxviA
         JZvOdzFkKBLPHa+UuEo7Qw1vPjozqA2b5c8GvnDuHOe4xkOMe0HFEWnk0cFZyFt0lz
         8yHHvRvUDWLjYYgOnIdw/lqs4PshJeIOJY3HIJeDUIwW1u8Ry5EzhPHIplJTzlbGdk
         g0fIh7WdFMSet/FUInjApJGDJGRJU3rlUNwRL9ceqE/Rq5wAplLeHDEKZGwYTsXEXw
         pGtlvS18y+Nmw==
Date:   Wed, 14 Jun 2023 14:46:27 +0300
From:   Mike Rapoport <rppt@kernel.org>
To:     Peng Zhang <zhangpeng362@huawei.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        akpm@linux-foundation.org, wangkefeng.wang@huawei.com,
        sunnanyong@huawei.com
Subject: Re: [PATCH] memblock: use the helper macro for_each_zone
Message-ID: <20230614114627.GW52412@kernel.org>
References: <20230612125102.1674568-1-zhangpeng362@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230612125102.1674568-1-zhangpeng362@huawei.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 12, 2023 at 08:51:02PM +0800, Peng Zhang wrote:
> From: ZhangPeng <zhangpeng362@huawei.com>
> 
> Let's use the helper macro for_each_zone to iterate over all memory
> zones and reset the node managed pages. After that, we can remove the
> unused function reset_node_managed_pages.

Are you sure it's safe to use for_each_zone() in all users of
reset_all_zones_managed_pages()?
 
> Signed-off-by: ZhangPeng <zhangpeng362@huawei.com>
> ---
>  mm/memblock.c | 14 +++-----------
>  1 file changed, 3 insertions(+), 11 deletions(-)
> 
> diff --git a/mm/memblock.c b/mm/memblock.c
> index da4264528e1e..af552604c3fb 100644
> --- a/mm/memblock.c
> +++ b/mm/memblock.c
> @@ -2122,23 +2122,15 @@ static unsigned long __init free_low_memory_core_early(void)
>  
>  static int reset_managed_pages_done __initdata;
>  
> -static void __init reset_node_managed_pages(pg_data_t *pgdat)
> -{
> -	struct zone *z;
> -
> -	for (z = pgdat->node_zones; z < pgdat->node_zones + MAX_NR_ZONES; z++)
> -		atomic_long_set(&z->managed_pages, 0);
> -}
> -
>  void __init reset_all_zones_managed_pages(void)
>  {
> -	struct pglist_data *pgdat;
> +	struct zone *z;
>  
>  	if (reset_managed_pages_done)
>  		return;
>  
> -	for_each_online_pgdat(pgdat)
> -		reset_node_managed_pages(pgdat);
> +	for_each_zone(z)
> +		atomic_long_set(&z->managed_pages, 0);
>  
>  	reset_managed_pages_done = 1;
>  }
> -- 
> 2.25.1
> 

-- 
Sincerely yours,
Mike.
