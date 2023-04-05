Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 42B476D7E48
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Apr 2023 16:00:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237579AbjDEOAq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Apr 2023 10:00:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237980AbjDEOAl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Apr 2023 10:00:41 -0400
Received: from cloudserver094114.home.pl (cloudserver094114.home.pl [79.96.170.134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D961AE5D;
        Wed,  5 Apr 2023 07:00:39 -0700 (PDT)
Received: from localhost (127.0.0.1) (HELO v370.home.net.pl)
 by /usr/run/smtp (/usr/run/postfix/private/idea_relay_lmtp) via UNIX with SMTP (IdeaSmtpServer 5.1.0)
 id 6ad874797a78371e; Wed, 5 Apr 2023 16:00:38 +0200
Received: from kreacher.localnet (unknown [213.134.163.219])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by v370.home.net.pl (Postfix) with ESMTPSA id 7E7D81B4EA57;
        Wed,  5 Apr 2023 16:00:37 +0200 (CEST)
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Linux ACPI <linux-acpi@vger.kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Bob Moore <robert.moore@intel.com>
Subject: [PATCH 31/32] ACPICA: add os specific support for Zephyr RTOS
Date:   Wed, 05 Apr 2023 15:59:00 +0200
Message-ID: <6519395.G0QQBjFxQf@kreacher>
In-Reply-To: <4845957.31r3eYUQgx@kreacher>
References: <4845957.31r3eYUQgx@kreacher>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="UTF-8"
X-CLIENT-IP: 213.134.163.219
X-CLIENT-HOSTNAME: 213.134.163.219
X-VADE-SPAMSTATE: clean
X-VADE-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedvhedrvdejuddgjeduucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecujffqoffgrffnpdggtffipffknecuuegrihhlohhuthemucduhedtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvfevufffkfgjfhgggfgtsehtufertddttdejnecuhfhrohhmpedftfgrfhgrvghlucflrdcuhgihshhotghkihdfuceorhhjfiesrhhjfiihshhotghkihdrnhgvtheqnecuggftrfgrthhtvghrnhepledtieekkeekveeikeetgffgteeuteefjeevjeegudelvdduheeiuedvieehieevnecuffhomhgrihhnpehgihhthhhusgdrtghomhenucfkphepvddufedrudefgedrudeifedrvdduleenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpedvudefrddufeegrdduieefrddvudelpdhhvghlohepkhhrvggrtghhvghrrdhlohgtrghlnhgvthdpmhgrihhlfhhrohhmpedftfgrfhgrvghlucflrdcuhgihshhotghkihdfuceorhhjfiesrhhjfiihshhotghkihdrnhgvtheqpdhnsggprhgtphhtthhopeefpdhrtghpthhtoheplhhinhhugidqrggtphhisehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheprhhosggvrhhtrdhmohhorhgvsehinhhtvghlrdgtohhm
X-DCC--Metrics: v370.home.net.pl 1024; Body=3 Fuz1=3 Fuz2=3
X-Spam-Status: No, score=0.0 required=5.0 tests=SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Najumon <najumon.ba@intel.com>

ACPICA commit 463d30f0a8edc5dccad20c2d189dc55111d51aae

The acpica will be integrated as module into Zephyr project for
enable acpi bus driver. This patch is for enable os specific
support layer for Zephyr.

Link: https://github.com/acpica/acpica/commit/463d30f0
Signed-off-by: Najumon <najumon.ba@intel.com>
Signed-off-by: Bob Moore <robert.moore@intel.com>
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 include/acpi/platform/acenv.h    |  2 ++
 include/acpi/platform/aczephyr.h | 48 ++++++++++++++++++++++++++++++++
 2 files changed, 50 insertions(+)
 create mode 100644 include/acpi/platform/aczephyr.h

diff --git a/include/acpi/platform/acenv.h b/include/acpi/platform/acenv.h
index 0fa7bbf85c83..337ffa931ee8 100644
--- a/include/acpi/platform/acenv.h
+++ b/include/acpi/platform/acenv.h
@@ -209,6 +209,8 @@
 #elif defined(_AED_EFI) || defined(_GNU_EFI) || defined(_EDK2_EFI)
 #include "acefi.h"
 
+#elif defined(__ZEPHYR__)
+#include "aczephyr.h"
 #else
 
 /* Unknown environment */
diff --git a/include/acpi/platform/aczephyr.h b/include/acpi/platform/aczephyr.h
new file mode 100644
index 000000000000..2f0d30c3c5fd
--- /dev/null
+++ b/include/acpi/platform/aczephyr.h
@@ -0,0 +1,48 @@
+/* SPDX-License-Identifier: BSD-3-Clause OR GPL-2.0 */
+/******************************************************************************
+ *
+ * Module Name: aczephyr.h - OS specific defines, etc.
+ *
+ * Copyright (C) 2000 - 2023, Intel Corp.
+ *
+ *****************************************************************************/
+
+#ifndef __ACZEPHYR_H__
+#define __ACZEPHYR_H__
+
+#define SEEK_SET FS_SEEK_SET
+#define SEEK_END FS_SEEK_END
+
+#define ACPI_MACHINE_WIDTH      64
+
+#define ACPI_NO_ERROR_MESSAGES
+#undef ACPI_DEBUG_OUTPUT
+#define ACPI_USE_SYSTEM_CLIBRARY
+#undef ACPI_DBG_TRACK_ALLOCATIONS
+#define ACPI_SINGLE_THREADED
+#define ACPI_USE_NATIVE_RSDP_POINTER
+
+#include <zephyr/kernel.h>
+#include <zephyr/device.h>
+#include <stdio.h>
+#include <stdlib.h>
+#include <string.h>
+#include <ctype.h>
+#include <zephyr/fs/fs.h>
+#include <zephyr/sys/printk.h>
+#include <zephyr/sys/__assert.h>
+
+/******************************************************************************
+ *
+ * FUNCTION:    acpi_enable_dbg_print
+ *
+ * PARAMETERS:  Enable, 	            - Enable/Disable debug print
+ *
+ * RETURN:      None
+ *
+ * DESCRIPTION: Enable/disable debug print
+ *
+ *****************************************************************************/
+
+void acpi_enable_dbg_print(bool enable);
+#endif
-- 
2.35.3





