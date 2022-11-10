Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E58A624BF3
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Nov 2022 21:35:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231923AbiKJUfO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Nov 2022 15:35:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231881AbiKJUfK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Nov 2022 15:35:10 -0500
Received: from mail-pj1-x1049.google.com (mail-pj1-x1049.google.com [IPv6:2607:f8b0:4864:20::1049])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E253A51C0F
        for <linux-kernel@vger.kernel.org>; Thu, 10 Nov 2022 12:35:08 -0800 (PST)
Received: by mail-pj1-x1049.google.com with SMTP id oo18-20020a17090b1c9200b0020bdba475afso4052961pjb.4
        for <linux-kernel@vger.kernel.org>; Thu, 10 Nov 2022 12:35:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=ORwfmj6kJY3MPYNwljMh0Ojz+sLVhyTdNLlUMLv1/pk=;
        b=dPenHzAEbJW8kC8ElMo2seQwuBWhbPC+xdFHerkhEDaAFKmywZZmJt5EKYxFYx5PvA
         ZmSN46xKFXiQ+Pp97CdEflEmOOgwFrIBLmkwqYRhzHE6W0scPyPsk0g6pP92RC/Ms9wg
         woHe+rgbZW5FUymKr5zW6CoWWcEtiAQ3zG7XADhtXqsxKkXfPN6Thqvc4vg12tOaeb+Z
         wBHu6IfhDia8qZ3HVCY2+V7n3w8UE+GKuXGOmdst2gOndCJ3rWo9fi3pSCWN+QAHJRq4
         ujCkQcGcl63h8ZV0ZSYMEHo4r5MMH8TrJED7BWIrVPMrWFIyW5MApHTDpEWqRIhumVS/
         IGCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ORwfmj6kJY3MPYNwljMh0Ojz+sLVhyTdNLlUMLv1/pk=;
        b=uVIia9Ypxd0jvbeMe3hIxLaj7AnvRbu62OtrI1U3kMv8A99IaITsOiduphPUH6Ew9f
         9B8HNx9Y1NbIqR2TRP2DFD0AhVDQ6DKBD4bjd+OLUpjFcGXVZnbc+p3KOKAyYFiU+X9K
         t3sFlWnJ8hUlebohSdQUG1lA5iRMiDvUyeVcXvGzET4f4J4PtVAfak7SrvcZwHSlFGS/
         dZ81iWOOyRLfD2mhxjilKy9xWLZVaM3x1GWBpCvs8LRgmADquSgv1pz7u3T8lpzDaGK7
         Mg/Dd87UqN4rlfhwNDBT8tSc8P0ypbf3l4NkqMyRHteD/BcAfN/ypehaJQCLujZVAhh2
         uVxg==
X-Gm-Message-State: ACrzQf1zoY1or6cM2uihAQLV5Ma0MG5PZJ2xcJhJqrcyKUfsw34poMDM
        ldU6Xvi8ACpgrlJS5CNq6Za9CH4NKKg=
X-Google-Smtp-Source: AMsMyM5fLKb1rLHzXIfRwcSUTb4J0JSxCJOaAqeWcC8JblIxncIkbaH9LXt+i6VekSJ9dYeWY2bd3Jh2AcY=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a17:902:9894:b0:185:57b6:13c3 with SMTP id
 s20-20020a170902989400b0018557b613c3mr1968715plp.116.1668112508403; Thu, 10
 Nov 2022 12:35:08 -0800 (PST)
Reply-To: Sean Christopherson <seanjc@google.com>
Date:   Thu, 10 Nov 2022 20:35:00 +0000
In-Reply-To: <20221110203504.1985010-1-seanjc@google.com>
Mime-Version: 1.0
References: <20221110203504.1985010-1-seanjc@google.com>
X-Mailer: git-send-email 2.38.1.431.g37b22c650d-goog
Message-ID: <20221110203504.1985010-2-seanjc@google.com>
Subject: [PATCH v2 1/5] x86/mm: Recompute physical address for every page of
 per-CPU CEA mapping
From:   Sean Christopherson <seanjc@google.com>
To:     Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, Andrey Ryabinin <ryabinin.a.a@gmail.com>
Cc:     "H. Peter Anvin" <hpa@zytor.com>,
        Alexander Potapenko <glider@google.com>,
        Andrey Konovalov <andreyknvl@gmail.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        linux-kernel@vger.kernel.org, kasan-dev@googlegroups.com,
        Sean Christopherson <seanjc@google.com>,
        syzbot+ffb4f000dc2872c93f62@syzkaller.appspotmail.com,
        syzbot+8cdd16fd5a6c0565e227@syzkaller.appspotmail.com
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

Recompute the physical address for each per-CPU page in the CPU entry
area, a recent commit inadvertantly modified cea_map_percpu_pages() such
that every PTE is mapped to the physical address of the first page.

Fixes: 9fd429c28073 ("x86/kasan: Map shadow for percpu pages on demand")
Cc: Andrey Ryabinin <ryabinin.a.a@gmail.com>
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/mm/cpu_entry_area.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/mm/cpu_entry_area.c b/arch/x86/mm/cpu_entry_area.c
index dff9001e5e12..d831aae94b41 100644
--- a/arch/x86/mm/cpu_entry_area.c
+++ b/arch/x86/mm/cpu_entry_area.c
@@ -97,7 +97,7 @@ cea_map_percpu_pages(void *cea_vaddr, void *ptr, int pages, pgprot_t prot)
 					early_pfn_to_nid(PFN_DOWN(pa)));
 
 	for ( ; pages; pages--, cea_vaddr+= PAGE_SIZE, ptr += PAGE_SIZE)
-		cea_set_pte(cea_vaddr, pa, prot);
+		cea_set_pte(cea_vaddr, per_cpu_ptr_to_phys(ptr), prot);
 }
 
 static void __init percpu_setup_debug_store(unsigned int cpu)
-- 
2.38.1.431.g37b22c650d-goog

