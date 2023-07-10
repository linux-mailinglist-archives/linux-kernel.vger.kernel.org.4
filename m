Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 54D2E74DEB5
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jul 2023 22:03:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231220AbjGJUDF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jul 2023 16:03:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229582AbjGJUDD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jul 2023 16:03:03 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5B3B133;
        Mon, 10 Jul 2023 13:03:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1689019382; x=1720555382;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=MApgpjDb8XK5qpJn9vA5zowAtSOWLa+PVy9qXmZ/Nhs=;
  b=ZYX5oEI+eg7N14H/Eys8PLkaE2+icQt85QBX7t5lNABDF4zFmyplCjlL
   qVO1jahwgnG7LJFFp3zTCtE0sVOj+iB2hOOu6L1x6CiUkE0Md688PAv0m
   /Rmznpr2hPEkhOukloB982RMVscYi5FV2YcQUL5GNoibKT5EY7blwvF+b
   m2zjWadtFBgOYty8efGb/RKZJ/8ioeVKyzSHlfSlqAHpmfV/+NnsWVerb
   leLoJD1vYefaJq4zQQuQVHrD/9H77Vay8YPis3g7FBQj+9oku9/fGMwu/
   QmzybSRhu62864y7q6ymPCtDgXvIIenTZSTE1PL2WZxrN/p33TE4kS1bc
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10767"; a="344764051"
X-IronPort-AV: E=Sophos;i="6.01,195,1684825200"; 
   d="scan'208";a="344764051"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jul 2023 13:03:01 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10767"; a="714903568"
X-IronPort-AV: E=Sophos;i="6.01,195,1684825200"; 
   d="scan'208";a="714903568"
Received: from aschofie-mobl2.amr.corp.intel.com (HELO localhost) ([10.209.93.201])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jul 2023 13:03:01 -0700
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
Subject: [PATCH v4 0/2] CXL: Apply SRAT defined PXM to entire CFMWS window
Date:   Mon, 10 Jul 2023 13:02:57 -0700
Message-Id: <cover.1689018477.git.alison.schofield@intel.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Alison Schofield <alison.schofield@intel.com>


Changes in v4:
- Remove useless export of numa_fill_memblks()  (Dan)
- Rebase on latest tip tree

v3: https://lore.kernel.org/linux-cxl/cover.1687645837.git.alison.schofield@intel.com/

----

Cover Letter:

The CXL subsystem requires the creation of NUMA nodes for CFMWS
Windows[1] not described in the SRAT. The existing implementation
only addresses windows that the SRAT describes completely or not
at all. This work addresses the case of partially described CFMWS
Windows by extending proximity domains in a portion of a CFMWS
window to the entire window.

Introduce a NUMA helper, numa_fill_memblks(), to fill gaps in a
numa_meminfo memblk address range. Update the CFMWS parsing in the
ACPI driver to use numa_fill_memblks() to extend SRAT defined
proximity domains to entire CXL windows.

An RFC of this patchset was previously posted for CXL folks review
here[2]. The RFC feedback led to the implementation here, extending
existing memblks (Dan). Also, both Jonathan and Dan influenced the
changelog comments in the ACPI patch, with regards to setting
expectations on this evolving heuristic.

Repeating here to set reviewer expectations:
*Note that this heuristic will evolve when CFMWS Windows present a
wider range of characteristics. The extension of the proximity domain,
implemented here, is likely a step in developing a more sophisticated
performance profile in the future.

[1] CFMWS is defined in CXL Spec 3.0 Section 9.17.1.3 :
https://www.computeexpresslink.org/spec-landing

A CXL Fixed Memory Window is a region of Host Physical Address (HPA)
Space which routes accesses to CXL Host bridges. The 'S', of CFMWS,
stand for the structure that describes the window, hence it's common
name, CFMWS.

[2] https://lore.kernel.org/linux-cxl/cover.1683742429.git.alison.schofield@intel.com/


Alison Schofield (2):
  x86/numa: Introduce numa_fill_memblks()
  ACPI: NUMA: Apply SRAT proximity domain to entire CFMWS window

 arch/x86/include/asm/sparsemem.h |  2 +
 arch/x86/mm/numa.c               | 80 ++++++++++++++++++++++++++++++++
 drivers/acpi/numa/srat.c         | 11 +++--
 include/linux/numa.h             |  7 +++
 4 files changed, 97 insertions(+), 3 deletions(-)


base-commit: ac442f6a364dd23bc08086f07b4bc4ef8476a9fe
-- 
2.37.3

