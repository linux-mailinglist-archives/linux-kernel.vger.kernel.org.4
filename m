Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4572F62423A
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Nov 2022 13:22:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230149AbiKJMW1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Nov 2022 07:22:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230516AbiKJMV5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Nov 2022 07:21:57 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 808BA725C3;
        Thu, 10 Nov 2022 04:21:56 -0800 (PST)
Date:   Thu, 10 Nov 2022 12:21:53 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1668082915;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=I/ooRQd7DtbG1LBSqmKVac3D5nhkiEo2hB1nYAv8Qiw=;
        b=3/tVNhIY78PMw3ujzvv7wveHgXC31dbLl1jLfopWyLCx07LUSCkaHQ/Q3808r1qag3Lr4R
        Com3kM5c6cC/q2YhfyQ1vOMXWsZuTgwzXFSkOPBqRksFwuxvxqjgry/6RUfbLW79vNv0Si
        EQnHTThXnJ7Rblh30L/d9h5TvoVDjIDdgp2Uoazo86z9cZXYIUQIvT/q99OxS3IzeZsn4G
        ybvWRmkzIt8ncT3JilzLziQq1NZkd9zuP4Zwabk1E6m9MR6uOJrBzW9d2G9UpgAmZINhMM
        0zdHDJe0BzlpfBKbW3nZVizLG1JGMBkzYD8aWDu5hW0tIogI51n0Gurr6xGTcw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1668082915;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=I/ooRQd7DtbG1LBSqmKVac3D5nhkiEo2hB1nYAv8Qiw=;
        b=KUeOrMzY1o88sjuRzue5H0br2T/CmwsUovt2t5eVKRyYRy2Y4bBsvzUnt1YeBvtRFATjFN
        4SbeRV9RBUs2P6Bw==
From:   "tip-bot2 for Juergen Gross" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/cpu] x86/mtrr: Remove set_all callback from struct mtrr_ops
Cc:     Juergen Gross <jgross@suse.com>, Borislav Petkov <bp@suse.de>,
        x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20221102074713.21493-9-jgross@suse.com>
References: <20221102074713.21493-9-jgross@suse.com>
MIME-Version: 1.0
Message-ID: <166808291380.4906.4322463496092665408.tip-bot2@tip-bot2>
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

Commit-ID:     57df636cd336a1929c7ddc5fb48ed124d24cd7b2
Gitweb:        https://git.kernel.org/tip/57df636cd336a1929c7ddc5fb48ed124d24cd7b2
Author:        Juergen Gross <jgross@suse.com>
AuthorDate:    Wed, 02 Nov 2022 08:47:05 +01:00
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Thu, 10 Nov 2022 13:12:44 +01:00

x86/mtrr: Remove set_all callback from struct mtrr_ops

Instead of using an indirect call to mtrr_if->set_all just call the only
possible target cache_cpu_init() directly. Remove the set_all function
pointer from struct mtrr_ops.

Signed-off-by: Juergen Gross <jgross@suse.com>
Signed-off-by: Borislav Petkov <bp@suse.de>
Link: https://lore.kernel.org/r/20221102074713.21493-9-jgross@suse.com
Signed-off-by: Borislav Petkov <bp@suse.de>
---
 arch/x86/kernel/cpu/mtrr/generic.c |  1 -
 arch/x86/kernel/cpu/mtrr/mtrr.c    | 10 +++++-----
 arch/x86/kernel/cpu/mtrr/mtrr.h    |  2 --
 3 files changed, 5 insertions(+), 8 deletions(-)

diff --git a/arch/x86/kernel/cpu/mtrr/generic.c b/arch/x86/kernel/cpu/mtrr/generic.c
index d409c38..9d4d2bc 100644
--- a/arch/x86/kernel/cpu/mtrr/generic.c
+++ b/arch/x86/kernel/cpu/mtrr/generic.c
@@ -843,7 +843,6 @@ int positive_have_wrcomb(void)
  * Generic structure...
  */
 const struct mtrr_ops generic_mtrr_ops = {
-	.set_all		= cache_cpu_init,
 	.get			= generic_get_mtrr,
 	.get_free_region	= generic_get_free_region,
 	.set			= generic_set_mtrr,
diff --git a/arch/x86/kernel/cpu/mtrr/mtrr.c b/arch/x86/kernel/cpu/mtrr/mtrr.c
index 4209945..a44b510 100644
--- a/arch/x86/kernel/cpu/mtrr/mtrr.c
+++ b/arch/x86/kernel/cpu/mtrr/mtrr.c
@@ -170,15 +170,15 @@ static int mtrr_rendezvous_handler(void *info)
 	 * saved, and we want to replicate that across all the cpus that come
 	 * online (either at the end of boot or resume or during a runtime cpu
 	 * online). If we're doing that, @reg is set to something special and on
-	 * all the cpu's we do mtrr_if->set_all() (On the logical cpu that
+	 * all the CPUs we do cache_cpu_init() (On the logical CPU that
 	 * started the boot/resume sequence, this might be a duplicate
-	 * set_all()).
+	 * cache_cpu_init()).
 	 */
 	if (data->smp_reg != ~0U) {
 		mtrr_if->set(data->smp_reg, data->smp_base,
 			     data->smp_size, data->smp_type);
 	} else if (mtrr_aps_delayed_init || !cpu_online(smp_processor_id())) {
-		mtrr_if->set_all();
+		cache_cpu_init();
 	}
 	return 0;
 }
@@ -770,7 +770,7 @@ void __init mtrr_bp_init(void)
 
 			if (mtrr_cleanup(phys_addr)) {
 				changed_by_mtrr_cleanup = 1;
-				mtrr_if->set_all();
+				cache_cpu_init();
 			}
 		}
 	}
@@ -856,7 +856,7 @@ void mtrr_bp_restore(void)
 	if (!memory_caching_control)
 		return;
 
-	mtrr_if->set_all();
+	cache_cpu_init();
 }
 
 static int __init mtrr_init_finialize(void)
diff --git a/arch/x86/kernel/cpu/mtrr/mtrr.h b/arch/x86/kernel/cpu/mtrr/mtrr.h
index 88b1c4b..3b18831 100644
--- a/arch/x86/kernel/cpu/mtrr/mtrr.h
+++ b/arch/x86/kernel/cpu/mtrr/mtrr.h
@@ -16,8 +16,6 @@ struct mtrr_ops {
 	u32	vendor;
 	void	(*set)(unsigned int reg, unsigned long base,
 		       unsigned long size, mtrr_type type);
-	void	(*set_all)(void);
-
 	void	(*get)(unsigned int reg, unsigned long *base,
 		       unsigned long *size, mtrr_type *type);
 	int	(*get_free_region)(unsigned long base, unsigned long size,
