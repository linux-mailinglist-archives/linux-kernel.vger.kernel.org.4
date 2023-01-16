Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 882BB66B770
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Jan 2023 07:31:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231945AbjAPGbQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Jan 2023 01:31:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231855AbjAPGbL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Jan 2023 01:31:11 -0500
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B532435A0
        for <linux-kernel@vger.kernel.org>; Sun, 15 Jan 2023 22:31:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1673850670; x=1705386670;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=uwCY+kg/niXT6bxn6yuzEYKrQhYZyea+2TI3E6O7Lv8=;
  b=hlPFapRSgfP5ovq1JZbhudLPaaJvFsfutw3mlC6WzsMRFUJHuPnieJnN
   78sX+vKldV3YEGPEWLZVvqRfhr4p+jMTbfyq57/CB0b/iLAprAWThzO+8
   E5xUrswGc9JC+DC4JCB73c07+p/qbdWSGmWOZrMC8j0I4tL9+JSS+kOvF
   Ry+wV6U+k2DO9NdFa7zMtZYLeDE8be8wmAHNAwPpHL4vU3a+y7MIBDsU6
   UAeSwM38m+ASd40osHsbKj811C63oJ1Q56yPC9JYqmBW/eTXyJ30JpJIT
   J6zr6JmwuAqMJ2cJn6nf8x4cDFDrokqv8tC0W9uwqgKXZ8ioEuPkNVDz7
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10591"; a="388892110"
X-IronPort-AV: E=Sophos;i="5.97,220,1669104000"; 
   d="scan'208";a="388892110"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jan 2023 22:31:10 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10591"; a="801286575"
X-IronPort-AV: E=Sophos;i="5.97,220,1669104000"; 
   d="scan'208";a="801286575"
Received: from tiangeng-mobl.ccr.corp.intel.com (HELO yhuang6-mobl2.ccr.corp.intel.com) ([10.255.28.220])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jan 2023 22:31:06 -0800
From:   Huang Ying <ying.huang@intel.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        "Huang, Ying" <ying.huang@intel.com>, Zi Yan <ziy@nvidia.com>,
        Yang Shi <shy828301@gmail.com>,
        Baolin Wang <baolin.wang@linux.alibaba.com>,
        Oscar Salvador <osalvador@suse.de>,
        Matthew Wilcox <willy@infradead.org>,
        Bharata B Rao <bharata@amd.com>,
        Alistair Popple <apopple@nvidia.com>,
        haoxin <xhao@linux.alibaba.com>, Minchan Kim <minchan@kernel.org>
Subject: [PATCH -v3 0/9] migrate_pages(): batch TLB flushing
Date:   Mon, 16 Jan 2023 14:30:48 +0800
Message-Id: <20230116063057.653862-1-ying.huang@intel.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Huang, Ying" <ying.huang@intel.com>

Now, migrate_pages() migrate folios one by one, like the fake code as
follows,

  for each folio
    unmap
    flush TLB
    copy
    restore map

If multiple folios are passed to migrate_pages(), there are
opportunities to batch the TLB flushing and copying.  That is, we can
change the code to something as follows,

  for each folio
    unmap
  for each folio
    flush TLB
  for each folio
    copy
  for each folio
    restore map

The total number of TLB flushing IPI can be reduced considerably.  And
we may use some hardware accelerator such as DSA to accelerate the
folio copying.

So in this patch, we refactor the migrate_pages() implementation and
implement the TLB flushing batching.  Base on this, hardware
accelerated folio copying can be implemented.

If too many folios are passed to migrate_pages(), in the naive batched
implementation, we may unmap too many folios at the same time.  The
possibility for a task to wait for the migrated folios to be mapped
again increases.  So the latency may be hurt.  To deal with this
issue, the max number of folios be unmapped in batch is restricted to
no more than HPAGE_PMD_NR in the unit of page.  That is, the influence
is at the same level of THP migration.

We use the following test to measure the performance impact of the
patchset,

On a 2-socket Intel server,

 - Run pmbench memory accessing benchmark

 - Run `migratepages` to migrate pages of pmbench between node 0 and
   node 1 back and forth.

With the patch, the TLB flushing IPI reduces 99.1% during the test and
the number of pages migrated successfully per second increases 291.7%.

This patchset is based on mm-unstable.

Changes:

v3:

- Rebased on v6.2-rc4

- Fixed a bug about non-LRU folio migration.  Thanks Mike!

- Fixed some comments.  Thanks Baolin!

- Collected reviewed-by.

v2:

- Rebased on v6.2-rc3

- Fixed type force cast warning.  Thanks Kees!

- Added more comments and cleaned up the code.  Thanks Andrew, Zi, Alistair, Dan!

- Collected reviewed-by.

from rfc to v1:

- Rebased on v6.2-rc1

- Fix the deadlock issue caused by locking multiple pages synchronously
  per Alistair's comments.  Thanks!

- Fix the autonumabench panic per Rao's comments and fix.  Thanks!

- Other minor fixes per comments. Thanks!

Best Regards,
Huang, Ying
