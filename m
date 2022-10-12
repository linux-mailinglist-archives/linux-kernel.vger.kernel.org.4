Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F6BD5FCA5F
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Oct 2022 20:17:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229777AbiJLSR0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Oct 2022 14:17:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229754AbiJLSRW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Oct 2022 14:17:22 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F40D64D174
        for <linux-kernel@vger.kernel.org>; Wed, 12 Oct 2022 11:17:08 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id g15-20020a25af8f000000b006bcad4bf46aso16756583ybh.19
        for <linux-kernel@vger.kernel.org>; Wed, 12 Oct 2022 11:17:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:mime-version:date:reply-to:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8z/N7rajPM5bDbkRc7ux+RB4h16QzYAJS8fnP1UPndE=;
        b=M/huj/nHRTShArCrudhJ7iG+SfM8N0CLPP7gdjYfeC3hoJLIqKIua/Mtb9p984G0jg
         kXvLGi1REkmVhvv+KDBdFg3pz7ILz+gWJkrCVS8Umc8koGm8s7jodek4b84Xa6qBVhXf
         d7rIf7DKQnCcvym1eIgAypVrehMRrMzoLAZgUzHfblBX3ZF3r8Do2tnaclV8zanwV5Az
         voFmthDUQHR1wv42I9Mc1soUJW6UrrPU+reuMjZVDu7AUC3yENb1SXXxISreFD87AiBA
         PisiXE9tfW7yPL86qpYBltsKCPseYrKbTXEgSM1BxTQ4HwheT5jc+zl7kSxEy93UjsLk
         zpBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:mime-version:date:reply-to
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8z/N7rajPM5bDbkRc7ux+RB4h16QzYAJS8fnP1UPndE=;
        b=YUOoR7lpBO28zzGhlFtpUoKexxCZhmkcIAp/UqueUUNTRdYcFlOOjWSOaTb7Gq5703
         IdYsTPlfjy1Hk31UQanEiQITFc/ecGEAbyZNsRHrPXx+Q9I5bymL1bIHEhMbPa9AyaPt
         szya5syfdnikv9O5549HuiwMifh0fK/5YxpadgTrEjl3/wByBXvG1pu7+BV9eRJZ8dOb
         E2XlbTAcQb549qR3h0H6o9VMY8AG/y6HQyyyV6rm1sCoDPPnjQzBHavXHN38zgKTahu+
         YyJCblmTIxSl9OESwZLucUuI4yCALmQta2xnptPNBWcbp3qJReX10i4F02hofivef20O
         NWbQ==
X-Gm-Message-State: ACrzQf1gDjWNcm20YmG0hT13aoJwgeHeM4N0DeE/RYLC7oU+Cc6WtyE9
        4ToboFwPtlgdRk25vENmxVb3q4RhXus=
X-Google-Smtp-Source: AMsMyM7PHmAGWW8xmkb9zmUhh7qx+uzrZL2OJC5GLZzb/QSCLd/oiR+K3itria64T/zEE3HJaSwPk38Uo0c=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a5b:443:0:b0:6bc:e3d1:8990 with SMTP id
 s3-20020a5b0443000000b006bce3d18990mr30993521ybp.191.1665598627584; Wed, 12
 Oct 2022 11:17:07 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date:   Wed, 12 Oct 2022 18:16:51 +0000
Mime-Version: 1.0
X-Mailer: git-send-email 2.38.0.rc1.362.ged0d419d3c-goog
Message-ID: <20221012181702.3663607-1-seanjc@google.com>
Subject: [PATCH v4 00/11] KVM: x86/mmu: Make tdp_mmu a read-only parameter
From:   Sean Christopherson <seanjc@google.com>
To:     Sean Christopherson <seanjc@google.com>,
        Paolo Bonzini <pbonzini@redhat.com>
Cc:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        David Matlack <dmatlack@google.com>,
        Isaku Yamahata <isaku.yamahata@intel.com>
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

This is a variation of David's series to change tdp_mmu to a RO param[*].
The key difference is that instead of moving the TDP MMU page fault handler
to its own function, use static branches to make TDP MMU page faults (and
a few other paths) effectively branch free.

I'm not dead set against having a dedicated TDP MMU page fault handler, but
IMO it's not really better once the TDP MMU vs. shadow MMU is reduced to a
static branch, just different.  The read vs. write mmu_lock is the most
visible ugliness, and that can be buried in helpers if we really want to
make the page fault handler easier on the eyes, e.g.

	direct_page_fault_mmu_lock(vcpu);

	if (is_page_fault_stale(vcpu, fault))
		goto out_unlock;

	if (is_tdp_mmu_enabled()) {
		r = kvm_tdp_mmu_map(vcpu, fault);
	} else {
		r = make_mmu_pages_available(vcpu);
		if (r)
			goto out_unlock;

		r = __direct_map(vcpu, fault);
	}

out_unlock:
	direct_page_fault_mmu_unlock(vcpu);

v4:
  - Keep is_tdp_mmu_page() in patch 1.
  - Collect reviews. [Isaku]
  - Skip "make MMU pages available" for root allocations.
  - Rework "is TDP MMU" checks to take advantage of read-only param.
  - Use a static key to track TDP MMU enabling.

[*] https://lkml.kernel.org/r/20220921173546.2674386-1-dmatlack@google.com

David Matlack (7):
  KVM: x86/mmu: Change tdp_mmu to a read-only parameter
  KVM: x86/mmu: Move TDP MMU VM init/uninit behind tdp_mmu_enabled
  KVM: x86/mmu: Grab mmu_invalidate_seq in kvm_faultin_pfn()
  KVM: x86/mmu: Handle error PFNs in kvm_faultin_pfn()
  KVM: x86/mmu: Avoid memslot lookup during KVM_PFN_ERR_HWPOISON
    handling
  KVM: x86/mmu: Handle no-slot faults in kvm_faultin_pfn()
  KVM: x86/mmu: Stop needlessly making MMU pages available for TDP MMU

Sean Christopherson (4):
  KVM: x86/mmu: Pivot on "TDP MMU enabled" when handling direct page
    faults
  KVM: x86/mmu: Pivot on "TDP MMU enabled" to check if active MMU is TDP
    MMU
  KVM: x86/mmu: Replace open coded usage of tdp_mmu_page with
    is_tdp_mmu_page()
  KVM: x86/mmu: Use static key/branches for checking if TDP MMU is
    enabled

 arch/x86/include/asm/kvm_host.h |   9 --
 arch/x86/kvm/mmu.h              |  14 ++-
 arch/x86/kvm/mmu/mmu.c          | 212 ++++++++++++++++++++------------
 arch/x86/kvm/mmu/mmu_internal.h |   1 +
 arch/x86/kvm/mmu/paging_tmpl.h  |  12 +-
 arch/x86/kvm/mmu/tdp_mmu.c      |  13 +-
 arch/x86/kvm/mmu/tdp_mmu.h      |  25 +---
 7 files changed, 149 insertions(+), 137 deletions(-)


base-commit: e18d6152ff0f41b7f01f9817372022df04e0d354
-- 
2.38.0.rc1.362.ged0d419d3c-goog

