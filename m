Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4576A68B59B
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Feb 2023 07:33:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229613AbjBFGdj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Feb 2023 01:33:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229479AbjBFGdd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Feb 2023 01:33:33 -0500
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2368193D4
        for <linux-kernel@vger.kernel.org>; Sun,  5 Feb 2023 22:33:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1675665208; x=1707201208;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=u2qsfcVM3St5WrkIXjYK8yM1e3KwimUpAfokCw818Xk=;
  b=IAbdWdQuAlRaiqYZTseoqrIrYn2ZONiCjMM0fgrtawKpIBnjOPKQDF/8
   DKp3wnPJSwJBGYARYj5rgkqO5d7vtwa+zQaVojhk+F9lA4XKF/6RaZj01
   Nvb8VvAmfauHDQxpZtJ+VIssPu6i6uf42UB6P7NSk9joUwHz/qWxZuEot
   nbpJkWm6bDcceDqBMScIq1zVHKvGHFaBJ64Ib/Vexx7Z87mArXdMzM99N
   hXghWmftF/Ty8gAzem/O26N66IxAkoSQheG1Yh/RZSMbI7i4t6Xc+X0IT
   AxzJjgiEbvOuM1th9fmgHJVku9UrbYMS/cmoEmiVLNEn6r0nnqvM0jGOK
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10612"; a="330432607"
X-IronPort-AV: E=Sophos;i="5.97,276,1669104000"; 
   d="scan'208";a="330432607"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Feb 2023 22:33:28 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10612"; a="659744606"
X-IronPort-AV: E=Sophos;i="5.97,276,1669104000"; 
   d="scan'208";a="659744606"
Received: from baoyumen-mobl.ccr.corp.intel.com (HELO yhuang6-mobl2.smartont.net) ([10.255.30.227])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Feb 2023 22:33:22 -0800
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
        haoxin <xhao@linux.alibaba.com>,
        Minchan Kim <minchan@kernel.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Hyeonggon Yoo <42.hyeyoo@gmail.com>
Subject: [PATCH -v4 0/9] migrate_pages(): batch TLB flushing
Date:   Mon,  6 Feb 2023 14:33:04 +0800
Message-Id: <20230206063313.635011-1-ying.huang@intel.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
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

This patchset is based on v6.2-rc4.

Changes:

v4:

- Fixed another bug about non-LRU folio migration.  Thanks Hyeonggon!

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
