Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA64064081B
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Dec 2022 15:04:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233413AbiLBOEF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Dec 2022 09:04:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233203AbiLBOEC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Dec 2022 09:04:02 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 640C3CCFC6;
        Fri,  2 Dec 2022 06:04:01 -0800 (PST)
Date:   Fri, 02 Dec 2022 14:03:58 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1669989840;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=9iVzQvZbEt7yaSBsiDKwN4A1tJdmjDFR+KuFuuwSQic=;
        b=0vJ7OIzB9yib9Vifjs8v6pUrj3TYVOXQJYeqnH7asfkSCDEmSoK9PVYriSN8/ZSUyi5PZ4
        c1QhJSh/Qw70+hR1IjfvR6n22w1/NCingU/0JZ+TNRrmswKyZhvjrODh9q1ZUHSQSLotYW
        FABZN+3in10tg/8D10pTWBhnNcd3W8+3UT9Ppch3dTNPt6ov6IuHUKrsGhWVo+b9fpw/5f
        ecYpfZaj5haOxh15FkcRK78SOLPpindbCM4DT8bV8WwE/8puC/a1Cy8QtUziLTQVzTUGt0
        dVelHqZvPgmDtCuOYIA+IqLi+Rw2g3aOuLxqG0PdYRKHa5rT/4x1Zr+a8hxTtw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1669989840;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=9iVzQvZbEt7yaSBsiDKwN4A1tJdmjDFR+KuFuuwSQic=;
        b=7PZ03XTUOp8fPRgrWPS93owWiMe5ZqRYreb9YqKBxeVNc//pYWA8BHicepjVowt3MB1Tha
        afb/OFD6svWT1tAQ==
From:   "tip-bot2 for Rahul Tanwar" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/apic] x86/of: Replace printk(KERN_LVL) with pr_lvl()
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Rahul Tanwar <rtanwar@maxlinear.com>,
        Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20221124084143.21841-4-rtanwar@maxlinear.com>
References: <20221124084143.21841-4-rtanwar@maxlinear.com>
MIME-Version: 1.0
Message-ID: <166998983862.4906.5810287160268183726.tip-bot2@tip-bot2>
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

The following commit has been merged into the x86/apic branch of tip:

Commit-ID:     535403323b4dcdc363e7ea265df62481b903826b
Gitweb:        https://git.kernel.org/tip/535403323b4dcdc363e7ea265df62481b903826b
Author:        Rahul Tanwar <rtanwar@maxlinear.com>
AuthorDate:    Thu, 24 Nov 2022 16:41:42 +08:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Fri, 02 Dec 2022 14:57:14 +01:00

x86/of: Replace printk(KERN_LVL) with pr_lvl()

Use pr_lvl() instead of the deprecated printk(KERN_LVL).

Just a upgrade of print utilities usage. no functional changes.

Suggested-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Signed-off-by: Rahul Tanwar <rtanwar@maxlinear.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Link: https://lore.kernel.org/r/20221124084143.21841-4-rtanwar@maxlinear.com

---
 arch/x86/kernel/devicetree.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/x86/kernel/devicetree.c b/arch/x86/kernel/devicetree.c
index 59438d2..484783f 100644
--- a/arch/x86/kernel/devicetree.c
+++ b/arch/x86/kernel/devicetree.c
@@ -243,7 +243,7 @@ static void __init dtb_add_ioapic(struct device_node *dn)
 
 	ret = of_address_to_resource(dn, 0, &r);
 	if (ret) {
-		printk(KERN_ERR "Can't obtain address from device node %pOF.\n", dn);
+		pr_err("Can't obtain address from device node %pOF.\n", dn);
 		return;
 	}
 	mp_register_ioapic(++ioapic_id, r.start, gsi_top, &cfg);
@@ -260,7 +260,7 @@ static void __init dtb_ioapic_setup(void)
 		of_ioapic = 1;
 		return;
 	}
-	printk(KERN_ERR "Error: No information about IO-APIC in OF.\n");
+	pr_err("Error: No information about IO-APIC in OF.\n");
 }
 #else
 static void __init dtb_ioapic_setup(void) {}
