Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 35D5566E2E4
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Jan 2023 16:57:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229629AbjAQP5g (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Jan 2023 10:57:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229583AbjAQP5b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jan 2023 10:57:31 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD3D82B603;
        Tue, 17 Jan 2023 07:57:30 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 73ABD1FE3C;
        Tue, 17 Jan 2023 15:57:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1673971049; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=rpgawVd99OX2fg9gFrA1SwUU/eb0iIN1sOqRSVcIZeg=;
        b=NbvuNjaeyuSDWK9T41o1ZE6yenmovxH9xNEbwB5mNsaF1w95I3+NfQR3NVRVbXgKYnOrIb
        jDY4z0V8u39WRheGZ6pG5ywgN5iPQtMBC5HhRnpufbaWbqgokzdn8cLpsimyBIppRuQMfH
        O/+P9lWyKRqkYvG7tjuiiPpeTiFfqag=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 1B7D913357;
        Tue, 17 Jan 2023 15:57:29 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id pi9ZBWnFxmM6XQAAMHmgww
        (envelope-from <jgross@suse.com>); Tue, 17 Jan 2023 15:57:29 +0000
From:   Juergen Gross <jgross@suse.com>
To:     linux-kernel@vger.kernel.org, x86@kernel.org,
        linux-acpi@vger.kernel.org
Cc:     Juergen Gross <jgross@suse.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>,
        =?UTF-8?q?Marek=20Marczykowski-G=C3=B3recki?= 
        <marmarek@invisiblethingslab.com>
Subject: [PATCH v2] acpi: fix suspend with Xen PV
Date:   Tue, 17 Jan 2023 16:57:23 +0100
Message-Id: <20230117155724.22940-1-jgross@suse.com>
X-Mailer: git-send-email 2.35.3
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit f1e525009493 ("x86/boot: Skip realmode init code when running as
Xen PV guest") missed one code path accessing real_mode_header, leading
to dereferencing NULL when suspending the system under Xen:

    [  348.284004] PM: suspend entry (deep)
    [  348.289532] Filesystems sync: 0.005 seconds
    [  348.291545] Freezing user space processes ... (elapsed 0.000 seconds) done.
    [  348.292457] OOM killer disabled.
    [  348.292462] Freezing remaining freezable tasks ... (elapsed 0.104 seconds) done.
    [  348.396612] printk: Suspending console(s) (use no_console_suspend to debug)
    [  348.749228] PM: suspend devices took 0.352 seconds
    [  348.769713] ACPI: EC: interrupt blocked
    [  348.816077] BUG: kernel NULL pointer dereference, address: 000000000000001c
    [  348.816080] #PF: supervisor read access in kernel mode
    [  348.816081] #PF: error_code(0x0000) - not-present page
    [  348.816083] PGD 0 P4D 0
    [  348.816086] Oops: 0000 [#1] PREEMPT SMP NOPTI
    [  348.816089] CPU: 0 PID: 6764 Comm: systemd-sleep Not tainted 6.1.3-1.fc32.qubes.x86_64 #1
    [  348.816092] Hardware name: Star Labs StarBook/StarBook, BIOS 8.01 07/03/2022
    [  348.816093] RIP: e030:acpi_get_wakeup_address+0xc/0x20

Fix that by adding an optional acpi callback allowing to skip setting
the wakeup address, as in the Xen PV case this will be handled by the
hypervisor anyway.

Fixes: f1e525009493 ("x86/boot: Skip realmode init code when running as Xen PV guest")
Reported-by: Marek Marczykowski-Górecki <marmarek@invisiblethingslab.com>
Signed-off-by: Juergen Gross <jgross@suse.com>
---
V2:
- new approach, avoid calling acpi_get_wakeup_address()
---
 arch/x86/include/asm/acpi.h | 8 ++++++++
 drivers/acpi/sleep.c        | 6 +++++-
 2 files changed, 13 insertions(+), 1 deletion(-)

diff --git a/arch/x86/include/asm/acpi.h b/arch/x86/include/asm/acpi.h
index 65064d9f7fa6..8eb74cf386db 100644
--- a/arch/x86/include/asm/acpi.h
+++ b/arch/x86/include/asm/acpi.h
@@ -14,6 +14,7 @@
 #include <asm/mmu.h>
 #include <asm/mpspec.h>
 #include <asm/x86_init.h>
+#include <asm/cpufeature.h>
 
 #ifdef CONFIG_ACPI_APEI
 # include <asm/pgtable_types.h>
@@ -63,6 +64,13 @@ extern int (*acpi_suspend_lowlevel)(void);
 /* Physical address to resume after wakeup */
 unsigned long acpi_get_wakeup_address(void);
 
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
index 0b557c0d405e..4ca667251272 100644
--- a/drivers/acpi/sleep.c
+++ b/drivers/acpi/sleep.c
@@ -60,13 +60,17 @@ static struct notifier_block tts_notifier = {
 	.priority	= 0,
 };
 
+#ifndef acpi_skip_set_wakeup_address
+#define acpi_skip_set_wakeup_address() false
+#endif
+
 static int acpi_sleep_prepare(u32 acpi_state)
 {
 #ifdef CONFIG_ACPI_SLEEP
 	unsigned long acpi_wakeup_address;
 
 	/* do we have a wakeup address for S2 and S3? */
-	if (acpi_state == ACPI_STATE_S3) {
+	if (acpi_state == ACPI_STATE_S3 && !acpi_skip_set_wakeup_address()) {
 		acpi_wakeup_address = acpi_get_wakeup_address();
 		if (!acpi_wakeup_address)
 			return -EFAULT;
-- 
2.35.3

