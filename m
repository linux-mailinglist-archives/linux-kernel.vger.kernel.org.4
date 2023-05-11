Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9BA386FF9BE
	for <lists+linux-kernel@lfdr.de>; Thu, 11 May 2023 21:04:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239042AbjEKTE4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 May 2023 15:04:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238921AbjEKTEy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 May 2023 15:04:54 -0400
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4BC0B268F;
        Thu, 11 May 2023 12:04:52 -0700 (PDT)
Date:   Thu, 11 May 2023 21:04:38 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
        s=mail; t=1683831878;
        bh=xjA/vlCf4x5jZr0jAJEzLOpVBQzYPu2p4Nh1B5PnCN8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=U2fNJZ6ysoEWoqzyyN1rE1MNPCL0MntkIEJpE2wVazVHpWZSn0bvKXT7swYVWtIv0
         n8v45AxXT3SmH7NrN8muBRwXOcDJfbnxM9Nr114Bh+ON7YzKBsMqtcwbl3S9goyvFa
         zi4+OMdsdWYgstKOzeOSKVODS96PVGMADvxWIYfU=
From:   Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <linux@weissschuh.net>
To:     George Kennedy <george.kennedy@oracle.com>
Cc:     gregkh@linuxfoundation.org, jirislaby@kernel.org,
        sfr@canb.auug.org.au, akpm@linux-foundation.org,
        linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
        regressions@lists.linux.dev
Subject: Re: [PATCH v2] vc_screen: reload load of struct vc_data pointer in
 vcs_write() to avoid UAF
Message-ID: <9b615891-fe8e-438e-b3f0-6a8a622c30ef@t-8ch.de>
References: <1683738431-3647-1-git-send-email-george.kennedy@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1683738431-3647-1-git-send-email-george.kennedy@oracle.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023-05-10 12:07:11-0500, George Kennedy wrote:
> After a call to console_unlock() in vcs_write() the vc_data struct can be
> freed by vc_port_destruct(). Because of that, the struct vc_data pointer
> must be reloaded in the while loop in vcs_write() after console_lock() to
> avoid a UAF when vcs_size() is called.
> 
> Syzkaller reported a UAF in vcs_size().
> 
> BUG: KASAN: slab-use-after-free in vcs_size (drivers/tty/vt/vc_screen.c:215)
> Read of size 4 at addr ffff8880beab89a8 by task repro_vcs_size/4119
> 
> Call Trace:
>  <TASK>
> __asan_report_load4_noabort (mm/kasan/report_generic.c:380)
> vcs_size (drivers/tty/vt/vc_screen.c:215)
> vcs_write (drivers/tty/vt/vc_screen.c:664)
> vfs_write (fs/read_write.c:582 fs/read_write.c:564)
> ...
>  <TASK>
> 
> Allocated by task 1213:
> kmalloc_trace (mm/slab_common.c:1064)
> vc_allocate (./include/linux/slab.h:559 ./include/linux/slab.h:680
>     drivers/tty/vt/vt.c:1078 drivers/tty/vt/vt.c:1058)
> con_install (drivers/tty/vt/vt.c:3334)
> tty_init_dev (drivers/tty/tty_io.c:1303 drivers/tty/tty_io.c:1415
>     drivers/tty/tty_io.c:1392)
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
>  which belongs to the cache kmalloc-1k of size 1024
> The buggy address is located 424 bytes inside of
>  freed 1024-byte region [ffff8880beab8800, ffff8880beab8c00)
> 
> The buggy address belongs to the physical page:
> page:00000000afc77580 refcount:1 mapcount:0 mapping:0000000000000000
>     index:0x0 pfn:0xbeab8
> head:00000000afc77580 order:3 entire_mapcount:0 nr_pages_mapped:0
>     pincount:0
> flags: 0xfffffc0010200(slab|head|node=0|zone=1|lastcpupid=0x1fffff)
> page_type: 0xffffffff()
> raw: 000fffffc0010200 ffff888100042dc0 ffffea000426de00 dead000000000002
> raw: 0000000000000000 0000000000100010 00000001ffffffff 0000000000000000
> page dumped because: kasan: bad access detected
> 
> Memory state around the buggy address:
>  ffff8880beab8880: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
>  ffff8880beab8900: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
> >ffff8880beab8980: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
>                                   ^
>  ffff8880beab8a00: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
>  ffff8880beab8a80: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
> ==================================================================
> Disabling lock debugging due to kernel taint
> 
> Fixes: ac751efa6a0d ("console: rename acquire/release_console_sem() to console_lock/unlock()")
> Reported-by: syzkaller <syzkaller@googlegroups.com>
> Signed-off-by: George Kennedy <george.kennedy@oracle.com>
> ---
> v2: added "ret = -EINVAL;"
> 
> v1: This patch is similar to the recent UAF vcs_read() patches (226fae124b2d & 46d733d0efc7).
> vcs_write() should have been checked for the same UAF issue at the same time the fixes went
> into vcs_read().
> 
>  drivers/tty/vt/vc_screen.c | 11 +++++++++--
>  1 file changed, 9 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/tty/vt/vc_screen.c b/drivers/tty/vt/vc_screen.c
> index 498ba9c0ee93..79a8e8189000 100644
> --- a/drivers/tty/vt/vc_screen.c
> +++ b/drivers/tty/vt/vc_screen.c
> @@ -656,10 +656,17 @@ vcs_write(struct file *file, const char __user *buf, size_t count, loff_t *ppos)
>  			}
>  		}
>  
> -		/* The vcs_size might have changed while we slept to grab
> -		 * the user buffer, so recheck.
> +		/* The vc might have been freed or vcs_size might have changed
> +		 * while we slept to grab the user buffer, so recheck.
>  		 * Return data written up to now on failure.
>  		 */
> +		vc = vcs_vc(inode, &viewed);
> +		if (!vc) {
> +			if (written)
> +				break;
> +			ret = -EINVAL;

I know smatch asked for -EINVAL but everywhere else in vc_screen.c
-ENXIO is used when vcs_vc() fails.

With that change:

Reviewed-by: Thomas Weißschuh <linux@weissschuh.net>

> +			goto unlock_out;
> +		}
>  		size = vcs_size(vc, attr, false);
>  		if (size < 0) {
>  			if (written)
> -- 
> 2.31.1
> 
