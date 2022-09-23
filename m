Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E1ED15E79E1
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Sep 2022 13:44:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231346AbiIWLor (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Sep 2022 07:44:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231370AbiIWLom (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Sep 2022 07:44:42 -0400
Received: from conssluserg-04.nifty.com (conssluserg-04.nifty.com [210.131.2.83])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 962F3165B2;
        Fri, 23 Sep 2022 04:44:37 -0700 (PDT)
Received: from mail-oa1-f43.google.com (mail-oa1-f43.google.com [209.85.160.43]) (authenticated)
        by conssluserg-04.nifty.com with ESMTP id 28NBiDY1018235;
        Fri, 23 Sep 2022 20:44:14 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-04.nifty.com 28NBiDY1018235
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1663933454;
        bh=LqsmeRM2OaGP4WC5nfd0EXtO9uwHZc3jGKePrhs1o2U=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=bQ/OUz70ODl8+3GdibrAQupV0/eiG0MELP9t9JgeM7u4R/kyhpVLnH/rUaUI3KlAR
         RZR4VHNbHchabS81fFVmel/2/zChVwRTYnR0FuCsMEA6dlVhmXhStFkB17PNF68zYc
         EAVrbx+hjSrX7RLQjwdvZMAII9ie2Q/J4bNd98fe8uyA8dhKeAvReZ+FbC3OAovdOL
         zf3ZUMWrAxN+zKTx1KnjZflodDG5fg1M6OxYXYhJlO+ZahNToDbJG88P+NOPcgDob8
         JQzK6GAjlZQXvotUlHcn4KGrAiFAsrr7oPr8JKV/IYsrK+F0Osqt7CxXb4BpWzg3k5
         75B9s/2bw4D2Q==
X-Nifty-SrcIP: [209.85.160.43]
Received: by mail-oa1-f43.google.com with SMTP id 586e51a60fabf-12803ac8113so17880094fac.8;
        Fri, 23 Sep 2022 04:44:14 -0700 (PDT)
X-Gm-Message-State: ACrzQf2Rn3RK6YAfOiBEwXhwGCDw38cnfvibxKtkYUop3+tkvqxfE5rU
        f/RWAQNO2ICcVUiquhFHTJT9eH3DVIEcicFVkOs=
X-Google-Smtp-Source: AMsMyM5dRnl+hmgFTprQndWvQnIXDB45oo8sBkbPDoLxqB+bXw9rdEhMmEGET4J+e8bzqS1omN+zQzqNUe8z1MN0HAY=
X-Received: by 2002:a05:6870:3103:b0:12d:5b7b:e6f2 with SMTP id
 v3-20020a056870310300b0012d5b7be6f2mr10104033oaa.194.1663933452907; Fri, 23
 Sep 2022 04:44:12 -0700 (PDT)
MIME-Version: 1.0
References: <20220923113835.21544-1-masahiroy@kernel.org>
In-Reply-To: <20220923113835.21544-1-masahiroy@kernel.org>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Fri, 23 Sep 2022 20:43:36 +0900
X-Gmail-Original-Message-ID: <CAK7LNATwNj9zqH8csL0MCrHr+fqWMYMarn3T38H+yvGeJK3oKA@mail.gmail.com>
Message-ID: <CAK7LNATwNj9zqH8csL0MCrHr+fqWMYMarn3T38H+yvGeJK3oKA@mail.gmail.com>
Subject: Re: [PATCH] lib/sg_pool: change module_init(sg_pool_init) to subsys_initcall
To:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Christoph Hellwig <hch@lst.de>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Robin Murphy <robin.murphy@arm.com>, iommu@lists.linux.dev
Cc:     Guenter Roeck <linux@roeck-us.net>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Ming Lin <ming.l@ssi.samsung.com>,
        Sagi Grimberg <sagi@grimberg.me>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_SOFTFAIL autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 23, 2022 at 8:40 PM Masahiro Yamada <masahiroy@kernel.org> wrote:
>
> sg_alloc_table_chained() is called by several drivers, but if it is
> called before sg_pool_init(), it results in a NULL pointer dereference
> in sg_pool_alloc().
>
> Since commit 9b1d6c895002 ("lib: scatterlist: move SG pool code from
> SCSI driver to lib/sg_pool.c"), we rely on module_init(sg_pool_init)
> is invoked before other module_init calls but this assumption is
> fragile.
>
> I slightly changed the link order while Kbuild refactoring Kbuild,


A nit.

while Kbuild refactoring Kbuild -> while refactoring Kbuild




> then uncovered this issue. I should keep the current link order, but
> depending on a specific call order among module_init is so fragine.


fragine -> fragile.




> We usually define the init order by specifying *_initcall correctly,
> or delay the driver probing by returning -EPROBE_DEFER.
>
> Change module_initcall() to subsys_initcall(), and also delete the
> pointless module_exit() because lib/sg_pool.c is always compiled as
> built-in. (CONFIG_SG_POOL is bool)
>
> Link: https://lore.kernel.org/all/20220921043946.GA1355561@roeck-us.net/
> Link: https://lore.kernel.org/all/8e70837d-d859-dfb2-bf7f-83f8b31467bc@samsung.com/
> Fixes: 9b1d6c895002 ("lib: scatterlist: move SG pool code from SCSI driver to lib/sg_pool.c")
> Reported-by: Guenter Roeck <linux@roeck-us.net>
> Reported-by: Marek Szyprowski <m.szyprowski@samsung.com>
> Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
> ---
>
> I am sending this to DMA subsystem because I did not find
> a corresponding one for lib/sg_pool.c
>
>  lib/sg_pool.c | 16 ++--------------
>  1 file changed, 2 insertions(+), 14 deletions(-)
>
> diff --git a/lib/sg_pool.c b/lib/sg_pool.c
> index a0b1a52cd6f7..9bfe60ca3f37 100644
> --- a/lib/sg_pool.c
> +++ b/lib/sg_pool.c
> @@ -1,5 +1,5 @@
>  // SPDX-License-Identifier: GPL-2.0-only
> -#include <linux/module.h>
> +#include <linux/init.h>
>  #include <linux/scatterlist.h>
>  #include <linux/mempool.h>
>  #include <linux/slab.h>
> @@ -177,16 +177,4 @@ static __init int sg_pool_init(void)
>         return -ENOMEM;
>  }
>
> -static __exit void sg_pool_exit(void)
> -{
> -       int i;
> -
> -       for (i = 0; i < SG_MEMPOOL_NR; i++) {
> -               struct sg_pool *sgp = sg_pools + i;
> -               mempool_destroy(sgp->pool);
> -               kmem_cache_destroy(sgp->slab);
> -       }
> -}
> -
> -module_init(sg_pool_init);
> -module_exit(sg_pool_exit);
> +subsys_initcall(sg_pool_init);
> --
> 2.34.1
>


-- 
Best Regards
Masahiro Yamada
