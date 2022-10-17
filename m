Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 727E9601074
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Oct 2022 15:47:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230012AbiJQNrm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Oct 2022 09:47:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229956AbiJQNrg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Oct 2022 09:47:36 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 433AC58DD7;
        Mon, 17 Oct 2022 06:47:35 -0700 (PDT)
Date:   Mon, 17 Oct 2022 13:47:32 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1666014453;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=RYRgwFQgQpDYP5WecjoI1bYhBCL6RdxmeiLAElFhWwY=;
        b=u7WleTcURbWvLQy7LWzgcd8+NqDyStSfsOUENOo9jiBro87pyyfm9obL092LSBswvrZzUW
        ecpArw43LdKd542EooWeLRfj9aY6QP2d81yUifrtbJ4Spfz2P4AelTV7LNw0iGqyhrT7ie
        JIYVvoAHqiKzWoQLYa4Mi03nD4bn95wrXlfV+v591IKKeBVoaRdYpvPi/08zeXiD3Ms+Dq
        MDe5KOWNcmdgXQWmjJFhwA7FNjO7YqvuJ7p5wtIcCxbu0LtPdS2FoyhK/aTy7AHYMbms2P
        v/dwmxQAiCpPo5bjQZTh86omZAVYHbyvFz/SrLuZK9SNW/XwEKC90pxBZ3fYiA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1666014453;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=RYRgwFQgQpDYP5WecjoI1bYhBCL6RdxmeiLAElFhWwY=;
        b=syq4pA0mfazDEMp5le6CZeJxDOcIP5nKqScoiImN5ec//N+Cxtkyg4cBG7sSdcKRV+t0hO
        XNMvQ7RVODzcIuCg==
From:   "tip-bot2 for Chang S. Bae" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/urgent] x86/fpu: Configure init_fpstate attributes orderly
Cc:     "Chang S. Bae" <chang.seok.bae@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>, neelnatu@google.com,
        x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20220824191223.1248-2-chang.seok.bae@intel.com>
References: <20220824191223.1248-2-chang.seok.bae@intel.com>
MIME-Version: 1.0
Message-ID: <166601445264.401.13144053597878691608.tip-bot2@tip-bot2>
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

The following commit has been merged into the x86/urgent branch of tip:

Commit-ID:     c32d7cab57e3a77af8ecc17cde7a5761a26483b8
Gitweb:        https://git.kernel.org/tip/c32d7cab57e3a77af8ecc17cde7a5761a26483b8
Author:        Chang S. Bae <chang.seok.bae@intel.com>
AuthorDate:    Wed, 24 Aug 2022 12:12:21 -07:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Mon, 17 Oct 2022 15:44:25 +02:00

x86/fpu: Configure init_fpstate attributes orderly

The init_fpstate setup code is spread out and out of order. The init image
is recorded before its scoped features and the buffer size are determined.

Determine the scope of init_fpstate components and its size before
recording the init state. Also move the relevant code together.

Signed-off-by: Chang S. Bae <chang.seok.bae@intel.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Acked-by: neelnatu@google.com
Link: https://lore.kernel.org/r/20220824191223.1248-2-chang.seok.bae@intel.com

---
 arch/x86/kernel/fpu/init.c   | 8 --------
 arch/x86/kernel/fpu/xstate.c | 6 +++++-
 2 files changed, 5 insertions(+), 9 deletions(-)

diff --git a/arch/x86/kernel/fpu/init.c b/arch/x86/kernel/fpu/init.c
index 621f4b6..8946f89 100644
--- a/arch/x86/kernel/fpu/init.c
+++ b/arch/x86/kernel/fpu/init.c
@@ -210,13 +210,6 @@ static void __init fpu__init_system_xstate_size_legacy(void)
 	fpstate_reset(&current->thread.fpu);
 }
 
-static void __init fpu__init_init_fpstate(void)
-{
-	/* Bring init_fpstate size and features up to date */
-	init_fpstate.size		= fpu_kernel_cfg.max_size;
-	init_fpstate.xfeatures		= fpu_kernel_cfg.max_features;
-}
-
 /*
  * Called on the boot CPU once per system bootup, to set up the initial
  * FPU state that is later cloned into all processes:
@@ -236,5 +229,4 @@ void __init fpu__init_system(struct cpuinfo_x86 *c)
 	fpu__init_system_xstate_size_legacy();
 	fpu__init_system_xstate(fpu_kernel_cfg.max_size);
 	fpu__init_task_struct_size();
-	fpu__init_init_fpstate();
 }
diff --git a/arch/x86/kernel/fpu/xstate.c b/arch/x86/kernel/fpu/xstate.c
index c834015..f0ce106 100644
--- a/arch/x86/kernel/fpu/xstate.c
+++ b/arch/x86/kernel/fpu/xstate.c
@@ -360,7 +360,7 @@ static void __init setup_init_fpu_buf(void)
 
 	print_xstate_features();
 
-	xstate_init_xcomp_bv(&init_fpstate.regs.xsave, fpu_kernel_cfg.max_features);
+	xstate_init_xcomp_bv(&init_fpstate.regs.xsave, init_fpstate.xfeatures);
 
 	/*
 	 * Init all the features state with header.xfeatures being 0x0
@@ -875,6 +875,10 @@ void __init fpu__init_system_xstate(unsigned int legacy_size)
 	update_regset_xstate_info(fpu_user_cfg.max_size,
 				  fpu_user_cfg.max_features);
 
+	/* Bring init_fpstate size and features up to date */
+	init_fpstate.size		= fpu_kernel_cfg.max_size;
+	init_fpstate.xfeatures		= fpu_kernel_cfg.max_features;
+
 	setup_init_fpu_buf();
 
 	/*
