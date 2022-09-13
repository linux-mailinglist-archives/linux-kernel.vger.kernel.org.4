Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF9185B6830
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Sep 2022 08:54:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230483AbiIMGyx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Sep 2022 02:54:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230433AbiIMGyu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Sep 2022 02:54:50 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5FC0CDEC1
        for <linux-kernel@vger.kernel.org>; Mon, 12 Sep 2022 23:54:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1663052088; x=1694588088;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=HeNaCXXVIao0VFO7uU90W0+/EcGCHe8FxZA3/bVxX44=;
  b=JtHsBailUk2mG9fFFtb6nTCtIVr/ant/KdypVRhwRDmvjoa27qkOgHGs
   sM42roY+P7pOkZ+Auot24lHOniXoQo/0KanF6Zqt5cSUBXiXpOu1xNiex
   jAocsuwka6ElrkyfZX2KDVC9TvkJxNM8pdVmYrWl2FCQANYxi+qLPQJhk
   fb+3I/PtqumRJegs+HIXMOkWb7od1wZph7Deef44pmzIiJLtrdFVpk8ml
   95i+XEdxsDV8zz0R18uMqwmPaMcBEjPxKO/lCeMWzaCt4zdbfxWIMR5d3
   qZzXNkceO0BKeeWoc6Q/GP2tuGKDzsuzr7LO4pclUqk4gDDgNdkn6SWy1
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10468"; a="298855220"
X-IronPort-AV: E=Sophos;i="5.93,312,1654585200"; 
   d="scan'208";a="298855220"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Sep 2022 23:54:46 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,312,1654585200"; 
   d="scan'208";a="861440697"
Received: from feng-clx.sh.intel.com ([10.238.200.228])
  by fmsmga006.fm.intel.com with ESMTP; 12 Sep 2022 23:54:42 -0700
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
        Feng Tang <feng.tang@intel.com>
Subject: [PATCH v6 0/4] mm/slub: some debug enhancements for kmalloc
Date:   Tue, 13 Sep 2022 14:54:19 +0800
Message-Id: <20220913065423.520159-1-feng.tang@intel.com>
X-Mailer: git-send-email 2.34.1
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

kmalloc's API family is critical for mm, and one of its nature is that
it will round up the request size to a fixed one (mostly power of 2).
When user requests memory for '2^n + 1' bytes, actually 2^(n+1) bytes
could be allocated, so in worst case, there is around 50% memory space
waste.

The wastage is not a big issue for requests that get allocated/freed
quickly, but may cause problems with objects that have longer life time,
and there were some OOM cases in some extrem cases.

This patchset(4/4) tries to :
* Add a debug method to track each kmalloced object's wastage info,
  and show the call stack of original allocation (depends on
  SLAB_STORE_USER flag) (Patch 1)

* Extend the redzone sanity check to the extra kmalloced buffer than
  requested, to better detect un-legitimate access to it. (depends
  on SLAB_STORE_USER & SLAB_RED_ZONE) (Patch 2/3/4, while 2/3 are
  preparation patches)

The redzone part has been tested with code below:

	for (shift = 3; shift <= 12; shift++) {
		size = 1 << shift;
		buf = kmalloc(size + 4, GFP_KERNEL);
		/* We have 96, 196 kmalloc size, which is not power of 2 */
		if (size == 64 || size == 128)
			oob_size = 16;
		else
			oob_size = size - 4;
		memset(buf + size + 4, 0xee, oob_size);
		kfree(buf);
	}

Please help to review, thanks!

- Feng

---
Changelogs:

  since v5:
    * Refine code/comments and add more perf info in commit log for
      kzalloc change (Hyeonggoon Yoo)
    * change the kasan param name and refine comments about
      kasan+redzone handling (Andrey Konovalov)
    * put free pointer in meta data to make redzone check cover all
      kmalloc objects (Hyeonggoon Yoo)

  since v4:
    * fix a race issue in v3, by moving kmalloc debug init into
      alloc_debug_processing (Hyeonggon Yoo)
    * add 'partial_conext' for better parameter passing in get_partial()
      call chain (Vlastimil Babka)
    * update 'slub.rst' for 'alloc_traces' part (Hyeonggon Yoo)
    * update code comments for 'orig_size'

  since v3:
    * rebase against latest post 6.0-rc1 slab tree's 'for-next' branch
    * fix a bug reported by 0Day, that kmalloc-redzoned data and kasan's
      free meta data overlaps in the same kmalloc object data area

  since v2:
    * rebase against slab tree's 'for-next' branch
    * fix pointer handling (Kefeng Wang)
    * move kzalloc zeroing handling change to a separate patch (Vlastimil Babka)
    * make 'orig_size' only depend on KMALLOC & STORE_USER flag
      bits (Vlastimil Babka)

  since v1:
    * limit the 'orig_size' to kmalloc objects only, and save
      it after track in metadata (Vlastimil Babka)
    * fix a offset calculation problem in print_trailer

  since RFC:
    * fix problems in kmem_cache_alloc_bulk() and records sorting,
      improve the print format (Hyeonggon Yoo)
    * fix a compiling issue found by 0Day bot
    * update the commit log based info from iova developers

Feng Tang (4):
  mm/slub: enable debugging memory wasting of kmalloc
  mm/slub: only zero the requested size of buffer for kzalloc
  mm: kasan: Add free_meta size info in struct kasan_cache
  mm/slub: extend redzone check to extra allocated kmalloc space than
    requested

 Documentation/mm/slub.rst |  33 +++---
 include/linux/kasan.h     |   2 +
 include/linux/slab.h      |   2 +
 mm/kasan/common.c         |   2 +
 mm/slab.c                 |   7 +-
 mm/slab.h                 |   9 +-
 mm/slab_common.c          |   4 +
 mm/slub.c                 | 217 ++++++++++++++++++++++++++++++--------
 8 files changed, 214 insertions(+), 62 deletions(-)

--
2.34.1

