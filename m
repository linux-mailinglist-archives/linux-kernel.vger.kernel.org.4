Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EBB2F5B6836
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Sep 2022 08:55:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230527AbiIMGzP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Sep 2022 02:55:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230511AbiIMGzI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Sep 2022 02:55:08 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F9271AD99
        for <linux-kernel@vger.kernel.org>; Mon, 12 Sep 2022 23:54:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1663052098; x=1694588098;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=DytKD4r9+X/L41exc0OVKMw7LZ0hR4YVrRBK5Geu9bo=;
  b=IoR8MGtQ6sN3mUy9jWov3JLEXeQdhItD2wIiQCy5NyG8gsWVO6ldg3vx
   rMfDaJf1Spg2tmT2vnAu2u3626tP/+hIRbtjbfFvtqyPKb2w46whY5Ls9
   Iu43CI2f/6HLU7aOl9BGTAtO6OwMZNermMkoVkHCN1eS2XEYcbucSnTVK
   D448JFaySJ55MU4N9tLasuckSMTAWkfpf+bo+8DIsX7nN7j7HC5XDwWut
   iMcMjEp4xceq6FJiyTrNwth5Jtt+TtDxOHWG/Xy5QS/sjefkgJxoXPZxK
   SFZ87oGRZ+6nLu2Ykh4DCf+oe1+PfzphFaanqDdBXP31HFtDeEvjnyIvi
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10468"; a="298855264"
X-IronPort-AV: E=Sophos;i="5.93,312,1654585200"; 
   d="scan'208";a="298855264"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Sep 2022 23:54:58 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,312,1654585200"; 
   d="scan'208";a="861440734"
Received: from feng-clx.sh.intel.com ([10.238.200.228])
  by fmsmga006.fm.intel.com with ESMTP; 12 Sep 2022 23:54:54 -0700
From:   Feng Tang <feng.tang@intel.com>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Hyeonggon Yoo <42.hyeyoo@gmail.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Andrey Konovalov <andreyknvl@gmail.com>
Cc:     Dave Hansen <dave.hansen@intel.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, kasan-dev@googlegroups.com,
        Feng Tang <feng.tang@intel.com>,
        kernel test robot <oliver.sang@intel.com>
Subject: [PATCH v6 3/4] mm: kasan: Add free_meta size info in struct kasan_cache
Date:   Tue, 13 Sep 2022 14:54:22 +0800
Message-Id: <20220913065423.520159-4-feng.tang@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220913065423.520159-1-feng.tang@intel.com>
References: <20220913065423.520159-1-feng.tang@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When kasan is enabled for slab/slub, it may save kasan' free_meta
data in the former part of slab object data area in slab object's
free path, which works fine.

There is ongoing effort to extend slub's debug function which will
redzone the latter part of kmalloc object area, and when both of
the debug are enabled, there is possible conflict, especially when
the kmalloc object has small size, as caught by 0Day bot [1]

For better information for slab/slub, add free_meta's data size
into 'struct kasan_cache', so that its users can take right action
to avoid data conflict.

[1]. https://lore.kernel.org/lkml/YuYm3dWwpZwH58Hu@xsang-OptiPlex-9020/
Reported-by: kernel test robot <oliver.sang@intel.com>
Signed-off-by: Feng Tang <feng.tang@intel.com>
Acked-by: Dmitry Vyukov <dvyukov@google.com>
---
 include/linux/kasan.h | 2 ++
 mm/kasan/common.c     | 2 ++
 2 files changed, 4 insertions(+)

diff --git a/include/linux/kasan.h b/include/linux/kasan.h
index b092277bf48d..49af9513e8ed 100644
--- a/include/linux/kasan.h
+++ b/include/linux/kasan.h
@@ -100,6 +100,8 @@ static inline bool kasan_has_integrated_init(void)
 struct kasan_cache {
 	int alloc_meta_offset;
 	int free_meta_offset;
+	/* size of free_meta data saved in object's data area */
+	int free_meta_size;
 	bool is_kmalloc;
 };
 
diff --git a/mm/kasan/common.c b/mm/kasan/common.c
index 69f583855c8b..0cb867e92524 100644
--- a/mm/kasan/common.c
+++ b/mm/kasan/common.c
@@ -201,6 +201,8 @@ void __kasan_cache_create(struct kmem_cache *cache, unsigned int *size,
 			cache->kasan_info.free_meta_offset = KASAN_NO_FREE_META;
 			*size = ok_size;
 		}
+	} else {
+		cache->kasan_info.free_meta_size = sizeof(struct kasan_free_meta);
 	}
 
 	/* Calculate size with optimal redzone. */
-- 
2.34.1

