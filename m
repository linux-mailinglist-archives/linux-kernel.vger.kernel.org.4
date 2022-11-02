Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 671FD615F2D
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Nov 2022 10:13:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231434AbiKBJNZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Nov 2022 05:13:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231292AbiKBJMi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Nov 2022 05:12:38 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49E5027FDD;
        Wed,  2 Nov 2022 02:12:36 -0700 (PDT)
Date:   Wed, 02 Nov 2022 09:12:31 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1667380354;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=uMR68Zmfoe0UqY0wLe0yKioBQ7nzb4jjELk2y2smSJc=;
        b=oWA10aC7L21CM687n9M00pX9BU5J27hHyj5odgNTQmHXQLYDHPDrp7nybWf8N7kXKSpvwM
        nwpCYM8fOnVkMIT/n1ZRXFcW2X4DlkWBv22tFf7MICosQQni+cJ9IQAcIQq5sCwzucmz47
        YlG0Id1XyM5PbOfZqkXtDsFv8Xpe9rPnalqlpAiUsizifREHLyemf9aq9N0766qaJ0XauE
        m8UQTaYwKFJ0dzq/2p8CJv+B5yKSRIvlpFwoAwMyAK8NYpGgm1QjlyY+fc7tY9aNP71lap
        er+q/RWffrLow8qvl8qbZq/kvyr0rIdbCIJ3rokCireiyImBaiAtYTlDJ5ADNQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1667380354;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=uMR68Zmfoe0UqY0wLe0yKioBQ7nzb4jjELk2y2smSJc=;
        b=G7sggtNUHAg+JecF4dfLb2k7B7mFg954jTYuxTs41s0AQm8Kf0O2yyJdOAp+tNeIZedpnq
        +h/7Pslit5BpLeDw==
From:   "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/mm] mm: Convert __HAVE_ARCH_P..P_GET to the new style
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <Y2EUEBlQXNgaJgoI@hirez.programming.kicks-ass.net>
References: <Y2EUEBlQXNgaJgoI@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Message-ID: <166738035184.7716.3554709284674678643.tip-bot2@tip-bot2>
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

The following commit has been merged into the x86/mm branch of tip:

Commit-ID:     0daf48b9e44674fb5ffc33cd41a3a17326e26cca
Gitweb:        https://git.kernel.org/tip/0daf48b9e44674fb5ffc33cd41a3a17326e26cca
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Tue, 01 Nov 2022 12:53:18 +01:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Tue, 01 Nov 2022 13:44:05 +01:00

mm: Convert __HAVE_ARCH_P..P_GET to the new style

Since __HAVE_ARCH_* style guards have been depricated in favour of
defining the function name onto itself, convert pxxp_get().

Suggested-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lkml.kernel.org/r/Y2EUEBlQXNgaJgoI@hirez.programming.kicks-ass.net
---
 arch/powerpc/include/asm/nohash/32/pgtable.h | 2 +-
 include/linux/pgtable.h                      | 4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/powerpc/include/asm/nohash/32/pgtable.h b/arch/powerpc/include/asm/nohash/32/pgtable.h
index 0d40b33..cb1ac02 100644
--- a/arch/powerpc/include/asm/nohash/32/pgtable.h
+++ b/arch/powerpc/include/asm/nohash/32/pgtable.h
@@ -263,7 +263,7 @@ static inline pte_basic_t pte_update(struct mm_struct *mm, unsigned long addr, p
 }
 
 #ifdef CONFIG_PPC_16K_PAGES
-#define __HAVE_ARCH_PTEP_GET
+#define ptep_get ptep_get
 static inline pte_t ptep_get(pte_t *ptep)
 {
 	pte_basic_t val = READ_ONCE(ptep->pte);
diff --git a/include/linux/pgtable.h b/include/linux/pgtable.h
index 2334852..70e2a7e 100644
--- a/include/linux/pgtable.h
+++ b/include/linux/pgtable.h
@@ -291,14 +291,14 @@ static inline void ptep_clear(struct mm_struct *mm, unsigned long addr,
 	ptep_get_and_clear(mm, addr, ptep);
 }
 
-#ifndef __HAVE_ARCH_PTEP_GET
+#ifndef ptep_get
 static inline pte_t ptep_get(pte_t *ptep)
 {
 	return READ_ONCE(*ptep);
 }
 #endif
 
-#ifndef __HAVE_ARCH_PMDP_GET
+#ifndef pmdp_get
 static inline pmd_t pmdp_get(pmd_t *pmdp)
 {
 	return READ_ONCE(*pmdp);
