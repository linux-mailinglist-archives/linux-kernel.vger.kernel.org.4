Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A7586268F0
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Nov 2022 11:47:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234551AbiKLKrW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 12 Nov 2022 05:47:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231558AbiKLKrU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Nov 2022 05:47:20 -0500
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5530918B0C
        for <linux-kernel@vger.kernel.org>; Sat, 12 Nov 2022 02:47:19 -0800 (PST)
Received: from dggpemm500023.china.huawei.com (unknown [172.30.72.54])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4N8XMC5ccbzRp3V;
        Sat, 12 Nov 2022 18:47:03 +0800 (CST)
Received: from dggpemm100009.china.huawei.com (7.185.36.113) by
 dggpemm500023.china.huawei.com (7.185.36.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Sat, 12 Nov 2022 18:47:17 +0800
Received: from [10.174.179.24] (10.174.179.24) by
 dggpemm100009.china.huawei.com (7.185.36.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Sat, 12 Nov 2022 18:47:16 +0800
Subject: Re: [PATCH v3 0/3] Refactor __kmem_cache_create() and fix memory leak
To:     Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        "David Rientjes" <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        "Andrew Morton" <akpm@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        "Roman Gushchin" <roman.gushchin@linux.dev>,
        Hyeonggon Yoo <42.hyeyoo@gmail.com>
References: <20221112112055.1111078-1-liushixin2@huawei.com>
CC:     <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>
From:   Liu Shixin <liushixin2@huawei.com>
Message-ID: <468b9657-df1a-24a2-49fe-18377bf59651@huawei.com>
Date:   Sat, 12 Nov 2022 18:47:16 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.7.1
MIME-Version: 1.0
In-Reply-To: <20221112112055.1111078-1-liushixin2@huawei.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.179.24]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 dggpemm100009.china.huawei.com (7.185.36.113)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Please ignore this set of patches. I need fix and will resend then.


thanks,

Liu Shixin

.

On 2022/11/12 19:20, Liu Shixin wrote:
> I found a memory leak of kobj->name in sysfs_slab_add() which is introduced
> by 80da026a8e5d ("mm/slub: fix slab double-free in case of duplicate sysfs filename").
> Following the rules stated in the comment for kobject_init_and_add():
>
>  If this function returns an error, kobject_put() must be called to
>  properly clean up the memory associated with the object.
>
> We should use kobject_put() to free kobject.
>
> But we can't simply add kobject_put() since it will free kmem_cache too.
> If we use kobject_put(), we need to skip other release functions.
>
> In this series, We refactor the code to separate sysfs_slab_add() and
> debugfs_slab_add() from __kmem_cache_create(), and then use kobject_put()
> to free kobject in sysfs_slab_add(). This can fix the memory leak of
> kobject->name.
>
> v1->v2: Fix build error reported by kernel test robot <lkp@intel.com>.
> v2->v3: Don't free kmem_cache that create early.
>
> Liu Shixin (3):
>   mm/slab_common: Move cache_name to create_cache()
>   mm/slub: Refactor __kmem_cache_create()
>   mm/slub: Fix memory leak of kobj->name in sysfs_slab_add()
>
>  include/linux/slub_def.h | 11 +++++++
>  mm/slab_common.c         | 44 +++++++++++++++-------------
>  mm/slub.c                | 63 +++++++++++++++-------------------------
>  3 files changed, 58 insertions(+), 60 deletions(-)
>

