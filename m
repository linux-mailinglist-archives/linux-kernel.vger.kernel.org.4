Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 12D4072E7FE
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Jun 2023 18:13:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241491AbjFMQMn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Jun 2023 12:12:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235917AbjFMQMl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Jun 2023 12:12:41 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39DFB92;
        Tue, 13 Jun 2023 09:12:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1686672760; x=1718208760;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=WHV4FEfJfq9HVHNXBICHwzIvVJlAjf9wds6NoOlHzQE=;
  b=TTvk/I+iVa1XyyjiI8kri7qizPs/Kj5SCg3J04k/65yhgEjCTWwFd7r2
   0tpsHm9FMBf5oMeb8tDGidyqmTe9aF7B7LIvLPIUES/sK0GyabxsHuaTS
   oq0fGReomNrEOH+pJMvPiT6sWklgWEwatG29PgrWc5aVt95dSk+ub2rtu
   Dic7vVskpvSJINWanxkhctQ0JWZYtfTN5XqJkygaYIjcFA8CxVXvkarrT
   qmWmkQvrNn7inv+NxHWkyahCvL9ECbrYpe22w5gqQMwJMmsqPaMc4Fyw0
   caVj7Aa5V6xnocs5B1scj99PTJIHGr0570YPJCxi69Ps4CsZTgf3PMlrx
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10740"; a="348038772"
X-IronPort-AV: E=Sophos;i="6.00,240,1681196400"; 
   d="scan'208";a="348038772"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jun 2023 09:10:52 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10740"; a="714863422"
X-IronPort-AV: E=Sophos;i="6.00,240,1681196400"; 
   d="scan'208";a="714863422"
Received: from powerlab.fi.intel.com ([10.237.71.25])
  by fmsmga007.fm.intel.com with ESMTP; 13 Jun 2023 09:10:48 -0700
From:   Michal Wilczynski <michal.wilczynski@intel.com>
To:     linux-acpi@vger.kernel.org
Cc:     rafael@kernel.org, andriy.shevchenko@intel.com,
        artem.bityutskiy@linux.intel.com, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, hpa@zytor.com, lenb@kernel.org,
        jgross@suse.com, linux-kernel@vger.kernel.org, x86@kernel.org
Subject: [PATCH v3 0/5] Prefer using _OSC method over deprecated _PDC
Date:   Tue, 13 Jun 2023 19:10:29 +0300
Message-Id: <20230613161034.3496047-1-michal.wilczynski@intel.com>
X-Mailer: git-send-email 2.40.1
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

ACPI 3.0 introduced a new Operating System Capabilities _OSC control
method. This method is similar to _PDC, which was marked as deprecated
in ACPI 3.0.

Prefer using _OSC method over deprecated _PDC in the acpi_bus_init(). In
case of the failure of the _OSC, try using _PDC as a fallback.

Testing done:
Tested on physical server with BIOS implementing _OSC methods. In this
case acpi_processor_osc() was executed for each CPU core. acpi_run_osc()
returned success indicating that _OSC method succeeded.

Tested on qemu VM to check whether the code would work on a SeaBios (the
default for qemu, doesn't support _OSC methods, or _PDC). This way I was
able to see how code behaves in case BIOS doesn't implement _OSC. In
that case the function
acpi_run_osc() returned failure, which propagated all the way up to
acpi_early_processor_osc(). The logic responsible for triggering _PDC
execution was triggered correctly.

Tested this using debug messages with printk.

v3:
 - split into more commits to make review easier
 - changed "_UID" to METHOD_NAME_UID
 - changed hard-coded constant to ACPI_PDC_COLLAB_PROC_PERF
 - added Suggested-by tags
 - fixed style issues
 - fixed whitespaces
 - refactored code
v2:
 - fixed compilation issues on ia64 and arm

Michal Wilczynski (5):
  acpi: Move logic responsible for conveying processor OSPM capabilities
  acpi: Refactor arch_acpi_set_pdc_bits()
  acpi: Introduce new function callback for _OSC
  acpi: Use _OSC method to convey processor OSPM capabilities
  acpi: Remove acpi_hwp_native_thermal_lvt_osc()

 arch/ia64/include/asm/acpi.h  |   4 +-
 arch/x86/include/asm/acpi.h   |  13 +--
 drivers/acpi/acpi_processor.c | 151 +++++++++++++++++++++++++++-------
 drivers/acpi/bus.c            |  13 ++-
 drivers/acpi/internal.h       |  10 +--
 drivers/acpi/processor_pdc.c  |  82 +-----------------
 include/acpi/pdc_intel.h      |   1 +
 include/acpi/processor.h      |   2 +-
 8 files changed, 148 insertions(+), 128 deletions(-)

-- 
2.41.0

