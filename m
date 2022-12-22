Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 13B37653AA3
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Dec 2022 03:35:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234779AbiLVCfD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Dec 2022 21:35:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234636AbiLVCfB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Dec 2022 21:35:01 -0500
Received: from mail-pf1-x449.google.com (mail-pf1-x449.google.com [IPv6:2607:f8b0:4864:20::449])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F14020BF2
        for <linux-kernel@vger.kernel.org>; Wed, 21 Dec 2022 18:35:00 -0800 (PST)
Received: by mail-pf1-x449.google.com with SMTP id 24-20020aa79118000000b00580476432deso284809pfh.23
        for <linux-kernel@vger.kernel.org>; Wed, 21 Dec 2022 18:35:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=GQnf75ze0MrWQoPr5yQT3tzD1yRIZkcu/325HSdEpko=;
        b=X4vqa2QMpMtABV2Zgc+HWnHmmowZhCWIDTxEEslxL9AK9cacIhKnTXDrjxOirRhvA4
         SLFOeOw1nXYyHiyzOg1qLcn40wlrwe2YhqMo0y3GDFxvd3w7DZm5SFRmFhFN6vb1W0l+
         sefeqBsRsi7ASQ1rrZEn7NR2MgmHF75tr3yRaKmwI0m5Zy30UVuKI4PM+PyrglYQm0ld
         TT0y+AHQSNAizPwZhzeF96NX53MAj1M4IdvnWbkGY4Bi8eLgVl2+EwxbxHokgpuwavuR
         JctECNSyLWlHSMcBtDWhwSm2coSbe1WdXq//62vJVf0WCSDPLvbqsLikbYAsGD0afiwH
         px+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=GQnf75ze0MrWQoPr5yQT3tzD1yRIZkcu/325HSdEpko=;
        b=HwZpne+IfD4cfmETGVIsgXQh7qC6BiVmhO0k6NECB/jjW/DrRZMRHt0uBPrFUs/FiS
         ZToFUf96PyvfvFmigEq8duesh+xCCR4PJE8I7J7O5obF54OO+NG9K1Lz+dB5pt6AAz6f
         UPg5i0CWLIADA1MKbXAmKkM2uAuQ6DfEGVujisO2swHOfa5puX6uOCHSZEBvwSrMKG0I
         g1VZ3Z6pGlDyR4ZdUAwEyNSMTu5h6NWcnBRnhNdguBXV7VCCvD/yGf7AgHvbtaKC5WGb
         aRyLJufBnm9WxjG+HQdC1ywgdqfw1Y0vQEDCITbHsR3vyVIP2NhHVSJqyNdAdvx9rF6i
         LAXw==
X-Gm-Message-State: AFqh2kqhj/VQ4xXZ3E0YURk7kjf+y16YPqeDFpLMa9DheTlsWEObDN2L
        3zWP1lBasY8lBeJ/aJaR/4z5eYM4DXf0
X-Google-Smtp-Source: AMrXdXuahbYQA2tTILXh7hNiKny1YPQHfnYGywLu0VLli8mKtoavgPoSkRaq1Z2htV2mb5KI+5sAIRlgRW5I
X-Received: from vipin.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:479f])
 (user=vipinsh job=sendgmr) by 2002:a17:90b:35c3:b0:219:5bdb:2b45 with SMTP id
 nb3-20020a17090b35c300b002195bdb2b45mr402510pjb.71.1671676500067; Wed, 21 Dec
 2022 18:35:00 -0800 (PST)
Date:   Wed, 21 Dec 2022 18:34:48 -0800
Mime-Version: 1.0
X-Mailer: git-send-email 2.39.0.314.g84b9a713c41-goog
Message-ID: <20221222023457.1764-1-vipinsh@google.com>
Subject: [Patch v3 0/9] NUMA aware page table's pages allocation
From:   Vipin Sharma <vipinsh@google.com>
To:     seanjc@google.com, pbonzini@redhat.com, bgardon@google.com,
        dmatlack@google.com
Cc:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Vipin Sharma <vipinsh@google.com>
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

Hi,

This series has expanded from v2 based on the feedbacks. Main items happening in
this series are:

1. KVM MMU shrinker now shrinks KVM caches.
   MMU shrinker will free shadow page caches and split caches whenever shrinker
   is invoked.

2. Page table's pages are allocated on NUMA node during fault and split.
   Pages of page tables will be allocated based on the underlying physical page
   a page table entry is point to. Got performance improvement up to 150% in
   416 vCPUs VM during live migrations.

3. Cache size is reduced from 40 to 5.
   40 is current cache size for KVM memory caches. Reduced them to 5. I didn't
   see any negative performance impact while running perf and dirty_log_perf_test.
   I also saw lesser number of calls to get a free page.

Thanks
Vipin

v3:
- Split patches into smaller ones.
- Repurposed KVM MMU shrinker to free cache pages instead of oldest page table
  pages
- Reduced cache size from 40 to 5
- Removed __weak function and initializing node value in all architectures.
- Some name changes.

v2: https://lore.kernel.org/lkml/20221201195718.1409782-1-vipinsh@google.com/
- All page table pages will be allocated on underlying physical page's
  NUMA node.
- Introduced module parameter, numa_aware_pagetable, to disable this
  feature.
- Using kvm_pfn_to_refcounted_page to get page from a pfn.

v1: https://lore.kernel.org/all/20220801151928.270380-1-vipinsh@google.com/

Vipin Sharma (9):
  KVM: x86/mmu: Repurpose KVM MMU shrinker to purge shadow page caches
  KVM: x86/mmu: Remove zapped_obsolete_pages from struct kvm_arch{}
  KVM: x86/mmu: Shrink split_shadow_page_cache via KVM MMU shrinker
  KVM: Add module param to make page tables NUMA aware
  KVM: x86/mmu: Allocate TDP page table's page on correct NUMA node on
    split
  KVM: Provide NUMA node support to kvm_mmu_memory_cache{}
  KVM: x86/mmu: Allocate page table's pages on NUMA node of the
    underlying pages
  KVM: x86/mmu: Make split_shadow_page_cache NUMA aware
  KVM: x86/mmu: Reduce default cache size in KVM from 40 to
    PT64_ROOT_MAX_LEVEL

 arch/arm64/kvm/arm.c             |   2 +-
 arch/arm64/kvm/mmu.c             |   4 +-
 arch/mips/kvm/mips.c             |   2 +
 arch/riscv/kvm/mmu.c             |   2 +-
 arch/riscv/kvm/vcpu.c            |   2 +-
 arch/x86/include/asm/kvm_host.h  |  15 +-
 arch/x86/include/asm/kvm_types.h |   2 +-
 arch/x86/kvm/mmu/mmu.c           | 282 +++++++++++++++++++------------
 arch/x86/kvm/mmu/mmu_internal.h  |   2 +
 arch/x86/kvm/mmu/paging_tmpl.h   |   4 +-
 arch/x86/kvm/mmu/tdp_mmu.c       |  24 ++-
 include/linux/kvm_host.h         |  27 +++
 include/linux/kvm_types.h        |   2 +
 virt/kvm/kvm_main.c              |  35 +++-
 14 files changed, 277 insertions(+), 128 deletions(-)

-- 
2.39.0.314.g84b9a713c41-goog

