Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C980624236
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Nov 2022 13:22:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230154AbiKJMWR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Nov 2022 07:22:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230507AbiKJMV4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Nov 2022 07:21:56 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B53B71F37;
        Thu, 10 Nov 2022 04:21:55 -0800 (PST)
Date:   Thu, 10 Nov 2022 12:21:52 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1668082913;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=HYDzanxKQjmi8wx6Qn4rdJZe7wl+OGuY2TVEzdipu+s=;
        b=etPRhA7WPabGVd8z2DvG1xDfjWd3Gn0TUgEHFuHRBTUw8TudNpWYH5ApY+mid5fciaZAgO
        pP3VsF7wtJ9xm6wRz+Kxl9dkxbvse5XvEvyjMp/zPkQth7F7wzafE4mLImbIxsX0RE1K7K
        MTy4xJLONj5q4eQiW15paTsCc+vJndz4MG5foyz5+J00T9dRQJtKR5es0WYWyoKSzifcS4
        A+DEIeXixXWDhYQBIpWH71jLHjvu5eO6aCiQHbLXIVuI75dsyzr0HEBPjxnshzHNwg8hC/
        bzi8XxQI9V1ZryAqKGg5ydgxsVXWMbIvOoH/dn5MYKrUo+D0OrdBF+r7AZltMQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1668082913;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=HYDzanxKQjmi8wx6Qn4rdJZe7wl+OGuY2TVEzdipu+s=;
        b=KlpF9aIhLQuSVe1HPqHEEJs6cCFK+Dl1OTQiR3aIPi0LA2khl2ZkFWgCFRmwZmV1trcq/4
        klPPoGBD32wXnXCQ==
From:   "tip-bot2 for Juergen Gross" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/cpu] x86/mtrr: Simplify mtrr_bp_init()
Cc:     Juergen Gross <jgross@suse.com>, Borislav Petkov <bp@suse.de>,
        x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20221102074713.21493-10-jgross@suse.com>
References: <20221102074713.21493-10-jgross@suse.com>
MIME-Version: 1.0
Message-ID: <166808291254.4906.17364603944285454166.tip-bot2@tip-bot2>
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

The following commit has been merged into the x86/cpu branch of tip:

Commit-ID:     74069135f09c4600ab2985939c305ebef57ac34f
Gitweb:        https://git.kernel.org/tip/74069135f09c4600ab2985939c305ebef57ac34f
Author:        Juergen Gross <jgross@suse.com>
AuthorDate:    Wed, 02 Nov 2022 08:47:06 +01:00
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Thu, 10 Nov 2022 13:12:44 +01:00

x86/mtrr: Simplify mtrr_bp_init()

In case of the generic cache interface being used (Intel CPUs or a
64-bit system), the initialization sequence of the boot CPU is more
complicated than necessary:

- check if MTRR enabled, if yes, call mtrr_bp_pat_init() which will
  disable caching, set the PAT MSR, and reenable caching

- call mtrr_cleanup(), in case that changed anything, call
  cache_cpu_init() doing the same caching disable/enable dance as
  above, but this time with setting the (modified) MTRR state (even
  if MTRR was disabled) AND setting the PAT MSR (again even with
  disabled MTRR)

The sequence can be simplified a lot while removing potential
inconsistencies:

- check if MTRR enabled, if yes, call mtrr_cleanup() and then
  cache_cpu_init()

This ensures to:

- no longer disable/enable caching more than once

- avoid to set MTRRs and/or the PAT MSR on the boot processor in case
  of MTRR cleanups even if MTRRs meant to be disabled

With that mtrr_bp_pat_init() can be removed.

Signed-off-by: Juergen Gross <jgross@suse.com>
Signed-off-by: Borislav Petkov <bp@suse.de>
Link: https://lore.kernel.org/r/20221102074713.21493-10-jgross@suse.com
Signed-off-by: Borislav Petkov <bp@suse.de>
---
 arch/x86/kernel/cpu/mtrr/generic.c | 14 --------------
 arch/x86/kernel/cpu/mtrr/mtrr.c    |  6 +-----
 arch/x86/kernel/cpu/mtrr/mtrr.h    |  1 -
 3 files changed, 1 insertion(+), 20 deletions(-)

diff --git a/arch/x86/kernel/cpu/mtrr/generic.c b/arch/x86/kernel/cpu/mtrr/generic.c
index 9d4d2bc..ee09d35 100644
--- a/arch/x86/kernel/cpu/mtrr/generic.c
+++ b/arch/x86/kernel/cpu/mtrr/generic.c
@@ -442,20 +442,6 @@ static void __init print_mtrr_state(void)
 		pr_debug("TOM2: %016llx aka %lldM\n", mtrr_tom2, mtrr_tom2>>20);
 }
 
-/* PAT setup for BP. We need to go through sync steps here */
-void __init mtrr_bp_pat_init(void)
-{
-	unsigned long flags;
-
-	local_irq_save(flags);
-	cache_disable();
-
-	pat_init();
-
-	cache_enable();
-	local_irq_restore(flags);
-}
-
 /* Grab all of the MTRR state for this CPU into *state */
 bool __init get_mtrr_state(void)
 {
diff --git a/arch/x86/kernel/cpu/mtrr/mtrr.c b/arch/x86/kernel/cpu/mtrr/mtrr.c
index a44b510..a468be5 100644
--- a/arch/x86/kernel/cpu/mtrr/mtrr.c
+++ b/arch/x86/kernel/cpu/mtrr/mtrr.c
@@ -764,12 +764,8 @@ void __init mtrr_bp_init(void)
 			__mtrr_enabled = get_mtrr_state();
 
 			if (mtrr_enabled()) {
-				mtrr_bp_pat_init();
 				memory_caching_control |= CACHE_MTRR | CACHE_PAT;
-			}
-
-			if (mtrr_cleanup(phys_addr)) {
-				changed_by_mtrr_cleanup = 1;
+				changed_by_mtrr_cleanup = mtrr_cleanup(phys_addr);
 				cache_cpu_init();
 			}
 		}
diff --git a/arch/x86/kernel/cpu/mtrr/mtrr.h b/arch/x86/kernel/cpu/mtrr/mtrr.h
index 3b18831..c98928c 100644
--- a/arch/x86/kernel/cpu/mtrr/mtrr.h
+++ b/arch/x86/kernel/cpu/mtrr/mtrr.h
@@ -50,7 +50,6 @@ void set_mtrr_prepare_save(struct set_mtrr_context *ctxt);
 void fill_mtrr_var_range(unsigned int index,
 		u32 base_lo, u32 base_hi, u32 mask_lo, u32 mask_hi);
 bool get_mtrr_state(void);
-void mtrr_bp_pat_init(void);
 
 extern void __init set_mtrr_ops(const struct mtrr_ops *ops);
 
