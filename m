Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F154C73FADD
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Jun 2023 13:16:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231248AbjF0LQc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Jun 2023 07:16:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229748AbjF0LQa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Jun 2023 07:16:30 -0400
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44C111FE2;
        Tue, 27 Jun 2023 04:16:29 -0700 (PDT)
Received: by mail-pf1-x42a.google.com with SMTP id d2e1a72fcca58-6686a05bc66so2689658b3a.1;
        Tue, 27 Jun 2023 04:16:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687864589; x=1690456589;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=b4EK0bo/MAX61tC7qBmeE8bLzdT0KVlSvicB6vVC5Lw=;
        b=DZMHAGISogIuqQFile94tAwrvvVEUmGRc2f8mu+bXijNryYjkGiF1ZxVnmaxozh7cD
         JLBCFmZuYRUC73Dp92IGhhc3TYzb3LOn6TdXEFyjfde/nP6UQkt3g2M68oViSTnO9+ZU
         2Q56/5YOciSNOvJNUUNFmaVzsxrV4hEGoRHQONkF9AVWffjAZWgdwRq4Pmm7UeepacCG
         Pe6f59NuU4Qc12pT/fxPvOQK9KM/m8F6Dv2zui5OQjIltp6ML4+gZ7yBL6xr0MZjgxto
         /XvpU/5DIzYl0PAItF601M0foRpdtzQg6ceYNCkf+t8Qcnh/WwzT3/iZfTTv8HseyZRA
         r0HQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687864589; x=1690456589;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=b4EK0bo/MAX61tC7qBmeE8bLzdT0KVlSvicB6vVC5Lw=;
        b=BglOXgRQ7PGwHPLnM2BZUwuiWpGV/Hc6N2KFs9bEAJxhKfuVtWK1zv2U8jXq6vfrrB
         5Akq1DIKu18nW6NRiy7LOl48AlgVTHrL/iuSXV786WXxas9c4tzrsqtvrx0b7w2tDKmP
         NqSfWPJ8K88qJDC2D1lPwCuJwBLm4M5vBuEFDZUCIGNgDw6vH0Ig2+0O1X+a6JwUifvR
         FDx6aL/U6RQPI6NQA3esVkqVHh7xNLpBapr+mrJSTRyfMTnbh38T0SetjaILevWC8n6I
         FgRm2h/mAgtB4VglgVa6vVEMv6THLMhS/gZ6J51t/OlR/WU13CrUYnGcH5B5Nt0IfIUH
         +QZA==
X-Gm-Message-State: AC+VfDx61i+EphnAK3VSAtIsIb+3QfTOwPfWPtQFmjFw3IOr5SE2YbOd
        b2v359Wt3s+awY8YlJK98iQ=
X-Google-Smtp-Source: ACHHUZ5f8DSTeQq2OL/PuvYB+lZRl9EqYj2BAHomzXGVpZRjEPvYY7uZjCqSvbm8gc+7d+uzmFRoAw==
X-Received: by 2002:a17:90a:ce17:b0:263:1661:1d1a with SMTP id f23-20020a17090ace1700b0026316611d1amr1264150pju.7.1687864588590;
        Tue, 27 Jun 2023 04:16:28 -0700 (PDT)
Received: from localhost.localdomain ([58.240.82.166])
        by smtp.gmail.com with ESMTPSA id 8-20020a17090a004800b00262d6ac0140sm5438658pjb.9.2023.06.27.04.16.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Jun 2023 04:16:28 -0700 (PDT)
From:   Song Shuai <suagrfillet@gmail.com>
To:     paul.walmsley@sifive.com, palmer@dabbelt.com,
        aou@eecs.berkeley.edu, rostedt@goodmis.org, mhiramat@kernel.org,
        mark.rutland@arm.com, guoren@kernel.org, suagrfillet@gmail.com,
        bjorn@rivosinc.com, jszhang@kernel.org, conor.dooley@microchip.com
Cc:     linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-trace-kernel@vger.kernel.org, songshuaishuai@tinylab.org
Subject: [PATCH V11 0/5] riscv: Optimize function trace
Date:   Tue, 27 Jun 2023 19:16:07 +0800
Message-Id: <20230627111612.761164-1-suagrfillet@gmail.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Changes in V11:

- append a patch that makes the DIRECT_CALL samples support RV32I in
  this series fixing the rv32 build failure reported by Palmer

- validated with ftrace boottime selftest and manual sample modules test
  in qemu-system for RV32I and RV64I

This series optimizes function trace. The first 3 independent 
patches has been picked in the V7 version of this series, the
subsequent version continues the following 4 patches:

select FTRACE_MCOUNT_USE_PATCHABLE_FUNCTION_ENTRY [1] (patch 1)
==========================================================

