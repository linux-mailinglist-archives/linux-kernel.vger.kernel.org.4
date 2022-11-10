Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 32F3E624235
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Nov 2022 13:22:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230373AbiKJMWM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Nov 2022 07:22:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230511AbiKJMVz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Nov 2022 07:21:55 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6388671F39;
        Thu, 10 Nov 2022 04:21:54 -0800 (PST)
Date:   Thu, 10 Nov 2022 12:21:51 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1668082912;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=FXUGUmHVztvXiUFfSp49JyGGH77rTqfAQ5M+mn70WN0=;
        b=LzFXk6Ds37LC6Na+1TnUv8xQ+mmNLtP6bvkrpMet29roROd6uK1UZ2eDSwOMbvc7g/Vtt5
        qc9bPe3WpzRhOJknumC2O6ruixMsu6PXOL8OYAQwDCiF43wTQPe+dMHbpYDa66zKzl3g4c
        FNAsePdDLGi/rFRNBMDcDrVZLSsvTWf4ohXW00XGu61BQuraXhG7/1ezjmN2Er2kB8ZjQL
        7S/dnb0pQwQ4DG7VQfMdRWb64akuaDYStXTXtI+T/vaw6ovHWbRG9BVeuHouLOlclXbI7F
        1WTg6RVp5aelEHPu6xt50TImqIiPh2354iAEBLANeJ6kq547Kn42O4GKFkTIpA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1668082912;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=FXUGUmHVztvXiUFfSp49JyGGH77rTqfAQ5M+mn70WN0=;
        b=31r5zjYQW8oC1rn5Dm2YDyoJOS/4M9QwidvlDxdDkWzWk5eC8i/uqV/Dl6Y83uAoVGw4c7
        a2cjm2JmM/Imp+AA==
From:   "tip-bot2 for Juergen Gross" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/cpu] x86/mtrr: Get rid of __mtrr_enabled bool
Cc:     Juergen Gross <jgross@suse.com>, Borislav Petkov <bp@suse.de>,
        x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20221102074713.21493-11-jgross@suse.com>
References: <20221102074713.21493-11-jgross@suse.com>
MIME-Version: 1.0
Message-ID: <166808291144.4906.5479534942233014334.tip-bot2@tip-bot2>
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

Commit-ID:     2c15679e8687d5934e1a70fe50ce409bb8a2aba1
Gitweb:        https://git.kernel.org/tip/2c15679e8687d5934e1a70fe50ce409bb8a2aba1
Author:        Juergen Gross <jgross@suse.com>
AuthorDate:    Wed, 02 Nov 2022 08:47:07 +01:00
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Thu, 10 Nov 2022 13:12:45 +01:00

x86/mtrr: Get rid of __mtrr_enabled bool

There is no need for keeping __mtrr_enabled as it can easily be replaced
by testing mtrr_if to be not NULL.

Signed-off-by: Juergen Gross <jgross@suse.com>
Signed-off-by: Borislav Petkov <bp@suse.de>
Link: https://lore.kernel.org/r/20221102074713.21493-11-jgross@suse.com
Signed-off-by: Borislav Petkov <bp@suse.de>
---
 arch/x86/kernel/cpu/mtrr/mtrr.c | 13 +++++--------
 1 file changed, 5 insertions(+), 8 deletions(-)

diff --git a/arch/x86/kernel/cpu/mtrr/mtrr.c b/arch/x86/kernel/cpu/mtrr/mtrr.c
index a468be5..f671be9 100644
--- a/arch/x86/kernel/cpu/mtrr/mtrr.c
+++ b/arch/x86/kernel/cpu/mtrr/mtrr.c
@@ -59,11 +59,9 @@
 #define MTRR_TO_PHYS_WC_OFFSET 1000
 
 u32 num_var_ranges;
-static bool __mtrr_enabled;
-
 static bool mtrr_enabled(void)
 {
-	return __mtrr_enabled;
+	return !!mtrr_if;
 }
 
 unsigned int mtrr_usage_table[MTRR_MAX_VAR_RANGES];
@@ -755,18 +753,17 @@ void __init mtrr_bp_init(void)
 		}
 	}
 
-	if (mtrr_if) {
-		__mtrr_enabled = true;
+	if (mtrr_enabled()) {
 		set_num_var_ranges(mtrr_if == &generic_mtrr_ops);
 		init_table();
 		if (mtrr_if == &generic_mtrr_ops) {
 			/* BIOS may override */
-			__mtrr_enabled = get_mtrr_state();
-
-			if (mtrr_enabled()) {
+			if (get_mtrr_state()) {
 				memory_caching_control |= CACHE_MTRR | CACHE_PAT;
 				changed_by_mtrr_cleanup = mtrr_cleanup(phys_addr);
 				cache_cpu_init();
+			} else {
+				mtrr_if = NULL;
 			}
 		}
 	}
