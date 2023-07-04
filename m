Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A9B34746B18
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jul 2023 09:51:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231446AbjGDHvh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Jul 2023 03:51:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229487AbjGDHvd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jul 2023 03:51:33 -0400
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20A129B
        for <linux-kernel@vger.kernel.org>; Tue,  4 Jul 2023 00:51:32 -0700 (PDT)
Received: by mail-pl1-x632.google.com with SMTP id d9443c01a7336-1b895a06484so9413555ad.1
        for <linux-kernel@vger.kernel.org>; Tue, 04 Jul 2023 00:51:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1688457091; x=1691049091;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=aMukUmhg9wLAu2yBqM0oINI7mMwOTLZl3bN36SrnOr8=;
        b=cRVBIQCrKObRhmaLXecoUVxQsUHCjiJKYZ0ly8h6tFMoM0eLgUDXUWJk32DqnCxO+f
         tGeGpE33VlCPoiqMfjSqd6S3tJ2TvTeLl7h0DUrokBmx8zDNIpVXhbzzzMGHZ5biNSav
         y2d2OuhDSSGEvEXqc+mGYPELnmc8pkr1vb3j4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688457091; x=1691049091;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=aMukUmhg9wLAu2yBqM0oINI7mMwOTLZl3bN36SrnOr8=;
        b=IhZqbgWVuHE/qixOuyaRWfy3V2mNh7T2mF7iuD7CrQwyaY2v41GWeSauzi4Nw4bYiD
         k4x1VKAODn7D/cKCA8wtgjevio4T2UpKhBWxoYHRpe2kd+372fR5sAIf2G/BbjPLn4Dp
         bAZ3m1NM/MCbh8YIXq9j1IRegswb5MMnKbnTKPeTSHvPP+sQ3m1NtgrehJzq0lXKJLIp
         eiymK7OHsKKMNPZiiHOzUaJVn8jE+T8oMJGkDOPa2bnTx+zqdB8gGS90H1frISNg1Lnh
         UheekYXpRwN34261Riqc/2fmhq3BdBrN+GMMe/CsvXL4tNXDdoSI0CoPyxC6YXY5QOkf
         Vf8Q==
X-Gm-Message-State: ABy/qLZ5RwpN9axvI1tFFgJD0nxNFshs+ANgQP/OhdFlmHvUxm5E0xvB
        684w95Ammfqeqf7r1WRawCpPhw==
X-Google-Smtp-Source: APBJJlEctDgwHsY+S2P2fswARZSXKXk3Zs/xgfXsJF16vV890y1gz4uktViIaSV118r4sHxFU5Z0xA==
X-Received: by 2002:a17:902:820a:b0:1b8:a720:f513 with SMTP id x10-20020a170902820a00b001b8a720f513mr310386pln.30.1688457091501;
        Tue, 04 Jul 2023 00:51:31 -0700 (PDT)
Received: from localhost ([2401:fa00:8f:203:a11b:bff7:d8ae:bb0])
        by smtp.gmail.com with UTF8SMTPSA id ix14-20020a170902f80e00b001b80b583092sm13758539plb.210.2023.07.04.00.51.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 04 Jul 2023 00:51:31 -0700 (PDT)
From:   David Stevens <stevensd@chromium.org>
X-Google-Original-From: David Stevens <stevensd@google.com>
To:     Sean Christopherson <seanjc@google.com>
Cc:     Marc Zyngier <maz@kernel.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Peter Xu <peterx@redhat.com>,
        linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev,
        linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        kvm@vger.kernel.org, David Stevens <stevensd@chromium.org>
Subject: [PATCH v7 0/8] KVM: allow mapping non-refcounted pages
Date:   Tue,  4 Jul 2023 16:50:45 +0900
Message-ID: <20230704075054.3344915-1-stevensd@google.com>
X-Mailer: git-send-email 2.41.0.255.g8b1d071c50-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: David Stevens <stevensd@chromium.org>

This patch series adds support for mapping VM_IO and VM_PFNMAP memory
that is backed by struct pages that aren't currently being refcounted
(e.g. tail pages of non-compound higher order allocations) into the
guest.

