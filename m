Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D7C86CCC3A
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Mar 2023 23:43:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229912AbjC1VnH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Mar 2023 17:43:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229556AbjC1VnE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Mar 2023 17:43:04 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7A5D10F5;
        Tue, 28 Mar 2023 14:43:03 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 43E2F6195E;
        Tue, 28 Mar 2023 21:43:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 98AA0C433D2;
        Tue, 28 Mar 2023 21:43:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1680039782;
        bh=AL26jRXOYUbvhq3Ssc/GIxdGUCwkOvFTKnr8aSbyD4w=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=Gf0XeA673rNtAVE/M1fOJwnv79NY1dbG0JNBYuEnjvjTxucnWxKLXjRsby+uCfGu8
         TlI1EkbgAWo6DYTCJbwJo7bgnXapit9bd6DT220JRkd5IjQpJThGXJd5Oiq1KAQyhg
         /n22izwjLoQrSsnwzMTiUfRX/9b/nuUtpy9Xrr+c84vzzuJQa1ZwkXl57kdErthx4+
         xTJPfWGUS9NBvVFXzPQlb1tiFM9k51gnJh5HNU8IVHlSWe7SpOJxLLYkP2hVKgPtSR
         +Ii//Funpa5KFKIvbtxQGjPFhVkrdxGiT00bk9VBM1tss1rKS7HDQSELJf1zzX0MC5
         8dsmpS4lyy2uw==
Received: by mail-lj1-f182.google.com with SMTP id x20so14043607ljq.9;
        Tue, 28 Mar 2023 14:43:02 -0700 (PDT)
X-Gm-Message-State: AAQBX9fkF/R90AF88/il3vvUFHVS0zd2fmWNPJm02HOiKJuhoqXpV+mV
        sBuWfNFADIOl0NoxGQMF7YZY66XeLeEVClH/1fY=
X-Google-Smtp-Source: AKy350Zw5FqhVro20/10UegQdde16M7C5YqEn+uPuZuevgyVZURL2fVpSWkCu94o9xJDqXskjSnpo892vf0sdNILNEQ=
X-Received: by 2002:a2e:7a17:0:b0:2a5:fe8f:b313 with SMTP id
 v23-20020a2e7a17000000b002a5fe8fb313mr1725987ljc.5.1680039780663; Tue, 28 Mar
 2023 14:43:00 -0700 (PDT)
MIME-Version: 1.0
References: <20230328094400.1448955-1-yukuai1@huaweicloud.com>
In-Reply-To: <20230328094400.1448955-1-yukuai1@huaweicloud.com>
From:   Song Liu <song@kernel.org>
Date:   Tue, 28 Mar 2023 14:42:48 -0700
X-Gmail-Original-Message-ID: <CAPhsuW4hRBQ9YooAOHsZhio88ykAtrbxxZBfKND_5CzhJBHQoQ@mail.gmail.com>
Message-ID: <CAPhsuW4hRBQ9YooAOHsZhio88ykAtrbxxZBfKND_5CzhJBHQoQ@mail.gmail.com>
Subject: Re: [PATCH -next] md: fix regression for null-ptr-deference in __md_stop()
To:     Yu Kuai <yukuai1@huaweicloud.com>
Cc:     xni@redhat.com, logang@deltatee.com, linux-raid@vger.kernel.org,
        linux-kernel@vger.kernel.org, yukuai3@huawei.com,
        yi.zhang@huawei.com, yangerkun@huawei.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-5.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 28, 2023 at 2:44=E2=80=AFAM Yu Kuai <yukuai1@huaweicloud.com> w=
rote:
>
> From: Yu Kuai <yukuai3@huawei.com>
>
> Commit 3e453522593d ("md: Free resources in __md_stop") tried to fix
> null-ptr-deference for 'active_io' by moving percpu_ref_exit() to
> __md_stop(), however, the commit also moving 'writes_pending' to
> __md_stop(), and this will cause mdadm tests broken:
>
> BUG: kernel NULL pointer dereference, address: 0000000000000038
> Oops: 0000 [#1] PREEMPT SMP
> CPU: 15 PID: 17830 Comm: mdadm Not tainted 6.3.0-rc3-next-20230324-00009-=
g520d37
> RIP: 0010:free_percpu+0x465/0x670
> Call Trace:
>  <TASK>
>  __percpu_ref_exit+0x48/0x70
>  percpu_ref_exit+0x1a/0x90
>  __md_stop+0xe9/0x170
>  do_md_stop+0x1e1/0x7b0
>  md_ioctl+0x90c/0x1aa0
>  blkdev_ioctl+0x19b/0x400
>  vfs_ioctl+0x20/0x50
>  __x64_sys_ioctl+0xba/0xe0
>  do_syscall_64+0x6c/0xe0
>  entry_SYSCALL_64_after_hwframe+0x63/0xcd
>
> And the problem can be reporduced 100% by following test:
>
> mdadm -CR /dev/md0 -l1 -n1 /dev/sda --force
> echo inactive > /sys/block/md0/md/array_state
> echo read-auto  > /sys/block/md0/md/array_state
> echo inactive > /sys/block/md0/md/array_state
>
> Root cause:
>
> // start raid
> raid1_run
>  mddev_init_writes_pending
>   percpu_ref_init
>
> // inactive raid
> array_state_store
>  do_md_stop
>   __md_stop
>    percpu_ref_exit
>
> // start raid again
> array_state_store
>  do_md_run
>   raid1_run
>    mddev_init_writes_pending
>     if (mddev->writes_pending.percpu_count_ptr)
>     // won't reinit
>
> // inactive raid again
> ...
> percpu_ref_exit
> -> null-ptr-deference
>
> Before the commit, 'writes_pending' is exited when mddev is freed, and
> it's safe to restart raid because mddev_init_writes_pending() already mak=
e
> sure that 'writes_pending' will only be initialized once.
>
> Fix the prblem by moving 'writes_pending' back, it's a litter hard to fin=
d
> the relationship between alloc memory and free memory, however, code
> changes is much less and we lived with this for a long time already.
>
> Fixes: 3e453522593d ("md: Free resources in __md_stop")
>
> Signed-off-by: Yu Kuai <yukuai3@huawei.com>

Applied to md-fixes.

Thanks!
Song
