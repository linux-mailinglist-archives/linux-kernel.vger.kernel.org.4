Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA5F472A886
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Jun 2023 04:40:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232621AbjFJCky (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Jun 2023 22:40:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229606AbjFJCkw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Jun 2023 22:40:52 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EDC892139
        for <linux-kernel@vger.kernel.org>; Fri,  9 Jun 2023 19:40:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1686364850; x=1717900850;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=8jqWFsMfbwzSoZ5zFqaX3i8XF+2E5kDtejebv/Ye4BE=;
  b=RhgUI93DOudja0u48wnxJ8UwlRk6pclfA34FK2cPXgo8bS9lESdwPuQ1
   YpfNNjGWuunLXb4BX6nlbvy4ppKgMf7pfJ0DwfdiPKi7qFf4vjoNRA5S4
   rL6jIwzFvmluAtH3USBkkbgQMcy5IkyurRSNIe87RZnph0Iacuj9/93k9
   DH+uJ8mFbvE1PwfrRJZdurAqCh0B/T5QlT7BUrVFhIAuGB24qKR0ND2Mb
   r//wqzM+CJCxOE4hKIvwumvO4sB+vnFi5wbhDEtpX4EECtOC7oryJpYX/
   VdotuupSLg8xTcBuslTLlrJ8yQUQJ2uv+dZQrb28wNN9FSc9aPZmFYwTY
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10736"; a="337361525"
X-IronPort-AV: E=Sophos;i="6.00,231,1681196400"; 
   d="scan'208";a="337361525"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jun 2023 19:40:50 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10736"; a="854935287"
X-IronPort-AV: E=Sophos;i="6.00,231,1681196400"; 
   d="scan'208";a="854935287"
Received: from linux-pnp-server-20.sh.intel.com ([10.239.146.185])
  by fmsmga001.fm.intel.com with ESMTP; 09 Jun 2023 19:40:44 -0700
From:   Yu Ma <yu.ma@intel.com>
To:     dennis@kernel.org, Liam.Howlett@oracle.com
Cc:     akpm@linux-foundation.org, dan.j.williams@intel.com,
        dave.hansen@intel.com, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, lipeng.zhu@intel.com, pan.deng@intel.com,
        shakeelb@google.com, tianyou.li@intel.com, tim.c.chen@intel.com,
        tim.c.chen@linux.intel.com, yu.ma@intel.com
Subject: [PATCH v3] percpu-internal/pcpu_chunk: Re-layout pcpu_chunk structure to reduce false sharing
Date:   Fri,  9 Jun 2023 23:07:30 -0400
Message-Id: <20230610030730.110074-1-yu.ma@intel.com>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <ZINtij2HhIu9h9Wx@V92F7Y9K0C.lan>
References: <ZINtij2HhIu9h9Wx@V92F7Y9K0C.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
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
 mm/percpu-internal.h | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/mm/percpu-internal.h b/mm/percpu-internal.h
index f9847c131998..7f108b25bb93 100644
--- a/mm/percpu-internal.h
+++ b/mm/percpu-internal.h
@@ -41,10 +41,17 @@ struct pcpu_chunk {
 	struct list_head	list;		/* linked to pcpu_slot lists */
 	int			free_bytes;	/* free bytes in the chunk */
 	struct pcpu_block_md	chunk_md;
-	void			*base_addr;	/* base address of this chunk */
+	unsigned long		*bound_map;	/* boundary map */
+	
+	/* 
+	 * base_addr is the base address of this chunk.
+	 * To reduce false sharing, current layout is optimized to make sure
+	 * base_addr locate in the different cacheline with free_bytes and
+	 * chunk_md.
+	 */
+	void			*base_addr ____cacheline_aligned_in_smp;
 
 	unsigned long		*alloc_map;	/* allocation map */
-	unsigned long		*bound_map;	/* boundary map */
 	struct pcpu_block_md	*md_blocks;	/* metadata blocks */
 
 	void			*data;		/* chunk data */
-- 
2.39.3

