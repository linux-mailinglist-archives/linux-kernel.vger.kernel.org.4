Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 632D4624E39
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Nov 2022 00:10:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230507AbiKJXKT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Nov 2022 18:10:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229528AbiKJXKQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Nov 2022 18:10:16 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DEDAD43AC0
        for <linux-kernel@vger.kernel.org>; Thu, 10 Nov 2022 15:10:15 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 79440619EB
        for <linux-kernel@vger.kernel.org>; Thu, 10 Nov 2022 23:10:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id C0B52C433B5;
        Thu, 10 Nov 2022 23:10:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1668121814;
        bh=VyvqkhmfvPygyTuScNJXZ35iPK4Sj22wV1/y+Ggp/tY=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=CZvIgXJw+6iu2XihbXFAwtthepV+oKFqSYWpHYaHwqWiiEG/FB7GjbR4D2OI3vzpN
         +Ss9/h41QNNo6PVu7Y+kgEpy//esBa/jsxJb+ksTFNRSWA9daoPJOHDWWlE4d1Mthx
         zsouWiinAh9AtpYBE6tghOWBDckik4HHjrvbP3PO3ibZ7QcoN8WRgx6DSxq9t/RDuX
         tQ34eRnZoIjdiHAjEzWbYYttx8efwn9Wh1Pu15UZB2iW8PbrlnsxP+Rc/6jbfpOE4L
         h1ygdob3L0Z72ZHi/C0nNWy3z7knbO7LbnT2dQZMIqL8Yp7ZfvUnyDIASt5gXy25On
         g2LMp+zrsmGAQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id A6FA4C395F8;
        Thu, 10 Nov 2022 23:10:14 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v1] riscv: fix reserved memory setup
From:   patchwork-bot+linux-riscv@kernel.org
Message-Id: <166812181467.9076.159650897116586866.git-patchwork-notify@kernel.org>
Date:   Thu, 10 Nov 2022 23:10:14 +0000
References: <20221107151524.3941467-1-conor.dooley@microchip.com>
In-Reply-To: <20221107151524.3941467-1-conor.dooley@microchip.com>
To:     Conor Dooley <conor.dooley@microchip.com>
Cc:     linux-riscv@lists.infradead.org, palmer@dabbelt.com,
        paul.walmsley@sifive.com, aou@eecs.berkeley.edu,
        daire.mcnamara@microchip.com, anup@brainfault.org,
        atishp@rivosinc.com, mick@ics.forth.gr,
        linux-kernel@vger.kernel.org,
        valentina.fernandezalanis@microchip.com, e.shatokhin@yadro.com
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

On Mon, 7 Nov 2022 15:15:25 +0000 you wrote:
> Currently, RISC-V sets up reserved memory using the "early" copy of the
> device tree. As a result, when trying to get a reserved memory region
> using of_reserved_mem_lookup(), the pointer to reserved memory regions
> is using the early, pre-virtual-memory address which causes a kernel
> panic when trying to use the buffer's name:
> 
>  Unable to handle kernel paging request at virtual address 00000000401c31ac
>  Oops [#1]
>  Modules linked in:
>  CPU: 0 PID: 0 Comm: swapper Not tainted 6.0.0-rc1-00001-g0d9d6953d834 #1
>  Hardware name: Microchip PolarFire-SoC Icicle Kit (DT)
>  epc : string+0x4a/0xea
>   ra : vsnprintf+0x1e4/0x336
>  epc : ffffffff80335ea0 ra : ffffffff80338936 sp : ffffffff81203be0
>   gp : ffffffff812e0a98 tp : ffffffff8120de40 t0 : 0000000000000000
>   t1 : ffffffff81203e28 t2 : 7265736572203a46 s0 : ffffffff81203c20
>   s1 : ffffffff81203e28 a0 : ffffffff81203d22 a1 : 0000000000000000
>   a2 : ffffffff81203d08 a3 : 0000000081203d21 a4 : ffffffffffffffff
>   a5 : 00000000401c31ac a6 : ffff0a00ffffff04 a7 : ffffffffffffffff
>   s2 : ffffffff81203d08 s3 : ffffffff81203d00 s4 : 0000000000000008
>   s5 : ffffffff000000ff s6 : 0000000000ffffff s7 : 00000000ffffff00
>   s8 : ffffffff80d9821a s9 : ffffffff81203d22 s10: 0000000000000002
>   s11: ffffffff80d9821c t3 : ffffffff812f3617 t4 : ffffffff812f3617
>   t5 : ffffffff812f3618 t6 : ffffffff81203d08
>  status: 0000000200000100 badaddr: 00000000401c31ac cause: 000000000000000d
>  [<ffffffff80338936>] vsnprintf+0x1e4/0x336
>  [<ffffffff80055ae2>] vprintk_store+0xf6/0x344
>  [<ffffffff80055d86>] vprintk_emit+0x56/0x192
>  [<ffffffff80055ed8>] vprintk_default+0x16/0x1e
>  [<ffffffff800563d2>] vprintk+0x72/0x80
>  [<ffffffff806813b2>] _printk+0x36/0x50
>  [<ffffffff8068af48>] print_reserved_mem+0x1c/0x24
>  [<ffffffff808057ec>] paging_init+0x528/0x5bc
>  [<ffffffff808031ae>] setup_arch+0xd0/0x592
>  [<ffffffff8080070e>] start_kernel+0x82/0x73c
> 
> [...]

Here is the summary with links:
  - [v1] riscv: fix reserved memory setup
    https://git.kernel.org/riscv/c/50e63dd8ed92

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


