Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 40F9560FFB1
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Oct 2022 20:00:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236003AbiJ0SAP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Oct 2022 14:00:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236117AbiJ0R7i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Oct 2022 13:59:38 -0400
Received: from cloudserver094114.home.pl (cloudserver094114.home.pl [79.96.170.134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62E6417F2AD;
        Thu, 27 Oct 2022 10:59:20 -0700 (PDT)
Received: from localhost (127.0.0.1) (HELO v370.home.net.pl)
 by /usr/run/smtp (/usr/run/postfix/private/idea_relay_lmtp) via UNIX with SMTP (IdeaSmtpServer 5.0.0)
 id 3854a3df824a396c; Thu, 27 Oct 2022 19:59:18 +0200
Received: from kreacher.localnet (unknown [213.134.169.45])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by v370.home.net.pl (Postfix) with ESMTPSA id 625BC66D83D;
        Thu, 27 Oct 2022 19:59:17 +0200 (CEST)
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Linux ACPI <linux-acpi@vger.kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Bob Moore <robert.moore@intel.com>
Subject: [PATCH 02/11] ACPICA: Events: Support fixed PCIe wake event
Date:   Thu, 27 Oct 2022 19:48:53 +0200
Message-ID: <3207154.44csPzL39Z@kreacher>
In-Reply-To: <4756726.GXAFRqVoOG@kreacher>
References: <4756726.GXAFRqVoOG@kreacher>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="UTF-8"
X-CLIENT-IP: 213.134.169.45
X-CLIENT-HOSTNAME: 213.134.169.45
X-VADE-SPAMSTATE: clean
X-VADE-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedvgedrtdeggdduudejucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecujffqoffgrffnpdggtffipffknecuuegrihhlohhuthemucduhedtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvfevufffkfgjfhgggfgtsehtufertddttdejnecuhfhrohhmpedftfgrfhgrvghlucflrdcuhgihshhotghkihdfuceorhhjfiesrhhjfiihshhotghkihdrnhgvtheqnecuggftrfgrthhtvghrnhepveehheehueelffeguefgteeuffffgfelhfeghfdvkeffueehteejjeegudeileeknecuffhomhgrihhnpehuvghfihdrohhrghdpghhithhhuhgsrdgtohhmnecukfhppedvudefrddufeegrdduieelrdegheenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpedvudefrddufeegrdduieelrdeghedphhgvlhhopehkrhgvrggthhgvrhdrlhhotggrlhhnvghtpdhmrghilhhfrhhomhepfdftrghfrggvlhculfdrucghhihsohgtkhhifdcuoehrjhifsehrjhifhihsohgtkhhirdhnvghtqedpnhgspghrtghpthhtohepfedprhgtphhtthhopehlihhnuhigqdgrtghpihesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehrohgsvghrthdrmhhoohhrvgesihhnthgvlhdrtghomh
X-DCC--Metrics: v370.home.net.pl 1024; Body=3 Fuz1=3 Fuz2=3
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Huacai Chen <chenhuacai@loongson.cn>

ACPICA commit 32d875705c8ee8f99fd8b78dbed48633486a7640

Some chipsets (such as Loongson's LS7A) support fixed pcie wake event
which is defined in the PM1 block(related description can be found in
4.8.4.1.1 PM1 Status Registers, 4.8.4.2.1 PM1 Control Registers and
5.2.9 Fixed ACPI Description Table (FADT)), so we add code to handle it.

Link: https://uefi.org/specifications/ACPI/6.4/
Link: https://github.com/acpica/acpica/commit/32d87570
Co-developed-by: Jianmin Lv <lvjianmin@loongson.cn>
Signed-off-by: Jianmin Lv <lvjianmin@loongson.cn>
Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>
Signed-off-by: Bob Moore <robert.moore@intel.com>
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/acpi/acpica/evevent.c  |   11 +++++++++++
 drivers/acpi/acpica/hwsleep.c  |   14 ++++++++++++++
 drivers/acpi/acpica/utglobal.c |    4 ++++
 include/acpi/actypes.h         |    3 ++-
 4 files changed, 31 insertions(+), 1 deletion(-)

Index: linux-pm/drivers/acpi/acpica/evevent.c
===================================================================
--- linux-pm.orig/drivers/acpi/acpica/evevent.c
+++ linux-pm/drivers/acpi/acpica/evevent.c
@@ -142,6 +142,9 @@ static acpi_status acpi_ev_fixed_event_i
 			status =
 			    acpi_write_bit_register(acpi_gbl_fixed_event_info
 						    [i].enable_register_id,
+						    (i ==
+						     ACPI_EVENT_PCIE_WAKE) ?
+						    ACPI_ENABLE_EVENT :
 						    ACPI_DISABLE_EVENT);
 			if (ACPI_FAILURE(status)) {
 				return (status);
@@ -185,6 +188,11 @@ u32 acpi_ev_fixed_event_detect(void)
 		return (int_status);
 	}
 
+	if (fixed_enable & ACPI_BITMASK_PCIEXP_WAKE_DISABLE)
+		fixed_enable &= ~ACPI_BITMASK_PCIEXP_WAKE_DISABLE;
+	else
+		fixed_enable |= ACPI_BITMASK_PCIEXP_WAKE_DISABLE;
+
 	ACPI_DEBUG_PRINT((ACPI_DB_INTERRUPTS,
 			  "Fixed Event Block: Enable %08X Status %08X\n",
 			  fixed_enable, fixed_status));
@@ -250,6 +258,9 @@ static u32 acpi_ev_fixed_event_dispatch(
 	if (!acpi_gbl_fixed_event_handlers[event].handler) {
 		(void)acpi_write_bit_register(acpi_gbl_fixed_event_info[event].
 					      enable_register_id,
+					      (event ==
+					       ACPI_EVENT_PCIE_WAKE) ?
+					      ACPI_ENABLE_EVENT :
 					      ACPI_DISABLE_EVENT);
 
 		ACPI_ERROR((AE_INFO,
Index: linux-pm/drivers/acpi/acpica/hwsleep.c
===================================================================
--- linux-pm.orig/drivers/acpi/acpica/hwsleep.c
+++ linux-pm/drivers/acpi/acpica/hwsleep.c
@@ -311,6 +311,20 @@ acpi_status acpi_hw_legacy_wake(u8 sleep
 				    [ACPI_EVENT_SLEEP_BUTTON].
 				    status_register_id, ACPI_CLEAR_STATUS);
 
+	/* Enable pcie wake event if support */
+	if ((acpi_gbl_FADT.flags & ACPI_FADT_PCI_EXPRESS_WAKE)) {
+		(void)
+		    acpi_write_bit_register(acpi_gbl_fixed_event_info
+					    [ACPI_EVENT_PCIE_WAKE].
+					    enable_register_id,
+					    ACPI_DISABLE_EVENT);
+		(void)
+		    acpi_write_bit_register(acpi_gbl_fixed_event_info
+					    [ACPI_EVENT_PCIE_WAKE].
+					    status_register_id,
+					    ACPI_CLEAR_STATUS);
+	}
+
 	acpi_hw_execute_sleep_method(METHOD_PATHNAME__SST, ACPI_SST_WORKING);
 	return_ACPI_STATUS(status);
 }
Index: linux-pm/drivers/acpi/acpica/utglobal.c
===================================================================
--- linux-pm.orig/drivers/acpi/acpica/utglobal.c
+++ linux-pm/drivers/acpi/acpica/utglobal.c
@@ -186,6 +186,10 @@ struct acpi_fixed_event_info acpi_gbl_fi
 					ACPI_BITREG_RT_CLOCK_ENABLE,
 					ACPI_BITMASK_RT_CLOCK_STATUS,
 					ACPI_BITMASK_RT_CLOCK_ENABLE},
+	/* ACPI_EVENT_PCIE_WAKE     */ {ACPI_BITREG_PCIEXP_WAKE_STATUS,
+					ACPI_BITREG_PCIEXP_WAKE_DISABLE,
+					ACPI_BITMASK_PCIEXP_WAKE_STATUS,
+					ACPI_BITMASK_PCIEXP_WAKE_DISABLE},
 };
 #endif				/* !ACPI_REDUCED_HARDWARE */
 
Index: linux-pm/include/acpi/actypes.h
===================================================================
--- linux-pm.orig/include/acpi/actypes.h
+++ linux-pm/include/acpi/actypes.h
@@ -723,7 +723,8 @@ typedef u32 acpi_event_type;
 #define ACPI_EVENT_POWER_BUTTON         2
 #define ACPI_EVENT_SLEEP_BUTTON         3
 #define ACPI_EVENT_RTC                  4
-#define ACPI_EVENT_MAX                  4
+#define ACPI_EVENT_PCIE_WAKE            5
+#define ACPI_EVENT_MAX                  5
 #define ACPI_NUM_FIXED_EVENTS           ACPI_EVENT_MAX + 1
 
 /*



