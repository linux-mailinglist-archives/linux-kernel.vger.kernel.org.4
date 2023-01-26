Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 31A7D67CA24
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Jan 2023 12:38:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237319AbjAZLiv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Jan 2023 06:38:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229639AbjAZLir (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jan 2023 06:38:47 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D78128D09;
        Thu, 26 Jan 2023 03:38:46 -0800 (PST)
Date:   Thu, 26 Jan 2023 11:38:42 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1674733124;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Yj7YBvoH2/oKg6SUByjlKXShm6+7+3WB/GHvp/SFSCE=;
        b=TZlXkgqP9bq4FaoxFPTlol1BKdMMK1CnDNcPs+4eBrRkbaJQ2YrbB36nttno1sRFTRiAob
        rMFw2qFMqWbGO+tr07ebvPa65UMRln2xAexUlIYzia7uY4BMua4qfLgaOl2e2PzQAzNgqo
        9aGnbw0uUkOcwWIyCPLgCLCeUF0BUiCailvMSYdDiqJhTH6TkMzTBiFKUfYw07RX71kXq9
        mlnJFaC8uYkHNHbc5vYfvEs/jkXFJWFedG4VDs3pD+icPlpp1VSB0w7bWtP4LFGGaYtp6p
        U+eO6VACOZm6g0QZDqzYDQ/AILwp+XZMSCuLVl6Q/jk3Rv7B4eVUenJnBY8TFw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1674733124;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Yj7YBvoH2/oKg6SUByjlKXShm6+7+3WB/GHvp/SFSCE=;
        b=hcoVFvzigyEU23XWaCIyVlXGMgzV2BZGpW+NL1S0w80MvnMFFLnmiEc96KQHmfSDPZfuvT
        oBCLy0qsvAGHUwCg==
From:   "tip-bot2 for Uros Bizjak" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: locking/core] x86/ACPI/boot: Use try_cmpxchg() in
 __acpi_{acquire,release}_global_lock()
Cc:     Uros Bizjak <ubizjak@gmail.com>, Ingo Molnar <mingo@kernel.org>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20230116162522.4072-1-ubizjak@gmail.com>
References: <20230116162522.4072-1-ubizjak@gmail.com>
MIME-Version: 1.0
Message-ID: <167473312297.4906.8676420213357731931.tip-bot2@tip-bot2>
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

The following commit has been merged into the locking/core branch of tip:

Commit-ID:     890a0794b34f89fcd90e94ec970ad2bc18b70e73
Gitweb:        https://git.kernel.org/tip/890a0794b34f89fcd90e94ec970ad2bc18b70e73
Author:        Uros Bizjak <ubizjak@gmail.com>
AuthorDate:    Mon, 16 Jan 2023 17:25:22 +01:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Thu, 26 Jan 2023 11:49:40 +01:00

x86/ACPI/boot: Use try_cmpxchg() in __acpi_{acquire,release}_global_lock()

Use try_cmpxchg instead of cmpxchg (*ptr, old, new) == old in
__acpi_{acquire,release}_global_lock().  x86 CMPXCHG instruction returns
success in ZF flag, so this change saves a compare after CMPXCHG
(and related MOV instruction in front of CMPXCHG).

Also, try_cmpxchg() implicitly assigns old *ptr value to "old" when CMPXCHG
fails. There is no need to re-read the value in the loop.

Note that the value from *ptr should be read using READ_ONCE() to prevent
the compiler from merging, refetching or reordering the read.

No functional change intended.

Signed-off-by: Uros Bizjak <ubizjak@gmail.com>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Acked-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Link: https://lore.kernel.org/r/20230116162522.4072-1-ubizjak@gmail.com
---
 arch/x86/kernel/acpi/boot.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/arch/x86/kernel/acpi/boot.c b/arch/x86/kernel/acpi/boot.c
index 907cc98..4177577 100644
--- a/arch/x86/kernel/acpi/boot.c
+++ b/arch/x86/kernel/acpi/boot.c
@@ -1840,23 +1840,23 @@ early_param("acpi_sci", setup_acpi_sci);
 
 int __acpi_acquire_global_lock(unsigned int *lock)
 {
-	unsigned int old, new, val;
+	unsigned int old, new;
+
+	old = READ_ONCE(*lock);
 	do {
-		old = *lock;
 		new = (((old & ~0x3) + 2) + ((old >> 1) & 0x1));
-		val = cmpxchg(lock, old, new);
-	} while (unlikely (val != old));
+	} while (!try_cmpxchg(lock, &old, new));
 	return ((new & 0x3) < 3) ? -1 : 0;
 }
 
 int __acpi_release_global_lock(unsigned int *lock)
 {
-	unsigned int old, new, val;
+	unsigned int old, new;
+
+	old = READ_ONCE(*lock);
 	do {
-		old = *lock;
 		new = old & ~0x3;
-		val = cmpxchg(lock, old, new);
-	} while (unlikely (val != old));
+	} while (!try_cmpxchg(lock, &old, new));
 	return old & 0x1;
 }
 
