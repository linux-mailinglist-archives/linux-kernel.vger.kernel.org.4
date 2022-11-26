Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 94603639825
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Nov 2022 20:25:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229606AbiKZTZI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 26 Nov 2022 14:25:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229480AbiKZTZH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Nov 2022 14:25:07 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4EBD214030
        for <linux-kernel@vger.kernel.org>; Sat, 26 Nov 2022 11:25:06 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id CE76560B40
        for <linux-kernel@vger.kernel.org>; Sat, 26 Nov 2022 19:25:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C97E2C433C1;
        Sat, 26 Nov 2022 19:25:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1669490705;
        bh=RWZn7M9dfjDS3n5ZFrwvBBoWwy9tta0co/UuIk20qiY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=fV2YLPdQMYdcgvl9cGHyjYtNoZZWxQHE7N8I8/2TPMYZzx6CieO+kqhkK2gy2s7ZK
         BWmEtoybvYoSxg0qiJmuSeqT6sB0A2gNXq/kZ175Sl7C6RiNieFEhQ0BBub3yVfbK0
         JehQu2kglKSCpxCjvMtVj+i5zNl/3EwlVcZwfkMcHoH+tVKsQJAG89r5T2jagKVsxK
         W52V+qcvq19LvCC6bdlkDhMsPZd1nu4+cN6JGqxdW6ZclVAYzr2wxIPsQ2S0njD6Wx
         lhe/nHlqN3j5uS8pONvoJ+ijECLZeJc6i6j/gLo3HW/Tetqrrzt9DWpHd+DAobD4KQ
         l9ARkR3tskPLA==
Date:   Sat, 26 Nov 2022 19:25:01 +0000
From:   Conor Dooley <conor@kernel.org>
To:     Andrea Righi <andrea.righi@canonical.com>
Cc:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Emil Renner Berthing <emil.renner.berthing@canonical.com>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] riscv: increase boot command line size to 1K
Message-ID: <Y4JoDSXOLepJX8mI@spud>
References: <20221125133713.314796-1-andrea.righi@canonical.com>
 <Y4Je7chN+fQM3NpP@spud>
 <Y4Jmk74enBTwkNcR@righiandr-XPS-13-7390>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y4Jmk74enBTwkNcR@righiandr-XPS-13-7390>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Nov 26, 2022 at 08:18:43PM +0100, Andrea Righi wrote:
> On Sat, Nov 26, 2022 at 06:46:05PM +0000, Conor Dooley wrote:
> > Hey Andrea,
> > 
> > On Fri, Nov 25, 2022 at 02:37:13PM +0100, Andrea Righi wrote:
> > > Kernel parameters string is limited to 512 characters on riscv (using
> > > the default from include/uapi/asm-generic/setup.h).
> > > 
> > > In some testing environments (e.g., qemu with long kernel parameters
> > > string) we may exceed this limit, triggering errors like the following:
> > > 
> > > [    3.331893] Kernel panic - not syncing: Attempted to kill init! exitcode=0x00000000
> > > [    3.332625] CPU: 2 PID: 1 Comm: sh Not tainted 6.1.0-rc6-kc #1
> > > [    3.333233] Hardware name: riscv-virtio,qemu (DT)
> > > [    3.333550] Call Trace:
> > > [    3.333736] [<ffffffff800062b6>] dump_backtrace+0x1c/0x24
> > > [    3.334053] [<ffffffff806e8f54>] show_stack+0x2c/0x38
> > > [    3.334260] [<ffffffff806f2d06>] dump_stack_lvl+0x5a/0x7c
> > > [    3.334483] [<ffffffff806f2d3c>] dump_stack+0x14/0x1c
> > > [    3.334687] [<ffffffff806e92fa>] panic+0x116/0x2d0
> > > [    3.334878] [<ffffffff8001b0aa>] do_exit+0x80a/0x810
> > > [    3.335079] [<ffffffff8001b1d0>] do_group_exit+0x24/0x70
> > > [    3.335287] [<ffffffff8001b234>] __wake_up_parent+0x0/0x20
> > > [    3.335502] [<ffffffff80003cee>] ret_from_syscall+0x0/0x2
> > > [    3.335857] SMP: stopping secondary CPUs
> > > [    3.337561] ---[ end Kernel panic - not syncing: Attempted to kill init! exitcode=0x00000000 ]---
> > > 
> > > It seems reasonable enough to increase the default command line size to
> > > 1024, like arm, to prevent issues like the one reported above.
> > 
> > error: arch/riscv/include/uapi/asm/setup.h: missing "WITH Linux-syscall-note" for SPDX-License-Identifier
> > 
> > Unfortunately this does not build :/
> > 
> > Thanks,
> > Conor.
> 
> Oh I see, because it's uapi it needs "WITH Linux-syscall-note",
> wondering why I can't reproduce this failure...

tuxmake --wrapper ccache --target-arch riscv --directory . \
	--environment=KBUILD_BUILD_TIMESTAMP=@1621270510 \
	--environment=KBUILD_BUILD_USER=tuxmake --environment=KBUILD_BUILD_HOST=tuxmake \
	-o $tmpdir --toolchain llvm -z none -k rv32_defconfig

(copy paste from a script)
That's what caught it initially & I think should be reproduce able. My
own standard build script also runs all of the HDRINST stuff if they've
changed since the last time a given toolchain was used so it reproduces
locally for me too.

> Anyway, as pointed out by Alexandre, there was already a previous
> discussion about this topic:
> https://lore.kernel.org/lkml/CACT4Y+YYAfTafFk7DE0B=qQFgkPXS7492AhBdY_CP1WdB8CGfA@mail.gmail.com/T/
> 
> Hopefully this change will be addressed there (and the patch land in
> -next at least), otherwise I'll post a v2.

Yup, I noticed that thread - in fact I was going to link it yesterday
before I saw Alex already had ;)

Thanks,
Conor.

