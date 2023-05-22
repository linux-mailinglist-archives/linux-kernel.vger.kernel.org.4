Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B99470C2F7
	for <lists+linux-kernel@lfdr.de>; Mon, 22 May 2023 18:06:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234080AbjEVQGN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 May 2023 12:06:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231147AbjEVQGL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 May 2023 12:06:11 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9F74C5;
        Mon, 22 May 2023 09:06:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1684771570; x=1716307570;
  h=subject:from:to:cc:date:message-id:mime-version:
   content-transfer-encoding;
  bh=PWeG8h1d4X+UeHqtvMp+lS9INBwDt1oWtuMjIoA5HEQ=;
  b=Esti7dYdnE1qrGp1SJolbqgo9F0rjausUBre6ui5Yi5B1j0jLEGc8Ulp
   aEULH2v28dgrwf6OUQC8iG98ZJBCm3mvhnukGSYKNb9S/88YlXS+Kf3ef
   Jc09Yv40hx5HmjUR26YLLRNtRYD6EtQgPsADLom8IWQWSwWkZpKL60MK0
   oX8aERrr4U+YeF/r0yVWD28Zkwr8LN193EBJsctO8+jkZI3RDabuPccV0
   vNIE67AaRNha4z7zYPVxHcixg/2ecUdg4v2Cj+ik0zxQNMfPxOicw6fUP
   KetLS+ZxTk/RWV1HDKD4TQoq3OZ+ddQMJg9e0PnDjIJJ8U+BCWgbXGL8k
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10718"; a="439315095"
X-IronPort-AV: E=Sophos;i="6.00,184,1681196400"; 
   d="scan'208";a="439315095"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 May 2023 09:06:06 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10718"; a="793357250"
X-IronPort-AV: E=Sophos;i="6.00,184,1681196400"; 
   d="scan'208";a="793357250"
Received: from djiang5-mobl3.amr.corp.intel.com (HELO [192.168.1.177]) ([10.213.173.219])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 May 2023 09:06:05 -0700
Subject: [PATCH] acpi: Fix header declaration of acpi_arch_dma_setup() w/o
 CONFIG_ACPI
From:   Dave Jiang <dave.jiang@intel.com>
To:     lpieralisi@kernel.org, guohanjun@huawei.com, sudeep.holla@arm.com
Cc:     kernel test robot <lkp@intel.com>,
        Jianmin Lv <lvjianmin@loongson.cn>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        rafael@kernel.org, lenb@kernel.org, linux-acpi@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Date:   Mon, 22 May 2023 09:06:04 -0700
Message-ID: <168477156440.3873520.6153672647621739139.stgit@djiang5-mobl3>
User-Agent: StGit/1.5
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

arm64 build can be done without CONFIG_ACPI. The ifdef bits for
acpi_arch_dma_setup() is placed inside CONFIG_ACPI. When CONFIG_ACPI is
not set, this causes warning reported by kernel test bot. Move the
prototype declaration for acpi_arch_dma_setup() outside of CONFIG_ACPI.

>> drivers/acpi/arm64/dma.c:7:6: warning: no previous prototype for function 'acpi_arch_dma_setup' [-Wmissing-prototypes]
   void acpi_arch_dma_setup(struct device *dev)
        ^
   drivers/acpi/arm64/dma.c:7:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
   void acpi_arch_dma_setup(struct device *dev)
   ^
   static
   1 warning generated.

Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202305200933.afKCLlxS-lkp@intel.com/
Fixes: bf2ee8d0c385 ("ACPI: scan: Support multiple DMA windows with different offsets")
CC: Jianmin Lv <lvjianmin@loongson.cn>
CC: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Signed-off-by: Dave Jiang <dave.jiang@intel.com>
---
 include/linux/acpi.h |   12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/include/linux/acpi.h b/include/linux/acpi.h
index 7b71dd74baeb..a0a8492d8a60 100644
--- a/include/linux/acpi.h
+++ b/include/linux/acpi.h
@@ -281,12 +281,6 @@ acpi_numa_processor_affinity_init(struct acpi_srat_cpu_affinity *pa) { }
 
 void acpi_numa_x2apic_affinity_init(struct acpi_srat_x2apic_cpu_affinity *pa);
 
-#if defined(CONFIG_ARM64) || defined(CONFIG_LOONGARCH)
-void acpi_arch_dma_setup(struct device *dev);
-#else
-static inline void acpi_arch_dma_setup(struct device *dev) { }
-#endif
-
 #ifdef CONFIG_ARM64
 void acpi_numa_gicc_affinity_init(struct acpi_srat_gicc_affinity *pa);
 #else
@@ -1084,6 +1078,12 @@ static inline bool acpi_sleep_state_supported(u8 sleep_state)
 
 #endif	/* !CONFIG_ACPI */
 
+#if defined(CONFIG_ARM64) || defined(CONFIG_LOONGARCH)
+void acpi_arch_dma_setup(struct device *dev);
+#else
+static inline void acpi_arch_dma_setup(struct device *dev) { }
+#endif
+
 #ifdef CONFIG_ACPI_HOTPLUG_IOAPIC
 int acpi_ioapic_add(acpi_handle root);
 #else


