Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C40C95F788D
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Oct 2022 15:02:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229904AbiJGNCM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Oct 2022 09:02:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229899AbiJGNBk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Oct 2022 09:01:40 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4E78114DC3
        for <linux-kernel@vger.kernel.org>; Fri,  7 Oct 2022 06:01:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1665147659;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=+zw5KqJ9vGznW+9ck2aKuAd2+Qsa5aSnhqW3TfQr/Uo=;
        b=i1Y2RpD2P8SQSIpZ7W+mxVbcXxnwC6VDoiyHMQik0A4DQwPSnSfaZWgIHAJlTbZ3lyJ4vZ
        dBnqhtFftzIUV32vRVwpixU0Y3JEdYpRpuje5xjkmDUiG6sDcNKyE/28pee142h+1uSuEt
        RGquXoe7edDgQr6rOYF8xF0XHZQNdfM=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-139-cXLBfdnMPPmX995qgATRZw-1; Fri, 07 Oct 2022 09:00:58 -0400
X-MC-Unique: cXLBfdnMPPmX995qgATRZw-1
Received: by mail-wr1-f72.google.com with SMTP id g15-20020adfbc8f000000b0022a4510a491so1418034wrh.12
        for <linux-kernel@vger.kernel.org>; Fri, 07 Oct 2022 06:00:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+zw5KqJ9vGznW+9ck2aKuAd2+Qsa5aSnhqW3TfQr/Uo=;
        b=YRmkMWP7ehkJ/geRhiwPyUG/NyHW4FnnwE+vQG+HTNnoTYMzkcsgSFrygCjpXlPYT1
         Sy6kNrN47ykCHLxs+ehq437JjfHb5fVoIsAyVTw3i0TG/SW/vMvw60ISfr6L+RA/JMEy
         LOPPbEhlU3Tx8ZHRyv1RlTGJ5+6ndeoSmlE2LKUn1TEjwUKoicW2Zj+hwhsk042biK1V
         yMEWrXmmzdcYrmMHS4OMywast8WdWAMscueodOV/6S1EfYP0YA/vGQgh1Yqf4+QBEvEz
         EYLDOJTU4aO0Hv7ZhcuISYx6ICOYMHWwE0khpTtj2Ivh8Uba9t+C5Zq5EaR1rvipI4+G
         yOWg==
X-Gm-Message-State: ACrzQf0mQTahQh8w5k0c6c5fWW4XdLaBd0rLfq7qIG9gH3Xri9/dmj1N
        07Zrl+4O8TCppIZ2m8QtyOYbYXKJOMlAkqBQ0Po/41TjFt1Wr8/+bHlnzq0bZ9qyDS6D7sdAgSu
        XdXXLPXabZiLNe88cLHgIqmD3
X-Received: by 2002:a5d:5750:0:b0:22d:58d5:338 with SMTP id q16-20020a5d5750000000b0022d58d50338mr3264758wrw.693.1665147657166;
        Fri, 07 Oct 2022 06:00:57 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM4tpFSG1Ueq05PO7eb8POH7gDXfFAlVZ5gCbKaWMW4dB/lQuQhfh8Xkzbb30c6kW9q+5hrxIg==
X-Received: by 2002:a5d:5750:0:b0:22d:58d5:338 with SMTP id q16-20020a5d5750000000b0022d58d50338mr3264680wrw.693.1665147656275;
        Fri, 07 Oct 2022 06:00:56 -0700 (PDT)
Received: from redhat.com ([2.55.183.131])
        by smtp.gmail.com with ESMTPSA id w9-20020a5d6809000000b0022aeba020casm2023912wru.83.2022.10.07.06.00.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Oct 2022 06:00:55 -0700 (PDT)
Date:   Fri, 7 Oct 2022 09:00:51 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Hulk Robot <hulkci@huawei.com>,
        Yang Yingliang <yangyingliang@huawei.com>,
        Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Subject: Re: [PATCH v3] Bluetooth: virtio_bt: fix device removal
