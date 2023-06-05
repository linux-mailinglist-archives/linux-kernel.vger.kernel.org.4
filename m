Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B8F3A72285D
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Jun 2023 16:09:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234486AbjFEOJL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Jun 2023 10:09:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233906AbjFEOIe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Jun 2023 10:08:34 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55F50115;
        Mon,  5 Jun 2023 07:08:18 -0700 (PDT)
Date:   Mon, 05 Jun 2023 14:08:15 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1685974095;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=YwL6GodePffgzteSztSoNrAzEEzWjnEMobKmSpbgnQQ=;
        b=uK6l0WMsdT7fj+9rUg/aUp0Iq67pniMOOwTOApfQNVo0tfrH5AYE9f3SN3CQzeIK4pyGb6
        Qd9P0hlt0EAVqa+HmQUAPKfhcnR8lgmsXvsRM9xFWX01198VoD95vT1Zu0DPG4p+1K3QbT
        Z8XI5IncSH8KCpwTrQF0QFQr+o7Cox1ZTZhjeDk13jiCT8x+rzOzRFSW+8m6j2SgQuKXcO
        8KcKZRlZWliYeU9BcnnF2FojHiE82Wesci5/B9jA0YFvjBsrwlkk+nfQIryWMDLW0EAOVB
        FSmo1bv5bKInObRqpX4ijXGzmCvT2iMlO8fnPAPj6L/lK0QiZhP5w3CeRRrpKg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1685974095;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=YwL6GodePffgzteSztSoNrAzEEzWjnEMobKmSpbgnQQ=;
        b=5eAgTBwoZlrTmE1Xv+jLB4gvVGMJ3u9wsHZEtYW2NPfNde6CFe8feZyIz5IeaKFxGRWTlu
        E9pGNyrLyaBq0hBg==
From:   "tip-bot2 for Juergen Gross" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/mtrr] x86/mtrr: Allocate mtrr_value array dynamically
Cc:     Juergen Gross <jgross@suse.com>,
        "Borislav Petkov (AMD)" <bp@alien8.de>,
        Michael Kelley <mikelley@microsoft.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20230502120931.20719-10-jgross@suse.com>
References: <20230502120931.20719-10-jgross@suse.com>
MIME-Version: 1.0
Message-ID: <168597409531.404.16021958975934147782.tip-bot2@tip-bot2>
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

Commit-ID:     961c6a4326643e6588352b7f1f5d77364415386f
Gitweb:        https://git.kernel.org/tip/961c6a4326643e6588352b7f1f5d77364415386f
Author:        Juergen Gross <jgross@suse.com>
AuthorDate:    Tue, 02 May 2023 14:09:24 +02:00
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Thu, 01 Jun 2023 15:04:33 +02:00

x86/mtrr: Allocate mtrr_value array dynamically

The mtrr_value[] array is a static variable which is used only in a few
configurations. Consuming 6kB is ridiculous for this case, especially as
the array doesn't need to be that large and it can easily be allocated
dynamically.

Signed-off-by: Juergen Gross <jgross@suse.com>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Tested-by: Michael Kelley <mikelley@microsoft.com>
Link: https://lore.kernel.org/r/20230502120931.20719-10-jgross@suse.com
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
---
 arch/x86/kernel/cpu/mtrr/legacy.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/arch/x86/kernel/cpu/mtrr/legacy.c b/arch/x86/kernel/cpu/mtrr/legacy.c
index 7d379fb..d25882f 100644
--- a/arch/x86/kernel/cpu/mtrr/legacy.c
+++ b/arch/x86/kernel/cpu/mtrr/legacy.c
@@ -1,6 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0-only
 
 #include <linux/types.h>
+#include <linux/slab.h>
 #include <linux/syscore_ops.h>
 #include <asm/cpufeature.h>
 #include <asm/mtrr.h>
@@ -38,12 +39,15 @@ struct mtrr_value {
 	unsigned long	lsize;
 };
 
-static struct mtrr_value mtrr_value[MTRR_MAX_VAR_RANGES];
+static struct mtrr_value *mtrr_value;
 
 static int mtrr_save(void)
 {
 	int i;
 
+	if (!mtrr_value)
+		return -ENOMEM;
+
 	for (i = 0; i < num_var_ranges; i++) {
 		mtrr_if->get(i, &mtrr_value[i].lbase,
 				&mtrr_value[i].lsize,
@@ -72,6 +76,8 @@ static struct syscore_ops mtrr_syscore_ops = {
 
 void mtrr_register_syscore(void)
 {
+	mtrr_value = kcalloc(num_var_ranges, sizeof(*mtrr_value), GFP_KERNEL);
+
 	/*
 	 * The CPU has no MTRR and seems to not support SMP. They have
 	 * specific drivers, we use a tricky method to support
