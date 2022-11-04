Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C2B7D61A3CD
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Nov 2022 23:01:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230211AbiKDWBY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Nov 2022 18:01:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230108AbiKDWBK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Nov 2022 18:01:10 -0400
Received: from mail-pf1-x44a.google.com (mail-pf1-x44a.google.com [IPv6:2607:f8b0:4864:20::44a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD4474E418
        for <linux-kernel@vger.kernel.org>; Fri,  4 Nov 2022 15:01:04 -0700 (PDT)
Received: by mail-pf1-x44a.google.com with SMTP id s11-20020a056a00178b00b0056cb4545c3fso3003261pfg.5
        for <linux-kernel@vger.kernel.org>; Fri, 04 Nov 2022 15:01:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=hFSxCFHJFYCR3Q5XQD/tcaVtxH3V8cegjhQxWvzfaqM=;
        b=q0L8+bqnh53LPDpc0iuNUVddTLJoqw3lgeoQHAOoNMmJjbaq/RhZUEfKy65bQ2V4tx
         ERlv7E97fNBIVpYL+3G69Vj1ulBMJ0DL3rPkykV1dWoMXRXD5NyqnSBvGMSyjBEojso8
         m6a5BX9oE/0gS/tTIbuRF2KkUS+AvoBLzXaU3IwHZevQo5anQo0hG2J/AUwEAG3Wh1dv
         Blmz68yvweRKLbBXaEw1fyIOLCCdFn2hfFu6QBTl8a4nIsVrR21EwF36hXNqsswJS558
         Nob/GWI+YiXwC/4g88+MVWj+0dDFnEpBmDc/3RAyWL+C/sAuPgUoRuFlJPsJe7UhAoUy
         8Q7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hFSxCFHJFYCR3Q5XQD/tcaVtxH3V8cegjhQxWvzfaqM=;
        b=eG7lz7kA6SZuhT54L9ppsmAdzc6IStDjuYiV9UOfpf447dGMAir58FnN5JwrGrkR2k
         Sdy6qpRuBp39Au6+RX9EAXVtuws7NeRlzVV71vysBxWC1bv2DaySHGuCkAqU+8725CSK
         p9jW84FlW7V9sG4dcG+/jBWT6Hi0OR0qMbhkf8i7JGH72fogRnVefg+ftVxJHSGpd4h7
         fK+sSZvaPoITmspfrEfqDzBWZu0R/kMJRECsHAHPNpUrQOhphmwfu1iOWUn6+w6BUccq
         PLs/WmwuckTJ6ZU0Tr430v48udQvhsPH8F+H7vOT+eQO7ovCNfOSer8Glhj1PeA5P1Li
         WRgg==
X-Gm-Message-State: ACrzQf0knlXieM/JsaS/Ez1FqxYzXiDz/ddReHnMmDs+tVRQfIgobNZ1
        TF3eiokT/kj5+U4fsI5z87WJS4By1AY=
X-Google-Smtp-Source: AMsMyM610M1J+WSeJ+P7QwJwJgjFxAOtG8mwtfLw98Ss3tp4pc/Wm9XmQbBvVzKISbKGAzL18/rMpazn/Oc=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a17:90b:11c1:b0:212:d3ec:632f with SMTP id
 gv1-20020a17090b11c100b00212d3ec632fmr381735pjb.43.1667599264346; Fri, 04 Nov
 2022 15:01:04 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date:   Fri,  4 Nov 2022 22:00:53 +0000
In-Reply-To: <20221104220053.1702977-1-seanjc@google.com>
Mime-Version: 1.0
References: <20221104220053.1702977-1-seanjc@google.com>
X-Mailer: git-send-email 2.38.1.431.g37b22c650d-goog
Message-ID: <20221104220053.1702977-3-seanjc@google.com>
Subject: [PATCH 2/2] x86/mm: Populate KASAN shadow for per-CPU DS buffers in
 CPU entry area
From:   Sean Christopherson <seanjc@google.com>
To:     Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     linux-kernel@vger.kernel.org,
        Andrey Ryabinin <ryabinin.a.a@gmail.com>,
        Sean Christopherson <seanjc@google.com>,
        Dmitry Vyukov <dvyukov@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Bounce through cea_map_percpu_pages() when setting the initial
protections for per-CPU DS buffers so that KASAN populates a shadow for
said mapping.  Failure to populate the shadow will result in a
not-present #PF during KASAN validation if DS buffers are activated
later on.

Fixes: 9fd429c28073 ("x86/kasan: Map shadow for percpu pages on demand")
Cc: Andrey Ryabinin <ryabinin.a.a@gmail.com>
Cc: Dmitry Vyukov <dvyukov@google.com>
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/mm/cpu_entry_area.c | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/arch/x86/mm/cpu_entry_area.c b/arch/x86/mm/cpu_entry_area.c
index d831aae94b41..64ae557ceb22 100644
--- a/arch/x86/mm/cpu_entry_area.c
+++ b/arch/x86/mm/cpu_entry_area.c
@@ -91,13 +91,12 @@ void cea_set_pte(void *cea_vaddr, phys_addr_t pa, pgprot_t flags)
 static void __init
 cea_map_percpu_pages(void *cea_vaddr, void *ptr, int pages, pgprot_t prot)
 {
-	phys_addr_t pa = per_cpu_ptr_to_phys(ptr);
+	int nid = ptr ? early_pfn_to_nid(PFN_DOWN(per_cpu_ptr_to_phys(ptr))) : 0;
 
-	kasan_populate_shadow_for_vaddr(cea_vaddr, pages * PAGE_SIZE,
-					early_pfn_to_nid(PFN_DOWN(pa)));
+	kasan_populate_shadow_for_vaddr(cea_vaddr, pages * PAGE_SIZE, nid);
 
 	for ( ; pages; pages--, cea_vaddr+= PAGE_SIZE, ptr += PAGE_SIZE)
-		cea_set_pte(cea_vaddr, per_cpu_ptr_to_phys(ptr), prot);
+		cea_set_pte(cea_vaddr, ptr ? per_cpu_ptr_to_phys(ptr) : 0, prot);
 }
 
 static void __init percpu_setup_debug_store(unsigned int cpu)
@@ -121,8 +120,7 @@ static void __init percpu_setup_debug_store(unsigned int cpu)
 	 * memory like debug store buffers.
 	 */
 	npages = sizeof(struct debug_store_buffers) / PAGE_SIZE;
-	for (; npages; npages--, cea += PAGE_SIZE)
-		cea_set_pte(cea, 0, PAGE_NONE);
+	cea_map_percpu_pages(cea, NULL, npages, PAGE_NONE);
 #endif
 }
 
-- 
2.38.1.431.g37b22c650d-goog

