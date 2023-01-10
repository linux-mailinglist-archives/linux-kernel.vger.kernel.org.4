Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2438B663A2F
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Jan 2023 08:54:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237597AbjAJHxy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Jan 2023 02:53:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237678AbjAJHxk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jan 2023 02:53:40 -0500
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D35B61ADAC
        for <linux-kernel@vger.kernel.org>; Mon,  9 Jan 2023 23:53:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1673337215; x=1704873215;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=TCPzdo8u3EXgieM9CNMUNU67y5hV/sEIFaUkmnCEXgQ=;
  b=la812Q0oQsuolvMNpG5Rncuzm3w+MRkuc7w2zkkTxHnbWIAqsCHuKbXI
   rjJoIg8agFEprUObiDKnJ9LmOc1m1JS61AFHD6DgXrAm0JnPkdOqqraqw
   WIAuX8+KfXBbj8bdhg7B4tND5/DRDzJ4u5Ai0R5gAphqr4dNxeiG+czsR
   4MG2Dd2obQ1pt4L8MshLbkpmIGQX37jaCPZVfoZAa0kRL65nsND6jM9+2
   X0fPbQfxSWe6crLot0NeSBSO5YRZNNVN9t6grwCq11r7l0aKYWYyL8SDo
   rpHGFRrwqZwI1KRfAb5XnjMf8qiSwORincQfhV0X/ZR5rFvU7jpeOS3GE
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10585"; a="303449253"
X-IronPort-AV: E=Sophos;i="5.96,314,1665471600"; 
   d="scan'208";a="303449253"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jan 2023 23:53:35 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10585"; a="902287140"
X-IronPort-AV: E=Sophos;i="5.96,314,1665471600"; 
   d="scan'208";a="902287140"
Received: from juxinli-mobl.ccr.corp.intel.com (HELO yhuang6-mobl2.ccr.corp.intel.com) ([10.254.214.35])
  by fmsmga006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jan 2023 23:53:32 -0800
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
        haoxin <xhao@linux.alibaba.com>
Subject: [PATCH -v2 0/9] migrate_pages(): batch TLB flushing
Date:   Tue, 10 Jan 2023 15:53:18 +0800
Message-Id: <20230110075327.590514-1-ying.huang@intel.com>
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
