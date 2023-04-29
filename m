Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 00D3B6F2389
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Apr 2023 09:18:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230414AbjD2HSN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 29 Apr 2023 03:18:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229501AbjD2HSJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Apr 2023 03:18:09 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE4E01986;
        Sat, 29 Apr 2023 00:18:08 -0700 (PDT)
Date:   Sat, 29 Apr 2023 07:18:07 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1682752687;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=DOzuSnTmxSim7dIvzyWlqGRd9comMl0rFJQ+W3TYF6c=;
        b=nA5wJmZe7BA+656vc7kwgAW3Lr83gzuK9BnN64sxJNUYUGruri5guG54il6r/nuL6vjw7I
        KsKXU7nhgLqfFj7Q5VgS/7pZqJFLHwbs48w8xI0PZ34xzZcechMSZrP/MUh+annWWc/iFo
        ak6YB6JANenVN6ndnRMUIItcjBWBaxc9qpUaz8kjbiSiCbI/OUgffuny4jRts56l1fm47b
        sutJwyj2UdJ0sLMHUuTy4NEbiZ81jbhi3lRIOxG8TLm691FA9sAR5ORubX+sWgmCecDCaQ
        Q90YhrSFvdYy7E3i+jCjWbgBbiqrhrywLZ1ubgxkMACGSpsIbKRpQd4QXxZB/w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1682752687;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=DOzuSnTmxSim7dIvzyWlqGRd9comMl0rFJQ+W3TYF6c=;
        b=sE3lkBWWYmhnqEukVTnfLQ7ChsT5xCdomOdpGbUQft62fOIdnz9AGhJ4Qj1ZRWSuErDRZP
        YzLUzgf+HUAbLIAQ==
From:   "tip-bot2 for Uros Bizjak" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: locking/core] locking/x86: Define arch_try_cmpxchg_local()
Cc:     Uros Bizjak <ubizjak@gmail.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20230405141710.3551-5-ubizjak@gmail.com>
References: <20230405141710.3551-5-ubizjak@gmail.com>
MIME-Version: 1.0
Message-ID: <168275268710.404.16959421973467678972.tip-bot2@tip-bot2>
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

The following commit has been merged into the locking/core branch of tip:

Commit-ID:     5cd4c268412f802e71b7722c3ec4638b0fe04acd
Gitweb:        https://git.kernel.org/tip/5cd4c268412f802e71b7722c3ec4638b0fe04acd
Author:        Uros Bizjak <ubizjak@gmail.com>
AuthorDate:    Wed, 05 Apr 2023 16:17:09 +02:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Sat, 29 Apr 2023 09:09:23 +02:00

locking/x86: Define arch_try_cmpxchg_local()

Define target specific arch_try_cmpxchg_local(). This
definition overrides the generic arch_try_cmpxchg_local()
fallback definition and enables target-specific
implementation of try_cmpxchg_local().

Signed-off-by: Uros Bizjak <ubizjak@gmail.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Link: https://lore.kernel.org/r/20230405141710.3551-5-ubizjak@gmail.com
Cc: Linus Torvalds <torvalds@linux-foundation.org>
---
 arch/x86/include/asm/cmpxchg.h | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/x86/include/asm/cmpxchg.h b/arch/x86/include/asm/cmpxchg.h
index 94fbe6a..540573f 100644
--- a/arch/x86/include/asm/cmpxchg.h
+++ b/arch/x86/include/asm/cmpxchg.h
@@ -221,9 +221,15 @@ extern void __add_wrong_size(void)
 #define __try_cmpxchg(ptr, pold, new, size)				\
 	__raw_try_cmpxchg((ptr), (pold), (new), (size), LOCK_PREFIX)
 
+#define __try_cmpxchg_local(ptr, pold, new, size)			\
+	__raw_try_cmpxchg((ptr), (pold), (new), (size), "")
+
 #define arch_try_cmpxchg(ptr, pold, new) 				\
 	__try_cmpxchg((ptr), (pold), (new), sizeof(*(ptr)))
 
+#define arch_try_cmpxchg_local(ptr, pold, new)				\
+	__try_cmpxchg_local((ptr), (pold), (new), sizeof(*(ptr)))
+
 /*
  * xadd() adds "inc" to "*ptr" and atomically returns the previous
  * value of "*ptr".
