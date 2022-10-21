Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5CE26606E47
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Oct 2022 05:24:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229976AbiJUDYR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Oct 2022 23:24:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229574AbiJUDYM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Oct 2022 23:24:12 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 399DF1B65C8
        for <linux-kernel@vger.kernel.org>; Thu, 20 Oct 2022 20:24:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1666322651; x=1697858651;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=lxJEukWGnKCepPojAgWRbHEwkob3SF5ucbXYsWWNJCU=;
  b=EmRSYzRA3j5gKAm2xIU5++OtQbZ00O1MqJ7FjrVKpXF3OgaGHRWLKzGM
   WAX3fQm99ZBOnPhiBRQYzvzyb+sly7AE2DowBYgOyw8txKsD9kBHkIngD
   BzI5rWIxbGi8ETdM4i+BUJzIjmkrNns8+4pnUkHPZ5/W9KcYFg62YQuPX
   yK7VJ8RE0G4695snru3XHwhu4XjUs7dxzDLQXv6fAIJVNdUi8brYctP+V
   4j/jJvkAmQ9k6D5L55/DP+/licr0vfKldL5DgGX+y57sORYGHaDRLUJM0
   siRRSEItDzjbpfAzSoSwO81ofY++ZNm335j7jq9y4XV6QMgkT75Z6neI+
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10506"; a="333471588"
X-IronPort-AV: E=Sophos;i="5.95,200,1661842800"; 
   d="scan'208";a="333471588"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Oct 2022 20:24:11 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10506"; a="719459530"
X-IronPort-AV: E=Sophos;i="5.95,200,1661842800"; 
   d="scan'208";a="719459530"
Received: from feng-clx.sh.intel.com ([10.238.200.228])
  by FMSMGA003.fm.intel.com with ESMTP; 20 Oct 2022 20:24:07 -0700
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
        Andrey Konovalov <andreyknvl@gmail.com>,
        Kees Cook <keescook@chromium.org>
Cc:     Dave Hansen <dave.hansen@intel.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, kasan-dev@googlegroups.com,
        Feng Tang <feng.tang@intel.com>
Subject: [PATCH v7 0/3] mm/slub: extend redzone check for kmalloc objects 
Date:   Fri, 21 Oct 2022 11:24:02 +0800
Message-Id: <20221021032405.1825078-1-feng.tang@intel.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

kmalloc's API family is critical for mm, and one of its nature is that
it will round up the request size to a fixed one (mostly power of 2).
When user requests memory for '2^n + 1' bytes, actually 2^(n+1) bytes
could be allocated, so there is an extra space than what is originally
requested.

This patchset tries to extend the redzone sanity check to the extra
kmalloced buffer than requested, to better detect un-legitimate access
to it. (dependson SLAB_STORE_USER & SLAB_RED_ZONE)

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

(This is against slab tree's 'for-6.2/slub-sysfs' branch, with
HEAD 54736f702526)

Please help to review, thanks!

- Feng
---
Changelogs:

  since v6:
    * 1/4 patch of kmalloc memory wastage debug patch was merged
      to 6.1-rc1, so drop it
    * refine the kasan patch by extending existing APIs and hiding
      kasan internal data structure info (Andrey Konovalov)
    * only reduce zeroing size when slub debug is enabled to
      avoid security risk (Kees Cook/Andrey Konovalov)
    * collect Acked-by tag from Hyeonggon Yoo

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


Feng Tang (3):
  mm/slub: only zero requested size of buffer for kzalloc when debug
    enabled
  mm: kasan: Extend kasan_metadata_size() to also cover in-object size
  mm/slub: extend redzone check to extra allocated kmalloc space than
    requested

 include/linux/kasan.h |  5 ++--
 mm/kasan/generic.c    | 19 +++++++++----
 mm/slab.c             |  7 +++--
 mm/slab.h             | 22 +++++++++++++--
 mm/slab_common.c      |  4 +++
 mm/slub.c             | 65 +++++++++++++++++++++++++++++++++++++------
 6 files changed, 100 insertions(+), 22 deletions(-)

-- 
2.34.1

