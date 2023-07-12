Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E64A750B10
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jul 2023 16:31:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233070AbjGLOa6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jul 2023 10:30:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233011AbjGLOax (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jul 2023 10:30:53 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 175751BE8
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jul 2023 07:30:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1689172245; x=1720708245;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=5HuHECwAhlLAZmEKECs99DXvcfxOeVUXcj3HB1kzxlY=;
  b=cKpWKxtPpPKfS845FMITUcckeAGgLNQ9c9t7f8VH4V0i6KQDoh4dUXAt
   teVyVRl2c3MQuxLocjvYek64ydFQClhzJqu3ruvckCPFAVsXd20yADm3l
   zQN7MrOd/AfNiRH4pBfAUR5eLhOkRGFK2OQPA9XS95lEO/pcFr1ap0Kup
   ABoE31WMp+B44z190tJOKfJ04Krc5G24te68ynBeTkbcMBNngd6/wYwYv
   ag4yl0fCkAR85qr+AjcBJqLvWq0iUfWCT3GMu7O7DFkAAfKJ+VEjuepbw
   M0iVyQMyAjSMKDrcK8Pq5qHvGUyMtTCQ5Q3bHF7AzwY4dkMiJLaea6jfH
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10769"; a="363768524"
X-IronPort-AV: E=Sophos;i="6.01,199,1684825200"; 
   d="scan'208";a="363768524"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jul 2023 07:30:42 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10769"; a="724893684"
X-IronPort-AV: E=Sophos;i="6.01,199,1684825200"; 
   d="scan'208";a="724893684"
Received: from linux-pnp-server-20.sh.intel.com ([10.239.146.185])
  by fmsmga007.fm.intel.com with ESMTP; 12 Jul 2023 07:30:39 -0700
From:   Yu Ma <yu.ma@intel.com>
To:     akpm@linux-foundation.org, Liam.Howlett@Oracle.com,
        kirill@shutemov.name, yu.ma@intel.com
Cc:     dan.j.williams@intel.com, dave.hansen@intel.com,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        lipeng.zhu@intel.com, pan.deng@intel.com, shakeelb@google.com,
        tianyou.li@intel.com, tim.c.chen@intel.com,
        tim.c.chen@linux.intel.com
Subject: [PATCH v3] mm/mmap: move vma operations to mm_struct out of the  critical section of file mapping lock
Date:   Wed, 12 Jul 2023 10:57:39 -0400
Message-Id: <20230712145739.604215-1-yu.ma@intel.com>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20230711112824.e559065488b08ce649cccfd7@linux-foundation.org>
References: <20230711112824.e559065488b08ce649cccfd7@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
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
obvious performance gain on v6.5-rc1 due to regression of this benchmark
from this commit f1a7941243c102a44e8847e3b94ff4ff3ec56f25 (mm: convert
mm's rss stats into percpu_counter). Related discussion and conclusion
can be referred at the mail thread initiated by 0day as below:
Link: https://lore.kernel.org/linux-mm/a4aa2e13-7187-600b-c628-7e8fb108def0@intel.com/

Reviewed-by: Tim Chen <tim.c.chen@linux.intel.com>
Signed-off-by: Yu Ma <yu.ma@intel.com>
---
v2 -> v3: Rebase the patch to v6.5-rc1, which includes 1c7873e3364 (mm:
lock newly mapped VMA with corrected ordering), and update commit
message to status on v6.5-rc1
v1 -> v2: Update vma_link() to reduce the hold time on file mapping lock
as well. Based on v6.5-rc1, vma_link() is only called by
insert_vm_struct () and copy_vma(), which are both protected by mmap_lock.
---
---
 mm/mmap.c | 11 +++--------
 1 file changed, 3 insertions(+), 8 deletions(-)

diff --git a/mm/mmap.c b/mm/mmap.c
index 3eda23c9ebe7..ce31aec82e82 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -412,14 +412,11 @@ static int vma_link(struct mm_struct *mm, struct vm_area_struct *vma)
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
@@ -2811,12 +2808,10 @@ unsigned long mmap_region(struct file *file, unsigned long addr,
 
 	/* Lock the VMA since it is modified after insertion into VMA tree */
 	vma_start_write(vma);
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

