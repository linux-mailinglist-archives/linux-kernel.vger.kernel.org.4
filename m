Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F582608CF3
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Oct 2022 13:49:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230289AbiJVLtH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 22 Oct 2022 07:49:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229824AbiJVLst (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Oct 2022 07:48:49 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E73824FEFE
        for <linux-kernel@vger.kernel.org>; Sat, 22 Oct 2022 04:48:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-ID:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To;
        bh=B/ouY7blFSKbM/QG08uUBBh7FdO1AskbZkW9MoHfj6s=; b=S//P5/VxJDDNdFqdqGkA0ghIGL
        VinkdVqdm4OvZQrImBQTdKp1JukAyaG5YVjjy3e3UbDF00JPqap9zUb+NzaQ9P+zYX2Pis2cBtO0z
        EgXV49kD0T3r9+YUm/5EWRySgkDdgVD8o2tUfQDEEFP59xFAkC0pvHiU34HWdkAN3NmJAqwoaljai
        vOSad0sFEWshxHC1ZMIEuH56m4bKhF56jG0i4XooByga1cS3S1h7RrM/RW1O7j+nHFv3L1Cs38kQ9
        GL7ZcQmZzyK2TEjFTPmNeE2yXiIj2VXTm5ImT10pf0FddSMPwgv3YCOyx9TMjBlEnjQrdOYxkwymX
        r5aanGyA==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1omCzL-005XdF-G3; Sat, 22 Oct 2022 11:48:28 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 327EC300472;
        Sat, 22 Oct 2022 13:48:26 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id 1C06028B8E50E; Sat, 22 Oct 2022 13:48:26 +0200 (CEST)
Message-ID: <20221022114424.515572025@infradead.org>
User-Agent: quilt/0.66
Date:   Sat, 22 Oct 2022 13:14:04 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     x86@kernel.org, willy@infradead.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org
Cc:     linux-kernel@vger.kernel.org, peterz@infradead.org,
        linux-mm@kvack.org, aarcange@redhat.com,
        kirill.shutemov@linux.intel.com, jroedel@suse.de, ubizjak@gmail.com
Subject: [PATCH 01/13] mm: Update ptep_get_lockless()s comment
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

Improve the comment.

Suggested-by: Matthew Wilcox <willy@infradead.org>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 include/linux/pgtable.h |   17 ++++++++---------
 1 file changed, 8 insertions(+), 9 deletions(-)

--- a/include/linux/pgtable.h
+++ b/include/linux/pgtable.h
@@ -260,15 +260,12 @@ static inline pte_t ptep_get(pte_t *ptep
 
 #ifdef CONFIG_GUP_GET_PTE_LOW_HIGH
 /*
- * WARNING: only to be used in the get_user_pages_fast() implementation.
- *
- * With get_user_pages_fast(), we walk down the pagetables without taking any
- * locks.  For this we would like to load the pointers atomically, but sometimes
- * that is not possible (e.g. without expensive cmpxchg8b on x86_32 PAE).  What
- * we do have is the guarantee that a PTE will only either go from not present
- * to present, or present to not present or both -- it will not switch to a
- * completely different present page without a TLB flush in between; something
- * that we are blocking by holding interrupts off.
+ * For walking the pagetables without holding any locks.  Some architectures
+ * (eg x86-32 PAE) cannot load the entries atomically without using expensive
+ * instructions.  We are guaranteed that a PTE will only either go from not
+ * present to present, or present to not present -- it will not switch to a
+ * completely different present page without a TLB flush inbetween; which we
+ * are blocking by holding interrupts off.
  *
  * Setting ptes from not present to present goes:
  *


