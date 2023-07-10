Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B30574D87B
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jul 2023 16:06:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232139AbjGJOGU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jul 2023 10:06:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232051AbjGJOF7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jul 2023 10:05:59 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6266A100;
        Mon, 10 Jul 2023 07:05:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1688997958; x=1720533958;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=yboxrH3I2y7YMdBC0O230I9M/DTQeHYDM4SkahotP7o=;
  b=J5edntkKHTOdbn9Qgea9ZafZgYIv8mFygV+PhO89Ou0tqyqzB8VILP7f
   T2BhVB+KgFWTjtC+6Kj9Am9oKT+9qZkaAskby092W27Ewr1PJSJ+lddbV
   2cEl+H6Hy3WCNU8szesqR32Rx/zQvyVxPyqbz6YRf+xZ/BBqSWtZCFfM8
   gMQsjSv1cnoWFCtirR1bTfnjKywDRifQJ+WG2j3DBXqCPKBeLpKU1zBJt
   ufk7mUbnAWpPe3ABIlrFi83bDqIz257MIW4v+iOBZ1ssd1iA/L54cDz1z
   ketCP2UygKUstybZ4tJ0tTuErb6Ah0gPgF4p5NOtLT5k5ajT9fF3bphvv
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10767"; a="361814831"
X-IronPort-AV: E=Sophos;i="6.01,194,1684825200"; 
   d="scan'208";a="361814831"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jul 2023 07:05:11 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10767"; a="714822497"
X-IronPort-AV: E=Sophos;i="6.01,194,1684825200"; 
   d="scan'208";a="714822497"
Received: from powerlab.fi.intel.com ([10.237.71.25])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jul 2023 07:05:05 -0700
From:   Michal Wilczynski <michal.wilczynski@intel.com>
To:     linux-acpi@vger.kernel.org
Cc:     rafael@kernel.org, andriy.shevchenko@intel.com,
        artem.bityutskiy@linux.intel.com, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, hpa@zytor.com, lenb@kernel.org,
        jgross@suse.com, linux-kernel@vger.kernel.org, x86@kernel.org,
        Michal Wilczynski <michal.wilczynski@intel.com>
Subject: [PATCH v4 0/9] Prefer using _OSC method over deprecated _PDC
Date:   Mon, 10 Jul 2023 17:03:28 +0300
Message-ID: <20230710140337.1434060-1-michal.wilczynski@intel.com>
X-Mailer: git-send-email 2.41.0
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

v4:
 - move setting processor capabilities bits into arch code
 - move workaround for mwait to acpi/x86 directory
 - rename ACPI_PDC* constants to more generic ACPI_PROC_CAP*
 - introduce new function acpi_early_processor_control_setup()

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

Michal Wilczynski (9):
  acpi: Move mwait quirk out of acpi_processor.c
  acpi: Move processor_physically_present() to acpi_processor.c
  acpi: Refactor arch_acpi_set_pdc_bits()
  acpi: Rename ACPI_PDC constants
  acpi: Clear C_C2C3_FFH and C_C1_FFH in arch_acpi_set_proc_cap_bits()
  acpi: Move setting CAP_SMP_T_SWCOORD to arch_acpi_set_proc_cap_bits()
  acpi: Introduce acpi_processor_osc()
  acpi: Use _OSC method to convey processor OSPM capabilities
  acpi: Remove acpi_hwp_native_thermal_lvt_osc()

 arch/ia64/include/asm/acpi.h  |   6 +-
 arch/x86/include/asm/acpi.h   |  24 ++++---
 arch/x86/xen/enlighten_pv.c   |   8 +--
 drivers/acpi/acpi_processor.c | 121 +++++++++++++++++++++++++---------
 drivers/acpi/bus.c            |   5 +-
 drivers/acpi/internal.h       |  10 ++-
 drivers/acpi/processor_pdc.c  |  97 +--------------------------
 drivers/acpi/x86/utils.c      |  35 ++++++++++
 include/acpi/pdc_intel.h      |  36 ----------
 include/acpi/proc_cap_intel.h |  40 +++++++++++
 10 files changed, 194 insertions(+), 188 deletions(-)
 delete mode 100644 include/acpi/pdc_intel.h
 create mode 100644 include/acpi/proc_cap_intel.h

-- 
2.41.0

