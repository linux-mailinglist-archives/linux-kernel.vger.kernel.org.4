Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 13C796FFD8A
	for <lists+linux-kernel@lfdr.de>; Fri, 12 May 2023 01:59:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239597AbjEKX7X (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 May 2023 19:59:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239118AbjEKX7U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 May 2023 19:59:20 -0400
Received: from mail-pl1-x64a.google.com (mail-pl1-x64a.google.com [IPv6:2607:f8b0:4864:20::64a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91E892689
        for <linux-kernel@vger.kernel.org>; Thu, 11 May 2023 16:59:19 -0700 (PDT)
Received: by mail-pl1-x64a.google.com with SMTP id d9443c01a7336-1ab032d91a1so56365605ad.1
        for <linux-kernel@vger.kernel.org>; Thu, 11 May 2023 16:59:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1683849559; x=1686441559;
        h=cc:to:from:subject:message-id:mime-version:date:reply-to:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gD2wxPZRC0ahvDEQjNH7fq/3Dc5P0Iq9R9ium1bEMDs=;
        b=MGlk/PU6+IiRolQerNk2PgwQ3qtJKnQgVTFFYNdIV6zqL44zPzxziJabGly2AGIVNq
         5oQlH0xf6wv9J8MUDwUVsuuCBBf02zpuhdgaw16nHDDnOl0REeITiZD6b8ysx/vhCyqq
         o2XOCeW2Kd17g+AF5NHI6I3kgLbokCfBbyQjGQ3OZvssXbjtBtkVsYsMcoZ6A058C19s
         vvwt3M/43mEjSGVlDt8VyvOTjidsavTu6KmtYQqsXiWKvXYCL5S7Av7Edtc6mccjwbBA
         MpvssCS4p88KfTGeIyGm01SHHLRRtGJ4srT8qJn8col/vEv0ALeSec4KTCfRUpyiQ1SV
         0dyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683849559; x=1686441559;
        h=cc:to:from:subject:message-id:mime-version:date:reply-to
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gD2wxPZRC0ahvDEQjNH7fq/3Dc5P0Iq9R9ium1bEMDs=;
        b=Vj42CzOQZnvf6/AMg6nPMp+Y7r0x3OppZuF+7fnv4gPaNrgNE8n+Cg0ZlKo3oAPAO3
         2+BtycKrOYnCcGTMhW3OtQJmNQcJH2fkGTfY47MfiKWyi70N87iC1vl2RRrVZLIEFGw3
         OmP4/kFzyhnJGB8Lebx0+oXIU7t8SDOnTNu+BL4Nx91QykKSkxYIGxeCrzn6nHtsaC2F
         OySJvyo0g1tLIasrjHSk1RmUDxsCRCdd9eMQMRr5xLO85PzqrEWL0tX5hlFCyuSy37lT
         wa293Pnm/LHKiJ3G+hv/O7K2bqDrw/3MYdOKhBgKdrS8RCyWCXPvnFgoUnNMM9DB1hMl
         fnWA==
X-Gm-Message-State: AC+VfDymrZfnjSix6d/NvQcyEkbI4Q5mqYevftdzCRJAMZAtj0AfvTMp
        bV0v34RTafmWVbVif2FCoBauL0EqfRA=
X-Google-Smtp-Source: ACHHUZ5A5kjW5bVlvq9KdEsMcLgB0AvNHGoaoxEVVyJ0iRuhS0gCQaUM+/sipjlblCzBwi/jS/uHFUBPx1s=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a17:902:7604:b0:1ac:b4db:6a5e with SMTP id
 k4-20020a170902760400b001acb4db6a5emr2296794pll.0.1683849559164; Thu, 11 May
 2023 16:59:19 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date:   Thu, 11 May 2023 16:59:08 -0700
Mime-Version: 1.0
X-Mailer: git-send-email 2.40.1.606.ga4b1b128d6-goog
Message-ID: <20230511235917.639770-1-seanjc@google.com>
Subject: [PATCH 0/9] KVM: x86/mmu: Clean up MMU_DEBUG and BUG/WARN usage
From:   Sean Christopherson <seanjc@google.com>
To:     Sean Christopherson <seanjc@google.com>,
        Paolo Bonzini <pbonzini@redhat.com>
Cc:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Mingwei Zhang <mizhang@google.com>,
        David Matlack <dmatlack@google.com>,
        Jim Mattson <jmattson@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series consist of three loosely related miniseries:

 1. Remove the noisy prints buried behind MMU_DEBUG, and replace MMU_DEBUG
    with a KVM_PROVE_MMU Kconfig.

 2. Use WARN_ON_ONCE() for all runtime WARNs, i.e. avoid spamming the
    kernel log if something goes awry in the MMU.

 3. Demote BUG() usage in the shadow MMU to KVM_BUG_ON() when the kernel
    is built with CONFIG_BUG_ON_DATA_CORRUPTION=n.

The three things aren't directly dependent on each other, but there are
minor conflicts, and more importantly I want to have a single series for
discussing how we want the MMU to behave when things go sideways.

Mingwei Zhang (1):
  KVM: x86/mmu: Plumb "struct kvm" all the way to pte_list_remove()

Sean Christopherson (8):
  KVM: x86/mmu: Delete pgprintk() and all its usage
  KVM: x86/mmu: Delete rmap_printk() and all its usage
  KVM: x86/mmu: Delete the "dbg" module param
  KVM: x86/mmu: Rename MMU_WARN_ON() to KVM_MMU_WARN_ON()
  KVM: x86/mmu: Convert "runtime" WARN_ON() assertions to WARN_ON_ONCE()
  KVM: x86/mmu: Bug the VM if a vCPU ends up in long mode without PAE
    enabled
  KVM: x86/mmu: Replace MMU_DEBUG with proper KVM_PROVE_MMU Kconfig
  KVM: x86/mmu: BUG() in rmap helpers iff
    CONFIG_BUG_ON_DATA_CORRUPTION=y

 arch/x86/kvm/Kconfig            |  13 +++
 arch/x86/kvm/mmu/mmu.c          | 144 +++++++++++++-------------------
 arch/x86/kvm/mmu/mmu_internal.h |  14 +---
 arch/x86/kvm/mmu/page_track.c   |  16 ++--
 arch/x86/kvm/mmu/paging_tmpl.h  |  16 ++--
 arch/x86/kvm/mmu/spte.c         |   6 +-
 arch/x86/kvm/mmu/spte.h         |   8 +-
 arch/x86/kvm/mmu/tdp_iter.c     |   4 +-
 arch/x86/kvm/mmu/tdp_mmu.c      |  28 +++----
 include/linux/kvm_host.h        |  19 +++++
 10 files changed, 127 insertions(+), 141 deletions(-)


base-commit: 5c291b93e5d665380dbecc6944973583f9565ee5
-- 
2.40.1.606.ga4b1b128d6-goog

