Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 61EA26D7E94
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Apr 2023 16:05:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238338AbjDEOFD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Apr 2023 10:05:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238182AbjDEOD7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Apr 2023 10:03:59 -0400
Received: from cloudserver094114.home.pl (cloudserver094114.home.pl [79.96.170.134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4548658A;
        Wed,  5 Apr 2023 07:01:56 -0700 (PDT)
Received: from localhost (127.0.0.1) (HELO v370.home.net.pl)
 by /usr/run/smtp (/usr/run/postfix/private/idea_relay_lmtp) via UNIX with SMTP (IdeaSmtpServer 5.1.0)
 id f57cfd1615ca829f; Wed, 5 Apr 2023 16:01:27 +0200
Received: from kreacher.localnet (unknown [213.134.163.219])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by v370.home.net.pl (Postfix) with ESMTPSA id 00E301B4EA6F;
        Wed,  5 Apr 2023 16:01:26 +0200 (CEST)
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Linux ACPI <linux-acpi@vger.kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Bob Moore <robert.moore@intel.com>
Subject: [PATCH 02/32] ACPICA: ACPI 6.5: MADT: add support for trace buffer extension in GICC
Date:   Wed, 05 Apr 2023 15:33:07 +0200
Message-ID: <2165774.irdbgypaU6@kreacher>
In-Reply-To: <4845957.31r3eYUQgx@kreacher>
References: <4845957.31r3eYUQgx@kreacher>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="UTF-8"
X-CLIENT-IP: 213.134.163.219
X-CLIENT-HOSTNAME: 213.134.163.219
X-VADE-SPAMSTATE: clean
X-VADE-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedvhedrvdejuddgjeduucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecujffqoffgrffnpdggtffipffknecuuegrihhlohhuthemucduhedtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvfevufffkfgjfhgggfgtsehtufertddttdejnecuhfhrohhmpedftfgrfhgrvghlucflrdcuhgihshhotghkihdfuceorhhjfiesrhhjfiihshhotghkihdrnhgvtheqnecuggftrfgrthhtvghrnhepledtieekkeekveeikeetgffgteeuteefjeevjeegudelvdduheeiuedvieehieevnecuffhomhgrihhnpehgihhthhhusgdrtghomhenucfkphepvddufedrudefgedrudeifedrvdduleenucevlhhushhtvghrufhiiigvpedunecurfgrrhgrmhepihhnvghtpedvudefrddufeegrdduieefrddvudelpdhhvghlohepkhhrvggrtghhvghrrdhlohgtrghlnhgvthdpmhgrihhlfhhrohhmpedftfgrfhgrvghlucflrdcuhgihshhotghkihdfuceorhhjfiesrhhjfiihshhotghkihdrnhgvtheqpdhnsggprhgtphhtthhopeefpdhrtghpthhtoheplhhinhhugidqrggtphhisehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheprhhosggvrhhtrdhmohhorhgvsehinhhtvghlrdgtohhm
X-DCC--Metrics: v370.home.net.pl 1024; Body=3 Fuz1=3 Fuz2=3
X-Spam-Status: No, score=0.0 required=5.0 tests=SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Xiongfeng Wang <wangxiongfeng2@huawei.com>

ACPICA commit 1363e35dc6976143d118588b5124d72017365588

Link: https://github.com/acpica/acpica/commit/1363e35d
Signed-off-by: Xiongfeng Wang <wangxiongfeng2@huawei.com>
Signed-off-by: Bob Moore <robert.moore@intel.com>
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 include/acpi/actbl2.h | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/include/acpi/actbl2.h b/include/acpi/actbl2.h
index 2e7e0d5674f6..65f9e834e921 100644
--- a/include/acpi/actbl2.h
+++ b/include/acpi/actbl2.h
@@ -1012,7 +1012,7 @@ struct acpi_madt_local_x2apic_nmi {
 	u8 reserved[3];		/* reserved - must be zero */
 };
 
-/* 11: Generic interrupt - GICC (ACPI 5.0 + ACPI 6.0 + ACPI 6.3 changes) */
+/* 11: Generic interrupt - GICC (ACPI 5.0 + ACPI 6.0 + ACPI 6.3 + ACPI 6.5 changes) */
 
 struct acpi_madt_generic_interrupt {
 	struct acpi_subtable_header header;
@@ -1032,6 +1032,7 @@ struct acpi_madt_generic_interrupt {
 	u8 efficiency_class;
 	u8 reserved2[1];
 	u16 spe_interrupt;	/* ACPI 6.3 */
+	u16 trbe_interrupt;	/* ACPI 6.5 */
 };
 
 /* Masks for Flags field above */
-- 
2.35.3





