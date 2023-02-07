Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 907BE68E424
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Feb 2023 00:05:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229994AbjBGXFF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Feb 2023 18:05:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229868AbjBGXFC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Feb 2023 18:05:02 -0500
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D01203A5B9
        for <linux-kernel@vger.kernel.org>; Tue,  7 Feb 2023 15:04:41 -0800 (PST)
Received: by mail-wm1-x329.google.com with SMTP id m16-20020a05600c3b1000b003dc4050c94aso196728wms.4
        for <linux-kernel@vger.kernel.org>; Tue, 07 Feb 2023 15:04:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=7K90Cconf9IU/JjGhL3usnB4fcgEN7IGa/N6vi83tEU=;
        b=z706X9RPRqgrkCmt0yKUhE1L13f0JWFGtZsjk6h4QI2Mv+QHJqo22MYv34CjWHftK4
         oAJGajJuv3Q00OnN6Fn/ZCWTmO8GtjcrerCMBnkvi1zFZXC/wwNColrF9kW6jcNe7EeX
         V56u1UwIuBxsnjgXrtV+XxAyLT4UUvBrNH98CfU/TG9q7aYZ/bqljHMhWs8knSyIRQuv
         lxEWGDGdcUFJJemoOyheFPlxzsXqecbyounSaS3Rm8GT5zFuViuYClwhnUkzoCArNv3/
         P3kLTknuABGBHhZVt0rAx09gEqaNLbWe9aSzeg5rY49tu9ooNv6MbBSF6Pbi67vqP+RJ
         EoJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7K90Cconf9IU/JjGhL3usnB4fcgEN7IGa/N6vi83tEU=;
        b=zDSFiH4OUmJhDk6b3CwX+oSWC/n5vorm1RB91Mjp7/CBhkV9pk1zV5YM5sqGoOY+hX
         Q2wIsXIB3kO+BIHbRAsUaM9/joCmq/k1f3Nchloyy9VPFIbh/+B36BGiRZN7KhZAEZbY
         NeIdtQfFnKvZWNlqku0ku+qV8aPv0GN3PGI6NeqSjv7l7M4nXER0DIKlctDsB9d7HsLd
         4WfXJ48G3YdI78k/r7MmTcZBmhLRq/Pi1LHc+4osKYpsQw2D4xECrvr7XjS6eWnCRzlh
         BPVt2Ri+DHZoH5rtZyHsFJoiw8wAZii1mxRDnvBE0OI5FYyVkTCmxtWsAlSLYHvx4UhB
         lyVw==
X-Gm-Message-State: AO0yUKXqBiMwgsoI54hICCN522OalYmRtvtlSLPku6jQCJdujmMq+Rwe
        8zViuLnFjDGst00GH56EnpGU4Q==
X-Google-Smtp-Source: AK7set8zWLCiZ74mwTGNMT2x2h+OX5COLl6cjWMEbiHAzeo6UxDuzQyfGltINaNHn718jXW1Eb49GQ==
X-Received: by 2002:a05:600c:3423:b0:3e0:185:e916 with SMTP id y35-20020a05600c342300b003e00185e916mr4591454wmp.13.1675811080307;
        Tue, 07 Feb 2023 15:04:40 -0800 (PST)
Received: from usaari01.cust.communityfibre.co.uk ([2a02:6b6a:b566:0:c04f:2463:c151:8b87])
        by smtp.gmail.com with ESMTPSA id j14-20020a05600c190e00b003dcc82ce53fsm146485wmq.38.2023.02.07.15.04.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Feb 2023 15:04:39 -0800 (PST)
From:   Usama Arif <usama.arif@bytedance.com>
To:     dwmw2@infradead.org, tglx@linutronix.de, kim.phillips@amd.com
Cc:     arjan@linux.intel.com, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, hpa@zytor.com, x86@kernel.org,
        pbonzini@redhat.com, paulmck@kernel.org,
        linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        rcu@vger.kernel.org, mimoja@mimoja.de, hewenliang4@huawei.com,
        thomas.lendacky@amd.com, seanjc@google.com, pmenzel@molgen.mpg.de,
        fam.zheng@bytedance.com, punit.agrawal@bytedance.com,
        simon.evans@bytedance.com, liangma@liangbit.com,
        Usama Arif <usama.arif@bytedance.com>
Subject: [PATCH v7 0/9] Parallel CPU bringup for x86_64
Date:   Tue,  7 Feb 2023 23:04:27 +0000
Message-Id: <20230207230436.2690891-1-usama.arif@bytedance.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Tested on v7, doing INIT/SIPI/SIPI in parallel brings down the time for
smpboot from ~700ms to 100ms (85% improvement) on a server with 128 CPUs
split across 2 NUMA nodes.

The major change over v6 is keeping parallel smp support enabled in AMD.
APIC ID for parallel CPU bringup is now obtained from CPUID leaf 0x0B
(for x2APIC mode) otherwise CPUID leaf 0x1 (8 bits).

The patch for reusing timer calibration for secondary CPUs is also removed
from the series as its not part of parallel smp bringup and needs to be
further thought about.

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

David Woodhouse (8):
  x86/apic/x2apic: Allow CPU cluster_mask to be populated in parallel
  cpu/hotplug: Move idle_thread_get() to <linux/smpboot.h>
  cpu/hotplug: Add dynamic parallel bringup states before
    CPUHP_BRINGUP_CPU
  x86/smpboot: Reference count on smpboot_setup_warm_reset_vector()
  x86/smpboot: Split up native_cpu_up into separate phases and document
    them
  x86/smpboot: Send INIT/SIPI/SIPI to secondary CPUs in parallel
  x86/mtrr: Avoid repeated save of MTRRs on boot-time CPU bringup
  x86/smpboot: Serialize topology updates for secondary bringup

Thomas Gleixner (1):
  x86/smpboot: Support parallel startup of secondary CPUs

 arch/x86/include/asm/realmode.h       |   3 +
 arch/x86/include/asm/smp.h            |  14 +-
 arch/x86/include/asm/topology.h       |   2 -
 arch/x86/kernel/acpi/sleep.c          |   1 +
 arch/x86/kernel/apic/apic.c           |   2 +-
 arch/x86/kernel/apic/x2apic_cluster.c | 130 ++++++----
 arch/x86/kernel/cpu/common.c          |   6 +-
 arch/x86/kernel/cpu/mtrr/mtrr.c       |   9 +
 arch/x86/kernel/head_64.S             |  84 +++++++
 arch/x86/kernel/smpboot.c             | 349 +++++++++++++++++++-------
 arch/x86/realmode/init.c              |   3 +
 arch/x86/realmode/rm/trampoline_64.S  |  14 ++
 arch/x86/xen/smp_pv.c                 |   4 +-
 include/linux/cpuhotplug.h            |   2 +
 include/linux/smpboot.h               |   7 +
 kernel/cpu.c                          |  31 ++-
 kernel/smpboot.c                      |   2 +-
 kernel/smpboot.h                      |   2 -
 18 files changed, 506 insertions(+), 159 deletions(-)

-- 
2.25.1

