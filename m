Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A41AB744E9A
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Jul 2023 18:28:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229908AbjGBQ2U (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 2 Jul 2023 12:28:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229644AbjGBQ2T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Jul 2023 12:28:19 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B406E60;
        Sun,  2 Jul 2023 09:28:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1688315298; x=1719851298;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=gE63mQxX2uqiJxp4/cma47DCCu39/6Y8JQQErQ+uM4g=;
  b=J/o9vRDxJuUzAtZC5eajg/NJ9T38/gjZ09luWFvMDyDwp9N+uRrq8jPf
   iF562pP1bPPnJomEgEGcu7RWmtrbboB4yfgXnZgQ2a07xTvDJoJSqePww
   dDAUArijX92wR/Q6JEszfBbqQ/n6c7qGhPuzWsYoHoFN/XpFrLNaAq5LU
   A4MwOEYPKHyzagVXW6Yl08uFesyKiTI3jZX16uehoXz8bCrVadd1uIJos
   NVDPgjwwwTxKTHp3n2a1ft9WzuK53KNL8NxOOaQ+0Nilu0AfGa0tKS9HT
   eFK9emxekfqqk0o9LpLu5NjTv2Ikw4455z47NqPzZeZjHK+ktsxAZyIul
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10759"; a="347494892"
X-IronPort-AV: E=Sophos;i="6.01,176,1684825200"; 
   d="scan'208";a="347494892"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jul 2023 09:28:17 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10759"; a="892310312"
X-IronPort-AV: E=Sophos;i="6.01,176,1684825200"; 
   d="scan'208";a="892310312"
Received: from zhaoqion-mobl.ccr.corp.intel.com (HELO rzhang1-mobl7.ccr.corp.intel.com) ([10.254.209.232])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jul 2023 09:28:14 -0700
From:   Zhang Rui <rui.zhang@intel.com>
To:     tglx@linutronix.de, peterz@infradead.org, bp@alien8.de,
        rafael.j.wysocki@intel.com
Cc:     linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org,
        x86@kernel.org, feng.tang@intel.com
Subject: [RFC PATCH] x86/acpi: Ignore invalid x2APIC entries
Date:   Mon,  3 Jul 2023 00:28:02 +0800
Message-Id: <20230702162802.344176-1-rui.zhang@intel.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently, kernel enumerates the possible CPUs by parsing both ACPI MADT
Local APIC entries and x2APIC entries. So CPUs with "valid" APIC IDs,
even if they have duplicated APIC IDs in Local APIC and x2APIC, are
always enumerated.

Below is what ACPI MADT Local APIC and x2APIC describes on an
Ivebridge-EP system,

[02Ch 0044   1]                Subtable Type : 00 [Processor Local APIC]
[02Fh 0047   1]                Local Apic ID : 00
...
[164h 0356   1]                Subtable Type : 00 [Processor Local APIC]
[167h 0359   1]                Local Apic ID : 39
[16Ch 0364   1]                Subtable Type : 00 [Processor Local APIC]
[16Fh 0367   1]                Local Apic ID : FF
...
[3ECh 1004   1]                Subtable Type : 09 [Processor Local x2APIC]
[3F0h 1008   4]                Processor x2Apic ID : 00000000
...
[B5Ch 2908   1]                Subtable Type : 09 [Processor Local x2APIC]
[B60h 2912   4]                Processor x2Apic ID : 00000077

As a result, kernel shows "smpboot: Allowing 168 CPUs, 120 hotplug CPUs".
And this wastes significant amount of memory for the per-cpu data.
Plus this also breaks https://lore.kernel.org/all/87edm36qqb.ffs@tglx/,
because __max_logical_packages is over-estimated by the APIC IDs in
the x2APIC entries.

According to https://uefi.org/specs/ACPI/6.5/05_ACPI_Software_Programming_Model.html#processor-local-x2apic-structure,
"[Compatibility note] On some legacy OSes, Logical processors with APIC
ID values less than 255 (whether in XAPIC or X2APIC mode) must use the
Processor Local APIC structure to convey their APIC information to OSPM,
and those processors must be declared in the DSDT using the Processor()
keyword. Logical processors with APIC ID values 255 and greater must use
the Processor Local x2APIC structure and be declared using the Device()
keyword.".

Enumerate CPUs from x2APIC enties with APIC ID values 255 or greater,
when valid CPU from Local APIC is already detected.

Signed-off-by: Zhang Rui <rui.zhang@intel.com>
---
I didn't find any clear statement in the ACPI spec about if a mixture of
Local APIC and x2APIC entries is allowed or not. So it would be great if
this can be clarified.

And FYI, I have auditted a series of Intel servers, and one IVB-EP in
LKP lab and one IVB-EP from PeterZ are the only ones with a mixture of
Local APIC entries + x2APIC entries.

Plat    Status
IVB-EP  valid LAPIC + invalid LAPIC (APIC ID 0xFF) + unknown x2APIC entries (valid APIC ID + Enable bit cleared)
IVB-EP  valid LAPIC + invalid LAPIC (APIC ID 0xFF) + unknown x2APIC entries (valid APIC ID + Enable bit cleared)
CLX     valid LAPIC + invalid LAPIC (APIC ID 0xFF) + invalid x2APIC entries (APIC ID 0xFFFFFFFF)
CLX     valid LAPIC + invalid LAPIC (APIC ID 0xFF) + invalid x2APIC entries (APIC ID 0xFFFFFFFF)
ICX     valid LAPIC only
SPR     valid LAPIC only
SPR     valid x2APIC only
---
 arch/x86/kernel/acpi/boot.c | 35 ++++++++++++++++++-----------------
 1 file changed, 18 insertions(+), 17 deletions(-)

diff --git a/arch/x86/kernel/acpi/boot.c b/arch/x86/kernel/acpi/boot.c
index 21b542a6866c..a41124d58e29 100644
--- a/arch/x86/kernel/acpi/boot.c
+++ b/arch/x86/kernel/acpi/boot.c
@@ -204,6 +204,8 @@ static bool __init acpi_is_processor_usable(u32 lapic_flags)
 	return false;
 }
 
