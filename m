Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 76C8A61A3CC
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Nov 2022 23:01:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230187AbiKDWBT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Nov 2022 18:01:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230075AbiKDWBE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Nov 2022 18:01:04 -0400
Received: from mail-pf1-x44a.google.com (mail-pf1-x44a.google.com [IPv6:2607:f8b0:4864:20::44a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EBC8548756
        for <linux-kernel@vger.kernel.org>; Fri,  4 Nov 2022 15:01:02 -0700 (PDT)
Received: by mail-pf1-x44a.google.com with SMTP id x8-20020aa79568000000b0056dd717e051so3049321pfq.11
        for <linux-kernel@vger.kernel.org>; Fri, 04 Nov 2022 15:01:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=ORwfmj6kJY3MPYNwljMh0Ojz+sLVhyTdNLlUMLv1/pk=;
        b=PO78hPWLhGiPOdh3FKBDOyG8KHk37JCjEqyaVuWHpv31zowr7R3uAFNA1xtr4KmvX7
         MNgLdzxinD3pD3F+Iy+FJRRYB6+BaIPkmAKMS8sMpLZvtYHqQ0Za+XlkPiLJGehQiKZD
         Ias/Me6yBT1a0kIMIsVRb9byR3i+C25+OfJMXPHOLtheGpsxMiwTrdYfDGgT7qe6YH0p
         VYlbRiW0TZ1PXbmeLJXvnAbdVEU6FaoijOh4HcfTQ+mLSmRNyTJbqm5Qx1KjIGGv3lW2
         KyB/3dFcoWYX++Bzh/d18RvfnpRxTpexGp5tVGKeS09SDdPSUNgquKt+qz/3a71UO18U
         AzaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ORwfmj6kJY3MPYNwljMh0Ojz+sLVhyTdNLlUMLv1/pk=;
        b=heu+Y+yHIH7PaGLre7J/K9qWlzHFPKAVZdozZw6K12yeqPeacesYNUDEhhOFiplI3K
         UBFknwddBKZysQhAJcyVbo0HrcD/9MPgYNXJ/y2+R/iYIpVX7lkNOE/tc7FAyKOqV+gz
         3wVKjZv9RSq6uWCC6DUT/4EWh0vGSWEHN3HE4Wdqvb2farXOBo6Zn4ti+Omh5b/v4nNH
         XAZ6G/C4FWf0G2yOfldRPhIHYnHhhCRohjJ2lbksQ+Auk0mIsuji4ARuhP4eHq4KTBbK
         oyhftq1CP6H6g4Opnice4UomUOoDUWEpocEOAEj6Lzkp/+u6NlrfXmV1u/f39qeYTW7Q
         FVvg==
X-Gm-Message-State: ACrzQf1J6WOEECqEQqAbVfdvhILR5hPWZiPQ8MqZ6tA7cI8JnNna5Y3F
        hlHJrszivwXD9s9u7GhIE8CMz8DvFAA=
X-Google-Smtp-Source: AMsMyM5GdWMwxgD79omgNC7BtFyG5IKFLHKInrzehKV7GztQovXKAacMaTRUyY4p85E/d0ew6BMw5d4H85I=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a17:90b:1809:b0:213:aeae:64a1 with SMTP id
 lw9-20020a17090b180900b00213aeae64a1mr37290558pjb.226.1667599262508; Fri, 04
 Nov 2022 15:01:02 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date:   Fri,  4 Nov 2022 22:00:52 +0000
In-Reply-To: <20221104220053.1702977-1-seanjc@google.com>
Mime-Version: 1.0
References: <20221104220053.1702977-1-seanjc@google.com>
X-Mailer: git-send-email 2.38.1.431.g37b22c650d-goog
Message-ID: <20221104220053.1702977-2-seanjc@google.com>
Subject: [PATCH 1/2] x86/mm: Recompute physical address for every page of
 per-CPU CEA mapping
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