Message-ID: <20221007090043-mutt-send-email-mst@kernel.org>
References: <20220811094542.268519-1-mst@redhat.com>
 <CABBYNZLeszHHi2TVcQsOtPWs1u=s8gjOVAhL+Q=O-ThgpxvpOw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CABBYNZLeszHHi2TVcQsOtPWs1u=s8gjOVAhL+Q=O-ThgpxvpOw@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 15, 2022 at 11:07:05AM -0700, Luiz Augusto von Dentz wrote:
> Hi Michael,
> 
> On Thu, Aug 11, 2022 at 2:46 AM Michael S. Tsirkin <mst@redhat.com> wrote:
> >
> > Device removal is clearly out of virtio spec: it attempts to remove
> > unused buffers from a VQ before invoking device reset. To fix, make
> > open/close NOPs and do all cleanup/setup in probe/remove.
> >
> > NB: This is a hacky way to handle this - virtbt_{open,close} as NOP is
> > not really what a driver is supposed to be doing. These are transport
> > enable/disable callbacks from the BT core towards the driver. It maps to
> > a device being enabled/disabled by something like bluetoothd for
> > example. So if disabled, users expect that no resources/queues are in
> > use.  It does work with all other transports like USB, SDIO, UART etc.
> > There should be no buffer used if the device is powered off. We also
> > don’t have any USB URBs in-flight if the transport is not active.
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
> 
> Shouldn't the line above be a Fixes tag with the commit hash you are
> attempting to fix, other than that I'd be fine to apply these changes.


ping? what's going on?

> > Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
> > Reported-by: Hulk Robot <hulkci@huawei.com>
> > Signed-off-by: Yang Yingliang <yangyingliang@huawei.com>
> > Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> > Message-Id: <20220811080943.198245-1-mst@redhat.com>
> > ---
> >
> > changes from v2:
> >         tkeaked commit log to make lines shorter
> > changes from v1:
> >         fixed error handling
> >
> >  drivers/bluetooth/virtio_bt.c | 19 +++++++++++++++++--
> >  1 file changed, 17 insertions(+), 2 deletions(-)
> >
> > diff --git a/drivers/bluetooth/virtio_bt.c b/drivers/bluetooth/virtio_bt.c
> > index 67c21263f9e0..f6d699fed139 100644
> > --- a/drivers/bluetooth/virtio_bt.c
> > +++ b/drivers/bluetooth/virtio_bt.c
> > @@ -50,8 +50,11 @@ static int virtbt_add_inbuf(struct virtio_bluetooth *vbt)
> >
> >  static int virtbt_open(struct hci_dev *hdev)
> >  {
> > -       struct virtio_bluetooth *vbt = hci_get_drvdata(hdev);
> > +       return 0;
> > +}
> >
> > +static int virtbt_open_vdev(struct virtio_bluetooth *vbt)
> > +{
> >         if (virtbt_add_inbuf(vbt) < 0)
> >                 return -EIO;
> >
> > @@ -61,7 +64,11 @@ static int virtbt_open(struct hci_dev *hdev)
> >
> >  static int virtbt_close(struct hci_dev *hdev)
> >  {
> > -       struct virtio_bluetooth *vbt = hci_get_drvdata(hdev);
> > +       return 0;
> > +}
> > +
> > +static int virtbt_close_vdev(struct virtio_bluetooth *vbt)
> > +{
> >         int i;
> >
> >         cancel_work_sync(&vbt->rx);
> > @@ -354,8 +361,15 @@ static int virtbt_probe(struct virtio_device *vdev)
> >                 goto failed;
> >         }
> >
> > +       virtio_device_ready(vdev);
> > +       err = virtbt_open_vdev(vbt);
> > +       if (err)
> > +               goto open_failed;
> > +
> >         return 0;
> >
> > +open_failed:
> > +       hci_free_dev(hdev);
> >  failed:
> >         vdev->config->del_vqs(vdev);
> >         return err;
> > @@ -368,6 +382,7 @@ static void virtbt_remove(struct virtio_device *vdev)
> >
> >         hci_unregister_dev(hdev);
> >         virtio_reset_device(vdev);
> > +       virtbt_close_vdev(vbt);
> >
> >         hci_free_dev(hdev);
> >         vbt->hdev = NULL;
> > --
> > MST
> >
> 
> 
> -- 
> Luiz Augusto von Dentz

