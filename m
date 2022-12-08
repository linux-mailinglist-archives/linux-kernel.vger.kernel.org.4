Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3AF98646F15
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Dec 2022 12:54:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229937AbiLHLyn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Dec 2022 06:54:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230166AbiLHLyW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Dec 2022 06:54:22 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 062DD5AE1F;
        Thu,  8 Dec 2022 03:54:21 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id B7115B8239C;
        Thu,  8 Dec 2022 11:54:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D5696C433D6;
        Thu,  8 Dec 2022 11:54:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1670500458;
        bh=Tb9EnbC2b9u5P9+aLfnOGvUbdDco7sW2zCcMGztO94I=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Hyt15JVqL3g1F4Myg0NT6wHJ+h0x5xfGO/zAyt1c/gWA/6biSkAebXsngiXOQ+O6/
         RgNiF+X1+DXCNi/J4jr/ZB9daCd4RrjpPETbjgx4k0ZVxCVSuZocw7cfDKxX/28wvM
         xIzWasothSck9S0l0g/k92z7nQla4WI+J0E56plhkhARdVz6OyelSuDPxDOLdBjspZ
         xLAbwcSp8DWoCAcx0GZHkVvZ/3q3qCH15T3naAXjehfajJwYHWKCGmiFTp49AMuF+Q
         OGOaIqkhX1PQfLwZ1kcM+hTxhTFlj0weNe9ezo5qXSZVr42KpxG94PKsZNiCivY+tm
         Utakorri84O8A==
Date:   Thu, 8 Dec 2022 13:54:13 +0200
From:   Leon Romanovsky <leon@kernel.org>
To:     Guoqing Jiang <guoqing.jiang@linux.dev>
Cc:     syzbot <syzbot+3fd8326d9a0812d19218@syzkaller.appspotmail.com>,
        jgg@ziepe.ca, linux-kernel@vger.kernel.org,
        linux-rdma@vger.kernel.org, markzhang@nvidia.com,
        ohartoov@nvidia.com, syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] WARNING: refcount bug in nldev_newlink
Message-ID: <Y5HQZRkxP7PO7a8m@unreal>
References: <0000000000004fe6c005ef43161d@google.com>
 <Y5Gq/zVi/fR85OJK@unreal>
 <69a62945-3bec-73a3-e347-9cabee4ebdf6@linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <69a62945-3bec-73a3-e347-9cabee4ebdf6@linux.dev>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 08, 2022 at 07:42:18PM +0800, Guoqing Jiang wrote:
