Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 345F7615E63
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Nov 2022 09:53:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229846AbiKBIxO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Nov 2022 04:53:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229548AbiKBIxL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Nov 2022 04:53:11 -0400
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC66824F22
        for <linux-kernel@vger.kernel.org>; Wed,  2 Nov 2022 01:53:10 -0700 (PDT)
Received: from dggpemm500023.china.huawei.com (unknown [172.30.72.56])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4N2LF32w9qzJnLD;
        Wed,  2 Nov 2022 16:50:15 +0800 (CST)
Received: from dggpemm100009.china.huawei.com (7.185.36.113) by
 dggpemm500023.china.huawei.com (7.185.36.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Wed, 2 Nov 2022 16:53:09 +0800
Received: from [10.174.179.24] (10.174.179.24) by
 dggpemm100009.china.huawei.com (7.185.36.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Wed, 2 Nov 2022 16:53:08 +0800
Subject: Re: [PATCH v2 0/3] Refactor __kmem_cache_create() and fix memory leak
To:     Hyeonggon Yoo <42.hyeyoo@gmail.com>
References: <20221031134747.3049593-1-liushixin2@huawei.com>
 <Y2IgUwTH/dO06Tot@hyeyoo>
CC:     Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        "David Rientjes" <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        "Andrew Morton" <akpm@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        "Roman Gushchin" <roman.gushchin@linux.dev>, <linux-mm@kvack.org>,
        <linux-kernel@vger.kernel.org>
From:   Liu Shixin <liushixin2@huawei.com>
Message-ID: <c03620e3-6159-1c46-c472-c15186f4ccae@huawei.com>
Date:   Wed, 2 Nov 2022 16:53:08 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.7.1
MIME-Version: 1.0
In-Reply-To: <Y2IgUwTH/dO06Tot@hyeyoo>
Content-Type: text/plain; charset="windows-1252"
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



On 2022/11/2 15:46, Hyeonggon Yoo wrote:
> On Mon, Oct 31, 2022 at 09:47:44PM +0800, Liu Shixin wrote:
>> I found a memory leak of kobj->name in sysfs_slab_add() which is introduced
>> by 80da026a8e5d ("mm/slub: fix slab double-free in case of duplicate sysfs filename").
>> Following the rules stated in the comment for kobject_init_and_add():
> Thank you for reporting this! Indeed it seems tried to fix double free but
> introduced a leak.
>
>>  If this function returns an error, kobject_put() must be called to
>>  properly clean up the memory associated with the object.
>>
>> We should use kobject_put() to free kobject.
> But what to do if a cache is created early and later sysfs_slab_add() failed?
> (Which is unlikely on normal condition)
>
> With this series it introduces use-after-free if sysfs_slab_add() in
> slab_sysfs_init() failed.  Should we just call BUG() or something like that?
Thanks for your discovery, what I missed. I prefer to panic directly, just as create_boot_cache() does.
Of couse, if you want the system to continue booting, I think it's possible to distinguish them
by slab_state.

Looking forward to your advice.
Thanks,
>
>> But we can't simply add kobject_put() since it will free kmem_cache too.
>> If we use kobject_put(), we need to skip other release functions.
>>
>> In this series, We refactor the code to separate sysfs_slab_add() and
>> debugfs_slab_add() from __kmem_cache_create(), and then use kobject_put()
>> to free kobject in sysfs_slab_add(). This can fix the memory leak of
>> kobject->name.
>>
>> v1->v2: Fix build error reported by kernel test robot <lkp@intel.com>.
>>
>> Liu Shixin (3):
>>   mm/slab_common: Move cache_name to create_cache()
>>   mm/slub: Refactor __kmem_cache_create()
>>   mm/slub: Fix memory leak of kobj->name in sysfs_slab_add()
>>
>>  include/linux/slub_def.h | 11 +++++++++
>>  mm/slab_common.c         | 44 ++++++++++++++++++----------------
>>  mm/slub.c                | 52 ++++++++++------------------------------
>>  3 files changed, 48 insertions(+), 59 deletions(-)
>>
>> -- 
>> 2.25.1
>>

