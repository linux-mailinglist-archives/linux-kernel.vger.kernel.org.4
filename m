Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CAF696A9F57
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Mar 2023 19:43:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231771AbjCCSnR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Mar 2023 13:43:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231701AbjCCSnN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Mar 2023 13:43:13 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD0C259E62
        for <linux-kernel@vger.kernel.org>; Fri,  3 Mar 2023 10:42:43 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A214D618C8
        for <linux-kernel@vger.kernel.org>; Fri,  3 Mar 2023 18:41:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7BE2EC433EF;
        Fri,  3 Mar 2023 18:41:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1677868907;
        bh=YTrv0VxcIMi4UDOxc6sliKnvGTbGdzcIKG2y0EaQ0W8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Wu5csu7JO0yWOcDEu9wXeHhz/I46yK3UjEg93H94QSLd5zc91edXbqOgHsxmNqqO7
         Y82fkgje0ZfO4nijhPhnmFjbDBHjK/p149bgYrpSTi3ccU9sx/GkWUMvvV+l2gvjRR
         ULuNcamxXSGCwoOybmhb7o/E7PVLDFwCS4iSrfTbXFLsr9cipRbmu36RHxGvLIvVsF
         iht5PQR2MPvI7cG+rZG3Gi2vqv+DMe0FsF1bHwJOu2mvtbTyu4SMklBmhGN5XYXovH
         YiNxXUXqnJseABO/3E5HwmZL5/uiej4KrSw7yhW1IDShUBIm8w3u+zRESlno3m/Lx7
         HJ2pbdXprz8bQ==
From:   SeongJae Park <sj@kernel.org>
To:     Kefeng Wang <wangkefeng.wang@huawei.com>
Cc:     SeongJae Park <sj@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, damon@lists.linux.dev
Subject: Re: [PATCH v2 1/3] mm/damon/paddr: minor refactor of damon_pa_pageout()
Date:   Fri,  3 Mar 2023 18:41:45 +0000
Message-Id: <20230303184145.113640-1-sj@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230303084343.171958-2-wangkefeng.wang@huawei.com>
References: 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 3 Mar 2023 16:43:41 +0800 Kefeng Wang <wangkefeng.wang@huawei.com> wrote:

> Omit three lines by unified folio_put(), and make code more clear.
> 
> Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>

Reviewed-by: SeongJae Park <sj@kernel.org>


Thanks,
SJ

> ---
>  mm/damon/paddr.c | 13 +++++--------
>  1 file changed, 5 insertions(+), 8 deletions(-)
> 
> diff --git a/mm/damon/paddr.c b/mm/damon/paddr.c
> index 6c655d9b5639..3fda00a0f786 100644
> --- a/mm/damon/paddr.c
> +++ b/mm/damon/paddr.c
> @@ -239,21 +239,18 @@ static unsigned long damon_pa_pageout(struct damon_region *r, struct damos *s)
>  		if (!folio)
>  			continue;
>  
> -		if (damos_pa_filter_out(s, folio)) {
> -			folio_put(folio);
> -			continue;
> -		}
> +		if (damos_pa_filter_out(s, folio))
> +			goto put_folio;
>  
>  		folio_clear_referenced(folio);
>  		folio_test_clear_young(folio);
> -		if (!folio_isolate_lru(folio)) {
> -			folio_put(folio);
> -			continue;
> -		}
> +		if (!folio_isolate_lru(folio))
> +			goto put_folio;
>  		if (folio_test_unevictable(folio))
>  			folio_putback_lru(folio);
>  		else
>  			list_add(&folio->lru, &folio_list);
> +put_folio:
>  		folio_put(folio);
>  	}
>  	applied = reclaim_pages(&folio_list);
> -- 
> 2.35.3
> 
> 