> Hi,
> 
> On 12/8/22 5:14 PM, Leon Romanovsky wrote:
> > On Wed, Dec 07, 2022 at 12:51:39PM -0800, syzbot wrote:
> > > Hello,
> > > 
> > > syzbot found the following issue on:
> > > 
> > > HEAD commit:    591cd61541b9 Add linux-next specific files for 20221207
> > > git tree:       linux-next
> > > console+strace: https://syzkaller.appspot.com/x/log.txt?x=11aeafad880000
> > > kernel config:  https://syzkaller.appspot.com/x/.config?x=8b2d3e63e054c24f
> > > dashboard link: https://syzkaller.appspot.com/bug?extid=3fd8326d9a0812d19218
> > > compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
> > > syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=112536fb880000
> > > C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=16aa2e6d880000
> > > 
> > > Downloadable assets:
> > > disk image: https://storage.googleapis.com/syzbot-assets/bc862c01ec56/disk-591cd615.raw.xz
> > > vmlinux: https://storage.googleapis.com/syzbot-assets/8f9b93f8ed2f/vmlinux-591cd615.xz
> > > kernel image: https://storage.googleapis.com/syzbot-assets/9d5cb636d548/bzImage-591cd615.xz
> > > 
> > > IMPORTANT: if you fix the issue, please add the following tag to the commit:
> > > Reported-by: syzbot+3fd8326d9a0812d19218@syzkaller.appspotmail.com
> > > 
> > > WARNING: CPU: 0 PID: 5156 at lib/refcount.c:31 refcount_warn_saturate+0x1d7/0x1f0 lib/refcount.c:31
> > > Modules linked in:
> > > CPU: 0 PID: 5156 Comm: syz-executor773 Not tainted 6.1.0-rc8-next-20221207-syzkaller #0
> > > Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 10/26/2022
> > > RIP: 0010:refcount_warn_saturate+0x1d7/0x1f0 lib/refcount.c:31
> > > Code: 05 5a 60 51 0a 01 e8 35 0a b5 05 0f 0b e9 d3 fe ff ff e8 6c 9b 75 fd 48 c7 c7 c0 6d a6 8a c6 05 37 60 51 0a 01 e8 16 0a b5 05 <0f> 0b e9 b4 fe ff ff 48 89 ef e8 5a b5 c3 fd e9 5c fe ff ff 0f 1f
> > > RSP: 0018:ffffc90003ebf0d8 EFLAGS: 00010286
> > > RAX: 0000000000000000 RBX: 0000000000000000 RCX: 0000000000000000
> > > RDX: ffff88802bfcba80 RSI: ffffffff8166b1dc RDI: fffff520007d7e0d
> > > RBP: ffff888070296600 R08: 0000000000000005 R09: 0000000000000000
> > > R10: 0000000080000000 R11: 0000000000000000 R12: 1ffff920007d7e20
> > > R13: 0000000000000000 R14: ffff888070296600 R15: ffffc90003ebf608
> > > FS:  000055555600f300(0000) GS:ffff8880b9800000(0000) knlGS:0000000000000000
> > > CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> > > CR2: 00007ffed185b004 CR3: 00000000265db000 CR4: 00000000003506f0
> > > DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> > > DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> > > Call Trace:
> > >   <TASK>
> > >   __refcount_dec include/linux/refcount.h:344 [inline]
> > >   refcount_dec include/linux/refcount.h:359 [inline]
> > >   ref_tracker_free+0x539/0x6b0 lib/ref_tracker.c:118
> > >   netdev_tracker_free include/linux/netdevice.h:4039 [inline]
> > >   netdev_put include/linux/netdevice.h:4056 [inline]
> > >   dev_put include/linux/netdevice.h:4082 [inline]
> > >   nldev_newlink+0x360/0x5d0 drivers/infiniband/core/nldev.c:1733
> > >   rdma_nl_rcv_msg+0x371/0x6a0 drivers/infiniband/core/netlink.c:195
> > >   rdma_nl_rcv_skb.constprop.0.isra.0+0x2fc/0x440 drivers/infiniband/core/netlink.c:239
> > >   netlink_unicast_kernel net/netlink/af_netlink.c:1330 [inline]
> > >   netlink_unicast+0x547/0x7f0 net/netlink/af_netlink.c:1356
> > >   netlink_sendmsg+0x91b/0xe10 net/netlink/af_netlink.c:1932
> > >   sock_sendmsg_nosec net/socket.c:714 [inline]
> > >   sock_sendmsg+0xd3/0x120 net/socket.c:734
> > >   ____sys_sendmsg+0x712/0x8c0 net/socket.c:2476
> > >   ___sys_sendmsg+0x110/0x1b0 net/socket.c:2530
> > >   __sys_sendmsg+0xf7/0x1c0 net/socket.c:2559
> > >   do_syscall_x64 arch/x86/entry/common.c:50 [inline]
> > >   do_syscall_64+0x39/0xb0 arch/x86/entry/common.c:80
> > >   entry_SYSCALL_64_after_hwframe+0x63/0xcd
> > > RIP: 0033:0x7fd5bc473699
> > > Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 41 15 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 c0 ff ff ff f7 d8 64 89 01 48
> > > RSP: 002b:00007ffed185aff8 EFLAGS: 00000246 ORIG_RAX: 000000000000002e
> > > RAX: ffffffffffffffda RBX: 0000000000000003 RCX: 00007fd5bc473699
> > > RDX: 0000000000000000 RSI: 0000000020000340 RDI: 0000000000000003
> > > RBP: 0000000000000000 R08: 000000000000000d R09: 000000000000000d
> > > R10: 00007ffed185aa70 R11: 0000000000000246 R12: 00007ffed185b010
> > > R13: 00000000000f4240 R14: 0000000000011fc1 R15: 00007ffed185b004
> > >   </TASK>
> > > 
> > > 
> > > ---
> > > This report is generated by a bot. It may contain errors.
> > > See https://goo.gl/tpsmEJ for more information about syzbot.
> > > syzbot engineers can be reached at syzkaller@googlegroups.com.
> > > 
> > > syzbot will keep track of this issue. See:
> > > https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
> > > syzbot can test patches for this issue, for details see:
> > > https://goo.gl/tpsmEJ#testing-patches
> > Jason, what do you think?
> > 
> > diff --git a/drivers/infiniband/core/nldev.c b/drivers/infiniband/core/nldev.c
> > index a981ac2f0975..982938c1dae3 100644
> > --- a/drivers/infiniband/core/nldev.c
> > +++ b/drivers/infiniband/core/nldev.c
> > @@ -1730,7 +1730,8 @@ static int nldev_newlink(struct sk_buff *skb, struct nlmsghdr *nlh,
> >   #endif
> >          err = ops ? ops->newlink(ibdev_name, ndev) : -EINVAL;
> >          up_read(&link_ops_rwsem);
> > -       dev_put(ndev);
> > +       if (err)
> > +               dev_put(ndev);
> >          return err;
> >   }
> > 
> 
> I guess the dev_put is paired with dev_hold in dev_get_by_name,

Yes, my concern is that call to ->delink() calls to dev_put
unconditionally in free_netdevs() and I didn't see who called
to dev_hold() except dev_get_by_name.

Thanks

> maybe it should be protected by ink_ops_rwsem, otherwise
> siw_exit_module could call� ib_unregister_driver -> free_netdevs
> after rdma_link_unregister (which needs to hold link_ops_rwsem),
> then seems it is possible that ndev is freed before nldev_newlink
> calls dev_put.
> 
> diff --git a/drivers/infiniband/core/nldev.c
> b/drivers/infiniband/core/nldev.c
> index 12dc97067ed2..f49bc8ee46da 100644
> --- a/drivers/infiniband/core/nldev.c
> +++ b/drivers/infiniband/core/nldev.c
> @@ -1715,8 +1715,8 @@ static int nldev_newlink(struct sk_buff *skb, struct
> nlmsghdr *nlh,
> ������� }
> �#endif
> ������� err = ops ? ops->newlink(ibdev_name, ndev) : -EINVAL;
> -������ up_read(&link_ops_rwsem);
> ������� dev_put(ndev);
> +������ up_read(&link_ops_rwsem);
> 
> ������� return err;
> �}
> 
> Thanks,
> Guoqing
