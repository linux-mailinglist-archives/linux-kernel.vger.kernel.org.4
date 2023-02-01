Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 442946865CE
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Feb 2023 13:19:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231786AbjBAMTW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Feb 2023 07:19:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231131AbjBAMTU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Feb 2023 07:19:20 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33E8C1423A
        for <linux-kernel@vger.kernel.org>; Wed,  1 Feb 2023 04:19:20 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id D7E17B8215B
        for <linux-kernel@vger.kernel.org>; Wed,  1 Feb 2023 12:19:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 15D82C433EF;
        Wed,  1 Feb 2023 12:19:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1675253957;
        bh=772MiW9mQPh+KTvZmr96PFBr8QTl3kP4byXYDSUvGbk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=mSTttzlaBqtcD72tYR1zi5yN8MbEl8GbslcBUchxh370gLPfnhDY4QsVUUTw0rWWH
         Ceq2pyy5tjuQpFJO5SFSqCc75321382k9G+SWiUjF2VHfMRlkg2wqYxh2F7TT7mOUC
         tN7TAkjuoFyoUsgW1hsLiEO1EomUe5tL4VuByvMris9QfBXm8ZHgBjc+Q99MIXx3LB
         ckaJ8O/xBJZ76Wfi/XlUGbqpDeMeP4X70v/UVXrEOfWSlCBpN/BFnITZx8G3akX1av
         YFUgzaPgARNlbCNLTRu25otXHaKWUVPzuRHo8sHX2SM9kZVrV59D5wCo9EjgMjlFIb
         pA6V3qvEAd90g==
Date:   Wed, 1 Feb 2023 14:19:03 +0200
From:   Mike Rapoport <rppt@kernel.org>
To:     Hyunmin Lee <hn.min.lee@gmail.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Uladzislau Rezki <urezki@gmail.com>,
        Christoph Hellwig <hch@infradead.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Gwan-gyeong Mun <gwan-gyeong.mun@intel.com>,
        Jeungwoo Yoo <casionwoo@gmail.com>,
        Sangyun Kim <sangyun.kim@snu.ac.kr>,
        Christophe Leroy <christophe.leroy@csgroup.eu>
Subject: Re: [PATCH v4] mm/vmalloc: replace BUG_ON to a simple if statement
Message-ID: <Y9pYt95oJqL7Eci5@kernel.org>
References: <20230201115142.GA7772@min-iamroot>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230201115142.GA7772@min-iamroot>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 01, 2023 at 08:51:42PM +0900, Hyunmin Lee wrote:
> As per the coding standards, in the event of an abnormal condition that
> should not occur under normal circumstances, the kernel should attempt
> recovery and proceed with execution, rather than halting the machine.
> 
> Specifically, in the alloc_vmap_area() function, use a simple if()
> instead of using BUG_ON() halting the machine.
> 
> Co-Developed-by: Gwan-gyeong Mun <gwan-gyeong.mun@intel.com>
> Co-Developed-by: Jeungwoo Yoo <casionwoo@gmail.com>
> Co-Developed-by: Sangyun Kim <sangyun.kim@snu.ac.kr>
> Signed-off-by: Hyunmin Lee <hn.min.lee@gmail.com>
> Signed-off-by: Gwan-gyeong Mun <gwan-gyeong.mun@intel.com>
> Signed-off-by: Jeungwoo Yoo <casionwoo@gmail.com>
> Signed-off-by: Sangyun Kim <sangyun.kim@snu.ac.kr>
> Cc: Hyeonggon Yoo <42.hyeyoo@gmail.com>

Reviewed-by: Mike Rapoport (IBM) <rppt@kernel.org>

> ---
> v1->v2 : Add commit description
> v2->v3 : Change WARN_ON() to if()
> v3->v4 : Use only one if() for three conditions
> ---
>  mm/vmalloc.c | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)
> 
> diff --git a/mm/vmalloc.c b/mm/vmalloc.c
> index 74afa2208558..3b7e8856be35 100644
> --- a/mm/vmalloc.c
> +++ b/mm/vmalloc.c
> @@ -1587,9 +1587,8 @@ static struct vmap_area *alloc_vmap_area(unsigned long size,
>  	int purged = 0;
>  	int ret;
>  
> -	BUG_ON(!size);
> -	BUG_ON(offset_in_page(size));
> -	BUG_ON(!is_power_of_2(align));
> +	if (unlikely(!size || offset_in_page(size) || !is_power_of_2(align)))
> +		return ERR_PTR(-EINVAL);
>  
>  	if (unlikely(!vmap_initialized))
>  		return ERR_PTR(-EBUSY);
> -- 
> 2.25.1
> 

-- 
Sincerely yours,
Mike.
