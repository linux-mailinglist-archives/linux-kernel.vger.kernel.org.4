Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 444466A104E
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Feb 2023 20:12:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231508AbjBWTMe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Feb 2023 14:12:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229801AbjBWTMa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Feb 2023 14:12:30 -0500
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91C0338029
        for <linux-kernel@vger.kernel.org>; Thu, 23 Feb 2023 11:12:02 -0800 (PST)
Received: by mail-wr1-x42a.google.com with SMTP id h14so2892919wru.4
        for <linux-kernel@vger.kernel.org>; Thu, 23 Feb 2023 11:12:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=XOS0veLLHWbwjK4eBBnp5I1m+3QaoysNm8QvFRgjkAM=;
        b=NoWOE1juav4B2EzO3sYoVjYk0WKOVpH+oBqfJvi8ziGJ5mMnDNe/17x0Nm8VQqmURH
         jY8DM7OfXqdvo5ko0NXGNMAlL5gcbkXkBJMqg8CCEhEKhV+mo7JGd5Eb2STH9IxN4NQ9
         Pj37RCtxE8VmbCkvm+ZXgra2t3hGXDanm1NNyyJo+1lOxO0RH89t5omOv3wUVU2rjXKX
         j/DjsDZcG+nlc2VAh72E4AKUTGT+o83suYwYv/0uOVFtpomc1sc4RlNxNBSZZCsUlQ9q
         6pdpGFhIkU3joQO/TUf35xtYje4X3s+Ld6DQfDWvGet+hI8aAcYpXOaKjPpcqUlbDxPF
         2viQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XOS0veLLHWbwjK4eBBnp5I1m+3QaoysNm8QvFRgjkAM=;
        b=0mxa5npxSReOW2KpY31pFTWQK96cw9VOSpOauiaoBqMekprYvU6dIL1q4F2ymjqRf1
         b9fiGpAFTJ0ASpAgXRY4hg0/vPfb2/X9mSZq5N/cRHaniSE5Kea6QE9E3r6VaDtfxpcm
         9lZE0Tso4pV6WK6CdKPv/JJxZy4s8mIB5Yryt/B3CyjiDOKadfmcX9E66GOEi84xVka2
         hNsXpMsm5pEXi0XL9txDwJUmXtrhanpCbjA9H70o1NWC+Ho/1A9gtdds71dJyU2tKT4V
         nlhrZYFPguT7nbFWd/Oi0xwNx6CxKWJ8BMh8cthgYmaQIzSipjl3Y3u+suHUiniCAz1s
         YTsQ==
X-Gm-Message-State: AO0yUKWR6kr9KfA2+LK/DDK5Ll3VMeJHnSKckWJ3B9RbDuTlnYrchYHl
        vpVsSTgFPupXQfBYKKZlbky8Vw==
X-Google-Smtp-Source: AK7set8v9uJ+aFQdjGSLkOj7taqgBaP0/g1nSEOHlxeNkTiapiOF09lwMSzf83LJfhH/le9sXkYJUQ==
X-Received: by 2002:a5d:6290:0:b0:2c7:1a86:aecd with SMTP id k16-20020a5d6290000000b002c71a86aecdmr532807wru.2.1677179503081;
        Thu, 23 Feb 2023 11:11:43 -0800 (PST)
Received: from usaari01.cust.communityfibre.co.uk ([2a02:6b6a:b566:0:5ee0:5af0:64bd:6198])
        by smtp.gmail.com with ESMTPSA id b15-20020a5d4b8f000000b002c561805a4csm12957286wrt.45.2023.02.23.11.11.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Feb 2023 11:11:42 -0800 (PST)
From:   Usama Arif <usama.arif@bytedance.com>
To:     dwmw2@infradead.org, tglx@linutronix.de, kim.phillips@amd.com,
        brgerst@gmail.com
Cc:     piotrgorski@cachyos.org, oleksandr@natalenko.name,
        arjan@linux.intel.com, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, hpa@zytor.com, x86@kernel.org,
        pbonzini@redhat.com, paulmck@kernel.org,
        linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        rcu@vger.kernel.org, mimoja@mimoja.de, hewenliang4@huawei.com,
        thomas.lendacky@amd.com, seanjc@google.com, pmenzel@molgen.mpg.de,
        fam.zheng@bytedance.com, punit.agrawal@bytedance.com,
        simon.evans@bytedance.com, liangma@liangbit.com,
        Usama Arif <usama.arif@bytedance.com>
