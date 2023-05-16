Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C41370487A
	for <lists+linux-kernel@lfdr.de>; Tue, 16 May 2023 11:10:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231790AbjEPJKG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 May 2023 05:10:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229510AbjEPJJ6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 May 2023 05:09:58 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E05030CF;
        Tue, 16 May 2023 02:09:56 -0700 (PDT)
Date:   Tue, 16 May 2023 09:09:54 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1684228194;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=mtlhvL39diIsHoEJEeHi/4xzRIVFTtzXhH36aRuQsIc=;
        b=298a2DrEuTwk7HVjGyp2vWepEfugPTdMAUTU523dTeQ59Rph9GS3+j9UufrjUlassdryhN
        3txvxwQA5A7wqbk3Hw9NRj/oNCLZ3gduLBI5UwPhxMY4QFMEUtb5CKu873rV/xvZwhr/BN
        npjvJvCysua2AEyCiW6NkuvFbQ4NSTteA5UOYSAsZHFkllrpUxT/+RW4HbOr6Y7A3nKjNg
        SC4CJHVeRA+7HiKd5zknus++MT70XteIHBBKa7FgMBqeIS2/wL8zrNRRfBBxoFj1764IN3
        q4+ly9M4KFTTY9MqmFqyLT+aBuKdrvfH0VpHcMqi/8nGm/WiP/27xpsY921S5A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1684228194;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=mtlhvL39diIsHoEJEeHi/4xzRIVFTtzXhH36aRuQsIc=;
        b=c6r1QdGUbJmFLpvWdCvOl8JnlxvMXvHzBFOyxR0xpvsMwKAC99DJMj9r5q+aWRny6ecZEZ
        BAu4SLtu8pi458AA==
From:   "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: smp/core] x86/apic: Save the APIC virtual base address
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Michael Kelley <mikelley@microsoft.com>,
        Oleksandr Natalenko <oleksandr@natalenko.name>,
        Helge Deller <deller@gmx.de>,
        "Guilherme G. Piccoli" <gpiccoli@igalia.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20230512205257.299231005@linutronix.de>
References: <20230512205257.299231005@linutronix.de>
MIME-Version: 1.0
Message-ID: <168422819438.404.10533112303979170137.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the smp/core branch of tip:

Commit-ID:     bea629d57d006733d155bdb65ba4867788da69b6
Gitweb:        https://git.kernel.org/tip/bea629d57d006733d155bdb65ba4867788da69b6
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Fri, 12 May 2023 23:07:51 +02:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Mon, 15 May 2023 13:45:03 +02:00

x86/apic: Save the APIC virtual base address

For parallel CPU brinugp it's required to read the APIC ID in the low level
startup code. The virtual APIC base address is a constant because its a
fix-mapped address. Exposing that constant which is composed via macros to
assembly code is non-trivial due to header inclusion hell.

Aside of that it's constant only because of the vsyscall ABI
requirement. Once vsyscall is out of the picture the fixmap can be placed
at runtime.

Avoid header hell, stay flexible and store the address in a variable which
can be exposed to the low level startup code.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Tested-by: Michael Kelley <mikelley@microsoft.com>
Tested-by: Oleksandr Natalenko <oleksandr@natalenko.name>
Tested-by: Helge Deller <deller@gmx.de> # parisc
Tested-by: Guilherme G. Piccoli <gpiccoli@igalia.com> # Steam Deck
Link: https://lore.kernel.org/r/20230512205257.299231005@linutronix.de
---
 arch/x86/include/asm/smp.h  | 1 +
 arch/x86/kernel/apic/apic.c | 4 ++++
 2 files changed, 5 insertions(+)

diff --git a/arch/x86/include/asm/smp.h b/arch/x86/include/asm/smp.h
index 726c2a2..c6d5b65 100644
--- a/arch/x86/include/asm/smp.h
+++ b/arch/x86/include/asm/smp.h
@@ -196,6 +196,7 @@ extern void nmi_selftest(void);
 #endif
 
 extern unsigned int smpboot_control;
+extern unsigned long apic_mmio_base;
 
 #endif /* !__ASSEMBLY__ */
 
diff --git a/arch/x86/kernel/apic/apic.c b/arch/x86/kernel/apic/apic.c
index e17600d..d3f6c18 100644
--- a/arch/x86/kernel/apic/apic.c
+++ b/arch/x86/kernel/apic/apic.c
@@ -101,6 +101,9 @@ static int apic_extnmi __ro_after_init = APIC_EXTNMI_BSP;
  */
 static bool virt_ext_dest_id __ro_after_init;
 
+/* For parallel bootup. */
+unsigned long apic_mmio_base __ro_after_init;
+
 /*
  * Map cpu index to physical APIC ID
  */
@@ -2163,6 +2166,7 @@ void __init register_lapic_address(unsigned long address)
 
 	if (!x2apic_mode) {
 		set_fixmap_nocache(FIX_APIC_BASE, address);
+		apic_mmio_base = APIC_BASE;
 		apic_printk(APIC_VERBOSE, "mapped APIC to %16lx (%16lx)\n",
 			    APIC_BASE, address);
 	}
