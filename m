Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 809966DE2CE
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Apr 2023 19:40:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230113AbjDKRkp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Apr 2023 13:40:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229631AbjDKRkl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Apr 2023 13:40:41 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F28E6E8E
        for <linux-kernel@vger.kernel.org>; Tue, 11 Apr 2023 10:40:21 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7FE6062858
        for <linux-kernel@vger.kernel.org>; Tue, 11 Apr 2023 17:40:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id BF445C433EF;
        Tue, 11 Apr 2023 17:40:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1681234819;
        bh=GZtan0aDYvfz7S+nGDKHusjvrOkU9PdTjM5nSWbDxz8=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=JtrAAs0lnFbUIMDj3IZUpBkAkbkQyNgDo8Rp209XcouyE0H5f5LLUzhgos5gWBsvg
         H43PILTKuVw4X7L5jvBv/TD8hb7sFnSo/kIpMnbW/ZV1TctjFf7LAIwRP0x5Fv7ABl
         mp0FsGPyiIKdtXMqJLkJ9KxoxOgsKl5rP6zSY4MDyPUALweuJpChJHhG331nTj0ZXn
         JP4NVF2FtvgroP65nmUgTiLEf2wOqs1uluSvl0gMftLOq1iYqR3x/IVU7Y70RaffBS
         CWvgyMmMDQXS2+8/5OEpwVoqs1FmTjq/j0dezJOCtpwZ0J9lNVoDe1MZvFy/I3zJn5
         kP1VvvYp5nrTg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 98D70E52443;
        Tue, 11 Apr 2023 17:40:19 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] riscv: entry: Save a0 prior syscall_enter_from_user_mode()
From:   patchwork-bot+linux-riscv@kernel.org
Message-Id: <168123481962.28886.3531781273059476912.git-patchwork-notify@kernel.org>
Date:   Tue, 11 Apr 2023 17:40:19 +0000
References: <20230403065207.1070974-1-bjorn@kernel.org>
In-Reply-To: <20230403065207.1070974-1-bjorn@kernel.org>
To:     =?utf-8?b?QmrDtnJuIFTDtnBlbCA8Ympvcm5Aa2VybmVsLm9yZz4=?=@ci.codeaurora.org
Cc:     linux-riscv@lists.infradead.org, aou@eecs.berkeley.edu,
        paul.walmsley@sifive.com, palmer@dabbelt.com,
        guoren@linux.alibaba.com, bjorn@rivosinc.com, heiko@sntech.de,
        conor@kernel.org, zouyipeng@huawei.com,
        linux-kernel@vger.kernel.org, palmer@rivosinc.com,
        heiko.stuebner@vrull.eu
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello:

This patch was applied to riscv/linux.git (for-next)
by Palmer Dabbelt <palmer@rivosinc.com>:

On Mon,  3 Apr 2023 08:52:07 +0200 you wrote:
> From: Björn Töpel <bjorn@rivosinc.com>
> 
> The RISC-V calling convention passes the first argument, and the
> return value in the a0 register. For this reason, the a0 register
> needs some extra care; When handling syscalls, the a0 register is
> saved into regs->orig_a0, so a0 can be properly restored for,
> e.g. interrupted syscalls.
> 
> [...]

Here is the summary with links:
  - riscv: entry: Save a0 prior syscall_enter_from_user_mode()
    https://git.kernel.org/riscv/c/9c2598d43510

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


