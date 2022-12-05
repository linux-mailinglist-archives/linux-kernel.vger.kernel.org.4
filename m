Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9460B64383E
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Dec 2022 23:40:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233529AbiLEWkW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Dec 2022 17:40:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230235AbiLEWkS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Dec 2022 17:40:18 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 260A9CCA
        for <linux-kernel@vger.kernel.org>; Mon,  5 Dec 2022 14:40:18 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id BE76CB81598
        for <linux-kernel@vger.kernel.org>; Mon,  5 Dec 2022 22:40:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 628D0C433D7;
        Mon,  5 Dec 2022 22:40:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1670280015;
        bh=GJt2tQnd1Xeds2lIE0ThsvUpUJvK+iSYvNujEq1ftUg=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=ULBvvhhRvzK9LCZR4X9G0JzAec6adclarvUv/8MLd/rjJzfztFmatqkSoyCgJRuGL
         SIi2UK/GRQW9t8WokcK0Wbd/p6AR/cWPn6gAJ/y/7DH3i/mgoJrCHkjRFzYxmKmB/w
         urjm3vyEWuL0YxU22XjqgwZ8BQwiq1LLYpB0BAj8JCNtD+BFmfnv0vxsBtBH3k1HIz
         f827gvGp4Ryr9gJcPyQCW1UTXJKG8feJj92SF3hbOXoKgJqyhKEVUa7oI7DaSEKDPS
         UZrryZGmvAdqq1qEpKzICkzKLZHie3ShizgtkK5hXETBgPIi2e3XdkbiekmcQtO78A
         pH653pZlFQXyQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 47B59C395E5;
        Mon,  5 Dec 2022 22:40:15 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH 1/2] RISC-V: kexec: Fix memory leak of fdt buffer
From:   patchwork-bot+linux-riscv@kernel.org
Message-Id: <167028001528.27830.840137402099225328.git-patchwork-notify@kernel.org>
Date:   Mon, 05 Dec 2022 22:40:15 +0000
References: <20221104095658.141222-1-lihuafei1@huawei.com>
In-Reply-To: <20221104095658.141222-1-lihuafei1@huawei.com>
To:     Li Huafei <lihuafei1@huawei.com>
Cc:     linux-riscv@lists.infradead.org, paul.walmsley@sifive.com,
        palmer@dabbelt.com, aou@eecs.berkeley.edu, lizhengyu3@huawei.com,
        liaochang1@huawei.com, u.kleine-koenig@pengutronix.de,
        rdunlap@infradead.org, linux-kernel@vger.kernel.org,
        kexec@lists.infradead.org
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello:

This series was applied to riscv/linux.git (for-next)
by Palmer Dabbelt <palmer@rivosinc.com>:

On Fri, 4 Nov 2022 17:56:57 +0800 you wrote:
> This is reported by kmemleak detector:
> 
> unreferenced object 0xff60000082864000 (size 9588):
>   comm "kexec", pid 146, jiffies 4294900634 (age 64.788s)
>   hex dump (first 32 bytes):
>     d0 0d fe ed 00 00 12 ed 00 00 00 48 00 00 11 40  ...........H...@
>     00 00 00 28 00 00 00 11 00 00 00 02 00 00 00 00  ...(............
>   backtrace:
>     [<00000000f95b17c4>] kmemleak_alloc+0x34/0x3e
>     [<00000000b9ec8e3e>] kmalloc_order+0x9c/0xc4
>     [<00000000a95cf02e>] kmalloc_order_trace+0x34/0xb6
>     [<00000000f01e68b4>] __kmalloc+0x5c2/0x62a
>     [<000000002bd497b2>] kvmalloc_node+0x66/0xd6
>     [<00000000906542fa>] of_kexec_alloc_and_setup_fdt+0xa6/0x6ea
>     [<00000000e1166bde>] elf_kexec_load+0x206/0x4ec
>     [<0000000036548e09>] kexec_image_load_default+0x40/0x4c
>     [<0000000079fbe1b4>] sys_kexec_file_load+0x1c4/0x322
>     [<0000000040c62c03>] ret_from_syscall+0x0/0x2
> 
> [...]

Here is the summary with links:
  - [1/2] RISC-V: kexec: Fix memory leak of fdt buffer
    https://git.kernel.org/riscv/c/96df59b1ae23
  - [2/2] RISC-V: kexec: Fix memory leak of elf header buffer
    https://git.kernel.org/riscv/c/cbc32023ddbd

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


