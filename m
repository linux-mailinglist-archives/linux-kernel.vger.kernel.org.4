Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9019E6DD307
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Apr 2023 08:40:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230310AbjDKGkg convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Tue, 11 Apr 2023 02:40:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229981AbjDKGke (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Apr 2023 02:40:34 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6187BC
        for <linux-kernel@vger.kernel.org>; Mon, 10 Apr 2023 23:39:48 -0700 (PDT)
Received: from mail-oo1-f69.google.com (mail-oo1-f69.google.com
 [209.85.161.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-65-iqbP9EBwNtiIqgpDGExeDw-1; Tue, 11 Apr 2023 02:39:46 -0400
X-MC-Unique: iqbP9EBwNtiIqgpDGExeDw-1
Received: by mail-oo1-f69.google.com with SMTP id x132-20020a4a418a000000b0053b4ee58e0fso2355099ooa.17
        for <linux-kernel@vger.kernel.org>; Mon, 10 Apr 2023 23:39:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1681195186; x=1683787186;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bmgGEYzkVZaUbgzmMbzoh5F6gwzYR6Zn8qNHV7angps=;
        b=OpP0VU7/xzcFoTaTcsGb/GHq/6cGtD+zN6EhJ47vS/r8evvJVEw3DnQKxHPuT357XW
         UqxPzSNhpU85uZwspI/MZMB45wFldO7m8hTjMwiuD0G43cCBv2ZrAJoC2lXmgJFakoRg
         3V1nsQC1K/TGkVlvlXjv3EQI5b1lezxCk0aQcrKmE1DqUIFPj9En7UDQfbYXWXu9IRZT
         EsHj2HXmDoXWSzex7mYm+b+oy2qt7N2VfGPxQ4AAhIGujy1gtTdJdvpL0ttTq/wLHX7i
         /Dokg/FB50XeI+Gis8LLy5G5Kh1voZYkWn5aDao/nvMnpYJiHyma3YkfMT78+Tt/MkpE
         08fw==
X-Gm-Message-State: AAQBX9eHHD3uFHTZiqsImGW+N4a9hJ2+ZnL+lx9t1K9mor5CVk+ywXoB
        eTP16LA8qSM6lCqbXUJqHYnFZQOV3eoRF7u6UB4z2Ic/hbJtVvDq8KP7AAEs4DoG1XdKstRVRQ5
        +zFTpg/koXJMBt3xeqZBBN5/Y6s71QALVjdMHJy57W9EoWY0QWBAuRw==
X-Received: by 2002:a54:4108:0:b0:389:86c3:b1fb with SMTP id l8-20020a544108000000b0038986c3b1fbmr1861475oic.9.1681195185869;
        Mon, 10 Apr 2023 23:39:45 -0700 (PDT)
X-Google-Smtp-Source: AKy350ZEuZdp/C/o7wvVXcAKKH0TG5seFsikb2lfTlxMLNcl5IJsjXU5OmKoZpXD/zEuzPQwxMhpCJdcfqdotgxeon8=
X-Received: by 2002:a54:4108:0:b0:389:86c3:b1fb with SMTP id
 l8-20020a544108000000b0038986c3b1fbmr1861473oic.9.1681195185664; Mon, 10 Apr
 2023 23:39:45 -0700 (PDT)
MIME-Version: 1.0
References: <20230411013833.1305-1-angus.chen@jaguarmicro.com>
 <CACGkMEscqtaTpCed_f2cfknO4--mXCyp33u1CmZwNEZxyf=ifQ@mail.gmail.com> <TY2PR06MB3424BACFA8B6CB463C12E31E859A9@TY2PR06MB3424.apcprd06.prod.outlook.com>
In-Reply-To: <TY2PR06MB3424BACFA8B6CB463C12E31E859A9@TY2PR06MB3424.apcprd06.prod.outlook.com>
From:   Jason Wang <jasowang@redhat.com>
Date:   Tue, 11 Apr 2023 14:39:34 +0800
Message-ID: <CACGkMEuOK+XqSa93a7+ki25yjVWSzfSzd5nsqMUo8sH1=B9hRg@mail.gmail.com>
Subject: Re: [PATCH] virtio_pci: Wait for legacy device to be reset
To:     Angus Chen <angus.chen@jaguarmicro.com>
Cc:     "mst@redhat.com" <mst@redhat.com>,
        "virtualization@lists.linux-foundation.org" 
        <virtualization@lists.linux-foundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=0.0 required=5.0 tests=RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 11, 2023 at 2:36 PM Angus Chen <angus.chen@jaguarmicro.com> wrote:
>
> Hi.
>
> > -----Original Message-----
> > From: Jason Wang <jasowang@redhat.com>
> > Sent: Tuesday, April 11, 2023 1:24 PM
> > To: Angus Chen <angus.chen@jaguarmicro.com>
> > Cc: mst@redhat.com; virtualization@lists.linux-foundation.org;
> > linux-kernel@vger.kernel.org
> > Subject: Re: [PATCH] virtio_pci: Wait for legacy device to be reset
> >
> > On Tue, Apr 11, 2023 at 9:39 AM Angus Chen <angus.chen@jaguarmicro.com>
> > wrote:
> > >
> > > We read the status of device after reset,
> > > It is not guaranteed that the device be reseted successfully.
> > > We can use a while loop to make sure that,like the modern device did.
> > > The spec is not request it ,but it work.
> >
> > The only concern is if it's too late to do this.
> >
> > Btw, any reason you want to have a legacy hardware implementation. It
> > will be very tricky to work correctly.
>   En,I found this in the real production environment some times about one year ago.
> and I fix this out of tree.our virtio card had been sold about thousands .
>
>   Now,we created a new card, it support virtio 0.95,1.0,1.1 etc.
>   And we use this host vdpa+ legacy virtio in vm to hot migration,we found that the
>   Legacy model often get the middle state value after reset and probe again.
>   The Soc is Simulated by fpga which is run slower than the host,so the same bug
>   Is found more frequently when the host use the other kernel like ubuntu or centos8.
>
>   So we hope we can fix this by upstream .

I think you can do mediation in your hypervisor.

When trapping set_status(), the hypervisor will not return until it
reads 0 from the hardware?

Thanks

> >
> > Thanks
> >
> > >
> > > Signed-off-by: Angus Chen <angus.chen@jaguarmicro.com>
> > > ---
> > >  drivers/virtio/virtio_pci_legacy.c | 4 +++-
> > >  1 file changed, 3 insertions(+), 1 deletion(-)
> > >
> > > diff --git a/drivers/virtio/virtio_pci_legacy.c b/drivers/virtio/virtio_pci_legacy.c
> > > index 2257f1b3d8ae..f2d241563e4f 100644
> > > --- a/drivers/virtio/virtio_pci_legacy.c
> > > +++ b/drivers/virtio/virtio_pci_legacy.c
> > > @@ -14,6 +14,7 @@
> > >   *  Michael S. Tsirkin <mst@redhat.com>
> > >   */
> > >
> > > +#include <linux/delay.h>
> > >  #include "linux/virtio_pci_legacy.h"
> > >  #include "virtio_pci_common.h"
> > >
> > > @@ -97,7 +98,8 @@ static void vp_reset(struct virtio_device *vdev)
> > >         vp_legacy_set_status(&vp_dev->ldev, 0);
> > >         /* Flush out the status write, and flush in device writes,
> > >          * including MSi-X interrupts, if any. */
> > > -       vp_legacy_get_status(&vp_dev->ldev);
> > > +       while (vp_legacy_get_status(&vp_dev->ldev))
> > > +               msleep(1);
> > >         /* Flush pending VQ/configuration callbacks. */
> > >         vp_synchronize_vectors(vdev);
> > >  }
> > > --
> > > 2.25.1
> > >
>

