Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC36363F8AE
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Dec 2022 20:58:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231226AbiLAT6I (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Dec 2022 14:58:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231277AbiLAT5l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Dec 2022 14:57:41 -0500
Received: from mail-pl1-x649.google.com (mail-pl1-x649.google.com [IPv6:2607:f8b0:4864:20::649])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0C73BF65F
        for <linux-kernel@vger.kernel.org>; Thu,  1 Dec 2022 11:57:30 -0800 (PST)
Received: by mail-pl1-x649.google.com with SMTP id p6-20020a170902e74600b001896ba6837bso3429490plf.17
        for <linux-kernel@vger.kernel.org>; Thu, 01 Dec 2022 11:57:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=CK6Z3pMphCqm/P4z2YhqproeKWq48HVTFIpFHrJotqk=;
        b=QXPj2lWYXCaifpx9GebybJ3sTEq11p+pDxgPkDGvSEzmAIXkQzQOXZIAzggLeECNae
         KFWZK3vSHylxoqraBE1/3YN5knTRaF+2DaBoYJa+nfh4T0KX4ygDN1NuJKyMOMwwfs3t
         vRQV1IX0o7ad6RiL6l8jRPoUvVSdnWakG8b9IVNgHwYkFJSUDcvwvjEMmO+fVzQO8cS+
         01BbYFXR0AUIcyPr2YU4+ZqzZF6Pfuct+pmYRQu57VhvMBlgVj7kOSwdE9FIDGKN1n61
         ukPNx9vUXpDgWygk/SFR2mTFRKQagHR21Dxui4YQ5e74TKQWWUHcpHVSnmLUDLDj7D31
         /y+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=CK6Z3pMphCqm/P4z2YhqproeKWq48HVTFIpFHrJotqk=;
        b=DIcoX67Ox0p+FEztDS0zthnXgMEd1y0c1tiSwJud4N/UP81SYBnqwFvbassHSf9y1H
         Ci1GShMQIHHBZn/SvVtbq5P/JHMd1BS3zX9MNqzK4pYFrL4/CKayokO4mpjq65HSDKya
         xA4ob0q4LeFNfXRh9U8Kaz7tl339GESg519eraEpbJyerAMhIe490ZYF55DzmImGUSSi
         81kJoaPhvPSlJig/7Wz5i+sYe81QxFqtRNqAjRtseL9fZ7ANzlG3to5Egj7JiiMw32Wu
         M2ycpAsJkj1qL4DdRZTVWEcVrZ86qT2p6zKT/VczBJKQRMNJr27onVGOnYmw7hXQPHuM
         Wicw==
X-Gm-Message-State: ANoB5plOy7GuNb/Q9CpP3Kd/bekVx53CViHoc4L1QD3aNhRQDsBkvOc0
        owt0EV6ltUBQKpMMdTu9LbeBvRnUJwjp
X-Google-Smtp-Source: AA0mqf4Kvuu18L6bq60fCXdQ2GxrHCXZejhXD4LjdkAaklVZl8ZmwX4OnPg5NMd56bYcbFxxsEBhbdHpypu9
X-Received: from vipin.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:479f])
 (user=vipinsh job=sendgmr) by 2002:aa7:92c7:0:b0:574:39dd:f162 with SMTP id
 k7-20020aa792c7000000b0057439ddf162mr44530279pfa.44.1669924650263; Thu, 01
 Dec 2022 11:57:30 -0800 (PST)
Date:   Thu,  1 Dec 2022 11:57:16 -0800
Mime-Version: 1.0
X-Mailer: git-send-email 2.39.0.rc0.267.gcb52ba06e7-goog
Message-ID: <20221201195718.1409782-1-vipinsh@google.com>
Subject: [Patch v2 0/2] NUMA aware page table allocation
From:   Vipin Sharma <vipinsh@google.com>
To:     dmatlack@google.com, bgardon@google.com, seanjc@google.com,
        pbonzini@redhat.com
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

This series improves page table accesses by allocating page tables on
the same NUMA node where underlying physical page is present.

Currently page tables are allocated during page faults and page splits.
In both instances page table location will depend on the current thread
mempolicy. This can create suboptimal placement of page tables on NUMA
node, for example, thread doing eager page split is on different NUMA
node compared to page it is splitting.

Reviewers please provide suggestion to the following:

1. Module parameter is true by default, which means this feature will
   be enabled by default. Is this okay or should I set it to false?

2. I haven't reduced KVM_ARCH_NR_OBJS_PER_MEMORY_CACHE considering that
   it might not be too much of an impact as only online nodes are filled
   during topup phase and in many cases some of these nodes will never
   be refilled again.  Please let me know if you want this to be
   reduced.

3. I have tried to keep everything in x86/mmu except for some changes in
   virt/kvm/kvm_main.c. I used __weak function so that only x86/mmu will
   see the change, other arch nothing will change. I hope this is the
   right approach.

4. I am not sure what is the right way to split patch 2. If you think
   this is too big for a patch please let me know what would you prefer.

Thanks
Vipin

v2:
- All page table pages will be allocated on underlying physical page's
  NUMA node.
- Introduced module parameter, numa_aware_pagetable, to disable this
  feature.
- Using kvm_pfn_to_refcounted_page to get page from a pfn.

v1: https://lore.kernel.org/all/20220801151928.270380-1-vipinsh@google.com/

Vipin Sharma (2):
  KVM: x86/mmu: Allocate page table pages on TDP splits during dirty log
    enable on the underlying page's numa node
  KVM: x86/mmu: Allocate page table pages on NUMA node of underlying
    pages

 arch/x86/include/asm/kvm_host.h |   4 +-
 arch/x86/kvm/mmu/mmu.c          | 126 ++++++++++++++++++++++++--------
 arch/x86/kvm/mmu/paging_tmpl.h  |   4 +-
 arch/x86/kvm/mmu/tdp_mmu.c      |  26 ++++---
 include/linux/kvm_host.h        |  17 +++++
 include/linux/kvm_types.h       |   2 +
 virt/kvm/kvm_main.c             |   7 +-
 7 files changed, 141 insertions(+), 45 deletions(-)


base-commit: df0bb47baa95aad133820b149851d5b94cbc6790
-- 
2.39.0.rc0.267.gcb52ba06e7-goog

