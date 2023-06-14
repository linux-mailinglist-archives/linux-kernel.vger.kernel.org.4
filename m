Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C878572F398
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Jun 2023 06:35:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233353AbjFNEfx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Jun 2023 00:35:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233878AbjFNEfu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Jun 2023 00:35:50 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 815131BD2;
        Tue, 13 Jun 2023 21:35:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1686717349; x=1718253349;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=ejpS5yv6KiwAGP47Gkayf0WbxFj2TagAcuYgVG4W330=;
  b=BKL8EsOuq3r+a9A2QuWj4X6VBVSw1ynp/jeoQZMkmjShtW3RzZh+fbAA
   RqMv2cdBtrcYAR20atw8xwv/DJBYqWTCX6JYaGRPPTdR6TpHsDe3vvcxq
   Yz7gm4aTAUHOM1MBlszRIfiYW3wYyGCpBer3ZaJ0s0/pGBIns+0/zWjOK
   OYp7lq1bfQ2BQ6tdlQ+n6K42wC0y3cGcIuhJomHfmTyNagBXZzjTXre88
   hwdDDSB49PAgUsA9B9eSTSSYl5zmawBvWzX2MDrJ/DOvCpcphCtnr8OIv
   DPPN0l4ZXINvi6iFzZdryhpYDMEOxkz8fAVtqMC6Etc9rXLxlwV872mmj
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10740"; a="360998729"
X-IronPort-AV: E=Sophos;i="6.00,241,1681196400"; 
   d="scan'208";a="360998729"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jun 2023 21:35:28 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10740"; a="662251402"
X-IronPort-AV: E=Sophos;i="6.00,241,1681196400"; 
   d="scan'208";a="662251402"
Received: from aschofie-mobl2.amr.corp.intel.com (HELO localhost) ([10.212.233.239])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jun 2023 21:35:28 -0700
From:   alison.schofield@intel.com
To:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Mike Rapoport <rppt@kernel.org>
Cc:     Alison Schofield <alison.schofield@intel.com>, x86@kernel.org,
        linux-cxl@vger.kernel.org, linux-acpi@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/2] CXL: Apply SRAT defined PXM to entire CFMWS window
Date:   Tue, 13 Jun 2023 21:35:23 -0700
Message-Id: <cover.1686712819.git.alison.schofield@intel.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Alison Schofield <alison.schofield@intel.com>

Along with the changes in v2 listed below, Dan questioned the maintenance
burden of x86 not switching to use the memblock API. See Dan Williams &
Mike Rapoport discuss the issue in the v1 link. [1]

IIUC switching existing x86 meminfo usage to memblock is the pre-existing
outstanding work, and per Mike 'that's quite some work needed to make
that happen' and since the memblock API doesn't support something like
numa_fill_memblks(), add that work on top.

So, with that open awaiting feedback from x86 maintainers, here's v2.


Changes in v2:

Patch 1/2: x86/numa: Introduce numa_fill_memblks()
- Update commit log with policy description. (Dan)
- Collect memblks with any HPA range intersect. (Dan)
- Adjust head or tail memblk to include, not align to, HPA range.
- Let the case of a single memblk simply fall through.
- Simplify the sort compare function to use start only.
- Rewrite and simplify the fill loop.
- Add code comment for exclusive memblk->end. (Dan)
- Add code comment for memblks being adjusted in place. (Dan)
- Add Tags: Reported-by, Suggested-by, Tested-by

Patch 2/2: ACPI: NUMA: Apply SRAT proximity domain to entire CFMWS window
- Add Tags: Reported-by, Suggested-by, Tested-by
- No changes in patch body.

[1] v1: https://lore.kernel.org/linux-cxl/cover.1684448934.git.alison.schofield@intel.com/

Cover Letter:

The CXL subsystem requires the creation of NUMA nodes for CFMWS
Windows not described in the SRAT. The existing implementation
only addresses windows that the SRAT describes completely or
not at all. This work addresses the case of partially described
CFMWS Windows by extending proximity domains in a portion of
a CFMWS window to the entire window.

Introduce a NUMA helper, numa_fill_memblks(), to fill gaps in
a numa_meminfo memblk address range. Update the CFMWS parsing
in the ACPI driver to use numa_fill_memblks() to extend SRAT
defined proximity domains to entire CXL windows.

An RFC of this patchset was previously posted for CXL folks
review.[2] The RFC feedback led to the implementation here,
extending existing memblks (Dan). Also, both Jonathan and
Dan influenced the changelog comments in the ACPI patch, with
regards to setting expectations on this evolving heuristic.

Repeating here to set reviewer expectations:
*Note that this heuristic will evolve when CFMWS Windows present
a wider range of characteristics. The extension of the proximity
domain, implemented here, is likely a step in developing a more
sophisticated performance profile in the future.

[2] https://lore.kernel.org/linux-cxl/cover.1683742429.git.alison.schofield@intel.com/

Alison Schofield (2):
  x86/numa: Introduce numa_fill_memblks()
  ACPI: NUMA: Apply SRAT proximity domain to entire CFMWS window

 arch/x86/include/asm/sparsemem.h |  2 +
 arch/x86/mm/numa.c               | 87 ++++++++++++++++++++++++++++++++
 drivers/acpi/numa/srat.c         | 11 ++--
 include/linux/numa.h             |  7 +++
 4 files changed, 104 insertions(+), 3 deletions(-)


base-commit: 6e2e1e779912345f0b5f86ef01facc2802bd97cc
-- 
2.37.3

