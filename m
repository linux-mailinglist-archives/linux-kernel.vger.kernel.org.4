Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 90ED2666FE2
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Jan 2023 11:40:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235699AbjALKkm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Jan 2023 05:40:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236584AbjALKji (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jan 2023 05:39:38 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FA2762F6;
        Thu, 12 Jan 2023 02:34:15 -0800 (PST)
Date:   Thu, 12 Jan 2023 10:34:12 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1673519653;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=HToTxnz9S15tHok02madK+uiew5TU6onPq4bHfE8d2A=;
        b=nOz4T+TL7Vd238tovZ3AnAwX3NTL85Fw0mGTGmkM5fJphH02+/OFrTKsy6xg2IOlhhJR7M
        PUze760DEZDJP6sXF5kTOVmJGrHk20eBFfht717jaID0i5WuA7mtMvxCLugIm82p8tL95s
        eqP8cXajaDi63oaw3rUNKCh3Ssmo3BEzCJdu4HMsQZgg1CICZDtzd6EOXMOGUdn6X9WJ1z
        rqaksxh0BViQ59apgAKtASHyYCw0SCMVNJ5Acm9sQbtIJAOqD2NsdCoFg0nlhzyG5y/0yv
        khFWnQFQk4K06LPXqTOJFHSUZdf641kxu2TogXtthWEDWiEkQEklOeJd5NlCjQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1673519653;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=HToTxnz9S15tHok02madK+uiew5TU6onPq4bHfE8d2A=;
        b=YH9JswKSge9L15v7FPBggySzJukch0Ufe4ArJZs/ZIsaJiLgjdHvBSptT8MGoMGXVFq4G9
        AG/TBr2pS2Y6K9Bw==
From:   "tip-bot2 for Juergen Gross" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/urgent] x86/mm: fix poking_init() for Xen PV guests
Cc:     Juergen Gross <jgross@suse.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20230109150922.10578-1-jgross@suse.com>
References: <20230109150922.10578-1-jgross@suse.com>
MIME-Version: 1.0
Message-ID: <167351965292.4906.12237792371879613660.tip-bot2@tip-bot2>
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

Commit-ID:     26ce6ec364f18d2915923bc05784084e54a5c4cc
Gitweb:        https://git.kernel.org/tip/26ce6ec364f18d2915923bc05784084e54a5c4cc
Author:        Juergen Gross <jgross@suse.com>
AuthorDate:    Mon, 09 Jan 2023 16:09:22 +01:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Thu, 12 Jan 2023 11:22:20 +01:00

x86/mm: fix poking_init() for Xen PV guests

Commit 3f4c8211d982 ("x86/mm: Use mm_alloc() in poking_init()") broke
the kernel for running as Xen PV guest.

It seems as if the new address space is never activated before being
used, resulting in Xen rejecting to accept the new CR3 value (the PGD
isn't pinned).

Fix that by adding the now missing call of paravirt_arch_dup_mmap() to
poking_init(). That call was previously done by dup_mm()->dup_mmap() and
it is a NOP for all cases but for Xen PV, where it is just doing the
pinning of the PGD.

Fixes: 3f4c8211d982 ("x86/mm: Use mm_alloc() in poking_init()")
Signed-off-by: Juergen Gross <jgross@suse.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lkml.kernel.org/r/20230109150922.10578-1-jgross@suse.com
---
 arch/x86/mm/init.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/x86/mm/init.c b/arch/x86/mm/init.c
index d398735..cb258f5 100644
--- a/arch/x86/mm/init.c
+++ b/arch/x86/mm/init.c
@@ -26,6 +26,7 @@
 #include <asm/pti.h>
 #include <asm/text-patching.h>
 #include <asm/memtype.h>
+#include <asm/paravirt.h>
 
 /*
  * We need to define the tracepoints somewhere, and tlb.c
@@ -804,6 +805,9 @@ void __init poking_init(void)
 	poking_mm = mm_alloc();
 	BUG_ON(!poking_mm);
 
+	/* Xen PV guests need the PGD to be pinned. */
+	paravirt_arch_dup_mmap(NULL, poking_mm);
+
 	/*
 	 * Randomize the poking address, but make sure that the following page
 	 * will be mapped at the same PMD. We need 2 pages, so find space for 3,
