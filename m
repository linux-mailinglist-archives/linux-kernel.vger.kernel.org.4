Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D006563D7E9
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Nov 2022 15:15:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229771AbiK3OPB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Nov 2022 09:15:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229603AbiK3OOt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Nov 2022 09:14:49 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14F3D7CA8D;
        Wed, 30 Nov 2022 06:14:37 -0800 (PST)
Date:   Wed, 30 Nov 2022 14:14:33 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1669817675;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=FVO6zWidXe6Zg/00vyTjYgijpJdIvLIKWg8mwZB6WUk=;
        b=jJr6lvwE5HoKZQ3iwBpA72pDmyP3fzGq2uChpeVtnJAA5sKmEMfDjGtob0EtNYY3QS4Zqj
        AtxedjVzosKK/C2+SpoDtjTCPNpSikL8up/sO0Fm8akKVJwuAkoerP6jDhg+ptRp7PU9ES
        Ios+SgGVeyeJk3dCxIebZymao7qahpmU6uftk4FTmwqBBaJJWHRlhCzbW308olJh2lqXRQ
        nt3iHiS3KzfS6JFED+0AXQ5t5JQyVpirGrUQU6d2J8pm8s8G0cPaxlFNWUvLn6EisGS8Xo
        Qk44zO3fPoh0wVVF1iPII3gKQBh7y8qipbpZ/K7u6sYPEjG57kZK3AyC9QJA6Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1669817675;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=FVO6zWidXe6Zg/00vyTjYgijpJdIvLIKWg8mwZB6WUk=;
        b=v3r7yglRuFcMRjgVjbNVSQOPNp4epMuUebQWMxga/8zZwizx0ggqZczYEF2t/1n84TdpU/
        y7BJL+KlQBLGmtAA==
From:   "tip-bot2 for Yang Yingliang" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: irq/core] genirq/irqdesc: Don't try to remove non-existing sysfs files
Cc:     Yang Yingliang <yangyingliang@huawei.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org, maz@kernel.org
In-Reply-To: <20221128151612.1786122-1-yangyingliang@huawei.com>
References: <20221128151612.1786122-1-yangyingliang@huawei.com>
MIME-Version: 1.0
Message-ID: <166981767350.4906.13064198854331518868.tip-bot2@tip-bot2>
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

The following commit has been merged into the irq/core branch of tip:

Commit-ID:     9049e1ca41983ab773d7ea244bee86d7835ec9f5
Gitweb:        https://git.kernel.org/tip/9049e1ca41983ab773d7ea244bee86d7835ec9f5
Author:        Yang Yingliang <yangyingliang@huawei.com>
AuthorDate:    Mon, 28 Nov 2022 23:16:12 +08:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Wed, 30 Nov 2022 14:52:11 +01:00

genirq/irqdesc: Don't try to remove non-existing sysfs files

Fault injection tests trigger warnings like this:

  kernfs: can not remove 'chip_name', no directory
  WARNING: CPU: 0 PID: 253 at fs/kernfs/dir.c:1616 kernfs_remove_by_name_ns+0xce/0xe0
  RIP: 0010:kernfs_remove_by_name_ns+0xce/0xe0
  Call Trace:
   <TASK>
   remove_files.isra.1+0x3f/0xb0
   sysfs_remove_group+0x68/0xe0
   sysfs_remove_groups+0x41/0x70
   __kobject_del+0x45/0xc0
   kobject_del+0x29/0x40
   free_desc+0x42/0x70
   irq_free_descs+0x5e/0x90

The reason is that the interrupt descriptor sysfs handling does not roll
back on a failing kobject_add() during allocation. If the descriptor is
freed later on, kobject_del() is invoked with a not added kobject resulting
in the above warnings.

A proper rollback in case of a kobject_add() failure would be the straight
forward solution. But this is not possible due to the way how interrupt
descriptor sysfs handling works.

Interrupt descriptors are allocated before sysfs becomes available. So the
sysfs files for the early allocated descriptors are added later in the boot
process. At this point there can be nothing useful done about a failing
kobject_add(). For consistency the interrupt descriptor allocation always
treats kobject_add() failures as non-critical and just emits a warning.

To solve this problem, keep track in the interrupt descriptor whether
kobject_add() was successful or not and make the invocation of
kobject_del() conditional on that.

[ tglx: Massage changelog, comments and use a state bit. ]

Fixes: ecb3f394c5db ("genirq: Expose interrupt information through sysfs")
Signed-off-by: Yang Yingliang <yangyingliang@huawei.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Link: https://lore.kernel.org/r/20221128151612.1786122-1-yangyingliang@huawei.com
---
 kernel/irq/internals.h |  2 ++
 kernel/irq/irqdesc.c   | 15 +++++++++------
 2 files changed, 11 insertions(+), 6 deletions(-)

diff --git a/kernel/irq/internals.h b/kernel/irq/internals.h
index f09c603..5fdc0b5 100644
--- a/kernel/irq/internals.h
+++ b/kernel/irq/internals.h
@@ -52,6 +52,7 @@ enum {
  * IRQS_PENDING			- irq is pending and replayed later
  * IRQS_SUSPENDED		- irq is suspended
  * IRQS_NMI			- irq line is used to deliver NMIs
+ * IRQS_SYSFS			- descriptor has been added to sysfs
  */
 enum {
 	IRQS_AUTODETECT		= 0x00000001,
@@ -64,6 +65,7 @@ enum {
 	IRQS_SUSPENDED		= 0x00000800,
 	IRQS_TIMINGS		= 0x00001000,
 	IRQS_NMI		= 0x00002000,
+	IRQS_SYSFS		= 0x00004000,
 };
 
 #include "debug.h"
diff --git a/kernel/irq/irqdesc.c b/kernel/irq/irqdesc.c
index a91f900..fd09962 100644
--- a/kernel/irq/irqdesc.c
+++ b/kernel/irq/irqdesc.c
@@ -288,22 +288,25 @@ static void irq_sysfs_add(int irq, struct irq_desc *desc)
 	if (irq_kobj_base) {
 		/*
 		 * Continue even in case of failure as this is nothing
-		 * crucial.
+		 * crucial and failures in the late irq_sysfs_init()
+		 * cannot be rolled back.
 		 */
 		if (kobject_add(&desc->kobj, irq_kobj_base, "%d", irq))
 			pr_warn("Failed to add kobject for irq %d\n", irq);
+		else
+			desc->istate |= IRQS_SYSFS;
 	}
 }
 
 static void irq_sysfs_del(struct irq_desc *desc)
 {
 	/*
-	 * If irq_sysfs_init() has not yet been invoked (early boot), then
-	 * irq_kobj_base is NULL and the descriptor was never added.
-	 * kobject_del() complains about a object with no parent, so make
-	 * it conditional.
+	 * Only invoke kobject_del() when kobject_add() was successfully
+	 * invoked for the descriptor. This covers both early boot, where
+	 * sysfs is not initialized yet, and the case of a failed
+	 * kobject_add() invocation.
 	 */
-	if (irq_kobj_base)
+	if (desc->istate & IRQS_SYSFS)
 		kobject_del(&desc->kobj);
 }
 
