Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B5CF45B7932
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Sep 2022 20:11:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232326AbiIMSLJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Sep 2022 14:11:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232286AbiIMSKs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Sep 2022 14:10:48 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E1B33AC
        for <linux-kernel@vger.kernel.org>; Tue, 13 Sep 2022 10:16:49 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id CF32561525
        for <linux-kernel@vger.kernel.org>; Tue, 13 Sep 2022 17:16:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A57CBC433C1;
        Tue, 13 Sep 2022 17:16:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1663089408;
        bh=Uo0FmKOIOqO2xt98KZDO75WMovCewe/BPwr12WzqD+Y=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=mAlGN2bbSywVp6ZYPZdCV+CdkaorThXnHVupWVu4TBqYco2iF+6ffjoU204Ci59xD
         QYVctAzw25geHyf0q6pAXfz06rbQk2VZUv9nk6rUhCdG72swQ+NTHuQedhHAFwXnqU
         IF/lpEivXclmgCb/wuCpAzd6fi4BtKrZsIsQR6wiXTYvkGHlodvO9LRQylSKEgfssc
         XUdPM18I8xWqEMkAWVCTaSyxWDYNTcQmonggXcRUrOCZiaqGLdvKkpQeH+LJs0X2vo
         CtPlfprzSMSNhql2Z5OvJh2J6PtKhdNHeSFgLRmhoe6K/tL5axr4CwUmdSVVai4dN3
         EJ89jtbcc9gJA==
From:   SeongJae Park <sj@kernel.org>
To:     Dawei Li <set_pte_at@outlook.com>
Cc:     sj@kernel.org, akpm@linux-foundation.org, damon@lists.linux.dev,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm/damon: Creating kmem cache for damon regions by KMEM_CACHE()
Date:   Tue, 13 Sep 2022 17:16:46 +0000
Message-Id: <20220913171646.47472-1-sj@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <TYCP286MB23233778395A18052E578387CA479@TYCP286MB2323.JPNP286.PROD.OUTLOOK.COM>
References: 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 14 Sep 2022 00:21:58 +0800 Dawei Li <set_pte_at@outlook.com> wrote:

> Damon regions are dynamic objects which can be created and destroyed
> frequently, a dedicated slab cache is created by KMEM_CACHE(), as
> suggested by akpm.
> 
> Signed-off-by: Dawei Li <set_pte_at@outlook.com>
> ---
>  mm/damon/core.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/mm/damon/core.c b/mm/damon/core.c
> index 0b1eb945c68a..20163c3c9aa7 100644
> --- a/mm/damon/core.c
> +++ b/mm/damon/core.c
> @@ -1283,8 +1283,7 @@ bool damon_find_biggest_system_ram(unsigned long *start, unsigned long *end)
>  
>  static int __init damon_init(void)
>  {
> -	damon_region_cache = kmem_cache_create("damon_region_cache", sizeof(struct damon_region),
> -		0, 0, NULL);
> +	damon_region_cache = KMEM_CACHE(damon_region, 0);

I was about to say about the 80 columns limit, and this fixes it as well.
Thank you, Andrew and Dawei!

>  	if (unlikely(!damon_region_cache)) {
>  		pr_err("creating damon_region_cache fails\n");
>  		return -ENOMEM;
> -- 
> 2.25.1
> 

For this fixup and the initial patch[1],
Reviewed-by: SeongJae Park <sj@kernel.org>

[1] https://lore.kernel.org/damon/TYCP286MB2323DA1894FA55BB9CF90978CA449@TYCP286MB2323.JPNP286.PROD.OUTLOOK.COM/


Thanks,
SJ