Subject: [PATCH v11 00/12] Parallel CPU bringup for x86_64
Date:   Thu, 23 Feb 2023 19:11:28 +0000
Message-Id: <20230223191140.4155012-1-usama.arif@bytedance.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This version includes the work done by Brian Gerst
(https://lore.kernel.org/all/20230222221301.245890-1-brgerst@gmail.com/)
to remove the global variables initial_gs, initial_stack, and
early_gdt_descr from the 64-bit boot code.

The first 2 patches have been squashed with patch 6, while the last 4 patches
for removing the global variables and simplifying boot setup are added on top
of the series.
Thanks,
Usama

Changes across versions:
v2: Cut it back to just INIT/SIPI/SIPI in parallel for now, nothing more
v3: Clean up x2apic patch, add MTRR optimisation, lock topology update
    in preparation for more parallelisation.
v4: Fixes to the real mode parallelisation patch spotted by SeanC, to
    avoid scribbling on initial_gs in common_cpu_up(), and to allow all
    24 bits of the physical X2APIC ID to be used. That patch still needs
    a Signed-off-by from its original author, who once claimed not to
    remember writing it at all. But now we've fixed it, hopefully he'll
    admit it now :)
v5: rebase to v6.1 and remeasure performance, disable parallel bringup
    for AMD CPUs.
v6: rebase to v6.2-rc6, disabled parallel boot on amd as a cpu bug and
    reused timer calibration for secondary CPUs.
v7: [David Woodhouse] iterate over all possible CPUs to find any existing
    cluster mask in alloc_clustermask. (patch 1/9)
    Keep parallel AMD support enabled in AMD, using APIC ID in CPUID leaf
    0x0B (for x2APIC mode) or CPUID leaf 0x01 where 8 bits are sufficient.
    Included sanity checks for APIC id from 0x0B. (patch 6/9)
    Removed patch for reusing timer calibration for secondary CPUs.
    commit message and code improvements.
v8: Fix CPU0 hotplug by setting up the initial_gs, initial_stack and
    early_gdt_descr.
    Drop trampoline lock and bail if APIC ID not found in find_cpunr.
    Code comments improved and debug prints added.
v9: Drop patch to avoid repeated saves of MTRR at boot time.
    rebased and retested at v6.2-rc8.
    added kernel doc for no_parallel_bringup and made do_parallel_bringup
    __ro_after_init.
v10: Fixed suspend/resume not working with parallel smpboot.
     rebased and retested to 6.2.
     fixed checkpatch errors.
v11: Added patches from Brian Gerst to remove the global variables initial_gs,
     initial_stack, and early_gdt_descr from the 64-bit boot code
     (https://lore.kernel.org/all/20230222221301.245890-1-brgerst@gmail.com/).

Brian Gerst (4):
  x86/smpboot: Remove initial_stack on 64-bit
  x86/smpboot: Remove early_gdt_descr on 64-bit
  x86/smpboot: Remove initial_gs
  x86/smpboot: Simplify boot CPU setup

David Woodhouse (8):
  x86/apic/x2apic: Allow CPU cluster_mask to be populated in parallel
  cpu/hotplug: Move idle_thread_get() to <linux/smpboot.h>
  cpu/hotplug: Add dynamic parallel bringup states before
    CPUHP_BRINGUP_CPU
  x86/smpboot: Reference count on smpboot_setup_warm_reset_vector()
  x86/smpboot: Split up native_cpu_up into separate phases and document
    them
  x86/smpboot: Support parallel startup of secondary CPUs
  x86/smpboot: Send INIT/SIPI/SIPI to secondary CPUs in parallel
  x86/smpboot: Serialize topology updates for secondary bringup

 .../admin-guide/kernel-parameters.txt         |   3 +
 arch/x86/include/asm/processor.h              |   6 +-
 arch/x86/include/asm/realmode.h               |   4 +-
 arch/x86/include/asm/smp.h                    |  13 +-
 arch/x86/include/asm/topology.h               |   2 -
 arch/x86/kernel/acpi/sleep.c                  |  12 +-
 arch/x86/kernel/apic/apic.c                   |   2 +-
 arch/x86/kernel/apic/x2apic_cluster.c         | 126 ++++---
 arch/x86/kernel/asm-offsets.c                 |   1 +
 arch/x86/kernel/cpu/common.c                  |   6 +-
 arch/x86/kernel/head_64.S                     | 125 +++++--
 arch/x86/kernel/smpboot.c                     | 350 +++++++++++++-----
 arch/x86/realmode/init.c                      |   3 +
 arch/x86/realmode/rm/trampoline_64.S          |  14 +
 arch/x86/xen/smp_pv.c                         |   4 +-
 arch/x86/xen/xen-head.S                       |   2 +-
 include/linux/cpuhotplug.h                    |   2 +
 include/linux/smpboot.h                       |   7 +
 kernel/cpu.c                                  |  31 +-
 kernel/smpboot.h                              |   2 -
 20 files changed, 525 insertions(+), 190 deletions(-)

-- 
2.25.1

