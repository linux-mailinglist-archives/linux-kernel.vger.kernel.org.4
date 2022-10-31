Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C9135613738
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Oct 2022 13:59:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231217AbiJaM7k (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Oct 2022 08:59:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229871AbiJaM7i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Oct 2022 08:59:38 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5BA74FD27
        for <linux-kernel@vger.kernel.org>; Mon, 31 Oct 2022 05:59:37 -0700 (PDT)
Received: from dggpemm500023.china.huawei.com (unknown [172.30.72.53])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4N1Cm05fb0zVjHr;
        Mon, 31 Oct 2022 20:54:40 +0800 (CST)
Received: from dggpemm100009.china.huawei.com (7.185.36.113) by
 dggpemm500023.china.huawei.com (7.185.36.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Mon, 31 Oct 2022 20:59:35 +0800
Received: from huawei.com (10.175.113.32) by dggpemm100009.china.huawei.com
 (7.185.36.113) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Mon, 31 Oct
 2022 20:59:35 +0800
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
Subject: [PATCH v2 0/3] Refactor __kmem_cache_create() and fix memory leak
Date:   Mon, 31 Oct 2022 21:47:44 +0800
Message-ID: <20221031134747.3049593-1-liushixin2@huawei.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.113.32]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
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

Liu Shixin (3):
  mm/slab_common: Move cache_name to create_cache()
  mm/slub: Refactor __kmem_cache_create()
  mm/slub: Fix memory leak of kobj->name in sysfs_slab_add()

 include/linux/slub_def.h | 11 +++++++++
 mm/slab_common.c         | 44 ++++++++++++++++++----------------
 mm/slub.c                | 52 ++++++++++------------------------------
 3 files changed, 48 insertions(+), 59 deletions(-)

-- 
2.25.1

