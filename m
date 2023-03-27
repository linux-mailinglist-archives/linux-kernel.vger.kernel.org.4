Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0471E6CB222
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Mar 2023 01:11:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230073AbjC0XLc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Mar 2023 19:11:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229456AbjC0XLa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Mar 2023 19:11:30 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5DBD19B2
        for <linux-kernel@vger.kernel.org>; Mon, 27 Mar 2023 16:10:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1679958646;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ixSHD7NwErKjXICuazNbf6jL54e0WVDQJqNTVBgzOPw=;
        b=bu5JI9R8qFZd3OaRdQiTdmvWTpCyJ3AvseCTy+K/R+BYxEa5NZ0/U77HKHqTZpTRDh8UyT
        L5HJYSsTIowC40np0MALOiMSod76Pkm/YBvXyNUQrsOqg64UDlAkZUNcZE68oSHKRTH2LW
        7pCBAJET3K8X8s2qdAnCaQjdCcoG/ro=
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com
 [209.85.214.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-235-PEe9RXsxOBmrPSkO7KCfZA-1; Mon, 27 Mar 2023 19:10:45 -0400
X-MC-Unique: PEe9RXsxOBmrPSkO7KCfZA-1
Received: by mail-pl1-f199.google.com with SMTP id u11-20020a170902e80b00b001a043e84bdfso6674828plg.23
        for <linux-kernel@vger.kernel.org>; Mon, 27 Mar 2023 16:10:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679958643;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ixSHD7NwErKjXICuazNbf6jL54e0WVDQJqNTVBgzOPw=;
        b=hrF+gIGgz//cHTjaayO//G8Po+Ek2Dlmj4AzXVJQBD/TqeQU58Z0MpSGPx7NKmhDQy
         TtxKJJ4PGfFY4mMHMu0lqZC/mVspYU8jJ3m61z1BJAInMOYZE9CbxhNtvRDwEXf+VG4x
         V93PwvK/Gwc92aibeCvd2Y5e3xVQAILIpx7JD1YK+P0w3Sq4sWgj3EuJ67JlS5SgsDfS
         FiYO3aqITQ70c+Z95vFaZOI2NANK3FAXeKIJKqK/RJNfk0MXiNFrAZpJxQTsVwkw5hwN
         d/uINt/4T+QER2qdj+WIN7DaJxfy7mtB9hpg1+zKi4kM7rksOY6pMjx1hYJSPd63HDqZ
         KBCA==
X-Gm-Message-State: AAQBX9dErWhQE4Yr6B0jOtEQQ4uKcb3H0a+SV+2Zvo1Bwe7WZaxl8RH9
        3Qjw/+zV+J2KDGuHsOyhdFpUeMefiSR3IlsD0txXwXuYep+565zExVE7q2Jiv5ro2w6dR+CAd/7
        cv3wYXiINy4/DKUhICnaSFH/KKxM4o/RdSVb6i5zq
X-Received: by 2002:a05:6a00:2443:b0:627:9d8a:a29c with SMTP id d3-20020a056a00244300b006279d8aa29cmr6454293pfj.2.1679958643717;
        Mon, 27 Mar 2023 16:10:43 -0700 (PDT)
X-Google-Smtp-Source: AKy350ZsZfkbsZqCEpg8AZVEAG7RO+bYQgko0N4B2fTN/mKndVZPWgOB5Qh5G34qucsX7S4vjX3BrZS93kbnPoyL0lc=
X-Received: by 2002:a05:6a00:2443:b0:627:9d8a:a29c with SMTP id
 d3-20020a056a00244300b006279d8aa29cmr6454287pfj.2.1679958643398; Mon, 27 Mar
 2023 16:10:43 -0700 (PDT)
MIME-Version: 1.0
References: <20230315090620.7294-1-ivan.orlov0322@gmail.com>
In-Reply-To: <20230315090620.7294-1-ivan.orlov0322@gmail.com>
From:   Andreas Gruenbacher <agruenba@redhat.com>
Date:   Tue, 28 Mar 2023 01:10:31 +0200
Message-ID: <CAHc6FU7b-BaBXrMR3UqbZGF3a_y=20TKkCNde1GvqbmN2-h1xw@mail.gmail.com>
Subject: Re: [PATCH] gfs2 FS: Fix UBSAN array-index-out-of-bounds in __gfs2_iomap_get
To:     Ivan Orlov <ivan.orlov0322@gmail.com>
Cc:     rpeterso@redhat.com, cluster-devel@redhat.com,
        linux-kernel@vger.kernel.org, skhan@linuxfoundation.org,
        himadrispandya@gmail.com,
        linux-kernel-mentees@lists.linuxfoundation.org,
        syzbot+45d4691b1ed3c48eba05@syzkaller.appspotmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Ivan,

On Wed, Mar 15, 2023 at 10:06=E2=80=AFAM Ivan Orlov <ivan.orlov0322@gmail.c=
om> wrote:
> Syzkaller reported the following issue:
>
> UBSAN: array-index-out-of-bounds in fs/gfs2/bmap.c:901:46
> index 11 is out of range for type 'u64 [11]'
> CPU: 0 PID: 5067 Comm: syz-executor164 Not tainted 6.1.0-syzkaller-13031-=
g77856d911a8c #0
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS G=
oogle 10/26/2022
> Call Trace:
>  <TASK>
>  __dump_stack lib/dump_stack.c:88 [inline]
>  dump_stack_lvl+0x1b1/0x290 lib/dump_stack.c:106
>  ubsan_epilogue lib/ubsan.c:151 [inline]
>  __ubsan_handle_out_of_bounds+0xe0/0x110 lib/ubsan.c:282
>  __gfs2_iomap_get+0x4a4/0x16e0 fs/gfs2/bmap.c:901
>  gfs2_iomap_get fs/gfs2/bmap.c:1399 [inline]
>  gfs2_block_map+0x28f/0x7f0 fs/gfs2/bmap.c:1214
>  gfs2_write_alloc_required+0x441/0x6e0 fs/gfs2/bmap.c:2322
>  gfs2_jdesc_check+0x1b9/0x290 fs/gfs2/super.c:114
>  init_journal+0x5a4/0x22c0 fs/gfs2/ops_fstype.c:804
>  init_inodes+0xdc/0x340 fs/gfs2/ops_fstype.c:889
>  gfs2_fill_super+0x1bb2/0x2700 fs/gfs2/ops_fstype.c:1247
>  get_tree_bdev+0x400/0x620 fs/super.c:1282
>  gfs2_get_tree+0x50/0x210 fs/gfs2/ops_fstype.c:1330
>  vfs_get_tree+0x88/0x270 fs/super.c:1489
>  do_new_mount+0x289/0xad0 fs/namespace.c:3145
>  do_mount fs/namespace.c:3488 [inline]
>  __do_sys_mount fs/namespace.c:3697 [inline]
>  __se_sys_mount+0x2d3/0x3c0 fs/namespace.c:3674
>  do_syscall_x64 arch/x86/entry/common.c:50 [inline]
>  do_syscall_64+0x3d/0xb0 arch/x86/entry/common.c:80
>  entry_SYSCALL_64_after_hwframe+0x63/0xcd
> RIP: 0033:0x7f2c63567aca
> Code: 83 c4 08 5b 5d c3 66 2e 0f 1f 84 00 00 00 00 00 c3 66 2e 0f 1f 84 0=
0 00 00 00 00 0f 1f 44 00 00 49 89 ca b8 a5 00 00 00 0f 05 <48> 3d 01 f0 ff=
 ff 73 01 c3 48 c7 c1 c0 ff ff ff f7 d8 64 89 01 48
> RSP: 002b:00007ffd0e3a28d8 EFLAGS: 00000282 ORIG_RAX: 00000000000000a5
> RAX: ffffffffffffffda RBX: 0000000000000003 RCX: 00007f2c63567aca
> RDX: 0000000020037f40 RSI: 0000000020037f80 RDI: 00007ffd0e3a28e0
> RBP: 00007ffd0e3a28e0 R08: 00007ffd0e3a2920 R09: 0000000000043350
> R10: 0000000002000011 R11: 0000000000000282 R12: 0000000000000004
> R13: 00005555567192c0 R14: 00007ffd0e3a2920 R15: 0000000000000000
>  </TASK>
>
> This issue is caused by the 'while' loop in the '__gfs2_iomap_get' functi=
on,
> which increments 'height' var until it matches the condition. If height i=
s
> larger or equal to 'sdp->sd_heightsize' array size (which is GFS2_MAX_MET=
A_HEIGHT
> + 1), the array-index-out-of-bounds issue occurs. Therefore we need to ad=
d extra
> condition to the while loop, which will prevent this issue.
>
> Additionally, if 'height' var after the while ending is equal to GFS2_MAX=
_META_HEIGHT,
> the 'find_metapath' call right after the loop will break (because it assu=
mes that
> 'height' parameter will not be larger than the size of metapath's mp_list=
 array length,
> which is GFS2_MAX_META_HEIGHT). So, we need to check the 'height' after t=
he loop ending,
> and if its value is too big we need to break the execution of the functio=
n, and return
> a proper error if it is too big.

Thanks for the patch, but the actual problem here is that we're
starting out with an invalid height; when starting with a valid
height, the loop will always terminate. Here's a proper fix:

https://listman.redhat.com/archives/cluster-devel/2023-March/023644.html

While looking into this, I had difficulties getting prepro.c to work.
The reason is that it always uses /dev/loop0 instead of creating its
own loop device. Here's a partial fix for that (but note that this
doesn't include the necessary cleanup code at the end):

--- a/repro.c
+++ b/repro.c
@@ -26,8 +26,6 @@
 #define __NR_memfd_create 319
 #endif

-static unsigned long long procid;
-
 //% This code is derived from puff.{c,h}, found in the zlib development. T=
he
 //% original files come with the following copyright notice:

@@ -423,8 +421,15 @@ static long syz_mount_image(volatile long fsarg,
volatile long dir,
   char* source =3D NULL;
   char loopname[64];
   if (need_loop_device) {
+    int loopctlfd;
+    long devnr;
+
+    loopctlfd =3D open("/dev/loop-control", O_RDWR);
+    devnr =3D ioctl(loopctlfd, LOOP_CTL_GET_FREE);
+    close(loopctlfd);
+
     memset(loopname, 0, sizeof(loopname));
-    snprintf(loopname, sizeof(loopname), "/dev/loop%llu", procid);
+    snprintf(loopname, sizeof(loopname), "/dev/loop%lu", devnr);
     if (setup_loop_device(data, size, loopname, &loopfd) =3D=3D -1)
       return -1;
     source =3D loopname;

Thanks,
Andreas

> Tested via syzbot.
>
> Reported-by: syzbot+45d4691b1ed3c48eba05@syzkaller.appspotmail.com
> Link: https://syzkaller.appspot.com/bug?id=3D42296ea544c870f4dde3b25efa4c=
c1b89515d38e
> Signed-off-by: Ivan Orlov <ivan.orlov0322@gmail.com>
> ---
>  fs/gfs2/bmap.c | 10 +++++++++-
>  1 file changed, 9 insertions(+), 1 deletion(-)
>
> diff --git a/fs/gfs2/bmap.c b/fs/gfs2/bmap.c
> index eedf6926c652..9b7358165f96 100644
> --- a/fs/gfs2/bmap.c
> +++ b/fs/gfs2/bmap.c
> @@ -895,8 +895,16 @@ static int __gfs2_iomap_get(struct inode *inode, lof=
f_t pos, loff_t length,
>         iomap->length =3D len << inode->i_blkbits;
>
>         height =3D ip->i_height;
> -       while ((lblock + 1) * sdp->sd_sb.sb_bsize > sdp->sd_heightsize[he=
ight])
> +
> +       while (height <=3D GFS2_MAX_META_HEIGHT
> +               && (lblock + 1) * sdp->sd_sb.sb_bsize > sdp->sd_heightsiz=
e[height])
>                 height++;
> +
> +       if (height > GFS2_MAX_META_HEIGHT) {
> +               ret =3D -ERANGE;
> +               goto unlock;
> +       }
> +
>         find_metapath(sdp, lblock, mp, height);
>         if (height > ip->i_height || gfs2_is_stuffed(ip))
>                 goto do_alloc;
> --
> 2.34.1
>

