Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C6ABE62FBBE
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Nov 2022 18:34:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235224AbiKRReA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Nov 2022 12:34:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242302AbiKRRdR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Nov 2022 12:33:17 -0500
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2524C976C2
        for <linux-kernel@vger.kernel.org>; Fri, 18 Nov 2022 09:32:30 -0800 (PST)
Received: by mail-pf1-x42f.google.com with SMTP id 140so5510996pfz.6
        for <linux-kernel@vger.kernel.org>; Fri, 18 Nov 2022 09:32:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=6lJ5gRcc7MMYSZVBgs/lVKCNpnkRvG9H5V/gHPoXFec=;
        b=mEVBeU/paftGIY37idqL5pt0S5LUHdqXb3s/vzcvKjn9W1d6LU9ECN2sZS3D0kL12Y
         nHppj6K6p2gNJbo3DGq6yO0Kf4zs0Vjm7FP60eQ5In4/IC1wmhWnysqsfF5EMjjdO1Kc
         t8mK3esr1OkuDB+hhj/xnex2u5mImr+QMEWzMsoYiUIcrt3FF5Jg7HW4ezYTevyOArs8
         bxUf4AZI7TsJOyycRdTHvwuwdd5nx6sJxVR7SN2x919+E5fhTtY4ypPvTV0ywoHJgH/w
         V6BILDr8nTsx1vwBpEcJw2I3vRGF3kqIUP1befh+9mNgP7DVdpThwk7xJNAjDdPQMFvL
         nzpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6lJ5gRcc7MMYSZVBgs/lVKCNpnkRvG9H5V/gHPoXFec=;
        b=zMkpOAup8nzXuNENb3nRVZQDYXm+GphqZCKn2DHaFcTT9azKKgXENDaFhMERVridIU
         lEZg2v7a7OcQKNUyKgkBjXcy0singf7mjelFozXqXunklyAf5GKtaR+/4cSd3vB6oLKb
         H6SJkcNzU3hp66SZZJqJb+g/3DSlF6mgNJzA7mF8MAQc6+bKL8qGZ2En/Gqdibd0HjDF
         LErva0Vn6kTkLoiDAJKEtsKXzerXtXP96TXFi+MDgfURMWcVXPvOcbY5MrDjjjo2naK5
         tunr1mTVlBjMgYs8zUpH69/NPeQBoqvZnJQfl1MX/XfXd32AouMPUujntsw9SOj2t+YB
         d+3w==
X-Gm-Message-State: ANoB5pnVr8ZVKKCN04gizZBBC173gXCU8vvyEmf4n20oCiMeqhYYxnV3
        KIYEF9BZiMXMrd/MEKTuy6A=
X-Google-Smtp-Source: AA0mqf6DbhB9UmdLqEtvQbQUt5I4PhHPNfLF2iIu8ry6zdE/U1sbPKXd5jJ1JIABu32Uz9cS2WdAzw==
X-Received: by 2002:a63:de01:0:b0:476:32a2:253 with SMTP id f1-20020a63de01000000b0047632a20253mr7809888pgg.133.1668792749585;
        Fri, 18 Nov 2022 09:32:29 -0800 (PST)
Received: from localhost.localdomain ([112.2.231.196])
        by smtp.gmail.com with ESMTPSA id u7-20020a656707000000b00476b6b7f339sm3037979pgf.11.2022.11.18.09.32.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Nov 2022 09:32:28 -0800 (PST)
From:   Song Shuai <suagrfillet@gmail.com>
To:     guoren@kernel.org, rostedt@goodmis.org, mhiramat@kernel.org,
        mark.rutland@arm.com, paul.walmsley@sifive.com, palmer@dabbelt.com,
        aou@eecs.berkeley.edu
Cc:     linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        Song Shuai <suagrfillet@gmail.com>
Subject: [PATCH v3 0/2] riscv/ftrace: make function graph use ftrace directly
Date:   Sat, 19 Nov 2022 01:32:15 +0800
Message-Id: <20221118173217.888077-1-suagrfillet@gmail.com>
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
 arch/riscv/kernel/mcount-dyn.S  | 143 +++++++++++++++++++++++---------
 3 files changed, 129 insertions(+), 57 deletions(-)

-- 
2.20.1

