Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A799572420B
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Jun 2023 14:27:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236341AbjFFM12 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Jun 2023 08:27:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229835AbjFFM10 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Jun 2023 08:27:26 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9ABA210C3
        for <linux-kernel@vger.kernel.org>; Tue,  6 Jun 2023 05:27:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1686054445; x=1717590445;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=b4k9x25/7qcaY8sBpX9kyB98GRPI8/m37GY4183rlNc=;
  b=SCmyGn10V7dabYRBqr1C/eoHZ8KzUfqbOB23qFOgJ7HjAIv8xqE9cxbX
   aQWlZTeUC29vylvaYAQE6Fpqk4jaA8stWt27y3seWt+lYAK5Sj9TcfhwE
   u22klB+I1GVMH86myhdtNBtuPLkf3ztmgDxtdgoOvbt7BYLFJOAKyi8es
   Ey6DIR21vExz9koyCuLfwP8IX2RzdNE5qA/XxFV1bWBB4vZls34c1DKlh
   fzYDg1ZFlxEEqNEdw6rwBnccy4Q8yMBV96U9QoaGfF3z5bWTj15NWe4GQ
   vzMpNL8tccwjozYVtA4/8osp6Op+bAJl5PGOuGwGpYVLBJD96NVkTg8DU
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10732"; a="422479137"
X-IronPort-AV: E=Sophos;i="6.00,221,1681196400"; 
   d="scan'208";a="422479137"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jun 2023 05:27:25 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10732"; a="1039156958"
X-IronPort-AV: E=Sophos;i="6.00,221,1681196400"; 
   d="scan'208";a="1039156958"
Received: from linux-pnp-server-20.sh.intel.com ([10.239.146.185])
  by fmsmga005.fm.intel.com with ESMTP; 06 Jun 2023 05:27:22 -0700
From:   Yu Ma <yu.ma@intel.com>
To:     akpm@linux-foundation.org, tim.c.chen@intel.com
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        dave.hansen@intel.com, dan.j.williams@intel.com,
        shakeelb@google.com, Liam.Howlett@Oracle.com, pan.deng@intel.com,
        tianyou.li@intel.com, lipeng.zhu@intel.com,
        tim.c.chen@linux.intel.com, yu.ma@intel.com
Subject: [PATCH] percpu-internal/pcpu_chunk: Re-layout pcpu_chunk structure to reduce false sharing
Date:   Tue,  6 Jun 2023 08:54:04 -0400
Message-Id: <20230606125404.95256-1-yu.ma@intel.com>
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

When running UnixBench/Execl throughput case, false sharing is observed
due to frequent read on base_addr and write on free_bytes, chunk_md.

UnixBench/Execl represents a class of workload where bash scripts
are spawned frequently to do some short jobs. It will do system call on
execl frequently, and execl will call mm_init to initialize mm_struct
of the process. mm_init will call __percpu_counter_init for
percpu_counters initialization. Then pcpu_alloc is called to read
the base_addr of pcpu_chunk for memory allocation. Inside pcpu_alloc,
it will call pcpu_alloc_area  to allocate memory from a specified chunk.
This function will update "free_bytes" and "chunk_md" to record the
rest free bytes and other meta data for this chunk. Correspondingly,
pcpu_free_area will also update these 2 members when free memory.
Call trace from perf is as below:
+   57.15%  0.01%  execl   [kernel.kallsyms] [k] __percpu_counter_init
+   57.13%  0.91%  execl   [kernel.kallsyms] [k] pcpu_alloc
-   55.27% 54.51%  execl   [kernel.kallsyms] [k] osq_lock
   - 53.54% 0x654278696e552f34
        main
        __execve
        entry_SYSCALL_64_after_hwframe
        do_syscall_64
        __x64_sys_execve
        do_execveat_common.isra.47
        alloc_bprm
        mm_init
        __percpu_counter_init
        pcpu_alloc
      - __mutex_lock.isra.17

In current pcpu_chunk layout, ‘base_addr’ is in the same cache line
with ‘free_bytes’ and ‘chunk_md’, and ‘base_addr’ is at the 
last 8 bytes. This patch moves ‘bound_map’ up to ‘base_addr’,
to let ‘base_addr’ locate in a new cacheline.

With this change, on Intel Sapphire Rapids 112C/224T platform,
based on v6.4-rc4, the 160 parallel score improves by 24%.

Reviewed-by: Tim Chen <tim.c.chen@linux.intel.com>
Signed-off-by: Yu Ma <yu.ma@intel.com>
---
 mm/percpu-internal.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/percpu-internal.h b/mm/percpu-internal.h
index f9847c131998..981eeb2ad0a9 100644
--- a/mm/percpu-internal.h
+++ b/mm/percpu-internal.h
@@ -41,10 +41,10 @@ struct pcpu_chunk {
 	struct list_head	list;		/* linked to pcpu_slot lists */
 	int			free_bytes;	/* free bytes in the chunk */
 	struct pcpu_block_md	chunk_md;
+	unsigned long		*bound_map;	/* boundary map */
 	void			*base_addr;	/* base address of this chunk */
 
 	unsigned long		*alloc_map;	/* allocation map */
-	unsigned long		*bound_map;	/* boundary map */
 	struct pcpu_block_md	*md_blocks;	/* metadata blocks */
 
 	void			*data;		/* chunk data */
-- 
2.39.3

