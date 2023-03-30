Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D56B6CFF49
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Mar 2023 10:58:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229540AbjC3I6O (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Mar 2023 04:58:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229491AbjC3I6M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Mar 2023 04:58:12 -0400
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 050CE2717
        for <linux-kernel@vger.kernel.org>; Thu, 30 Mar 2023 01:58:11 -0700 (PDT)
Received: by mail-pl1-x634.google.com with SMTP id c18so17442363ple.11
        for <linux-kernel@vger.kernel.org>; Thu, 30 Mar 2023 01:58:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1680166690;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=khZuI90C3yICc2QlVMZxoINj4hbBwgvv4lkvCwQn0oM=;
        b=EXT9oCu6maH6hdfTnR/yspZUXl4VC9pYBcFM28HOWhVhVGfjKr06H97hxY5NEcXDVy
         O6AYwjuUW+eoRs3XHt58Vt+g8j0rm222Dq96fo5vNQMf/niag4j/MHyFyVmXmvni74E6
         /YSWF5zCloCKf2Ewpv0BTU/CsQe8NgLXcgDAc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680166690;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=khZuI90C3yICc2QlVMZxoINj4hbBwgvv4lkvCwQn0oM=;
        b=vAnJHbKpguaz01eJmBpfUEkEUXlrKK/3VU6HKFlw4po/yl7zGvaGv741uaXmfnBKdG
         zDNvwaqYNL3ppr95PuYm64DxvtdZHXN0f7j+Qny315QGdn7Yo5OGMV+zvF1ZFSL+KC/3
         Rlk2zHVYy8b98x0uG/emSmvm+qGRVSOrOjwD106cLdUkHitqwwnb5DwW4WS9q11qvDEW
         1ppwlPa89DOiNpp00GnRFF4Erpl9MU1Texf7FfWOlE7k7fflXUTrsVrIqFTwFBfKHLL1
         ktR2iGhCZxq9urqiJxMCW+F89P6N0SUrFKB3D5ZB72AQmyQTUK3PrR/RzU2xF3UbuQbv
         cLdQ==
X-Gm-Message-State: AAQBX9ctsWODWsZ8LdVnipqHTvGF99LSpBP047+RfaF9Ow6T2ZnAeHXz
        jHFWNpCLKgaQXw6Jm/PenNhFGRmBUUVXIU/6qhs=
X-Google-Smtp-Source: AKy350ZDrTpkuW3KLUjaRcClMpQ+xS+Gsu2ak5nMpigAHapulHNWYWEUZil+IM2Hxt1/98K3/CNwAQ==
X-Received: by 2002:a17:903:11ce:b0:1a1:da3c:6065 with SMTP id q14-20020a17090311ce00b001a1da3c6065mr28208585plh.22.1680166690463;
        Thu, 30 Mar 2023 01:58:10 -0700 (PDT)
Received: from localhost ([2401:fa00:8f:203:1320:eef8:d0bb:b161])
        by smtp.gmail.com with UTF8SMTPSA id bj4-20020a170902850400b001a076568da9sm7239405plb.216.2023.03.30.01.58.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 30 Mar 2023 01:58:09 -0700 (PDT)
From:   David Stevens <stevensd@chromium.org>
X-Google-Original-From: David Stevens <stevensd@google.com>
To:     Marc Zyngier <maz@kernel.org>,
        Sean Christopherson <seanjc@google.com>
Cc:     Oliver Upton <oliver.upton@linux.dev>,
        Paolo Bonzini <pbonzini@redhat.com>,
        linux-arm-kernel@lists.infradead.org, kvmarm@lists.cs.columbia.edu,
        linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        David Stevens <stevensd@chromium.org>
Subject: [PATCH v6 0/4] KVM: allow mapping non-refcounted pages
Date:   Thu, 30 Mar 2023 17:57:58 +0900
Message-Id: <20230330085802.2414466-1-stevensd@google.com>
X-Mailer: git-send-email 2.40.0.348.gf938b09366-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
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

Currently, the gfn_to_pfn functions require being able to pin the target
pfn, so they fail when the pfn returned by follow_pte isn't a
ref-counted page. However, the KVM secondary MMUs do not require that
the pfn be pinned, since they are integrated with the mmu notifier API.
This series adds a new set of gfn_to_pfn_noref functions which parallel
the gfn_to_pfn functions but do not pin the pfn. The new functions
return the page from gup if it was present, so callers can use it and
call put_page when done.

This series updates x86 and arm64 secondary MMUs to the new API. Other
MMUs can likely be updated without too much difficulty, but I am not
familiar with them and have no way to test them. On the other hand,
updating the rest of KVM would require replacing all usages of
kvm_vcpu_map with the gfn_to_pfn_cache, which is not at all easy [2].

[1]
https://patchwork.kernel.org/project/dri-devel/cover/20200814024000.2485-1-gurchetansingh@chromium.org/
[2] https://lore.kernel.org/all/ZBEEQtmtNPaEqU1i@google.com/

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

David Stevens (4):
  KVM: mmu: introduce new gfn_to_pfn_noref functions
  KVM: x86/mmu: use gfn_to_pfn_noref
  KVM: arm64/mmu: use gfn_to_pfn_noref
  KVM: mmu: remove over-aggressive warnings

 arch/arm64/kvm/mmu.c            |  21 ++--
 arch/x86/kvm/mmu/mmu.c          |  29 ++---
 arch/x86/kvm/mmu/mmu_internal.h |   1 +
 arch/x86/kvm/mmu/paging_tmpl.h  |   7 +-
 arch/x86/kvm/x86.c              |   5 +-
 include/linux/kvm_host.h        |  18 +++
 virt/kvm/kvm_main.c             | 214 +++++++++++++++++++++++---------
 virt/kvm/kvm_mm.h               |   6 +-
 virt/kvm/pfncache.c             |  12 +-
 9 files changed, 220 insertions(+), 93 deletions(-)

-- 
2.40.0.348.gf938b09366-goog

