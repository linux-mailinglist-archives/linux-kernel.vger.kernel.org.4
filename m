Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E738164FBD4
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Dec 2022 19:56:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230136AbiLQS4P (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 17 Dec 2022 13:56:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229982AbiLQSzf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Dec 2022 13:55:35 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31E0410B79;
        Sat, 17 Dec 2022 10:55:35 -0800 (PST)
Date:   Sat, 17 Dec 2022 18:55:30 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1671303330;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=7WoHnbBUf+eaFgX0tansF4F+ZZl7V5KaZrpki5k9zWU=;
        b=HThoaR0pbIT71c3Lc5Fh3ZP2Uu/y4zMkj7hXm9VqdIBZ+VZvqa0CLP2y2eYofdTlZb6iwm
        ij2finYPkH9VN+bX7+qDGspLJFkdEz707OlV3O9pERmx2Oef6Nt0ncVl2erNCTKMAN2TwD
        5J0cWxC9+17vj6I2S73hL5nCgAx6D1yKp4W0Fyjr7HD/cwMv4WSjT7ohDDAUE6IrFyTN3Q
        aLZLdQPnWcS2gRjt4lNQREfrbVM3weOTq4e8je//Fg3GJzvTvvUyiZxCEZRntim3bSYve3
        E2GFCyAHda6vocn1fvH1O7dKm0bl/2RVwBwcjUAxoDLhN5Ppe6nCPjDOempRIg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1671303330;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=7WoHnbBUf+eaFgX0tansF4F+ZZl7V5KaZrpki5k9zWU=;
        b=N8xLEwQ1oiFRu7ghlNx3+fv2lOImUVoufw5leaJjWurHIQEyz9hLdP4wf9QOB5WfeOWpA1
        q3q2fSVrAOOtpRBg==
From:   "tip-bot2 for Sean Christopherson" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/mm] x86/mm: Recompute physical address for every page of
 per-CPU CEA mapping
Cc:     Sean Christopherson <seanjc@google.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Andrey Ryabinin <ryabinin.a.a@gmail.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20221110203504.1985010-2-seanjc@google.com>
References: <20221110203504.1985010-2-seanjc@google.com>
MIME-Version: 1.0
Message-ID: <167130333036.4906.9488227521049793904.tip-bot2@tip-bot2>
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

Commit-ID:     80d72a8f76e8f3f0b5a70b8c7022578e17bde8e7
Gitweb:        https://git.kernel.org/tip/80d72a8f76e8f3f0b5a70b8c7022578e17bde8e7
Author:        Sean Christopherson <seanjc@google.com>
AuthorDate:    Thu, 10 Nov 2022 20:35:00 
Committer:     Dave Hansen <dave.hansen@linux.intel.com>
CommitterDate: Thu, 15 Dec 2022 10:37:28 -08:00

x86/mm: Recompute physical address for every page of per-CPU CEA mapping

Recompute the physical address for each per-CPU page in the CPU entry
area, a recent commit inadvertantly modified cea_map_percpu_pages() such
that every PTE is mapped to the physical address of the first page.

Fixes: 9fd429c28073 ("x86/kasan: Map shadow for percpu pages on demand")
Signed-off-by: Sean Christopherson <seanjc@google.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Andrey Ryabinin <ryabinin.a.a@gmail.com>
Link: https://lkml.kernel.org/r/20221110203504.1985010-2-seanjc@google.com
---
 arch/x86/mm/cpu_entry_area.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/mm/cpu_entry_area.c b/arch/x86/mm/cpu_entry_area.c
index dff9001..d831aae 100644
--- a/arch/x86/mm/cpu_entry_area.c
+++ b/arch/x86/mm/cpu_entry_area.c
@@ -97,7 +97,7 @@ cea_map_percpu_pages(void *cea_vaddr, void *ptr, int pages, pgprot_t prot)
 					early_pfn_to_nid(PFN_DOWN(pa)));
 
 	for ( ; pages; pages--, cea_vaddr+= PAGE_SIZE, ptr += PAGE_SIZE)
-		cea_set_pte(cea_vaddr, pa, prot);
+		cea_set_pte(cea_vaddr, per_cpu_ptr_to_phys(ptr), prot);
 }
 
 static void __init percpu_setup_debug_store(unsigned int cpu)
