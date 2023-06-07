Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 17C2E7262BC
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Jun 2023 16:25:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241109AbjFGOZA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Jun 2023 10:25:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241129AbjFGOYx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Jun 2023 10:24:53 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99E2C1BF0
        for <linux-kernel@vger.kernel.org>; Wed,  7 Jun 2023 07:24:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1686147885; x=1717683885;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=qOS33Z45j4TI2OKl5FBe0hF56pv3kMKz0o+IBc1D+4Q=;
  b=RpYTNEWfcZ2jZofeS5CMYpy5yn6+x2gEl8HsscDG+nmEN4B/5do9n+la
   SsRJYmxn1NmCkpJaN4nuD6Ltw9eMZ6QbWCeS+mTBMa4jz/5QJaZAfJ0h3
   keAbUWsv7IOvd37aBF5GY8rw+91BJFwAj00VdAQzl4AGqeOSCWah/tcvu
   9EBdMo770zMrdyZbP8qdZsVvM//V269TQjkgY2CNY9RKOcptV/3asqiyw
   zIgHLpEWlJYzFV6NnAFFioD/WHggfo3LZvWgdaUkHNO+wMMGR7hmlNQPW
   Dr4Gjqx2lqB1D/ThtXu7g6CinKMSHIaaLkq9DM/vMYS02FA5O66RAgY0N
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10734"; a="337361334"
X-IronPort-AV: E=Sophos;i="6.00,224,1681196400"; 
   d="scan'208";a="337361334"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jun 2023 07:23:27 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10734"; a="659973610"
X-IronPort-AV: E=Sophos;i="6.00,224,1681196400"; 
   d="scan'208";a="659973610"
Received: from linux-pnp-server-20.sh.intel.com ([10.239.146.185])
  by orsmga003.jf.intel.com with ESMTP; 07 Jun 2023 07:23:23 -0700
From:   Yu Ma <yu.ma@intel.com>
To:     yu.ma@intel.com
Cc:     Liam.Howlett@Oracle.com, akpm@linux-foundation.org,
        dan.j.williams@intel.com, dave.hansen@intel.com,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        lipeng.zhu@intel.com, pan.deng@intel.com, shakeelb@google.com,
        tianyou.li@intel.com, tim.c.chen@intel.com,
        tim.c.chen@linux.intel.com
Subject: [PATCH v2] percpu-internal/pcpu_chunk: Re-layout pcpu_chunk structure to reduce false sharing
Date:   Wed,  7 Jun 2023 10:50:09 -0400
Message-Id: <20230607145009.58899-1-yu.ma@intel.com>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20230606125404.95256-1-yu.ma@intel.com>
References: <20230606125404.95256-1-yu.ma@intel.com>
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
 mm/percpu-internal.h | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/mm/percpu-internal.h b/mm/percpu-internal.h
index f9847c131998..ecc7be1ec876 100644
--- a/mm/percpu-internal.h
+++ b/mm/percpu-internal.h
@@ -41,10 +41,16 @@ struct pcpu_chunk {
 	struct list_head	list;		/* linked to pcpu_slot lists */
 	int			free_bytes;	/* free bytes in the chunk */
 	struct pcpu_block_md	chunk_md;
+	unsigned long		*bound_map;	/* boundary map */
+	
+	/*
+	 * To reduce false sharing, current layout is optimized to make sure
+	 * base_addr locate in the different cacheline with free_bytes and
+	 * chunk_md.
+	 */
 	void			*base_addr;	/* base address of this chunk */
 
 	unsigned long		*alloc_map;	/* allocation map */
-	unsigned long		*bound_map;	/* boundary map */
 	struct pcpu_block_md	*md_blocks;	/* metadata blocks */
 
 	void			*data;		/* chunk data */
-- 
2.39.3

