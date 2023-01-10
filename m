Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8395F6646F0
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Jan 2023 18:04:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238786AbjAJREQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Jan 2023 12:04:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238679AbjAJREE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jan 2023 12:04:04 -0500
Received: from mail-pf1-x44a.google.com (mail-pf1-x44a.google.com [IPv6:2607:f8b0:4864:20::44a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C4F218E18
        for <linux-kernel@vger.kernel.org>; Tue, 10 Jan 2023 09:04:02 -0800 (PST)
Received: by mail-pf1-x44a.google.com with SMTP id dc11-20020a056a0035cb00b00589a6a97519so2466571pfb.8
        for <linux-kernel@vger.kernel.org>; Tue, 10 Jan 2023 09:04:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:mime-version:message-id:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=9ich1iVezuNu8uluYHiS8u02oY/MPLgCxDKersNmYNE=;
        b=p9p+1zFPB28l14+mwS3NvWMaACg+aecpV1UwwesL2QfHocdCvPs6k3tvZJRieh0uum
         nrACwtnAg1DjhjmZPbmjTgzJVT9K7FM6RxEkFIT1KrgDLquuyDZ4pko74qs0WDkofSjK
         Zkai6s32MyhpQekhgPYZs5jkWRlDmJaEGcpmKgvgGRO10m7ZAh46wBNtYSoH53mQY8tS
         831x5gC3WWsRzXXbeOzIntJUMuWSbMTYatrhSy2NNtruzRmY/h4VGgdo/T5bdnShLAuD
         RWBgrZLxpbwPnMsaeslltVEloeBVYNDZ+euhMzxV5tzPw1A5DxCkwaGLYCMQpm/9coVU
         lPyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:mime-version:message-id:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=9ich1iVezuNu8uluYHiS8u02oY/MPLgCxDKersNmYNE=;
        b=yjU1LdEZvsCD0dLK26bOlAVCTgfKtFYhdx3VfgF5+bKp+KrpGQskNKmAUx6gZmxfwP
         qS/CYBxRNNfsz4tKhid+cySpPLwZLsLbADTFQ6P+hFORbwKiDIfiTVypCHbH3E+1HDAl
         uBeGeeT0yNJFJ6YDxb7tibKDLdzys+aFx5Vuts5ILQqfYY1U66eb/VHqNCFAdKm/jlTO
         TdO1joT5AK+SgPOUABqPaxjRVof991ETwxZ7o2MmE2ff1XhQaIxxCrcQ49gTig9BaTEN
         28lzAf+Lvfe+oC6ZfuboXVGDEZopXOx6hnd33/0Kkfy+I+3DispMrCINJEDdTr3qWFSs
         P/OQ==
X-Gm-Message-State: AFqh2krnOiSrNY95CUKn/XWEgL2L22b5iKAzqlV6qJ1sb2W2Nuk+plBK
        NsCosj1SoGzgE+NgIeqSo+tcahmslXI=
X-Google-Smtp-Source: AMrXdXvxWxEzhLKqzOCYZP/aYcoUD3gssPT0roagdfGDUN6PufKDYiJCLYWwA1oTmd/D2owo3RZuVSarkWM=
X-Received: from pgonda1.kir.corp.google.com ([2620:0:1008:11:8358:4c2a:eae1:4752])
 (user=pgonda job=sendgmr) by 2002:aa7:90d9:0:b0:578:7983:9391 with SMTP id
 k25-20020aa790d9000000b0057879839391mr5265795pfk.41.1673370241528; Tue, 10
 Jan 2023 09:04:01 -0800 (PST)
Date:   Tue, 10 Jan 2023 09:03:51 -0800
Message-Id: <20230110170358.633793-1-pgonda@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.39.0.314.g84b9a713c41-goog
Subject: [PATCH V6 0/7] KVM: selftests: Add simple SEV test
From:   Peter Gonda <pgonda@google.com>
To:     kvm@vger.kernel.org
Cc:     Peter Gonda <pgonda@google.com>, linux-kernel@vger.kernel.org,
        marcorr@google.com, seanjc@google.com, michael.roth@amd.com,
        thomas.lendacky@amd.com, joro@8bytes.org, pbonzini@redhat.com,
        andrew.jones@linux.dev, vannapurve@google.com,
        Ackerly Tng <ackerleytng@google.com>
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

V6
 * Updated SEV VM create function based on Seanjc's feedback and new
   changes to VM creation functions.
 * Removed pte_me_mask based on feedback.
 * Fixed s_bit usage based on TDX
 * Fixed bugs and took Ackerly's code for enc_region setup code.

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

Cc: kvm@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Cc: marcorr@google.com
Cc: seanjc@google.com
Cc: michael.roth@amd.com
Cc: thomas.lendacky@amd.com
Cc: joro@8bytes.org
Cc: pbonzini@redhat.com
Cc: andrew.jones@linux.dev
Cc: vannapurve@google.com
Cc: Ackerly Tng <ackerleytng@google.com>

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
 tools/arch/x86/include/asm/kvm_host.h         |  14 +
 tools/testing/selftests/kvm/.gitignore        |  84 ++++++
 tools/testing/selftests/kvm/Makefile          |   4 +-
 .../selftests/kvm/include/kvm_util_base.h     |  49 +++-
 .../testing/selftests/kvm/include/sparsebit.h |  36 +--
 .../selftests/kvm/include/x86_64/processor.h  |   1 +
 .../selftests/kvm/include/x86_64/sev.h        |  27 ++
 tools/testing/selftests/kvm/lib/kvm_util.c    |  66 ++++-
 tools/testing/selftests/kvm/lib/sparsebit.c   |  48 ++--
 .../testing/selftests/kvm/lib/ucall_common.c  |   2 +-
 .../selftests/kvm/lib/x86_64/processor.c      |  62 ++++-
 tools/testing/selftests/kvm/lib/x86_64/sev.c  | 254 ++++++++++++++++++
 .../selftests/kvm/x86_64/sev_all_boot_test.c  |  84 ++++++
 16 files changed, 685 insertions(+), 67 deletions(-)
 create mode 100644 tools/arch/arm64/include/asm/kvm_host.h
 create mode 100644 tools/arch/riscv/include/asm/kvm_host.h
 create mode 100644 tools/arch/s390/include/asm/kvm_host.h
 create mode 100644 tools/arch/x86/include/asm/kvm_host.h
 create mode 100644 tools/testing/selftests/kvm/include/x86_64/sev.h
 create mode 100644 tools/testing/selftests/kvm/lib/x86_64/sev.c
 create mode 100644 tools/testing/selftests/kvm/x86_64/sev_all_boot_test.c

-- 
2.39.0.314.g84b9a713c41-goog

