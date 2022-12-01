Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 394A363F76B
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Dec 2022 19:22:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230488AbiLASWa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Dec 2022 13:22:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230020AbiLASW2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Dec 2022 13:22:28 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04EE7A431C
        for <linux-kernel@vger.kernel.org>; Thu,  1 Dec 2022 10:22:27 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id AC07BB81FC9
        for <linux-kernel@vger.kernel.org>; Thu,  1 Dec 2022 18:22:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D356BC433C1;
        Thu,  1 Dec 2022 18:22:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1669918944;
        bh=etaYTnvb8jilBA305rqN2Wt8ZpwsKzb1Ez7jSaYNMlY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Gw+Ns5angHf12QKT+OxnZZHaR6WaH2QtaY5MXF0VGVE8u6ulcMP7YGFCjlWWuH0tT
         a8mb1RThnEdsnIn6L7lYKi13AEWSnsaXW0ohcFYz/r2oYdupqwCRkkDzG+P5NCBKZS
         0ZtL3IkixlAwS6JmeQiai1xrbBo6WzS02kI2d+Tb4GccDzucriP176zVwfQHZfDWor
         whjijGXwjFV3KWoXHO9YjL8Oi3a+8xXl9W1gytDEihson+g/ypU2cxAmHmTgaZIf0A
         AgjQuxGTPZwUcTtSbJiMEhwf/0kKFysIrM41LV0GoWpMjTzVM3DVgYsIVXgMnNbDsc
         Pxa2ZL3TX97jA==
Date:   Thu, 1 Dec 2022 11:22:22 -0700
From:   Nathan Chancellor <nathan@kernel.org>
To:     John Ogness <john.ogness@linutronix.de>
Cc:     Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org, Miguel Ojeda <ojeda@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Paul E . McKenney" <paulmck@kernel.org>
Subject: Re: [PATCH printk v5 03/40] printk: Prepare for SRCU console list
 protection
Message-ID: <Y4jw3hSuwt3RG4DL@dev-arch.thelio-3990X>
References: <20221116162152.193147-1-john.ogness@linutronix.de>
 <20221116162152.193147-4-john.ogness@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221116162152.193147-4-john.ogness@linutronix.de>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi John,

On Wed, Nov 16, 2022 at 05:27:15PM +0106, John Ogness wrote:
> Provide an NMI-safe SRCU protected variant to walk the console list.
> 
> Note that all console fields are now set before adding the console
> to the list to avoid the console becoming visible by SCRU readers
> before being fully initialized.
> 
> This is a preparatory change for a new console infrastructure which
> operates independent of the console BKL.
> 
> Suggested-by: Thomas Gleixner <tglx@linutronix.de>
> Signed-off-by: John Ogness <john.ogness@linutronix.de>
> Acked-by: Miguel Ojeda <ojeda@kernel.org>
> Reviewed-by: Paul E. McKenney <paulmck@kernel.org>
> Reviewed-by: Petr Mladek <pmladek@suse.com>

I just bisected a boot hang to this change in -next as commit
621a912810a5 ("printk: Prepare for SRCU console list protection"); I
have included the bisect log at the end of this message.

The failure occurs while booting ARCH=powerpc pmac32_defconfig in QEMU,
during which I see the following message spammed constantly. I have
included reproduction steps below, assuming you can use kernel.org's
toolchains [1] (I used GCC 11.3.0):

$ make -skj$(nproc) ARCH=powerpc CROSS_COMPILE=powerpc-linux- mrproper pmac32_defconfig

# For proper serial console output
$ scripts/config -e SERIAL_PMACZILOG -e SERIAL_PMACZILOG_CONSOLE

$ make -skj$(nproc) ARCH=powerpc CROSS_COMPILE=powerpc-linux- olddefconfig vmlinux

$ qemu-system-ppc \
-append console=ttyS0 \
-display none \
-initrd rootfs.cpio \
-kernel vmlinux \
-m 128m \
-machine mac99 \
-nodefaults \
-no-reboot \
-serial mon:stdio
...
bad: scheduling from the idle thread!
CPU: 0 PID: 0 Comm: swapper Not tainted 6.1.0-rc1+ #1
Hardware name: PowerMac3,1 7400 0xc0209 PowerMac
Call Trace:
[c0bc1db0] [c07f07e0] dump_stack_lvl+0x34/0x50 (unreliable)
[c0bc1dd0] [c008429c] dequeue_task_idle+0x34/0x5c
[c0bc1df0] [c0820924] __schedule+0x56c/0x5c4
[c0bc1e40] [c08209d0] schedule+0x54/0xfc
[c0bc1e60] [c0826034] schedule_timeout+0x13c/0x194
[c0bc1ea0] [c082134c] __wait_for_common+0xcc/0x1f4
[c0bc1ee0] [c00ac8ac] synchronize_srcu+0xc8/0x12c
[c0bc1f20] [c00a0230] unregister_console+0xc8/0x10c
[c0bc1f40] [c009e314] register_console+0x2f4/0x390
[c0bc1f60] [c0a17510] pmz_console_init+0x34/0x48
[c0bc1f70] [c0a0491c] console_init+0x9c/0xf0
[c0bc1fa0] [c09f5584] start_kernel+0x588/0x6ac
[c0bc1ff0] [00003540] 0x3540
...

