Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 208046B3444
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Mar 2023 03:30:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229927AbjCJCaX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Mar 2023 21:30:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229602AbjCJCaV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Mar 2023 21:30:21 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B476DAB96
        for <linux-kernel@vger.kernel.org>; Thu,  9 Mar 2023 18:30:20 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 021A960B24
        for <linux-kernel@vger.kernel.org>; Fri, 10 Mar 2023 02:30:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 58C4DC4339C;
        Fri, 10 Mar 2023 02:30:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678415419;
        bh=bKiV0Xvo7sKCXPxFTqkgixvqM/7sMqdz4rxmS27H1GY=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=g+H34xjQ0y3JWgpcbTfVs35aBKwqKBbqt6dapC/QV5y46CiCEefULoETmvPCGHy6v
         MdGyrYH9WqMY/IA5k4Ft4SV/SH9DtlQn1T++3jOBoaL9ydOibuKAoG6j8ixEqV0q71
         2CkYs8FNkgeV1VqGNYDHydho15PG68Ov5rD8OPbIe5ns9gBOeA0NXmQ4CaDbQlQEMn
         VmNYuZfUci6oJ+jNWQAe+XNRZCe1hzVAl6479qagFykjZzGICZ41/C4H0EmwxY/9d8
         W7kywPJuNDIwnfKyOcnoxDSTyTk3pMuIoEfx92pcZTFRZgPDo5c6tDkf8XUSmuTc6q
         UHIr80Ua5g/mw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 3174DE21EEA;
        Fri, 10 Mar 2023 02:30:19 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] riscv: Use READ_ONCE_NOCHECK in imprecise unwinding stack
 mode
From:   patchwork-bot+linux-riscv@kernel.org
Message-Id: <167841541919.17842.10261054652311897241.git-patchwork-notify@kernel.org>
Date:   Fri, 10 Mar 2023 02:30:19 +0000
References: <20230308091639.602024-1-alexghiti@rivosinc.com>
In-Reply-To: <20230308091639.602024-1-alexghiti@rivosinc.com>
To:     Alexandre Ghiti <alexghiti@rivosinc.com>
Cc:     linux-riscv@lists.infradead.org, paul.walmsley@sifive.com,
        palmer@dabbelt.com, aou@eecs.berkeley.edu,
        linux-kernel@vger.kernel.org, chathura.abeyrathne.lk@gmail.com,
        dvyukov@google.com
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

On Wed,  8 Mar 2023 10:16:39 +0100 you wrote:
> When CONFIG_FRAME_POINTER is unset, the stack unwinding function
> walk_stackframe randomly reads the stack and then, when KASAN is enabled,
> it can lead to the following backtrace:
> 
> [    0.000000] ==================================================================
> [    0.000000] BUG: KASAN: stack-out-of-bounds in walk_stackframe+0xa6/0x11a
> [    0.000000] Read of size 8 at addr ffffffff81807c40 by task swapper/0
> [    0.000000]
> [    0.000000] CPU: 0 PID: 0 Comm: swapper Not tainted 6.2.0-12919-g24203e6db61f #43
> [    0.000000] Hardware name: riscv-virtio,qemu (DT)
> [    0.000000] Call Trace:
> [    0.000000] [<ffffffff80007ba8>] walk_stackframe+0x0/0x11a
> [    0.000000] [<ffffffff80099ecc>] init_param_lock+0x26/0x2a
> [    0.000000] [<ffffffff80007c4a>] walk_stackframe+0xa2/0x11a
> [    0.000000] [<ffffffff80c49c80>] dump_stack_lvl+0x22/0x36
> [    0.000000] [<ffffffff80c3783e>] print_report+0x198/0x4a8
> [    0.000000] [<ffffffff80099ecc>] init_param_lock+0x26/0x2a
> [    0.000000] [<ffffffff80007c4a>] walk_stackframe+0xa2/0x11a
> [    0.000000] [<ffffffff8015f68a>] kasan_report+0x9a/0xc8
> [    0.000000] [<ffffffff80007c4a>] walk_stackframe+0xa2/0x11a
> [    0.000000] [<ffffffff80007c4a>] walk_stackframe+0xa2/0x11a
> [    0.000000] [<ffffffff8006e99c>] desc_make_final+0x80/0x84
> [    0.000000] [<ffffffff8009a04e>] stack_trace_save+0x88/0xa6
> [    0.000000] [<ffffffff80099fc2>] filter_irq_stacks+0x72/0x76
> [    0.000000] [<ffffffff8006b95e>] devkmsg_read+0x32a/0x32e
> [    0.000000] [<ffffffff8015ec16>] kasan_save_stack+0x28/0x52
> [    0.000000] [<ffffffff8006e998>] desc_make_final+0x7c/0x84
> [    0.000000] [<ffffffff8009a04a>] stack_trace_save+0x84/0xa6
> [    0.000000] [<ffffffff8015ec52>] kasan_set_track+0x12/0x20
> [    0.000000] [<ffffffff8015f22e>] __kasan_slab_alloc+0x58/0x5e
> [    0.000000] [<ffffffff8015e7ea>] __kmem_cache_create+0x21e/0x39a
> [    0.000000] [<ffffffff80e133ac>] create_boot_cache+0x70/0x9c
> [    0.000000] [<ffffffff80e17ab2>] kmem_cache_init+0x6c/0x11e
> [    0.000000] [<ffffffff80e00fd6>] mm_init+0xd8/0xfe
> [    0.000000] [<ffffffff80e011d8>] start_kernel+0x190/0x3ca
> [    0.000000]
> [    0.000000] The buggy address belongs to stack of task swapper/0
> [    0.000000]  and is located at offset 0 in frame:
> [    0.000000]  stack_trace_save+0x0/0xa6
> [    0.000000]
> [    0.000000] This frame has 1 object:
> [    0.000000]  [32, 56) 'c'
> [    0.000000]
> [    0.000000] The buggy address belongs to the physical page:
> [    0.000000] page:(____ptrval____) refcount:1 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x81a07
> [    0.000000] flags: 0x1000(reserved|zone=0)
> [    0.000000] raw: 0000000000001000 ff600003f1e3d150 ff600003f1e3d150 0000000000000000
> [    0.000000] raw: 0000000000000000 0000000000000000 00000001ffffffff
> [    0.000000] page dumped because: kasan: bad access detected
> [    0.000000]
> [    0.000000] Memory state around the buggy address:
> [    0.000000]  ffffffff81807b00: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> [    0.000000]  ffffffff81807b80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> [    0.000000] >ffffffff81807c00: 00 00 00 00 00 00 00 00 f1 f1 f1 f1 00 00 00 f3
> [    0.000000]                                            ^
> [    0.000000]  ffffffff81807c80: f3 f3 f3 f3 00 00 00 00 00 00 00 00 00 00 00 00
> [    0.000000]  ffffffff81807d00: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> [    0.000000] ==================================================================
> 
> [...]

Here is the summary with links:
  - riscv: Use READ_ONCE_NOCHECK in imprecise unwinding stack mode
    https://git.kernel.org/riscv/c/76950340cf03

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


