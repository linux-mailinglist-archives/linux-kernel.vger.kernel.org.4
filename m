Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 27FCB668362
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Jan 2023 21:08:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240547AbjALUHN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Jan 2023 15:07:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241674AbjALUEh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jan 2023 15:04:37 -0500
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DFE615816
        for <linux-kernel@vger.kernel.org>; Thu, 12 Jan 2023 12:01:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1673553715; x=1705089715;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=L0LysSy+o68gZus5CsHds3iLhv9K3aJ1XZA9pHukedQ=;
  b=GnH1413EUyUY6n7jg6jRnSG0WBElisiyL4As58RoxS1/xDc2mHiMw9KN
   seBWGqibbHhBg0m9GzxZv3UyBfUXC6wpy2y63ldXGVOqSKxsV9iRhEYY4
   /xlIHgsxykEUuq+kLEqMuz+9ydiYnozsKj1ga6JbPKVlDo/YIdXxOzDVC
   nioWVr9b55ksTwQmuAOTEQazdEJEFqI6aQmw06xegu9XSuwv6N7tVV8Dg
   QbWm//d+H/FEVRg+zJIXGbDg34AtCkPQe7SOe7ll7X1Oa8wliAW4lQAJf
   NDmlfkRyfRlUIc3Lr1cbSxpnrOHkiEUjxieyVxJL+b/b7cG1BAGlV/vp6
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10588"; a="325867096"
X-IronPort-AV: E=Sophos;i="5.97,211,1669104000"; 
   d="scan'208";a="325867096"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jan 2023 12:01:29 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10588"; a="657959925"
X-IronPort-AV: E=Sophos;i="5.97,211,1669104000"; 
   d="scan'208";a="657959925"
Received: from kanliang-dev.jf.intel.com ([10.165.154.102])
  by orsmga002.jf.intel.com with ESMTP; 12 Jan 2023 12:01:29 -0800
From:   kan.liang@linux.intel.com
To:     peterz@infradead.org, mingo@redhat.com,
        linux-kernel@vger.kernel.org
Cc:     steve.wahl@hpe.com, alexander.antonov@linux.intel.com,
        ak@linux.intel.com, eranian@google.com, namhyung@kernel.org,
        Kan Liang <kan.liang@linux.intel.com>
Subject: [PATCH RESEND 1/5] perf/x86/uncore: Factor out uncore_device_to_die()
Date:   Thu, 12 Jan 2023 12:01:01 -0800
Message-Id: <20230112200105.733466-2-kan.liang@linux.intel.com>
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

The same code is used to retrieve the logical die ID with a given PCI
device in both the discovery code and the code that supports a system
with > 8 nodes.

Factor out uncore_device_to_die() to replace the duplicate code.

No functional change.

Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
---
 arch/x86/events/intel/uncore.c           | 15 +++++++++++++++
 arch/x86/events/intel/uncore.h           |  1 +
 arch/x86/events/intel/uncore_discovery.c | 16 ++--------------
 arch/x86/events/intel/uncore_snbep.c     | 12 +-----------
 4 files changed, 19 insertions(+), 25 deletions(-)

diff --git a/arch/x86/events/intel/uncore.c b/arch/x86/events/intel/uncore.c
index 6f1ccc57a692..8caf253be1de 100644
--- a/arch/x86/events/intel/uncore.c
+++ b/arch/x86/events/intel/uncore.c
@@ -65,6 +65,21 @@ int uncore_die_to_segment(int die)
 	return bus ? pci_domain_nr(bus) : -EINVAL;
 }
 
