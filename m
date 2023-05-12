Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 83981700154
	for <lists+linux-kernel@lfdr.de>; Fri, 12 May 2023 09:21:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240318AbjELHVg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 May 2023 03:21:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240193AbjELHUv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 May 2023 03:20:51 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E87D51992
        for <linux-kernel@vger.kernel.org>; Fri, 12 May 2023 00:20:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1683876048; x=1715412048;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=vbfbV3YIRAiL+Me0xGu53szMmW7EztoemLnA/EVynh4=;
  b=MwrY6Owerp5XKQRhA32Uw9W6LaCWSezgBcSt49y10Rft1+oobM3WVZPg
   cmKGIu/BSUWCn2qCTls6snwXrfLXPh1GbGwYJRhOzAOAafAEafDyV5aYc
   sGuz/RAhivz7QEF7K91vgutdutzcjT7pd3iVDbIGXbZZwbtNqtm6Wr39r
   33raf8DAD15A8F90fGhh+Tcl1+va5DVNzB8zKt6lH5xp1f5DylyDoUncn
   FUMzQJJ3Fp1Vuv5mcc9LtrQtN+WPz1DrC9lQ0+sds1/XWl0sq9tRgIK19
   /qSv6c9esN3DhrtOV7E3nVEWBOq1CIV9k6/y0OMGybOyr7J1CG4iqhQ9V
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10707"; a="349566264"
X-IronPort-AV: E=Sophos;i="5.99,269,1677571200"; 
   d="scan'208";a="349566264"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 May 2023 00:20:48 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10707"; a="765073979"
X-IronPort-AV: E=Sophos;i="5.99,269,1677571200"; 
   d="scan'208";a="765073979"
Received: from junxiaochang.bj.intel.com ([10.238.154.225])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 May 2023 00:20:46 -0700
From:   Junxiao Chang <junxiao.chang@intel.com>
To:     akpm@linux-foundation.org, kirill.shutemov@linux.intel.com,
        mhocko@suse.com, jmarchan@redhat.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, mike.kravetz@oracle.com,
        muchun.song@linux.dev
Cc:     junxiao.chang@intel.com
Subject: [PATCH] mm: fix hugetlb page unmap count balance issue
Date:   Fri, 12 May 2023 15:20:36 +0800
Message-Id: <20230512072036.1027784-1-junxiao.chang@intel.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

hugetlb page usually is mapped with pmd, but occasionally it might be
mapped with pte. QEMU can use udma-buf to create host dmabufs for guest
framebuffers. When QEMU is launched with parameter "hugetlb=on",
udmabuffer driver maps hugetlb page with pte in page fault handler.
Call chain looks like:

page_add_file_rmap
do_set_pte
finish_fault
__do_fault -> udmabuf_vm_fault, it maps hugetlb page here.
do_read_fault

In function page_add_file_rmap, compound is false since it is pte mapping.

When qemu exits and page is unmapped in function page_remove_rmap, the
hugetlb page should not be handled in pmd way.

This change is to check compound parameter as well as hugetlb flag. It
fixes below kernel bug which is reproduced with 6.3 kernel:

[  114.027754] BUG: Bad page cache in process qemu-system-x86  pfn:37aa00
[  114.034288] page:000000000dd2153b refcount:514 mapcount:-4 mapping:000000004b01ca30 index:0x13800 pfn:0x37aa00
[  114.044277] head:000000000dd2153b order:9 entire_mapcount:-4 nr_pages_mapped:4 pincount:512
[  114.052623] aops:hugetlbfs_aops ino:6f93
[  114.056552] flags: 0x17ffffc0010001(locked|head|node=0|zone=2|lastcpupid=0x1fffff)
[  114.064115] raw: 0017ffffc0010001 fffff7338deb0008 fffff7338dea0008 ffff98dc855ea870
[  114.071847] raw: 000000000000009c 0000000000000002 00000202ffffffff 0000000000000000
[  114.079572] page dumped because: still mapped when deleted
[  114.085048] CPU: 0 PID: 3122 Comm: qemu-system-x86 Tainted: G    BU  W   E      6.3.0-v3+ #62
[  114.093566] Hardware name: Intel Corporation Alder Lake Client Platform DDR5 SODIMM SBS RVP, BIOS ADLPFWI1.R00.3084.D89.2303211034 03/21/2023
[  114.106839] Call Trace:
[  114.109291]  <TASK>
[  114.111405]  dump_stack_lvl+0x4c/0x70
[  114.115073]  dump_stack+0x14/0x20
[  114.118395]  filemap_unaccount_folio+0x159/0x220
[  114.123021]  filemap_remove_folio+0x54/0x110
[  114.127295]  remove_inode_hugepages+0x111/0x5b0
[  114.131834]  hugetlbfs_evict_inode+0x23/0x50
[  114.136111]  evict+0xcd/0x1e0
[  114.139083]  iput.part.0+0x183/0x1e0
[  114.142663]  iput+0x20/0x30
[  114.145466]  dentry_unlink_inode+0xcc/0x130
[  114.149655]  __dentry_kill+0xec/0x1a0
[  114.153325]  dput+0x1ca/0x3c0
[  114.156293]  __fput+0xf4/0x280
[  114.159357]  ____fput+0x12/0x20
[  114.162502]  task_work_run+0x62/0xa0
[  114.166088]  do_exit+0x352/0xae0
[  114.169321]  do_group_exit+0x39/0x90
[  114.172892]  get_signal+0xa09/0xa30
[  114.176391]  arch_do_signal_or_restart+0x33/0x280
[  114.181098]  exit_to_user_mode_prepare+0x11f/0x190
[  114.185893]  syscall_exit_to_user_mode+0x2a/0x50
[  114.190509]  do_syscall_64+0x4c/0x90
[  114.194095]  entry_SYSCALL_64_after_hwframe+0x72/0xdc

Fixes: 53f9263baba6 ("mm: rework mapcount accounting to enable 4k mapping of THPs")
Signed-off-by: Junxiao Chang <junxiao.chang@intel.com>
---
 mm/rmap.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/mm/rmap.c b/mm/rmap.c
index 19392e090bec6..b42fc0389c243 100644
--- a/mm/rmap.c
+++ b/mm/rmap.c
@@ -1377,9 +1377,9 @@ void page_remove_rmap(struct page *page, struct vm_area_struct *vma,
 
 	VM_BUG_ON_PAGE(compound && !PageHead(page), page);
 
-	/* Hugetlb pages are not counted in NR_*MAPPED */
-	if (unlikely(folio_test_hugetlb(folio))) {
-		/* hugetlb pages are always mapped with pmds */
+	/* Hugetlb pages usually are not counted in NR_*MAPPED */
+	if (unlikely(folio_test_hugetlb(folio) && compound)) {
+		/* hugetlb pages are mapped with pmds */
 		atomic_dec(&folio->_entire_mapcount);
 		return;
 	}
-- 
2.34.1

