Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5190A74DD67
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jul 2023 20:35:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232397AbjGJSfv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jul 2023 14:35:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229848AbjGJSfu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jul 2023 14:35:50 -0400
Received: from mail-pg1-x549.google.com (mail-pg1-x549.google.com [IPv6:2607:f8b0:4864:20::549])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD95B197
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jul 2023 11:35:48 -0700 (PDT)
Received: by mail-pg1-x549.google.com with SMTP id 41be03b00d2f7-55c1c7f872bso3709420a12.1
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jul 2023 11:35:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1689014148; x=1691606148;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=ii//NdDJV9WujsqukD3lwiIq5e/LyG2Fswag+05zH+E=;
        b=cRgD+oRUns5YzG9+1bpiaTGIpy4DKL/Xz7bJ7gRd9oD3Xn4lyqRtw/KGJjiH510MA6
         XYA0ZB6HRLE5cy7jDThnf/lxpm2EXODNGbqaAbL6N2igI2KXl0cOiRj7U/evNbfGna2K
         HfzwAQizTxP1bXa+6SRrdzB8mvpoeP9CEQhZ21NmL3Ag+Slaua582VWcKupdcO7zVBf0
         3ekYXBaPC6LyH8OID/IYa3j0DKmstgsoJ5ggVCFOEqoG3LW1b2AZF0q9ItrxjeqGDa7k
         W2tg6ArEqP2N38xhU5sfVF6WGzPabfsrUm/dNMJIzHuUVJkB9Nk1fhln4NbzAJ43fllB
         mmWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689014148; x=1691606148;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ii//NdDJV9WujsqukD3lwiIq5e/LyG2Fswag+05zH+E=;
        b=kKpx820x21Uh9SdRJvoXTgsG0qNF5vHKQbjv67zoWYm6YBfch4Rj3vS8DLuotv6e4M
         IjTns4Sabm1MtLIms9hDPyqJXPBjv8LH2af6EdrEwv5ytX+jkrZLSBX0rFQzMlyUx3WJ
         HrZ7rQcAdazatu6N6SQQexQRszsSkKIO0ikf3AKI3Ht4HLNr/OsK0qFywsib50KAUru5
         xqda12lyO5OY1prRSbtL8jwcDux3QXn7scTsuBO5UgwE0MACJZKmqM79UfoNAIfhVDGl
         LI0IF14iNOxzzVYGgdcCBKabyeUuZmpN+qFDvaCOmCPNMLRsGpGtrffbj/5e6jNuOJ+W
         ER8A==
X-Gm-Message-State: ABy/qLbMafKGPGeR+RqtFECLHZ7lAfCQoItj6B24j26NCCFQ7pumsm2t
        7CuCDYqeZHoKmPWN5r9xTblo8VHrzr1cCTC8piY=
X-Google-Smtp-Source: APBJJlGr9RJyCy/NTtd4U3G8YBzsr03Efxb2b0r6mb2spZfsYM39frOrlzfVt4txYLqSsSFhpgcb57zUbCLWzB6Duj0=
X-Received: from samitolvanen.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:4f92])
 (user=samitolvanen job=sendgmr) by 2002:a63:7747:0:b0:55c:5c30:33aa with SMTP
 id s68-20020a637747000000b0055c5c3033aamr174205pgc.9.1689014148087; Mon, 10
 Jul 2023 11:35:48 -0700 (PDT)
Date:   Mon, 10 Jul 2023 18:35:45 +0000
Mime-Version: 1.0
X-Developer-Key: i=samitolvanen@google.com; a=openpgp; fpr=35CCFB63B283D6D3AEB783944CB5F6848BBC56EE
X-Developer-Signature: v=1; a=openpgp-sha256; l=3192; i=samitolvanen@google.com;
 h=from:subject; bh=7OU2bpD9UM9q2xXwG7ynEd3jeDD83obc/zqrCIV8X8k=;
 b=owEB7QES/pANAwAKAUy19oSLvFbuAcsmYgBkrE+AhS2yuHhEWb37FLulyBDG6hxPDOCPp4ma4
 1wBuy7vRHaJAbMEAAEKAB0WIQQ1zPtjsoPW0663g5RMtfaEi7xW7gUCZKxPgAAKCRBMtfaEi7xW
 7roEC/4igkmPPv4O8DtGnr3voPUmeALLQLdA+F8M9Bn3HTFaVz4ioIvWtKmMezopiYJbIDUHGbt
 SDhgD1cRQvrBs4Uusc/ekdt5I3RNrXi0z6DJy+BoH4v1bwxQAurRzapGETRjEeAZGXacIEm8iRj
 54IfAkdnmWdi11rza4Efd2TxMPQquQLui+dmgNiuK9E/7Vo2/j5KWn8MyGP8axxbZgVM2KpGWHd
 EoHqu2niCWANM+elksiJly2S1XiaMQN5TpxUusyMQ01Bm9GtsZpSbF+RLl+P15RO7BuV+ToDSe9
 +C052grMu1y/NaRQqJlPq3RnHTsjhT6yCR7PvqfV2Nz8gbFi/JwVWQG6+bkISVbVah15Fpr5s9f
 6tL8b0o4dsMBjjN1mqqpKOSNfrFbOvrYSt/TtzIZnAxO/nYTEPNrAxdLxLnmW0ormlBt2YFgOjV H7GkBVLFi8Hs3P0GfQIei8SHfcJ+DZAIc5Q+SAJuUMabYv7kWkgKAb0PyzLv00PgaoHUk=
