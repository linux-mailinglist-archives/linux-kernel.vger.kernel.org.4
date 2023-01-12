Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C4B13668373
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Jan 2023 21:08:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240608AbjALUHX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Jan 2023 15:07:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241695AbjALUEl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jan 2023 15:04:41 -0500
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BFFD1D0F0
        for <linux-kernel@vger.kernel.org>; Thu, 12 Jan 2023 12:01:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1673553720; x=1705089720;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=k3olYJGDuAsTwkx4jY139eZ6Hwoc0t134R0hr6yBmNI=;
  b=CMU6RVdPWdQ/3ehsOAfEAJNsaooYRZUwVFuvEPfROvecaaiAmOZm2c9v
   TyX+FQdG1ZbMijiwq0Eaq4SbFzarQ2e+XTCmHBa/pq9oSlkSIPU7g6YhD
   faYoW7Md6LhQ7hpSt8E30GflrQSWDqTt9Qxc5aHtD4209K4QI7GAiBuXA
   haja8y/J625z5Q0xn3QugcpjhxLzAVlHsVTAoypTV9/eo7oaiyrS1tNA+
   dBv17l6RXQJWNBjwlwjm77fwAotw/a0CYHZHZWe2D2lZ78L5ZbT6kUL7S
   rwJJnjWgNNYz2jNhmvHaMLWbR5JsMg3RddSaCYpHjKV7gDRhKyeYzI66Q
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10588"; a="325867109"
X-IronPort-AV: E=Sophos;i="5.97,211,1669104000"; 
   d="scan'208";a="325867109"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jan 2023 12:01:29 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10588"; a="657959930"
X-IronPort-AV: E=Sophos;i="5.97,211,1669104000"; 
   d="scan'208";a="657959930"
Received: from kanliang-dev.jf.intel.com ([10.165.154.102])
  by orsmga002.jf.intel.com with ESMTP; 12 Jan 2023 12:01:29 -0800
From:   kan.liang@linux.intel.com
To:     peterz@infradead.org, mingo@redhat.com,
        linux-kernel@vger.kernel.org
Cc:     steve.wahl@hpe.com, alexander.antonov@linux.intel.com,
        ak@linux.intel.com, eranian@google.com, namhyung@kernel.org,
        Kan Liang <kan.liang@linux.intel.com>
Subject: [PATCH RESEND 3/5] perf/x86/uncore: Ignore broken units in discovery table
Date:   Thu, 12 Jan 2023 12:01:03 -0800
Message-Id: <20230112200105.733466-4-kan.liang@linux.intel.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20230112200105.733466-1-kan.liang@linux.intel.com>
References: <20230112200105.733466-1-kan.liang@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kan Liang <kan.liang@linux.intel.com>

Some units in a discovery table may be broken, e.g., UPI of SPR MCC.
A generic method is required to ignore the broken units.

Add uncore_units_ignore in the struct intel_uncore_init_fun, which
indicates the type ID of broken units. It will be assigned by the
platform-specific code later when the platform has a broken discovery
table.

Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
---
 arch/x86/events/intel/uncore.c           |  8 ++++++--
 arch/x86/events/intel/uncore.h           |  2 ++
 arch/x86/events/intel/uncore_discovery.c | 26 +++++++++++++++++++++---
 arch/x86/events/intel/uncore_discovery.h |  2 +-
 4 files changed, 32 insertions(+), 6 deletions(-)

