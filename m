Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 863466CFFDF
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Mar 2023 11:33:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230092AbjC3JdK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Mar 2023 05:33:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229728AbjC3JdI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Mar 2023 05:33:08 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF8776A63;
        Thu, 30 Mar 2023 02:33:02 -0700 (PDT)
Date:   Thu, 30 Mar 2023 09:33:00 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1680168781;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=R/5YEIu7OURMmSlptDaTTLCcQHDxaQcGsTk6gemD5Q0=;
        b=dpEFt7fE+e+WIDhL3UhPDpFlvPgrE4zLi+7G1hXonfThL4RQyXb2oRrM8yPEu7vPEtfIqm
        DbuT+kR1HRyzsNpr6+yehVVU43k8swb9J7wa2/Lr98/Ue8T+z8Dk3pK/ZdazeltydKFii0
        XtmbRtC01blHxanQiJvbX7ZgL29/B3qmdKZCdaUJzJN/0uvi4hTyVMM6AAPBiefBmq2vNY
        AmtUeJ+eqHicCaQXPmXqlibiM8OnaI2LRjBbA79isl4nDFocrqFO2Fgu3O3DOT+lh9xtFh
        r6nw8fyBdCOjPvtWs3qo+ehRxlxWKa7TJmbKo3T6LlQHpx2bwePZfK3lSE3tGw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1680168781;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=R/5YEIu7OURMmSlptDaTTLCcQHDxaQcGsTk6gemD5Q0=;
        b=qR+A+vsl4CuQ+nib0l9qMCCjDxhA9Ro0Q++qBA1MWrmoQ30+ZAARqOG0IIxS9wyNOEZvzJ
        E9dO2BocU42g+kBQ==
From:   "tip-bot2 for Mario Limonciello" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/urgent] x86/ACPI/boot: Use FADT version to check support
 for online capable
Cc:     Eric DeVolder <eric.devolder@oracle.com>,
        Borislav Petkov <bp@alien8.de>,
        Mario Limonciello <mario.limonciello@amd.com>,
        <stable@kernel.org>, x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <943d2445-84df-d939-f578-5d8240d342cc@unsolicited.net>
References: <943d2445-84df-d939-f578-5d8240d342cc@unsolicited.net>
MIME-Version: 1.0
Message-ID: <168016878085.404.6003734700616193238.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the x86/urgent branch of tip:

Commit-ID:     a74fabfbd1b7013045afc8cc541e6cab3360ccb5
Gitweb:        https://git.kernel.org/tip/a74fabfbd1b7013045afc8cc541e6cab3360ccb5
Author:        Mario Limonciello <mario.limonciello@amd.com>
AuthorDate:    Wed, 29 Mar 2023 12:45:35 -05:00
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Thu, 30 Mar 2023 10:50:30 +02:00

x86/ACPI/boot: Use FADT version to check support for online capable

ACPI 6.3 introduced the online capable bit, and also introduced MADT
version 5.

Latter was used to distinguish whether the offset storing online capable
could be used. However ACPI 6.2b has MADT version "45" which is for
an errata version of the ACPI 6.2 spec.  This means that the Linux code
for detecting availability of MADT will mistakenly flag ACPI 6.2b as
supporting online capable which is inaccurate as it's an ACPI 6.3 feature.

Instead use the FADT major and minor revision fields to distinguish this.

  [ bp: Massage. ]

Fixes: aa06e20f1be6 ("x86/ACPI: Don't add CPUs that are not online capable")
Reported-by: Eric DeVolder <eric.devolder@oracle.com>
Reported-by: Borislav Petkov <bp@alien8.de>
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Cc: <stable@kernel.org>
Link: https://lore.kernel.org/r/943d2445-84df-d939-f578-5d8240d342cc@unsolicited.net
---
 arch/x86/kernel/acpi/boot.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/arch/x86/kernel/acpi/boot.c b/arch/x86/kernel/acpi/boot.c
index 1c38174..7292184 100644
--- a/arch/x86/kernel/acpi/boot.c
+++ b/arch/x86/kernel/acpi/boot.c
@@ -146,7 +146,11 @@ static int __init acpi_parse_madt(struct acpi_table_header *table)
 
 		pr_debug("Local APIC address 0x%08x\n", madt->address);
 	}
-	if (madt->header.revision >= 5)
+
+	/* ACPI 6.3 and newer support the online capable bit. */
+	if (acpi_gbl_FADT.header.revision > 6 ||
+	    (acpi_gbl_FADT.header.revision == 6 &&
+	     acpi_gbl_FADT.minor_revision >= 3))
 		acpi_support_online_capable = true;
 
 	default_acpi_madt_oem_check(madt->header.oem_id,
