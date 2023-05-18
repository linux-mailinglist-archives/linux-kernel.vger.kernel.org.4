Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 63A607088E9
	for <lists+linux-kernel@lfdr.de>; Thu, 18 May 2023 22:02:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230098AbjERUC1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 May 2023 16:02:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230060AbjERUCZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 May 2023 16:02:25 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27200E4F
        for <linux-kernel@vger.kernel.org>; Thu, 18 May 2023 13:02:24 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B2E4E651F4
        for <linux-kernel@vger.kernel.org>; Thu, 18 May 2023 20:02:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B918EC433D2;
        Thu, 18 May 2023 20:02:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1684440143;
        bh=UIdscq9ovWZR/uuYAsfRx5k5jKXZrbwOP57t1m8V5VY=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=vkTKp2X8rq2NEoGqFiMUh7EgG2jZsuKn+VFFybe45mF1Bf+0LpBwdbPK6IlIvPEf5
         v5oAEhcIDQALM6giGuT0OqKloSjC5V3Wtg9syUMeMyIJfNujBzVgehdvrk9zZx5W7o
         Sas/CaTw/R8oJSFyeJmeGS3LkZr9ohxw0UCFgnMo=
Date:   Thu, 18 May 2023 13:02:21 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Angus Chen <angus.chen@jaguarmicro.com>
Cc:     masahiroy@kernel.org, vbabka@suse.cz, peterz@infradead.org,
        ndesaulniers@google.com, paulmck@kernel.org, rppt@kernel.org,
        linux-kernel@vger.kernel.org, Al Viro <viro@zeniv.linux.org.uk>
Subject: Re: [PATCH] init: Add bdev fs printk if mount_block_root failed
Message-Id: <20230518130221.81e8e1f474cfbfd6c93712c5@linux-foundation.org>
In-Reply-To: <20230518035321.1672-1-angus.chen@jaguarmicro.com>
References: <20230518035321.1672-1-angus.chen@jaguarmicro.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 18 May 2023 11:53:21 +0800 Angus Chen <angus.chen@jaguarmicro.com> wrote:

> Attempt to printk all bdev fstype as root gives the following kernel panic:
> 
> [    1.729006] VFS: Cannot open root device "vda" or unknown-block(253,0): error -19
> [    1.730603] Please append a correct "root=" boot option; here are the available partitions:
> [    1.732323] fd00          256000 vda
> [    1.732329]  driver: virtio_blk
> [    1.734194] Kernel panic - not syncing: VFS: Unable to mount root fs on unknown-block(253,0)
> [    1.734771] CPU: 0 PID: 1 Comm: swapper/0 Not tainted 6.4.0-rc2+ #53
> [    1.735194] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.10.2-1ubuntu1 04/01/2014
> [    1.735772] Call Trace:
> [    1.735950]  <TASK>
> [    1.736113]  dump_stack_lvl+0x32/0x50
> [    1.736367]  panic+0x108/0x310
> [    1.736570]  mount_block_root+0x161/0x310
> [    1.736849]  ? rdinit_setup+0x40/0x40
> [    1.737088]  prepare_namespace+0x10c/0x180
> [    1.737393]  kernel_init_freeable+0x354/0x450
> [    1.737707]  ? rest_init+0xd0/0xd0
> [    1.737945]  kernel_init+0x16/0x130
> [    1.738196]  ret_from_fork+0x1f/0x30
> 
> QEMU command line:
> "qemu-system-x86_64 -append root=/dev/vda rootfstype=ext4 ..."
> 
> This error is because ext4 is not buildin and request ext4 module fail.
> 
> As a hint, printk all the bdev fstype available for prompts.
> 

Seems reasonable.  I reworded the changelog a bit:

: Booting with the QEMU command line:
: "qemu-system-x86_64 -append root=/dev/vda rootfstype=ext4 ..."
: will panic if ext4 is not builtin and a request to load the ext4 module
: fails.
: 
: [    1.729006] VFS: Cannot open root device "vda" or unknown-block(253,0): error -19
: [    1.730603] Please append a correct "root=" boot option; here are the available partitions:
: [    1.732323] fd00          256000 vda
: [    1.732329]  driver: virtio_blk
: [    1.734194] Kernel panic - not syncing: VFS: Unable to mount root fs on unknown-block(253,0)
: [    1.734771] CPU: 0 PID: 1 Comm: swapper/0 Not tainted 6.4.0-rc2+ #53
: [    1.735194] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.10.2-1ubuntu1 04/01/2014
: [    1.735772] Call Trace:
: [    1.735950]  <TASK>
: [    1.736113]  dump_stack_lvl+0x32/0x50
: [    1.736367]  panic+0x108/0x310
: [    1.736570]  mount_block_root+0x161/0x310
: [    1.736849]  ? rdinit_setup+0x40/0x40
: [    1.737088]  prepare_namespace+0x10c/0x180
: [    1.737393]  kernel_init_freeable+0x354/0x450
: [    1.737707]  ? rest_init+0xd0/0xd0
: [    1.737945]  kernel_init+0x16/0x130
: [    1.738196]  ret_from_fork+0x1f/0x30
: 
: As a hint, print all the bdev fstypes which are available.

> --- a/init/do_mounts.c
> +++ b/init/do_mounts.c
> @@ -427,8 +427,19 @@ void __init mount_block_root(char *name, int flags)
>  		printk("VFS: Cannot open root device \"%s\" or %s: error %d\n",
>  				root_device_name, b, err);
>  		printk("Please append a correct \"root=\" boot option; here are the available partitions:\n");
> -
>  		printk_all_partitions();
> +
> +		if (root_fs_names)
> +			num_fs = list_bdev_fs_names(fs_names, PAGE_SIZE);
> +		if (!num_fs)
> +			pr_err("Can't find any bdev filesystem to be used for mount!\n");
> +		else {
> +			pr_err("List of all bdev filesystem:\n");
> +			for (i = 0, p = fs_names; i < num_fs; i++, p += strlen(p)+1)
> +				pr_err(" %s", p);
> +			pr_err("\n");
> +		}
> +
>  		panic("VFS: Unable to mount root fs on %s", b);
>  	}
>  	if (!(flags & SB_RDONLY)) {

And I added a little fix.

--- a/init/do_mounts.c~init-add-bdev-fs-printk-if-mount_block_root-failed-fix
+++ a/init/do_mounts.c
@@ -434,7 +434,7 @@ retry:
 		if (!num_fs)
 			pr_err("Can't find any bdev filesystem to be used for mount!\n");
 		else {
-			pr_err("List of all bdev filesystem:\n");
+			pr_err("List of all bdev filesystems:\n");
 			for (i = 0, p = fs_names; i < num_fs; i++, p += strlen(p)+1)
 				pr_err(" %s", p);
 			pr_err("\n");
_


This function now uses a jumble of printk() and pr_err().  Perhaps
someone will go through and rationalize all of this sometime.

