Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C68EB67D6A4
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Jan 2023 21:45:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232555AbjAZUpC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Jan 2023 15:45:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232860AbjAZUox (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jan 2023 15:44:53 -0500
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D11C5954E
        for <linux-kernel@vger.kernel.org>; Thu, 26 Jan 2023 12:44:52 -0800 (PST)
Received: by mail-yb1-xb4a.google.com with SMTP id p19-20020a25d813000000b0080b78270db5so3127391ybg.15
        for <linux-kernel@vger.kernel.org>; Thu, 26 Jan 2023 12:44:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=j9eMGsuOboeDFLvBXbf4EoVuBvplDzjiR8R35kRzRzk=;
        b=cQMw6FAyg6mYnU7VIMqrgDwFxLs3c6Kcg0P38Z+Sg43jVxky6lvNicUFY568YhVD3h
         geRQGIU7S03l1YTAZxjjbutQ49edTKuPIY8miJd7qbBgwJ+MPl5LZnYUfzGCJRZmJk+4
         qDE0VWTF35oajtWZ5Zl+pazWx+IQjQBxJjREDohEa5TEf05b0EvBRyT+YJaAwNk7OAGV
         NWsCw4Ya2caGs5rfbN1+UcSZi9jzqO2PSxD3XSumV+QUlO4R77YNCBsOAnZ4CF3Q0wfg
         K4FMpUmHtmmEf9l1bhupZMqZ65fzTTljYHVLYRI3nJqvR3Xtu/Yxs0Ng/WvpqqfdsPjM
         AHEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=j9eMGsuOboeDFLvBXbf4EoVuBvplDzjiR8R35kRzRzk=;
        b=3Sccz5wW2otkbRWgUaLUSTOAUlyeNz+JOJPbXM0VoWY1Poaow8n8I6A1hDVwHCdXTo
         w/V12nrIs+aoq/JW2qruOGdLfAn75laNcr/00b6PPp+WL5eg5RwR933e9huPmj187SKX
         JnUeqt2XpUpUmWmVBBebARHot/+wBORAtlgXLcsesIZcQ3OSgqcIV4/9n3x2OIhmPev+
         Inh07omdsPGAnjgIhWxhsp17lSqWoih/ZwdJ6OJH726tTSQ5iRLA/OMjFdbWPGhrDVdG
         v/HPMtICux8hSkqW2x9iVr63mQ8SfSYwoUsopBJx7MyRJZ2CptQivHFY/GkHRbeNVZTj
         MUOw==
X-Gm-Message-State: AFqh2kp0+PXkxPBwctILRs0Ecc/sAMLS7DJ+xNaIPDjT6ZItGLBP0Ihh
        mhu7S1zKmoTq0yuhm4T19vtjgyN1AIL2nEU=
X-Google-Smtp-Source: AMrXdXvqgrjYC0YYc4Slv5mogwPRxgYozsZ3TTkpden02y5nqgY7MNNJj+RJ44bjJRb/eYtnJkbmDMOppy9uU7M=
X-Received: from zaidcloud.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5325])
 (user=zalbassam job=sendgmr) by 2002:a25:3c82:0:b0:7e2:76a6:a641 with SMTP id
 j124-20020a253c82000000b007e276a6a641mr4484003yba.645.1674765891585; Thu, 26
 Jan 2023 12:44:51 -0800 (PST)
Date:   Thu, 26 Jan 2023 15:44:36 -0500
Mime-Version: 1.0
X-Mailer: git-send-email 2.39.1.456.gfc5497dd1b-goog
Message-ID: <20230126204444.2204061-1-zalbassam@google.com>
Subject: [PATCH 0/8] perf: arm: Make PMUv3 driver available for aarch32
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

Currently, PMUv3 driver is only available for ARMv8 aarch64
platforms, ARMv8 running in aarch32 mode dont have access to
the driver. This is, especially, a problem for ARMv8 platforms
that only have aarch32 support, like the Cortex-A32.

Make the PMUv3 driver available to arm arch (ARMv8 aarch32) by
moving the PMUv3 driver from arm64 to drivers, that makes the
driver common to both arm and arm64 architectures, then add
PMUv3 arm Support.

The main work in this patchset was made a while back by Marc
Zyngier on a private branch. This patchset rebases Marc's
patches to the latest kernel revision and adds additional
patches to accommodate the changes in the kernel since Marc
wrote the patches.

Marc Zyngier (5):
  arm64: perf: Move PMUv3 driver to drivers/perf
  arm64: perf: Abstract system register accesses away
  ARM: Make CONFIG_CPU_V7 valid for 32bit ARMv8 implementations
  ARM: perf: Allow the use of the PMUv3 driver on 32bit ARM
  ARM: mach-virt: Select PMUv3 driver by default

Zaid Al-Bassam (3):
  perf: pmuv3: Add common defines for the PMU version
  perf: pmuv3: Add wrappers for KVM accesses
  perf: pmuv3: Change GENMASK to GENMASK_ULL

 arch/arm/Kconfig                              |   1 +
 arch/arm/include/asm/arm_pmuv3.h              | 238 +++++++++++++++
 arch/arm/mm/Kconfig                           |   2 +-
 arch/arm64/include/asm/arm_pmuv3.h            | 210 +++++++++++++
 arch/arm64/include/asm/perf_event.h           | 249 ----------------
 arch/arm64/kernel/Makefile                    |   1 -
 drivers/perf/Kconfig                          |  10 +
 drivers/perf/Makefile                         |   1 +
 .../perf_event.c => drivers/perf/arm_pmuv3.c  | 139 +++------
 include/kvm/arm_pmu.h                         |   2 +-
 include/linux/perf/arm_pmuv3.h                | 276 ++++++++++++++++++
 11 files changed, 773 insertions(+), 356 deletions(-)
 create mode 100644 arch/arm/include/asm/arm_pmuv3.h
 create mode 100644 arch/arm64/include/asm/arm_pmuv3.h
 rename arch/arm64/kernel/perf_event.c => drivers/perf/arm_pmuv3.c (92%)
 create mode 100644 include/linux/perf/arm_pmuv3.h

-- 
2.39.0.246.g2a6d74b583-goog

