Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 529E262B1B8
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Nov 2022 04:13:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231913AbiKPDNf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Nov 2022 22:13:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231231AbiKPDNa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Nov 2022 22:13:30 -0500
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 734EC244
        for <linux-kernel@vger.kernel.org>; Tue, 15 Nov 2022 19:13:28 -0800 (PST)
Received: by mail-pl1-x62a.google.com with SMTP id k7so15214209pll.6
        for <linux-kernel@vger.kernel.org>; Tue, 15 Nov 2022 19:13:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=o7mzmekM7b4EuQmfkyfbxbQT4N8eepFsinPjqbtyCKE=;
        b=kX3d6lExIOuHVP0aTrAKIv5tdbIt6hj0I68RZirGPk3K9t3bAA8Z8+euow/gEYF2mD
         LSpX2xkdZEB6qGt9ZJAFpHTASMkDdBDnb+RSIEJe3DWyLk7c9TIR06bsVroh8EmuVpFd
         U+C3wN7BoTc1CZc0MydHWfmuksoBy37x3C7RnxendZ8tVpYEtLNsUuMaOS7mnEEAZN0o
         peWdKyTfjdB4LF9sMvV4c6xX63nptyKSoVtbIqtBVduA98EJ6i59aGCzXPNYfjdO+QVA
         kA//O/FsGR9XvVUyBmo1AKAgeII5QEKhb9K02J213m3Tbzl8QwmKI9ThoeoeBnLJ7iOL
         OZEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=o7mzmekM7b4EuQmfkyfbxbQT4N8eepFsinPjqbtyCKE=;
        b=Sql4AzAb/ALsI/qfI1FK6c6vWqoZWkH+SFnC1ynjZELc2JxkSL1kZlDoRw8tYHWKwi
         KBhnbn/0U3sHYAg7u33g9NAca9p4MTz5i5XPoVqZLPJ4NvfRh8v8xGpzMirkTjwJCFX/
         XoILZGE5Omh3n1bbjgLhrDf7Niq5KeqDTtvTmbm1IBbzrSDxM3rCy4JQc3aVA57MPEMJ
         VgwxjHn6G3JB77eQje/GFwHlqBycv+Rs61HadJltafsTK8WdCzbdaffduRnN75VPvd2t
         vZao1LdqveGdw6ZSd9eNFhQ5YITckZmJdOktwF3ue6P3L/gFZVyDXiDOiKhAR623zm21
         DtOg==
X-Gm-Message-State: ANoB5pnLbSbvjQKsfHSPrWM2JQpCBv4dyqZhBLTpiph8xaFLK8mDpQ6Z
        UB1kl9ySP/XG0gA5vopZlBl4YdEVvXo=
X-Google-Smtp-Source: AA0mqf5PgYJuqHrOwezSTS8rWopIiBJdf6luxzLQaLFYjhyKCFgETQA47M57FLg7/jaZKgxvNRiFJg==
X-Received: by 2002:a17:90a:4596:b0:1fd:5b5d:f09d with SMTP id v22-20020a17090a459600b001fd5b5df09dmr1607574pjg.69.1668568407736;
        Tue, 15 Nov 2022 19:13:27 -0800 (PST)
Received: from localhost.localdomain ([221.226.144.218])
        by smtp.gmail.com with ESMTPSA id ml22-20020a17090b361600b0020b2082e0acsm348295pjb.0.2022.11.15.19.13.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Nov 2022 19:13:27 -0800 (PST)
From:   Song Shuai <suagrfillet@gmail.com>
To:     guoren@kernel.org, rostedt@goodmis.org, mhiramat@kernel.org,
        mark.rutland@arm.com, paul.walmsley@sifive.com, palmer@dabbelt.com,
        aou@eecs.berkeley.edu
Cc:     linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        Song Shuai <suagrfillet@gmail.com>
Subject: [PATCH v2 0/3] riscv/ftrace: make function graph use ftrace directly
Date:   Wed, 16 Nov 2022 11:13:02 +0800
Message-Id: <20221116031305.286634-1-suagrfillet@gmail.com>
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

Changes since v1
-  fixed the checkpatch warnings in patch 1
Link: https://lore.kernel.org/linux-riscv/20221115061525.112757-1-suagrfillet@gmail.com

Song Shuai (3):
  riscv/ftrace: add ftrace_graph_func
  riscv/ftrace: SAVE_ALL supports lightweight save
  riscv/ftrace: cleanup ftrace_caller and ftrace_regs_caller

 arch/riscv/include/asm/ftrace.h |  13 ++-
 arch/riscv/kernel/ftrace.c      |  35 ++++----
 arch/riscv/kernel/mcount-dyn.S  | 145 +++++++++++++++++++++++---------
 3 files changed, 136 insertions(+), 57 deletions(-)

-- 
2.20.1

