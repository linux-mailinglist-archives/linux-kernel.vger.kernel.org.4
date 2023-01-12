Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 76B326671EB
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Jan 2023 13:17:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231337AbjALMRP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Jan 2023 07:17:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235030AbjALMQh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jan 2023 07:16:37 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A4E25FB9;
        Thu, 12 Jan 2023 04:16:35 -0800 (PST)
Date:   Thu, 12 Jan 2023 12:16:32 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1673525793;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=LykX6xGIl2wRYi0o9Z9WARdITFqFb2/ddeZCLUa0EhQ=;
        b=k6bbeQIhgzdUSmphnnfRpN70RCzslNPnsr/6vQ3CeVQZ6tW3WF9JaEKTSfjXt9nqnbOXUg
        S5STKqmRMM7uR5zDE83137jDxGCuO91aGiaLoja3q7yP70Vhnj5Yn/N/EKiHM5Cvl8zjw/
        IANyYZu18pvOykMLDRZ48lMhhrDfnHaJzLqcbwOsWav+GfiTF4QXMRcendX15E5dbUNZuy
        umaaahURmKcVsxAU0mkdSM9gX8j4wwTcP4dYwMb/RGJKmsUE9OxKmMwWBRjrNSjvLcUQBe
        t+TApAzGqJT54mLlqs/N5TAK4agISZN1Fjlhigf1hj6bLeiPjnPeoYm6BJXLJg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1673525793;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=LykX6xGIl2wRYi0o9Z9WARdITFqFb2/ddeZCLUa0EhQ=;
        b=HMeFuqbkRPlSUK2YTdQPDT+x7t0DmI/a/FR0pu70V/26WJ55M9fWyCcFVtBWvVvT906GWB
        RAXqeqfCVllv3CDQ==
From:   "tip-bot2 for H. Peter Anvin (Intel)" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/cpu] x86/gsseg: Make asm_load_gs_index() take an u16
Cc:     "H. Peter Anvin (Intel)" <hpa@zytor.com>,
        Xin Li <xin3.li@intel.com>, Ingo Molnar <mingo@kernel.org>,
        x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20230112072032.35626-4-xin3.li@intel.com>
References: <20230112072032.35626-4-xin3.li@intel.com>
MIME-Version: 1.0
Message-ID: <167352579295.4906.1690898852505380960.tip-bot2@tip-bot2>
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

Commit-ID:     df729fb05ae2db52f7de150439392a88ee9d9b4f
Gitweb:        https://git.kernel.org/tip/df729fb05ae2db52f7de150439392a88ee9d9b4f
Author:        H. Peter Anvin (Intel) <hpa@zytor.com>
AuthorDate:    Wed, 11 Jan 2023 23:20:30 -08:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Thu, 12 Jan 2023 13:06:36 +01:00

x86/gsseg: Make asm_load_gs_index() take an u16

Let GCC know that only the low 16 bits of load_gs_index() argument
actually matter. It might allow it to create slightly better
code. However, do not propagate this into the prototypes of functions
that end up being paravirtualized, to avoid unnecessary changes.

Signed-off-by: H. Peter Anvin (Intel) <hpa@zytor.com>
Signed-off-by: Xin Li <xin3.li@intel.com>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Link: https://lore.kernel.org/r/20230112072032.35626-4-xin3.li@intel.com
---
 arch/x86/entry/entry_64.S            | 2 +-
 arch/x86/include/asm/special_insns.h | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/x86/entry/entry_64.S b/arch/x86/entry/entry_64.S
index 15739a2..7ecd2ae 100644
--- a/arch/x86/entry/entry_64.S
+++ b/arch/x86/entry/entry_64.S
@@ -782,7 +782,7 @@ _ASM_NOKPROBE(common_interrupt_return)
 
 /*
  * Reload gs selector with exception handling
- * edi:  new selector
+ *  di:  new selector
  *
  * Is in entry.text as it shouldn't be instrumented.
  */
diff --git a/arch/x86/include/asm/special_insns.h b/arch/x86/include/asm/special_insns.h
index 35f709f..a71d0e8 100644
--- a/arch/x86/include/asm/special_insns.h
+++ b/arch/x86/include/asm/special_insns.h
@@ -120,7 +120,7 @@ static inline void native_wbinvd(void)
 	asm volatile("wbinvd": : :"memory");
 }
 
-extern asmlinkage void asm_load_gs_index(unsigned int selector);
+extern asmlinkage void asm_load_gs_index(u16 selector);
 
 static inline void native_load_gs_index(unsigned int selector)
 {
