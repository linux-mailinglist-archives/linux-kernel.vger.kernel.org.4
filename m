Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6461B60FFB0
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Oct 2022 20:00:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236108AbiJ0SAM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Oct 2022 14:00:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235962AbiJ0R7Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Oct 2022 13:59:25 -0400
Received: from cloudserver094114.home.pl (cloudserver094114.home.pl [79.96.170.134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 242E3180AD9;
        Thu, 27 Oct 2022 10:59:17 -0700 (PDT)
Received: from localhost (127.0.0.1) (HELO v370.home.net.pl)
 by /usr/run/smtp (/usr/run/postfix/private/idea_relay_lmtp) via UNIX with SMTP (IdeaSmtpServer 5.0.0)
 id eea9195a9de4c2bc; Thu, 27 Oct 2022 19:59:16 +0200
Received: from kreacher.localnet (unknown [213.134.169.45])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by v370.home.net.pl (Postfix) with ESMTPSA id 4C79E66D83D;
        Thu, 27 Oct 2022 19:59:15 +0200 (CEST)
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Linux ACPI <linux-acpi@vger.kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Bob Moore <robert.moore@intel.com>
Subject: [PATCH 03/11] ACPICA: Check that EBDA pointer is in valid memory
Date:   Thu, 27 Oct 2022 19:50:06 +0200
Message-ID: <10171725.nUPlyArG6x@kreacher>
In-Reply-To: <4756726.GXAFRqVoOG@kreacher>
References: <4756726.GXAFRqVoOG@kreacher>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="UTF-8"
X-CLIENT-IP: 213.134.169.45
X-CLIENT-HOSTNAME: 213.134.169.45
X-VADE-SPAMSTATE: clean
X-VADE-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedvgedrtdeggdduudejucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecujffqoffgrffnpdggtffipffknecuuegrihhlohhuthemucduhedtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvfevufffkfgjfhgggfgtsehtufertddttdejnecuhfhrohhmpedftfgrfhgrvghlucflrdcuhgihshhotghkihdfuceorhhjfiesrhhjfiihshhotghkihdrnhgvtheqnecuggftrfgrthhtvghrnhepledtieekkeekveeikeetgffgteeuteefjeevjeegudelvdduheeiuedvieehieevnecuffhomhgrihhnpehgihhthhhusgdrtghomhenucfkphepvddufedrudefgedrudeiledrgeehnecuvehluhhsthgvrhfuihiivgepudenucfrrghrrghmpehinhgvthepvddufedrudefgedrudeiledrgeehpdhhvghlohepkhhrvggrtghhvghrrdhlohgtrghlnhgvthdpmhgrihhlfhhrohhmpedftfgrfhgrvghlucflrdcuhgihshhotghkihdfuceorhhjfiesrhhjfiihshhotghkihdrnhgvtheqpdhnsggprhgtphhtthhopeefpdhrtghpthhtoheplhhinhhugidqrggtphhisehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheprhhosggvrhhtrdhmohhorhgvsehinhhtvghlrdgtohhm
X-DCC--Metrics: v370.home.net.pl 1024; Body=3 Fuz1=3 Fuz2=3
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Vit Kabele <vit@kabele.me>

ACPICA commit cc9e7763ceb2e2649fe3422130416d84a3c6854a

If the memory at 0x40e is uninitialized, the retrieved physical_memory
address of EBDA may be beyond the low memory (i.e. above 640K).

If so, the kernel may unintentionally access the VGA memory, that
might not be decoded or even present in case of virtualization.

Link: https://github.com/acpica/acpica/commit/cc9e7763
Signed-off-by: Vit Kabele <vit@kabele.me>
Signed-off-by: Bob Moore <robert.moore@intel.com>
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/acpi/acpica/tbxfroot.c |    6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

Index: linux-pm/drivers/acpi/acpica/tbxfroot.c
===================================================================
--- linux-pm.orig/drivers/acpi/acpica/tbxfroot.c
+++ linux-pm/drivers/acpi/acpica/tbxfroot.c
@@ -139,7 +139,11 @@ acpi_find_root_pointer(acpi_physical_add
 
 	/* EBDA present? */
 
-	if (physical_address > 0x400) {
+	/*
+	 * Check that the EBDA pointer from memory is sane and does not point
+	 * above valid low memory
+	 */
+	if (physical_address > 0x400 && physical_address < 0xA0000) {
 		/*
 		 * 1b) Search EBDA paragraphs (EBDA is required to be a
 		 *     minimum of 1K length)



