Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 95D046A78DB
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Mar 2023 02:26:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229672AbjCBB0e (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Mar 2023 20:26:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229445AbjCBB0c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Mar 2023 20:26:32 -0500
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AEE15567B1
        for <linux-kernel@vger.kernel.org>; Wed,  1 Mar 2023 17:26:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1677720388; x=1709256388;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=pGmuTevQ07eJFP0ypp19WPyXeC9s3DN8CSY+tvCbLVs=;
  b=BVS9ruwRzJp7nstuPN8qyKx2jmlZ45dB/2Ai4xfVxhwARyrnFhLUioJw
   SOzS+BzpOJQxYyJheU82qi1lhbeiXv5Ji3maaRkvdk/XsA3MFAu7bTO1V
   oXYWzZpJHlvfoRElN4cle3RGc1iprpKeeeiK78fiL0u504LXhc9E9UmRP
   GBCM4038ilaqkleF0owD2Zze5vSha7oTbxKx2a5SNgxDepDSRADN5PnUk
   Wy7l2SbXbij/tiHJacq5mg3Z6iQzLTLDBZmsB/3mqbFPK+e+Bb8HccSEh
   4jKzhrwrUP/EzHI3Yb4kyanLh8nKekYhEzUf4z0C5kMPAw0xOExom/lK6
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10636"; a="315002942"
X-IronPort-AV: E=Sophos;i="5.98,226,1673942400"; 
   d="scan'208";a="315002942"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Mar 2023 17:26:28 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10636"; a="652226939"
X-IronPort-AV: E=Sophos;i="5.98,226,1673942400"; 
   d="scan'208";a="652226939"
Received: from yhuang6-mobl2.sh.intel.com ([10.238.7.50])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Mar 2023 17:26:23 -0800
From:   Huang Ying <ying.huang@intel.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Huang Ying <ying.huang@intel.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Baolin Wang <baolin.wang@linux.alibaba.com>,
        Xin Hao <xhao@linux.alibaba.com>, Zi Yan <ziy@nvidia.com>,
        Yang Shi <shy828301@gmail.com>,
        Oscar Salvador <osalvador@suse.de>,
        Matthew Wilcox <willy@infradead.org>,
        Bharata B Rao <bharata@amd.com>,
        Alistair Popple <apopple@nvidia.com>
Subject: [PATCH] migrate_pages: silence gcc notes for mis-casting
Date:   Thu,  2 Mar 2023 09:26:10 +0800
Message-Id: <20230302012610.17055-1-ying.huang@intel.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following GCC notes was reported for commit 64c8902ed441
("migrate_pages: split unmap_and_move() to _unmap() and _move()").

    mm/migrate.c: In function ‘__migrate_folio_extract’:
    mm/migrate.c:1050:20: note: randstruct: casting between randomized
structure pointer types (ssa): ‘struct anon_vma’ and ‘struct
address_space’

     1050 |         *anon_vmap = (void *)dst->mapping;
          |         ~~~~~~~~~~~^~~~~~~~~~~~~~~~~~~~~~

The casting itself is safe.  Because we only use dst->mapping to store
the pointer itself temporarily and dst is a newly allocated folio and
not used by anyone else during that.  But the notes should be silenced
and some comments are deserved.  So, we do that in this patch.

Fixes: 64c8902ed441 ("migrate_pages: split unmap_and_move() to _unmap() and _move()")
Signed-off-by: "Huang, Ying" <ying.huang@intel.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Baolin Wang <baolin.wang@linux.alibaba.com>
Cc: Xin Hao <xhao@linux.alibaba.com>
Cc: Zi Yan <ziy@nvidia.com>
Cc: Yang Shi <shy828301@gmail.com>
Cc: Oscar Salvador <osalvador@suse.de>
Cc: Matthew Wilcox <willy@infradead.org>
Cc: Bharata B Rao <bharata@amd.com>
Cc: Alistair Popple <apopple@nvidia.com>
---
 mm/migrate.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/mm/migrate.c b/mm/migrate.c
index c17ce5ee8d92..53fcc23025c7 100644
--- a/mm/migrate.c
+++ b/mm/migrate.c
@@ -1047,7 +1047,16 @@ static void __migrate_folio_extract(struct folio *dst,
 				   int *page_was_mappedp,
 				   struct anon_vma **anon_vmap)
 {
-	*anon_vmap = (void *)dst->mapping;
+	struct anon_vma *anon_vma;
+
+	/*
+	 * 2 steps assignment to silence gcc notes for mis-casting. The
+	 * casting is safe.  Because we only use dst->mapping to store
+	 * the pointer itself temporarily and dst is a newly allocated
+	 * folio and not used by anyone else during that.
+	 */
+	anon_vma = (void *)dst->mapping;
+	*anon_vmap = anon_vma;
 	*page_was_mappedp = (unsigned long)dst->private;
 	dst->mapping = NULL;
 	dst->private = NULL;
-- 
2.39.2