+static bool has_lapic_cpus;
+
 static int __init
 acpi_parse_x2apic(union acpi_subtable_headers *header, const unsigned long end)
 {
@@ -232,6 +234,14 @@ acpi_parse_x2apic(union acpi_subtable_headers *header, const unsigned long end)
 	if (!acpi_is_processor_usable(processor->lapic_flags))
 		return 0;
 
+	/*
+	 * According to https://uefi.org/specs/ACPI/6.5/05_ACPI_Software_Programming_Model.html#processor-local-x2apic-structure
+	 * when MADT provides both valid LAPIC and x2APIC entries, the APIC ID
+	 * in x2APIC must be equal or greater than 0xff.
+	 */
+	if (has_lapic_cpus && apic_id < 0xff)
+		return 0;
+
 	/*
 	 * We need to register disabled CPU as well to permit
 	 * counting disabled CPUs. This allows us to size
@@ -257,6 +267,7 @@ static int __init
 acpi_parse_lapic(union acpi_subtable_headers * header, const unsigned long end)
 {
 	struct acpi_madt_local_apic *processor = NULL;
+	int cpu;
 
 	processor = (struct acpi_madt_local_apic *)header;
 
@@ -280,10 +291,11 @@ acpi_parse_lapic(union acpi_subtable_headers * header, const unsigned long end)
 	 * to not preallocating memory for all NR_CPUS
 	 * when we use CPU hotplug.
 	 */
-	acpi_register_lapic(processor->id,	/* APIC ID */
+	cpu = acpi_register_lapic(processor->id,	/* APIC ID */
 			    processor->processor_id, /* ACPI ID */
 			    processor->lapic_flags & ACPI_MADT_ENABLED);
-
+	if (cpu >= 0)
+		has_lapic_cpus = true;
 	return 0;
 }
 
@@ -1123,21 +1135,10 @@ static int __init acpi_parse_madt_lapic_entries(void)
 				      acpi_parse_sapic, MAX_LOCAL_APIC);
 
 	if (!count) {
-		memset(madt_proc, 0, sizeof(madt_proc));
-		madt_proc[0].id = ACPI_MADT_TYPE_LOCAL_APIC;
-		madt_proc[0].handler = acpi_parse_lapic;
-		madt_proc[1].id = ACPI_MADT_TYPE_LOCAL_X2APIC;
-		madt_proc[1].handler = acpi_parse_x2apic;
-		ret = acpi_table_parse_entries_array(ACPI_SIG_MADT,
-				sizeof(struct acpi_table_madt),
-				madt_proc, ARRAY_SIZE(madt_proc), MAX_LOCAL_APIC);
-		if (ret < 0) {
-			pr_err("Error parsing LAPIC/X2APIC entries\n");
-			return ret;
-		}
-
-		count = madt_proc[0].count;
-		x2count = madt_proc[1].count;
+		count = acpi_table_parse_madt(ACPI_MADT_TYPE_LOCAL_APIC,
+					acpi_parse_lapic, MAX_LOCAL_APIC);
+		x2count = acpi_table_parse_madt(ACPI_MADT_TYPE_LOCAL_X2APIC,
+					acpi_parse_x2apic, MAX_LOCAL_APIC);
 	}
 	if (!count && !x2count) {
 		pr_err("No LAPIC entries present\n");
-- 
2.34.1

