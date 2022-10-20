Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A9A4605F7C
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Oct 2022 13:57:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229760AbiJTL47 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Oct 2022 07:56:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229757AbiJTL4y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Oct 2022 07:56:54 -0400
Received: from out0.migadu.com (out0.migadu.com [IPv6:2001:41d0:2:267::])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E120F134DEB
        for <linux-kernel@vger.kernel.org>; Thu, 20 Oct 2022 04:56:47 -0700 (PDT)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1666267005;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=h1eg7lftjZwHwlpEPa2PsbvY+k99P5M493CYWmMhT+A=;
        b=xf9AYapUBZUAGvR3RM/0QQx+r4Tq4xSLh6VVr3HNNhTd8MlciibOzWzz6dChqyjCUQv0xP
        Pyn5bEHKcBAc9ZMNQAoB3K+YgfgUEvTdM0l0g3whJ6x4PCUsBiV2BiiiX0VYdBiJYBZCWA
        5ASBtXK667niNnJ1zYxgS7BLuxd17gE=
From:   Yajun Deng <yajun.deng@linux.dev>
To:     tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, hpa@zytor.com
Cc:     noodles@fb.com, ross.philipson@oracle.com, daniel.kiper@oracle.com,
        x86@kernel.org, linux-kernel@vger.kernel.org,
        Yajun Deng <yajun.deng@linux.dev>
Subject: [PATCH] x86/e820: make e820 type string uniform
Date:   Thu, 20 Oct 2022 19:56:09 +0800
Message-Id: <20221020115609.223940-1-yajun.deng@linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

These e820_print_type() and e820_type_to_string() functions are similar,
the former used in dmesg and the latter used in /proc/iomem.

Make them uniform, so that we can find the correspondence between dmesg
and /proc/iomem.

It may be confusing in dmesg. The e820 type update seems no change, but
the log like that:
...
[    0.000000] e820: update [mem 0x81004018-0x81023c57] usable ==> usable
[    0.000000] e820: update [mem 0x81004018-0x81023c57] usable ==> usable
[    0.000000] e820: update [mem 0x80ff3018-0x81003e57] usable ==> usable
[    0.000000] e820: update [mem 0x80ff3018-0x81003e57] usable ==> usable
...

Another confusion in /proc/iomem, the continuous area may be divided
into multiple parts, but they have same name, like that:

...
00100000-80ff3017 : System RAM
80ff3018-81003e57 : System RAM
81003e58-81004017 : System RAM
81004018-81023c57 : System RAM
81023c58-87672fff : System RAM
...

Separate the string of E820_TYPE_RESERVED_KERN and E820_TYPE_RAM, this
makes more clearer.

