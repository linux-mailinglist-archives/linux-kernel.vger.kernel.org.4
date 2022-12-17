Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E0D9D64FBE0
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Dec 2022 19:56:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229937AbiLQS4t (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 17 Dec 2022 13:56:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230039AbiLQSzi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Dec 2022 13:55:38 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 388842D5;
        Sat, 17 Dec 2022 10:55:37 -0800 (PST)
Date:   Sat, 17 Dec 2022 18:55:32 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1671303333;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=nnhG1yoylZQ4yHA8V2Wi+1iakrx4cPgvIkGwcKrqkG8=;
        b=zEOiwGcZsApXtm8iXT2w9pC6EGvpDuVv4j3vys2Wq5+yXOSlp0Mbz0IvJD2culVKDs45MW
        V4IxDx9vuzjnibp0kjPFjkpiYpquFCZvLtlSq25K0Y1RTQLfCL8WNoL/4NEtKPy+0RPYTd
        HrWgvni6i1osNxJlgI53S3CHa7iZ9rhExtOFavtSibNL2B32emwdWHpx9jXDJP6KB+7gq5
        OFllO/rPcZkuE/srYJhgFtf/K13lU96eIUQ0dZ/UMa+xxXNViTMB7TQ6R7UqVyN1DMR9uS
        hsx0OiRzfzhCrnL1bsE64wWfVIGE0SJN1fGOW7PGPAIQdjbE1h+bjOR29D/DsQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1671303333;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=nnhG1yoylZQ4yHA8V2Wi+1iakrx4cPgvIkGwcKrqkG8=;
        b=AqDe/RXRtimJNan3OEXfrKfJ11GiHP3Ox0QoFcAccVSrAtLonPsi8/nGo/UvSNmSH0MNNP
        AxPHXwAxelhUN0CQ==
From:   "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/mm] x86/mm/pae: Don't (ab)use atomic64
Cc:     "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
MIME-Version: 1.0
Message-ID: <167130333280.4906.12675723278515944040.tip-bot2@tip-bot2>
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

Commit-ID:     7a9b8bdb6af3e19fb8e3dc7a3caf6a9ea1bed8cd
Gitweb:        https://git.kernel.org/tip/7a9b8bdb6af3e19fb8e3dc7a3caf6a9ea1bed8cd
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Thu, 26 Nov 2020 17:38:42 +01:00
Committer:     Dave Hansen <dave.hansen@linux.intel.com>
CommitterDate: Thu, 15 Dec 2022 10:37:27 -08:00

x86/mm/pae: Don't (ab)use atomic64

PAE implies CX8, write readable code.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lkml.kernel.org/r/20221022114424.971450128%40infradead.org
---
 arch/x86/include/asm/pgtable-3level.h |  9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/arch/x86/include/asm/pgtable-3level.h b/arch/x86/include/asm/pgtable-3level.h
index 94f50b0..0a1b81d 100644
--- a/arch/x86/include/asm/pgtable-3level.h
+++ b/arch/x86/include/asm/pgtable-3level.h
@@ -2,8 +2,6 @@
 #ifndef _ASM_X86_PGTABLE_3LEVEL_H
 #define _ASM_X86_PGTABLE_3LEVEL_H
 
-#include <asm/atomic64_32.h>
-
 /*
  * Intel Physical Address Extension (PAE) Mode - three-level page
  * tables on PPro+ CPUs.
@@ -95,11 +93,12 @@ static inline void pud_clear(pud_t *pudp)
 #ifdef CONFIG_SMP
 static inline pte_t native_ptep_get_and_clear(pte_t *ptep)
 {
-	pte_t res;
+	pte_t old = *ptep;
 
-	res.pte = (pteval_t)arch_atomic64_xchg((atomic64_t *)ptep, 0);
+	do {
+	} while (!try_cmpxchg64(&ptep->pte, &old.pte, 0ULL));
 
-	return res;
+	return old;
 }
 #else
 #define native_ptep_get_and_clear(xp) native_local_ptep_get_and_clear(xp)
