Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4652F6923B5
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Feb 2023 17:55:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232903AbjBJQzS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Feb 2023 11:55:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232229AbjBJQzR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Feb 2023 11:55:17 -0500
Received: from mail-pf1-x449.google.com (mail-pf1-x449.google.com [IPv6:2607:f8b0:4864:20::449])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D47613D08B
        for <linux-kernel@vger.kernel.org>; Fri, 10 Feb 2023 08:55:15 -0800 (PST)
Received: by mail-pf1-x449.google.com with SMTP id m16-20020a62a210000000b005a851506993so2926117pff.4
        for <linux-kernel@vger.kernel.org>; Fri, 10 Feb 2023 08:55:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=/T7AMdhFLGitDXHZ5/TfRi2ULQMYcZwnIbHev2XdwW0=;
        b=W9p/dZOcq6Yrc4yvBEoJQaIdVvvUWQFCmtOwR8Yajzr08GgV7Sj0rLyD/x8KqLBZMr
         DfL5q09Qgs7SmvILLDxBUmZmVXD4M8nPzD+BwiuyarUPAdmIi93tCwxnjPXLqHPb9UG+
         HO9E1/VvCqpuwyn0wyC5OZrbDykhAbicVPfxq0EDMpkWSQKA08UULhfQ8kecC1Ay3Jl5
         rb1z5UZzHJMVoeMg7S6UhPIAZ6ZwJAoXI2LUps9b2YaSakDa+7jRzwL31yRUrL/hY9vC
         WAyc09K7uHelvmpX6OcLVlAni+u6lRCHwV9pBGss0VRWxNnc/PjV76/MSSX/nMtWwHAu
         Webg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=/T7AMdhFLGitDXHZ5/TfRi2ULQMYcZwnIbHev2XdwW0=;
        b=O+6ZprlMLkPCfEN8JAk1vOhbjTARkMgHamY+2qHnIMfAT5toB866Jmmgm2JP3v0Ld/
         qyqiyYgnpL6cucdjkW15henuGbRKSaR/xrgjddM/9eQ9qjJ2+joj0Bs1dLqMDO9Tn7Sg
         cREQheyk3zqR2fTrxHXalZQVeR0pmekFYltyt8baRrZYp35IEYBrwNEhixmGVy79/T/B
         HKlDNhztqYGxE6pOSx0ItHJGDNF4md/90YJbcnuaIq5/+JTgKwRxae/8jXgFAPmldOxn
         JYxHqG+c0ftXXfbvTYs8ETjeee45PqjKeqX2tFmRo5b495bwu5vQaQqXFw9GYH1TVDIh
         UmgQ==
X-Gm-Message-State: AO0yUKVxnxLrFKZ5vZDg6wka7hfg9E51KAS0cz6QZJDttuJv7J2iI6BK
        AJp8Yc8OmZ8t3ljx1RrcbvFSzhTe5e3xZtQ=
X-Google-Smtp-Source: AK7set8EEM2vPuWTtNSdApk5kfdc5jxhS8S3smtK3/eWyLn1K5CRolTI3MKSZV4+jhJat0Wcjkt5P+MgOeWbLGU=
X-Received: from zaidcloud.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5325])
 (user=zalbassam job=sendgmr) by 2002:a17:90a:280a:b0:231:1912:b40d with SMTP
 id e10-20020a17090a280a00b002311912b40dmr2050226pjd.116.1676048115339; Fri,
 10 Feb 2023 08:55:15 -0800 (PST)
Date:   Fri, 10 Feb 2023 11:54:52 -0500
Mime-Version: 1.0
X-Mailer: git-send-email 2.39.1.581.gbfd45094c4-goog
Message-ID: <20230210165500.2292608-1-zalbassam@google.com>
Subject: [PATCH v2 0/8] perf: arm: Make PMUv3 driver available for aarch32
From:   Zaid Al-Bassam <zalbassam@google.com>
To:     Jesus Sanchez-Palencia <jesussanp@google.com>,
        Russell King <linux@armlinux.org.uk>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Marc Zyngier <maz@kernel.org>,
        James Morse <james.morse@arm.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Oliver Upton <oliver.upton@linux.dev>,
        Zenghui Yu <yuzenghui@huawei.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org, kvmarm@lists.linux.dev,
        kvmarm@lists.cs.columbia.edu
Cc:     Zaid Al-Bassam <zalbassam@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently, PMUv3 driver is only available for ARMv8 aarch64 platforms,
ARMv8 platorms running in aarch32 mode dont have access to the driver.
This is, especially, a problem for ARMv8 platforms that only have
aarch32 support, like the Cortex-A32.

Make the PMUv3 driver available to arm arch (ARMv8 aarch32) by moving
the PMUv3 driver from arm64 to drivers, that makes the driver common
to both arm and arm64 architectures, then add PMUv3 arm Support.

The main work in this patchset was made a while back by Marc Zyngier
in [1]. This patchset rebases Marc's patches to the latest kernel
revision and adds additional patches to accommodate the changes in the
kernel since Marc wrote the patches.

This is the v2 of the patch series [v1]. This version of the patchset
was created by Marc Zyngier and I picked it up from [2].

Changes in v2:
- Flattened the nested switches in the arm_pmuv3.h for arm.
- Removed wrappers and added stubs for the PMU KVM functions for arm.
- Added PMU version abstractions.

[1] https://git.kernel.org/pub/scm/linux/kernel/git/maz/arm-platforms.git/log/?h=kvm-arm/pmuv3-32bit
[2] https://git.kernel.org/pub/scm/linux/kernel/git/maz/arm-platforms.git/log/?h=arm/pmuv3

[v1] https://lore.kernel.org/all/20230126204444.2204061-1-zalbassam@google.com/

Thank you,
Zaid Al-Bassam

Marc Zyngier (5):
  arm64: perf: Move PMUv3 driver to drivers/perf
  arm64: perf: Abstract system register accesses away
  ARM: Make CONFIG_CPU_V7 valid for 32bit ARMv8 implementations
  ARM: perf: Allow the use of the PMUv3 driver on 32bit ARM
  ARM: mach-virt: Select PMUv3 driver by default

Zaid Al-Bassam (3):
  perf: pmuv3: Abstract PMU version checks
  perf: pmuv3: Move inclusion of kvm_host.h to the arch-specific helper
  perf: pmuv3: Change GENMASK to GENMASK_ULL

 arch/arm/Kconfig                              |   1 +
 arch/arm/include/asm/arm_pmuv3.h              | 259 ++++++++++++++
 arch/arm/mm/Kconfig                           |   2 +-
 arch/arm64/include/asm/arm_pmuv3.h            | 167 ++++++++++
 arch/arm64/include/asm/perf_event.h           | 249 --------------
 arch/arm64/kernel/Makefile                    |   1 -
 drivers/perf/Kconfig                          |  10 +
 drivers/perf/Makefile                         |   1 +
 .../perf_event.c => drivers/perf/arm_pmuv3.c  | 131 ++------
 include/kvm/arm_pmu.h                         |   2 +-
 include/linux/perf/arm_pmuv3.h                | 315 ++++++++++++++++++
 11 files changed, 787 insertions(+), 351 deletions(-)
 create mode 100644 arch/arm/include/asm/arm_pmuv3.h
 create mode 100644 arch/arm64/include/asm/arm_pmuv3.h
 rename arch/arm64/kernel/perf_event.c => drivers/perf/arm_pmuv3.c (93%)
 create mode 100644 include/linux/perf/arm_pmuv3.h

-- 
2.39.1.581.gbfd45094c4-goog

