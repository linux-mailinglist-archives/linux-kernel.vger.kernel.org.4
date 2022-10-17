Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CBBEA60122C
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Oct 2022 16:59:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231579AbiJQO70 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Oct 2022 10:59:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230329AbiJQO6I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Oct 2022 10:58:08 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FA786AA21;
        Mon, 17 Oct 2022 07:55:06 -0700 (PDT)
Date:   Mon, 17 Oct 2022 14:54:28 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1666018470;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=lDH4lNeSn29fzW6aKL9NU3cvnqKlx9WGVr28ecp1CVM=;
        b=3exDKmZAKyEaAecJ4NprepM5WdnvWxg/rSEiQdMBq+cUWKKR7kxMdiVgX4XJT8yz9GHnvW
        FfcPcIJ2bQQjJ8NWKxbZGxPo9nOjWooAm/ui4T3kGzT05oiJI6bmyxxSGfFLUs8i15Kz4m
        D9u4RIJtckACkNpbe/E7PdjLljrLsv5105AEiIgsljK2NnZykKOj8HjTBO0EkzgmWiDu2P
        18/hNDr1n/BCpSXWmA9kv99rx6dZawNV3CH/lmVwUowycVlzJ4neelx5PJQEM7QmBt+Nch
        oWOTlsIni3kJRKyCdIrD9w/WpqqN6ohs8OiU14Kquljl9cA0dbuThSwPSA+8CA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1666018470;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=lDH4lNeSn29fzW6aKL9NU3cvnqKlx9WGVr28ecp1CVM=;
        b=OdbA8SzTYy07dZMw09UxLrYKjL+Gnvb+b5HsWvQVmHHR80sbjxfVYnkJ3cOnng63oOgWJB
        x6+d345z6/0Y6cAg==
From:   "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/core] x86/cpu: Re-enable stackprotector
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20220915111143.303010511@infradead.org>
References: <20220915111143.303010511@infradead.org>
MIME-Version: 1.0
Message-ID: <166601846890.401.14873709384624392317.tip-bot2@tip-bot2>
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

The following commit has been merged into the x86/core branch of tip:

Commit-ID:     2cb15faaedeb67f52f2ddc32b5ca152acfc422c2
Gitweb:        https://git.kernel.org/tip/2cb15faaedeb67f52f2ddc32b5ca152acfc422c2
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Thu, 15 Sep 2022 13:10:43 +02:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Mon, 17 Oct 2022 16:40:56 +02:00

x86/cpu: Re-enable stackprotector

Commit 5416c2663517 ("x86: make sure load_percpu_segment has no
stackprotector") disabled the stackprotector for cpu/common.c because of
load_percpu_segment(). Back then the boot stack canary was initialized very
early in start_kernel(). Switching the per CPU area by loading the GDT
caused the stackprotector to fail with paravirt enabled kernels as the
GSBASE was not updated yet. In hindsight a wrong change because it would
have been sufficient to ensure that the canary is the same in both per CPU
areas.

Commit d55535232c3d ("random: move rand_initialize() earlier") moved the
stack canary initialization to a later point in the init sequence. As a
consequence the per CPU stack canary is 0 when switching the per CPU areas,
so there is no requirement anymore to exclude this file.

Add a comment to load_percpu_segment().

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lore.kernel.org/r/20220915111143.303010511@infradead.org
---
 arch/x86/kernel/cpu/Makefile | 3 ---
 arch/x86/kernel/cpu/common.c | 3 +++
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/x86/kernel/cpu/Makefile b/arch/x86/kernel/cpu/Makefile
index f10a921..d7e3cea 100644
--- a/arch/x86/kernel/cpu/Makefile
+++ b/arch/x86/kernel/cpu/Makefile
@@ -17,9 +17,6 @@ KMSAN_SANITIZE_common.o := n
 # As above, instrumenting secondary CPU boot code causes boot hangs.
 KCSAN_SANITIZE_common.o := n
 
-# Make sure load_percpu_segment has no stackprotector
-CFLAGS_common.o		:= -fno-stack-protector
-
 obj-y			:= cacheinfo.o scattered.o topology.o
 obj-y			+= common.o
 obj-y			+= rdrand.o
diff --git a/arch/x86/kernel/cpu/common.c b/arch/x86/kernel/cpu/common.c
index f51928d..8e87318 100644
--- a/arch/x86/kernel/cpu/common.c
+++ b/arch/x86/kernel/cpu/common.c
@@ -752,6 +752,9 @@ void __init switch_gdt_and_percpu_base(int cpu)
 	 * early mapping is still valid. That means the GSBASE update will
 	 * lose any prior per CPU data which was not copied over in
 	 * setup_per_cpu_areas().
+	 *
+	 * This works even with stackprotector enabled because the
+	 * per CPU stack canary is 0 in both per CPU areas.
 	 */
 	wrmsrl(MSR_GS_BASE, cpu_kernelmode_gs_base(cpu));
 #else
