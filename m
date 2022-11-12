Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B57AD6268FC
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Nov 2022 11:58:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234820AbiKLK6c (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 12 Nov 2022 05:58:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232427AbiKLK60 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Nov 2022 05:58:26 -0500
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9D42BC21
        for <linux-kernel@vger.kernel.org>; Sat, 12 Nov 2022 02:58:22 -0800 (PST)
Received: from dggpemm500024.china.huawei.com (unknown [172.30.72.53])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4N8Xbh2V3wzHvJN;
        Sat, 12 Nov 2022 18:57:52 +0800 (CST)
Received: from dggpemm100009.china.huawei.com (7.185.36.113) by
 dggpemm500024.china.huawei.com (7.185.36.203) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Sat, 12 Nov 2022 18:58:19 +0800
Received: from huawei.com (10.175.113.32) by dggpemm100009.china.huawei.com
 (7.185.36.113) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Sat, 12 Nov
 2022 18:58:18 +0800
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
Subject: [PATCH v4 0/3] Refactor __kmem_cache_create() and fix memory leak
Date:   Sat, 12 Nov 2022 19:45:59 +0800
Message-ID: <20221112114602.1268989-1-liushixin2@huawei.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.113.32]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
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

v1->v2: Fix build error reported by kernel test robot <lkp@intel.com>.
v2->v3: Don't free kmem_cache that create early.
v3->v4: Fix error in kfree_const of kobject's name.

Liu Shixin (3):
  mm/slab_common: Move cache_name to create_cache()
  mm/slub: Refactor __kmem_cache_create()
  mm/slub: Fix memory leak of kobj->name in sysfs_slab_add()

 include/linux/slub_def.h | 11 +++++++
 mm/slab_common.c         | 44 +++++++++++++++-------------
 mm/slub.c                | 63 +++++++++++++++-------------------------
 3 files changed, 58 insertions(+), 60 deletions(-)

--
2.25.1

