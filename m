Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EDDFF6CFFE0
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Mar 2023 11:33:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230094AbjC3JdN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Mar 2023 05:33:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229814AbjC3JdI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Mar 2023 05:33:08 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A4806E93;
        Thu, 30 Mar 2023 02:33:03 -0700 (PDT)
Date:   Thu, 30 Mar 2023 09:33:00 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1680168781;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=vqOK79NtrV7he0FM5j2OjTQDuyQecRZj6vRZgqwExg4=;
        b=b76AvJO2QCUzr7uneadSs/vpjdB8eCOtTw59Z8PY3Ww7KYI01iVOX5H6N2c5rVczuoTL0A
        ua4O0L1MCXV1opaDoVHAbq0PL1qyICyloNiND2vzPZCnzPidfyB4CRKupp87p5Lz6/TmOI
        1FL/mdwFnyna1Rap4okeaymaG7dc5ejxj82n8r7gpHHBq6+Il2cHuLH8P4VCVGkx/K/VdT
        uWLcd5JKG/K4kxm1duR5YVHpTH3NhNz3ynEoa9bC0gk5EbaTiv0JQWkcZnkuZh7cfntOCr
        s1x/Z+n2DjmaPVhEvztIBDwhxSujR+jtEO8fJHCEpR2lbfOcYDqUf/cpg0dcOA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1680168781;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=vqOK79NtrV7he0FM5j2OjTQDuyQecRZj6vRZgqwExg4=;
        b=COCFp4z0K2EoY/I25UgrX58l47Bk1g6afszS3EVJWvF7f6egDobKI+edqkhiwydXmNEyre
        sy9/Ox01EOc/OcDw==
From:   "tip-bot2 for Eric DeVolder" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/urgent] x86/acpi/boot: Correct acpi_is_processor_usable() check
Cc:     Miguel Luis <miguel.luis@oracle.com>,
        Boris Ostrovsky <boris.ovstrosky@oracle.com>,
        Eric DeVolder <eric.devolder@oracle.com>,
        "Borislav Petkov (AMD)" <bp@alien8.de>,
        David R <david@unsolicited.net>, <stable@kernel.org>,
        x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20230327191026.3454-2-eric.devolder@oracle.com>
References: <20230327191026.3454-2-eric.devolder@oracle.com>
MIME-Version: 1.0
Message-ID: <168016878002.404.5262105401164408214.tip-bot2@tip-bot2>
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

Commit-ID:     fed8d8773b8ea68ad99d9eee8c8343bef9da2c2c
Gitweb:        https://git.kernel.org/tip/fed8d8773b8ea68ad99d9eee8c8343bef9da2c2c
Author:        Eric DeVolder <eric.devolder@oracle.com>
AuthorDate:    Mon, 27 Mar 2023 15:10:26 -04:00
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Thu, 30 Mar 2023 11:07:30 +02:00

x86/acpi/boot: Correct acpi_is_processor_usable() check

The logic in acpi_is_processor_usable() requires the online capable
bit be set for hotpluggable CPUs.  The online capable bit has been
introduced in ACPI 6.3.

However, for ACPI revisions < 6.3 which do not support that bit, CPUs
should be reported as usable, not the other way around.

Reverse the check.

  [ bp: Rewrite commit message. ]

Fixes: e2869bd7af60 ("x86/acpi/boot: Do not register processors that cannot be onlined for x2APIC")
Suggested-by: Miguel Luis <miguel.luis@oracle.com>
Suggested-by: Boris Ostrovsky <boris.ovstrosky@oracle.com>
Signed-off-by: Eric DeVolder <eric.devolder@oracle.com>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Tested-by: David R <david@unsolicited.net>
Cc: <stable@kernel.org>
Link: https://lore.kernel.org/r/20230327191026.3454-2-eric.devolder@oracle.com
---
 arch/x86/kernel/acpi/boot.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/x86/kernel/acpi/boot.c b/arch/x86/kernel/acpi/boot.c
index 7292184..0dac4ab 100644
--- a/arch/x86/kernel/acpi/boot.c
+++ b/arch/x86/kernel/acpi/boot.c
@@ -197,7 +197,8 @@ static bool __init acpi_is_processor_usable(u32 lapic_flags)
 	if (lapic_flags & ACPI_MADT_ENABLED)
 		return true;
 
-	if (acpi_support_online_capable && (lapic_flags & ACPI_MADT_ONLINE_CAPABLE))
+	if (!acpi_support_online_capable ||
+	    (lapic_flags & ACPI_MADT_ONLINE_CAPABLE))
 		return true;
 
 	return false;