+int uncore_device_to_die(struct pci_dev *dev)
+{
+	int node = pcibus_to_node(dev->bus);
+	int cpu;
+
+	for_each_cpu(cpu, cpumask_of_pcibus(dev->bus)) {
+		struct cpuinfo_x86 *c = &cpu_data(cpu);
+
+		if (c->initialized && cpu_to_node(cpu) == node)
+			return c->logical_die_id;
+	}
+
+	return -1;
+}
+
 static void uncore_free_pcibus_map(void)
 {
 	struct pci2phy_map *map, *tmp;
diff --git a/arch/x86/events/intel/uncore.h b/arch/x86/events/intel/uncore.h
index e278e2e7c051..8d493bea9eb6 100644
--- a/arch/x86/events/intel/uncore.h
+++ b/arch/x86/events/intel/uncore.h
@@ -208,6 +208,7 @@ struct pci2phy_map {
 struct pci2phy_map *__find_pci2phy_map(int segment);
 int uncore_pcibus_to_dieid(struct pci_bus *bus);
 int uncore_die_to_segment(int die);
+int uncore_device_to_die(struct pci_dev *dev);
 
 ssize_t uncore_event_show(struct device *dev,
 			  struct device_attribute *attr, char *buf);
diff --git a/arch/x86/events/intel/uncore_discovery.c b/arch/x86/events/intel/uncore_discovery.c
index 5fd72d4b8bbb..08af92af2be2 100644
--- a/arch/x86/events/intel/uncore_discovery.c
+++ b/arch/x86/events/intel/uncore_discovery.c
@@ -33,7 +33,7 @@ static int logical_die_id;
 
 static int get_device_die_id(struct pci_dev *dev)
 {
-	int cpu, node = pcibus_to_node(dev->bus);
+	int node = pcibus_to_node(dev->bus);
 
 	/*
 	 * If the NUMA info is not available, assume that the logical die id is
@@ -43,19 +43,7 @@ static int get_device_die_id(struct pci_dev *dev)
 	if (node < 0)
 		return logical_die_id++;
 
-	for_each_cpu(cpu, cpumask_of_node(node)) {
-		struct cpuinfo_x86 *c = &cpu_data(cpu);
-
-		if (c->initialized && cpu_to_node(cpu) == node)
-			return c->logical_die_id;
-	}
-
-	/*
-	 * All CPUs of a node may be offlined. For this case,
-	 * the PCI and MMIO type of uncore blocks which are
-	 * enumerated by the device will be unavailable.
-	 */
-	return -1;
+	return uncore_device_to_die(dev);
 }
 
 #define __node_2_type(cur)	\
diff --git a/arch/x86/events/intel/uncore_snbep.c b/arch/x86/events/intel/uncore_snbep.c
index 44c2f879f708..31acc96ccb69 100644
--- a/arch/x86/events/intel/uncore_snbep.c
+++ b/arch/x86/events/intel/uncore_snbep.c
@@ -1453,9 +1453,6 @@ static int snbep_pci2phy_map_init(int devid, int nodeid_loc, int idmap_loc, bool
 			}
 			raw_spin_unlock(&pci2phy_map_lock);
 		} else {
-			int node = pcibus_to_node(ubox_dev->bus);
-			int cpu;
-
 			segment = pci_domain_nr(ubox_dev->bus);
 			raw_spin_lock(&pci2phy_map_lock);
 			map = __find_pci2phy_map(segment);
@@ -1465,15 +1462,8 @@ static int snbep_pci2phy_map_init(int devid, int nodeid_loc, int idmap_loc, bool
 				break;
 			}
 
-			die_id = -1;
-			for_each_cpu(cpu, cpumask_of_pcibus(ubox_dev->bus)) {
-				struct cpuinfo_x86 *c = &cpu_data(cpu);
+			map->pbus_to_dieid[bus] = die_id = uncore_device_to_die(ubox_dev);
 
-				if (c->initialized && cpu_to_node(cpu) == node) {
-					map->pbus_to_dieid[bus] = die_id = c->logical_die_id;
-					break;
-				}
-			}
 			raw_spin_unlock(&pci2phy_map_lock);
 
 			if (WARN_ON_ONCE(die_id == -1)) {
-- 
2.35.1

