Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AAF0D69BD22
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Feb 2023 22:45:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229889AbjBRVmd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 18 Feb 2023 16:42:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229751AbjBRVmc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Feb 2023 16:42:32 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9698E13D7D
        for <linux-kernel@vger.kernel.org>; Sat, 18 Feb 2023 13:42:31 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 066F960BC5
        for <linux-kernel@vger.kernel.org>; Sat, 18 Feb 2023 21:42:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 5B125C4339B;
        Sat, 18 Feb 2023 21:42:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1676756550;
        bh=inKpTNdeTXJQXc2kCE2ygH8R+rkjnBMFxu5iAD5Thhc=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=YoETc/4lf2iWwhemc7pZhBdWs4vOKxeaEzVQa4XFrgFn4RXny6giIeAYJ4DVFC7DX
         QvkHisTrLxOtSACIHGyYZqpd18nBzUYqhM2vZrkHNYnmfnK1if7rLmFXZ8/UWrNddq
         72GbrXvqhINAOP0FHDYNryxwfwlwRVK5ybQhz8kc6k+WUdiWSDyxQgRu2paonOMcz1
         E6sMh+SZZmJDSuZhZjRYkrE31CvQOo4VQl/QYlrIu9neStQQcT40sCZGUlrzbgUQYL
         N2bRpQNVOX8MsGcZ4KZdebPo4+1rXxDBVc15aWD4lkBaTOuhn7Iuz5Bs4Cl+YteUGj
         md1dZxKhhVjhw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 3B7D8E68D2F;
        Sat, 18 Feb 2023 21:42:30 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH -next V7 0/7] riscv: Optimize function trace
From:   patchwork-bot+linux-riscv@kernel.org
Message-Id: <167675655023.26920.11250197941763068411.git-patchwork-notify@kernel.org>
Date:   Sat, 18 Feb 2023 21:42:30 +0000
References: <20230112090603.1295340-1-guoren@kernel.org>
In-Reply-To: <20230112090603.1295340-1-guoren@kernel.org>
To:     Guo Ren <guoren@kernel.org>
Cc:     linux-riscv@lists.infradead.org, anup@brainfault.org,
        paul.walmsley@sifive.com, palmer@dabbelt.com,
        conor.dooley@microchip.com, heiko@sntech.de, rostedt@goodmis.org,
        mhiramat@kernel.org, jolsa@redhat.com, bp@suse.de,
        jpoimboe@kernel.org, suagrfillet@gmail.com, andy.chiu@sifive.com,
        e.shatokhin@yadro.com, linux-kernel@vger.kernel.org,
        guoren@linux.alibaba.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello:

This series was applied to riscv/linux.git (for-next)
by Palmer Dabbelt <palmer@rivosinc.com>:

On Thu, 12 Jan 2023 04:05:56 -0500 you wrote:
> From: Guo Ren <guoren@linux.alibaba.com>
> 
> The previous ftrace detour implementation fc76b8b8011 ("riscv: Using
> PATCHABLE_FUNCTION_ENTRY instead of MCOUNT") contain three problems.
> 
>  - The most horrible bug is preemption panic which found by Andy [1].
>    Let's disable preemption for ftrace first, and Andy could continue
>    the ftrace preemption work.
>  - The "-fpatchable-function-entry= CFLAG" wasted code size
>    !RISCV_ISA_C.
>  - The ftrace detour implementation wasted code size.
>  - When livepatching, the trampoline (ftrace_regs_caller) would not
>    return to <func_prolog+12> but would rather jump to the new function.
>    So, "REG_L ra, -SZREG(sp)" would not run and the original return
>    address would not be restored. The kernel is likely to hang or crash
>    as a result. (Found by Evgenii Shatokhin [4])
> 
> [...]

Here is the summary with links:
  - [-next,V7,1/7] riscv: ftrace: Fixup panic by disabling preemption
    https://git.kernel.org/riscv/c/8547649981e6
  - [-next,V7,2/7] riscv: ftrace: Remove wasted nops for !RISCV_ISA_C
    https://git.kernel.org/riscv/c/409c8fb20c66
  - [-next,V7,3/7] riscv: ftrace: Reduce the detour code size to half
    https://git.kernel.org/riscv/c/6724a76cff85
  - [-next,V7,4/7] riscv: ftrace: Add ftrace_graph_func
    (no matching commit)
  - [-next,V7,5/7] riscv: ftrace: Add DYNAMIC_FTRACE_WITH_DIRECT_CALLS support
    (no matching commit)
  - [-next,V7,6/7] samples: ftrace: Add riscv support for SAMPLE_FTRACE_DIRECT[_MULTI]
    (no matching commit)
  - [-next,V7,7/7] riscv : select FTRACE_MCOUNT_USE_PATCHABLE_FUNCTION_ENTRY
    (no matching commit)

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


