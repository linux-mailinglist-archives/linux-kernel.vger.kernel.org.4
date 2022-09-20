Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 26DBF5BDC5F
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Sep 2022 07:25:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230253AbiITFYp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Sep 2022 01:24:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230112AbiITFYE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Sep 2022 01:24:04 -0400
Received: from mail-lj1-x235.google.com (mail-lj1-x235.google.com [IPv6:2a00:1450:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B470C558D8;
        Mon, 19 Sep 2022 22:23:36 -0700 (PDT)
Received: by mail-lj1-x235.google.com with SMTP id b6so1615895ljr.10;
        Mon, 19 Sep 2022 22:23:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date;
        bh=dO8JJjJK1s65vYurLtIxdFrCVxG6MjYOph/vBSym/Vo=;
        b=gTkBZnTpYUwwpCI5EaHdGGalX3Ctv/cu1rzCB4n4/2OoRwGhcngnhccpDRBQq1LpDf
         RB5WExeXShBZdmE/rv+PB2hEGnV8o58ItP7nQ5apDW0DjhfOiCjiFUzMsrvMw2MilazP
         R9q940VlSBSqd/N33OwMdxe4o15J4vh2ir6i6MQ+YOfYNhrj+UUqU2cqows6qVj3StJM
         00M/FNN/xYuQMpYYCOM5mVGs8hNGbTNm1JqB3oyZdxq7m6y2wFLushrlUb1/GImZLI0K
         u+RvbUD/ErdmzYp376LgflUGLISpBe8y7dgbBwzjtJyedlIP33m3l+SijFqLa2eJzFzj
         Mhnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date;
        bh=dO8JJjJK1s65vYurLtIxdFrCVxG6MjYOph/vBSym/Vo=;
        b=P8kAktmoXULot/fHy4nf6/w4eP3CpJ8lEAljIakH1bIUt8ss17eDIcs3QqjdBLgxPn
         EJYXsNwH1mUnd00fjIsOK1+tZqw4ybS4krxmfoEWp0MtL6BiEIUNpkAeQSp7HrHPvjRT
         QyJml/caD9VOIvn9bA4T2iyYNCuSOFqQt6pOpNcTxMu+t6iQ1QCIP3hBPDB+Zv87YXfF
         8Zp84xMAa5+WiMpzovixDQBXxBvacmZusik+WiebigazZBiw7gruy7dxV2zPX3M5Yvp3
         i4z43CYHwHNUnnpuAUn4V7908OD2JIOSfbmGG8T5nsryKIMuoeYmt0ScIFYgcvCUpMcm
         wCkA==
X-Gm-Message-State: ACrzQf1HO1FGrIrKv4vgbP/hyd7EXTDqLfG1EiVvMdyTHcDtSJzGrDL/
        E2TLF/A3gsZ7Em/sGws7WM0gmpIc4Z0PFU2eff4=
X-Google-Smtp-Source: AMsMyM7qFz1RuMWagROpdywuhcU4i4b3O3BqjNiOr61DC61m0zQZwA/XlSo2iYTn0boUvStPNZ79RfcYdx/Lgu+OiwY=
X-Received: by 2002:a2e:804a:0:b0:26b:66d3:4d51 with SMTP id
 p10-20020a2e804a000000b0026b66d34d51mr6699510ljg.293.1663651414718; Mon, 19
 Sep 2022 22:23:34 -0700 (PDT)
MIME-Version: 1.0
References: <CABBYNZKm_YcMeRTouY6z+748WNYFnkD_UFWCQd8Yts7mNEnxGw@mail.gmail.com>
 <20220920051024.4991-1-yin31149@gmail.com>
In-Reply-To: <20220920051024.4991-1-yin31149@gmail.com>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Mon, 19 Sep 2022 22:23:22 -0700
Message-ID: <CABBYNZKYAa3q7++6ivJRy-tFe1zZMHaWsRUQuSe_5+SwqcQ=3Q@mail.gmail.com>
Subject: Re: [syzbot] BUG: corrupted list in kobject_add_internal (4)
To:     Hawkins Jiawei <yin31149@gmail.com>
Cc:     18801353760@163.com, gregkh@linuxfoundation.org,
        linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org,
        marcel@holtmann.org, rafael@kernel.org, soenke.huster@eknoes.de,
        syzbot+5a2d2b4a8ca80ad216a9@syzkaller.appspotmail.com,
        syzbot+e653e3f67251b6139aaa@syzkaller.appspotmail.com,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Hawkins,

On Mon, Sep 19, 2022 at 10:12 PM Hawkins Jiawei <yin31149@gmail.com> wrote:
>
> Hi Luiz,
>
> On Tue, 20 Sept 2022 at 00:55, Luiz Augusto von Dentz <luiz.dentz@gmail.c=
om> wrote:
> >
> > Hi Hawkins,
> >
> > On Mon, Sep 19, 2022 at 1:42 AM Hawkins Jiawei <yin31149@gmail.com> wro=
te:
> > >
> > > On Sat, 17 Sept 2022 at 09:47, Hawkins Jiawei <yin31149@gmail.com> wr=
ote:
> > > >
> > > >Hi,
> > > >
> > > >On Fri, 26 Aug 2022 08:27:06, AM S=C3=B6nke Huster <soenke.huster@ek=
noes.de> wrote:
> > > >>Hi Luiz,
> > > >>
> > > >>On 25.08.22 20:58, Luiz Augusto von Dentz wrote:
> > > >>> Hi S=C3=B6nke,
> > > >>>
> > > >>> On Thu, Aug 25, 2022 at 8:08 AM S=C3=B6nke Huster <soenke.huster@=
eknoes.de> wrote:
> > > >>>>
> > > >>>> Hi,
> > > >>>>
> > > >>>>
> > > >>>>
> > > >>>> While fuzzing I found several crashes similar to the following:
> > > >>>>
> > > >>>>
> > > >>>>         [    5.345731] sysfs: cannot create duplicate filename '=
/devices/virtual/bluetooth/hci0/hci0:0'
> > > >>>>
> > > >>>>         [...]
> > > >>>>
> > > >>>>         [    5.430464] BUG: KASAN: use-after-free in klist_add_t=
ail+0x1bd/0x200
> > > >>>>
> > > >>>>         [    5.430464] Write of size 8 at addr ffff88800bfcc468 =
by task kworker/u3:1/43
> > > >>>>
> > > >>>>         [    5.430464]
> > > >>>>
> > > >>>>         [    5.430464] CPU: 0 PID: 43 Comm: kworker/u3:1 Not tai=
nted 5.19.0-12855-g13f222680b8f #2
> > > >>>>
> > > >>>>         [    5.430464] Hardware name: QEMU Standard PC (i440FX +=
 PIIX, 1996), BIOS rel-1.16.0-0-gd239552ce722-prebuilt.qemu.org 04/01/2014
> > > >>>>
> > > >>>>         [    5.430464] Workqueue: hci0 hci_rx_work
> > > >>>>
> > > >>>>         [    5.430464] Call Trace:
> > > >>>>
> > > >>>>         [    5.430464]  <TASK>
> > > >>>>
> > > >>>>         [    5.430464]  dump_stack_lvl+0x45/0x5d
> > > >>>>
> > > >>>>         [    5.430464]  print_report.cold+0x5e/0x5e5
> > > >>>>
> > > >>>>         [    5.430464]  kasan_report+0xb1/0x1c0
> > > >>>>
> > > >>>>         [    5.430464]  klist_add_tail+0x1bd/0x200
> > > >>>>
> > > >>>>         [    5.430464]  device_add+0xa6b/0x1b80
> > > >>>>
> > > >>>>         [    5.430464]  hci_conn_add_sysfs+0x91/0x110
> > > >>>>
> > > >>>>         [    5.430464]  le_conn_complete_evt+0x117f/0x17d0
> > > >>>>
> > > >>>>         [    5.430464]  hci_le_conn_complete_evt+0x226/0x2c0
> > > >>>>
> > > >>>>         [    5.430464]  hci_le_meta_evt+0x2c0/0x4a0
> > > >>>>
> > > >>>>         [    5.430464]  hci_event_packet+0x636/0xf60
> > > >>>>
> > > >>>>         [    5.430464]  hci_rx_work+0xa8c/0x1000
> > > >>>>
> > > >>>>         [    5.430464]  process_one_work+0x8df/0x1530
> > > >>>>
> > > >>>>         [    5.430464]  worker_thread+0x575/0x11a0
> > > >>>>
> > > >>>>         [    5.430464]  kthread+0x29d/0x340
> > > >>>>
> > > >>>>         [    5.430464]  ret_from_fork+0x22/0x30
> > > >>>>
> > > >>>>         [    5.430464]  </TASK>
> > > >>>>
> > > >>>>         [    5.430464]
> > > >>>>
> > > >>>>         [    5.430464] Allocated by task 44:
> > > >>>>
> > > >>>>         [    5.430464]  kasan_save_stack+0x1e/0x40
> > > >>>>
> > > >>>>         [    5.430464]  __kasan_kmalloc+0x81/0xa0
> > > >>>>
> > > >>>>         [    5.430464]  device_add+0xcae/0x1b80
> > > >>>>
> > > >>>>         [    5.430464]  hci_conn_add_sysfs+0x91/0x110
> > > >>>>
> > > >>>>         [    5.430464]  le_conn_complete_evt+0x117f/0x17d0
> > > >>>>
> > > >>>>         [    5.430464]  hci_le_conn_complete_evt+0x226/0x2c0
> > > >>>>
> > > >>>>         [    5.430464]  hci_le_meta_evt+0x2c0/0x4a0
> > > >>>>
> > > >>>>         [    5.430464]  hci_event_packet+0x636/0xf60
> > > >>>>
> > > >>>>         [    5.430464]  hci_rx_work+0xa8c/0x1000
> > > >>>>
> > > >>>>         [    5.430464]  process_one_work+0x8df/0x1530
> > > >>>>
> > > >>>>         [    5.430464]  worker_thread+0x575/0x11a0
> > > >>>>
> > > >>>>         [    5.430464]  kthread+0x29d/0x340
> > > >>>>
> > > >>>>         [    5.430464]  ret_from_fork+0x22/0x30
> > > >>>>
> > > >>>>         [    5.430464]
> > > >>>>
> > > >>>>         [    5.430464] Freed by task 43:
> > > >>>>
> > > >>>>         [    5.430464]  kasan_save_stack+0x1e/0x40
> > > >>>>
> > > >>>>         [    5.430464]  kasan_set_track+0x21/0x30
> > > >>>>
> > > >>>>         [    5.430464]  kasan_set_free_info+0x20/0x40
> > > >>>>
> > > >>>>         [    5.430464]  __kasan_slab_free+0x108/0x190
> > > >>>>
> > > >>>>         [    5.430464]  kfree+0xa9/0x360
> > > >>>>
> > > >>>>         [    5.430464]  device_add+0x33a/0x1b80
> > > >>>>
> > > >>>>         [    5.430464]  hci_conn_add_sysfs+0x91/0x110
> > > >>>>
> > > >>>>         [    5.430464]  hci_le_cis_estabilished_evt+0x517/0xa70
> > > >>>>
> > > >>>>         [    5.430464]  hci_le_meta_evt+0x2c0/0x4a0
> > > >>>>
> > > >>>>         [    5.430464]  hci_event_packet+0x636/0xf60
> > > >>>>
> > > >>>>         [    5.430464]  hci_rx_work+0xa8c/0x1000
> > > >>>>
> > > >>>>         [    5.430464]  process_one_work+0x8df/0x1530
> > > >>>>
> > > >>>>         [    5.430464]  worker_thread+0x575/0x11a0
> > > >>>>
> > > >>>>         [    5.430464]  kthread+0x29d/0x340
> > > >>>>
> > > >>>>         [    5.430464]  ret_from_fork+0x22/0x30
> > > >>>>
> > > >>>>
> > > >>>>
> > > >>>> I think I fixed a similar issue in d5ebaa7c5f6f ("Bluetooth: hci=
_event: Ignore multiple conn complete events"). Here, the problem was that =
multiple connection complete events for the same handle called hci_conn_add=
_sysfs multiple times, but if it is called with an existing connection conn=
->dev->p is freed.
> > > >>>>
> > > >>>> This is because device_add is called - its documentation contain=
s this sentence: "Do not call this routine or device_register() more than o=
nce for any device structure".
> > > >>>>
> > > >>>>
> > > >>>>
> > > >>>> This here is similar: First, an hci_le_conn_complete_evt creates=
 a new connection.
> > > >>>>
> > > >>>> Afterwards, an hci_le_cis_estabilished_evt with the same handle =
finds that connection, and tries to add it to sysfs again, freeing conn->de=
v->p. Now, an event that might use that connection such as here the hci_le_=
conn_complete_evt triggers a use after free.
> > > >>>>
> > > >
> > > >Syzkaller reports a bug as follows [1]:
> > > >------------[ cut here ]------------
> > > >kernel BUG at lib/list_debug.c:33!
> > > >invalid opcode: 0000 [#1] PREEMPT SMP KASAN
> > > >[...]
> > > >Call Trace:
> > > > <TASK>
> > > > __list_add include/linux/list.h:69 [inline]
> > > > list_add_tail include/linux/list.h:102 [inline]
> > > > kobj_kset_join lib/kobject.c:164 [inline]
> > > > kobject_add_internal+0x18f/0x8f0 lib/kobject.c:214
> > > > kobject_add_varg lib/kobject.c:358 [inline]
> > > > kobject_add+0x150/0x1c0 lib/kobject.c:410
> > > > device_add+0x368/0x1e90 drivers/base/core.c:3452
> > > > hci_conn_add_sysfs+0x9b/0x1b0 net/bluetooth/hci_sysfs.c:53
> > > > hci_le_cis_estabilished_evt+0x57c/0xae0 net/bluetooth/hci_event.c:6=
799
> > > > hci_le_meta_evt+0x2b8/0x510 net/bluetooth/hci_event.c:7110
> > > > hci_event_func net/bluetooth/hci_event.c:7440 [inline]
> > > > hci_event_packet+0x63d/0xfd0 net/bluetooth/hci_event.c:7495
> > > > hci_rx_work+0xae7/0x1230 net/bluetooth/hci_core.c:4007
> > > > process_one_work+0x991/0x1610 kernel/workqueue.c:2289
> > > > worker_thread+0x665/0x1080 kernel/workqueue.c:2436
> > > > kthread+0x2e4/0x3a0 kernel/kthread.c:376
> > > > ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:306
> > > > </TASK>
> > > >
> > > >I think they are the same problems:
> > > >A hci_le_conn_complete_evt creates a new connection, and calls
> > > >hci_conn_add_sysfs(). Then hci_le_cis_estabilished_evt with the same=
 handle
> > > >finds that connection, and will also calls hci_conn_add_sysfs(), whi=
ch maybe
> > > >triggering corrupted list bug.
> > > >
> > > >Link: https://syzkaller.appspot.com/bug?id=3Dda3246e2d33afdb92d66bc1=
66a0934c5b146404a [1]
> > > >
> > > >>>>
> > > >>>>
> > > >>>> I bisected this bug and it was introduced with  26afbd826ee3 ("B=
luetooth: Add initial implementation of CIS connections").
> > > >>>>
> > > >>>>
> > > >>>>
> > > >>>> The same happens with hci_le_create_big_complete_evt: Here, mult=
iple events trigger the following bug:
> > > >>>>
> > > >>>>
> > > >>>>
> > > >>>>         [    6.898080] BUG: kernel NULL pointer dereference, add=
ress: 0000000000000058
> > > >>>>
> > > >>>>         [    6.898081] #PF: supervisor read access in kernel mod=
e
> > > >>>>
> > > >>>>         [    6.898083] #PF: error_code(0x0000) - not-present pag=
e
> > > >>>>
> > > >>>>         [    6.898085] Oops: 0000 [#1] PREEMPT SMP NOPTI
> > > >>>>
> > > >>>>         [    6.898090] Workqueue: hci0 hci_rx_work
> > > >>>>
> > > >>>>         [    6.898092] RIP: 0010:klist_next+0x12/0x160
> > > >>>>
> > > >>>>         [    6.898128] Call Trace:
> > > >>>>
> > > >>>>         [    6.898129]  <TASK>
> > > >>>>
> > > >>>>         [    6.898130]  ? bt_link_release+0x20/0x20
> > > >>>>
> > > >>>>         [    6.898133]  device_find_child+0x37/0xa0
> > > >>>>
> > > >>>>         [    6.898136]  hci_conn_del_sysfs+0x71/0xa0
> > > >>>>
> > > >>>>         [    6.898138]  hci_conn_cleanup+0x17a/0x2c0
> > > >>>>
> > > >>>>         [    6.898141]  hci_conn_del+0x14a/0x240
> > > >>>>
> > > >>>>         [    6.898144]  hci_le_create_big_complete_evt+0x3d8/0x4=
70
> > > >>>>
> > > >>>>         [    6.898146]  ? hci_le_remote_feat_complete_evt+0x3e0/=
0x3e0
> > > >>>>
> > > >>>>         [    6.898148]  hci_le_meta_evt+0x155/0x230
> > > >>>>
> > > >>>>         [    6.898150]  hci_event_packet+0x328/0x820
> > > >>>>
> > > >>>>         [    6.898152]  ? hci_conn_drop+0x100/0x100
> > > >>>>
> > > >>>>         [    6.898155]  hci_rx_work+0x725/0xb70
> > > >>>>
> > > >>>>         [    6.898157]  process_one_work+0x2a6/0x5d0
> > > >>>>
> > > >>>>         [    6.898160]  worker_thread+0x4a/0x3e0
> > > >>>>
> > > >>>>         [    6.898162]  ? process_one_work+0x5d0/0x5d0
> > > >>>>
> > > >>>>         [    6.898164]  kthread+0xed/0x120
> > > >>>>
> > > >>>>         [    6.898165]  ? kthread_complete_and_exit+0x20/0x20
> > > >>>>
> > > >>>>         [    6.898167]  ret_from_fork+0x22/0x30
> > > >>>>
> > > >>>>         [    6.898170]  </TASK>
> > > >>>>
> > > >>>>
> > > >>>>
> > > >>>> I bisected this bug and it was introduced with eca0ae4aea66 ("Bl=
uetooth: Add initial implementation of BIS connections").
> > > >>>>
> > > >>>>
> > > >>>>
> > > >>>> I am not really sure how to solve that. As far as I understand, =
previously we simply set an unused handle as connection handle, and checked=
 for that before setting the correct handle and adding it to sysfs. But her=
e, adding it to sysfs seems to happen in a different function and the handl=
e is already set.
> > > >>>
> > > >>> We should probably check if link-type, if it is an ISO link it sh=
all
> > > >>> not be created via Connection Complete events and they have their=
 own
> > > >>> events to create that.
> > > I wonder if we can check the connection type in hci_le_create_big_com=
plete_evt()
> > > and hci_le_cis_estabilished_evt(), as below:
> > >
> > > diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
> > > index 6643c9c20fa4..5b83473d51b5 100644
> > > --- a/net/bluetooth/hci_event.c
> > > +++ b/net/bluetooth/hci_event.c
> > > @@ -6795,8 +6795,16 @@ static void hci_le_cis_estabilished_evt(struct=
 hci_dev *hdev, void *data,
> > >
> > >         if (!ev->status) {
> > >                 conn->state =3D BT_CONNECTED;
> > > -               hci_debugfs_create_conn(conn);
> > > -               hci_conn_add_sysfs(conn);
> > > +
> > > +               /* Only ISO_LINK link type need to register connectio=
n device
> > > +                * here, others will register in their relative
> > > +                * Connection Complete events
> > > +                */
> > > +               if (conn->type =3D=3D ISO_LINK) {
> > > +                       hci_debugfs_create_conn(conn);
> > > +                       hci_conn_add_sysfs(conn);
> > > +               }
> >
> > We should probably just bail out if conn->type !=3D ISO_LINK which can
> > be done much earlier.
> Thanks for explanation.

https://patchwork.kernel.org/project/bluetooth/patch/20220919181017.1658995=
-1-luiz.dentz@gmail.com/

> >
> > >                 hci_iso_setup_path(conn);
> > >                 goto unlock;
> > >         }
> > > @@ -6901,8 +6909,16 @@ static void hci_le_create_big_complete_evt(str=
uct hci_dev *hdev, void *data,
> > >
> > >         if (!ev->status) {
> > >                 conn->state =3D BT_CONNECTED;
> > > -               hci_debugfs_create_conn(conn);
> > > -               hci_conn_add_sysfs(conn);
> > > +
> > > +               /* Only ISO_LINK link type need to register connectio=
n device
> > > +                * here, others will register in their relative
> > > +                * Connection Complete events
> > > +                */
> > > +               if (conn->type =3D=3D ISO_LINK) {
> > > +                       hci_debugfs_create_conn(conn);
> > > +                       hci_conn_add_sysfs(conn);
> > > +               }
> > > +
> > >                 hci_iso_setup_path(conn);
> > >                 goto unlock;
> > >         }
> > >
> > > It seems that this patch can pass the syzbot test.
> > >
> > > Link: https://lore.kernel.org/all/0000000000004f9ca105e8ba8157@google=
.com/
> > > Reported-and-tested-by: syzbot+5a2d2b4a8ca80ad216a9@syzkaller.appspot=
mail.com
> > >
> > > Link: https://lore.kernel.org/all/0000000000008a7a3f05e8ad02f6@google=
.com/
> > > Reported-and-tested-by: syzbot+e653e3f67251b6139aaa@syzkaller.appspot=
mail.com
> > >
> > > >>>
> > > >>
> > > >>But then the problem of duplicate hci_le_cis_estabilished_evt / hci=
_le_create_big_complete_evt still exists, isn't it? For example if the conn=
ection is created through a hci_le_cis_req_evt, and afterwards two hci_le_c=
is_estabilished_evt arrive, the second event calls hci_conn_add_sysfs a sec=
ond time which frees parts of the device structure.
> > > As for this problem, I wonder if we can check the connection state in=
 those
> > > functions as below, liking patch
> > > d5ebaa7c5f6f("Bluetooth: hci_event: Ignore multiple conn complete eve=
nts"):
> > >
> > > diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
> > > index 5b83473d51b5..f6b62cfcf082 100644
> > > --- a/net/bluetooth/hci_event.c
> > > +++ b/net/bluetooth/hci_event.c
> > > @@ -6794,6 +6794,14 @@ static void hci_le_cis_estabilished_evt(struct=
 hci_dev *hdev, void *data,
> > >         }
> > >
> > >         if (!ev->status) {
> > > +               /* The HCI_LE_CIS_Estabilished event is only sent onc=
e per connection.
> > > +                * Processing it more than once per connection can co=
rrupt kernel memory.
> > > +                *
> > > +                * As the connection state is set here for the first =
time, it indicates
> > > +                * whether the connection is already set up.
> > > +                */
> > > +               if (conn->state =3D=3D BT_CONNECTED)
> > > +                       goto unlock;
> > >                 conn->state =3D BT_CONNECTED;
> > >
> > >                 /* Only ISO_LINK link type need to register connectio=
n device
> > > @@ -6908,6 +6916,14 @@ static void hci_le_create_big_complete_evt(str=
uct hci_dev *hdev, void *data,
> > >                 conn->handle =3D __le16_to_cpu(ev->bis_handle[0]);
> > >
> > >         if (!ev->status) {
> > > +               /* The HCI_LE_Create_BIG_Complete event is only sent =
once per connection.
> > > +                * Processing it more than once per connection can co=
rrupt kernel memory.
> > > +                *
> > > +                * As the connection state is set here for the first =
time, it indicates
> > > +                * whether the connection is already set up.
> > > +                */
> > > +               if (conn->state =3D=3D BT_CONNECTED)
> > > +                       goto unlock;
> >
> > These changes look good, please send a proper patch.
> OK, I will add some error message and send a proper patch.

Note that I did send a set that should resolve this as well:

https://patchwork.kernel.org/project/bluetooth/list/?series=3D678331

> >
> > >                 conn->state =3D BT_CONNECTED;
> > >
> > >                 /* Only ISO_LINK link type need to register connectio=
n device
> > >
> > > >>
> > > >>>> Best
> > > >>>> S=C3=B6nke
> > > >I wonder that if we need both two patches? Because they
> > > >seems to be used to patch different bugs?
> >
> >
> >
> > --
> > Luiz Augusto von Dentz



--=20
Luiz Augusto von Dentz
