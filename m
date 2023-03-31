Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 189066D2BDA
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Apr 2023 01:54:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232975AbjCaXyp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 31 Mar 2023 19:54:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232787AbjCaXyn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Mar 2023 19:54:43 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56AC21C1F0
        for <linux-kernel@vger.kernel.org>; Fri, 31 Mar 2023 16:54:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1680306840;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=t5RvZXymu9JjN9l2ZeWTOkKU3lIJM23nGwOWxytWHx4=;
        b=heqGEfywyDXpLz9flXAqHmoKSPRzTu+v2M18EDgyhoFbZnp6XEJ2noqTUejkfLr8dXQL5P
        2IoLJdRdaAeRZH+3zh/gYgfQnxZptVdLFuGqY0ngZDK3LhVFWkQVdKuejq5IRGHjZj7HEj
        PVSFJLWJwNSzLr7Iyy+0Lx/wlOZf2c0=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-442-RuBk5MlbNaKHJDEZdN00Ow-1; Fri, 31 Mar 2023 19:53:56 -0400
X-MC-Unique: RuBk5MlbNaKHJDEZdN00Ow-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id A07F32A59547;
        Fri, 31 Mar 2023 23:53:55 +0000 (UTC)
Received: from emerald.redhat.com (unknown [10.22.32.129])
        by smtp.corp.redhat.com (Postfix) with ESMTP id AC5B618EC7;
        Fri, 31 Mar 2023 23:53:54 +0000 (UTC)
From:   Lyude Paul <lyude@redhat.com>
To:     linux-acpi@vger.kernel.org
Cc:     Leo Duran <leo.duran@amd.com>,
        Kishon Vijay Abraham I <kvijayab@amd.com>,
        Borislav Petkov <bp@alien8.de>,
        Zhang Rui <rui.zhang@intel.com>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        x86@kernel.org (maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)),
        "H. Peter Anvin" <hpa@zytor.com>,
        linux-kernel@vger.kernel.org (open list:X86 ARCHITECTURE (32-BIT AND
        64-BIT))
Subject: [PATCH] Revert "x86/acpi/boot: Do not register processors that cannot be onlined for x2APIC"
Date:   Fri, 31 Mar 2023 19:53:28 -0400
Message-Id: <20230331235328.4312-1-lyude@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.5
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This reverts commit e2869bd7af608c343988429ceb1c2fe99644a01f. This commit
unfortunately seems to have resulted in one of my machines no longer
booting. Specifically, this machine is a custom build with a MS-7A39/A320M
GAMING PRO motherboard with firmware version v1.10. I'm not entirely sure
of the cause yet, but starting it up with "earlycon=efifb keep_bootcon" has
informed me that the kernel panics like so:

Call Trace:
  <TASK>
  dump_stack_lvl+0x33/0x46
  panic+0x105/0x2b1
  ? timer_irq_works+0x53/0xef
  panic_if_irq_remap.cold+0x5/0x5
  setup_IO_APIC+0x3c4/0x831
  ? __pfx_native_io_apic_read+0x10/0x10
  ? __ioapic_read_entry+0x34/0x50
  ? _raw_spin_unlock_irqrestore+0x1b/0x40
  ? clear_IO_APIC_pin+0x16b/0x240
  apic_intr_mode_init+0x101/0x106
  x86_late_time_init+0x20/0x34
  start_kernel+0x8b4/0x95f
  secondary_startup_64_no_verify+0x5e/0xeb
  </TASK>
---[ end Kernel panic - not syncing: timer doesn't work through
 interrupt-mapped IO-APIC ]---

My assumption is there's probably something funky with the firmware on the
machine seeing as it's a random gaming motherboard, but that also probably
means there are other boards out there like this that are cold, afraid, and
unable to boot. We could warm their hearts by reverting this, or maybe by
figuring out a proper fix.

Signed-off-by: Lyude Paul <lyude@redhat.com>
Fixes: e2869bd7af60 ("x86/acpi/boot: Do not register processors that cannot be onlined for x2APIC")
Cc: Leo Duran <leo.duran@amd.com>
Cc: Kishon Vijay Abraham I <kvijayab@amd.com>
Cc: Borislav Petkov (AMD) <bp@alien8.de>
Cc: Zhang Rui <rui.zhang@intel.com>
Cc: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Len Brown <lenb@kernel.org>
Cc: linux-acpi@vger.kernel.org
---
 arch/x86/kernel/acpi/boot.c | 19 +++----------------
 1 file changed, 3 insertions(+), 16 deletions(-)

diff --git a/arch/x86/kernel/acpi/boot.c b/arch/x86/kernel/acpi/boot.c
index 1c38174b5f019..4177577c173bf 100644
--- a/arch/x86/kernel/acpi/boot.c
+++ b/arch/x86/kernel/acpi/boot.c
@@ -188,17 +188,6 @@ static int acpi_register_lapic(int id, u32 acpiid, u8 enabled)
 	return cpu;
 }
 
-static bool __init acpi_is_processor_usable(u32 lapic_flags)
-{
-	if (lapic_flags & ACPI_MADT_ENABLED)
-		return true;
-
-	if (acpi_support_online_capable && (lapic_flags & ACPI_MADT_ONLINE_CAPABLE))
-		return true;
-
-	return false;
-}
-
 static int __init
 acpi_parse_x2apic(union acpi_subtable_headers *header, const unsigned long end)
 {
@@ -223,10 +212,6 @@ acpi_parse_x2apic(union acpi_subtable_headers *header, const unsigned long end)
 	if (apic_id == 0xffffffff)
 		return 0;
 
-	/* don't register processors that cannot be onlined */
-	if (!acpi_is_processor_usable(processor->lapic_flags))
-		return 0;
-
 	/*
 	 * We need to register disabled CPU as well to permit
 	 * counting disabled CPUs. This allows us to size
@@ -265,7 +250,9 @@ acpi_parse_lapic(union acpi_subtable_headers * header, const unsigned long end)
 		return 0;
 
 	/* don't register processors that can not be onlined */
-	if (!acpi_is_processor_usable(processor->lapic_flags))
+	if (acpi_support_online_capable &&
+	    !(processor->lapic_flags & ACPI_MADT_ENABLED) &&
+	    !(processor->lapic_flags & ACPI_MADT_ONLINE_CAPABLE))
 		return 0;
 
 	/*
-- 
2.39.2

