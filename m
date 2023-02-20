Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BAD8F69D58A
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Feb 2023 22:11:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232786AbjBTVL0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Feb 2023 16:11:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232721AbjBTVLY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Feb 2023 16:11:24 -0500
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF3221C7F9;
        Mon, 20 Feb 2023 13:11:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
        s=20170329; h=Content-Transfer-Encoding:MIME-Version:Message-Id:Date:Subject:
        Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:Content-Description:
        Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
        In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=a3LVf7whnZNYyM6/9fdisQFTTZR3PEoZf4vidzT7dAA=; b=hlkUxn03fuq/S0qUoMM49EqkJF
        urfitedtlgNx6Ht4oiZc8WVrWUofRNLcgg/bZQFIwWbPQILcahhRffjDdBa6FuLv+Th6443P4bcTu
        Mn3ZqzEP+CqaVEcSv30gKpUDS+13mpnjBSRfFie687p/LE8NolSEjW0n5503gGE08v2RHcB+mHxCZ
        gU6PW8eDiCVhB+PIXBQEHxWlvT0pYFE+c1Miek0Z+jhxqMarBnFihNsHhAoQkm934KmxHHqXDWZbB
        4he43jUsHt3OZJX8J2RnMMLZS8nrfPezH3EeYT6VvjMpOqRXmlZL+Lbh7rS9diDcyBMJ8CRm/alfa
        m9J6Oj4g==;
Received: from [179.232.147.2] (helo=localhost)
        by fanzine2.igalia.com with esmtpsa 
        (Cipher TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
        id 1pUDRJ-00990y-5t; Mon, 20 Feb 2023 22:11:13 +0100
From:   "Guilherme G. Piccoli" <gpiccoli@igalia.com>
To:     linux-parisc@vger.kernel.org, deller@gmx.de
Cc:     linux-kernel@vger.kernel.org, kernel-dev@igalia.com,
        kernel@gpiccoli.net, "Guilherme G. Piccoli" <gpiccoli@igalia.com>,
        "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>,
        Jeroen Roovers <jer@xs4all.nl>
Subject: [PATCH v4] parisc: Replace regular spinlock with spin_trylock on panic path
Date:   Mon, 20 Feb 2023 18:11:05 -0300
Message-Id: <20230220211105.151401-1-gpiccoli@igalia.com>
X-Mailer: git-send-email 2.39.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The panic notifiers' callbacks execute in an atomic context, with
interrupts/preemption disabled, and all CPUs not running the panic
function are off, so it's very dangerous to wait on a regular
spinlock, there's a risk of deadlock.

Refactor the panic notifier of parisc/power driver to make use
of spin_trylock - for that, we've added a second version of the
soft-power function. Also, some comments were reorganized and
trailing white spaces, useless header inclusion and blank lines
were removed.

Cc: "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>
Cc: Jeroen Roovers <jer@xs4all.nl>
Acked-by: Helge Deller <deller@gmx.de> # parisc
Signed-off-by: Guilherme G. Piccoli <gpiccoli@igalia.com>

---
V4:
- rebase against v6.2 (build-tested).

V3:
- s/in/on as per Jeroen's suggestion - thanks!

V2:
- Added Helge's ACK - thanks!


Hey Helge, this is the V4 - just rebased and build-tested on v6.2.
I remember we discussed the possibility of this getting merged through
the series I've submitted [0], but happens the series is "gone", most of
the patches were picked by maintainers, others I'm dropping. This is really
a standalone fix, similar ones were merged in other notifiers.

I'd appreciate if you/James could pick it for the next kernel, there's no
rush at all, but there's also no series we could throw this patch to get
merged with heh

Thanks in advance,


Guilherme

[0] https://lore.kernel.org/lkml/43de5653-7587-3e8e-274c-b2729649d0fd@gmx.de/


 arch/parisc/include/asm/pdc.h |  1 +
 arch/parisc/kernel/firmware.c | 27 +++++++++++++++++++++++----
 drivers/parisc/power.c        | 17 ++++++++++-------
 3 files changed, 34 insertions(+), 11 deletions(-)

diff --git a/arch/parisc/include/asm/pdc.h b/arch/parisc/include/asm/pdc.h
index 40793bef8429..2b4fad8328e8 100644
--- a/arch/parisc/include/asm/pdc.h
+++ b/arch/parisc/include/asm/pdc.h
@@ -80,6 +80,7 @@ int pdc_do_firm_test_reset(unsigned long ftc_bitmap);
 int pdc_do_reset(void);
 int pdc_soft_power_info(unsigned long *power_reg);
 int pdc_soft_power_button(int sw_control);
+int pdc_soft_power_button_panic(int sw_control);
 void pdc_io_reset(void);
 void pdc_io_reset_devices(void);
 int pdc_iodc_getc(void);
diff --git a/arch/parisc/kernel/firmware.c b/arch/parisc/kernel/firmware.c
index 6817892a2c58..cc124d9f1f7f 100644
--- a/arch/parisc/kernel/firmware.c
+++ b/arch/parisc/kernel/firmware.c
@@ -1232,15 +1232,18 @@ int __init pdc_soft_power_info(unsigned long *power_reg)
 }
 
 /*
- * pdc_soft_power_button - Control the soft power button behaviour
- * @sw_control: 0 for hardware control, 1 for software control 
+ * pdc_soft_power_button{_panic} - Control the soft power button behaviour
+ * @sw_control: 0 for hardware control, 1 for software control
  *
  *
  * This PDC function places the soft power button under software or
  * hardware control.
- * Under software control the OS may control to when to allow to shut 
- * down the system. Under hardware control pressing the power button 
+ * Under software control the OS may control to when to allow to shut
+ * down the system. Under hardware control pressing the power button
  * powers off the system immediately.
+ *
+ * The _panic version relies on spin_trylock to prevent deadlock
+ * on panic path.
  */
 int pdc_soft_power_button(int sw_control)
 {
@@ -1254,6 +1257,22 @@ int pdc_soft_power_button(int sw_control)
 	return retval;
 }
 
