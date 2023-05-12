Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A53CF70068B
	for <lists+linux-kernel@lfdr.de>; Fri, 12 May 2023 13:20:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241091AbjELLU5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 May 2023 07:20:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241089AbjELLUx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 May 2023 07:20:53 -0400
Received: from todd.t-8ch.de (todd.t-8ch.de [IPv6:2a01:4f8:c010:41de::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2F531725;
        Fri, 12 May 2023 04:20:49 -0700 (PDT)
Date:   Fri, 12 May 2023 13:20:45 +0200 (GMT+02:00)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
        s=mail; t=1683890447;
        bh=hhXJMQCxvKp1+nw4q9TnQfrvs9S4cFgeJ2xbcbMgzA8=;
        h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
        b=sOYZqPveunTfOvlt9WEFn46042o8mQNf+WxYBsVaTlIva+v10+YMqChMjRhcKvDA9
         PPjXCIO3foJDYv1EoECrFEE8p6ne4erqZOTIgz1OqM8lRATH+HimOdW/w600N23NNr
         joMVW280V39dOC/9YNzdTzD7EJ5AiqLCZzw2BJLA=
From:   linux@weissschuh.net
To:     George Kennedy <george.kennedy@oracle.com>
Cc:     linux@weissschuh.net, gregkh@linuxfoundation.org,
        jirislaby@kernel.org, sfr@canb.auug.org.au,
        akpm@linux-foundation.org, linux-kernel@vger.kernel.org,
        linux-serial@vger.kernel.org, regressions@lists.linux.dev
Message-ID: <bb2ca0cf-0a0a-4e60-8fe6-c18efacbfa99@weissschuh.net>
In-Reply-To: <1683889728-10411-1-git-send-email-george.kennedy@oracle.com>
References: <1683889728-10411-1-git-send-email-george.kennedy@oracle.com>
Subject: Re: [PATCH v3] vc_screen: reload load of struct vc_data pointer in
 vcs_write() to avoid UAF
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Correlation-ID: <bb2ca0cf-0a0a-4e60-8fe6-c18efacbfa99@weissschuh.net>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


May 12, 2023 13:10:48 George Kennedy <george.kennedy@oracle.com>:

> After a call to console_unlock() in vcs_write() the vc_data struct can be
> freed by vc_port_destruct(). Because of that, the struct vc_data pointer
> must be reloaded in the while loop in vcs_write() after console_lock() to
> avoid a UAF when vcs_size() is called.
>
> Syzkaller reported a UAF in vcs_size().
>
> BUG: KASAN: slab-use-after-free in vcs_size (drivers/tty/vt/vc_screen.c:2=
15)
> Read of size 4 at addr ffff8880beab89a8 by task repro_vcs_size/4119
>
> Call Trace:
> <TASK>
> __asan_report_load4_noabort (mm/kasan/report_generic.c:380)
> vcs_size (drivers/tty/vt/vc_screen.c:215)
> vcs_write (drivers/tty/vt/vc_screen.c:664)
> vfs_write (fs/read_write.c:582 fs/read_write.c:564)
> ...
> <TASK>
>
> Allocated by task 1213:
> kmalloc_trace (mm/slab_common.c:1064)
> vc_allocate (./include/linux/slab.h:559 ./include/linux/slab.h:680
> =C2=A0=C2=A0=C2=A0 drivers/tty/vt/vt.c:1078 drivers/tty/vt/vt.c:1058)
> con_install (drivers/tty/vt/vt.c:3334)
> tty_init_dev (drivers/tty/tty_io.c:1303 drivers/tty/tty_io.c:1415
> =C2=A0=C2=A0=C2=A0 drivers/tty/tty_io.c:1392)
> tty_open (drivers/tty/tty_io.c:2082 drivers/tty/tty_io.c:2128)
> chrdev_open (fs/char_dev.c:415)
> do_dentry_open (fs/open.c:921)
> vfs_open (fs/open.c:1052)
> ...
>
> Freed by task 4116:
> kfree (mm/slab_common.c:1016)
> vc_port_destruct (drivers/tty/vt/vt.c:1044)
> tty_port_destructor (drivers/tty/tty_port.c:296)
> tty_port_put (drivers/tty/tty_port.c:312)
> vt_disallocate_all (drivers/tty/vt/vt_ioctl.c:662 (discriminator 2))
> vt_ioctl (drivers/tty/vt/vt_ioctl.c:903)
> tty_ioctl (drivers/tty/tty_io.c:2778)
> ...
>
> The buggy address belongs to the object at ffff8880beab8800
> which belongs to the cache kmalloc-1k of size 1024
> The buggy address is located 424 bytes inside of
> freed 1024-byte region [ffff8880beab8800, ffff8880beab8c00)
>
> The buggy address belongs to the physical page:
> page:00000000afc77580 refcount:1 mapcount:0 mapping:0000000000000000
> =C2=A0=C2=A0=C2=A0 index:0x0 pfn:0xbeab8
> head:00000000afc77580 order:3 entire_mapcount:0 nr_pages_mapped:0
> =C2=A0=C2=A0=C2=A0 pincount:0
> flags: 0xfffffc0010200(slab|head|node=3D0|zone=3D1|lastcpupid=3D0x1fffff)
> page_type: 0xffffffff()
> raw: 000fffffc0010200 ffff888100042dc0 ffffea000426de00 dead000000000002
> raw: 0000000000000000 0000000000100010 00000001ffffffff 0000000000000000
> page dumped because: kasan: bad access detected
>
> Memory state around the buggy address:
> ffff8880beab8880: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
> ffff8880beab8900: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
>> ffff8880beab8980: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ^
> ffff8880beab8a00: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
> ffff8880beab8a80: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> Disabling lock debugging due to kernel taint
>
> Fixes: ac751efa6a0d ("console: rename acquire/release_console_sem() to co=
nsole_lock/unlock()")
> Reported-by: syzkaller <syzkaller@googlegroups.com>
> Signed-off-by: George Kennedy <george.kennedy@oracle.com>

Reviewed-by: Thomas Wei=C3=9Fschuh <linux@weissschuh.net>

> ---
> v3: changed to "ret =3D -ENXIO;"
>
> v2: added "ret =3D -EINVAL;"
>
> v1: This patch is similar to the recent UAF vcs_read() patches (226fae124=
b2d & 46d733d0efc7).
> vcs_write() should have been checked for the same UAF issue at the same t=
ime the fixes went
> into vcs_read().
>
> drivers/tty/vt/vc_screen.c | 11 +++++++++--
> 1 file changed, 9 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/tty/vt/vc_screen.c b/drivers/tty/vt/vc_screen.c
> index 498ba9c0ee93..829c4be66f3b 100644
> --- a/drivers/tty/vt/vc_screen.c
> +++ b/drivers/tty/vt/vc_screen.c
> @@ -656,10 +656,17 @@ vcs_write(struct file *file, const char __user *buf=
, size_t count, loff_t *ppos)
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /* The vcs_size might have changed =
while we slept to grab
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * the user buffer, so recheck=
.
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /* The vc might have been freed or =
vcs_size might have changed
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * while we slept to grab the =
user buffer, so recheck.
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * Return data written up=
 to now on failure.
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 */
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 vc =3D vcs_vc(inode, &viewed);
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (!vc) {
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (written=
)
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 break;
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ret =3D -EN=
XIO;
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 goto unlock=
_out;
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 size =3D vcs_size(vc, attr, fa=
lse);
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (size < 0) {
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (wr=
itten)
> -- > 2.31.1

