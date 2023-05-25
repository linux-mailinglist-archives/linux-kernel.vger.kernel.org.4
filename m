Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6EADF710744
	for <lists+linux-kernel@lfdr.de>; Thu, 25 May 2023 10:25:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239531AbjEYIZN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 May 2023 04:25:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233942AbjEYIZH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 May 2023 04:25:07 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66FAB18C
        for <linux-kernel@vger.kernel.org>; Thu, 25 May 2023 01:25:05 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E14D860FAA
        for <linux-kernel@vger.kernel.org>; Thu, 25 May 2023 08:25:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C7728C433D2;
        Thu, 25 May 2023 08:25:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685003104;
        bh=grNGwJfKWoBTpHT3Wmi+ZF/bEInd8peYBr4JARBqluI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=V3o5NCJv7n+774JknAT+F+0rMRvBC6KmsOrVG4f08XgskuY4sSSiQi7M7cNRfTxXQ
         5I6/akS+M3M7SP1DCY+34zoMT/xVgzoLV0+kGckVsZdDB9/+BUVtWkHMMN0rKTQ7mS
         W27f/A5CDV7sg5I0P7RDaL9UIWsHdn+DVwm+93nnd6MFwG/H3Q0R9Vx03TtgOjsacr
         LNA2Aad2GWcYq8TFWud+C7F8jdV9L6eVAVxbQgtapC/Fpf4ly/38ygoU+WE5AedTmX
         9RCL5yidlze9IyNjv1rR/f61EpLLyQqz4stJmLjbOnspBIyJE+0EJVybRABtI37GaW
         +y5IXHjxX2vQQ==
Date:   Thu, 25 May 2023 11:24:44 +0300
From:   Mike Rapoport <rppt@kernel.org>
To:     Haifeng Xu <haifeng.xu@shopee.com>
Cc:     akpm@linux-foundation.org, mhocko@suse.com, david@redhat.com,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] mm/mm_init.c: remove comments in
 zone_spanned_pages_in_node() and zone_absent_pages_in_node()
Message-ID: <20230525082444.GT4967@kernel.org>
References: <20230525040150.1588-1-haifeng.xu@shopee.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230525040150.1588-1-haifeng.xu@shopee.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 25, 2023 at 04:01:48AM +0000, Haifeng Xu wrote:
> Since commit 03e85f9d5f1f ("mm/page_alloc: Introduce free_area_init_core_hotplug"),
> free_area_init_node() doesn't get called in hotplug path anymore, so
> remove the comments related to it.
> 
> Signed-off-by: Haifeng Xu <haifeng.xu@shopee.com>
> ---
>  mm/mm_init.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/mm/mm_init.c b/mm/mm_init.c
> index 7f7f9c677854..cf55bba04b23 100644
> --- a/mm/mm_init.c
> +++ b/mm/mm_init.c
> @@ -1174,7 +1174,6 @@ static unsigned long __init zone_absent_pages_in_node(int nid,
>  	unsigned long zone_start_pfn, zone_end_pfn;
>  	unsigned long nr_absent;
>  
> -	/* When hotadd a new node from cpu_up(), the node should be empty */
>  	if (!node_start_pfn && !node_end_pfn)
>  		return 0;

I think it's better to call calculate_node_totalpages only if node actually has 
memory and for node with no memory we just need to make sure all the node
and zone page counts are indeed set to 0.

Then the condition here and in zone_spanned_pages_in_node() can be removed
along with the comment and patch 2 won't be required at all.
  
> @@ -1227,7 +1226,7 @@ static unsigned long __init zone_spanned_pages_in_node(int nid,
>  {
>  	unsigned long zone_low = arch_zone_lowest_possible_pfn[zone_type];
>  	unsigned long zone_high = arch_zone_highest_possible_pfn[zone_type];
> -	/* When hotadd a new node from cpu_up(), the node should be empty */
> +
>  	if (!node_start_pfn && !node_end_pfn)
>  		return 0;
>  
> -- 
> 2.25.1
> 
> 

-- 
Sincerely yours,
Mike.
