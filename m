Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E2B7608CF5
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Oct 2022 13:49:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230168AbiJVLtd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 22 Oct 2022 07:49:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229945AbiJVLs4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Oct 2022 07:48:56 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9C9E251D4F
        for <linux-kernel@vger.kernel.org>; Sat, 22 Oct 2022 04:48:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-ID:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To;
        bh=21hb22ZOLPug1Y7rU1MItuB/yDHg1vIxzPuc1LZH5hI=; b=PdKGQbC12QBugaGBHXI+1OdOwW
        jIeT7sZU8f/cCzbk9SkQJaFP1b540Ku1IBJuuSIHSLzg9x2w8Wmc8o276uAHPOpXzXLG3d6TZq0tF
        ufch0SOHGlt6rJ9GjVJv7If3PI2CCLHZEcs/plOsipgGDnY0U9T2MARB4MNF2md4sW8rQWFDyYM2z
        ftKN36vAn858VDWdBe2+QF71E9pc0xQfcgKilAvXMfbC3SKqEsFNp+XKGyHGw+FG2kU27DviLQ2k2
        Zgve+Gbb5vgj55/AffmFiNzVSPKfRJE8lA9PCBRfZ7JGWZYdwkJx6h4LWZv/Y1jswpVYaPfpTSW4b
        7CjP2Teg==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1omCzM-005XdH-1s; Sat, 22 Oct 2022 11:48:28 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id BDB8D302D91;
        Sat, 22 Oct 2022 13:48:26 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id 3B49F28B8E516; Sat, 22 Oct 2022 13:48:26 +0200 (CEST)
Message-ID: <20221022114425.038102604@infradead.org>
User-Agent: quilt/0.66
Date:   Sat, 22 Oct 2022 13:14:12 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     x86@kernel.org, willy@infradead.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org
Cc:     linux-kernel@vger.kernel.org, peterz@infradead.org,
        linux-mm@kvack.org, aarcange@redhat.com,
        kirill.shutemov@linux.intel.com, jroedel@suse.de, ubizjak@gmail.com
Subject: [PATCH 09/13] x86/mm/pae: Use WRITE_ONCE()
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

Disallow write-tearing, that would be really unfortunate.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 arch/x86/include/asm/pgtable-3level.h |   12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

--- a/arch/x86/include/asm/pgtable-3level.h
+++ b/arch/x86/include/asm/pgtable-3level.h
@@ -27,9 +27,9 @@
  */
 static inline void native_set_pte(pte_t *ptep, pte_t pte)
 {
-	ptep->pte_high = pte.pte_high;
+	WRITE_ONCE(ptep->pte_high, pte.pte_high);
 	smp_wmb();
-	ptep->pte_low = pte.pte_low;
+	WRITE_ONCE(ptep->pte_low, pte.pte_low);
 }
 
 static inline void native_set_pte_atomic(pte_t *ptep, pte_t pte)
@@ -58,16 +58,16 @@ static inline void native_set_pud(pud_t
 static inline void native_pte_clear(struct mm_struct *mm, unsigned long addr,
 				    pte_t *ptep)
 {
-	ptep->pte_low = 0;
+	WRITE_ONCE(ptep->pte_low, 0);
 	smp_wmb();
-	ptep->pte_high = 0;
+	WRITE_ONCE(ptep->pte_high, 0);
 }
 
 static inline void native_pmd_clear(pmd_t *pmdp)
 {
-	pmdp->pmd_low = 0;
+	WRITE_ONCE(pmdp->pmd_low, 0);
 	smp_wmb();
-	pmdp->pmd_high = 0;
+	WRITE_ONCE(pmdp->pmd_high, 0);
 }
 
 static inline void native_pud_clear(pud_t *pudp)