+int pdc_soft_power_button_panic(int sw_control)
+{
+	int retval;
+	unsigned long flags;
+
+	if (!spin_trylock_irqsave(&pdc_lock, flags)) {
+		pr_emerg("Couldn't enable soft power button\n");
+		return -EBUSY; /* ignored by the panic notifier */
+	}
+
+	retval = mem_pdc_call(PDC_SOFT_POWER, PDC_SOFT_POWER_ENABLE, __pa(pdc_result), sw_control);
+	spin_unlock_irqrestore(&pdc_lock, flags);
+
+	return retval;
+}
+
 /*
  * pdc_io_reset - Hack to avoid overlapping range registers of Bridges devices.
  * Primarily a problem on T600 (which parisc-linux doesn't support) but
diff --git a/drivers/parisc/power.c b/drivers/parisc/power.c
index 456776bd8ee6..8512884de2cf 100644
--- a/drivers/parisc/power.c
+++ b/drivers/parisc/power.c
@@ -37,7 +37,6 @@
 #include <linux/module.h>
 #include <linux/init.h>
 #include <linux/kernel.h>
-#include <linux/notifier.h>
 #include <linux/panic_notifier.h>
 #include <linux/reboot.h>
 #include <linux/sched/signal.h>
@@ -175,16 +174,21 @@ static void powerfail_interrupt(int code, void *x)
 
 
 
-/* parisc_panic_event() is called by the panic handler.
- * As soon as a panic occurs, our tasklets above will not be
- * executed any longer. This function then re-enables the 
- * soft-power switch and allows the user to switch off the system
+/*
+ * parisc_panic_event() is called by the panic handler.
+ *
+ * As soon as a panic occurs, our tasklets above will not
+ * be executed any longer. This function then re-enables
+ * the soft-power switch and allows the user to switch off
+ * the system. We rely in pdc_soft_power_button_panic()
+ * since this version spin_trylocks (instead of regular
+ * spinlock), preventing deadlocks on panic path.
  */
 static int parisc_panic_event(struct notifier_block *this,
 		unsigned long event, void *ptr)
 {
 	/* re-enable the soft-power switch */
-	pdc_soft_power_button(0);
+	pdc_soft_power_button_panic(0);
 	return NOTIFY_DONE;
 }
 
@@ -193,7 +197,6 @@ static struct notifier_block parisc_panic_block = {
 	.priority	= INT_MAX,
 };
 
-
 static int __init power_init(void)
 {
 	unsigned long ret;
-- 
2.39.1

