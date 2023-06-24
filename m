Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4506173CD7A
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Jun 2023 01:42:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230363AbjFXXmb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 24 Jun 2023 19:42:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229552AbjFXXm2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Jun 2023 19:42:28 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B3AB10F4;
        Sat, 24 Jun 2023 16:42:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1687650148; x=1719186148;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=XulpVuQfuTZ4FuPcJLyEvjWsEHT8K+qOYMn61+EN9cc=;
  b=KfGbiS3Y8OodnGFfBN/Io0q/Ki2oCbNi51Fe0YFf3AI2VNUHZFL2IkcK
   GB/MDq8oznXisH75PZf1EsZ0ECHHKDqhwFLtxwF8U2gQiuQlOMNMQYQ/v
   2n8cXDz4Z92eiZx8+eXc54GLU4+pMA9GCQoOzXczEcHEU/fV4KuiaOqH9
   LIOi7j7RZOwBR4llbkBSBgxRLRUZqntJFuxwsU3ybdFx+GdcDFspJ32+m
   oLmckU+JdjLXY0/CkpAI1zhNU6i2a0s3GvfQXtQSaVgAmcMIxpMMFpQ6Y
   htFFIxcJf8b9Iohaqx7zJb78hSi9VoHFZ6F+d2icr2TDSiGw2koqHlzK1
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10751"; a="391123085"
X-IronPort-AV: E=Sophos;i="6.01,156,1684825200"; 
   d="scan'208";a="391123085"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jun 2023 16:42:27 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10751"; a="839839580"
X-IronPort-AV: E=Sophos;i="6.01,156,1684825200"; 
   d="scan'208";a="839839580"
Received: from aschofie-mobl2.amr.corp.intel.com (HELO localhost) ([10.209.113.117])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jun 2023 16:42:26 -0700
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
Subject: [PATCH v3 0/2] CXL: Apply SRAT defined PXM to entire CFMWS window
Date:   Sat, 24 Jun 2023 16:42:22 -0700
Message-Id: <cover.1687645837.git.alison.schofield@intel.com>
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

Changes in v3:
- Define CFMWS and add CXL Spec link in cover letter (Peter, Jonathan)
- s/HPA/physical address in Patch 1 (Peter)
- Remove overkill comment in Patch 1 (Dan)
- Simplify cmp_memblk() in Patch 1 (Dan)

v2: https://lore.kernel.org/linux-cxl/cover.1686712819.git.alison.schofield@intel.com/

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
 arch/x86/mm/numa.c               | 81 ++++++++++++++++++++++++++++++++
 drivers/acpi/numa/srat.c         | 11 +++--
 include/linux/numa.h             |  7 +++
 4 files changed, 98 insertions(+), 3 deletions(-)


base-commit: 214a71b53bc7cb30f6b8d43089037e9fe7f3ae1f
-- 
2.37.3

