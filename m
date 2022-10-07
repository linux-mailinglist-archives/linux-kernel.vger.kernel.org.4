Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BAADA5F7E05
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Oct 2022 21:33:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229507AbiJGTdU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Oct 2022 15:33:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229445AbiJGTdS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Oct 2022 15:33:18 -0400
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1469B14F8;
        Fri,  7 Oct 2022 12:33:16 -0700 (PDT)
Received: by mail-lf1-x131.google.com with SMTP id d6so8624856lfs.10;
        Fri, 07 Oct 2022 12:33:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qkjlOYfmEhQ6UDDWrFbvWRZg+rSeRjXVZkUM9y6BFvU=;
        b=QueoBHfrBmmYW0KPY82csmNNAgu1MmBnnFYYXXacpjngybyBNAr+qvb15THQaWE1O0
         4jkBzEZKW61xGys2PmOJ0NfjKMFEEPj5LTfskwt33A2tlU0SoxceKo9pUQWgOaiSMl8i
         Gt1KfbXH12xHQguLbYhswIuFbuADiaKBAVXg/64XZdwrf7tTvmfHG3y/Nhp/s42gOAaG
         7kAPlQYgCmLW9mVQUSZdLf666qXedUbbYK+90SnWX3uvpjM8aQv+IDRw2ekn7ULcCLwX
         K1P+unv110R5RP81WSZRKiXdZlWIWXhn9kxGtlvxI8E9mQ6pIEQ4R8qf2D3FDzcIY6wi
         0aWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qkjlOYfmEhQ6UDDWrFbvWRZg+rSeRjXVZkUM9y6BFvU=;
        b=iXuTi0iC5b9DgjUXpBkKEXcs+C2WGtBKxSd4bVBRdfJwF+705OkDvWz4y7Q5OCAO6M
         q/BoBIEcTS8JEIphZ28ej9o4JltEAWx3Uz1hE2n11fcwYkzbSWCmkwA0a6jeMwFDjWtZ
         C6+ftCAxfQ1IAOCHNiVdJr/fC2CxHSTanHbgqzVn6kNnjIMMAzrgasFgYX90tvSGT1cA
         UJiCuGz6B39epsuYobelgyEUwW2Vr/BIr2QhEb9TC8FN2rCR+sQu2mYZs0q/Ynm3LdQ9
         bRaOnL9AUZvNh5c1z65oYnk3NQl2ulA6FvucwPbQ10vJku9l7mAZe8cY4rkt8a1wd2r9
         PueA==
X-Gm-Message-State: ACrzQf3JLYsQkSyDqcBAsW1aOtgPpKrJ2DmVpGFEb1BFXoDo4DGgDvSX
        vKKEQZEZJXmn80007jiYcMU83T328ygcDUeqXk4=
X-Google-Smtp-Source: AMsMyM5WEsAjnYpHedrqfupNOBN2Nbo7h2E2YNMwK7YUM4aAtRW4UWAap5mDFg5Qu/8ptkoPTovr1tpd2N3EaY4JUF8=
X-Received: by 2002:a05:6512:2621:b0:47f:d228:bdeb with SMTP id
 bt33-20020a056512262100b0047fd228bdebmr2242555lfb.121.1665171195063; Fri, 07
 Oct 2022 12:33:15 -0700 (PDT)
MIME-Version: 1.0
References: <20220811094542.268519-1-mst@redhat.com> <CABBYNZLeszHHi2TVcQsOtPWs1u=s8gjOVAhL+Q=O-ThgpxvpOw@mail.gmail.com>
 <20221007090043-mutt-send-email-mst@kernel.org>
In-Reply-To: <20221007090043-mutt-send-email-mst@kernel.org>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Fri, 7 Oct 2022 12:33:03 -0700
Message-ID: <CABBYNZKHuaoy0OrA+t46V6=PZtN9BPeNQR4RutdKZhdJJ+4ixA@mail.gmail.com>
Subject: Re: [PATCH v3] Bluetooth: virtio_bt: fix device removal
To:     "Michael S. Tsirkin" <mst@redhat.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Hulk Robot <hulkci@huawei.com>,
        Yang Yingliang <yangyingliang@huawei.com>,
        Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
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

Hi Michael,

