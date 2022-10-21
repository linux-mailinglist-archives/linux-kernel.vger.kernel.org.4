Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 70B3C607F64
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Oct 2022 22:01:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229874AbiJUUBd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Oct 2022 16:01:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229727AbiJUUBa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Oct 2022 16:01:30 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A5FE25E886
        for <linux-kernel@vger.kernel.org>; Fri, 21 Oct 2022 13:01:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1666382488; x=1697918488;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=/l/AGxNBveIFVLifPG7mHqaofFSHPy5andRAcNZBXFI=;
  b=iJGAohOrEopopUldTmSoMCuPLHyM2Tr2nHChri786Oz0HL+d9NZ7OHF/
   REdNNoWz6/itKDUCH4iWPUvvae5d+sZUSLM3bJBQIHMia1f5U9EBal+Vo
   ofbK7LNPtmJ9SlIV92rgHu+pgt+EeWVx919ezlabvjnYPbdFWsTVkRp80
   Ef5MTetcLnPOQi6X/ZJvFGhVPBQy3YKSiSoER+3EmgIciJZPk4KRymhvj
   enWKmAQzd7M2Fn1DBHM2BVy0iEg7Em7IA5SE6zbFuczDDia3wg4Y7LDtx
   gc0PnoNh6n19inksrVWzmKkDG/QfWwz/BIyxSDj598Sgmb6fq2jtyTpdB
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10507"; a="290401087"
X-IronPort-AV: E=Sophos;i="5.95,203,1661842800"; 
   d="scan'208";a="290401087"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Oct 2022 13:01:27 -0700
X-IronPort-AV: E=McAfee;i="6500,9779,10507"; a="633069084"
X-IronPort-AV: E=Sophos;i="5.95,203,1661842800"; 
   d="scan'208";a="633069084"
Received: from agluck-desk3.sc.intel.com ([172.25.222.78])
  by fmsmga007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Oct 2022 13:01:27 -0700
From:   Tony Luck <tony.luck@intel.com>
To:     Naoya Horiguchi <naoya.horiguchi@nec.com>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Miaohe Lin <linmiaohe@huawei.com>,
        Matthew Wilcox <willy@infradead.org>,
        Shuai Xue <xueshuai@linux.alibaba.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Nicholas Piggin <npiggin@gmail.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, Tony Luck <tony.luck@intel.com>
Subject: [PATCH v3 0/2] Copy-on-write poison recovery
Date:   Fri, 21 Oct 2022 13:01:18 -0700
Message-Id: <20221021200120.175753-1-tony.luck@intel.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20221019170835.155381-1-tony.luck@intel.com>
References: <20221019170835.155381-1-tony.luck@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Part 1 deals with the process that triggered the copy on write
fault with a store to a shared read-only page. That process is
send a SIGBUS with the usual machine check decoration to specify
the virtual address of the lost page, together with the scope.

Part 2 sets up to asynchronously take the page with the uncorrected
error offline to prevent additional machine check faults. H/t to
Miaohe Lin <linmiaohe@huawei.com> and Shuai Xue <xueshuai@linux.alibaba.com>
for pointing me to the existing function to queue a call to
memory_failure().

On x86 there is some duplicate reporting (because the error is
also signalled by the memory controller as well as by the core
that triggered the machine check). Console logs look like this:

[ 1647.723403] mce: [Hardware Error]: Machine check events logged
	Machine check from kernel copy routine

[ 1647.723414] MCE: Killing einj_mem_uc:3600 due to hardware memory corruption fault at 7f3309503400
	x86 fault handler sends SIGBUS to child process

[ 1647.735183] Memory failure: 0x905b92d: recovery action for dirty LRU page: Recovered
	Async call to memory_failure() from copy on write path

[ 1647.748397] Memory failure: 0x905b92d: already hardware poisoned
	uc_decode_notifier() processes memory controller report

[ 1647.761313] MCE: Killing einj_mem_uc:3599 due to hardware memory corruption fault at 7f3309503400
	Parent process tries to read poisoned page. Page has been unmapped, so
	#PF handler sends SIGBUS


Tony Luck (2):
  mm, hwpoison: Try to recover from copy-on write faults
  mm, hwpoison: When copy-on-write hits poison, take page offline

 include/linux/highmem.h | 24 ++++++++++++++++++++++++
 include/linux/mm.h      |  5 ++++-
 mm/memory.c             | 32 ++++++++++++++++++++++----------
 3 files changed, 50 insertions(+), 11 deletions(-)

-- 
2.37.3

