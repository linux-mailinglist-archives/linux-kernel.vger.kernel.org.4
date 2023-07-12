Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D1F7C74FEED
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jul 2023 08:02:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231855AbjGLGCA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jul 2023 02:02:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231908AbjGLGB6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jul 2023 02:01:58 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7CE1A1
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jul 2023 23:01:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1689141716; x=1720677716;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=o/Aws3JMOGR03jlt+wsWp78WyeH6J7qvKifxMU03VXk=;
  b=HOWl/6IvgD7ycJi94VOA24NeNfDtM69WHwqB2Ql84ce5BfNHhJ3VbMYA
   0EM8S5SFqbw4AhwxQ6Zg4XPLvHfXOkHJWOw0QaRXL5ZwZR+bjXsCIcxGP
   oU2s9LJAbznR4SEtcI+hBCFJVL+Iag2tN4qMoQMD9rKR3ZO29bUs7fDJp
   jAF7FoWtJr3JMcwy7D0GOCC+m2o2jk/jdDELlrXW/cW+fnY66BSU1zbQl
   qedxo5r54FVa2ntq2zqjF9CwhQrsgpoJbw63RWcvr4TjTRx4UFMOvF7zF
   G+/Nddhhm976b/qsVcgTEFi9OohPAIKZdNrGcd5bNGaFoRNtM4PCTfdan
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10768"; a="354715284"
X-IronPort-AV: E=Sophos;i="6.01,198,1684825200"; 
   d="scan'208";a="354715284"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jul 2023 23:01:56 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10768"; a="756643382"
X-IronPort-AV: E=Sophos;i="6.01,198,1684825200"; 
   d="scan'208";a="756643382"
Received: from fyin-dev.sh.intel.com ([10.239.159.32])
  by orsmga001.jf.intel.com with ESMTP; 11 Jul 2023 23:01:53 -0700
From:   Yin Fengwei <fengwei.yin@intel.com>
To:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        akpm@linux-foundation.org, yuzhao@google.com, willy@infradead.org,
        david@redhat.com, ryan.roberts@arm.com, shy828301@gmail.com
Cc:     fengwei.yin@intel.com
Subject: [RFC PATCH v2 1/3] mm: add functions folio_in_range() and folio_within_vma()
Date:   Wed, 12 Jul 2023 14:01:42 +0800
Message-Id: <20230712060144.3006358-2-fengwei.yin@intel.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230712060144.3006358-1-fengwei.yin@intel.com>
References: <20230712060144.3006358-1-fengwei.yin@intel.com>
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

Also a helper function folio_within_vma() to check whether folio
is in the range of vma based on folio_in_range().

Signed-off-by: Yin Fengwei <fengwei.yin@intel.com>
---
 mm/internal.h | 32 ++++++++++++++++++++++++++++++++
 1 file changed, 32 insertions(+)

diff --git a/mm/internal.h b/mm/internal.h
index 483add0bfb289..c7dd15d8de3ef 100644
--- a/mm/internal.h
+++ b/mm/internal.h
@@ -585,6 +585,38 @@ extern long faultin_vma_page_range(struct vm_area_struct *vma,
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
+static inline bool
+folio_within_vma(struct folio *folio, struct vm_area_struct *vma)
+{
+	return folio_in_range(folio, vma, vma->vm_start, vma->vm_end);
+}
+
 /*
  * mlock_vma_folio() and munlock_vma_folio():
  * should be called with vma's mmap_lock held for read or write,
-- 
2.39.2

