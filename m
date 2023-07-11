Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE6AC74F619
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jul 2023 18:53:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231414AbjGKQxa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jul 2023 12:53:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230155AbjGKQx2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jul 2023 12:53:28 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 966CDE75
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jul 2023 09:53:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1689094407; x=1720630407;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=TrplBJ3bzzs7m5iDqf6Oh6aYMUB0SNPyHYHI7Jj6/7o=;
  b=kumpe81S7q6IbG60XE0ZyNYdohOfCvobQ1eIJxAv9SfczYKlaFTrr1Mb
   eq5T7Ov1TElsuiyIiS2EZOcPrROUGZqwwAsrvzgxaumydWsVDf9wCIrEF
   XkGWq303G3K+5L6NG+frQI1USFPIjRTAe0l/IbaTJ+wSTR0rgeFezJsW4
   TjQbL7NEVMrF8faVbOhgxL7SKtexZ3IOt/+lT6xEpn6NLUyKrC1bwBBLt
   +0+0X/FwEM9okUiBXeE1j0FMHx8RKgjGFXj2OC1G7QiQsyzCz2DBgVOwZ
   UL0DBw52CUH9itgVuf1ZSEbq+Hdwf54EX66jZpC52naVOpuvlVIyCmSxD
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10768"; a="354539101"
X-IronPort-AV: E=Sophos;i="6.01,197,1684825200"; 
   d="scan'208";a="354539101"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jul 2023 09:53:23 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10768"; a="967873360"
X-IronPort-AV: E=Sophos;i="6.01,197,1684825200"; 
   d="scan'208";a="967873360"
Received: from linux-pnp-server-20.sh.intel.com ([10.239.146.185])
  by fmsmga006.fm.intel.com with ESMTP; 11 Jul 2023 09:53:18 -0700
From:   Yu Ma <yu.ma@intel.com>
To:     yu.ma@intel.com, Liam.Howlett@Oracle.com, kirill@shutemov.name,
        akpm@linux-foundation.org
Cc:     dan.j.williams@intel.com, dave.hansen@intel.com,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        lipeng.zhu@intel.com, pan.deng@intel.com, shakeelb@google.com,
        tianyou.li@intel.com, tim.c.chen@intel.com,
        tim.c.chen@linux.intel.com
Subject: [PATCH v2] mm/mmap: move vma operations to mm_struct out of the critical section of file mapping lock
Date:   Tue, 11 Jul 2023 13:20:20 -0400
Message-Id: <20230711172020.562250-1-yu.ma@intel.com>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <SN7PR11MB75902EEF55E7ABE8189C6CABE12CA@SN7PR11MB7590.namprd11.prod.outlook.com>
References: <SN7PR11MB75902EEF55E7ABE8189C6CABE12CA@SN7PR11MB7590.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

UnixBench/Execl represents a class of workload where bash scripts are
spawned frequently to do some short jobs. When running multiple parallel
tasks, hot osq_lock is observed from do_mmap and exit_mmap. Both of them
come from load_elf_binary through the call chain
"execl->do_execveat_common->bprm_execve->load_elf_binary". In do_mmap,it will
call mmap_region to create vma node, initialize it and insert it to vma
maintain structure in mm_struct and i_mmap tree of the mapping file, then
increase map_count to record the number of vma nodes used. The hot osq_lock
is to protect operations on file’s i_mmap tree. For the mm_struct member
change like vma insertion and map_count update, they do not affect i_mmap
tree. Move those operations out of the lock's critical section, to reduce
hold time on the lock.

With this change, on Intel Sapphire Rapids 112C/224T platform, based on
v6.0-rc6, the 160 parallel score improves by 12%. The patch has no
obvious performance gain on v6.4-rc4 due to regression of this benchmark
from this commit f1a7941243c102a44e8847e3b94ff4ff3ec56f25 (mm: convert
mm's rss stats into percpu_counter). Related discussion and conclusion
can be referred at the mail thread initiated by 0day as below:
Link: https://lore.kernel.org/linux-mm/a4aa2e13-7187-600b-c628-7e8fb108def0@intel.com/

Reviewed-by: Tim Chen <tim.c.chen@linux.intel.com>
Signed-off-by: Yu Ma <yu.ma@intel.com>
---
v1 -> v2:
- Update vma_link() to reduce the hold time on file mapping lock as well.
Based on v6.4-rc7, vma_link() is only called by insert_vm_struct ()
and copy_vma(), which are both protected by mmap_lock.
---
 mm/mmap.c | 11 +++--------
 1 file changed, 3 insertions(+), 8 deletions(-)

diff --git a/mm/mmap.c b/mm/mmap.c
index d600404580b2..6f42ca2ab84a 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -444,14 +444,11 @@ static int vma_link(struct mm_struct *mm, struct vm_area_struct *vma)
 	if (vma_iter_prealloc(&vmi))
 		return -ENOMEM;
 
+	vma_iter_store(&vmi, vma);
+
 	if (vma->vm_file) {
 		mapping = vma->vm_file->f_mapping;
 		i_mmap_lock_write(mapping);
-	}
-
-	vma_iter_store(&vmi, vma);
-
-	if (mapping) {
 		__vma_link_file(vma, mapping);
 		i_mmap_unlock_write(mapping);
 	}
@@ -2708,12 +2705,10 @@ unsigned long mmap_region(struct file *file, unsigned long addr,
 	if (vma_iter_prealloc(&vmi))
 		goto close_and_free_vma;
 
-	if (vma->vm_file)
-		i_mmap_lock_write(vma->vm_file->f_mapping);
-
 	vma_iter_store(&vmi, vma);
 	mm->map_count++;
 	if (vma->vm_file) {
+		i_mmap_lock_write(vma->vm_file->f_mapping);
 		if (vma->vm_flags & VM_SHARED)
 			mapping_allow_writable(vma->vm_file->f_mapping);
 
-- 
2.39.3

