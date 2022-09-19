Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8CAE95BC1A8
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Sep 2022 05:13:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229839AbiISDNH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 18 Sep 2022 23:13:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229826AbiISDNC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Sep 2022 23:13:02 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63A4A1A3A1
        for <linux-kernel@vger.kernel.org>; Sun, 18 Sep 2022 20:13:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1663557181; x=1695093181;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=TJneCTmLlrztD6YAx7hnp5eutOdkGZbB+hdFQjt3lUk=;
  b=F0HzyqpD1eA+wqjZQwp8IBufVoP5mqlogbktqTt0mFqPEfitqYk8eI/y
   RWOYj8dBmRHNwpbeiJxEBKU5M7aTxIcK8H7yYl3yw8zPrhTN5nu/fs6sm
   HqJVi8McqnK2lZhdVVDFyRPTZs5If6kPkj3UMSjuSn4+35PkJ4cly2LTc
   u1afthKKRLKKQXqVWjchV5g/0SiZTN0ssBjITFem69Aeu2WP9uPxTwf7W
   neEEDOpoxVQY6AKoQeEx8i6znnFRknD2uwTn8yxzgNMzsYEdczFBHVLH5
   rOSi/PWylpTKcVAqrdi2fPOQ+LfrwfpxhsQr8ibWu9EcXZ3an5BD53R2w
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10474"; a="385583749"
X-IronPort-AV: E=Sophos;i="5.93,325,1654585200"; 
   d="scan'208";a="385583749"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Sep 2022 20:13:01 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,325,1654585200"; 
   d="scan'208";a="569477795"
Received: from feng-clx.sh.intel.com ([10.238.200.228])
  by orsmga003.jf.intel.com with ESMTP; 18 Sep 2022 20:12:57 -0700
From:   Feng Tang <feng.tang@intel.com>
To:     Vlastimil Babka <vbabka@suse.cz>, Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Hyeonggon Yoo <42.hyeyoo@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Waiman Long <longman@redhat.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        kasan-dev@googlegroups.com, Feng Tang <feng.tang@intel.com>
Subject: [PATCH] mm/slab_common: fix possiable double free of kmem_cache
Date:   Mon, 19 Sep 2022 11:12:41 +0800
Message-Id: <20220919031241.1358001-1-feng.tang@intel.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When doing slub_debug test, kfence's 'test_memcache_typesafe_by_rcu'
kunit test case cause a use-after-free error:

  BUG: KASAN: use-after-free in kobject_del+0x14/0x30
  Read of size 8 at addr ffff888007679090 by task kunit_try_catch/261

  CPU: 1 PID: 261 Comm: kunit_try_catch Tainted: G    B            N 6.0.0-rc5-next-20220916 #17
  Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.15.0-1 04/01/2014
  Call Trace:
   <TASK>
   dump_stack_lvl+0x34/0x48
   print_address_description.constprop.0+0x87/0x2a5
   print_report+0x103/0x1ed
   kasan_report+0xb7/0x140
   kobject_del+0x14/0x30
   kmem_cache_destroy+0x130/0x170
   test_exit+0x1a/0x30
   kunit_try_run_case+0xad/0xc0
   kunit_generic_run_threadfn_adapter+0x26/0x50
   kthread+0x17b/0x1b0
   </TASK>

The cause is inside kmem_cache_destroy():

kmem_cache_destroy
    acquire lock/mutex
    shutdown_cache
        schedule_work(kmem_cache_release) (if RCU flag set)
    release lock/mutex
    kmem_cache_release (if RCU flag set)

in some certain timing, the scheduled work could be run before
the next RCU flag checking which will get a wrong state.

Fix it by caching the RCU flag inside protected area, just like 'refcnt'

Signed-off-by: Feng Tang <feng.tang@intel.com>
---

note:

The error only happens on linux-next tree, and not in Linus' tree,
which already has Waiman's commit:
0495e337b703 ("mm/slab_common: Deleting kobject in kmem_cache_destroy()
without holding slab_mutex/cpu_hotplug_lock")

 mm/slab_common.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/mm/slab_common.c b/mm/slab_common.c
index 07b948288f84..ccc02573588f 100644
--- a/mm/slab_common.c
+++ b/mm/slab_common.c
@@ -475,6 +475,7 @@ void slab_kmem_cache_release(struct kmem_cache *s)
 void kmem_cache_destroy(struct kmem_cache *s)
 {
 	int refcnt;
+	bool rcu_set;
 
 	if (unlikely(!s) || !kasan_check_byte(s))
 		return;
@@ -482,6 +483,8 @@ void kmem_cache_destroy(struct kmem_cache *s)
 	cpus_read_lock();
 	mutex_lock(&slab_mutex);
 
+	rcu_set = s->flags & SLAB_TYPESAFE_BY_RCU;
+
 	refcnt = --s->refcount;
 	if (refcnt)
 		goto out_unlock;
@@ -492,7 +495,7 @@ void kmem_cache_destroy(struct kmem_cache *s)
 out_unlock:
 	mutex_unlock(&slab_mutex);
 	cpus_read_unlock();
-	if (!refcnt && !(s->flags & SLAB_TYPESAFE_BY_RCU))
+	if (!refcnt && !rcu_set)
 		kmem_cache_release(s);
 }
 EXPORT_SYMBOL(kmem_cache_destroy);
-- 
2.34.1

