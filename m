Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF05974DC62
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jul 2023 19:24:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232999AbjGJRYW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jul 2023 13:24:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232929AbjGJRXp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jul 2023 13:23:45 -0400
Received: from cloudserver094114.home.pl (cloudserver094114.home.pl [79.96.170.134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 483FEC4;
        Mon, 10 Jul 2023 10:23:43 -0700 (PDT)
Received: from localhost (127.0.0.1) (HELO v370.home.net.pl)
 by /usr/run/smtp (/usr/run/postfix/private/idea_relay_lmtp) via UNIX with SMTP (IdeaSmtpServer 5.2.0)
 id fbf52e4b15011c9f; Mon, 10 Jul 2023 19:23:41 +0200
Received: from kreacher.localnet (unknown [195.136.19.94])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by v370.home.net.pl (Postfix) with ESMTPSA id 36D34660DCF;
        Mon, 10 Jul 2023 19:23:41 +0200 (CEST)
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Linux ACPI <linux-acpi@vger.kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Bob Moore <robert.moore@intel.com>,
        Saket Dumbre <saket.dumbre@intel.com>
Subject: [PATCH 01/14] ACPICA: Fix GCC 12 dangling-pointer warning
Date:   Mon, 10 Jul 2023 19:11:30 +0200
Message-ID: <4851363.31r3eYUQgx@kreacher>
In-Reply-To: <5698695.DvuYhMxLoT@kreacher>
References: <5698695.DvuYhMxLoT@kreacher>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="UTF-8"
X-CLIENT-IP: 195.136.19.94
X-CLIENT-HOSTNAME: 195.136.19.94
X-VADE-SPAMSTATE: clean
X-VADE-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedviedrvdekgddutdefucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecujffqoffgrffnpdggtffipffknecuuegrihhlohhuthemucduhedtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvfevufffkfgjfhgggfgtsehtufertddttdejnecuhfhrohhmpedftfgrfhgrvghlucflrdcuhgihshhotghkihdfuceorhhjfiesrhhjfiihshhotghkihdrnhgvtheqnecuggftrfgrthhtvghrnhepledtieekkeekveeikeetgffgteeuteefjeevjeegudelvdduheeiuedvieehieevnecuffhomhgrihhnpehgihhthhhusgdrtghomhenucfkphepudelhedrudefiedrudelrdelgeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpeduleehrddufeeirdduledrleegpdhhvghlohepkhhrvggrtghhvghrrdhlohgtrghlnhgvthdpmhgrihhlfhhrohhmpedftfgrfhgrvghlucflrdcuhgihshhotghkihdfuceorhhjfiesrhhjfiihshhotghkihdrnhgvtheqpdhnsggprhgtphhtthhopeegpdhrtghpthhtoheplhhinhhugidqrggtphhisehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheprhhosggvrhhtrdhmohhorhgvsehinhhtvghlrdgtohhmpdhrtghpthhtohepshgrkhgvthdrughumhgsrhgv
 sehinhhtvghlrdgtohhm
X-DCC--Metrics: v370.home.net.pl 1024; Body=4 Fuz1=4 Fuz2=4
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Philip Prindeville <philipp@redfish-solutions.com>

ACPICA commit aea0a5cfce262ce2ab16fd96d87c12cf5e756380

We're storing a persistent pointer to an ephemeral local variable
which technically is a dangling pointer and the compiler is correct.
However, since we never indirect the pointer, this is a safe
operation and we can suppress the warning.

Also, some C run-times (like MUSL) aren't including <stdint.h>
indirectly so we must include it explicitly or we won't have the
type definition for uintptr_t.

Link: https://github.com/acpica/acpica/commit/aea0a5cf
Signed-off-by: Philip Prindeville <philipp@redfish-solutions.com>
Signed-off-by: Bob Moore <robert.moore@intel.com>
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/acpi/acpica/utdebug.c   | 5 +++++
 include/acpi/platform/aclinux.h | 1 +
 2 files changed, 6 insertions(+)

diff --git a/drivers/acpi/acpica/utdebug.c b/drivers/acpi/acpica/utdebug.c
index 1bbba8585fa6..c5f6c85a3a09 100644
--- a/drivers/acpi/acpica/utdebug.c
+++ b/drivers/acpi/acpica/utdebug.c
@@ -37,7 +37,12 @@ void acpi_ut_init_stack_ptr_trace(void)
 {
 	acpi_size current_sp;
 
+#pragma GCC diagnostic push
+#if defined(__GNUC__) && __GNUC__ >= 12
+#pragma GCC diagnostic ignored "-Wdangling-pointer="
+#endif
 	acpi_gbl_entry_stack_pointer = &current_sp;
+#pragma GCC diagnostic pop
 }
 
 /*******************************************************************************
diff --git a/include/acpi/platform/aclinux.h b/include/acpi/platform/aclinux.h
index 1ca450e35c0d..565341c826e3 100644
--- a/include/acpi/platform/aclinux.h
+++ b/include/acpi/platform/aclinux.h
@@ -182,6 +182,7 @@
 #ifdef ACPI_USE_STANDARD_HEADERS
 #include <stddef.h>
 #include <unistd.h>
+#include <stdint.h>
 
 #define ACPI_OFFSET(d, f)   offsetof(d, f)
 #endif
-- 
2.35.3