X-Mailer: git-send-email 2.41.0.255.g8b1d071c50-goog
Message-ID: <20230710183544.999540-8-samitolvanen@google.com>
Subject: [PATCH v2 0/6] riscv: KCFI support
From:   Sami Tolvanen <samitolvanen@google.com>
To:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Kees Cook <keescook@chromium.org>
Cc:     Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Conor Dooley <conor.dooley@microchip.com>,
        linux-riscv@lists.infradead.org, llvm@lists.linux.dev,
        linux-kernel@vger.kernel.org,
        Sami Tolvanen <samitolvanen@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series adds KCFI support for RISC-V. KCFI is a fine-grained
forward-edge control-flow integrity scheme supported in Clang >=16,
which ensures indirect calls in instrumented code can only branch to
functions whose type matches the function pointer type, thus making
code reuse attacks more difficult.

Patch 1 implements a pt_regs based syscall wrapper to address
function pointer type mismatches in syscall handling. Patches 2 and 3
annotate indirectly called assembly functions with CFI types. Patch 4
implements error handling for indirect call checks. Patch 5 disables
CFI for arch/riscv/purgatory. Patch 6 finally allows CONFIG_CFI_CLANG
to be enabled for RISC-V.

Note that Clang 16 has a generic architecture-agnostic KCFI
implementation, which does work with the kernel, but doesn't produce
a stable code sequence for indirect call checks, which means
potential failures just trap and won't result in informative error
messages. Clang 17 includes a RISC-V specific back-end implementation
for KCFI, which emits a predictable code sequence for the checks and a
.kcfi_traps section with locations of the traps, which patch 5 uses to
produce more useful errors.

The type mismatch fixes and annotations in the first three patches
also become necessary in future if the kernel decides to support
fine-grained CFI implemented using the hardware landing pad
feature proposed in the in-progress Zicfisslp extension. Once the
specification is ratified and hardware support emerges, implementing
runtime patching support that replaces KCFI instrumentation with
Zicfisslp landing pads might also be feasible (similarly to KCFI to
FineIBT patching on x86_64), allowing distributions to ship a unified
kernel binary for all devices.

---

Changes in v2:
  - Rebased on 6.5-rc1.
  - Sorted Kconfig entries alphabetically.


Sami Tolvanen (6):
  riscv: Implement syscall wrappers
  riscv: Add types to indirectly called assembly functions
  riscv: Add ftrace_stub_graph
  riscv: Add CFI error handling
  riscv/purgatory: Disable CFI
  riscv: Allow CONFIG_CFI_CLANG to be selected

 arch/riscv/Kconfig                       |  3 +
 arch/riscv/include/asm/cfi.h             | 22 ++++++
 arch/riscv/include/asm/insn.h            | 10 +++
 arch/riscv/include/asm/syscall.h         |  5 +-
 arch/riscv/include/asm/syscall_wrapper.h | 87 ++++++++++++++++++++++++
 arch/riscv/kernel/Makefile               |  2 +
 arch/riscv/kernel/cfi.c                  | 77 +++++++++++++++++++++
 arch/riscv/kernel/compat_syscall_table.c |  8 ++-
 arch/riscv/kernel/mcount.S               |  9 ++-
 arch/riscv/kernel/suspend_entry.S        |  5 +-
 arch/riscv/kernel/sys_riscv.c            |  6 ++
 arch/riscv/kernel/syscall_table.c        |  8 ++-
 arch/riscv/kernel/traps.c                |  4 +-
 arch/riscv/purgatory/Makefile            |  4 ++
 14 files changed, 238 insertions(+), 12 deletions(-)
 create mode 100644 arch/riscv/include/asm/cfi.h
 create mode 100644 arch/riscv/include/asm/syscall_wrapper.h
 create mode 100644 arch/riscv/kernel/cfi.c


base-commit: 06c2afb862f9da8dc5efa4b6076a0e48c3fbaaa5
-- 
2.41.0.255.g8b1d071c50-goog

