Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 74941635CF6
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Nov 2022 13:35:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236944AbiKWMfE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Nov 2022 07:35:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235612AbiKWMfB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Nov 2022 07:35:01 -0500
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A534DEBD
        for <linux-kernel@vger.kernel.org>; Wed, 23 Nov 2022 04:35:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1669206901; x=1700742901;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=32aAwApD/Py6ob5i40TYQ76jp/UicXBWzicek/tVfb0=;
  b=flTN7wX6/StGouVIAT1r6wDjNg34KVw+HaYf50587lPCkKomMB5rSbcI
   j5pQbxtOAJKxllGBtIiTaoeubBlA4tGvMQY0a38H5rllx5LGpHVmZbLWw
   MlEcWdY1qc83CKLyd+fl1DAGg2fMrAS0JPtNgliMdQADsKnjdpAydH6D8
   Aw/bwLJiH5XufAUSTaval5r7AuHRc+KabG+ZkjOCMi9/LsfT5AJT6JYy2
   xgTMG01AHoCK8si/02168JCdrT6CwoxX8Ga1ANTY52W5In943czumGwp1
   HqjMQL5H55jfag4pZ060yup1J3+ZZO2DqdwierW5OheS4OU9kMGYEqYlA
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10539"; a="340935416"
X-IronPort-AV: E=Sophos;i="5.96,187,1665471600"; 
   d="scan'208";a="340935416"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Nov 2022 04:35:00 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10539"; a="705349428"
X-IronPort-AV: E=Sophos;i="5.96,187,1665471600"; 
   d="scan'208";a="705349428"
Received: from feng-clx.sh.intel.com ([10.238.200.228])
  by fmsmga008.fm.intel.com with ESMTP; 23 Nov 2022 04:34:57 -0800
From:   Feng Tang <feng.tang@intel.com>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Hyeonggon Yoo <42.hyeyoo@gmail.com>,
        Andrey Konovalov <andreyknvl@gmail.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Andrey Ryabinin <ryabinin.a.a@gmail.com>,
        Alexander Potapenko <glider@google.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>
Cc:     linux-mm@kvack.org, kasan-dev@googlegroups.com,
        linux-kernel@vger.kernel.org, Feng Tang <feng.tang@intel.com>
Subject: [PATCH v2 -next 1/2] mm/slb: add is_kmalloc_cache() helper function
Date:   Wed, 23 Nov 2022 20:31:58 +0800
Message-Id: <20221123123159.2325763-1-feng.tang@intel.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

commit 6edf2576a6cc ("mm/slub: enable debugging memory wasting of
kmalloc") introduces 'SLAB_KMALLOC' bit specifying whether a
kmem_cache is a kmalloc cache for slab/slub (slob doesn't have
dedicated kmalloc caches).

Add a helper inline function for other components like kasan to
simplify code.

Signed-off-by: Feng Tang <feng.tang@intel.com>
---
changlog:
  
  since v1:
  * don't use macro for the helper (Andrew Morton)
  * place the inline function in mm/slb.h to solve data structure
    definition issue (Vlastimil Babka)

 mm/slab.h | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/mm/slab.h b/mm/slab.h
index e3b3231af742..0d72fd62751a 100644
--- a/mm/slab.h
+++ b/mm/slab.h
@@ -325,6 +325,14 @@ static inline slab_flags_t kmem_cache_flags(unsigned int object_size,
 }
 #endif
 
+static inline bool is_kmalloc_cache(struct kmem_cache *s)
+{
+#ifndef CONFIG_SLOB
+	return (s->flags & SLAB_KMALLOC);
+#else
+	return false;
+#endif
+}
 
 /* Legal flag mask for kmem_cache_create(), for various configurations */
 #define SLAB_CORE_FLAGS (SLAB_HWCACHE_ALIGN | SLAB_CACHE_DMA | \
-- 
2.34.1

