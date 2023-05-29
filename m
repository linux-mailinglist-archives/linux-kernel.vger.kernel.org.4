Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE7CD7146D0
	for <lists+linux-kernel@lfdr.de>; Mon, 29 May 2023 11:05:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231795AbjE2JFQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 May 2023 05:05:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229628AbjE2JFN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 May 2023 05:05:13 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F77591
        for <linux-kernel@vger.kernel.org>; Mon, 29 May 2023 02:05:12 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9B04B6135F
        for <linux-kernel@vger.kernel.org>; Mon, 29 May 2023 09:05:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 07B15C4339B;
        Mon, 29 May 2023 09:05:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685351111;
        bh=a0JuTRdYRCCfiZG2Iw5Mnx/pP+lqpKmJlhBMUAjpNL8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=HK7x766l7V56uon1rxaUzwgAf6cZoaiFKntT9oIUJxtajR+3PG//Zw6INfHkCD7YL
         Q08U2FLyBg3+kfe2Tj4Uzdb5ybjOQkCRLSyYPdFwuYEjjfPu02YmWt5JjwlaqRnmXL
         AQ5AknK4p5P3KRaCvVHVc5VKPcSB0QDFqempdzu6KkyNuVEDH24/CCs5oWZYQuDx86
         0Yqh1Qvt/hXekeLFe9PhSfU2EQLwzaAcAkUIDdGg3oR4S3/5H1r5X+GshQGCQ8xv9q
         E03Qku3fBBuqL1ZGrW56JvwgsZcqsqUDiQMZlf8c6ET5O6YRnqxjtwFEz1brANpftN
         qGWoGIX3/ROEg==
Date:   Mon, 29 May 2023 12:04:46 +0300
From:   Mike Rapoport <rppt@kernel.org>
To:     Haifeng Xu <haifeng.xu@shopee.com>
Cc:     akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Michal Hocko <mhocko@kernel.org>
Subject: Re: [PATCH] mm/mm_init.c: remove free_area_init_memoryless_node()
Message-ID: <20230529090446.GK4967@kernel.org>
References: <20230528045720.4835-1-haifeng.xu@shopee.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230528045720.4835-1-haifeng.xu@shopee.com>
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

(added Michal)

On Sun, May 28, 2023 at 04:57:20AM +0000, Haifeng Xu wrote:
> free_area_init_memoryless_node() is just a wrapper of
> free_area_init_node(), remove it to clean up.
> 
> Signed-off-by: Haifeng Xu <haifeng.xu@shopee.com>
> ---
>  mm/mm_init.c | 7 +------
>  1 file changed, 1 insertion(+), 6 deletions(-)
> 
> diff --git a/mm/mm_init.c b/mm/mm_init.c
> index 2d91bb52c619..93821824271a 100644
> --- a/mm/mm_init.c
> +++ b/mm/mm_init.c
> @@ -1752,11 +1752,6 @@ void __init setup_nr_node_ids(void)
>  }
>  #endif
>  
> -static void __init free_area_init_memoryless_node(int nid)
> -{
> -	free_area_init_node(nid);
> -}
> -
>  /*
>   * Some architectures, e.g. ARC may have ZONE_HIGHMEM below ZONE_NORMAL. For
>   * such cases we allow max_zone_pfn sorted in the descending order
> @@ -1867,7 +1862,7 @@ void __init free_area_init(unsigned long *max_zone_pfn)
>  				panic("Cannot allocate %zuB for node %d.\n",
>  				       sizeof(*pgdat), nid);
>  			arch_refresh_nodedata(nid, pgdat);
> -			free_area_init_memoryless_node(nid);
> +			free_area_init_node(nid);

Using a dedicated free_area_init_memoryless_node() wrapper here emphasizes
that the node has no memory, but I don't have a strong feeling about
keeping it.

>  
>  			/*
>  			 * We do not want to confuse userspace by sysfs
> -- 
> 2.25.1
> 

-- 
Sincerely yours,
Mike.
