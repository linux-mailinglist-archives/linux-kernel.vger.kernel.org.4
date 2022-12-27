Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 241F2656640
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Dec 2022 01:29:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232413AbiL0A3Z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Dec 2022 19:29:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229791AbiL0A3W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Dec 2022 19:29:22 -0500
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14E3CEB1
        for <linux-kernel@vger.kernel.org>; Mon, 26 Dec 2022 16:29:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1672100962; x=1703636962;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=Of+NKY4iw8WWEB0zFLvTUTaUQgg1khMoL1jqU3Qdd5I=;
  b=ivXu9YmqZDYVFv3a1Ujv+oDMCxj/p2cY3x3KAzI+YrYqMjhHSvl+9hk1
   XxMdofdgS4J6+4edgDol0DjaxZdwc7481OBoS2jQhsTT8rhMPrtObpwZo
   lmw+QpzmKOVXuKXrtxqiaZHtktKoZ+gebIrzLoNtE94odcVVvJsmAcbSh
   beogyzpEDtshmi1aDbGfpmlDnf3sdi8Fw8ftdAr4W1JzS1Sq06bwpCpPi
   gmjhnoeEJfSjM+Sh0i5/sbLnL90y+J3VNIAoopmmHJX6TcKiRvkFDNlqr
   gQox0eXP7YVCLGIb9br6JsofsQ38WLkz0V1tQ59G+kKGzY+ul0V1h/mhp
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10572"; a="322597195"
X-IronPort-AV: E=Sophos;i="5.96,277,1665471600"; 
   d="scan'208";a="322597195"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Dec 2022 16:29:21 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10572"; a="760172178"
X-IronPort-AV: E=Sophos;i="5.96,277,1665471600"; 
   d="scan'208";a="760172178"
Received: from yyang3-mobl1.ccr.corp.intel.com (HELO yhuang6-mobl2.ccr.corp.intel.com) ([10.254.212.104])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Dec 2022 16:29:16 -0800
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
Subject: [PATCH 0/8] migrate_pages(): batch TLB flushing
Date:   Tue, 27 Dec 2022 08:28:51 +0800
Message-Id: <20221227002859.27740-1-ying.huang@intel.com>
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

from rfc to v1:

- Rebased on v6.2-rc1

- Fix the deadlock issue caused by locking multiple pages synchronously
  per Alistair's comments.  Thanks!

- Fix the autonumabench panic per Rao's comments and fix.  Thanks!

- Other minor fixes per comments. Thanks!

Best Regards,
Huang, Ying
