Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF1E472285F
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Jun 2023 16:09:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230371AbjFEOJV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Jun 2023 10:09:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234202AbjFEOIe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Jun 2023 10:08:34 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55C7F100;
        Mon,  5 Jun 2023 07:08:18 -0700 (PDT)
Date:   Mon, 05 Jun 2023 14:08:15 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1685974096;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=flAU8Kxin3DTwjlsDB2c7PPQk1Z5ZpuKbdc2pbw8unw=;
        b=01ZIvxV6sxX09zqB3WyumyD0LvvmROtUBVIF0ZqM4rO+ZZhUJ2SmASKrZCxcT4jKoX8QAX
        DLx5s/Lya2T14dzSIOracDvgT2/7XNCJHisM9sobybXZJHuXKueHojVKSTEu7QRCXw9Fmo
        xy4f7vt99CoY+/R4JMLUG/cZgaho3m1JIy5pzh5RJ6XInxkh/XiSXUiD65bQu4nNXQaXjA
        H3D5ShFiOvV6PsmhooKgNVYswfr0bvi4TkFo2kV14rRvrv+sxbtn7tOQBNri3q7y18QHGN
        A0YGlk9HXc/z5gwN55ZyJERL0YuCvLm/I/C2IsfY28MIT+31rFqAfioy7U8TFg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1685974096;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=flAU8Kxin3DTwjlsDB2c7PPQk1Z5ZpuKbdc2pbw8unw=;
        b=/4wSTnir7TH5e1pHiPxpNRw7d7duAyR8PMw4cgM23e76Qrrzxb/BpyMTEpk+ZfyQvDMF3V
        iKMGwLBtn997Q4Bg==
From:   "tip-bot2 for Juergen Gross" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/mtrr] x86/mtrr: Have only one set_mtrr() variant
Cc:     Juergen Gross <jgross@suse.com>,
        "Borislav Petkov (AMD)" <bp@alien8.de>,
        Michael Kelley <mikelley@microsoft.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20230502120931.20719-8-jgross@suse.com>
References: <20230502120931.20719-8-jgross@suse.com>
MIME-Version: 1.0
Message-ID: <168597409590.404.1718981891238519233.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the x86/mtrr branch of tip:

Commit-ID:     34cf2d19552bbe3b72b34fc859a19cd5070c466a
Gitweb:        https://git.kernel.org/tip/34cf2d19552bbe3b72b34fc859a19cd5070c466a
Author:        Juergen Gross <jgross@suse.com>
AuthorDate:    Tue, 02 May 2023 14:09:22 +02:00
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Thu, 01 Jun 2023 15:04:32 +02:00

x86/mtrr: Have only one set_mtrr() variant

Today there are two variants of set_mtrr(): one calling stop_machine()
and one calling stop_machine_cpuslocked().

The first one (set_mtrr()) has only one caller, and this caller is
running only when resuming from suspend when the interrupts are still
off and only one CPU is active. Additionally this code is used only on
rather old 32-bit CPUs not supporting SMP.

For these reasons the first variant can be replaced by a simple call of
mtrr_if->set().

Rename the second variant set_mtrr_cpuslocked() to set_mtrr() now that
there is only one variant left, in order to have a shorter function
name.

Signed-off-by: Juergen Gross <jgross@suse.com>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Tested-by: Michael Kelley <mikelley@microsoft.com>
Link: https://lore.kernel.org/r/20230502120931.20719-8-jgross@suse.com
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
---
 arch/x86/kernel/cpu/mtrr/mtrr.c | 28 ++++++++--------------------
 1 file changed, 8 insertions(+), 20 deletions(-)

diff --git a/arch/x86/kernel/cpu/mtrr/mtrr.c b/arch/x86/kernel/cpu/mtrr/mtrr.c
index 85113af..007ecca 100644
--- a/arch/x86/kernel/cpu/mtrr/mtrr.c
+++ b/arch/x86/kernel/cpu/mtrr/mtrr.c
@@ -173,20 +173,8 @@ static inline int types_compatible(mtrr_type type1, mtrr_type type2)
  * Note that the mechanism is the same for UP systems, too; all the SMP stuff
  * becomes nops.
  */
-static void
-set_mtrr(unsigned int reg, unsigned long base, unsigned long size, mtrr_type type)
-{
-	struct set_mtrr_data data = { .smp_reg = reg,
-				      .smp_base = base,
-				      .smp_size = size,
-				      .smp_type = type
-				    };
-
-	stop_machine(mtrr_rendezvous_handler, &data, cpu_online_mask);
-}
-
-static void set_mtrr_cpuslocked(unsigned int reg, unsigned long base,
-				unsigned long size, mtrr_type type)
+static void set_mtrr(unsigned int reg, unsigned long base, unsigned long size,
+		     mtrr_type type)
 {
 	struct set_mtrr_data data = { .smp_reg = reg,
 				      .smp_base = base,
@@ -316,7 +304,7 @@ int mtrr_add_page(unsigned long base, unsigned long size,
 	/* Search for an empty MTRR */
 	i = mtrr_if->get_free_region(base, size, replace);
 	if (i >= 0) {
-		set_mtrr_cpuslocked(i, base, size, type);
+		set_mtrr(i, base, size, type);
 		if (likely(replace < 0)) {
 			mtrr_usage_table[i] = 1;
 		} else {
@@ -324,7 +312,7 @@ int mtrr_add_page(unsigned long base, unsigned long size,
 			if (increment)
 				mtrr_usage_table[i]++;
 			if (unlikely(replace != i)) {
-				set_mtrr_cpuslocked(replace, 0, 0, 0);
+				set_mtrr(replace, 0, 0, 0);
 				mtrr_usage_table[replace] = 0;
 			}
 		}
@@ -452,7 +440,7 @@ int mtrr_del_page(int reg, unsigned long base, unsigned long size)
 		goto out;
 	}
 	if (--mtrr_usage_table[reg] < 1)
-		set_mtrr_cpuslocked(reg, 0, 0, 0);
+		set_mtrr(reg, 0, 0, 0);
 	error = reg;
  out:
 	mutex_unlock(&mtrr_mutex);
@@ -582,9 +570,9 @@ static void mtrr_restore(void)
 
 	for (i = 0; i < num_var_ranges; i++) {
 		if (mtrr_value[i].lsize) {
-			set_mtrr(i, mtrr_value[i].lbase,
-				    mtrr_value[i].lsize,
-				    mtrr_value[i].ltype);
+			mtrr_if->set(i, mtrr_value[i].lbase,
+				     mtrr_value[i].lsize,
+				     mtrr_value[i].ltype);
 		}
 	}
 }
