Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D2CB062AE54
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Nov 2022 23:27:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238599AbiKOW1S (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Nov 2022 17:27:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231935AbiKOW0j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Nov 2022 17:26:39 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1718F3120B;
        Tue, 15 Nov 2022 14:26:27 -0800 (PST)
Date:   Tue, 15 Nov 2022 22:26:24 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1668551185;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=+JtffAj+2E6g0CcEyxya1ard296ICfPdvweSfJug0Ww=;
        b=PCg4IE122wfMfXgTYuRsl2pC/fRifjH5YyruypjNTp8E4d7Zv1GJF8aL52dmMdXZNcuwoe
        qdIDFMkCcq9nWcU9E3kCRKbqAcuHqNXzAIRi1XoHumud5IunTdnM7JS88kFbdEACd9KFZ6
        OweUVFBvosgGaaspSw3ab0bW2T/ZMssOQkpw2uUEULKNS8WvnIB5MjjIZAv6g1yAIVCySr
        I4fWnivCK3iL9NcIN5xqa9jhPDX9l2wKDzmAY0J5LjPoR+/dd2+rGIVC6NKxBbi+DGhjoX
        wIJWjXc+1YbUBJkCV8ydlZySOnLRpIsP8cWWwej83SeWp5KCfgMbUcDPV6v7nA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1668551185;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=+JtffAj+2E6g0CcEyxya1ard296ICfPdvweSfJug0Ww=;
        b=yphQOfhfwdnV12cTOD9x7HkB7J32qLus4a2aevCuCSKeDh5tAHOqTiaHKd50yBQt7uteNI
        LJkcj0QJWlpAb/Dw==
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
Message-ID: <166855118442.4906.2253990342203519446.tip-bot2@tip-bot2>
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

Commit-ID:     991ab455645118e83fe9f2f9aea6ee383908ffd4
Gitweb:        https://git.kernel.org/tip/991ab455645118e83fe9f2f9aea6ee383908ffd4
Author:        Sean Christopherson <seanjc@google.com>
AuthorDate:    Thu, 10 Nov 2022 20:35:00 
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Tue, 15 Nov 2022 22:29:58 +01:00

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
