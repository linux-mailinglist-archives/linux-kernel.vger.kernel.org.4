Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 63BA271F4D4
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Jun 2023 23:37:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232770AbjFAVhJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Jun 2023 17:37:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229618AbjFAVhH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Jun 2023 17:37:07 -0400
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3672184
        for <linux-kernel@vger.kernel.org>; Thu,  1 Jun 2023 14:37:05 -0700 (PDT)
Received: by mail-pf1-x431.google.com with SMTP id d2e1a72fcca58-651ffcc1d3dso610694b3a.3
        for <linux-kernel@vger.kernel.org>; Thu, 01 Jun 2023 14:37:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1685655425; x=1688247425;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=wK2qTWWUlvlWswvV25kHoV1Nx+E83dWl0Aza3PbFaXw=;
        b=VjkyfUKU1dkg5kT2BFXow4+y0HeGzDVKSaONjNBRNW8oLVR/Alj7nxwARt7jAN4AAd
         LeszuaBRTc4EKoRYji2WEy+1ZUighHRYU33p6yuhIh4aTq/1brBqn37H8mLeVIu/k+4w
         OX1kckaXSmVRq+aZdP5wkU6jO0HaJRTPBztMw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685655425; x=1688247425;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wK2qTWWUlvlWswvV25kHoV1Nx+E83dWl0Aza3PbFaXw=;
        b=X7G4L8ArXv9aOmVjhjmEMXud4IyC+ojFVNPT6xH4JATzfBqEya+FDNiVYX8Udp+B10
         p+WbMOPZ5//kqX9AYNZWhs3I0HO+erJWjeJKAJmpL8MPnzOLgSUQFud30gq/gRZhSZlt
         q54E4CUGDkPBJUsc2Mis9/kEO4Hrcqisa4jY4zpQaq74MYRP+8msQvoy9WatsbLdJuGk
         Adexb6s3wmUREE2WIhTf1Wznwl9KsgbJL/XzGTDejqPGgjI/NPVK9TaASsSbNm6obCoV
         czhRyqLtbKZ57kbWt7CqzW5zv8zsJweUW3r8oSjl8lYB7deVEHnDXzzhBLTaSpO1SmNR
         9EOA==
X-Gm-Message-State: AC+VfDymkzAMj/Q9sijKwB4czays8Fvxbg7FIaSKsdO2przn9w2D11OB
        3UHtYq8kX9TH5wn/Woq5sGz/lQ==
X-Google-Smtp-Source: ACHHUZ5HygCX8YZytHhbbDr3bRwb0rXBa6fo96DufozZDOKQ1Pv8Ou3d9q1G/o0NgyZNtzPCEB3dPQ==
X-Received: by 2002:a05:6a20:4299:b0:10f:b53d:8641 with SMTP id o25-20020a056a20429900b0010fb53d8641mr9155808pzj.46.1685655425420;
        Thu, 01 Jun 2023 14:37:05 -0700 (PDT)
Received: from tictac2.mtv.corp.google.com ([2620:15c:9d:2:11b8:2d2:7e02:6bff])
        by smtp.gmail.com with ESMTPSA id g22-20020aa78756000000b0064d48d98260sm5319534pfo.156.2023.06.01.14.37.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Jun 2023 14:37:04 -0700 (PDT)
From:   Douglas Anderson <dianders@chromium.org>
To:     Mark Rutland <mark.rutland@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Sumit Garg <sumit.garg@linaro.org>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        Marc Zyngier <maz@kernel.org>
Cc:     linux-perf-users@vger.kernel.org, ito-yuichi@fujitsu.com,
        Chen-Yu Tsai <wens@csie.org>, Ard Biesheuvel <ardb@kernel.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-arm-kernel@lists.infradead.org,
        kgdb-bugreport@lists.sourceforge.net,
        Masayoshi Mizuma <msys.mizuma@gmail.com>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Lecopzer Chen <lecopzer.chen@mediatek.com>,
        Douglas Anderson <dianders@chromium.org>,
        Andrey Konovalov <andreyknvl@gmail.com>,
        Ben Dooks <ben-linux@fluff.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        "Gautham R. Shenoy" <gautham.shenoy@amd.com>,
        Ingo Molnar <mingo@kernel.org>,
        Jason Wessel <jason.wessel@windriver.com>,
        Josh Poimboeuf <jpoimboe@kernel.org>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Valentin Schneider <vschneid@redhat.com>,
        Wei Li <liwei391@huawei.com>, linux-kernel@vger.kernel.org
