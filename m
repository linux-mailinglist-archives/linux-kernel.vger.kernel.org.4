Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE13261537F
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Nov 2022 21:51:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229628AbiKAUvq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Nov 2022 16:51:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229511AbiKAUvm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Nov 2022 16:51:42 -0400
Received: from hermod.demsh.org (hermod.demsh.org [45.140.147.175])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7362618B34;
        Tue,  1 Nov 2022 13:51:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=demsh.org; s=022020;
        t=1667335897;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=lynTikTlbsL63yiBUJcjQJmAweLbFMnBPUDPM2HsYvc=;
        b=fDSxtn/X7V/oaUc3Fga5kApTHiev2/SDYiuahPDgSUybP30jBgjuCeReUBUJK93xQmFE92
        ReWqC2dxlXcD9JxIS6rnbFCdAWMf189ZA5fkwGxR69s76AdmUVLc1wL3RVJ1yu84OiKmMa
        JNbZN3zs5VyvHbEC0gDxdTw55Khsl8lBmOtS9FyqOEcfXGFRcA7dFSIOoMGDJZfEgh4PUJ
        kEfls9Jk6YzQcalfVqHfSPTKEtmuh7oEZ5fwNNoS6FqohNt7ATGvbnAMqpmkpcXb440E5t
        AFNgYExHa4I0B3tNZsOZBIPflYbhayNPYPeE4e/9Ry+POwUnQ2LmQtUibW66ZA==
Received: from xps.demsh.org (algiz.demsh.org [94.103.82.47])
        by hermod.demsh.org (OpenSMTPD) with ESMTPSA id 36acce8b (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO) auth=yes user=me;
        Tue, 1 Nov 2022 20:51:37 +0000 (UTC)
Date:   Tue, 1 Nov 2022 23:51:44 +0300
From:   Dmitrii Tcvetkov <me@demsh.org>
To:     Keith Busch <kbusch@kernel.org>
Cc:     Jens Axboe <axboe@kernel.dk>, Song Liu <song@kernel.org>,
        linux-raid@vger.kernel.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [bisected] RAID1 direct IO redirecting sector loop since 6.0
Message-ID: <20221101235144.06a3dbd3@xps.demsh.org>
In-Reply-To: <Y2FVzdcro8HCfODK@kbusch-mbp>
References: <20221101001558.648ee024@xps.demsh.org>
 <Y2FVzdcro8HCfODK@kbusch-mbp>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=0.0 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,SPF_HELO_NONE,SPF_PASS,URIBL_BLACK autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 1 Nov 2022 11:22:21 -0600
Keith Busch <kbusch@kernel.org> wrote:

> On Tue, Nov 01, 2022 at 12:15:58AM +0300, Dmitrii Tcvetkov wrote:
> >=20
> > # cat /proc/7906/stack
> > [<0>] submit_bio_wait+0xdb/0x140
> > [<0>] blkdev_direct_IO+0x62f/0x770
> > [<0>] blkdev_read_iter+0xc1/0x140
> > [<0>] vfs_read+0x34e/0x3c0
> > [<0>] __x64_sys_pread64+0x74/0xc0
> > [<0>] do_syscall_64+0x6a/0x90
> > [<0>] entry_SYSCALL_64_after_hwframe+0x4b/0xb5
> >=20
> > After "mdadm --fail" invocation the last line becomes:
> > [pid  7906] pread64(13, 0x627c34c8d200, 4096, 0) =3D -1 EIO
> > (Input/output error)
>=20
> It looks like something isn't accounting for the IO size correctly
> when there's an offset. It may be something specific to one of the
> stacking drivers in your block setup. Does this still happen without
> the cryptosetup step?
>=20
I created setup lvm(mdraid(gpt(HDD))):

# lsblk -t -a
NAME                 ALIGNMENT MIN-IO OPT-IO PHY-SEC LOG-SEC ROTA SCHED RQ-=
SIZE  RA WSAME
...
sdd                          0    512      0     512     512    1 bfq      =
  64 128    0B
=E2=94=9C=E2=94=80sdd3                       0    512      0     512     51=
2    1 bfq        64 128    0B
=E2=94=82 =E2=94=94=E2=94=80md1                      0    512      0     51=
2     512    1           128 128    0B
=E2=94=82   =E2=94=9C=E2=94=80512lvmraid-zfs         0    512      0     51=
2     512    1           128 128    0B
=E2=94=82   =E2=94=94=E2=94=80512lvmraid-wrk         0    512      0     51=
2     512    1           128 128    0B
sde                          0    512      0     512     512    1 bfq      =
  64 128    0B
