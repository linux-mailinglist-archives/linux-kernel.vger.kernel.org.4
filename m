Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E2528624DCB
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Nov 2022 23:50:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231735AbiKJWuW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Nov 2022 17:50:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230180AbiKJWuU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Nov 2022 17:50:20 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04E935288C
        for <linux-kernel@vger.kernel.org>; Thu, 10 Nov 2022 14:50:19 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id AE08CB823D1
        for <linux-kernel@vger.kernel.org>; Thu, 10 Nov 2022 22:50:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 55259C43470;
        Thu, 10 Nov 2022 22:50:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1668120616;
        bh=M9LAVYZ92Xll7tzRG+y7J0TmMOHu9UY1fOYopwYmZt4=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=Oa1rCgaNhIhQdb8PE2MFAjrFYbwvbhkuXGRx2MghWoNI2X1I6Xa0v2UpQGYG2KqNa
         7dvJngTKnR58Svu/JR/O7BdIgOB70XTMX3i6Hb3/DVn4ueD12XC4P9ACzUTb8CpCXQ
         zZgCMjJZfjm6zpkp94kNLfAuRfN1PBxqxOPwr1mqJDS5lTAQ4P0y3lOdhiBCLj+WvJ
         HOAxru9PLRPEDUKR/cnunk0CxCHE4jMsv8T/7txoZxlT7Ks73fcBVFWf5pih07fUur
         aENYbtp2r4p/FfeOUolp7vwzelvPqqjJsWw+HiKuTU+ehWXnh8Prh6CT/wEwwYIM19
         ZLx8PhkbzOXmg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 25CA3E270EF;
        Thu, 10 Nov 2022 22:50:16 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] riscv: vdso: fix build with llvm
From:   patchwork-bot+linux-riscv@kernel.org
Message-Id: <166812061615.32242.2820818026881124201.git-patchwork-notify@kernel.org>
Date:   Thu, 10 Nov 2022 22:50:16 +0000
References: <20221031182943.2453-1-jszhang@kernel.org>
In-Reply-To: <20221031182943.2453-1-jszhang@kernel.org>
To:     Jisheng Zhang <jszhang@kernel.org>
Cc:     linux-riscv@lists.infradead.org, paul.walmsley@sifive.com,
        palmer@dabbelt.com, aou@eecs.berkeley.edu,
        linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello:

This patch was applied to riscv/linux.git (fixes)
by Palmer Dabbelt <palmer@rivosinc.com>:

On Tue,  1 Nov 2022 02:29:43 +0800 you wrote:
> Even after commit 89fd4a1df829 ("riscv: jump_label: mark arguments as
> const to satisfy asm constraints"), building with CC_OPTIMIZE_FOR_SIZE
> + LLVM=1 can reproduce below build error:
> 
>   CC      arch/riscv/kernel/vdso/vgettimeofday.o
> In file included from <built-in>:4:
> In file included from lib/vdso/gettimeofday.c:5:
> In file included from include/vdso/datapage.h:17:
> In file included from
> include/vdso/processor.h:10:
> In file included from
> arch/riscv/include/asm/vdso/processor.h:7:
> In file included from
> include/linux/jump_label.h:112:
> arch/riscv/include/asm/jump_label.h:42:3: error:
> invalid operand fo
> r inline asm constraint 'i'
>                 "       .option push                            \n\t"
>                 ^
> 1 error generated.
> 
> [...]

Here is the summary with links:
  - riscv: vdso: fix build with llvm
    https://git.kernel.org/riscv/c/50f4dd657a0f

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


