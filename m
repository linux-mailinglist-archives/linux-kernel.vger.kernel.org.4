Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 788D37241FD
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Jun 2023 14:23:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234238AbjFFMXH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Jun 2023 08:23:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230297AbjFFMXD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Jun 2023 08:23:03 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 244C510C6
        for <linux-kernel@vger.kernel.org>; Tue,  6 Jun 2023 05:23:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1686054182; x=1717590182;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=RbqQ3EfGHI6UTyKDi2aKopvN4mTn1VMxbyOUyuWsAiY=;
  b=QgVSczTxWl41Z56LIzmb6QAiyEqSDMRfmC9fXS9NAhmZcdA4jimFvviC
   0gVzhlhizqqVLf27SsTflOExB/LMx214ROjnezhcnTOGiJ4MWj3F8NUVl
   a5dk4EdS7U03jkfmjOW6CavrC/NIc/mpqXmZMfRufn/sh7matRXVoh55+
   0o8LD1xZF52SO3HehqBjpcU2pht7QYCQqEgNGaioigfsJ5+IakaP0D44o
   ukCe5iW0DXX2KGFpY5F9FzrhW7J/HPG5vl4vQXdFq7OmQ+yNEM5duwNp4
   DA8oyyyk51OiRNsPPKP+J+1tnKqvuAH///k/XAHYF7++Z1RZMAgJ13glR
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10732"; a="422478429"
X-IronPort-AV: E=Sophos;i="6.00,221,1681196400"; 
   d="scan'208";a="422478429"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jun 2023 05:23:01 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10732"; a="1039155849"
X-IronPort-AV: E=Sophos;i="6.00,221,1681196400"; 
   d="scan'208";a="1039155849"
Received: from linux-pnp-server-20.sh.intel.com ([10.239.146.185])
  by fmsmga005.fm.intel.com with ESMTP; 06 Jun 2023 05:22:58 -0700
From:   Yu Ma <yu.ma@intel.com>
To:     akpm@linux-foundation.org, tim.c.chen@intel.com
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        dave.hansen@intel.com, dan.j.williams@intel.com,
        shakeelb@google.com, Liam.Howlett@Oracle.com, pan.deng@intel.com,
        tianyou.li@intel.com, lipeng.zhu@intel.com,
        tim.c.chen@linux.intel.com, yu.ma@intel.com
Subject: [PATCH] mm/mmap: move vma operations to mm_struct out of the critical section of file mapping lock
Date:   Tue,  6 Jun 2023 08:49:39 -0400
Message-Id: <20230606124939.93561-1-yu.ma@intel.com>
X-Mailer: git-send-email 2.39.3
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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
 mm/mmap.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/mm/mmap.c b/mm/mmap.c
index 13678edaa22c..0e694a0433bc 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -2711,12 +2711,10 @@ unsigned long mmap_region(struct file *file, unsigned long addr,
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

