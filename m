Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 675CF623658
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Nov 2022 23:09:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231980AbiKIWJ0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Nov 2022 17:09:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231461AbiKIWJY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Nov 2022 17:09:24 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85EDE31DCA;
        Wed,  9 Nov 2022 14:09:23 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1DC6C61D10;
        Wed,  9 Nov 2022 22:09:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 80CC0C433C1;
        Wed,  9 Nov 2022 22:09:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1668031762;
        bh=EEuQTpyT1zPNFWqBtPvayqZV0Fn9C13LbP5RzTMs8eU=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=gJ9QSlxr6erAibGR21TtwGkp8wF9nDvqhVn9FrBA1LpJWUM7V1zXDczhDQ/LP0AyG
         kO733GQfSN2+9TSFIuFGOCwxkzoz3PcPoUovXPFvtfYDHEO7MsNoVP7ibifWx8eL1Q
         ZjFJ9HKeVdVPc2i65qr5abZsQ5x0FnrPh6jqOIpcwyy2sSbddxN3CH+yisQoHJMiRn
         BUqi+8Ug5WDGZ0fHLy5CnJU6oTOPp8uDyPwv9vqFF+M1e0OcUrPsei/Ie9M3O7zNEx
         3j7pnpdco81mDInbhTjnCwCa26fjJk6BiSD+saOh2fNWlkQ3sj5DFF80d6c94GgjKN
         IqnFW+sbKF8BA==
Received: by mail-ej1-f43.google.com with SMTP id b2so415881eja.6;
        Wed, 09 Nov 2022 14:09:22 -0800 (PST)
X-Gm-Message-State: ACrzQf3Dccp6vqoqvV1cgleEIS0Usl3kqwr939YpFV1l3C6eSCMX5nuU
        lPjRgaoRZvSb6NL9wVM0BITkkmtLdnsL34uzvX8=
X-Google-Smtp-Source: AMsMyM5xvsgX6rY8Jb800SV/ASKHK57y5X0DlYVXG9EfNtmQmr4vZZrSMU1oLP5rxkXKOzcmrPep0GjfewOQz0wwpf0=
X-Received: by 2002:a17:907:75ef:b0:78e:17ad:ba62 with SMTP id
 jz15-20020a17090775ef00b0078e17adba62mr1822224ejc.719.1668031760673; Wed, 09
 Nov 2022 14:09:20 -0800 (PST)
MIME-Version: 1.0
References: <20221107141659.2680-1-jiang.li1388@gmail.com>
In-Reply-To: <20221107141659.2680-1-jiang.li1388@gmail.com>
From:   Song Liu <song@kernel.org>
Date:   Wed, 9 Nov 2022 14:09:08 -0800
X-Gmail-Original-Message-ID: <CAPhsuW5_r8JrV5F=B6fV5T8eKQ+eu8xk06eCZq-=MdxNNEykkw@mail.gmail.com>
Message-ID: <CAPhsuW5_r8JrV5F=B6fV5T8eKQ+eu8xk06eCZq-=MdxNNEykkw@mail.gmail.com>
Subject: Re: [PATCH V3 1/1] md/raid1: stop mdx_raid1 thread when raid1 array
 run failed
To:     Jiang Li <jiang.li1388@gmail.com>
Cc:     linux-raid@vger.kernel.org, linux-kernel@vger.kernel.org,
        lijiang@ugreen.com, Jiang Li <jiang.li@ugreen.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 7, 2022 at 6:17 AM Jiang Li <jiang.li1388@gmail.com> wrote:
