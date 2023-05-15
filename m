Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 13B2D702550
	for <lists+linux-kernel@lfdr.de>; Mon, 15 May 2023 08:50:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240156AbjEOGud (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 May 2023 02:50:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240120AbjEOGua (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 May 2023 02:50:30 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E457C2
        for <linux-kernel@vger.kernel.org>; Sun, 14 May 2023 23:50:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1684133429; x=1715669429;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=8qoVMqaRyRfqkzBoyYI1vRz26d5h32BGobLS43A08RI=;
  b=N6Z7XoIMGyCWCuLOWheLG2Qa9nvBJRgvmhtSmIxDLEnoRvod7d9A7YFR
   A31DNoxNzaf//JTEoM9xqraH0Jcbm+AEtv9ojWxmWKTLxKjGN7ETSkQZc
   Ofn6NJH/LqTYbn29OIoiKYdNFIzEecvMBzmDv2o/VVff+c4pVC5dDVJ+4
   ofu2Nx0ZU63fISX7zpIiDKAKJY4ApUtgWLPTQbtg2PTTuFFvwmZo0Eu9q
   b3NJgksVG5i7vLvMVWdXVPjVbaCbZew1SAGCNl2lsYwGyAUwBPp5vIYQd
   /GHk/SYbkly5LGEO5ezhdl1Ie3eNLAyZkvJm5RPusX3wPJB+Z7iskUctD
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10710"; a="349966288"
X-IronPort-AV: E=Sophos;i="5.99,275,1677571200"; 
   d="scan'208";a="349966288"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 May 2023 23:50:28 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10710"; a="694908603"
X-IronPort-AV: E=Sophos;i="5.99,275,1677571200"; 
   d="scan'208";a="694908603"
Received: from bard-ubuntu.sh.intel.com ([10.239.185.57])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 May 2023 23:50:26 -0700
From:   Bard Liao <yung-chuan.liao@linux.intel.com>
To:     alsa-devel@alsa-project.org, vkoul@kernel.org, broonie@kernel.org,
        tiwai@suse.de
Cc:     linux-kernel@vger.kernel.org, vinod.koul@linaro.org,
        pierre-louis.bossart@linux.intel.com, bard.liao@intel.com
Subject: [PATCH v2 03/26] soundwire: intel_ace2x: add empty new ops for LunarLake
Date:   Mon, 15 May 2023 15:10:19 +0800
Message-Id: <20230515071042.2038-4-yung-chuan.liao@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230515071042.2038-1-yung-chuan.liao@linux.intel.com>
References: <20230515071042.2038-1-yung-chuan.liao@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>

The register map and programming sequences for the ACE2.x IP are
completely different and need to be abstracted with a different set of
callbacks.

This initial patch adds a new file, follow-up patches will add each
required callback.

Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Reviewed-by: Rander Wang <rander.wang@intel.com>
Reviewed-by: Péter Ujfalusi <peter.ujfalusi@linux.intel.com>
Reviewed-by: Ranjani Sridharan <ranjani.sridharan@linux.intel.com>
Signed-off-by: Bard Liao <yung-chuan.liao@linux.intel.com>
---
 drivers/soundwire/Makefile          |  2 +-
 drivers/soundwire/intel_ace2x.c     | 19 +++++++++++++++++++
 include/linux/soundwire/sdw_intel.h |  1 +
 3 files changed, 21 insertions(+), 1 deletion(-)
 create mode 100644 drivers/soundwire/intel_ace2x.c

diff --git a/drivers/soundwire/Makefile b/drivers/soundwire/Makefile
index 925566ff4272..5d612c9b6362 100644
--- a/drivers/soundwire/Makefile
+++ b/drivers/soundwire/Makefile
@@ -24,7 +24,7 @@ soundwire-cadence-y := cadence_master.o
 obj-$(CONFIG_SOUNDWIRE_CADENCE) += soundwire-cadence.o
 
 #Intel driver
-soundwire-intel-y :=	intel.o intel_auxdevice.o intel_init.o dmi-quirks.o \
+soundwire-intel-y :=	intel.o  intel_ace2x.o intel_auxdevice.o intel_init.o dmi-quirks.o \
 			intel_bus_common.o
 obj-$(CONFIG_SOUNDWIRE_INTEL) += soundwire-intel.o
 
diff --git a/drivers/soundwire/intel_ace2x.c b/drivers/soundwire/intel_ace2x.c
new file mode 100644
index 000000000000..623e4fd7db91
--- /dev/null
+++ b/drivers/soundwire/intel_ace2x.c
@@ -0,0 +1,19 @@
+// SPDX-License-Identifier: (GPL-2.0-only OR BSD-3-Clause)
+// Copyright(c) 2023 Intel Corporation. All rights reserved.
+
+/*
+ * Soundwire Intel ops for LunarLake
+ */
+
+#include <linux/acpi.h>
+#include <linux/device.h>
+#include <linux/soundwire/sdw_registers.h>
+#include <linux/soundwire/sdw.h>
+#include <linux/soundwire/sdw_intel.h>
+#include "cadence_master.h"
+#include "bus.h"
+#include "intel.h"
+
+const struct sdw_intel_hw_ops sdw_intel_lnl_hw_ops = {
+};
+EXPORT_SYMBOL_NS(sdw_intel_lnl_hw_ops, SOUNDWIRE_INTEL);
diff --git a/include/linux/soundwire/sdw_intel.h b/include/linux/soundwire/sdw_intel.h
index 8e6183e029fa..66687e83a94f 100644
--- a/include/linux/soundwire/sdw_intel.h
+++ b/include/linux/soundwire/sdw_intel.h
@@ -419,5 +419,6 @@ struct sdw_intel_hw_ops {
 };
 
 extern const struct sdw_intel_hw_ops sdw_intel_cnl_hw_ops;
+extern const struct sdw_intel_hw_ops sdw_intel_lnl_hw_ops;
 
 #endif
-- 
2.25.1

