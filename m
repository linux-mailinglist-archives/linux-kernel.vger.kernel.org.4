Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D8694603476
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Oct 2022 22:59:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230159AbiJRU7B (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Oct 2022 16:59:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230120AbiJRU6y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Oct 2022 16:58:54 -0400
Received: from mail-pj1-x1049.google.com (mail-pj1-x1049.google.com [IPv6:2607:f8b0:4864:20::1049])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12BCEC06B4
        for <linux-kernel@vger.kernel.org>; Tue, 18 Oct 2022 13:58:54 -0700 (PDT)
Received: by mail-pj1-x1049.google.com with SMTP id oo18-20020a17090b1c9200b0020bdba475afso12425395pjb.4
        for <linux-kernel@vger.kernel.org>; Tue, 18 Oct 2022 13:58:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:mime-version:message-id:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=kNWqE5oSMNPl31vBAcUWs8MhWMZMoIHwD5R3GLMR2V0=;
        b=hEeVUXOJOaLsXfMd/B8oSQem2Uqa5PAmxofPXcAc6ncC5A2cPCq2RpbiWUpnrzE2dM
         IxY/39pKh+rYwNtrxWuVFLeNrVPoLsvR4qTNSqp2e8OicqxEWfIfcmcwOPqM85lGy2n1
         rd1QXbr2sFNOX7xEcxr3KCm9J7FdAQa9VBUMdscdlm4VV9+4JX604NonlFX1Dousawxc
         npbW52yWoOS4+ckENf/T/25av9DZFlh9H3jkAkltz9b6IqEiVWAw0kgDBHCuug5pqTUV
         2cmaJ7XHSPfSQvHeDR5/WXlOjvjF40cs8ThZEwsYyvWdwoe8bt7pGADICYiiN5Dh0p64
         hPyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:mime-version:message-id:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=kNWqE5oSMNPl31vBAcUWs8MhWMZMoIHwD5R3GLMR2V0=;
        b=W5qUdNlut51FZRkMpxb8qZjt2azffEdcpYRSYX/hSRPKWA7k/3UX5kjYe+3pqM2o67
         KExLb1hZpOPCWf5w5ImLK7e2XhiWiTn9nkto28voht1lrA+a1VbP3HnQ37WP1OjTQ11a
         NvMConX4egCw9NpvxsT0Ipb0Hi89Iuvp4FwL5WTZFircfEKLrM9csDWTD0V1kA5JXTdF
         IGYMaJD6sDHutTKAmxZwks9b+pymekgCXerpj9SrMEDMzywV0OZW09NvK2x5AfmRseBF
         VC2TtGW6AVhw2wSORU4v6Kkllgwu7JTwId8jdRIeqFE9LmyGXqG88/0tmlYCuAxvCf6r
         9QGA==
X-Gm-Message-State: ACrzQf1CoxXTQrOxZzR+TJ7sdHhX4h++eOXTsbsierrGYyL9ncLvloFG
        fjd6X2v0ZClXzpJFBS8OSM6M6SB6aYg=
X-Google-Smtp-Source: AMsMyM7w2XKJKW1SsCbY9NUbjWlBQowiLQp6HtyyW9RNXzoQOfhtvEjx3ztQ5J/XNm4QDj79VvUbqdhDqu4=
X-Received: from pgonda1.kir.corp.google.com ([2620:15c:29:203:c89b:7f49:3437:9db8])
 (user=pgonda job=sendgmr) by 2002:a17:902:e80b:b0:183:7463:f628 with SMTP id
 u11-20020a170902e80b00b001837463f628mr5039102plg.19.1666126733578; Tue, 18
 Oct 2022 13:58:53 -0700 (PDT)
Date:   Tue, 18 Oct 2022 13:58:38 -0700
Message-Id: <20221018205845.770121-1-pgonda@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.38.0.413.g74048e4d9e-goog
Subject: [PATCH V5 0/7] KVM: selftests: Add simple SEV test
From:   Peter Gonda <pgonda@google.com>
To:     kvm@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, marcorr@google.com,
        seanjc@google.com, michael.roth@amd.com, thomas.lendacky@amd.com,
        joro@8bytes.org, mizhang@google.com, pbonzini@redhat.com,
        andrew.jones@linux.dev, pgonda@google.com, vannapurve@google.com
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

This patch series continues the work Michael Roth has done in supporting
SEV guests in selftests. It continues on top of the work Sean
Christopherson has sent to support ucalls from SEV guests. Along with a
very simple version of the SEV selftests Michael originally proposed.

V5
 * Rebase onto seanjc@'s latest ucall pool series.
 * More review changes based on seanjc:
 ** use protected instead of encrypted outside of SEV specific files
 ** Swap memcrypt struct for kvm_vm_arch arch specific struct
 ** Make protected page table data agnostic of address bit stealing specifics
    of SEV
 ** Further clean up for SEV library to just vm_sev_create_one_vcpu()
 * Due to large changes moved more authorships from mroth@ to pgonda@. Gave 
   originally-by tags to mroth@ as suggested by Seanjc for this.

V4
 * Rebase ontop of seanjc@'s latest Ucall Pool series:
   https://lore.kernel.org/linux-arm-kernel/20220825232522.3997340-8-seanjc@google.com/
 * Fix up review comments from seanjc
 * Switch authorship on 2 patches because of significant changes, added
 * Michael as suggested-by or originally-by.

V3
 * Addressed more of andrew.jones@ in ucall patches.
 * Fix build in non-x86 archs.

V2
 * Dropped RFC tag
 * Correctly separated Sean's ucall patches into 2 as originally
   intended.
 * Addressed andrew.jones@ in ucall patches.
 * Fixed ucall pool usage to work for other archs

V1
 * https://lore.kernel.org/all/20220715192956.1873315-1-pgonda@google.com/

Michael Roth (2):
  KVM: selftests: sparsebit: add const where appropriate
  KVM: selftests: add support for protected vm_vaddr_* allocations

Peter Gonda (5):
  KVM: selftests: add hooks for managing protected guest memory
  KVM: selftests: handle protected bits in page tables
  KVM: selftests: add library for creating/interacting with SEV guests
  KVM: selftests: Update ucall pool to allocate from shared memory
  KVM: selftests: Add simple sev vm testing

 tools/arch/arm64/include/asm/kvm_host.h       |   7 +
 tools/arch/riscv/include/asm/kvm_host.h       |   7 +
 tools/arch/s390/include/asm/kvm_host.h        |   7 +
 tools/arch/x86/include/asm/kvm_host.h         |  15 ++
 tools/testing/selftests/kvm/.gitignore        |   1 +
 tools/testing/selftests/kvm/Makefile          |   2 +
 .../selftests/kvm/include/kvm_util_base.h     |  49 +++-
 .../testing/selftests/kvm/include/sparsebit.h |  36 +--
 .../selftests/kvm/include/x86_64/sev.h        |  22 ++
 tools/testing/selftests/kvm/lib/kvm_util.c    |  63 ++++-
 tools/testing/selftests/kvm/lib/sparsebit.c   |  48 ++--
 .../testing/selftests/kvm/lib/ucall_common.c  |   2 +-
 .../selftests/kvm/lib/x86_64/processor.c      |  23 +-
 tools/testing/selftests/kvm/lib/x86_64/sev.c  | 243 ++++++++++++++++++
 .../selftests/kvm/x86_64/sev_all_boot_test.c  |  84 ++++++
 15 files changed, 549 insertions(+), 60 deletions(-)
 create mode 100644 tools/arch/arm64/include/asm/kvm_host.h
 create mode 100644 tools/arch/riscv/include/asm/kvm_host.h
 create mode 100644 tools/arch/s390/include/asm/kvm_host.h
 create mode 100644 tools/arch/x86/include/asm/kvm_host.h
 create mode 100644 tools/testing/selftests/kvm/include/x86_64/sev.h
 create mode 100644 tools/testing/selftests/kvm/lib/x86_64/sev.c
 create mode 100644 tools/testing/selftests/kvm/x86_64/sev_all_boot_test.c

-- 
2.38.0.413.g74048e4d9e-goog