=E2=94=9C=E2=94=80sde3                       0    512      0     512     51=
2    1 bfq        64 128    0B
=E2=94=82 =E2=94=94=E2=94=80md1                      0    512      0     51=
2     512    1           128 128    0B
=E2=94=82   =E2=94=9C=E2=94=80512lvmraid-zfs         0    512      0     51=
2     512    1           128 128    0B
=E2=94=82   =E2=94=94=E2=94=80512lvmraid-wrk         0    512      0     51=
2     512    1           128 128    0B

where:
# mdadm --create --level=3D1 --metadata=3D1.2 \
	--raid-devices=3D2 /dev/md1 /dev/sdd3 /dev/sde3
# pvcreate /dev/md1
# vgcreate 512lvmraid /dev/md2

In this case problem doesn't reproduce, both guests start successfully.

It also doesn't reproduce with 4096 sector loop:
# lsblk -t -a                                                              =
            =20
NAME                 ALIGNMENT MIN-IO OPT-IO PHY-SEC LOG-SEC ROTA SCHED RQ-=
SIZE  RA WSAME
loop0                        0   4096      0    4096    4096    0 none     =
 128 128    0B
=E2=94=94=E2=94=80md2                        0   4096      0    4096    409=
6    0           128 128    0B
  =E2=94=9C=E2=94=804096lvmraid-zfs          0   4096      0    4096    409=
6    0           128 128    0B
  =E2=94=94=E2=94=804096lvmraid-wrk          0   4096      0    4096    409=
6    0           128 128    0B
loop1                        0   4096      0    4096    4096    0 none     =
 128 128    0B
=E2=94=94=E2=94=80md2                        0   4096      0    4096    409=
6    0           128 128    0B
  =E2=94=9C=E2=94=804096lvmraid-zfs          0   4096      0    4096    409=
6    0           128 128    0B
  =E2=94=94=E2=94=804096lvmraid-wrk          0   4096      0    4096    409=
6    0           128 128    0B

where:
# losetup --sector-size 4096 -f /dev/sdd4
# losetup --sector-size 4096 -f /dev/sde4
# mdadm --create --level=3D1 --metadata=3D1.2 \
	--raid-devices=3D2 /dev/md2 /dev/loop0 /dev/loop1
# pvcreate /dev/md2
# vgcreate 4096lvmraid /dev/md2

Indeed then something is wrong in LUKS.

> For a different experiment, it may be safer to just force all
> alignment for stacking drivers. Could you try the following and see
> if that gets it working again?=20
>=20
> ---
> diff --git a/block/blk-settings.c b/block/blk-settings.c
> index 8bb9eef5310e..5c16fdb00c6f 100644
> --- a/block/blk-settings.c
> +++ b/block/blk-settings.c
> @@ -646,6 +646,7 @@ int blk_stack_limits(struct queue_limits *t,
> struct queue_limits *b, t->misaligned =3D 1;
>  		ret =3D -1;
>  	}
> +	blk_queue_dma_alignment(t, t->logical_block_size - 1);
> =20
>  	t->max_sectors =3D blk_round_down_sectors(t->max_sectors,
> t->logical_block_size); t->max_hw_sectors =3D
> blk_round_down_sectors(t->max_hw_sectors, t->logical_block_size); --

This doesn't compile:
  CC      block/blk-settings.o                                             =
                   =20
block/blk-settings.c: In function =E2=80=98blk_stack_limits=E2=80=99:
block/blk-settings.c:649:33: error: passing argument 1 of =E2=80=98blk_queu=
e_dma_alignment=E2=80=99 from incompatible pointer type [-Werror=3Dincompat=
ible-pointer-types]
  649 |         blk_queue_dma_alignment(t, t->logical_block_size - 1);
      |                                 ^
      |                                 |
      |                                 struct queue_limits *
In file included from block/blk-settings.c:9:
./include/linux/blkdev.h:956:37: note: expected =E2=80=98struct request_que=
ue *=E2=80=99 but argument is of type =E2=80=98struct queue_limits *=E2=80=
=99
  956 | extern void blk_queue_dma_alignment(struct request_queue *, int);

I didn't find obvious way to get a request_queue pointer, which corresponds=
 to struct queue_limits *t.
