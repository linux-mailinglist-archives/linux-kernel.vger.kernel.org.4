Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 684916E855E
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Apr 2023 00:57:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232913AbjDSW5F (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Apr 2023 18:57:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232734AbjDSW5C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Apr 2023 18:57:02 -0400
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5FC721738
        for <linux-kernel@vger.kernel.org>; Wed, 19 Apr 2023 15:56:59 -0700 (PDT)
Received: by mail-pf1-x42b.google.com with SMTP id d2e1a72fcca58-63b62d2f729so373642b3a.1
        for <linux-kernel@vger.kernel.org>; Wed, 19 Apr 2023 15:56:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1681945019; x=1684537019;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=EfHs6iQcu6f/xzGNIRNs/Y6zNI7wkCv1JLv9sFf5g1M=;
        b=Hf8STPeTqcCEMBqR/MDrmp1HtnPk6GIH5PFNOTsUN7tPgWqWR1ZyBP8GwDsJkkLKG8
         AYhZdFrgwCV8MqXtRmCQi31cmL6jiSjz3Nhdqbn+Ydb7KtggmVC0mWLgTkV8h5LrocTx
         JMSiKPmPNqI9PaMzeCfkSLedwLBMwC/49yavs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681945019; x=1684537019;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=EfHs6iQcu6f/xzGNIRNs/Y6zNI7wkCv1JLv9sFf5g1M=;
        b=ZEufqGZrxPsmNJR4PiTB6Kq8E5LFeEYErWbh/GIDRkXC+icjMmU+Q0QR/8D5/TGj6z
         q0HCjaMyqiZ3XosA0Ujgz511zgaP/HegOQ6i+0d59FmwVrqyWJVioUwuC0yaTF6D9+86
         NZT3CKGnTgFVhMAwB/kLZJi5f913bSBlrJ9GDcRPy9f2SgjdzyPcDKd7DOAtZFvHiDIA
         /99lSy7MF3rBsXqStJRXqR2dJt6IrbQwlfalF/c//SWSkbiJMhvQR0Wo2ala8+Q6OA2A
         unop+P2OsBRbceeNUWoG5vIJWBfDSNuSd2KA1QwZP/L/vu6RWiku84oTnyufXUmhK6ga
         AK/g==
X-Gm-Message-State: AAQBX9eTg9RaiWaB5APIVe2tzorKqzl4QL1mMcqNKm/MCUeWXFmc+J9f
        VeWiA6zBqKI0NY27CPKXNJO3eA==
X-Google-Smtp-Source: AKy350ZiPT69ec5g7FHlxHkgLJsXu49t1r2PGDTeEGKpYVM7Qe0rm8s8+T+i58n9/utMvufCZU7NAA==
X-Received: by 2002:a17:902:e74a:b0:1a6:46d7:77dc with SMTP id p10-20020a170902e74a00b001a646d777dcmr7987289plf.43.1681945018669;
        Wed, 19 Apr 2023 15:56:58 -0700 (PDT)
Received: from tictac2.mtv.corp.google.com ([2620:15c:9d:2:8b1:fa03:670e:b784])
        by smtp.gmail.com with ESMTPSA id h15-20020a17090aea8f00b00246ea338c96sm1847101pjz.53.2023.04.19.15.56.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Apr 2023 15:56:57 -0700 (PDT)
From:   Douglas Anderson <dianders@chromium.org>
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Sumit Garg <sumit.garg@linaro.org>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        Marc Zyngier <maz@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Cc:     ito-yuichi@fujitsu.com, kgdb-bugreport@lists.sourceforge.net,
        Chen-Yu Tsai <wens@csie.org>,
        Masayoshi Mizuma <msys.mizuma@gmail.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ard Biesheuvel <ardb@kernel.org>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        linux-arm-kernel@lists.infradead.org,
        Stephen Boyd <swboyd@chromium.org>,
        Lecopzer Chen <lecopzer.chen@mediatek.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-perf-users@vger.kernel.org,
        Douglas Anderson <dianders@chromium.org>,
        Alexandru Elisei <alexandru.elisei@arm.com>,
        Andrey Konovalov <andreyknvl@gmail.com>,
        Ben Dooks <ben-linux@fluff.org>,
        Borislav Petkov <bp@alien8.de>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        "Darrick J. Wong" <djwong@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "David S. Miller" <davem@davemloft.net>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Frederic Weisbecker <frederic@kernel.org>,
        Gaosheng Cui <cuigaosheng1@huawei.com>,
        "Gautham R. Shenoy" <gautham.shenoy@amd.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Guilherme G. Piccoli" <gpiccoli@igalia.com>,
        Guo Ren <guoren@kernel.org>, "H. Peter Anvin" <hpa@zytor.com>,
        Huacai Chen <chenhuacai@kernel.org>,
        Ingo Molnar <mingo@kernel.org>, Ingo Molnar <mingo@redhat.com>,
        "Jason A. Donenfeld" <Jason@zx2c4.com>,
        Jason Wessel <jason.wessel@windriver.com>,
        Jianmin Lv <lvjianmin@loongson.cn>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        Jinyang He <hejinyang@loongson.cn>,
        Joey Gouly <joey.gouly@arm.com>,
        Kees Cook <keescook@chromium.org>,
        Laurent Dufour <ldufour@linux.ibm.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Masayoshi Mizuma <m.mizuma@jp.fujitsu.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Nicholas Piggin <npiggin@gmail.com>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
        Pierre Gondois <Pierre.Gondois@arm.com>,
        Qing Zhang <zhangqing@loongson.cn>,
        "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>,
        Russell King <linux@armlinux.org.uk>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        WANG Xuerui <kernel@xen0n.name>, linux-kernel@vger.kernel.org,
        linux-mips@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        loongarch@lists.linux.dev, sparclinux@vger.kernel.org,
        x86@kernel.org
Subject: [PATCH v8 00/10] arm64: Add framework to turn an IPI as NMI
Date:   Wed, 19 Apr 2023 15:55:54 -0700
Message-ID: <20230419225604.21204-1-dianders@chromium.org>
X-Mailer: git-send-email 2.40.0.634.g4ca3ef3211-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is an attempt to resurrect Sumit's old patch series [1] that
allowed us to use the arm64 pseudo-NMI to get backtraces of CPUs and
also to round up CPUs in kdb/kgdb. The last post from Sumit that I
could find was v7, so I called this series v8. I haven't copied all of
his old changelongs here, but you can find them from the link.

Since v7, I have:
* Addressed the small amount of feedback that was there for v7.
* Rebased.
* Added a new patch that prevents us from spamming the logs with idle
  tasks.
* Added an extra patch to gracefully fall back to regular IPIs if
  pseudo-NMIs aren't there.

Since there appear to be a few different patches series related to
being able to use NMIs to get stack traces of crashed systems, let me
try to organize them to the best of my understanding:

a) This series. On its own, a) will (among other things) enable stack
   traces of all running processes with the soft lockup detector if
   you've enabled the sysctl "kernel.softlockup_all_cpu_backtrace". On
   its own, a) doesn't give a hard lockup detector.

