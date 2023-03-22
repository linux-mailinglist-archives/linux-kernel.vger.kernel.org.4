Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 84BCA6C415A
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Mar 2023 05:00:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230267AbjCVEA1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Mar 2023 00:00:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229498AbjCVEAY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Mar 2023 00:00:24 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11B9B474D4
        for <linux-kernel@vger.kernel.org>; Tue, 21 Mar 2023 21:00:23 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9EF3260BF0
        for <linux-kernel@vger.kernel.org>; Wed, 22 Mar 2023 04:00:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7E5DAC433D2;
        Wed, 22 Mar 2023 04:00:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1679457622;
        bh=i6IhVzT9OpzVoQyspMPLq+3N5zYy9EEMRpCDmXH98t4=;
        h=From:To:Cc:Subject:Date:From;
        b=DtxPoVGI4mjrJY0/CaMvvbpoAj9zmMGMUVZZkeFvN4b0EDxeUYodHoc+uSAgG7EMg
         md/SXA60oJPCZ3BM9einpvw9EdzWsAC5hT3eh6QxvfxqWiC+4ZkCgQDnKNI5LbOub6
         8LhJPx+CL7C8weP3Nx+B6RiTiP5w7gl6ZQrufWyyZo40uw4wJKjEfEUmvjZOsreduk
         vAfCbhb7zCixqjKMoBMqSEN2hydxpPQqBrS8mLGw0HaDuUX7y2RhvNw+KV8Cy6FV32
         Y6P+kOPY2///MNOis55LgPXkMeeEYiWo3jNtV61ZTtv5A2CMQevKVWRjwuDjPxf0Yg
         +5jkKhCtD1wQA==
From:   Josh Poimboeuf <jpoimboe@kernel.org>
To:     x86@kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Jason Baron <jbaron@akamai.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ard Biesheuvel <ardb@kernel.org>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Sean Christopherson <seanjc@google.com>,
        Sami Tolvanen <samitolvanen@google.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Will McVicker <willmcvicker@google.com>,
        Kees Cook <keescook@chromium.org>,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH v2 00/11] static_call: Improve NULL/ret0 handling
Date:   Tue, 21 Mar 2023 21:00:06 -0700
Message-Id: <cover.1679456900.git.jpoimboe@kernel.org>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Peter pointed out that v1 had CFI violations on arm64 with
CONFIG_CFI_CLANG.  Then I realized there are already CFI violations
today in the existing code.

So this ended up turning into a complete rewrite of v1.

Highlights include:

- Several cleanups
- Fix arm64 CFI violations
- Make NULL pointer behavior consistent across configs
- Merge NULL and RET0 into a single concept


v1 can be found here:

  https://lkml.kernel.org/lkml/cover.1678474914.git.jpoimboe@kernel.org

Josh Poimboeuf (11):
  static_call: Improve key type abstraction
  static_call: Flip key type union bit
  static_call: Remove static_call_mod_init() declaration
  static_call: Remove static_call.h dependency on cpu.h
  static_call: Make ARCH_ADD_TRAMP_KEY() generic
  static_call: "EXPORT_STATIC_CALL_TRAMP" -> "EXPORT_STATIC_CALL_RO"
  static_call: Reorganize static call headers
  arm64/static_call: Fix static call CFI violations
  static_call: Make NULL static calls consistent
  static_call: Remove static_call_cond()
  static_call: Remove DEFINE_STATIC_CALL_RET0()

 arch/Kconfig                              |   4 +
 arch/arm/include/asm/paravirt.h           |   2 +-
 arch/arm64/include/asm/paravirt.h         |   2 +-
 arch/arm64/include/asm/static_call.h      |  29 ++
 arch/powerpc/include/asm/static_call.h    |   1 -
 arch/powerpc/kernel/irq.c                 |   2 +-
 arch/powerpc/kernel/static_call.c         |   6 +-
 arch/x86/events/amd/brs.c                 |   2 +-
 arch/x86/events/amd/core.c                |   2 +-
 arch/x86/events/core.c                    |  29 +-
 arch/x86/include/asm/kvm-x86-ops.h        |   6 +-
 arch/x86/include/asm/kvm-x86-pmu-ops.h    |   3 +-
 arch/x86/include/asm/kvm_host.h           |   4 +-
 arch/x86/include/asm/paravirt.h           |   2 +-
 arch/x86/include/asm/perf_event.h         |   2 +-
 arch/x86/include/asm/preempt.h            |   6 +-
 arch/x86/include/asm/static_call.h        |  22 +-
 arch/x86/kernel/alternative.c             |   6 -
 arch/x86/kernel/paravirt.c                |   1 +
 arch/x86/kernel/static_call.c             |  89 +-----
 arch/x86/kvm/irq.c                        |   2 +-
 arch/x86/kvm/lapic.c                      |  22 +-
 arch/x86/kvm/pmu.c                        |   4 +-
 arch/x86/kvm/x86.c                        |  28 +-
 block/bio.c                               |   1 +
 include/linux/entry-common.h              |   2 +-
 include/linux/entry-kvm.h                 |   2 +-
 include/linux/kernel.h                    |   4 +-
 include/linux/module.h                    |   2 +-
 include/linux/sched.h                     |   2 +-
 include/linux/static_call.h               | 369 ++++++++++------------
 include/linux/static_call_types.h         |  74 +----
 kernel/Makefile                           |   2 +-
 kernel/cgroup/cgroup.c                    |   1 +
 kernel/events/core.c                      |  15 +-
 kernel/sched/core.c                       |  18 +-
 kernel/static_call.c                      |  13 +
 kernel/static_call_inline.c               |  64 +++-
 security/keys/trusted-keys/trusted_core.c |   2 +-
 sound/soc/intel/avs/trace.c               |   1 +
 tools/include/linux/static_call_types.h   |  74 +----
 41 files changed, 369 insertions(+), 553 deletions(-)
 create mode 100644 arch/arm64/include/asm/static_call.h

-- 
2.39.2

