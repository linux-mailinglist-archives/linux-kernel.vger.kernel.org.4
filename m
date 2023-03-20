Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 08D7A6C0BA9
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Mar 2023 09:00:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230263AbjCTIAA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Mar 2023 04:00:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230281AbjCTH74 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Mar 2023 03:59:56 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C08D12CCA
        for <linux-kernel@vger.kernel.org>; Mon, 20 Mar 2023 00:59:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1679299195; x=1710835195;
  h=from:to:cc:subject:references:date:in-reply-to:
   message-id:mime-version;
  bh=YVw9SzaqPt5R2Jh/Y/jSV9pqtQ0IhNlz8O+4tLs+q/8=;
  b=cBwN769AcZm4EZr1GGuTqVfp/L+ckimfOU/CV2/pV03YMCyi0SSFW9zd
   ekjIozyLJTNMDxBm6fSfj/7I8vHO2AsT7bE9BvbYvWsk5bABMCplCn4yN
   i/4vOtepL3dIT7zuQcAP00iedYyhzQ4Repjqc4/b1dC9fJ1Gr8bkEVwKB
   iBCQAE2i634qf/kdAyu2vkjA1GBB2mv6EYQjodIjtBx47ug/vS++mNGyD
   y3fK3DE2h4Mb5jZnc/2C8b2IX9FKUt0W7qrqfpzvBJVQ6f5vErk6huRVX
   T08kxj2rGMY47vrmcUs0vbMSpwlIsAeKDBS9qYyWJUYvmJPvXoAVKzEpr
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10654"; a="424875548"
X-IronPort-AV: E=Sophos;i="5.98,274,1673942400"; 
   d="scan'208";a="424875548"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Mar 2023 00:59:54 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10654"; a="1010375162"
X-IronPort-AV: E=Sophos;i="5.98,274,1673942400"; 
   d="scan'208";a="1010375162"
Received: from yhuang6-desk2.sh.intel.com (HELO yhuang6-desk2.ccr.corp.intel.com) ([10.238.208.55])
  by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Mar 2023 00:59:50 -0700
From:   "Huang, Ying" <ying.huang@intel.com>
To:     kernel test robot <yujie.liu@intel.com>
Cc:     <oe-lkp@lists.linux.dev>, <lkp@intel.com>,
        <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Xin Hao <xhao@linux.alibaba.com>, Zi Yan <ziy@nvidia.com>,
        Yang Shi <shy828301@gmail.com>,
        Baolin Wang <baolin.wang@linux.alibaba.com>,
        Oscar Salvador <osalvador@suse.de>,
        "Matthew Wilcox" <willy@infradead.org>,
        Bharata B Rao <bharata@amd.com>,
        "Alistair Popple" <apopple@nvidia.com>,
        Minchan Kim <minchan@kernel.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Hyeonggon Yoo <42.hyeyoo@gmail.com>, <linux-mm@kvack.org>,
        <feng.tang@intel.com>, <zhengjun.xing@linux.intel.com>,
        <fengwei.yin@intel.com>
Subject: Re: [linus:master] [migrate_pages] 7e12beb8ca:
 vm-scalability.throughput -3.4% regression
References: <202303192325.ecbaf968-yujie.liu@intel.com>
Date:   Mon, 20 Mar 2023 15:58:42 +0800
In-Reply-To: <202303192325.ecbaf968-yujie.liu@intel.com> (kernel test robot's
        message of "Mon, 20 Mar 2023 09:12:16 +0800")
Message-ID: <87o7onua4t.fsf@yhuang6-desk2.ccr.corp.intel.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=ascii
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Yujie,

kernel test robot <yujie.liu@intel.com> writes:

> Hello,
>
> FYI, we noticed a -3.4% regression of vm-scalability.throughput due to commit:
>
> commit: 7e12beb8ca2ac98b2ec42e0ea4b76cdc93b58654 ("migrate_pages: batch flushing TLB")
> https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git master
>
> in testcase: vm-scalability
> on test machine: 96 threads 2 sockets Intel(R) Xeon(R) Platinum 8260L CPU @ 2.40GHz (Cascade Lake) with 128G memory
> with following parameters:
>
> 	runtime: 300s
> 	size: 512G
> 	test: anon-cow-rand-mt
> 	cpufreq_governor: performance
>
> test-description: The motivation behind this suite is to exercise functions and regions of the mm/ of the Linux kernel which are of interest to us.
> test-url: https://git.kernel.org/cgit/linux/kernel/git/wfg/vm-scalability.git/
>
>
> If you fix the issue, kindly add following tag
> | Reported-by: kernel test robot <yujie.liu@intel.com>
> | Link: https://lore.kernel.org/oe-lkp/202303192325.ecbaf968-yujie.liu@intel.com
>

Thanks a lot for report!  Can you try whether the debug patch as
below can restore the regression?

Best Regards,
Huang, Ying

-------------------------------------8<------------------------------------
From 1ac61967b54bbdc1ca20af16f9dfb2507a4d4811 Mon Sep 17 00:00:00 2001
From: Huang Ying <ying.huang@intel.com>
Date: Mon, 20 Mar 2023 15:48:39 +0800
Subject: [PATCH] dbg, rmap: avoid flushing TLB in batch if PTE is inaccessible

Signed-off-by: "Huang, Ying" <ying.huang@intel.com>
---
 mm/rmap.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/mm/rmap.c b/mm/rmap.c
index 8632e02661ac..3c7c43642d7c 100644
--- a/mm/rmap.c
+++ b/mm/rmap.c
@@ -1582,7 +1582,8 @@ static bool try_to_unmap_one(struct folio *folio, struct vm_area_struct *vma,
 				 */
 				pteval = ptep_get_and_clear(mm, address, pvmw.pte);
 
-				set_tlb_ubc_flush_pending(mm, pte_dirty(pteval));
+				if (pte_accessible(mm, pteval))
+					set_tlb_ubc_flush_pending(mm, pte_dirty(pteval));
 			} else {
 				pteval = ptep_clear_flush(vma, address, pvmw.pte);
 			}
@@ -1963,7 +1964,8 @@ static bool try_to_migrate_one(struct folio *folio, struct vm_area_struct *vma,
 				 */
 				pteval = ptep_get_and_clear(mm, address, pvmw.pte);
 
-				set_tlb_ubc_flush_pending(mm, pte_dirty(pteval));
+				if (pte_accessible(mm, pteval))
+					set_tlb_ubc_flush_pending(mm, pte_dirty(pteval));
 			} else {
 				pteval = ptep_clear_flush(vma, address, pvmw.pte);
 			}
-- 
2.30.2

