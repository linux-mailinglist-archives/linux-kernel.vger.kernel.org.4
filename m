Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0FBD4674650
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Jan 2023 23:41:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230484AbjASWlY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Jan 2023 17:41:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231312AbjASWkq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jan 2023 17:40:46 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF92645BE8;
        Thu, 19 Jan 2023 14:22:41 -0800 (PST)
Date:   Thu, 19 Jan 2023 22:22:39 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1674166960;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=Dl7CD/D7G+lEEnQAkMUvyaCXOdQrmVHbu2hv3zw7wS4=;
        b=YYaNfLX37nPmqRGXTrjCpTAOYLZPNqRJJmdTb1zEc+kWrUmpOaFHlvPiItv7IsLhWKum+P
        OgxqAtitccCGygSTSR+VDPPWTS9q714/WvRE//+jPl7HrLiQTA6tNzU9ZUHcWHRX4eIXOY
        /cY2J/qH/30Mji2QNBqnUHdzZ4xNsocpgddCHpsjZL8ys1bAB/qDeHf7KlhPgp29/cqbTN
        8u46YcVkxG7hwLA3p1bMVJjxb3fqDj67Qn+Sqx3b+3P1537bFSlXFpOqkEiyB3lKJ5aPTH
        ZuvxhSiZnGARFiJsvbrNk0uwcUpR2s4Oj3lcfO9vqLqP/zNArwYORh3O4xk8eg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1674166960;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=Dl7CD/D7G+lEEnQAkMUvyaCXOdQrmVHbu2hv3zw7wS4=;
        b=pxNV52oubP0oYTEICwRZIfeuv8AG/eouBTkHsFGWNTPue8NVmjMF0Zde0bLSKfGikKWAVj
        gpFg8HQqVzY9A1BQ==
From:   "tip-bot2 for Juergen Gross" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/urgent] acpi: Fix suspend with Xen PV
Cc:     marmarek@invisiblethingslab.com, Juergen Gross <jgross@suse.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
MIME-Version: 1.0
Message-ID: <167416695968.4906.1267929896543710738.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the x86/urgent branch of tip:

Commit-ID:     fe0ba8c23f9a35b0307eb662f16dd3a75fcdae41
Gitweb:        https://git.kernel.org/tip/fe0ba8c23f9a35b0307eb662f16dd3a75fc=
dae41
Author:        Juergen Gross <jgross@suse.com>
AuthorDate:    Tue, 17 Jan 2023 16:57:23 +01:00
Committer:     Dave Hansen <dave.hansen@linux.intel.com>
CommitterDate: Thu, 19 Jan 2023 13:52:05 -08:00

acpi: Fix suspend with Xen PV

Commit f1e525009493 ("x86/boot: Skip realmode init code when running as
Xen PV guest") missed one code path accessing real_mode_header, leading
to dereferencing NULL when suspending the system under Xen:

    [  348.284004] PM: suspend entry (deep)
    [  348.289532] Filesystems sync: 0.005 seconds
    [  348.291545] Freezing user space processes ... (elapsed 0.000 seconds) =
done.
    [  348.292457] OOM killer disabled.
    [  348.292462] Freezing remaining freezable tasks ... (elapsed 0.104 seco=
nds) done.
    [  348.396612] printk: Suspending console(s) (use no_console_suspend to d=
ebug)
    [  348.749228] PM: suspend devices took 0.352 seconds
    [  348.769713] ACPI: EC: interrupt blocked
    [  348.816077] BUG: kernel NULL pointer dereference, address: 00000000000=
0001c
    [  348.816080] #PF: supervisor read access in kernel mode
    [  348.816081] #PF: error_code(0x0000) - not-present page
    [  348.816083] PGD 0 P4D 0
    [  348.816086] Oops: 0000 [#1] PREEMPT SMP NOPTI
    [  348.816089] CPU: 0 PID: 6764 Comm: systemd-sleep Not tainted 6.1.3-1.f=
c32.qubes.x86_64 #1
    [  348.816092] Hardware name: Star Labs StarBook/StarBook, BIOS 8.01 07/0=
3/2022
    [  348.816093] RIP: e030:acpi_get_wakeup_address+0xc/0x20

Fix that by adding an optional acpi callback allowing to skip setting
the wakeup address, as in the Xen PV case this will be handled by the
hypervisor anyway.

Fixes: f1e525009493 ("x86/boot: Skip realmode init code when running as Xen P=
V guest")
Reported-by: Marek Marczykowski-G=C3=B3recki <marmarek@invisiblethingslab.com>
Signed-off-by: Juergen Gross <jgross@suse.com>
Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
Acked-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Link: https://lore.kernel.org/all/20230117155724.22940-1-jgross%40suse.com
---
 arch/x86/include/asm/acpi.h | 8 ++++++++
 drivers/acpi/sleep.c        | 6 +++++-
 2 files changed, 13 insertions(+), 1 deletion(-)

diff --git a/arch/x86/include/asm/acpi.h b/arch/x86/include/asm/acpi.h
index 65064d9..8eb74cf 100644
--- a/arch/x86/include/asm/acpi.h
+++ b/arch/x86/include/asm/acpi.h
@@ -14,6 +14,7 @@
 #include <asm/mmu.h>
 #include <asm/mpspec.h>
 #include <asm/x86_init.h>
+#include <asm/cpufeature.h>
=20
 #ifdef CONFIG_ACPI_APEI
 # include <asm/pgtable_types.h>
@@ -63,6 +64,13 @@ extern int (*acpi_suspend_lowlevel)(void);
 /* Physical address to resume after wakeup */
 unsigned long acpi_get_wakeup_address(void);
=20
+static inline bool acpi_skip_set_wakeup_address(void)
+{
+	return cpu_feature_enabled(X86_FEATURE_XENPV);
+}
+
+#define acpi_skip_set_wakeup_address acpi_skip_set_wakeup_address
+
 /*
  * Check if the CPU can handle C2 and deeper
  */
diff --git a/drivers/acpi/sleep.c b/drivers/acpi/sleep.c
index 0b557c0..4ca6672 100644
--- a/drivers/acpi/sleep.c
+++ b/drivers/acpi/sleep.c
@@ -60,13 +60,17 @@ static struct notifier_block tts_notifier =3D {
 	.priority	=3D 0,
 };
=20
+#ifndef acpi_skip_set_wakeup_address
+#define acpi_skip_set_wakeup_address() false
+#endif
+
 static int acpi_sleep_prepare(u32 acpi_state)
 {
 #ifdef CONFIG_ACPI_SLEEP
 	unsigned long acpi_wakeup_address;
=20
 	/* do we have a wakeup address for S2 and S3? */
-	if (acpi_state =3D=3D ACPI_STATE_S3) {
+	if (acpi_state =3D=3D ACPI_STATE_S3 && !acpi_skip_set_wakeup_address()) {
 		acpi_wakeup_address =3D acpi_get_wakeup_address();
 		if (!acpi_wakeup_address)
 			return -EFAULT;