After patch:
dmesg:
...
[    0.000000] BIOS-provided physical RAM map:
[    0.000000] BIOS-e820: [mem 0x0000000000000000-0x000000000005efff] System RAM
[    0.000000] BIOS-e820: [mem 0x000000000005f000-0x000000000005ffff] Reserved
[    0.000000] BIOS-e820: [mem 0x0000000000060000-0x000000000009ffff] System RAM
[    0.000000] BIOS-e820: [mem 0x00000000000a0000-0x00000000000fffff] Reserved
[    0.000000] BIOS-e820: [mem 0x0000000000100000-0x000000008c7b5fff] System RAM
[    0.000000] BIOS-e820: [mem 0x000000008c7b6000-0x000000008e025fff] Reserved
[    0.000000] BIOS-e820: [mem 0x000000008e026000-0x000000008e200fff] ACPI Tables
[    0.000000] BIOS-e820: [mem 0x000000008e201000-0x000000008e689fff] ACPI Non-volatile Storage
[    0.000000] BIOS-e820: [mem 0x000000008e68a000-0x000000008f40dfff] Reserved
[    0.000000] BIOS-e820: [mem 0x000000008f40e000-0x000000008f40efff] System RAM
[    0.000000] BIOS-e820: [mem 0x000000008f40f000-0x000000008fffffff] Reserved
[    0.000000] BIOS-e820: [mem 0x00000000e0000000-0x00000000efffffff] Reserved
[    0.000000] BIOS-e820: [mem 0x00000000fe000000-0x00000000fe010fff] Reserved
[    0.000000] BIOS-e820: [mem 0x00000000fec00000-0x00000000fec00fff] Reserved
[    0.000000] BIOS-e820: [mem 0x00000000fed00000-0x00000000fed03fff] Reserved
[    0.000000] BIOS-e820: [mem 0x00000000fee00000-0x00000000fee00fff] Reserved
[    0.000000] BIOS-e820: [mem 0x00000000ff000000-0x00000000ffffffff] Reserved
[    0.000000] BIOS-e820: [mem 0x0000000100000000-0x000000086dffffff] System RAM
[    0.000000] NX (Execute Disable) protection: active
[    0.000000] e820: update [mem 0x81004018-0x81023c57] System RAM ==> System RAM (kernel)
[    0.000000] e820: update [mem 0x81004018-0x81023c57] System RAM ==> System RAM (kernel)
[    0.000000] e820: update [mem 0x80ff3018-0x81003e57] System RAM ==> System RAM (kernel)
[    0.000000] e820: update [mem 0x80ff3018-0x81003e57] System RAM ==> System RAM (kernel)
...

/proc/iomem:
...
00000000-00000fff : Reserved
00001000-0005efff : System RAM
0005f000-0005ffff : Reserved
00060000-0009ffff : System RAM
000a0000-000fffff : Reserved
  000a0000-000bffff : PCI Bus 0000:00
  000c0000-000cddff : Video ROM
  000f0000-000fffff : System ROM
00100000-80ff3017 : System RAM
80ff3018-81003e57 : System RAM (kernel)
81003e58-81004017 : System RAM
81004018-81023c57 : System RAM (kernel)
81023c58-87672fff : System RAM
...

Signed-off-by: Yajun Deng <yajun.deng@linux.dev>
---
 arch/x86/kernel/e820.c | 54 ++++++++++++++----------------------------
 1 file changed, 18 insertions(+), 36 deletions(-)

diff --git a/arch/x86/kernel/e820.c b/arch/x86/kernel/e820.c
index 9dac24680ff8..8a0fb22bd740 100644
--- a/arch/x86/kernel/e820.c
+++ b/arch/x86/kernel/e820.c
@@ -184,19 +184,19 @@ void __init e820__range_add(u64 start, u64 size, enum e820_type type)
 	__e820__range_add(e820_table, start, size, type);
 }
 
-static void __init e820_print_type(enum e820_type type)
+static const char *__init e820_type_to_string(enum e820_type type)
 {
 	switch (type) {
-	case E820_TYPE_RAM:		/* Fall through: */
-	case E820_TYPE_RESERVED_KERN:	pr_cont("usable");			break;
-	case E820_TYPE_RESERVED:	pr_cont("reserved");			break;
-	case E820_TYPE_SOFT_RESERVED:	pr_cont("soft reserved");		break;
-	case E820_TYPE_ACPI:		pr_cont("ACPI data");			break;
-	case E820_TYPE_NVS:		pr_cont("ACPI NVS");			break;
-	case E820_TYPE_UNUSABLE:	pr_cont("unusable");			break;
-	case E820_TYPE_PMEM:		/* Fall through: */
-	case E820_TYPE_PRAM:		pr_cont("persistent (type %u)", type);	break;
-	default:			pr_cont("type %u", type);		break;
+	case E820_TYPE_RESERVED_KERN:	return "System RAM (kernel)";
+	case E820_TYPE_RAM:		return "System RAM";
+	case E820_TYPE_ACPI:		return "ACPI Tables";
+	case E820_TYPE_NVS:		return "ACPI Non-volatile Storage";
+	case E820_TYPE_UNUSABLE:	return "Unusable memory";
+	case E820_TYPE_PRAM:		return "Persistent Memory (legacy)";
+	case E820_TYPE_PMEM:		return "Persistent Memory";
+	case E820_TYPE_RESERVED:	return "Reserved";
+	case E820_TYPE_SOFT_RESERVED:	return "Soft Reserved";
+	default:			return "Unknown E820 type";
 	}
 }
 
