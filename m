Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8FA685FBBA0
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Oct 2022 21:57:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229792AbiJKT5r (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Oct 2022 15:57:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229607AbiJKT5p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Oct 2022 15:57:45 -0400
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 930DE74BA3;
        Tue, 11 Oct 2022 12:57:43 -0700 (PDT)
Received: by mail-lf1-x133.google.com with SMTP id d6so22709356lfs.10;
        Tue, 11 Oct 2022 12:57:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bJCp8XmgPB/HD8nVBMtLsLp57IPP1Zwda7nt1SFsRpc=;
        b=GNbjgTiIYzhxjJrb9sh6I4lvuddpUQolwhkM8WO39goeks3aMP7w5oxnBQ/ZZc/VFB
         SmEj92bUxRNt2+9Zi//hvaPYifKERTxc5LnSlblIOHND3o4qPrJnGgLudbaaHZMBOF0e
         X+vOUSg2GRra3SDwP7PE2vhHE38nGfQogrTea4ME57NQLaL4PVyevboH6K3NSmahvKk2
         iml7ZqPYvfJY85N3hOrFswQrkmZZ0oJ2/ooy5zNCtM9DKG2ZDzS11RY5miUYFMBL/02S
         DVPL+AgmkVuhBnuHhlrv0EofzNCHMfbugEBD1iobzYVQRWYlRa5J4f/7TH8fc5irTdRK
         7oHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bJCp8XmgPB/HD8nVBMtLsLp57IPP1Zwda7nt1SFsRpc=;
        b=Z3o8XSBu0BV6v2hkkXrYx38+0jXjo3214Mh0+CoRWEmd7hs1d4325W26aJrQ/sQ32Q
         G+iYY7R1I7Hyl/fe9dsx+FSiusQR4w2o2T7MNErFQEOGDB6QppXCd7gg2WI8FFkIINhQ
         BdSD4mgCVj9iSWAWiUep0dgkMHkbwvSGtX+/ogsLa2cBgRWrr/LBJqVUGpPjgiXfLH3C
         h1sqZqzK13ByjbXNVf0qQo8oW3LQDUlDDWbwwK0mjgviojfiG0JCVqe04P23Au3Wltvw
         +4Kjgd8YnzIGhrptC60+ye5aZ23PBvP0jaWxH9tPSqlAoqE9BD1xs3vnTrjpLZbx0dFz
         nCHA==
X-Gm-Message-State: ACrzQf2ROvzGpgOiPlESZS05/IY9t8R7rr0VxqzM68Z7SDJTNIFYyS5y
        NDogQzbaMv2+53/ETT/21xklWHnAp9R2TP98puE=
X-Google-Smtp-Source: AMsMyM4gwYjWPx7kVxsO+jKjYRYVCZsolNGnbZhuZPi+IwG/XzTJJHDicmYQQXgB3R9wJJd3gPlELIxKageMdm/7Qb8=
X-Received: by 2002:a05:6512:483:b0:4a2:6905:dfae with SMTP id
 v3-20020a056512048300b004a26905dfaemr9480322lfq.57.1665518261842; Tue, 11 Oct
 2022 12:57:41 -0700 (PDT)
MIME-Version: 1.0
References: <20220811094542.268519-1-mst@redhat.com> <794b9160-9647-7157-c84f-e278a375716e@opensynergy.com>
In-Reply-To: <794b9160-9647-7157-c84f-e278a375716e@opensynergy.com>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Tue, 11 Oct 2022 12:57:30 -0700
Message-ID: <CABBYNZJ9cj2RuJSyKcfV33N4kn1aqNQdJLFj8T5PEeJpGtRxWw@mail.gmail.com>
Subject: Re: [PATCH v3 resend] Bluetooth: virtio_bt: fix device removal
To:     Igor Skalkin <igor.skalkin@opensynergy.com>
Cc:     "Michael S. Tsirkin" <mst@redhat.com>,
        linux-kernel@vger.kernel.org,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Hulk Robot <hulkci@huawei.com>,
        Yang Yingliang <yangyingliang@huawei.com>,
        Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        linux-bluetooth@vger.kernel.org
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

On Tue, Oct 11, 2022 at 5:18 AM Igor Skalkin
<igor.skalkin@opensynergy.com> wrote:
>
> Tested, works fine in our projects.
>
> Tested-by: Igor Skalkin <Igor.Skalkin@opensynergy.com>
>
> On 10/10/22 19:14, Michael S. Tsirkin wrote:
> > Device removal is clearly out of virtio spec: it attempts to remove
> > unused buffers from a VQ before invoking device reset. To fix, make
> > open/close NOPs and do all cleanup/setup in probe/remove.
> >
> > NB: This is a hacky way to handle this - virtbt_{open,close} as NOP is
> > not really what a driver is supposed to be doing. These are transport
> > enable/disable callbacks from the BT core towards the driver. It maps t=
o
> > a device being enabled/disabled by something like bluetoothd for
> > example. So if disabled, users expect that no resources/queues are in
> > use.  It does work with all other transports like USB, SDIO, UART etc.
> > There should be no buffer used if the device is powered off. We also
> > don=E2=80=99t have any USB URBs in-flight if the transport is not activ=
e.
> >
> > The way to implement a proper fix would be using vq reset if supported,
> > or even using a full device reset.
> >
> > The cost of the hack is a single skb wasted on an unused bt device.
> >
> > NB2: with this fix in place driver still suffers from a race condition
> > if an interrupt triggers while device is being reset.  To fix, in the
> > virtbt_close() callback we should deactivate all interrupts.  To be
> > fixed.
> >
> > squashed fixup: bluetooth: virtio_bt: fix an error code in probe()
> >
> > Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
> > Reported-by: Hulk Robot <hulkci@huawei.com>
> > Signed-off-by: Yang Yingliang <yangyingliang@huawei.com>
> > Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> > Message-Id: <20220811080943.198245-1-mst@redhat.com>

Ive pushed this one.

> > ---
> >
> > resending due to v3 having been dropped
> > changes from v2:
> >       tkeaked commit log to make lines shorter
> > changes from v1:
> >       fixed error handling
> >
> >   drivers/bluetooth/virtio_bt.c | 19 +++++++++++++++++--
> >   1 file changed, 17 insertions(+), 2 deletions(-)
> >
> > diff --git a/drivers/bluetooth/virtio_bt.c b/drivers/bluetooth/virtio_b=
t.c
> > index 67c21263f9e0..f6d699fed139 100644
> > --- a/drivers/bluetooth/virtio_bt.c
> > +++ b/drivers/bluetooth/virtio_bt.c
> > @@ -50,8 +50,11 @@ static int virtbt_add_inbuf(struct virtio_bluetooth =
*vbt)
> >
> >   static int virtbt_open(struct hci_dev *hdev)
> >   {
> > -     struct virtio_bluetooth *vbt =3D hci_get_drvdata(hdev);
> > +     return 0;
> > +}
> >
> > +static int virtbt_open_vdev(struct virtio_bluetooth *vbt)
> > +{
> >       if (virtbt_add_inbuf(vbt) < 0)
> >               return -EIO;
> >
> > @@ -61,7 +64,11 @@ static int virtbt_open(struct hci_dev *hdev)
> >
> >   static int virtbt_close(struct hci_dev *hdev)
> >   {
> > -     struct virtio_bluetooth *vbt =3D hci_get_drvdata(hdev);
> > +     return 0;
> > +}
> > +
> > +static int virtbt_close_vdev(struct virtio_bluetooth *vbt)
> > +{
> >       int i;
> >
> >       cancel_work_sync(&vbt->rx);
> > @@ -354,8 +361,15 @@ static int virtbt_probe(struct virtio_device *vdev=
)
> >               goto failed;
> >       }
> >
> > +     virtio_device_ready(vdev);
> > +     err =3D virtbt_open_vdev(vbt);
> > +     if (err)
> > +             goto open_failed;
> > +
> >       return 0;
> >
> > +open_failed:
> > +     hci_free_dev(hdev);
> >   failed:
> >       vdev->config->del_vqs(vdev);
> >       return err;
> > @@ -368,6 +382,7 @@ static void virtbt_remove(struct virtio_device *vde=
v)
> >
> >       hci_unregister_dev(hdev);
> >       virtio_reset_device(vdev);
> > +     virtbt_close_vdev(vbt);
> >
> >       hci_free_dev(hdev);
> >       vbt->hdev =3D NULL;
>
> Please mind our privacy notice<https://www.opensynergy.com/datenschutzerk=
laerung/privacy-notice-for-business-partners-pursuant-to-article-13-of-the-=
general-data-protection-regulation-gdpr/> pursuant to Art. 13 GDPR. // Unse=
re Hinweise zum Datenschutz gem. Art. 13 DSGVO finden Sie hier.<https://www=
.opensynergy.com/de/datenschutzerklaerung/datenschutzhinweise-fuer-geschaef=
tspartner-gem-art-13-dsgvo/>



--=20
Luiz Augusto von Dentz
