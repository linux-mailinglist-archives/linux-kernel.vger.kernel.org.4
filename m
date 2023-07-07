Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DFD8074B565
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jul 2023 18:53:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233037AbjGGQxK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Jul 2023 12:53:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233007AbjGGQxG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jul 2023 12:53:06 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB08F2694
        for <linux-kernel@vger.kernel.org>; Fri,  7 Jul 2023 09:52:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1688748756; x=1720284756;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=9AZoEU1dBDfQPpclAW3AxhTYvcE6HGN/KVZD4GlGeoo=;
  b=d/94MWC/wkbSzhSnmtqy5gZ/71whsbZAxyYKwWuqvq42/epCEH7Ifmjb
   O6vAkzc2/R1uguu4CnTsodWb4+Yd5TsewLztAqMLlXiUY9wrQbTtYm7Ub
   YsTBfTzMyvPSrsrzT7TDfs4jgwuZURehrbUT+Ql6YzOVyteHSTW0QSDXl
   0Mp+Zv9PAnlVYwI9LJcATgMQFdqXHRSG9bm9WCe5E3PJWUWNER6NoFPcM
   1QeEHWL7lsz0IgkXIiOmJan0WKA3NfZNcGOGu9dEoTIpgRUeZvbmgpfG1
   TmvUiu8YszLz2WU72jqNep4sxYVXCN+og6g9GO1mPuD9t0WIE0fYVtAZc
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10764"; a="353776318"
X-IronPort-AV: E=Sophos;i="6.01,189,1684825200"; 
   d="scan'208";a="353776318"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jul 2023 09:52:35 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10764"; a="697290444"
X-IronPort-AV: E=Sophos;i="6.01,189,1684825200"; 
   d="scan'208";a="697290444"
Received: from fyin-dev.sh.intel.com ([10.239.159.32])
  by orsmga006.jf.intel.com with ESMTP; 07 Jul 2023 09:52:33 -0700
From:   Yin Fengwei <fengwei.yin@intel.com>
To:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        yuzhao@google.com, ryan.roberts@arm.com, shy828301@gmail.com,
        akpm@linux-foundation.org, willy@infradead.org, david@redhat.com
Cc:     fengwei.yin@intel.com
Subject: [RFC PATCH 1/3] mm: add function folio_in_range()
Date:   Sat,  8 Jul 2023 00:52:19 +0800
Message-Id: <20230707165221.4076590-2-fengwei.yin@intel.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230707165221.4076590-1-fengwei.yin@intel.com>
References: <20230707165221.4076590-1-fengwei.yin@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It will be used to check whether the folio is mapped to specific
VMA and whether the mapping address of folio is in the range.

Signed-off-by: Yin Fengwei <fengwei.yin@intel.com>
---
 mm/internal.h | 26 ++++++++++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/mm/internal.h b/mm/internal.h
index f1276d90484ad..66117523d7d71 100644
--- a/mm/internal.h
+++ b/mm/internal.h
@@ -585,6 +585,32 @@ extern long faultin_vma_page_range(struct vm_area_struct *vma,
 				   bool write, int *locked);
 extern bool mlock_future_ok(struct mm_struct *mm, unsigned long flags,
 			       unsigned long bytes);
+
+static inline bool
+folio_in_range(struct folio *folio, struct vm_area_struct *vma,
+		unsigned long start, unsigned long end)
+{
+	pgoff_t pgoff, addr;
+	unsigned long vma_pglen = (vma->vm_end - vma->vm_start) >> PAGE_SHIFT;
+
+	VM_WARN_ON_FOLIO(folio_test_ksm(folio), folio);
+	if (start < vma->vm_start)
+		start = vma->vm_start;
+
+	if (end > vma->vm_end)
+		end = vma->vm_end;
+
+	pgoff = folio_pgoff(folio);
+
+	/* if folio start address is not in vma range */
+	if (pgoff < vma->vm_pgoff || pgoff > vma->vm_pgoff + vma_pglen)
+		return false;
+
+	addr = vma->vm_start + ((pgoff - vma->vm_pgoff) << PAGE_SHIFT);
+
+	return ((addr >= start) && (addr + folio_size(folio) <= end));
+}
+
 /*
  * mlock_vma_folio() and munlock_vma_folio():
  * should be called with vma's mmap_lock held for read or write,
-- 
2.39.2

