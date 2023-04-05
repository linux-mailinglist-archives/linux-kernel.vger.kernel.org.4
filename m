Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A4FF6D7E58
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Apr 2023 16:01:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238199AbjDEOBg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Apr 2023 10:01:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238278AbjDEOBC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Apr 2023 10:01:02 -0400
Received: from cloudserver094114.home.pl (cloudserver094114.home.pl [79.96.170.134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3AB786182;
        Wed,  5 Apr 2023 07:00:52 -0700 (PDT)
Received: from localhost (127.0.0.1) (HELO v370.home.net.pl)
 by /usr/run/smtp (/usr/run/postfix/private/idea_relay_lmtp) via UNIX with SMTP (IdeaSmtpServer 5.1.0)
 id 2baca87f8f83e7cf; Wed, 5 Apr 2023 16:00:51 +0200
Received: from kreacher.localnet (unknown [213.134.163.219])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by v370.home.net.pl (Postfix) with ESMTPSA id 7FD111B4EA62;
        Wed,  5 Apr 2023 16:00:50 +0200 (CEST)
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Linux ACPI <linux-acpi@vger.kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Bob Moore <robert.moore@intel.com>,
        Kees Cook <kees@outflux.net>,
        Dan Williams <dan.j.williams@intel.com>
Subject: [PATCH 23/32] ACPICA: struct acpi_nfit_interleave: Replace 1-element array with flexible array
Date:   Wed, 05 Apr 2023 15:51:25 +0200
Message-ID: <2652195.BddDVKsqQX@kreacher>
In-Reply-To: <4845957.31r3eYUQgx@kreacher>
References: <4845957.31r3eYUQgx@kreacher>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="UTF-8"
X-CLIENT-IP: 213.134.163.219
X-CLIENT-HOSTNAME: 213.134.163.219
X-VADE-SPAMSTATE: clean
X-VADE-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedvhedrvdejuddgjeduucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecujffqoffgrffnpdggtffipffknecuuegrihhlohhuthemucduhedtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvfevufffkfgjfhgggfgtsehtufertddttdejnecuhfhrohhmpedftfgrfhgrvghlucflrdcuhgihshhotghkihdfuceorhhjfiesrhhjfiihshhotghkihdrnhgvtheqnecuggftrfgrthhtvghrnhepledtieekkeekveeikeetgffgteeuteefjeevjeegudelvdduheeiuedvieehieevnecuffhomhgrihhnpehgihhthhhusgdrtghomhenucfkphepvddufedrudefgedrudeifedrvdduleenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpedvudefrddufeegrdduieefrddvudelpdhhvghlohepkhhrvggrtghhvghrrdhlohgtrghlnhgvthdpmhgrihhlfhhrohhmpedftfgrfhgrvghlucflrdcuhgihshhotghkihdfuceorhhjfiesrhhjfiihshhotghkihdrnhgvtheqpdhnsggprhgtphhtthhopeehpdhrtghpthhtoheplhhinhhugidqrggtphhisehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheprhhosggvrhhtrdhmohhorhgvsehinhhtvghlrdgtohhmpdhrtghpthhtohepkhgvvghssehouhht
 fhhluhigrdhnvghtpdhrtghpthhtohepuggrnhdrjhdrfihilhhlihgrmhhssehinhhtvghlrdgtohhm
X-DCC--Metrics: v370.home.net.pl 1024; Body=5 Fuz1=5 Fuz2=5
X-Spam-Status: No, score=0.0 required=5.0 tests=SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kees Cook <kees@outflux.net>

ACPICA commit e66decc6fca36b59194b0947d87d6a9bec078bc3

Similar to "Replace one-element array with flexible-array", replace the
1-element array with a proper flexible array member as defined by C99.

This allows the code to operate without tripping compile-time and run-
time bounds checkers (e.g. via __builtin_object_size(), -fsanitize=bounds,
and/or -fstrict-flex-arrays=3).

Unlike struct acpi_nfit_flush_address and struct acpi_nfit_smbios, which
had their sizeof() uses adjusted in code, struct acpi_nfit_interleave did
not. This appears to have been a bug. After this change, there is a binary
difference in acpi_dm_dump_nfit() since the size of the structure now has
the correct size, as the prior result was including the trailing U32:

-       mov    $0x14,%ebp
+       mov    $0x10,%ebp

Link: https://github.com/acpica/acpica/commit/e66decc6
Signed-off-by: Bob Moore <robert.moore@intel.com>
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/acpi/nfit/core.c | 2 +-
 include/acpi/actbl2.h    | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/acpi/nfit/core.c b/drivers/acpi/nfit/core.c
index 981f8b0f595d..a398f32dfd68 100644
--- a/drivers/acpi/nfit/core.c
+++ b/drivers/acpi/nfit/core.c
@@ -3476,7 +3476,7 @@ static __init int nfit_init(void)
 	BUILD_BUG_ON(sizeof(struct acpi_table_nfit) != 40);
 	BUILD_BUG_ON(sizeof(struct acpi_nfit_system_address) != 64);
 	BUILD_BUG_ON(sizeof(struct acpi_nfit_memory_map) != 48);
-	BUILD_BUG_ON(sizeof(struct acpi_nfit_interleave) != 20);
+	BUILD_BUG_ON(sizeof(struct acpi_nfit_interleave) != 16);
 	BUILD_BUG_ON(sizeof(struct acpi_nfit_smbios) != 8);
 	BUILD_BUG_ON(sizeof(struct acpi_nfit_control_region) != 80);
 	BUILD_BUG_ON(sizeof(struct acpi_nfit_data_region) != 40);
diff --git a/include/acpi/actbl2.h b/include/acpi/actbl2.h
index 6d3251ea4c53..a51fd4090d27 100644
--- a/include/acpi/actbl2.h
+++ b/include/acpi/actbl2.h
@@ -1700,7 +1700,7 @@ struct acpi_nfit_interleave {
 	u16 reserved;		/* Reserved, must be zero */
 	u32 line_count;
 	u32 line_size;
-	u32 line_offset[1];	/* Variable length */
+	u32 line_offset[];	/* Variable length */
 };
 
 /* 3: SMBIOS Management Information Structure */
-- 
2.35.3





