Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8A527695296
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Feb 2023 22:03:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229810AbjBMVDf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Feb 2023 16:03:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229581AbjBMVDd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Feb 2023 16:03:33 -0500
Received: from mail-pl1-x64a.google.com (mail-pl1-x64a.google.com [IPv6:2607:f8b0:4864:20::64a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3D3A1ABC8
        for <linux-kernel@vger.kernel.org>; Mon, 13 Feb 2023 13:03:32 -0800 (PST)
Received: by mail-pl1-x64a.google.com with SMTP id t3-20020a170902e1c300b0019a84b88f70so4286315pla.19
        for <linux-kernel@vger.kernel.org>; Mon, 13 Feb 2023 13:03:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1676322212;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=IH3jJcJ/IoZtR7vL3Ek1HckoQScJmDuoE0WIjUb4KK8=;
        b=dGWV2JGDl4a32c3CxY9ycW7JCWmkwvjFsm2CupzNfand10jYMJ8qQlpFj3kbO3CZmR
         6UX2IUVXTGA5e0VFugUjCDsKiugRnjCaocM4DNhnQztU3vqv54Bbb+Vw/ok5L+3DXntf
         tA5tXBCVz3JlE0ZIIZavJflsEsOQhD5AUtNkEqa4YHoSl8TozBtbpcuW05NZ3xDux+vV
         kF4d7mkBmEexy897IFi7oIbSOFhVzUctYylJNqrD20l0bJP1ummHvXInwWF1MUvn6BNm
         /da2V5/XfFq4NKrOTQqriI8mCv/OYTfAhW2opih+oXTmKx9zMM0/mSrxCERtqg09QL0+
         C09g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1676322212;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=IH3jJcJ/IoZtR7vL3Ek1HckoQScJmDuoE0WIjUb4KK8=;
        b=Hk+oAg2KePlpQLiNMJDewadMeE0DSkQkSmsr7f8whjpu9Nckj3/zHem3pnrBVQdRHf
         JD8iNFh/RBk/BQVKwKrMvvM1hN9oHkJktQpGBKRFjjwEBjVxEFfLISXLqJNbXuDuM07N
         HMUIAUeX5yICqDqB9Uqw6zGkFzynMVBkPFpHG2yNpXmcc3ahAVjCK3cwqp97pnlBHajU
         vt8Ji5mzTYzuPmx3gQthejm4YfbPbZRCGGt/HY+RMbw8w1MYulk8HqGfag6htW4ZPAZV
         LeM8+gCs5yCIZjatEAOugiNb3j+MZ5LddwkJuW/hng3BfJCedPfw156OQ0KDS29ty/HO
         XJXg==
X-Gm-Message-State: AO0yUKVdaj9xLYhdH1fLJNrjAJqZAlpwSZnWhoOtdjw5Es3C5f5Bhl5V
        aUcxVFkIViYiE/V82vcCjDqJv/P6sFLH4Us=
X-Google-Smtp-Source: AK7set+CiP9aL8UBtV5TmqF28XLkt6IaxJ0mcncY8JVwJXtnw2rLbvuAxo6bzvnfqn8OHGaKAqhZ2FFHm5R13Uc=
X-Received: from zaidcloud.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5325])
 (user=zalbassam job=sendgmr) by 2002:a17:903:2309:b0:19a:b302:516d with SMTP
 id d9-20020a170903230900b0019ab302516dmr94777plh.1.1676322212079; Mon, 13 Feb
 2023 13:03:32 -0800 (PST)
Date:   Mon, 13 Feb 2023 16:03:11 -0500
Mime-Version: 1.0
X-Mailer: git-send-email 2.39.1.581.gbfd45094c4-goog
Message-ID: <20230213210319.1075872-1-zalbassam@google.com>
Subject: [PATCH v3 0/8] perf: arm: Make PMUv3 driver available for aarch32
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
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
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
in [1]. Patchset version 1 [v1] rebases Marc's patches to the latest
kernel revision and adds additional patches to accommodate the changes
in the kernel since Marc wrote the patches.

version 2 [v2] of the patchset was created by Marc Zyngier and I
picked it up from [2].

Changes in v2:
- Flattened the nested switches in the arm_pmuv3.h for arm.
- Removed wrappers and added stubs for the PMU KVM functions for arm.
- Added PMU version abstractions.

Changes in v3:
- Removed the link tag from the commit messages.
- Fixed the license header in the arm_pmuv3.h files.

[1] https://git.kernel.org/pub/scm/linux/kernel/git/maz/arm-platforms.git/log/?h=kvm-arm/pmuv3-32bit
[2] https://git.kernel.org/pub/scm/linux/kernel/git/maz/arm-platforms.git/log/?h=arm/pmuv3

[v1] https://lore.kernel.org/all/20230126204444.2204061-1-zalbassam@google.com/
[v2] https://lore.kernel.org/all/20230210165500.2292608-1-zalbassam@google.com/

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
 arch/arm/include/asm/arm_pmuv3.h              | 247 ++++++++++++++
 arch/arm/mm/Kconfig                           |   2 +-
 arch/arm64/include/asm/arm_pmuv3.h            | 155 +++++++++
 arch/arm64/include/asm/perf_event.h           | 249 --------------
 arch/arm64/kernel/Makefile                    |   1 -
 drivers/perf/Kconfig                          |  10 +
 drivers/perf/Makefile                         |   1 +
 .../perf_event.c => drivers/perf/arm_pmuv3.c  | 131 ++------
 include/kvm/arm_pmu.h                         |   2 +-
 include/linux/perf/arm_pmuv3.h                | 303 ++++++++++++++++++
 11 files changed, 751 insertions(+), 351 deletions(-)
 create mode 100644 arch/arm/include/asm/arm_pmuv3.h
 create mode 100644 arch/arm64/include/asm/arm_pmuv3.h
 rename arch/arm64/kernel/perf_event.c => drivers/perf/arm_pmuv3.c (93%)
 create mode 100644 include/linux/perf/arm_pmuv3.h

-- 
2.39.1.581.gbfd45094c4-goog