Our use case is virtio-gpu blob resources [1], which directly map host
graphics buffers into the guest as "vram" for the virtio-gpu device.
This feature currently does not work on systems using the amdgpu driver,
as that driver allocates non-compound higher order pages via
ttm_pool_alloc_page.

First, this series replaces the __gfn_to_pfn_memslot API with a more
extensible __kvm_faultin_pfn API. The updated API rearranges
__gfn_to_pfn_memslot's args into a struct and where possible packs the
bool arguments into a FOLL_ flags argument. The refactoring changes do
not change any behavior, except as noted in the PPC change.

When introduced in the refactoring, __kvm_faultin_pfn implies FOLL_GET
to preserve existing behavior. From there, the API is made to support
mapping non-refcounted pages by respecting the FOLL_GET flag.

This series only adds support for non-refcounted pages to the x86 MMU.
Other MMUs can likely be updated without too much difficulty, but it is
not needed at this point. Updating other parts of KVM (e.g. pfncache) is
not straightforward [2].

[1]
https://patchwork.kernel.org/project/dri-devel/cover/20200814024000.2485-1-gurchetansingh@chromium.org/
[2] https://lore.kernel.org/all/ZBEEQtmtNPaEqU1i@google.com/

v6 -> v7:
 - Replace __gfn_to_pfn_memslot with a more flexible __kvm_faultin_pfn,
   and extend that API to support non-refcounted pages.
v5 -> v6:
 - rebase on kvm next branch
 - rename gfn_to_pfn_page to gfn_to_pfn_noref
 - fix uninitialized outparam in error case of __kvm_faultin_pfn
 - add kvm_release_pfn_noref_clean for releasing pfn/page pair
v4 -> v5:
 - rebase on kvm next branch again
v3 -> v4:
 - rebase on kvm next branch again
 - Add some more context to a comment in ensure_pfn_ref
v2 -> v3:
 - rebase on kvm next branch
v1 -> v2:
 - Introduce new gfn_to_pfn_page functions instead of modifying the
   behavior of existing gfn_to_pfn functions, to make the change less
   invasive.
 - Drop changes to mmu_audit.c
 - Include Nicholas Piggin's patch to avoid corrupting refcount in the
   follow_pte case, and use it in depreciated gfn_to_pfn functions.
 - Rebase on kvm/next
David Stevens (7):
  KVM: Introduce __kvm_follow_pfn function
  KVM: Make __kvm_follow_pfn not imply FOLL_GET
  KVM: x86/mmu: Migrate to __kvm_follow_pfn
  KVM: x86/mmu: Don't pass FOLL_GET to __kvm_follow_pfn
  KVM: arm64: Migrate to __kvm_follow_pfn
  KVM: PPC: Migrate to __kvm_follow_pfn
  KVM: remove __gfn_to_pfn_memslot

Sean Christopherson (1):
  KVM: Assert that a page's refcount is elevated when marking
    accessed/dirty

 arch/arm64/kvm/mmu.c                   |  25 +--
 arch/powerpc/include/asm/kvm_book3s.h  |   2 +-
 arch/powerpc/kvm/book3s_64_mmu_hv.c    |  38 ++---
 arch/powerpc/kvm/book3s_64_mmu_radix.c |  50 +++---
 arch/powerpc/kvm/book3s_hv_nested.c    |   4 +-
 arch/x86/kvm/mmu/mmu.c                 |  77 ++++++---
 arch/x86/kvm/mmu/mmu_internal.h        |   1 +
 arch/x86/kvm/mmu/paging_tmpl.h         |   9 +-
 arch/x86/kvm/mmu/spte.c                |   4 +-
 arch/x86/kvm/mmu/spte.h                |  12 +-
 arch/x86/kvm/mmu/tdp_mmu.c             |  22 +--
 include/linux/kvm_host.h               |  26 +++
 virt/kvm/kvm_main.c                    | 210 +++++++++++++------------
 virt/kvm/kvm_mm.h                      |   3 +-
 virt/kvm/pfncache.c                    |   8 +-
 15 files changed, 282 insertions(+), 209 deletions(-)

-- 
2.41.0.255.g8b1d071c50-goog

