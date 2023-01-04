Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D5C4865CCC6
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Jan 2023 07:08:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233273AbjADGIs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Jan 2023 01:08:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229655AbjADGIr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jan 2023 01:08:47 -0500
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D00F12637
        for <linux-kernel@vger.kernel.org>; Tue,  3 Jan 2023 22:08:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1672812526; x=1704348526;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=akgWoI1DZBNrZUnXySes4BuMOxDs0QUyVGoUEHSDAAM=;
  b=Jfv+xXHorquctWz0QKHm2VsD8x0fLPOfdppi6t/0zn8sLke12wUFHQEM
   ATnYcLKP+E1Wca7n+mn3CVcWpI6e11fjViPakW7NmH/MzA1SesVvym72Y
   PukpabBTbXDM7xqc27M48SYVaKWSLGNsDnO3WAgpkSjDoG/qrimyg/HF+
   vQ3TNc1dt2zCrirIeovKy956Zrvi0SR64j6iZtqgpArA9dkXQ1plM5B5F
   MnZBZFFvGmMkagmXEUFU25vSkBpWfcRKRgARzgRspnIeJdX/MyPwQNNfg
   dH4m5Drq+l6E8JoLzjmPqdRGRjIGOaJXLrNESRaC4FjccRb9xbZSSctrx
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10579"; a="323840107"
X-IronPort-AV: E=Sophos;i="5.96,299,1665471600"; 
   d="scan'208";a="323840107"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jan 2023 22:08:45 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10579"; a="779094063"
X-IronPort-AV: E=Sophos;i="5.96,299,1665471600"; 
   d="scan'208";a="779094063"
Received: from feng-clx.sh.intel.com ([10.238.200.228])
  by orsmga004.jf.intel.com with ESMTP; 03 Jan 2023 22:08:41 -0800
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
Subject: [Patch v3 -mm 1/2] mm/slab: add is_kmalloc_cache() helper function
Date:   Wed,  4 Jan 2023 14:06:04 +0800
Message-Id: <20230104060605.930910-1-feng.tang@intel.com>
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

commit 6edf2576a6cc ("mm/slub: enable debugging memory wasting of
kmalloc") introduces 'SLAB_KMALLOC' bit specifying whether a
kmem_cache is a kmalloc cache for slab/slub (slob doesn't have
dedicated kmalloc caches).

Add a helper inline function for other components like kasan to
simplify code.

Signed-off-by: Feng Tang <feng.tang@intel.com>
Acked-by: Vlastimil Babka <vbabka@suse.cz>
Acked-by: Hyeonggon Yoo <42.hyeyoo@gmail.com>
---
changlog:

  since v2:
  * fix type in subject(Vlastimil Babka)
  * collect Acked-by tag
  
  since v1:
  * don't use macro for the helper (Andrew Morton)
  * place the inline function in mm/slab.h to solve data structure
    definition issue (Vlastimil Babka)

 mm/slab.h | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/mm/slab.h b/mm/slab.h
index 7cc432969945..63fb4c00d529 100644
--- a/mm/slab.h
+++ b/mm/slab.h
@@ -323,6 +323,14 @@ static inline slab_flags_t kmem_cache_flags(unsigned int object_size,
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

