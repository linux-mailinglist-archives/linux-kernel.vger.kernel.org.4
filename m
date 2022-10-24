Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0FEF9609ACB
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Oct 2022 08:54:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230121AbiJXGyP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Oct 2022 02:54:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230217AbiJXGyG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Oct 2022 02:54:06 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3CE2C5B73B
        for <linux-kernel@vger.kernel.org>; Sun, 23 Oct 2022 23:54:02 -0700 (PDT)
Received: from dggpemm500022.china.huawei.com (unknown [172.30.72.55])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4Mwm4s0W3rzHv6T;
        Mon, 24 Oct 2022 14:53:49 +0800 (CST)
Received: from dggpemm100009.china.huawei.com (7.185.36.113) by
 dggpemm500022.china.huawei.com (7.185.36.162) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Mon, 24 Oct 2022 14:53:59 +0800
Received: from huawei.com (10.175.113.32) by dggpemm100009.china.huawei.com
 (7.185.36.113) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Mon, 24 Oct
 2022 14:53:59 +0800
From:   Liu Shixin <liushixin2@huawei.com>
To:     Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        "David Rientjes" <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        "Andrew Morton" <akpm@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        "Roman Gushchin" <roman.gushchin@linux.dev>,
        Hyeonggon Yoo <42.hyeyoo@gmail.com>
CC:     <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
        Liu Shixin <liushixin2@huawei.com>
Subject: [PATCH 0/4] Refactor __kmem_cache_create() and fix memory leak
Date:   Mon, 24 Oct 2022 15:42:28 +0800
Message-ID: <20221024074232.151383-1-liushixin2@huawei.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.113.32]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 dggpemm100009.china.huawei.com (7.185.36.113)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I found a memory leak of kobj->name in sysfs_slab_add() which is introduced
by 80da026a8e5d ("mm/slub: fix slab double-free in case of duplicate sysfs filename").
Following the rules stated in the comment for kobject_init_and_add():

 If this function returns an error, kobject_put() must be called to
 properly clean up the memory associated with the object.

We should use kobject_put() to free kobject.

But we can't simply add kobject_put() since it will free kmem_cache too.
If we use kobject_put(), we need to skip other release functions.

In this series, We refactor the code to separate sysfs_slab_add() and
debugfs_slab_add() from __kmem_cache_create(), and then use kobject_put()
to free kobject in sysfs_slab_add(). This can fix the memory leak of
kobject->name.

Liu Shixin (4):
  mm/slab_common: Move cache_name to create_cache()
  mm/slub: rename kmem_cache_release to slab_release in slub.c
  mm/slab_common: Separate sysfs_slab_add() and debugfs_slab_add() from
    __kmem_cache_create()
  mm/slab_common: Fix memory leak of kobj->name in sysfs_slab_add()

 include/linux/slub_def.h | 11 ++++++++
 mm/slab_common.c         | 42 ++++++++++++++++--------------
 mm/slub.c                | 56 +++++++++++-----------------------------
 3 files changed, 48 insertions(+), 61 deletions(-)

-- 
2.25.1

