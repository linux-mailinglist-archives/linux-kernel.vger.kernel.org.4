Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C8453708C9E
	for <lists+linux-kernel@lfdr.de>; Fri, 19 May 2023 02:05:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230155AbjESAFE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 May 2023 20:05:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229512AbjESAFC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 May 2023 20:05:02 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6BC9F10C3;
        Thu, 18 May 2023 17:05:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1684454700; x=1715990700;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=NxrdO54ygL7upV2uL2eTTGfGI0A4vPAHukw5zXs+2vU=;
  b=M3+JKSlV+3QzKkxlljXzxBQZXyIWgsqB28dkaOJ/16CkKQ7zTjB5z1Xj
   bOOZzWOAC5tdRlKtzRYlXhmcPY5qEwUXmiIHCg/NjHqb0s9cyeK7KJ+YR
   PjpDK5W/xxO4dlOKSOsTxXf15Llk3whnRfjNrKF7I4DrkxScC35P2GV2q
   BRJ42Go9Iu4Co2ZHmNCeoSz8X561wu5J3B9uYJwbxPDLlTfgCNiry9OIE
   CHq110lXp3UgMlIKAcEYvjugpU8oYaXeanZ6ehrR75UX9INn0+/JRXUJr
   +u7ag8IYfCmddOJ3xLPeTRZyFfRPqJBFJn9y5PQ3fa/woN05ky9kN+aYR
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10714"; a="355446205"
X-IronPort-AV: E=Sophos;i="6.00,175,1681196400"; 
   d="scan'208";a="355446205"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 May 2023 17:04:59 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10714"; a="876634912"
X-IronPort-AV: E=Sophos;i="6.00,175,1681196400"; 
   d="scan'208";a="876634912"
Received: from aschofie-mobl2.amr.corp.intel.com (HELO localhost) ([10.251.20.44])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 May 2023 17:04:59 -0700
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
        Dave Jiang <dave.jiang@intel.com>
Cc:     Alison Schofield <alison.schofield@intel.com>, x86@kernel.org,
        linux-cxl@vger.kernel.org, linux-acpi@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 0/2] CXL: Apply SRAT defined PXM to entire CFMWS window
Date:   Thu, 18 May 2023 17:04:54 -0700
Message-Id: <cover.1684448934.git.alison.schofield@intel.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Alison Schofield <alison.schofield@intel.com>

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
review.[1] The RFC feedback led to the implementation here,
extending existing memblks (Dan). Also, both Jonathan and
Dan influenced the changelog comments in the ACPI patch, with
regards to setting expectations on this evolving heuristic.

Repeating here to set reviewer expectations:
*Note that this heuristic will evolve when CFMWS Windows present
a wider range of characteristics. The extension of the proximity
domain, implemented here, is likely a step in developing a more
sophisticated performance profile in the future.

[1] https://lore.kernel.org/linux-cxl/cover.1683742429.git.alison.schofield@intel.com/

Alison Schofield (2):
  x86/numa: Introduce numa_fill_memblks()
  ACPI: NUMA: Apply SRAT proximity domain to entire CFMWS window

 arch/x86/include/asm/sparsemem.h |  2 +
 arch/x86/mm/numa.c               | 82 ++++++++++++++++++++++++++++++++
 drivers/acpi/numa/srat.c         | 11 +++--
 include/linux/numa.h             |  7 +++
 4 files changed, 99 insertions(+), 3 deletions(-)


base-commit: f81d8f759e7f80c643027e631c586369836aac90
-- 
2.37.3

