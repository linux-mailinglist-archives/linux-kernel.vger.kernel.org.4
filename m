Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6FED56231D2
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Nov 2022 18:48:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230503AbiKIRsE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Nov 2022 12:48:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231322AbiKIRrr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Nov 2022 12:47:47 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 9D445E70;
        Wed,  9 Nov 2022 09:47:32 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 98B911FB;
        Wed,  9 Nov 2022 09:47:36 -0800 (PST)
Received: from u200856.usa.arm.com (U203867.austin.arm.com [10.118.30.40])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id C25BD3F703;
        Wed,  9 Nov 2022 09:47:26 -0800 (PST)
From:   Jeremy Linton <jeremy.linton@arm.com>
To:     linux-acpi@vger.kernel.org
Cc:     catalin.marinas@arm.com, will@kernel.org, corbet@lwn.net,
        rafael@kernel.org, lenb@kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, Jeremy Linton <jeremy.linton@arm.com>
Subject: [PATCH] ACPI: Enable FPDT on arm64
Date:   Wed,  9 Nov 2022 11:47:20 -0600
Message-Id: <20221109174720.203723-1-jeremy.linton@arm.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

FPDT provides some boot timing records useful for analyzing
parts of the UEFI boot stack. Given the existing code works
on arm64, and allows reading the values without utilizing
/dev/mem it seems like a good idea to turn it on.

Signed-off-by: Jeremy Linton <jeremy.linton@arm.com>
---
 Documentation/arm64/acpi_object_usage.rst | 2 +-
 drivers/acpi/Kconfig                      | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/arm64/acpi_object_usage.rst b/Documentation/arm64/acpi_object_usage.rst
index 0609da73970b..484ef9676653 100644
--- a/Documentation/arm64/acpi_object_usage.rst
+++ b/Documentation/arm64/acpi_object_usage.rst
@@ -163,7 +163,7 @@ FPDT   Section 5.2.23 (signature == "FPDT")
 
        **Firmware Performance Data Table**
 
-       Optional, not currently supported.
+       Optional, useful for boot performance profiling.
 
 GTDT   Section 5.2.24 (signature == "GTDT")
 
diff --git a/drivers/acpi/Kconfig b/drivers/acpi/Kconfig
index 473241b5193f..1cc11d2a2a88 100644
--- a/drivers/acpi/Kconfig
+++ b/drivers/acpi/Kconfig
@@ -90,7 +90,7 @@ config ACPI_SPCR_TABLE
 
 config ACPI_FPDT
 	bool "ACPI Firmware Performance Data Table (FPDT) support"
-	depends on X86_64
+	depends on X86_64 || ARM64
 	help
 	  Enable support for the Firmware Performance Data Table (FPDT).
 	  This table provides information on the timing of the system
-- 
2.38.1

