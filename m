Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C6B54608CFA
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Oct 2022 13:49:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230182AbiJVLtg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 22 Oct 2022 07:49:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230024AbiJVLtA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Oct 2022 07:49:00 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 672C4251D7C
        for <linux-kernel@vger.kernel.org>; Sat, 22 Oct 2022 04:48:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-ID:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To;
        bh=ZxLGyKaonAFGosmEJEXCJIuUc/p2pYnEnlwCFC//QMs=; b=d5RZJQiWmMamzGxaIKQnEOtUwD
        T9H/sWSomE2By/o8fhYFxcJnvZOZCOoyYsj4DPqrDTAEiVXHR6xyiOPOuV3LpQeQUbDuoAPcmVKGs
        DJSaXerbzdFXHI/CeMHGBW7cMxLNnTrKYaXjJZ3DmnuM+KA59Jo1ENMyp0WIE4NfWdcSJlN6hSA3v
        I0C+dfhtEKU3yRXt+wguStxjqcWSysKILzObipzuaBHkU3xB0q+bVaL3s37Udbo8ewcAHquPYv+98
        QYAVXxD+sKkG/ZpZypq3uRMpr18Br1YlM8YBXYyqaiaLhGv+xeybW3Binc8LI7NIXuDe907gPs0vd
        qMBpHPRw==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1omCzM-005XdG-1V; Sat, 22 Oct 2022 11:48:28 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id BDB6F302D82;
        Sat, 22 Oct 2022 13:48:26 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id 33F9C28B8E514; Sat, 22 Oct 2022 13:48:26 +0200 (CEST)
Message-ID: <20221022114424.906110403@infradead.org>
User-Agent: quilt/0.66
Date:   Sat, 22 Oct 2022 13:14:10 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     x86@kernel.org, willy@infradead.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org
Cc:     linux-kernel@vger.kernel.org, peterz@infradead.org,
        linux-mm@kvack.org, aarcange@redhat.com,
        kirill.shutemov@linux.intel.com, jroedel@suse.de, ubizjak@gmail.com
Subject: [PATCH 07/13] mm/gup: Fix the lockless PMD access
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

On architectures where the PTE/PMD is larger than the native word size
(i386-PAE for example), READ_ONCE() can do the wrong thing. Use
pmdp_get_lockless() just like we use ptep_get_lockless().

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 kernel/events/core.c |    2 +-
 mm/gup.c             |    2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -7186,7 +7186,7 @@ static u64 perf_get_pgtable_size(struct
 		return pud_leaf_size(pud);
 
 	pmdp = pmd_offset_lockless(pudp, pud, addr);
-	pmd = READ_ONCE(*pmdp);
+	pmd = pmdp_get_lockless(pmdp);
 	if (!pmd_present(pmd))
 		return 0;
 
--- a/mm/gup.c
+++ b/mm/gup.c
@@ -2507,7 +2507,7 @@ static int gup_pmd_range(pud_t *pudp, pu
 
 	pmdp = pmd_offset_lockless(pudp, pud, addr);
 	do {
-		pmd_t pmd = READ_ONCE(*pmdp);
+		pmd_t pmd = pmdp_get_lockless(pmdp);
 
 		next = pmd_addr_end(addr, end);
 		if (!pmd_present(pmd))


