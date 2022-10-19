Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C82076037DF
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Oct 2022 04:06:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229862AbiJSCGf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Oct 2022 22:06:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229584AbiJSCGd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Oct 2022 22:06:33 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B24752E9EB
        for <linux-kernel@vger.kernel.org>; Tue, 18 Oct 2022 19:06:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1666145192; x=1697681192;
  h=from:to:cc:subject:references:date:in-reply-to:
   message-id:mime-version;
  bh=wJzOhrQWqcsuSASOVqRvm9mp5Iy2u4n3d/wxjNCySmY=;
  b=D7pjHk+Jnjh3GKowbN6J8mFGOq9d49cKkjoeIIt2IvfUM4W/QpN83L/6
   wsvBhfdt4jVFFTGN3flWnY7wo37/ZzCyb97rWLX2JL4EqWBtVNaPTJcoU
   7AxPaYzdx/+qkFxhQUUBZStGIBW38tT3kqIxrlonuA84IkOZbPDGbLiwi
   1U6GF3aK82J2UjuETHx+mkqpmsTPuSaWRvCZ+o1r4J6d59P2dPFUiHXFn
   23Ao92bd4sa+QMj7FHK5T82D368a1UjZnqbqStxKi2IVgfgqeLlwaHCYk
   zVqFZionukwP0V6KpuEt/AkJWNkFvwZWcozTJyxzqgLGfWWbXPw7KflQ5
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10504"; a="286001158"
X-IronPort-AV: E=Sophos;i="5.95,194,1661842800"; 
   d="scan'208";a="286001158"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Oct 2022 19:06:32 -0700
X-IronPort-AV: E=McAfee;i="6500,9779,10504"; a="874201142"
X-IronPort-AV: E=Sophos;i="5.95,194,1661842800"; 
   d="scan'208";a="874201142"
Received: from yhuang6-desk2.sh.intel.com (HELO yhuang6-desk2.ccr.corp.intel.com) ([10.238.208.55])
  by fmsmga006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Oct 2022 19:06:29 -0700
From:   "Huang, Ying" <ying.huang@intel.com>
To:     kernel test robot <yujie.liu@intel.com>
Cc:     Rik van Riel <riel@surriel.com>, <lkp@lists.01.org>,
        <lkp@intel.com>, Andrew Morton <akpm@linux-foundation.org>,
        Yang Shi <shy828301@gmail.com>,
        Matthew Wilcox <willy@infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>,
        <feng.tang@intel.com>, <zhengjun.xing@linux.intel.com>,
        <fengwei.yin@intel.com>
Subject: Re: [mm] f35b5d7d67: will-it-scale.per_process_ops -95.5% regression
References: <202210181535.7144dd15-yujie.liu@intel.com>
Date:   Wed, 19 Oct 2022 10:05:50 +0800
In-Reply-To: <202210181535.7144dd15-yujie.liu@intel.com> (kernel test robot's
        message of "Tue, 18 Oct 2022 16:44:59 +0800")
Message-ID: <87edv4r2ip.fsf@yhuang6-desk2.ccr.corp.intel.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=ascii
X-Spam-Status: No, score=-4.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Yujie,

>      32528  48%    +147.6%      80547  38%  numa-meminfo.node0.AnonHugePages
>      92821  23%     +59.3%     147839  28%  numa-meminfo.node0.AnonPages

The Anon pages allocated are much more than the parent commit.  This is
expected, because THP instead of normal page will be allocated for
aligned memory area.