The rootfs can be downloaded from [2] at 'images/ppc32/rootfs.cpio.zst'
(just decompress it with 'zstd' first) or you can use 'boot-qemu.py' to
run QEMU automatically (pass '-h' to see the options available).

If there is any further information I can provide or patches I can test,
I am more than happy to do so.

Cheers,
Nathan

[1]: https://mirrors.edge.kernel.org/pub/tools/crosstool/
[2]: https://github.com/ClangBuiltLinux/boot-utils

# bad: [2934ceb4e967b9233d0f97732e47175574a11406] Add linux-next specific files for 20221201
# good: [ef4d3ea40565a781c25847e9cb96c1bd9f462bc6] afs: Fix server->active leak in afs_put_server
git bisect start '2934ceb4e967b9233d0f97732e47175574a11406' 'ef4d3ea40565a781c25847e9cb96c1bd9f462bc6'
# bad: [e21f15c77886e52e4cdb448933ffa9efff48695f] Merge branch 'master' of git://git.kernel.org/pub/scm/linux/kernel/git/herbert/cryptodev-2.6.git
git bisect bad e21f15c77886e52e4cdb448933ffa9efff48695f
# good: [dae6dd6a3a5774175b752856b1a19201317f591d] Merge branch 'for-next' of git://git.kernel.org/pub/scm/linux/kernel/git/viro/vfs.git
git bisect good dae6dd6a3a5774175b752856b1a19201317f591d
# good: [59b843691d726b332492d70038131d2fb584fc7c] selftests/bpf: Add bench test to arm64 and s390x denylist
git bisect good 59b843691d726b332492d70038131d2fb584fc7c
# bad: [0e4c3a93d8ac956c1697e376ba8f772d342cda6a] Merge branch 'master' of git://linuxtv.org/media_tree.git
git bisect bad 0e4c3a93d8ac956c1697e376ba8f772d342cda6a
# bad: [89e8355104a3b82372fe8ceae026a96097b823b9] Merge branch 'for-next' of git://git.kernel.org/pub/scm/linux/kernel/git/hid/hid.git
git bisect bad 89e8355104a3b82372fe8ceae026a96097b823b9
# bad: [9d9e2018111d42c49c34bc4c59e65163185cb1df] Merge branch 'next' of git://git.kernel.org/pub/scm/linux/kernel/git/helgaas/pci.git
git bisect bad 9d9e2018111d42c49c34bc4c59e65163185cb1df
# bad: [a04b46d8846f8c92bb7697554609d3ae5bc7efb9] Merge branch 'rework/console-list-lock' into for-next
git bisect bad a04b46d8846f8c92bb7697554609d3ae5bc7efb9
# bad: [1a30db5d04673703450f944b3141fd89c70afa70] tty: tty_io: use console_list_lock for list synchronization
git bisect bad 1a30db5d04673703450f944b3141fd89c70afa70
# bad: [feec6b0406f1b71798d31c48d5721b6461e4a636] proc: consoles: document console_lock usage
git bisect bad feec6b0406f1b71798d31c48d5721b6461e4a636
# good: [e29a4915db1480f96e0bc2e928699d086a71f43c] srcu: Debug NMI safety even on archs that don't require it
git bisect good e29a4915db1480f96e0bc2e928699d086a71f43c
# bad: [fd9e5fe0e2a8a8ffc159430eb7ee676978159432] printk: register_console: use "registered" for variable names
git bisect bad fd9e5fe0e2a8a8ffc159430eb7ee676978159432
# good: [c1313d1ab38deb6621045f7d70f0d34f19ec7cfc] serial: kgdboc: Lock console list in probe function
git bisect good c1313d1ab38deb6621045f7d70f0d34f19ec7cfc
# bad: [621a912810a582195eacd96a3536fd057376be21] printk: Prepare for SRCU console list protection
git bisect bad 621a912810a582195eacd96a3536fd057376be21
# good: [7f2dc96716485b01c65f564f2805c558eb0b1a10] printk: Convert console_drivers list to hlist
git bisect good 7f2dc96716485b01c65f564f2805c558eb0b1a1
# first bad commit: [621a912810a582195eacd96a3536fd057376be21] printk: Prepare for SRCU console list protection
