Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 82C9E68D34C
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Feb 2023 10:56:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231698AbjBGJ4c (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Feb 2023 04:56:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231143AbjBGJ4a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Feb 2023 04:56:30 -0500
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E42D3EC67
        for <linux-kernel@vger.kernel.org>; Tue,  7 Feb 2023 01:56:28 -0800 (PST)
Received: by mail-pl1-x632.google.com with SMTP id i2so1697217ple.13
        for <linux-kernel@vger.kernel.org>; Tue, 07 Feb 2023 01:56:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=SG8X6lulctZRcn7Z3WZzCy2y8oVKu+FXkngsEcj8kcI=;
        b=U8fCgEaEcom7Oh7JVPHoN8FvbggNelySldt/OPyxnGXrbeVrQVPS56AFSDIc4/eXAW
         CmTfrWpxU2kBiYrYeR0dMG2xQDgRC7QmD1Yzzy2hri8K09w6zZ1C0/je2YfqE/sjF1mC
         fOm2uILHde3qVUY2gWmr+SXTecggUrYYlFOGg8eF4Vvv0xe7q8O5pnuP6z85fwwmk+m+
         3/cuEafb0j0/+Er9/uHSNLwuJwEHFy0MZOcYzZ9f/pkJhkV/8ULqCPlFdU98/z7abLLV
         KSpnTT7hwOKVh9WzmmXi03sWEuDIz3ftscD1TXw6jRvQp37p8tn+BsQKsf3/9f5ysTcK
         YS1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SG8X6lulctZRcn7Z3WZzCy2y8oVKu+FXkngsEcj8kcI=;
        b=jj4n2Cxvj4gC9jg3KKtlvW1sFxVgZoGq0saeZOLOQoXgT44sXNGIVux+e0J13tmvzB
         MiTHrBW+4PBtRHuUKRrnpe0My4TqT+a+bn5g5Jbx5fEoZEZZ4MXuZBfX9lChMKxB5bl7
         TiTaz+zCHYj+UXsccr5hBX2jiUWtsOiSX70F0EKyL63zQPq9dt2+08Hs6S7HcQwNLM1R
         aWYPnuAiO9OWlQ2iLWQsDC5KAd3MWnf0bcDo5eERahqTE09bDGz6VNAZ9dKaCnkx+N0A
         H+rS/slE6hCaH7iQorCdyLqFvZ3rSLN20SlyeZVy1plGrFdfpL5dU/lrISOzUVowaQLW
         YyZg==
X-Gm-Message-State: AO0yUKVv4P46o2uY772lANkVgl7yQWNocOcEJ8hUR0Eenm7sZGLa29BC
        RNMxuw14+NkXSqlIue6HsUJK9K7iOFvJYb+I
X-Google-Smtp-Source: AK7set/QvmGlsS0iMTnkpkDrBaVQ36UY4PtdpTaoN5m14ykycniCiV35zYMVBsbzVHoCp28pqr5hiw==
X-Received: by 2002:a17:902:f791:b0:198:adc4:22a5 with SMTP id q17-20020a170902f79100b00198adc422a5mr13464632pln.32.1675763788266;
        Tue, 07 Feb 2023 01:56:28 -0800 (PST)
Received: from atishp.ba.rivosinc.com ([66.220.2.162])
        by smtp.gmail.com with ESMTPSA id w8-20020a1709027b8800b0019602b2c00csm4030598pll.175.2023.02.07.01.56.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Feb 2023 01:56:27 -0800 (PST)
From:   Atish Patra <atishp@rivosinc.com>
To:     linux-kernel@vger.kernel.org
Cc:     Atish Patra <atishp@rivosinc.com>,
        Andrew Jones <ajones@ventanamicro.com>,
        Anup Patel <anup@brainfault.org>,
        Atish Patra <atishp@atishpatra.org>,
        kvm-riscv@lists.infradead.org, kvm@vger.kernel.org,
        linux-riscv@lists.infradead.org,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>
Subject: [PATCH v6 0/8] KVM perf support 
Date:   Tue,  7 Feb 2023 01:55:21 -0800
Message-Id: <20230207095529.1787260-1-atishp@rivosinc.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series extends perf support for KVM. The KVM implementation relies
on the SBI PMU extension and trap n emulation of hpmcounter CSRs.
The KVM implementation exposes the virtual counters to the guest and internally
manage the counters using kernel perf counters. 

This series doesn't support the counter overflow as the Sscofpmf extension
doesn't allow trap & emulation mechanism of scountovf CSR yet. The required
changes to allow that are being under discussions. Supporting overflow interrupt
also requires AIA interrupt filtering support.

perf stat works in kvm guests with this series. 

Here is example of running perf stat in a guest running in KVM.

===========================================================================
/ # /host/apps/perf stat -e instructions -e cycles -e r8000000000000005 \
> -e r8000000000000006 -e r8000000000000007 -e r8000000000000008 \
> -e r800000000000000a perf bench sched messaging -g 10 -l 10

# Running 'sched/messaging' benchmark:
# 20 sender and receiver processes per group
# 10 groups == 400 processes run

     Total time: 7.769 [sec]
                 
 Performance counter stats for 'perf bench sched messaging -g 10 -l 10':

       73556259604      cycles
       73387266056      instructions              #    1.00  insn per cycle
                 0      dTLB-store-misses
                 0      iTLB-load-misses
                 0      r8000000000000005
              2595      r8000000000000006
              2272      r8000000000000007
                10      r8000000000000008
                 0      r800000000000000a

      12.173720400 seconds time elapsed

       1.002716000 seconds user
      21.931047000 seconds sys


Note: The SBI_PMU_FW_SET_TIMER (eventid : r8000000000000005) is zero
as kvm guest supports sstc now. 

This series can be found here as well.
https://github.com/atishp04/linux/tree/kvm_perf_v6

TODO:
1. Add sscofpmf support.
2. Add One reg interface for the following operations:
	1. Enable/Disable PMU (should it at VM level rather than vcpu ?)
	2. Number of hpmcounter and width of the counters
	3. Init PMU
	4. Allow guest user to access cycle & instret without trapping
3. Move counter mask to a bitmask instead of unsigned long so that it can work
   for RV32 systems where number of total counters are more than 32.
   This will also accomodate future systems which may define maximum counters
   to be more than 64. 

Changes from v5->v6:
1. Addressed remainig RB tags.
2. Rebased on kvm-queue which already has merged first 6 patches from v5.
3. Added static time compilation checks for max counters.
4. Addressed other nit comments.

Changes from v4->v5:
1. Few checkpatch --strict error fixes.
2. Some other minor nit comment addressed.
3. Fixed an issue around counter indexing.

Changes from v3->v4:
1. Addressed all the comments on v3.
2. Modified the vcpu_pmu_init to void return type.
3. Redirect illegal instruction trap to guest for invalid hpmcounter access
   instead of exiting to the userpsace.
4. Got rid of unecessary error messages.

Changes v2->v3:
1. Changed the exported functions to GPL only export.
2. Addressed all the nit comments on v2.
3. Split non-kvm related changes into separate patches.
4. Reorgainze the PATCH 11 and 10 based on Drew's suggestions.

Changes from v1->v2:
1. Addressed comments from Andrew.
2. Removed kvpmu sanity check.
3. Added a kvm pmu init flag and the sanity check to probe function.
4. Improved the linux vs sbi error code handling.
 

Atish Patra (8):
RISC-V: KVM: Add skeleton support for perf
RISC-V: KVM: Add SBI PMU extension support
RISC-V: KVM: Make PMU functionality depend on Sscofpmf
RISC-V: KVM: Disable all hpmcounter access for VS/VU mode
RISC-V: KVM: Implement trap & emulate for hpmcounters
RISC-V: KVM: Implement perf support without sampling
RISC-V: KVM: Support firmware events
RISC-V: KVM: Increment firmware pmu events

arch/riscv/include/asm/kvm_host.h     |   4 +
arch/riscv/include/asm/kvm_vcpu_pmu.h | 108 +++++
arch/riscv/kvm/Makefile               |   1 +
arch/riscv/kvm/main.c                 |   3 +-
arch/riscv/kvm/tlb.c                  |   4 +
arch/riscv/kvm/vcpu.c                 |   7 +
arch/riscv/kvm/vcpu_insn.c            |   4 +-
arch/riscv/kvm/vcpu_pmu.c             | 630 ++++++++++++++++++++++++++
arch/riscv/kvm/vcpu_sbi.c             |  11 +
arch/riscv/kvm/vcpu_sbi_pmu.c         |  86 ++++
arch/riscv/kvm/vcpu_sbi_replace.c     |   7 +
11 files changed, 863 insertions(+), 2 deletions(-)
create mode 100644 arch/riscv/include/asm/kvm_vcpu_pmu.h
create mode 100644 arch/riscv/kvm/vcpu_pmu.c
create mode 100644 arch/riscv/kvm/vcpu_sbi_pmu.c

--
2.25.1