@@ -210,8 +210,7 @@ void __init e820__print_table(char *who)
 			e820_table->entries[i].addr,
 			e820_table->entries[i].addr + e820_table->entries[i].size - 1);
 
-		e820_print_type(e820_table->entries[i].type);
-		pr_cont("\n");
+		pr_info("%s\n", e820_type_to_string(e820_table->entries[i].type));
 	}
 }
 
@@ -473,10 +472,8 @@ __e820__range_update(struct e820_table *table, u64 start, u64 size, enum e820_ty
 
 	end = start + size;
 	printk(KERN_DEBUG "e820: update [mem %#010Lx-%#010Lx] ", start, end - 1);
-	e820_print_type(old_type);
-	pr_cont(" ==> ");
-	e820_print_type(new_type);
-	pr_cont("\n");
+	pr_info("%s ==> %s\n", e820_type_to_string(old_type),
+		e820_type_to_string(new_type));
 
 	for (i = 0; i < table->nr_entries; i++) {
 		struct e820_entry *entry = &table->entries[i];
@@ -550,7 +547,7 @@ u64 __init e820__range_remove(u64 start, u64 size, enum e820_type old_type, bool
 	end = start + size;
 	printk(KERN_DEBUG "e820: remove [mem %#010Lx-%#010Lx] ", start, end - 1);
 	if (check_type)
-		e820_print_type(old_type);
+		pr_info("%s", e820_type_to_string(old_type));
 	pr_cont("\n");
 
 	for (i = 0; i < e820_table->nr_entries; i++) {
@@ -1071,22 +1068,6 @@ void __init e820__finish_early_params(void)
 	}
 }
 
-static const char *__init e820_type_to_string(struct e820_entry *entry)
-{
-	switch (entry->type) {
-	case E820_TYPE_RESERVED_KERN:	/* Fall-through: */
-	case E820_TYPE_RAM:		return "System RAM";
-	case E820_TYPE_ACPI:		return "ACPI Tables";
-	case E820_TYPE_NVS:		return "ACPI Non-volatile Storage";
-	case E820_TYPE_UNUSABLE:	return "Unusable memory";
-	case E820_TYPE_PRAM:		return "Persistent Memory (legacy)";
-	case E820_TYPE_PMEM:		return "Persistent Memory";
-	case E820_TYPE_RESERVED:	return "Reserved";
-	case E820_TYPE_SOFT_RESERVED:	return "Soft Reserved";
-	default:			return "Unknown E820 type";
-	}
-}
-
 static unsigned long __init e820_type_to_iomem_type(struct e820_entry *entry)
 {
 	switch (entry->type) {
@@ -1174,7 +1155,7 @@ void __init e820__reserve_resources(void)
 		}
 		res->start = entry->addr;
 		res->end   = end;
-		res->name  = e820_type_to_string(entry);
+		res->name  = e820_type_to_string(entry->type);
 		res->flags = e820_type_to_iomem_type(entry);
 		res->desc  = e820_type_to_iores_desc(entry);
 
@@ -1194,7 +1175,8 @@ void __init e820__reserve_resources(void)
 	for (i = 0; i < e820_table_firmware->nr_entries; i++) {
 		struct e820_entry *entry = e820_table_firmware->entries + i;
 
-		firmware_map_add_early(entry->addr, entry->addr + entry->size, e820_type_to_string(entry));
+		firmware_map_add_early(entry->addr,
+			entry->addr + entry->size, e820_type_to_string(entry->type));
 	}
 }
 
-- 
2.25.1

