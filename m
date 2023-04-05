Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1A4816D7E56
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Apr 2023 16:01:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230012AbjDEOBP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Apr 2023 10:01:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238237AbjDEOA5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Apr 2023 10:00:57 -0400
Received: from cloudserver094114.home.pl (cloudserver094114.home.pl [79.96.170.134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76E40619F;
        Wed,  5 Apr 2023 07:00:51 -0700 (PDT)
Received: from localhost (127.0.0.1) (HELO v370.home.net.pl)
 by /usr/run/smtp (/usr/run/postfix/private/idea_relay_lmtp) via UNIX with SMTP (IdeaSmtpServer 5.1.0)
 id 7f235b38e99b158a; Wed, 5 Apr 2023 16:00:49 +0200
Received: from kreacher.localnet (unknown [213.134.163.219])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by v370.home.net.pl (Postfix) with ESMTPSA id 0635D1B4EA62;
        Wed,  5 Apr 2023 16:00:48 +0200 (CEST)
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Linux ACPI <linux-acpi@vger.kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Bob Moore <robert.moore@intel.com>,
        Kees Cook <kees@outflux.net>
Subject: [PATCH 24/32] ACPICA: Introduce ACPI_FLEX_ARRAY
Date:   Wed, 05 Apr 2023 15:52:23 +0200
Message-ID: <9164448.rMLUfLXkoz@kreacher>
In-Reply-To: <4845957.31r3eYUQgx@kreacher>
References: <4845957.31r3eYUQgx@kreacher>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="UTF-8"
X-CLIENT-IP: 213.134.163.219
X-CLIENT-HOSTNAME: 213.134.163.219
X-VADE-SPAMSTATE: clean
X-VADE-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedvhedrvdejuddgjeduucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecujffqoffgrffnpdggtffipffknecuuegrihhlohhuthemucduhedtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvfevufffkfgjfhgggfgtsehtufertddttdejnecuhfhrohhmpedftfgrfhgrvghlucflrdcuhgihshhotghkihdfuceorhhjfiesrhhjfiihshhotghkihdrnhgvtheqnecuggftrfgrthhtvghrnhepledtieekkeekveeikeetgffgteeuteefjeevjeegudelvdduheeiuedvieehieevnecuffhomhgrihhnpehgihhthhhusgdrtghomhenucfkphepvddufedrudefgedrudeifedrvdduleenucevlhhushhtvghrufhiiigvpedunecurfgrrhgrmhepihhnvghtpedvudefrddufeegrdduieefrddvudelpdhhvghlohepkhhrvggrtghhvghrrdhlohgtrghlnhgvthdpmhgrihhlfhhrohhmpedftfgrfhgrvghlucflrdcuhgihshhotghkihdfuceorhhjfiesrhhjfiihshhotghkihdrnhgvtheqpdhnsggprhgtphhtthhopeegpdhrtghpthhtoheplhhinhhugidqrggtphhisehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheprhhosggvrhhtrdhmohhorhgvsehinhhtvghlrdgtohhmpdhrtghpthhtohepkhgvvghssehouhht
 fhhluhigrdhnvght
X-DCC--Metrics: v370.home.net.pl 1024; Body=4 Fuz1=4 Fuz2=4
X-Spam-Status: No, score=0.0 required=5.0 tests=SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kees Cook <kees@outflux.net>

ACPICA commit e73b227e8e475c20cc394f237ea35d592fdf9ec3

In order to enable using -fstrict-flex-arrays with GCC and Clang in the
Linux kernel, each trailing dynamically sized array must be defined as
proper C99 "flexible array members" (FAM). Unfortunately, ACPICA has a
bunch of technical debt, dating back to before even the GNU extension of
0-length arrays, meaning the code base has many 1-element and 0-length
arrays defined at the end of structures that should actually be FAMs.

One limitation of the C99 FAM specification is the accidental requirement
that they cannot be in unions or alone in structs. There is no real-world
reason for this, though, and, actually, the existing GNU extension
permits this for 0-length arrays (which get treated as FAMs).

Add the ACPI_FLEX_ARRAY() helper macro to work around this requirement
so that FAMs can be defined in unions or alone in structs. Since this
behavior still depends on GNU extensions, keep the macro specific to GCC
(and Clang) builds. In this way, MSVC will continue to use 0-length
arrays (since it does not support the union work-around). When MSVC
grows support for this in the future, the macro can be updated.

Link: https://github.com/acpica/acpica/commit/e73b227e
Signed-off-by: Bob Moore <robert.moore@intel.com>
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 include/acpi/actypes.h        |  4 ++++
 include/acpi/platform/acgcc.h | 11 +++++++++++
 2 files changed, 15 insertions(+)

diff --git a/include/acpi/actypes.h b/include/acpi/actypes.h
index ce1db1c2e9d3..cf6ee2cb0eb9 100644
--- a/include/acpi/actypes.h
+++ b/include/acpi/actypes.h
@@ -1323,4 +1323,8 @@ typedef enum {
 #define ACPI_FALLTHROUGH do {} while(0)
 #endif
 
+#ifndef ACPI_FLEX_ARRAY
+#define ACPI_FLEX_ARRAY(TYPE, NAME)     TYPE NAME[0]
+#endif
+
 #endif				/* __ACTYPES_H__ */
diff --git a/include/acpi/platform/acgcc.h b/include/acpi/platform/acgcc.h
index c9d418f9395e..04b4bf620517 100644
--- a/include/acpi/platform/acgcc.h
+++ b/include/acpi/platform/acgcc.h
@@ -61,4 +61,15 @@
 #define ACPI_FALLTHROUGH __attribute__((__fallthrough__))
 #endif
 
+/*
+ * Flexible array members are not allowed to be part of a union under
+ * C99, but this is not for any technical reason. Work around the
+ * limitation.
+ */
+#define ACPI_FLEX_ARRAY(TYPE, NAME)             \
+        struct {                                \
+                struct { } __Empty_ ## NAME;    \
+                TYPE NAME[];                    \
+        }
+
 #endif				/* __ACGCC_H__ */
-- 
2.35.3