>      95.23           -79.8       15.41   6%  perf-profile.calltrace.cycles-pp.__munmap
>      95.08           -79.7       15.40   6%  perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.__munmap
>      95.02           -79.6       15.39   6%  perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.__munmap
>      94.96           -79.6       15.37   6%  perf-profile.calltrace.cycles-pp.__x64_sys_munmap.do_syscall_64.entry_SYSCALL_64_after_hwframe.__munmap
>      94.95           -79.6       15.37   6%  perf-profile.calltrace.cycles-pp.__vm_munmap.__x64_sys_munmap.do_syscall_64.entry_SYSCALL_64_after_hwframe.__munmap
>      94.86           -79.5       15.35   6%  perf-profile.calltrace.cycles-pp.__do_munmap.__vm_munmap.__x64_sys_munmap.do_syscall_64.entry_SYSCALL_64_after_hwframe
>      94.38           -79.2       15.22   6%  perf-profile.calltrace.cycles-pp.unmap_region.__do_munmap.__vm_munmap.__x64_sys_munmap.do_syscall_64
>      42.74           -42.7        0.00        perf-profile.calltrace.cycles-pp.lru_add_drain.unmap_region.__do_munmap.__vm_munmap.__x64_sys_munmap
>      42.74           -42.7        0.00        perf-profile.calltrace.cycles-pp.lru_add_drain_cpu.lru_add_drain.unmap_region.__do_munmap.__vm_munmap
>      42.72           -42.7        0.00        perf-profile.calltrace.cycles-pp.folio_batch_move_lru.lru_add_drain_cpu.lru_add_drain.unmap_region.__do_munmap
>      41.84           -41.8        0.00        perf-profile.calltrace.cycles-pp.folio_lruvec_lock_irqsave.folio_batch_move_lru.lru_add_drain_cpu.lru_add_drain.unmap_region
>      41.70           -41.7        0.00        perf-profile.calltrace.cycles-pp._raw_spin_lock_irqsave.folio_lruvec_lock_irqsave.folio_batch_move_lru.lru_add_drain_cpu.lru_add_drain
>      41.62           -41.6        0.00        perf-profile.calltrace.cycles-pp.folio_lruvec_lock_irqsave.release_pages.tlb_batch_pages_flush.tlb_finish_mmu.unmap_region
>      41.55           -41.6        0.00        perf-profile.calltrace.cycles-pp.native_queued_spin_lock_slowpath._raw_spin_lock_irqsave.folio_lruvec_lock_irqsave.folio_batch_move_lru.lru_add_drain_cpu
>      41.52           -41.5        0.00        perf-profile.calltrace.cycles-pp._raw_spin_lock_irqsave.folio_lruvec_lock_irqsave.release_pages.tlb_batch_pages_flush.tlb_finish_mmu
>      41.28           -41.3        0.00        perf-profile.calltrace.cycles-pp.native_queued_spin_lock_slowpath._raw_spin_lock_irqsave.folio_lruvec_lock_irqsave.release_pages.tlb_batch_pages_flush

In the parent commit, most CPU cycles are used for contention on LRU lock.

>       0.00            +4.8        4.82   7%  perf-profile.calltrace.cycles-pp.do_huge_pmd_anonymous_page.__handle_mm_fault.handle_mm_fault.do_user_addr_fault.exc_page_fault
>       0.00            +4.9        4.88   7%  perf-profile.calltrace.cycles-pp.zap_huge_pmd.zap_pmd_range.unmap_page_range.unmap_vmas.unmap_region
>       0.00            +8.2        8.22   8%  perf-profile.calltrace.cycles-pp.native_queued_spin_lock_slowpath._raw_spin_lock.rmqueue_bulk.rmqueue.get_page_from_freelist
>       0.00            +8.2        8.23   8%  perf-profile.calltrace.cycles-pp._raw_spin_lock.rmqueue_bulk.rmqueue.get_page_from_freelist.__alloc_pages
>       0.00            +8.3        8.35   8%  perf-profile.calltrace.cycles-pp.native_queued_spin_lock_slowpath._raw_spin_lock.free_pcppages_bulk.free_unref_page.release_pages
>       0.00            +8.3        8.35   8%  perf-profile.calltrace.cycles-pp._raw_spin_lock.free_pcppages_bulk.free_unref_page.release_pages.tlb_batch_pages_flush
>       0.00            +8.4        8.37   8%  perf-profile.calltrace.cycles-pp.free_pcppages_bulk.free_unref_page.release_pages.tlb_batch_pages_flush.tlb_finish_mmu
>       0.00            +9.6        9.60   6%  perf-profile.calltrace.cycles-pp.free_unref_page.release_pages.tlb_batch_pages_flush.tlb_finish_mmu.unmap_region
>       0.00           +65.5       65.48   2%  perf-profile.calltrace.cycles-pp.clear_page_erms.clear_huge_page.__do_huge_pmd_anonymous_page.__handle_mm_fault.handle_mm_fault
>       0.00           +72.5       72.51   2%  perf-profile.calltrace.cycles-pp.clear_huge_page.__do_huge_pmd_anonymous_page.__handle_mm_fault.handle_mm_fault.do_user_addr_fault

With the commit, most CPU cycles are consumed for clear huge page.  This
is expected.  We allocate more pages, so, we need more cycles to clear
them.

Check the source code of test case (will-it-scale/malloc1), I found that
it will allocate some memory with malloc() then free it.

In the parent commit, because the virtual memory address isn't aligned
with 2M, normal page will be allocated.  With the commit, THP will be
allocated, so more page clearing and less LRU lock contention.  I think
this is the expected behavior of the commit.  And the test case isn't so
popular (malloc() then free() but don't access the memory allocated).  So
this regression isn't important.  We can just ignore it.

Best Regards,
Huang, Ying
