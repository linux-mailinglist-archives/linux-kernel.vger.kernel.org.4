Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 439C8664B85
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Jan 2023 19:49:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239504AbjAJStC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Jan 2023 13:49:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239691AbjAJSsb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jan 2023 13:48:31 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01A8AA0886;
        Tue, 10 Jan 2023 10:42:00 -0800 (PST)
Date:   Tue, 10 Jan 2023 18:41:57 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1673376118;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=zFt8ls/SIq2F8FQFC00tJD9a95U7qyLmsiGpKJdUiJ0=;
        b=N3ITY5q3aTpbRrn+WslIL6aHo0xUITD9QknJfCIT/zszwfelSwSu4BdLrISjAqawXE1F6a
        XLLb8ccTqqbOPg7hKxUUANgZ9WdgByzaOdss6OyD3Zi8OXkbEnKd7J/l2/Xn71i0NsUm7Q
        3wefEGfhDIREAFZpSyGNd8s5CYmAQif+7XllVGdmKnFU63HOBFiqfOhdudKUKBKrpCdHNR
        rWY1ksrXVqPRF5c5p68RLD3Xn+iWbVvrxEu5KGRs9xnS1956DcYjtpPqeeWuLOtSUGUWkc
        qo2WUnG1niPDDzYTKajIr0zv4xbTthibo1ABMEgxNrIJMsoUV4loGzEcw/11CA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1673376118;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=zFt8ls/SIq2F8FQFC00tJD9a95U7qyLmsiGpKJdUiJ0=;
        b=WDxADVDikXf9j6yqNbCQnU2z3caJCnhFcWNa68Y1NMmf5/jhU97IyoNmuUXRUcG0sauHuA
        xoBMVicy9ahHSzBA==
From:   "tip-bot2 for Kishon Vijay Abraham I" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/boot] x86/acpi/boot: Do not register processors that cannot
 be onlined for x2APIC
Cc:     Leo Duran <leo.duran@amd.com>,
        Kishon Vijay Abraham I <kvijayab@amd.com>,
        "Borislav Petkov (AMD)" <bp@alien8.de>,
        Zhang Rui <rui.zhang@intel.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20230105041059.39366-1-kvijayab@amd.com>
References: <20230105041059.39366-1-kvijayab@amd.com>
MIME-Version: 1.0
Message-ID: <167337611777.4906.2987946119491090408.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the x86/boot branch of tip:

Commit-ID:     e2869bd7af608c343988429ceb1c2fe99644a01f
Gitweb:        https://git.kernel.org/tip/e2869bd7af608c343988429ceb1c2fe99644a01f
Author:        Kishon Vijay Abraham I <kvijayab@amd.com>
AuthorDate:    Thu, 05 Jan 2023 04:10:59 
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Tue, 10 Jan 2023 19:21:07 +01:00

x86/acpi/boot: Do not register processors that cannot be onlined for x2APIC

Section 5.2.12.12 Processor Local x2APIC Structure in the ACPI v6.5
spec mandates that both "enabled" and "online capable" Local APIC Flags
should be used to determine if the processor is usable or not.

However, Linux doesn't use the "online capable" flag for x2APIC to
determine if the processor is usable. As a result, cpu_possible_mask has
incorrect value and results in more memory getting allocated for per_cpu
variables than it is going to be used.

Make sure Linux parses both "enabled" and "online capable" flags for
x2APIC to correctly determine if the processor is usable.

Fixes: aa06e20f1be6 ("x86/ACPI: Don't add CPUs that are not online capable")
Reported-by: Leo Duran <leo.duran@amd.com>
Signed-off-by: Kishon Vijay Abraham I <kvijayab@amd.com>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Reviewed-by: Borislav Petkov (AMD) <bp@alien8.de>
Reviewed-by: Zhang Rui <rui.zhang@intel.com>
Acked-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Link: https://lore.kernel.org/r/20230105041059.39366-1-kvijayab@amd.com
---
 arch/x86/kernel/acpi/boot.c | 19 ++++++++++++++++---
 1 file changed, 16 insertions(+), 3 deletions(-)

diff --git a/arch/x86/kernel/acpi/boot.c b/arch/x86/kernel/acpi/boot.c
index 907cc98..518bda5 100644
--- a/arch/x86/kernel/acpi/boot.c
+++ b/arch/x86/kernel/acpi/boot.c
@@ -188,6 +188,17 @@ static int acpi_register_lapic(int id, u32 acpiid, u8 enabled)
 	return cpu;
 }
 
+static bool __init acpi_is_processor_usable(u32 lapic_flags)
+{
+	if (lapic_flags & ACPI_MADT_ENABLED)
+		return true;
+
+	if (acpi_support_online_capable && (lapic_flags & ACPI_MADT_ONLINE_CAPABLE))
+		return true;
+
+	return false;
+}
+
 static int __init
 acpi_parse_x2apic(union acpi_subtable_headers *header, const unsigned long end)
 {
@@ -212,6 +223,10 @@ acpi_parse_x2apic(union acpi_subtable_headers *header, const unsigned long end)
 	if (apic_id == 0xffffffff)
 		return 0;
 
+	/* don't register processors that cannot be onlined */
+	if (!acpi_is_processor_usable(processor->lapic_flags))
+		return 0;
+
 	/*
 	 * We need to register disabled CPU as well to permit
 	 * counting disabled CPUs. This allows us to size
@@ -250,9 +265,7 @@ acpi_parse_lapic(union acpi_subtable_headers * header, const unsigned long end)
 		return 0;
 
 	/* don't register processors that can not be onlined */
-	if (acpi_support_online_capable &&
-	    !(processor->lapic_flags & ACPI_MADT_ENABLED) &&
-	    !(processor->lapic_flags & ACPI_MADT_ONLINE_CAPABLE))
+	if (!acpi_is_processor_usable(processor->lapic_flags))
 		return 0;
 
 	/*