>
> From: Jiang Li <jiang.li@ugreen.com>
>
> fail run raid1 array when we assemble array with the inactive disk only,
> but the mdx_raid1 thread were not stop, Even if the associated resources
> have been released. it will caused a NULL dereference when we do poweroff.
>
> This causes the following Oops:
>     [  287.587787] BUG: kernel NULL pointer dereference, address: 0000000000000070
>     [  287.594762] #PF: supervisor read access in kernel mode
>     [  287.599912] #PF: error_code(0x0000) - not-present page
>     [  287.605061] PGD 0 P4D 0
>     [  287.607612] Oops: 0000 [#1] SMP NOPTI
>     [  287.611287] CPU: 3 PID: 5265 Comm: md0_raid1 Tainted: G     U            5.10.146 #0
>     [  287.619029] Hardware name: xxxxxxx/To be filled by O.E.M, BIOS 5.19 06/16/2022
>     [  287.626775] RIP: 0010:md_check_recovery+0x57/0x500 [md_mod]
>     [  287.632357] Code: fe 01 00 00 48 83 bb 10 03 00 00 00 74 08 48 89 ......
>     [  287.651118] RSP: 0018:ffffc90000433d78 EFLAGS: 00010202
>     [  287.656347] RAX: 0000000000000000 RBX: ffff888105986800 RCX: 0000000000000000
>     [  287.663491] RDX: ffffc90000433bb0 RSI: 00000000ffffefff RDI: ffff888105986800
>     [  287.670634] RBP: ffffc90000433da0 R08: 0000000000000000 R09: c0000000ffffefff
>     [  287.677771] R10: 0000000000000001 R11: ffffc90000433ba8 R12: ffff888105986800
>     [  287.684907] R13: 0000000000000000 R14: fffffffffffffe00 R15: ffff888100b6b500
>     [  287.692052] FS:  0000000000000000(0000) GS:ffff888277f80000(0000) knlGS:0000000000000000
>     [  287.700149] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>     [  287.705897] CR2: 0000000000000070 CR3: 000000000320a000 CR4: 0000000000350ee0
>     [  287.713033] Call Trace:
>     [  287.715498]  raid1d+0x6c/0xbbb [raid1]
>     [  287.719256]  ? __schedule+0x1ff/0x760
>     [  287.722930]  ? schedule+0x3b/0xb0
>     [  287.726260]  ? schedule_timeout+0x1ed/0x290
>     [  287.730456]  ? __switch_to+0x11f/0x400
>     [  287.734219]  md_thread+0xe9/0x140 [md_mod]
>     [  287.738328]  ? md_thread+0xe9/0x140 [md_mod]
>     [  287.742601]  ? wait_woken+0x80/0x80
>     [  287.746097]  ? md_register_thread+0xe0/0xe0 [md_mod]
>     [  287.751064]  kthread+0x11a/0x140
>     [  287.754300]  ? kthread_park+0x90/0x90
>     [  287.757974]  ret_from_fork+0x1f/0x30
>
> In fact, when raid1 array run fail, we need to do
> md_unregister_thread() before raid1_free().
>
> Signed-off-by: Jiang Li <jiang.li@ugreen.com>

Applied to md-next. Thanks!
Song

> ---
> Hi,
> my full name is Jiang Li. Thanks!
>
> The following steps can be used to reproduce the problem:
> mdadm --create /dev/md0 --level=1  --raid-devices=2 /dev/sd[a-b]
> mdadm -A /dev/md0 /dev/sd[a-b]
> mkfs.ext4  /dev/md0
> mount /dev/md0   /mnt/md0
>
> mdadm -S /dev/md0
>
> mdadm -A /dev/md0 /dev/sda   --run
> mount /dev/md0   /mnt/md0
> #Store a certain amount of data, so that the rebuilding will not be completed in a short time
> dd if=/dev/urandom of=/mnt/md0/test.db bs=1M count=40960
>
> mdadm --add /dev/md0 /dev/sdb
> sleep 1
> #when the array were rebuilding, we stop the array.
> umount /dev/md0
> mdadm -S  /dev/md0
>
> #assemble array with the sdb only in --run insist mode:
> mdadm -A /dev/md0 /dev/sdb  --run
>
> #md run fail with kernel message as follow:
> [  850.593441] md: md0 stopped.
> [  850.672071] md: pers->run() failed ...
> [  850.686913] md: md0 stopped.
>
> #we can see the md0_raid1 thread were not stop:
> $ps -ef | grep raid1
> root      5672     2  0 Oct31 ?        00:00:04 [md0_raid1]
>
> #now, do poweroff can reproduce the problem.
>
>  drivers/md/raid1.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/drivers/md/raid1.c b/drivers/md/raid1.c
> index 05d8438cfec8..58f705f42948 100644
> --- a/drivers/md/raid1.c
> +++ b/drivers/md/raid1.c
> @@ -3159,6 +3159,7 @@ static int raid1_run(struct mddev *mddev)
>          * RAID1 needs at least one disk in active
>          */
>         if (conf->raid_disks - mddev->degraded < 1) {
> +               md_unregister_thread(&conf->thread);
>                 ret = -EINVAL;
>                 goto abort;
>         }
> --
> 2.25.1
>
