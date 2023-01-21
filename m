Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E8DB967657E
	for <lists+linux-kernel@lfdr.de>; Sat, 21 Jan 2023 10:49:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229693AbjAUJty (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 21 Jan 2023 04:49:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229728AbjAUJtd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 Jan 2023 04:49:33 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5848E5B596;
        Sat, 21 Jan 2023 01:49:32 -0800 (PST)
Date:   Sat, 21 Jan 2023 09:49:26 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1674294567;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Cux3u5RitqESrW0kZWqOAJ/Kos4RVxzC1jiribYIxfA=;
        b=H55ylvZB9UyFVEKlgIQPxlVuQ/UjUR+9f3gAoHEPE95BqVMnYk/fETalTnji5flYqfd/cn
        m3o+COC8JtHBvYYKGjISZO0h8OexDTdIb2iofXvLqc/quuTbVOmlz+n4gBbZJOCZUVdbo2
        Ru4P8S0HwBailhbZEpjN55BW8ZeRZs9vLcnp1vq8Bzho/jJ4Zmyon+DcRq7ZCl452HF6wo
        DEw7mC3Tnqf0+rAYS2EQopCVZhQS8pyWE+6KfldeVK48siKLoehPlTX9oS4/9t3jYoNRV2
        MWTTj+eVWTwSALPBzqqXswMDU057GSfTgHBNf7VLA2v8dPJ2ZL5qeEO+yqgfpw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1674294567;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Cux3u5RitqESrW0kZWqOAJ/Kos4RVxzC1jiribYIxfA=;
        b=MHU1a7D2MSmR/UVA4QdjfWvvIhyFbS1Dv3PqaQWmEFy089/gJe+ZAtpRVof2jCwtPhUMSL
        UZ5jtqtylL+LMIAw==
From:   "tip-bot2 for Kan Liang" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: perf/core] perf/x86/uncore: Factor out uncore_device_to_die()
Cc:     Kan Liang <kan.liang@linux.intel.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Michael Petlan <mpetlan@redhat.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20230112200105.733466-2-kan.liang@linux.intel.com>
References: <20230112200105.733466-2-kan.liang@linux.intel.com>
MIME-Version: 1.0
Message-ID: <167429456670.4906.2068459695458312637.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the perf/core branch of tip:

Commit-ID:     dbf061b26221fa1a99e6489dd61f5b4ee97a24e8
Gitweb:        https://git.kernel.org/tip/dbf061b26221fa1a99e6489dd61f5b4ee97a24e8
Author:        Kan Liang <kan.liang@linux.intel.com>
AuthorDate:    Thu, 12 Jan 2023 12:01:01 -08:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Sat, 21 Jan 2023 00:06:11 +01:00

perf/x86/uncore: Factor out uncore_device_to_die()

The same code is used to retrieve the logical die ID with a given PCI
device in both the discovery code and the code that supports a system
with > 8 nodes.

Factor out uncore_device_to_die() to replace the duplicate code.

No functional change.

Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Tested-by: Michael Petlan <mpetlan@redhat.com>
Link: https://lore.kernel.org/r/20230112200105.733466-2-kan.liang@linux.intel.com
---
 arch/x86/events/intel/uncore.c           | 15 +++++++++++++++
 arch/x86/events/intel/uncore.h           |  1 +
 arch/x86/events/intel/uncore_discovery.c | 16 ++--------------
 arch/x86/events/intel/uncore_snbep.c     | 12 +-----------
 4 files changed, 19 insertions(+), 25 deletions(-)

diff --git a/arch/x86/events/intel/uncore.c b/arch/x86/events/intel/uncore.c
index 459b1aa..eeaa92f 100644
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
index e278e2e..8d493be 100644
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
index 5fd72d4..08af92a 100644
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
index 44c2f87..31acc96 100644
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
