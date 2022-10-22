Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 798FC608CF6
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Oct 2022 13:49:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229765AbiJVLtV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 22 Oct 2022 07:49:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229914AbiJVLsv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Oct 2022 07:48:51 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA2B424FEC2
        for <linux-kernel@vger.kernel.org>; Sat, 22 Oct 2022 04:48:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-ID:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To;
        bh=rlvYdOzEA1PYmv3xpXNUozerfLc4suXD0vdv08sNG6k=; b=gfnL7eWmkMJzCbyJLYVMNiLqdN
        Yy/XAKxgWJ1eol3mJOSAcMtqvfGvqoxIJjpKemQp81MaKf1+ntLPHeb8Tem7q/EMim9uN0vxFMDUB
        eXbMhDOcxXURog4p2Dz9JSV7iQMaS+NvXu2N+TIdLF2D1tj3LS6LRHUMXcL2NpUST9QLYcdvQ+L6m
        0tSzURodRdHPX/bvpcDRKMHpJhdmSmNMA8PjoBlbBQTsxsSBpfIXNc3inYvAKWS+p0g8i/fZ3WPsc
        CtjByrke9HLUT+6Qs8yFq1wAEjWRrJtLKO2twxmWKmHgpKCQcsNt+RZg5B7IuCgeZG9FXhnWrtHSL
        GKlrjMlQ==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1omCzR-00Dtgt-IR; Sat, 22 Oct 2022 11:48:33 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id BDB42302D80;
        Sat, 22 Oct 2022 13:48:26 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id 37BBE28B8E515; Sat, 22 Oct 2022 13:48:26 +0200 (CEST)
Message-ID: <20221022114424.971450128@infradead.org>
User-Agent: quilt/0.66
Date:   Sat, 22 Oct 2022 13:14:11 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     x86@kernel.org, willy@infradead.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org
Cc:     linux-kernel@vger.kernel.org, peterz@infradead.org,
        linux-mm@kvack.org, aarcange@redhat.com,
        kirill.shutemov@linux.intel.com, jroedel@suse.de, ubizjak@gmail.com
Subject: [PATCH 08/13] x86/mm/pae: Dont (ab)use atomic64
References: <20221022111403.531902164@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PAE implies CX8, write readable code.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 arch/x86/include/asm/pgtable-3level.h |    9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

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
@@ -95,11 +93,12 @@ static inline void pud_clear(pud_t *pudp
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