On Fri, Oct 7, 2022 at 6:01 AM Michael S. Tsirkin <mst@redhat.com> wrote:
>
> On Mon, Aug 15, 2022 at 11:07:05AM -0700, Luiz Augusto von Dentz wrote:
> > Hi Michael,
> >
> > On Thu, Aug 11, 2022 at 2:46 AM Michael S. Tsirkin <mst@redhat.com> wro=
te:
> > >
> > > Device removal is clearly out of virtio spec: it attempts to remove
> > > unused buffers from a VQ before invoking device reset. To fix, make
> > > open/close NOPs and do all cleanup/setup in probe/remove.
> > >
> > > NB: This is a hacky way to handle this - virtbt_{open,close} as NOP i=
s
> > > not really what a driver is supposed to be doing. These are transport
> > > enable/disable callbacks from the BT core towards the driver. It maps=
 to
> > > a device being enabled/disabled by something like bluetoothd for
> > > example. So if disabled, users expect that no resources/queues are in
> > > use.  It does work with all other transports like USB, SDIO, UART etc=
.
> > > There should be no buffer used if the device is powered off. We also
> > > don=E2=80=99t have any USB URBs in-flight if the transport is not act=
ive.
> > >
> > > The way to implement a proper fix would be using vq reset if supporte=
d,
> > > or even using a full device reset.
> > >
> > > The cost of the hack is a single skb wasted on an unused bt device.
> > >
> > > NB2: with this fix in place driver still suffers from a race conditio=
n
> > > if an interrupt triggers while device is being reset.  To fix, in the
> > > virtbt_close() callback we should deactivate all interrupts.  To be
> > > fixed.
> > >
> > > squashed fixup: bluetooth: virtio_bt: fix an error code in probe()
> >
> > Shouldn't the line above be a Fixes tag with the commit hash you are
> > attempting to fix, other than that I'd be fine to apply these changes.
>
>
> ping? what's going on?

Please resend, our patchwork only retain the patches for 30 days.

> > > Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
> > > Reported-by: Hulk Robot <hulkci@huawei.com>
> > > Signed-off-by: Yang Yingliang <yangyingliang@huawei.com>
> > > Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> > > Message-Id: <20220811080943.198245-1-mst@redhat.com>
> > > ---
> > >
> > > changes from v2:
> > >         tkeaked commit log to make lines shorter
> > > changes from v1:
> > >         fixed error handling
> > >
> > >  drivers/bluetooth/virtio_bt.c | 19 +++++++++++++++++--
> > >  1 file changed, 17 insertions(+), 2 deletions(-)
> > >
> > > diff --git a/drivers/bluetooth/virtio_bt.c b/drivers/bluetooth/virtio=
_bt.c
> > > index 67c21263f9e0..f6d699fed139 100644
> > > --- a/drivers/bluetooth/virtio_bt.c
> > > +++ b/drivers/bluetooth/virtio_bt.c
> > > @@ -50,8 +50,11 @@ static int virtbt_add_inbuf(struct virtio_bluetoot=
h *vbt)
> > >
> > >  static int virtbt_open(struct hci_dev *hdev)
> > >  {
> > > -       struct virtio_bluetooth *vbt =3D hci_get_drvdata(hdev);
> > > +       return 0;
> > > +}
> > >
> > > +static int virtbt_open_vdev(struct virtio_bluetooth *vbt)
> > > +{
> > >         if (virtbt_add_inbuf(vbt) < 0)
> > >                 return -EIO;
> > >
> > > @@ -61,7 +64,11 @@ static int virtbt_open(struct hci_dev *hdev)
> > >
> > >  static int virtbt_close(struct hci_dev *hdev)
> > >  {
> > > -       struct virtio_bluetooth *vbt =3D hci_get_drvdata(hdev);
> > > +       return 0;
> > > +}
> > > +
> > > +static int virtbt_close_vdev(struct virtio_bluetooth *vbt)
> > > +{
> > >         int i;
> > >
> > >         cancel_work_sync(&vbt->rx);
> > > @@ -354,8 +361,15 @@ static int virtbt_probe(struct virtio_device *vd=
ev)
> > >                 goto failed;
> > >         }
> > >
> > > +       virtio_device_ready(vdev);
> > > +       err =3D virtbt_open_vdev(vbt);
> > > +       if (err)
> > > +               goto open_failed;
> > > +
> > >         return 0;
> > >
> > > +open_failed:
> > > +       hci_free_dev(hdev);
> > >  failed:
> > >         vdev->config->del_vqs(vdev);
> > >         return err;
> > > @@ -368,6 +382,7 @@ static void virtbt_remove(struct virtio_device *v=
dev)
> > >
> > >         hci_unregister_dev(hdev);
> > >         virtio_reset_device(vdev);
> > > +       virtbt_close_vdev(vbt);
> > >
> > >         hci_free_dev(hdev);
> > >         vbt->hdev =3D NULL;
> > > --
> > > MST
> > >
> >
> >
> > --
> > Luiz Augusto von Dentz
>


--=20
Luiz Augusto von Dentz
