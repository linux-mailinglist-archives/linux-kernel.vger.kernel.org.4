Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C59F63245C
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Nov 2022 14:53:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230157AbiKUNxa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Nov 2022 08:53:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229640AbiKUNx1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Nov 2022 08:53:27 -0500
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 855F61EECB
        for <linux-kernel@vger.kernel.org>; Mon, 21 Nov 2022 05:53:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1669038806; x=1700574806;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=VxqTtM17BmtYe97UGlIkeXzguZmoQW3WI6yuaWgDYSE=;
  b=oE/lX1CojWbEkBQaUY5u/UQtNZcrQZse7JrviaSBsAwjQfvVwcCbuk8b
   2CRhFfo6r4G6pNloOiJ0sfi4SipGEMeaX1taQpO0L10UxbKoia7UWeWXd
   AFbwATVGpODMJQr15WZC39OUDxtjU/X7zxoQq53EpxIYKPaLt5/uYMgp1
   AiUQ9r/O0bq5TPckSVZfV3mzEtsWH//LuvpXpDUQnWPyjZQgHR7Zqr0MT
   r0HzxZf2Cb4Q6/w+cXPF1sO1UFNLkjNgP41TSAzOOAcfQgqkbopfvzdQz
   T5Nz3mEp8AA6WRlKiDdY7HSuE0Mx2M5ThMFY1sIKh9+U5lWJisC+m2fg4
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10538"; a="312261154"
X-IronPort-AV: E=Sophos;i="5.96,181,1665471600"; 
   d="scan'208";a="312261154"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Nov 2022 05:53:26 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10537"; a="886125081"
X-IronPort-AV: E=Sophos;i="5.96,181,1665471600"; 
   d="scan'208";a="886125081"
Received: from feng-clx.sh.intel.com ([10.238.200.228])
  by fmsmga006.fm.intel.com with ESMTP; 21 Nov 2022 05:53:22 -0800
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
Subject: [PATCH -next 1/2] mm/slab: add is_kmalloc_cache() helper macro
Date:   Mon, 21 Nov 2022 21:50:23 +0800
Message-Id: <20221121135024.1655240-1-feng.tang@intel.com>
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

Add a helper macro for other components like kasan to simplify code.

Signed-off-by: Feng Tang <feng.tang@intel.com>
---
 include/linux/slab.h | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/include/linux/slab.h b/include/linux/slab.h
index 1c670c16c737..ee6499088ad3 100644
--- a/include/linux/slab.h
+++ b/include/linux/slab.h
@@ -758,6 +758,12 @@ extern void kvfree_sensitive(const void *addr, size_t len);
 
 unsigned int kmem_cache_size(struct kmem_cache *s);
 
+#ifndef CONFIG_SLOB
+#define is_kmalloc_cache(s) ((s)->flags & SLAB_KMALLOC)
+#else
+#define is_kmalloc_cache(s) (false)
+#endif
+
 /**
  * kmalloc_size_roundup - Report allocation bucket size for the given size
  *
-- 
2.34.1