In RISC-V, -fpatchable-function-entry option is used to support
dynamic ftrace in this commit afc76b8b8011 ("riscv: Using
PATCHABLE_FUNCTION_ENTRY instead of MCOUNT"). So recordmcount
don't have to be called to create the __mcount_loc section before
the vmlinux linking.

Here selects FTRACE_MCOUNT_USE_PATCHABLE_FUNCTION_ENTRY to tell
Makefile not to run recordmcount.

Make function graph use ftrace directly [2] (patch 2)
======================================================== 

In RISC-V architecture, when we enable the ftrace_graph tracer on some
functions, the function tracings on other functions will suffer extra
graph tracing work. In essence, graph_ops isn't limited by its func_hash
due to the global ftrace_graph_[regs]_call label. That should be
corrected.

What inspires me is the commit 0c0593b45c9b ("x86/ftrace: Make function
graph use ftrace directly") that uses graph_ops::func function to
install return_hooker and makes the function called against its
func_hash.

Add WITH_DIRECT_CALLS support [3] (patch 3, 4)
==============================================

This series adds DYNAMIC_FTRACE_WITH_DIRECT_CALLS support for RISC-V.
SAMPLE_FTRACE_DIRECT and SAMPLE_FTRACE_DIRECT_MULTI are also included
here as the samples for testing DIRECT_CALLS related interface.

First, select the DYNAMIC_FTRACE_WITH_DIRECT_CALLS to provide 
register_ftrace_direct[_multi] interfaces allowing user to register 
the customed trampoline (direct_caller) as the mcount for one or 
more target functions. And modify_ftrace_direct[_multi] are also 
provided for modify direct_caller.

At the same time, the samples in ./samples/ftrace/ can be built
as kerenl module for testing these interfaces with SAMPLE_FTRACE_DIRECT
and SAMPLE_FTRACE_DIRECT_MULTI selected.

Second, to make the direct_caller and the other ftrace hooks
(eg. function/fgraph tracer, k[ret]probes) co-exist, a temporary
register
are nominated to store the address of direct_caller in
ftrace_regs_caller.
After the setting of the address direct_caller by direct_ops->func and
the RESTORE_REGS in ftrace_regs_caller, direct_caller will be jumped to
by the `jr` inst.

The series's old changes related these patches
==========================================

Changes in v10:
https://lore.kernel.org/all/20230511093234.3123181-1-suagrfillet@gmail.com/

- add Acked-by from Björn Töpel in patch 2 and patch 4 
- replace `move` with `mv` in patch3 
- prettify patch 2/4 with proper tabs

Changes in v9:
https://lore.kernel.org/linux-riscv/20230510101857.2953955-1-suagrfillet@gmail.com/

1. add Acked-by from Björn Töpel in patch 1

2. rebase patch2/patch3 on Linux v6.4-rc1

  - patch 2: to make the `SAVE_ABI_REGS` configurable, revert the
    modification of mcount-dyn.S from commit (45b32b946a97 "riscv:
entry: Consolidate general regs saving/restoring")

  - patch 3: to pass the trace_selftest, add the implement of
    `ftrace_stub_direct_tramp` from commit (fee86a4ed536 "ftrace:
selftest: remove broken trace_direct_tramp") ; and fixup the context
conflict in Kconfig 

Changes in v8:
https://lore.kernel.org/linux-riscv/20230324033342.3177979-1-suagrfillet@gmail.com/
 - Fix incorrect address values in the 4nd patch 
 - Rebased on v6.3-rc2

Changes in v7:
https://lore.kernel.org/linux-riscv/20230112090603.1295340-1-guoren@kernel.org/
 - Fixup RESTORE_ABI_REGS by remove PT_T0(sp) overwrite.
 - Add FTRACE_MCOUNT_USE_PATCHABLE_FUNCTION_ENTRY [1]
 - Fixup kconfig with HAVE_SAMPLE_FTRACE_DIRECT &
   HAVE_SAMPLE_FTRACE_DIRECT_MULTI

Changes in v6:
https://lore.kernel.org/linux-riscv/20230107133549.4192639-1-guoren@kernel.org/
 - Replace 8 with MCOUNT_INSN_SIZE
 - Replace "REG_L a1, PT_RA(sp)" with "mv a1, ra"
 - Add Evgenii Shatokhin comment

Changes in v5:
https://lore.kernel.org/linux-riscv/20221208091244.203407-1-guoren@kernel.org/
 - Sort Kconfig entries in alphabetical order.

Changes in v4:
https://lore.kernel.org/linux-riscv/20221129033230.255947-1-guoren@kernel.org/
 - Include [3] for maintenance. [Song Shuai]

Changes in V3:
https://lore.kernel.org/linux-riscv/20221123153950.2911981-1-guoren@kernel.org/
 - Include [2] for maintenance. [Song Shuai]

[1]: https://lore.kernel.org/linux-riscv/CAAYs2=j3Eak9vU6xbAw0zPuoh00rh8v5C2U3fePkokZFibWs2g@mail.gmail.com/T/#t
[2]: https://lore.kernel.org/lkml/20221120084230.910152-1-suagrfillet@gmail.com/
[3]: https://lore.kernel.org/linux-riscv/20221123142025.1504030-1-suagrfillet@gmail.com/ 

Song Shuai (5):
  riscv: select FTRACE_MCOUNT_USE_PATCHABLE_FUNCTION_ENTRY
  riscv: ftrace: Add ftrace_graph_func
  riscv: ftrace: Add DYNAMIC_FTRACE_WITH_DIRECT_CALLS support
  samples: ftrace: Add riscv support for SAMPLE_FTRACE_DIRECT[_MULTI]
  samples: ftrace: Make the riscv samples support RV32I

 arch/riscv/Kconfig                          |   4 +
 arch/riscv/include/asm/ftrace.h             |  19 +-
 arch/riscv/kernel/ftrace.c                  |  30 ++-
 arch/riscv/kernel/mcount-dyn.S              | 200 ++++++++++++++++----
 samples/ftrace/ftrace-direct-modify.c       |  35 ++++
 samples/ftrace/ftrace-direct-multi-modify.c |  41 ++++
 samples/ftrace/ftrace-direct-multi.c        |  25 +++
 samples/ftrace/ftrace-direct-too.c          |  28 +++
 samples/ftrace/ftrace-direct.c              |  24 +++
 9 files changed, 350 insertions(+), 56 deletions(-)

-- 
2.20.1

