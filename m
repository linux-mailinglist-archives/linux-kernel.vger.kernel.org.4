Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E39663131F
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Nov 2022 09:42:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229618AbiKTImm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 20 Nov 2022 03:42:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229489AbiKTIml (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Nov 2022 03:42:41 -0500
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com [IPv6:2607:f8b0:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DAE2414D17
        for <linux-kernel@vger.kernel.org>; Sun, 20 Nov 2022 00:42:39 -0800 (PST)
Received: by mail-pf1-x436.google.com with SMTP id v28so8738842pfi.12
        for <linux-kernel@vger.kernel.org>; Sun, 20 Nov 2022 00:42:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=YLLHgVu/6CTNCGMLbnDOl9D7NCNUxklg4y/FnevzvKI=;
        b=lC2V7BJWGu1L7ZCHIWUuvL537rOWu3YnUXhBSedGqiNIZCRLyqla0T7KTPautB5ZBu
         DOEOIyA0VSEG8miWkw6c/vsxrMJILc2soRMJnICbKy1Dw9MCBTYGJ+CMMTCNen1behoh
         iT50vAortbZ9Qtx5JxEtbv+K3v4FrS7F7k6sxkr1IgNorJnGZFKr5/B6qYOMVLpAGYy7
         Y/P/6H5kOXUO2WqdDccvRhXbWkJKvhg6cPibiGHt4vn/yQE/tUmiQr8aGprc9SQQiml8
         43tx0gNpce0LYtOyXunRcI+DrRRqO/mwySlRrvzrf6Yj0zsgE41ksNQsIAlwzf5b4vSO
         leeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=YLLHgVu/6CTNCGMLbnDOl9D7NCNUxklg4y/FnevzvKI=;
        b=jgMrZHzT6GhSOcm8wO9xuxjwO6ipBWC0px9p3EpKxoGFjV4rbpgQubw0fKiYuFtd26
         fsUSlx3KGcLVdrHPOsFGa1zNtInZeS9nbiEUOdIyr2NQGGWRbrUrT4RhhKFH0og89ts8
         9fFB9vIt0OkEfn1+qF+5Lhkt/8ko4rwFUhyNvnygLpYNefmzH/q2rCUD1zMAYgDEgFEB
         UbvpiIUJXYcZw5y9UKyvHvJSgPer/2GuMDL0707fEZkVOKDgSw/dTx8Ht1g+z1KFzmRB
         Y9IVlNv3FCDX1bDoHmur0Xlno8+J7VV5wMmQX5yCJzKZrJo0r4JsJF/Dcb/7Ka+WCp8M
         EY0w==
X-Gm-Message-State: ANoB5plfK6CA9LlUuwM8JOe3ruqx55IMeOWZsDOcMldoth76HdgEVhj6
        31AtYVWnho72HPPz710vDYU=
X-Google-Smtp-Source: AA0mqf61DJ+/C/vy/vfKzM/CU0dXAD4HkN+480uYXxz4VId8Zh2VRFQctzdJ0MGTZ2Yq6dgVtlpBAQ==
X-Received: by 2002:a63:fb04:0:b0:476:7faf:e0bf with SMTP id o4-20020a63fb04000000b004767fafe0bfmr4311805pgh.80.1668933759284;
        Sun, 20 Nov 2022 00:42:39 -0800 (PST)
Received: from localhost.localdomain ([122.192.14.194])
        by smtp.gmail.com with ESMTPSA id q40-20020a17090a17ab00b00212735c8898sm8188273pja.30.2022.11.20.00.42.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 20 Nov 2022 00:42:38 -0800 (PST)
From:   Song Shuai <suagrfillet@gmail.com>
To:     guoren@kernel.org, rostedt@goodmis.org, mhiramat@kernel.org,
        mark.rutland@arm.com, paul.walmsley@sifive.com, palmer@dabbelt.com,
        aou@eecs.berkeley.edu
Cc:     linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        Song Shuai <suagrfillet@gmail.com>
Subject: [PATCH v4 0/2] riscv/ftrace: make function graph use ftrace directly
Date:   Sun, 20 Nov 2022 16:42:28 +0800
Message-Id: <20221120084230.910152-1-suagrfillet@gmail.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In RISC-V architecture, when we enable the ftrace_graph tracer on some
functions, the function tracings on other functions will suffer extra
graph tracing work. In essence, graph_ops isn't limited by its func_hash
due to the global ftrace_graph_[regs]_call label. That should be corrected.

What inspires me is the commit 0c0593b45c9b ("x86/ftrace: Make function
graph use ftrace directly") that uses graph_ops::func function to install
return_hooker and makes the function called against its func_hash.

This series of patches makes function graph use ftrace directly for riscv.

If FTRACE_WITH_REGS isn't defined, ftrace_caller keeps ftrace_graph_call
so that it can be replaced with the calling of prepare_ftrace_return by
the enable/disable helper.

As for defining FTRACE_WITH_REGS, ftrace_caller is adjusted to save the
necessary regs against the pt_regs layout, so it can reasonably call the
graph_ops::func function - ftrace_graph_func. And ftrace_graph_[regs]_call
and its enable/disable helper aren't needed.

The tests generated by CONFIG_FTRACE_STARTUP_TEST have passed in the local
qemu-system-riscv64 virt machine. The following is the log during startup.

```
Nov 15 03:07:13 stage4 kernel: Testing tracer function: PASSED
Nov 15 03:07:13 stage4 kernel: Testing dynamic ftrace: PASSED
Nov 15 03:07:13 stage4 kernel: Testing dynamic ftrace ops #1: 
Nov 15 03:07:13 stage4 kernel: (1 0 1 0 0)  
Nov 15 03:07:13 stage4 kernel: (1 1 2 0 0)  
Nov 15 03:07:13 stage4 kernel: (2 1 3 0 365) 
Nov 15 03:07:13 stage4 kernel: (2 2 4 0 399) 
Nov 15 03:07:13 stage4 kernel: (3 2 4 0 146071) 
Nov 15 03:07:13 stage4 kernel: (3 3 5 0 146105) PASSED
Nov 15 03:07:13 stage4 kernel: Testing dynamic ftrace ops #2: 
Nov 15 03:07:13 stage4 kernel: (1 0 1 589 0)  
Nov 15 03:07:13 stage4 kernel: (1 1 2 635 0)  
Nov 15 03:07:13 stage4 kernel: (2 1 3 1 2)  
Nov 15 03:07:13 stage4 kernel: (2 2 4 125 126) 
Nov 15 03:07:13 stage4 kernel: (3 2 4 146001 146078) 
Nov 15 03:07:13 stage4 kernel: (3 3 5 146035 146112) PASSED
Nov 15 03:07:13 stage4 kernel: Testing ftrace recursion: PASSED
Nov 15 03:07:13 stage4 kernel: Testing ftrace recursion safe: PASSED
Nov 15 03:07:13 stage4 kernel: Testing ftrace regs: PASSED
Nov 15 03:07:13 stage4 kernel: Testing tracer nop: PASSED
Nov 15 03:07:13 stage4 kernel: Testing tracer irqsoff: PASSED
Nov 15 03:07:13 stage4 kernel: Testing tracer wakeup:
Nov 15 03:07:13 stage4 kernel: sched: DL replenish lagged too much
Nov 15 03:07:13 stage4 kernel: PASSED
Nov 15 03:07:13 stage4 kernel: Testing tracer wakeup_rt: PASSED
Nov 15 03:07:13 stage4 kernel: Testing tracer wakeup_dl: PASSED
Nov 15 03:07:13 stage4 kernel: Testing tracer function_graph: PASSED
```

Note that the changes of mcount-dyn.S conflicts with this unmerged
commit (riscv: entry: consolidate general regs saving/restoring).
https://lore.kernel.org/linux-riscv/20221103075047.1634923-15-guoren@kernel.org

Changes since v3:
- separate parameters preparation as PREPARE_ARGS [Guo Ren]
v3 link: https://lore.kernel.org/linux-riscv/20221118173217.888077-1-suagrfillet@gmail.com/

Changes since v2:
- line up the comments [Andrew]
- rename SAVE_ALL as SAVE_ABI_REGS [Guo Ren]
- consolidate the modifications of mcount-dyn.S into one patch [Guo Ren]
- adapt this series based on [riscv: ftrace: Fixup ftrace detour code][1] [Guo Ren]

[1]: https://lore.kernel.org/linux-riscv/20220921034910.3142465-1-guoren@kernel.org/
v2 Link: https://lore.kernel.org/linux-riscv/20221116031305.286634-1-suagrfillet@gmail.com/

Changes since v1:
- fix the checkpatch warnings in patch 1
v1 Link: https://lore.kernel.org/linux-riscv/20221115061525.112757-1-suagrfillet@gmail.com

Song Shuai (2):
  riscv/ftrace: add ftrace_graph_func
  riscv/ftrace: make ftrace_caller call ftrace_graph_func

 arch/riscv/include/asm/ftrace.h |  13 ++-
 arch/riscv/kernel/ftrace.c      |  30 +++----
 arch/riscv/kernel/mcount-dyn.S  | 142 +++++++++++++++++++++++---------
 3 files changed, 128 insertions(+), 57 deletions(-)

-- 
2.20.1

