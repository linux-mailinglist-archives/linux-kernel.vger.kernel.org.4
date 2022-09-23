Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F04655E7AAE
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Sep 2022 14:25:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231636AbiIWMZv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Sep 2022 08:25:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232402AbiIWMYm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Sep 2022 08:24:42 -0400
Received: from mailout2.w1.samsung.com (mailout2.w1.samsung.com [210.118.77.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E670A9E8A8
        for <linux-kernel@vger.kernel.org>; Fri, 23 Sep 2022 05:20:09 -0700 (PDT)
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20220923122004euoutp027e61b4edc5d770a7996652fe6d7bec63~XfJ3kTlHC1939819398euoutp02W
        for <linux-kernel@vger.kernel.org>; Fri, 23 Sep 2022 12:20:04 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20220923122004euoutp027e61b4edc5d770a7996652fe6d7bec63~XfJ3kTlHC1939819398euoutp02W
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1663935604;
        bh=EpDM0Vb6lykgvos+Hn5hp44lw7kuaoVKi+4PEICbisw=;
        h=Date:Subject:To:Cc:From:In-Reply-To:References:From;
        b=lhVHQdJXcuO6eB9YTmtHlD1dx7VBWa5pIymBq/9SHLN+dZqiYcXtqPYriaOsqQDeY
         etKVkMh7vCgDrD6Qk4hM0pACsJlAf/wgmbVZtviob1tZYPfR9wslhRbcal9pKIKEta
         JZVTvRCwXrp5tVFTeep3y4gmfQaIOT9wpSllwqQg=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20220923122004eucas1p138bbdfbc053e74c2a547854d241f4bfd~XfJ25lfxU1978619786eucas1p1A;
        Fri, 23 Sep 2022 12:20:04 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges3new.samsung.com (EUCPMTA) with SMTP id 48.E6.19378.474AD236; Fri, 23
        Sep 2022 13:20:04 +0100 (BST)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20220923122003eucas1p14d35921b7e6faf29f2b8605d0e20364a~XfJ2aHnsV1993019930eucas1p1r;
        Fri, 23 Sep 2022 12:20:03 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20220923122003eusmtrp2a008f3b007d30b6c0bc431dce49aa3b0~XfJ2Y_lQC1853918539eusmtrp2c;
        Fri, 23 Sep 2022 12:20:03 +0000 (GMT)
X-AuditID: cbfec7f5-a4dff70000014bb2-52-632da4745866
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id B1.9D.10862.374AD236; Fri, 23
        Sep 2022 13:20:03 +0100 (BST)
Received: from [106.210.134.192] (unknown [106.210.134.192]) by
        eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20220923122003eusmtip2b9e3f813cfc4040c4af23e26c3b44c74~XfJ1zfjlA0536705367eusmtip2S;
        Fri, 23 Sep 2022 12:20:02 +0000 (GMT)
Message-ID: <17123363-90ce-7047-3369-f260082011bd@samsung.com>
Date:   Fri, 23 Sep 2022 14:20:02 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0)
        Gecko/20100101 Thunderbird/91.13.0
Subject: Re: [PATCH] lib/sg_pool: change module_init(sg_pool_init) to
 subsys_initcall
Content-Language: en-US
To:     Masahiro Yamada <masahiroy@kernel.org>,
        linux-kernel@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Robin Murphy <robin.murphy@arm.com>, iommu@lists.linux.dev
Cc:     Guenter Roeck <linux@roeck-us.net>, linux-kbuild@vger.kernel.org,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Ming Lin <ming.l@ssi.samsung.com>,
        Sagi Grimberg <sagi@grimberg.me>
From:   Marek Szyprowski <m.szyprowski@samsung.com>
In-Reply-To: <20220923113835.21544-1-masahiroy@kernel.org>
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrIKsWRmVeSWpSXmKPExsWy7djP87olS3STDXZ2cVisXH2UyeLXFwuL
        P7t2MFlc3jWHzeLJwjNMFsuP/2OyePjgBqtFe28Hs8XBD09YLda9fs/iwOWxZt4aRo/z9zay
        eGxa1cnm8WLzTEaP3Tcb2Dw+Pr3F4rHzewO7x9uXO1k9Pm+SC+CM4rJJSc3JLEst0rdL4MpY
        P20lU8Ff4YrJc38yNjDuF+hi5OSQEDCR6D12hL2LkYtDSGAFo8TUlu+sEM4XRoltt/6zQTif
        GSWmvF7CDtNyeOppJojEckaJf/OOsIEkhAQ+MkqcWMTVxcjBwStgJzHrXxpImEVAVWLjgQtg
        vbwCghInZz5hAbFFBZIlZh07xghiCwuES3yd84AJxGYWEJe49WQ+2HwRkJNePulnAXGYBQ4w
        SvzcPwFsEpuAoUTX2y6wxZwCVhIz775ih+iWl9j+dg4zSIOEwHROiXMzVzBDnO0ice71Myhb
        WOLV8S1Q78hI/N8JsU5CoJ1RYsHv+1DOBEaJhue3GCGqrCXunPvFBvIbs4CmxPpd+hBhR4ld
        Tw6AhSUE+CRuvBWEOIJPYtK26cwQYV6JjjYhiGo1iVnH18GtPXjhEvMERqVZSAEzCykAZiF5
        ZxbC3gWMLKsYxVNLi3PTU4uN81LL9YoTc4tL89L1kvNzNzECU9npf8e/7mBc8eqj3iFGJg7G
        Q4wSHMxKIryz72gmC/GmJFZWpRblxxeV5qQWH2KU5mBREudlm6GVLCSQnliSmp2aWpBaBJNl
        4uCUamDKDlO+sUHGJelY9eMzi4tFnr9fcf7dL+OXCY+MFPTWZeo7LeNZNvXfLxXOo2bv3zBq
        fi39ddmbRW/GnAkS96UWxwVkXT6oYStwvyH79lE2vruJb1hm/1qken5djUSZWMW12W9kX015
        8//+eaHESmlFq8V18fqrD4StKwho2LtvWcrXYu+ru69t2aG+cpGHdJ/l4eJfE2JqBT5rcm4S
        czh89ijvw52ynYc08l1LppxQ3/Lh1DalAwevR2Yudz2utmv/Z8sdP95kHjj/cMtNuR8h1zba
        flRYaVKo9/P0SS2HyM1Jjht3/9xoW86gV/1oR+Knl2tVNd9+V674FRTI43mTTagk6MG20IMx
        dVty9897+EOJpTgj0VCLuag4EQBOl9M51AMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrCIsWRmVeSWpSXmKPExsVy+t/xe7rFS3STDW6dVbRYufook8WvLxYW
        f3btYLK4vGsOm8WThWeYLJYf/8dk8fDBDVaL9t4OZouDH56wWqx7/Z7Fgctjzbw1jB7n721k
        8di0qpPN48XmmYweu282sHl8fHqLxWPn9wZ2j7cvd7J6fN4kF8AZpWdTlF9akqqQkV9cYqsU
        bWhhpGdoaaFnZGKpZ2hsHmtlZKqkb2eTkpqTWZZapG+XoJexftpKpoK/whWT5/5kbGDcL9DF
        yMkhIWAicXjqaaYuRi4OIYGljBInZ59lhEjISJyc1sAKYQtL/LnWxQZR9J5R4vKNk0AdHBy8
        AnYSs/6lgdSwCKhKbDxwgR3E5hUQlDg58wkLiC0qkCyxpOE+2BxhgXCJr3MeMIHYzALiEree
        zAdbLCKwglHiQfs2RhCHWeAAo8SUk5+YIbb1MkpM3LoZ7CQ2AUOJrrcgZ3BycApYScy8+4od
        YpSZRNfWLkYIW15i+9s5zBMYhWYhuWQWko2zkLTMQtKygJFlFaNIamlxbnpusZFecWJucWle
        ul5yfu4mRmD0bjv2c8sOxpWvPuodYmTiYDzEKMHBrCTCO/uOZrIQb0piZVVqUX58UWlOavEh
        RlNgcExklhJNzgemj7ySeEMzA1NDEzNLA1NLM2MlcV7Pgo5EIYH0xJLU7NTUgtQimD4mDk6p
        BqbZJ9+t+Zss++OZUEaIZXuPmPfqpzYxbx2Sy8+vsOwQFWnP72ie4Gs0i9/fe37dJ3GFd9Is
        G3w3ePHN+3aw6UhXwg2Zz6nhLwvj/NX/zNcs3sJ93t0yeZG+7vMDwh8enwny+qJ2K0+/b0WH
        7wJlGckVq/ZM1NqYVd/DJvVtYTN3S+PXClenPSfj3mm+mFH3+Nlra7nD6hGnzloaMXLfcThk
        dFpEYzHbc960J4dOTp26iNVtRVzomt5+kc6n+a+e3o3c4BHcqHk0sP+Hz6R4H87NHgqNL3/o
        L1hTe8WVIVgtOup7gIvOLkex2RkZ/3+YHZM4Oml2rXquz9yz555byLxXncd8NqU79onWjMOm
        d5VYijMSDbWYi4oTAVJ9+3dnAwAA
X-CMS-MailID: 20220923122003eucas1p14d35921b7e6faf29f2b8605d0e20364a
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20220923113941eucas1p2e5f7b9bc7316114e69ab6348d40d3b6d
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20220923113941eucas1p2e5f7b9bc7316114e69ab6348d40d3b6d
References: <CGME20220923113941eucas1p2e5f7b9bc7316114e69ab6348d40d3b6d@eucas1p2.samsung.com>
        <20220923113835.21544-1-masahiroy@kernel.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 23.09.2022 13:38, Masahiro Yamada wrote:
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
> then uncovered this issue. I should keep the current link order, but
> depending on a specific call order among module_init is so fragine.
>
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

Feel free to add:

Tested-by: Marek Szyprowski <m.szyprowski@samsung.com>

>   lib/sg_pool.c | 16 ++--------------
>   1 file changed, 2 insertions(+), 14 deletions(-)
>
> diff --git a/lib/sg_pool.c b/lib/sg_pool.c
> index a0b1a52cd6f7..9bfe60ca3f37 100644
> --- a/lib/sg_pool.c
> +++ b/lib/sg_pool.c
> @@ -1,5 +1,5 @@
>   // SPDX-License-Identifier: GPL-2.0-only
> -#include <linux/module.h>
> +#include <linux/init.h>
>   #include <linux/scatterlist.h>
>   #include <linux/mempool.h>
>   #include <linux/slab.h>
> @@ -177,16 +177,4 @@ static __init int sg_pool_init(void)
>   	return -ENOMEM;
>   }
>   
> -static __exit void sg_pool_exit(void)
> -{
> -	int i;
> -
> -	for (i = 0; i < SG_MEMPOOL_NR; i++) {
> -		struct sg_pool *sgp = sg_pools + i;
> -		mempool_destroy(sgp->pool);
> -		kmem_cache_destroy(sgp->slab);
> -	}
> -}
> -
> -module_init(sg_pool_init);
> -module_exit(sg_pool_exit);
> +subsys_initcall(sg_pool_init);

Best regards
-- 
Marek Szyprowski, PhD
Samsung R&D Institute Poland

