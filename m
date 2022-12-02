Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 24A32640819
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Dec 2022 15:04:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233332AbiLBOED (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Dec 2022 09:04:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231776AbiLBOEB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Dec 2022 09:04:01 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3599BCCFF0;
        Fri,  2 Dec 2022 06:04:00 -0800 (PST)
Date:   Fri, 02 Dec 2022 14:03:57 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1669989838;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=v9/VVB6YB4wgZHpv4JxrSHkdVN43DQfG6ar/1FBDzPY=;
        b=ayIxdckXlrlkUKiQek92NRftJ2jIVde3UnRJl+Pg522qr3Rw35u0mn0YHUJxHBjCHkr0/g
        szYakWh5ofW43NieOlXNxw4yJu9gaWwG2CYGKgg9mCmUtPaSZMXzMXsRWzlF8inQWUCTN/
        i3ZJD3iftxvY25AQDCMUVrx9VqOUDCIrrJfwklinzBV6phvGSEduzUrUGav36RXcbqpUw7
        wJ6ZSy8woaLi0MuTfTLKOOsd3CEWt81TFVzQuHXrKXVvrVbWcfThnakJjF+0yW6oYVhq+i
        pNOWzo3EeOmr0wTWpGs3CSHaAxBtU3w+jGMrJ05sdzmejvRrDhkdF89jjhw5cA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1669989838;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=v9/VVB6YB4wgZHpv4JxrSHkdVN43DQfG6ar/1FBDzPY=;
        b=7CCHGJkvu2uuSpyJRgmyCXEOHi6FQoqWux2FM3sHlmA9UxBgVJxpZv1GTJQEx8PqXTJVOc
        SG8rNbtlcXzkKdCw==
From:   "tip-bot2 for Rahul Tanwar" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/apic] x86/of: Add support for boot time interrupt delivery
 mode configuration
Cc:     Rahul Tanwar <rtanwar@maxlinear.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20221124084143.21841-5-rtanwar@maxlinear.com>
References: <20221124084143.21841-5-rtanwar@maxlinear.com>
MIME-Version: 1.0
Message-ID: <166998983740.4906.7393408926569297500.tip-bot2@tip-bot2>
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

Commit-ID:     2833275568755eb937a52c358bf8bfa7125a463e
Gitweb:        https://git.kernel.org/tip/2833275568755eb937a52c358bf8bfa7125a463e
Author:        Rahul Tanwar <rtanwar@maxlinear.com>
AuthorDate:    Thu, 24 Nov 2022 16:41:43 +08:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Fri, 02 Dec 2022 14:57:14 +01:00

x86/of: Add support for boot time interrupt delivery mode configuration

Presently, init/boot time interrupt delivery mode is enumerated only for
ACPI enabled systems by parsing MADT table or for older systems by parsing
MP table. But for OF based x86 systems, it is assumed & hardcoded to be
legacy PIC mode. This causes a boot time crash for platforms which do not
provide a 8259 compliant legacy PIC.

Add support for configuration of init time interrupt delivery mode for x86
OF based systems by introducing a new optional boolean property
'intel,virtual-wire-mode' for the local APIC interrupt-controller
node. This property emulates IMCRP Bit 7 of MP feature info byte 2 of MP
floating pointer structure.

Defaults to legacy PIC mode if absent. Configures it to virtual wire
compatibility mode if present.

Signed-off-by: Rahul Tanwar <rtanwar@maxlinear.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Link: https://lore.kernel.org/r/20221124084143.21841-5-rtanwar@maxlinear.com

---
 arch/x86/kernel/devicetree.c |  9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/arch/x86/kernel/devicetree.c b/arch/x86/kernel/devicetree.c
index 484783f..28da5dd 100644
--- a/arch/x86/kernel/devicetree.c
+++ b/arch/x86/kernel/devicetree.c
@@ -162,7 +162,14 @@ static void __init dtb_lapic_setup(void)
 			return;
 	}
 	smp_found_config = 1;
-	pic_mode = 1;
+	if (of_property_read_bool(dn, "intel,virtual-wire-mode")) {
+		pr_info("Virtual Wire compatibility mode.\n");
+		pic_mode = 0;
+	} else {
+		pr_info("IMCR and PIC compatibility mode.\n");
+		pic_mode = 1;
+	}
+
 	register_lapic_address(lapic_addr);
 }
 
