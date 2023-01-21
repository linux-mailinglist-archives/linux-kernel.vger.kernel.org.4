Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 234BE67657A
	for <lists+linux-kernel@lfdr.de>; Sat, 21 Jan 2023 10:49:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229853AbjAUJtm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 21 Jan 2023 04:49:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229631AbjAUJtd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 Jan 2023 04:49:33 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 987725B581;
        Sat, 21 Jan 2023 01:49:31 -0800 (PST)
Date:   Sat, 21 Jan 2023 09:49:26 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1674294566;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=EhUGzAZN0FJQccp+JfzAobzdaGMczhgrP4tXmZAaRRQ=;
        b=QIXeI/Vg2dVr7hbrsPI4eZ+7SYTek9l/ViLZKAVFGhFNkgOaP0wkwL2bKIxF7278/88wrz
        l1jJfdrUliPeqbQOPD6zeqEgioBg/UjajrlSo8vMIZewkVQf7RHwhwE5ukupVtFgf7MBGE
        u3VWYUf6gu8lASzEv2+l4IM1LtvNjtr/nTIYoQZjvaSOT4dZPLbwzsg4cVifnkRd2TPZHz
        5QMwPGtXgOuqEdjcvLL8KOn1uNrZGXc5cPT71kWF8hsZoAqivRbIhSd/vvCoCvggJI4Xcx
        jcfiNbGMYkQw/+9YihTJLfEi9PtRlAK/Chsg83Pkdy3t8puRZIeIX5eJL6CFnw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1674294566;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=EhUGzAZN0FJQccp+JfzAobzdaGMczhgrP4tXmZAaRRQ=;
        b=Xt5gM/4cUlhu+uzCIgSp8hzKIWTPjtCeO6uOzAsPxoPEnxOCxV0hhOBzWqkcTlCkG/IMik
        pkOtWgAYJGelJdDg==
From:   "tip-bot2 for Kan Liang" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: perf/core] perf/x86/uncore: Ignore broken units in discovery table
Cc:     Kan Liang <kan.liang@linux.intel.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Michael Petlan <mpetlan@redhat.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20230112200105.733466-4-kan.liang@linux.intel.com>
References: <20230112200105.733466-4-kan.liang@linux.intel.com>
MIME-Version: 1.0
Message-ID: <167429456602.4906.2438264462801813993.tip-bot2@tip-bot2>
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

Commit-ID:     bd9514a4d5ec25b29728720ca8b3a9ac4e3137d7
Gitweb:        https://git.kernel.org/tip/bd9514a4d5ec25b29728720ca8b3a9ac4e3137d7
Author:        Kan Liang <kan.liang@linux.intel.com>
AuthorDate:    Thu, 12 Jan 2023 12:01:03 -08:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Sat, 21 Jan 2023 00:06:12 +01:00

perf/x86/uncore: Ignore broken units in discovery table

Some units in a discovery table may be broken, e.g., UPI of SPR MCC.
A generic method is required to ignore the broken units.

Add uncore_units_ignore in the struct intel_uncore_init_fun, which
indicates the type ID of broken units. It will be assigned by the
platform-specific code later when the platform has a broken discovery
table.

Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Tested-by: Michael Petlan <mpetlan@redhat.com>
Link: https://lore.kernel.org/r/20230112200105.733466-4-kan.liang@linux.intel.com
---
 arch/x86/events/intel/uncore.c           |  8 +++++--
 arch/x86/events/intel/uncore.h           |  2 ++-
 arch/x86/events/intel/uncore_discovery.c | 26 ++++++++++++++++++++---
 arch/x86/events/intel/uncore_discovery.h |  2 +-
 4 files changed, 32 insertions(+), 6 deletions(-)

diff --git a/arch/x86/events/intel/uncore.c b/arch/x86/events/intel/uncore.c
index 271c016..d9a2ef5 100644
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
@@ -1874,7 +1877,7 @@ static int __init intel_uncore_init(void)
 
 	id = x86_match_cpu(intel_uncore_match);
 	if (!id) {
-		if (!uncore_no_discover && intel_uncore_has_discovery_tables())
+		if (!uncore_no_discover && intel_uncore_has_discovery_tables(NULL))
 			uncore_init = (struct intel_uncore_init_fun *)&generic_uncore_init;
 		else
 			return -ENODEV;
@@ -1882,7 +1885,8 @@ static int __init intel_uncore_init(void)
 		uncore_init = (struct intel_uncore_init_fun *)id->driver_data;
 		if (uncore_no_discover && uncore_init->use_discovery)
 			return -ENODEV;
-		if (uncore_init->use_discovery && !intel_uncore_has_discovery_tables())
+		if (uncore_init->use_discovery &&
+		    !intel_uncore_has_discovery_tables(uncore_init->uncore_units_ignore))
 			return -ENODEV;
 	}
 
diff --git a/arch/x86/events/intel/uncore.h b/arch/x86/events/intel/uncore.h
index 8d493be..bbaa57c 100644
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
index 08af92a..abb5119 100644
--- a/arch/x86/events/intel/uncore_discovery.c
+++ b/arch/x86/events/intel/uncore_discovery.c
@@ -190,8 +190,25 @@ free_box_offset:
 
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
index f443935..4163702 100644
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
