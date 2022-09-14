Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 920725B85A2
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Sep 2022 11:53:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231694AbiINJxO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Sep 2022 05:53:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231648AbiINJwZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Sep 2022 05:52:25 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4E3165669
        for <linux-kernel@vger.kernel.org>; Wed, 14 Sep 2022 02:52:11 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id C281DB818FA
        for <linux-kernel@vger.kernel.org>; Wed, 14 Sep 2022 09:52:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B5DA3C433D7;
        Wed, 14 Sep 2022 09:52:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1663149128;
        bh=ET7xbCmKy/wqjVqLOdaW4rsp6pDFPXzpeLtwj+QaumI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=esymQ/kJqQsK2cqJ9IZ7oY0Clu6YyLsT78uqOUlEhaCBDCgX6jFu9XKPrNZbryLiu
         6gH+q1Ov9/ZtXtPZHp5CXJ8+gqf9OR2vxM2tGKcXBIv5MrUVfvPcPEd7EEeOtAzzhh
         VGkQH+tmS7nOCtRVn1ZIva/jZ1xxnVoHpaCsIzjTiTgwO7iMeUzZHFMYYABRplL7kY
         ltnM6yGDX236aK+iETeMDt4t6S949SL/zDISOkTUvkR4hUs+v332jQK1b3fGt9mKGr
         Tf5l+kJt69JuC/mWYDTZQIdPnopU0XjHgk39Chm+IRi5H1Bev35sWWFW2JRxAplCal
         fCBGBjgBXBQnQ==
From:   SeongJae Park <sj@kernel.org>
To:     Yajun Deng <yajun.deng@linux.dev>
Cc:     sj@kernel.org, akpm@linux-foundation.org, sieberf@amazon.com,
        shakeelb@google.com, foersleo@amazon.de, damon@lists.linux.dev,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm/damon: fix missing damon_del_region()
Date:   Wed, 14 Sep 2022 09:52:06 +0000
Message-Id: <20220914095206.70459-1-sj@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220914093636.1184590-1-yajun.deng@linux.dev>
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

Hi Yajun,

On Wed, 14 Sep 2022 17:36:36 +0800 Yajun Deng <yajun.deng@linux.dev> wrote:

> It should be called damon_del_region() before free each region, so use
> damon_destroy_region() instead of damon_free_region().

What 'damon_del_region()' does is deleting the region from target's regions
linked list so that nobody references it later after its freed.  However, as
each region is linked to one target, and as we will free the target here, the
list will also be freed.  Therefore, we don't need to worry about future
references to the region.

Anything I'm missing?


Thanks,
SJ

> 
> Fixes: f23b8eee1871 (mm/damon/core: implement region-based sampling)
> Signed-off-by: Yajun Deng <yajun.deng@linux.dev>
> ---
>  mm/damon/core.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/mm/damon/core.c b/mm/damon/core.c
> index 0b1eb945c68a..e62e7ebf4b12 100644
> --- a/mm/damon/core.c
> +++ b/mm/damon/core.c
> @@ -361,7 +361,7 @@ void damon_free_target(struct damon_target *t)
>  	struct damon_region *r, *next;
>  
>  	damon_for_each_region_safe(r, next, t)
> -		damon_free_region(r);
> +		damon_destroy_region(r, t);
>  	kfree(t);
>  }
>  
> -- 
> 2.25.1