diff --git a/arch/x86/events/intel/uncore.c b/arch/x86/events/intel/uncore.c
index d63be6d1224e..751df6460bff 100644
--- a/arch/x86/events/intel/uncore.c
+++ b/arch/x86/events/intel/uncore.c
@@ -1695,7 +1695,10 @@ struct intel_uncore_init_fun {
 	void	(*cpu_init)(void);
 	int	(*pci_init)(void);
 	void	(*mmio_init)(void);
+	/* Discovery table is required */
 	bool	use_discovery;
+	/* The units in the discovery table should be ignored. */
+	int	*uncore_units_ignore;
 };
 
 static const struct intel_uncore_init_fun nhm_uncore_init __initconst = {
@@ -1873,7 +1876,7 @@ static int __init intel_uncore_init(void)
 
 	id = x86_match_cpu(intel_uncore_match);
 	if (!id) {
-		if (!uncore_no_discover && intel_uncore_has_discovery_tables())
+		if (!uncore_no_discover && intel_uncore_has_discovery_tables(NULL))
 			uncore_init = (struct intel_uncore_init_fun *)&generic_uncore_init;
 		else
 			return -ENODEV;
@@ -1881,7 +1884,8 @@ static int __init intel_uncore_init(void)
 		uncore_init = (struct intel_uncore_init_fun *)id->driver_data;
 		if (uncore_no_discover && uncore_init->use_discovery)
 			return -ENODEV;
-		if (uncore_init->use_discovery && !intel_uncore_has_discovery_tables())
+		if (uncore_init->use_discovery &&
+		    !intel_uncore_has_discovery_tables(uncore_init->uncore_units_ignore))
 			return -ENODEV;
 	}
 
diff --git a/arch/x86/events/intel/uncore.h b/arch/x86/events/intel/uncore.h
index 8d493bea9eb6..bbaa57cd868d 100644
--- a/arch/x86/events/intel/uncore.h
+++ b/arch/x86/events/intel/uncore.h
@@ -34,6 +34,8 @@
 
 #define UNCORE_EVENT_CONSTRAINT(c, n) EVENT_CONSTRAINT(c, n, 0xff)
 
+#define UNCORE_IGNORE_END		-1
+
 struct pci_extra_dev {
 	struct pci_dev *dev[UNCORE_EXTRA_PCI_DEV_MAX];
 };
diff --git a/arch/x86/events/intel/uncore_discovery.c b/arch/x86/events/intel/uncore_discovery.c
index 08af92af2be2..abb51191f5af 100644
--- a/arch/x86/events/intel/uncore_discovery.c
+++ b/arch/x86/events/intel/uncore_discovery.c
@@ -190,8 +190,25 @@ uncore_insert_box_info(struct uncore_unit_discovery *unit,
 
 }
 
+static bool
+uncore_ignore_unit(struct uncore_unit_discovery *unit, int *ignore)
+{
+	int i;
+
+	if (!ignore)
+		return false;
+
+	for (i = 0; ignore[i] != UNCORE_IGNORE_END ; i++) {
+		if (unit->box_type == ignore[i])
+			return true;
+	}
+
+	return false;
+}
+
 static int parse_discovery_table(struct pci_dev *dev, int die,
-				 u32 bar_offset, bool *parsed)
+				 u32 bar_offset, bool *parsed,
+				 int *ignore)
 {
 	struct uncore_global_discovery global;
 	struct uncore_unit_discovery unit;
@@ -246,6 +263,9 @@ static int parse_discovery_table(struct pci_dev *dev, int die,
 		if (unit.access_type >= UNCORE_ACCESS_MAX)
 			continue;
 
+		if (uncore_ignore_unit(&unit, ignore))
+			continue;
+
 		uncore_insert_box_info(&unit, die, *parsed);
 	}
 
@@ -254,7 +274,7 @@ static int parse_discovery_table(struct pci_dev *dev, int die,
 	return 0;
 }
 
-bool intel_uncore_has_discovery_tables(void)
+bool intel_uncore_has_discovery_tables(int *ignore)
 {
 	u32 device, val, entry_id, bar_offset;
 	int die, dvsec = 0, ret = true;
@@ -290,7 +310,7 @@ bool intel_uncore_has_discovery_tables(void)
 			if (die < 0)
 				continue;
 
-			parse_discovery_table(dev, die, bar_offset, &parsed);
+			parse_discovery_table(dev, die, bar_offset, &parsed, ignore);
 		}
 	}
 
diff --git a/arch/x86/events/intel/uncore_discovery.h b/arch/x86/events/intel/uncore_discovery.h
index f4439357779a..41637022b5d1 100644
--- a/arch/x86/events/intel/uncore_discovery.h
+++ b/arch/x86/events/intel/uncore_discovery.h
@@ -122,7 +122,7 @@ struct intel_uncore_discovery_type {
 	unsigned int	*box_offset;	/* Box offset */
 };
 
-bool intel_uncore_has_discovery_tables(void);
+bool intel_uncore_has_discovery_tables(int *ignore);
 void intel_uncore_clear_discovery_tables(void);
 void intel_uncore_generic_uncore_cpu_init(void);
 int intel_uncore_generic_uncore_pci_init(void);
-- 
2.35.1