b) A different recently-posted series [2] that adds a hard lockup
   detector based on perf. On its own, b) gives a stack crawl of the
   locked up CPU but no stack crawls of other CPUs (even if they're
   locked too). Together with a) + b) we get everything (full lockup
   detect, full ability to get stack crawls).

c) The old Android "buddy" hard lockup detector [3] that I'm
   considering trying to upstream. If b) lands then I believe c) would
   be redundant (at least for arm64). c) on its own is really only
   useful on arm64 for platforms that can print CPU_DBGPCSR somehow
   (see [4]). a) + c) is roughly as good as a) + b).

[1] https://lore.kernel.org/linux-arm-kernel/1604317487-14543-1-git-send-email-sumit.garg@linaro.org/
[2] https://lore.kernel.org/linux-arm-kernel/20220903093415.15850-1-lecopzer.chen@mediatek.com/
[3] https://issuetracker.google.com/172213097
[4] https://issuetracker.google.com/172213129

Changes in v8:
- dynamic_ipi_setup() and dynamic_ipi_teardown() no longer take cpu param
- dynamic_ipi_setup() and dynamic_ipi_teardown() no longer take cpu param
- Add loongarch support, too
- Removed "#ifdef CONFIG_SMP" since arm64 is always SMP
- "Tag the arm64 idle functions as __cpuidle" new for v8
- "Provide a stub kgdb_nmicallback() if !CONFIG_KGDB" new for v8
- "Fallback to a regular IPI if NMI isn't enabled" new for v8

Douglas Anderson (3):
  arm64: idle: Tag the arm64 idle functions as __cpuidle
  kgdb: Provide a stub kgdb_nmicallback() if !CONFIG_KGDB
  arm64: ipi_nmi: Fallback to a regular IPI if NMI isn't enabled

Sumit Garg (7):
  arm64: Add framework to turn IPI as NMI
  irqchip/gic-v3: Enable support for SGIs to act as NMIs
  arm64: smp: Assign and setup an IPI as NMI
  nmi: backtrace: Allow runtime arch specific override
  arm64: ipi_nmi: Add support for NMI backtrace
  kgdb: Expose default CPUs roundup fallback mechanism
  arm64: kgdb: Roundup cpus using IPI as NMI

 arch/arm/include/asm/irq.h       |   2 +-
 arch/arm/kernel/smp.c            |   3 +-
 arch/arm64/include/asm/irq.h     |   4 ++
 arch/arm64/include/asm/nmi.h     |  17 +++++
 arch/arm64/kernel/Makefile       |   2 +-
 arch/arm64/kernel/idle.c         |   4 +-
 arch/arm64/kernel/ipi_nmi.c      | 103 +++++++++++++++++++++++++++++++
 arch/arm64/kernel/kgdb.c         |  18 ++++++
 arch/arm64/kernel/smp.c          |   8 +++
 arch/loongarch/include/asm/irq.h |   2 +-
 arch/loongarch/kernel/process.c  |   3 +-
 arch/mips/include/asm/irq.h      |   2 +-
 arch/mips/kernel/process.c       |   3 +-
 arch/powerpc/include/asm/nmi.h   |   2 +-
 arch/powerpc/kernel/stacktrace.c |   3 +-
 arch/sparc/include/asm/irq_64.h  |   2 +-
 arch/sparc/kernel/process_64.c   |   4 +-
 arch/x86/include/asm/irq.h       |   2 +-
 arch/x86/kernel/apic/hw_nmi.c    |   3 +-
 drivers/irqchip/irq-gic-v3.c     |  29 ++++++---
 include/linux/kgdb.h             |  13 ++++
 include/linux/nmi.h              |  12 ++--
 kernel/debug/debug_core.c        |   8 ++-
 23 files changed, 217 insertions(+), 32 deletions(-)
 create mode 100644 arch/arm64/include/asm/nmi.h
 create mode 100644 arch/arm64/kernel/ipi_nmi.c

-- 
2.40.0.634.g4ca3ef3211-goog

