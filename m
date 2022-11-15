Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5BF8B6291C1
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Nov 2022 07:15:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230199AbiKOGPh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Nov 2022 01:15:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229455AbiKOGPf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Nov 2022 01:15:35 -0500
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1757D13F2B
        for <linux-kernel@vger.kernel.org>; Mon, 14 Nov 2022 22:15:35 -0800 (PST)
Received: by mail-pl1-x629.google.com with SMTP id y4so12263179plb.2
        for <linux-kernel@vger.kernel.org>; Mon, 14 Nov 2022 22:15:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=S87JB0jXS/1245zlp0DfUQH9YtzFG2T1WCf/d65ubvA=;
        b=iSRK/t7aVPl926xpswpdT3LP5BxwCAfSZTOr7OwGkPaB6PX+IHx2rN87Ku3TbXpmC1
         bXlFK58LjE5mA0EVy4VMO/CrkaIkEYxrxU+rsB5Kx+TQ12svkXhH1iEMhRQWFvEMC0iS
         e9k6fWxHKBwHYCWdRQwWfk9rZ0O+tIxHolbbuPN7l30PqZ3vzHu4lZAVnUVgk/mpF45u
         SsGioiYvicOfDBnPVkfa41C8i/1sBlveGVnXkW6K/zFTyu0Pv1o595FfvfOwhK6Y0R62
         5vlloVDw494RdCcagfk0y91X52r7ihZGSmuZJZ3iO7i1eeYPni0+7fqJT6MiVW/f9PSZ
         otiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=S87JB0jXS/1245zlp0DfUQH9YtzFG2T1WCf/d65ubvA=;
        b=41Avy0AUi6pRwTPETNtF8kBagAOKEtix3nTeNqo5Tx4kEW37RFbuCkR7er9r9MhTkT
         CfNAGrmMtEWBFxA2SviuMX+1iVzhm1yzi0STp7XdcWO+qBzU5Qz0I14KPG+lmzqGZgZh
         teGhsxRNlpDeb2S5oV21BL7iPgm89BhXGEondu1okvIFoN/5dSFTJAtDWmABwZDaoRMN
         OJwV6awohJ19huWjKJpmHmk2eR673XFjmJ65YmAnX2BlM+OKuWHb1639VkdApJyMZSG2
         +bbYXRlEmiKQHo5toLdaLI3WZHV4/cEGmSRfFMnYtQBmBdY1VvmiXOtLFahEXcubRAqS
         rH6w==
X-Gm-Message-State: ANoB5pnQINAfZvmSmvqRl82wJ+5c1zYpav5FrecYTvQGPovo5g5cXxc9
        1RaDbutch2k3F7BFsn/guahoynN3dDI=
X-Google-Smtp-Source: AA0mqf6GLQkOG+1nRPuyrln1cg9/qE9hPWTcUF2NcqOY3pLgJSG8Xf9e/WYv2vYh++6oTI3xz3VtbA==
X-Received: by 2002:a17:90b:48cb:b0:212:e2e9:a522 with SMTP id li11-20020a17090b48cb00b00212e2e9a522mr699407pjb.55.1668492934466;
        Mon, 14 Nov 2022 22:15:34 -0800 (PST)
Received: from localhost.localdomain ([221.226.144.218])
        by smtp.gmail.com with ESMTPSA id p9-20020a1709027ec900b0017f57787a4asm8736769plb.229.2022.11.14.22.15.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Nov 2022 22:15:34 -0800 (PST)
From:   Song Shuai <suagrfillet@gmail.com>
To:     guoren@kernel.org, rostedt@goodmis.org, mhiramat@kernel.org,
        mark.rutland@arm.com, paul.walmsley@sifive.com, palmer@dabbelt.com,
        aou@eecs.berkeley.edu
Cc:     linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        Song Shuai <suagrfillet@gmail.com>
Subject: [PATCH 0/3] riscv/ftrace: make function graph use ftrace directly
Date:   Tue, 15 Nov 2022 14:15:22 +0800
Message-Id: <20221115061525.112757-1-suagrfillet@gmail.com>
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
https://lore.kernel.org/linux-riscv/20221103075047.1634923-15-guoren@kernel.org/

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

