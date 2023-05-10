Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E78116FDB7C
	for <lists+linux-kernel@lfdr.de>; Wed, 10 May 2023 12:19:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236509AbjEJKTW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 May 2023 06:19:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229500AbjEJKTT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 May 2023 06:19:19 -0400
Received: from mail-pg1-x535.google.com (mail-pg1-x535.google.com [IPv6:2607:f8b0:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D886199A;
        Wed, 10 May 2023 03:19:18 -0700 (PDT)
Received: by mail-pg1-x535.google.com with SMTP id 41be03b00d2f7-52c6504974dso6366221a12.2;
        Wed, 10 May 2023 03:19:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683713958; x=1686305958;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=6TzFaeCtsMyNHK5TeH92zz3hB8ciuzOv3glPd5m6k7I=;
        b=eNSMyA+YCxWztneHcmukaT6xLcQ5dhXTjeJ22Z4Xi9+ur68aJtIRfqtcCJ//xaoRwY
         1eLdkqWNRgI50/CW131HJI7Q2VbMxOHANI9AplmX3a0L9ULkG5pq3RCah0piqw4x49TX
         Cx28bKfGFVRUU0f35kS0UH4jd9k8wbT5ZCY5JZEs66GfrVLp2OAByBne4AjCxZ+TaO7i
         4wiW19mEF4pw6Q7dQfUqy4+TAbMEkb7/2dbeIwVrhSeD87HcF5j4DYWmu0Cjvk9hU/by
         G150n2etnUnAoLmlPWZbhU/Q8aEjIZciXVUPN42e0wVp0aqzIHQAHL7pkbylJXD6zIY+
         Lrow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683713958; x=1686305958;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6TzFaeCtsMyNHK5TeH92zz3hB8ciuzOv3glPd5m6k7I=;
        b=KTB/zKxP3gwOWcWn0A6/NhttU7G8o59hKGgXjSgRrFYWx0LGaCkoeUaHj8F/IYzQ7T
         MMrTEyS46hzy+ZJ7xfpoaJyz7QwKee5P09hGz4x+48xisq8/8DOUlZPT+8Fgf7ovbcVw
         UFG7d7Js2/3TzKfc2X1gkw2UPRF/xpLV2n436srNegnI5J0kRDvxlpLkuOk1rKyCIjEp
         pTB38nphUJLHMxwb9hBQbsx75GM1UFiTinp57lDz9vnVh3ydBpCm5Kpou1KblYwA0aBF
         czFk+qUu5x1oCJgiDnIofFOhkzq8GOCeWccsRQjyjNOwiJMFleC8wdk+jxQgeWIp3qnY
         LAEQ==
X-Gm-Message-State: AC+VfDyZDlxi2eM/IdPpyEFSyJR0AE3GsoI98AzeqFYflgkO0Yq12sid
        Az54rs1TBbetKWGDDyxwo24=
X-Google-Smtp-Source: ACHHUZ6tDzveM5eOKzKrGk213LFBmv5V4FVEwtFB/+ed+zvaz7MwM+K1L7Xavv4Vhy/NAiw+g+hCmA==
X-Received: by 2002:a17:903:185:b0:1a1:e237:5f0 with SMTP id z5-20020a170903018500b001a1e23705f0mr22428195plg.58.1683713957671;
        Wed, 10 May 2023 03:19:17 -0700 (PDT)
Received: from localhost.localdomain ([221.226.144.218])
        by smtp.gmail.com with ESMTPSA id p16-20020a170902e75000b001aadd0d7364sm3393419plf.83.2023.05.10.03.19.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 May 2023 03:19:17 -0700 (PDT)
From:   Song Shuai <suagrfillet@gmail.com>
To:     paul.walmsley@sifive.com, palmer@dabbelt.com,
        aou@eecs.berkeley.edu, rostedt@goodmis.org, mhiramat@kernel.org,
        mark.rutland@arm.com, guoren@kernel.org, suagrfillet@gmail.com,
        jszhang@kernel.org, e.shatokhin@yadro.com
Cc:     linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-trace-kernel@vger.kernel.org
Subject: [PATCH V9 0/4] riscv: Optimize function trace
Date:   Wed, 10 May 2023 18:18:53 +0800
Message-Id: <20230510101857.2953955-1-suagrfillet@gmail.com>
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

Changes in v9:

1. add Acked-by from Björn Töpel in patch 1

2. rebase patch2/patch3 on Linux v6.4-rc1

  - patch 2: to make the `SAVE_ABI_REGS` configurable, revert the
    modification of mcount-dyn.S from commit (45b32b946a97 "riscv:
entry: Consolidate general regs saving/restoring")

  - patch 3: to pass the trace_selftest, add the implement of
    `ftrace_stub_direct_tramp` from commit (fee86a4ed536 "ftrace:
selftest: remove broken trace_direct_tramp") ; and fixup the context
conflict in Kconfig 

You can directly try it with:

https://github.com/sugarfillet/linux/tree/6.4-rc1-rv-ftrace-v9


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

Song Shuai (4):
  riscv: select FTRACE_MCOUNT_USE_PATCHABLE_FUNCTION_ENTRY
  riscv: ftrace: Add ftrace_graph_func
  riscv: ftrace: Add DYNAMIC_FTRACE_WITH_DIRECT_CALLS support
  samples: ftrace: Add riscv support for SAMPLE_FTRACE_DIRECT[_MULTI]

 arch/riscv/Kconfig                          |   4 +
 arch/riscv/include/asm/ftrace.h             |  19 ++-
 arch/riscv/kernel/ftrace.c                  |  30 ++--
 arch/riscv/kernel/mcount-dyn.S              | 176 +++++++++++++++++---
 samples/ftrace/ftrace-direct-modify.c       |  33 ++++
 samples/ftrace/ftrace-direct-multi-modify.c |  39 +++++
 samples/ftrace/ftrace-direct-multi.c        |  23 +++
 samples/ftrace/ftrace-direct-too.c          |  26 +++
 samples/ftrace/ftrace-direct.c              |  22 +++
 9 files changed, 328 insertions(+), 44 deletions(-)

-- 
2.20.1

