Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E2262665BB4
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Jan 2023 13:46:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232758AbjAKMqb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Jan 2023 07:46:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231972AbjAKMqW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jan 2023 07:46:22 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C11AE1DE;
        Wed, 11 Jan 2023 04:46:21 -0800 (PST)
Date:   Wed, 11 Jan 2023 12:46:18 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1673441179;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=HJRmCe2JRPrclyZDv+jxp2gCtkF0MB5rMYfHRUF55lY=;
        b=v/08Vtu93GWOvzbL3W9z+cBDQK+TN1qqqrR66fvjzYO30IHyK9UZ51CUruPNEzWDJIGCcw
        hYI+xS0U/nJLWRDNDJJtIeG81AQHQJGrq1S5aeNMepSOsvJ0OlCnyd/RrQ3UBsTGyjiGs1
        XtIaTN2HpdfVaOV/n8QenwGGzVkLiBfKdXQS0qVGLMzUIa6uqsCsKvI61Tcx47g23/lsna
        3E4Ym4Hnbo5rscWcMqPA9doOdy/ATFA7MPS++FKv1USREq04i++KKwIq0pAjoJnGwGZ98B
        ctFU745KwIiT8QOGmZd9u9qg3wgP8FmBJ8Y6bYWZy4QFECOR6AgvonlRM8Vvkw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1673441179;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=HJRmCe2JRPrclyZDv+jxp2gCtkF0MB5rMYfHRUF55lY=;
        b=OboHnC1keQvF/IqHOrgHfPYZfLgdLYCuOjFhDUjX3Axj9hqkt0NotVrgokR6gJ77EjL5st
        b47xyQqiW+31JaDg==
From:   "tip-bot2 for Yuntao Wang" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/cleanups] x86/setup: Move duplicate boot_cpu_data
 definition out of the ifdeffery
Cc:     Yuntao Wang <ytcoode@gmail.com>,
        "Borislav Petkov (AMD)" <bp@alien8.de>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20220601122914.820890-1-ytcoode@gmail.com>
References: <20220601122914.820890-1-ytcoode@gmail.com>
MIME-Version: 1.0
Message-ID: <167344117807.4906.12901315064552359156.tip-bot2@tip-bot2>
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

The following commit has been merged into the x86/cleanups branch of tip:

Commit-ID:     50c66d7b049ddec095644a005bfe0b28e22c4b02
Gitweb:        https://git.kernel.org/tip/50c66d7b049ddec095644a005bfe0b28e22c4b02
Author:        Yuntao Wang <ytcoode@gmail.com>
AuthorDate:    Wed, 01 Jun 2022 20:29:14 +08:00
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Wed, 11 Jan 2023 12:45:16 +01:00

x86/setup: Move duplicate boot_cpu_data definition out of the ifdeffery

Both the if and else blocks define an exact same boot_cpu_data variable, move
the duplicate variable definition out of the if/else block.

In addition, do some other minor cleanups.

  [ bp: Massage. ]

Signed-off-by: Yuntao Wang <ytcoode@gmail.com>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Link: https://lore.kernel.org/r/20220601122914.820890-1-ytcoode@gmail.com
---
 arch/x86/kernel/e820.c  |  4 ++--
 arch/x86/kernel/setup.c | 10 ++--------
 2 files changed, 4 insertions(+), 10 deletions(-)

diff --git a/arch/x86/kernel/e820.c b/arch/x86/kernel/e820.c
index 0614a79..fb8cf95 100644
--- a/arch/x86/kernel/e820.c
+++ b/arch/x86/kernel/e820.c
@@ -395,7 +395,7 @@ int __init e820__update_table(struct e820_table *table)
 
 		/* Continue building up new map based on this information: */
 		if (current_type != last_type || e820_nomerge(current_type)) {
-			if (last_type != 0)	 {
+			if (last_type) {
 				new_entries[new_nr_entries].size = change_point[chg_idx]->addr - last_addr;
 				/* Move forward only if the new size was non-zero: */
 				if (new_entries[new_nr_entries].size != 0)
@@ -403,7 +403,7 @@ int __init e820__update_table(struct e820_table *table)
 					if (++new_nr_entries >= max_nr_entries)
 						break;
 			}
-			if (current_type != 0)	{
+			if (current_type) {
 				new_entries[new_nr_entries].addr = change_point[chg_idx]->addr;
 				new_entries[new_nr_entries].type = current_type;
 				last_addr = change_point[chg_idx]->addr;
diff --git a/arch/x86/kernel/setup.c b/arch/x86/kernel/setup.c
index 8818854..16babff 100644
--- a/arch/x86/kernel/setup.c
+++ b/arch/x86/kernel/setup.c
@@ -114,11 +114,6 @@ static struct resource bss_resource = {
 #ifdef CONFIG_X86_32
 /* CPU data as detected by the assembly code in head_32.S */
 struct cpuinfo_x86 new_cpu_data;
-
-/* Common CPU data for all CPUs */
-struct cpuinfo_x86 boot_cpu_data __read_mostly;
-EXPORT_SYMBOL(boot_cpu_data);
-
 unsigned int def_to_bigsmp;
 
 struct apm_info apm_info;
@@ -132,11 +127,10 @@ EXPORT_SYMBOL(ist_info);
 struct ist_info ist_info;
 #endif
 
-#else
-struct cpuinfo_x86 boot_cpu_data __read_mostly;
-EXPORT_SYMBOL(boot_cpu_data);
 #endif
 
+struct cpuinfo_x86 boot_cpu_data __read_mostly;
+EXPORT_SYMBOL(boot_cpu_data);
 
 #if !defined(CONFIG_X86_PAE) || defined(CONFIG_X86_64)
 __visible unsigned long mmu_cr4_features __ro_after_init;
