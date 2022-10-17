Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4EEF7601075
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Oct 2022 15:48:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230031AbiJQNrq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Oct 2022 09:47:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229968AbiJQNrg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Oct 2022 09:47:36 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4434852FD9;
        Mon, 17 Oct 2022 06:47:34 -0700 (PDT)
Date:   Mon, 17 Oct 2022 13:47:31 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1666014452;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=N3GpTfY3y5qdlAiQiJDXMLWXE9wY2GvyezsXxcK3s5I=;
        b=wMmHLSJetIHsJ8irzObZ3AgopznAlw8RAl/kmGgfAaLQVi8gWDiYtxDUT1ab0YoXgTNqSb
        cUZ1lGjcYGMc4i1sEFZZLhD6cEMe++P0wk8DZk7DAbKC5kOujybscK3yMHsmmNo7trc5Su
        WwbdMhv9zx6ii4FA8yAm7PEzEFgOhwtrxig7Dk1yUKjNjKOhsmIbfz6YhXaIKm6bxI19rn
        /ui63Booxm3I0aiq45eEOqMr0Xzcwo6JXRSL62fLAHOqt+6ytx1TSq3ziWkcHqw+S2YoFe
        xZ91Eo1O+cOy58Dm6CLNfYrDb2aoT9WwkvGWQSCfqdkBS8DtZ/0dcyI2UkTAgA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1666014452;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=N3GpTfY3y5qdlAiQiJDXMLWXE9wY2GvyezsXxcK3s5I=;
        b=ScmnGY8OVfjvKVhOlrpxTCfnLRU6HF8vrFQpvKmQYT0e8Rs7YpyeBC/tEpChttj13TYde3
        lMCD2CPSWaTjBxCw==
From:   "tip-bot2 for Chang S. Bae" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/urgent] x86/fpu: Fix the init_fpstate size check with the
 actual size
Cc:     "Chang S. Bae" <chang.seok.bae@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20220824191223.1248-3-chang.seok.bae@intel.com>
References: <20220824191223.1248-3-chang.seok.bae@intel.com>
MIME-Version: 1.0
Message-ID: <166601445140.401.5905202379513336433.tip-bot2@tip-bot2>
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

Commit-ID:     d3e021adac7c51a26d9ede167c789fcc1b878467
Gitweb:        https://git.kernel.org/tip/d3e021adac7c51a26d9ede167c789fcc1b878467
Author:        Chang S. Bae <chang.seok.bae@intel.com>
AuthorDate:    Wed, 24 Aug 2022 12:12:22 -07:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Mon, 17 Oct 2022 15:44:25 +02:00

x86/fpu: Fix the init_fpstate size check with the actual size

The init_fpstate buffer is statically allocated. Thus, the sanity test was
established to check whether the pre-allocated buffer is enough for the
calculated size or not.

The currently measured size is not strictly relevant. Fix to validate the
calculated init_fpstate size with the pre-allocated area.

Also, replace the sanity check function with open code for clarity. The
abstraction itself and the function naming do not tend to represent simply
what it does.

Fixes: 2ae996e0c1a3 ("x86/fpu: Calculate the default sizes independently")
Signed-off-by: Chang S. Bae <chang.seok.bae@intel.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/r/20220824191223.1248-3-chang.seok.bae@intel.com

---
 arch/x86/kernel/fpu/xstate.c | 24 ++++++------------------
 1 file changed, 6 insertions(+), 18 deletions(-)

diff --git a/arch/x86/kernel/fpu/xstate.c b/arch/x86/kernel/fpu/xstate.c
index f0ce106..f5ef786 100644
--- a/arch/x86/kernel/fpu/xstate.c
+++ b/arch/x86/kernel/fpu/xstate.c
@@ -678,20 +678,6 @@ static unsigned int __init get_xsave_size_user(void)
 	return ebx;
 }
 
-/*
- * Will the runtime-enumerated 'xstate_size' fit in the init
- * task's statically-allocated buffer?
- */
-static bool __init is_supported_xstate_size(unsigned int test_xstate_size)
-{
-	if (test_xstate_size <= sizeof(init_fpstate.regs))
-		return true;
-
-	pr_warn("x86/fpu: xstate buffer too small (%zu < %d), disabling xsave\n",
-			sizeof(init_fpstate.regs), test_xstate_size);
-	return false;
-}
-
 static int __init init_xstate_size(void)
 {
 	/* Recompute the context size for enabled features: */
@@ -717,10 +703,6 @@ static int __init init_xstate_size(void)
 	kernel_default_size =
 		xstate_calculate_size(fpu_kernel_cfg.default_features, compacted);
 
-	/* Ensure we have the space to store all default enabled features. */
-	if (!is_supported_xstate_size(kernel_default_size))
-		return -EINVAL;
-
 	if (!paranoid_xstate_size_valid(kernel_size))
 		return -EINVAL;
 
@@ -879,6 +861,12 @@ void __init fpu__init_system_xstate(unsigned int legacy_size)
 	init_fpstate.size		= fpu_kernel_cfg.max_size;
 	init_fpstate.xfeatures		= fpu_kernel_cfg.max_features;
 
+	if (init_fpstate.size > sizeof(init_fpstate.regs)) {
+		pr_warn("x86/fpu: init_fpstate buffer too small (%zu < %d), disabling XSAVE\n",
+			sizeof(init_fpstate.regs), init_fpstate.size);
+		goto out_disable;
+	}
+
 	setup_init_fpu_buf();
 
 	/*