Subject: [PATCH v9 0/7] arm64: Add debug IPI for backtraces / kgdb; try to use NMI for it
Date:   Thu,  1 Jun 2023 14:31:44 -0700
Message-ID: <20230601213440.2488667-1-dianders@chromium.org>
X-Mailer: git-send-email 2.41.0.rc2.161.g9c6817b8e7-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is an attempt to resurrect Sumit's old patch series [1] that
allowed us to use the arm64 pseudo-NMI to get backtraces of CPUs and
also to round up CPUs in kdb/kgdb. The last post from Sumit that I
could find was v7, so I started my series at v8. I haven't copied all
of his old changelongs here, but you can find them from the link.

I'm really looking for a way to land this patch series. In response to
v8, Mark Rutland indicated [2] that he was worried about the soundness
of pseudo NMI. Those definitely need to get fixed, but IMO this patch
series could still land in the meantime. That would at least let
people test with it.

Request for anyone reading this: please help indicate your support of
this patch series landing by replying, even if you don't have the
background for a full review. My suspicion is that there are a lot of
people who agree that this would be super useful to get landed.

Since v8, I have cleaned up this patch series by integrating the 10th
patch from v8 [3] into the whole series. As part of this, I renamed
the "NMI IPI" to the "debug IPI" since it could now be backed by a
regular IPI in the case that pseudo NMIs weren't available. With the
fallback, this allowed me to drop some extra patches from the
series. This feels (to me) to be pretty clean and hopefully others
agree. Any patch I touched significantly I removed Masayoshi and
Chen-Yu's tags from.

...also in v8, I reorderd the patches a bit in a way that seemed a
little cleaner to me.

Since v7, I have:
* Addressed the small amount of feedback that was there for v7.
* Rebased.
* Added a new patch that prevents us from spamming the logs with idle
  tasks.
* Added an extra patch to gracefully fall back to regular IPIs if
  pseudo-NMIs aren't there.

It can be noted that this patch series works very well with the recent
"hardlockup" patches that have landed through Andrew Morton's tree and
are currently in linuxnext. It works especially well with the "buddy"
lockup detector.

[1] https://lore.kernel.org/linux-arm-kernel/1604317487-14543-1-git-send-email-sumit.garg@linaro.org/
[2] https://lore.kernel.org/lkml/ZFvGqD%2F%2Fpm%2FlZb+p@FVFF77S0Q05N.cambridge.arm.com/
[3] https://lore.kernel.org/r/20230419155341.v8.10.Ic3659997d6243139d0522fc3afcdfd88d7a5f030@changeid/

Changes in v9:
- Add a warning if we don't have enough IPIs for the NMI IPI
- Added comments that we might not be using NMI always.
- Added missing "inline"
- Added to commit message that this doesn't catch all cases.
- Fold in v8 patch #10 ("Fallback to a regular IPI if NMI isn't enabled")
- Moved header file out of "include" since it didn't need to be there.
- Remove arm64_supports_nmi()
- Remove fallback for when debug IPI isn't available.
- Renamed "NMI IPI" to "debug IPI" since it might not be backed by NMI.
- Update commit description
- arch_trigger_cpumask_backtrace() no longer returns bool

Changes in v8:
- "Provide a stub kgdb_nmicallback() if !CONFIG_KGDB" new for v8
- "Tag the arm64 idle functions as __cpuidle" new for v8
- Removed "#ifdef CONFIG_SMP" since arm64 is always SMP
- debug_ipi_setup() and debug_ipi_teardown() no longer take cpu param

Douglas Anderson (2):
  arm64: idle: Tag the arm64 idle functions as __cpuidle
  kgdb: Provide a stub kgdb_nmicallback() if !CONFIG_KGDB

Sumit Garg (5):
  irqchip/gic-v3: Enable support for SGIs to act as NMIs
  arm64: Add framework for a debug IPI
  arm64: smp: Assign and setup the debug IPI
  arm64: ipi_debug: Add support for backtrace using the debug IPI
  arm64: kgdb: Roundup cpus using the debug IPI

 arch/arm64/include/asm/irq.h  |   3 +
 arch/arm64/kernel/Makefile    |   2 +-
 arch/arm64/kernel/idle.c      |   4 +-
 arch/arm64/kernel/ipi_debug.c | 102 ++++++++++++++++++++++++++++++++++
 arch/arm64/kernel/ipi_debug.h |  13 +++++
 arch/arm64/kernel/kgdb.c      |  14 +++++
 arch/arm64/kernel/smp.c       |  11 ++++
 drivers/irqchip/irq-gic-v3.c  |  29 +++++++---
 include/linux/kgdb.h          |   1 +
 9 files changed, 168 insertions(+), 11 deletions(-)
 create mode 100644 arch/arm64/kernel/ipi_debug.c
 create mode 100644 arch/arm64/kernel/ipi_debug.h

-- 
2.41.0.rc2.161.g9c6817b8e7-goog

