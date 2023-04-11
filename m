Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 333086DD386
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Apr 2023 08:56:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230309AbjDKG4u (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Apr 2023 02:56:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230261AbjDKG4t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Apr 2023 02:56:49 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9F3C46A4
        for <linux-kernel@vger.kernel.org>; Mon, 10 Apr 2023 23:55:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1681196140;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=+zCqBAbm5qTYKfMyXgiPulTFZxoOZvyL5XnQNHyUmjU=;
        b=TZn8rAx3WvAWGXIn7mVG04LZzf75LQe27jK2bAwYrWtlBoINU2Bv/eVhVIApN71SOC2j4P
        OdqJvBf+nO0cN3J2942t0x+v4R1aAX+vgquvnm2YR+Fe79HkCsUDzMo887ORZLNp4S6kO0
        N+hNznk7jGm3pSnptGwZ1I73jEUUTJo=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-187-398ig7mdPNeIYWRXNjLrQw-1; Tue, 11 Apr 2023 02:55:39 -0400
X-MC-Unique: 398ig7mdPNeIYWRXNjLrQw-1
Received: by mail-wm1-f70.google.com with SMTP id t8-20020a05600c450800b003ee6dbceb81so1348141wmo.5
        for <linux-kernel@vger.kernel.org>; Mon, 10 Apr 2023 23:55:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1681196138;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+zCqBAbm5qTYKfMyXgiPulTFZxoOZvyL5XnQNHyUmjU=;
        b=cvUpGu4kdkVzYBy03fH/m7TSH9Mc3a8eH5dtHcAYtutdrOeBVHmEwljomFA6h2Z17t
         WCPCliG3eUVGhheSToRzWW00fsPti1NsSFwV/NBVe9G6+vHi+ab66btvTrragscsg7VZ
         E3q0zzMxUVzC5Ses7jZ0vDVgzBceWhARNOx9R+wmbBFeh4pd865ztng/hW5NZ8M4r57u
         l1LHLYUMKuR3v2hczgmFXj4phgSZoBynAxY3BJqHboDRE5HnsYLVlSMJ77gOj27bCshi
         Ri8H9jILN/QQg6Nx9mayfqGHNp4h+1JRVzZWsS+iNB56HXWRiVtyH6jqJ+hBYB7/anzD
         sWRQ==
X-Gm-Message-State: AAQBX9e52Xn9Cjry5KH4WAzpOUM2MEs6JKJsScHHCcYXRP/s9CiXJxD7
        toTaeyjQcHqmcpcGwkPhbazP0/lmAlXaDQVzgQKzyHmF4f7cT+DzAzbHRv8LyA6VSE+SnOQUmkG
        FftSmDmuhRkFzD0es7HD44mJ/awQGvbOO
X-Received: by 2002:a7b:cd0a:0:b0:3ed:5a12:5641 with SMTP id f10-20020a7bcd0a000000b003ed5a125641mr8925385wmj.36.1681196136570;
        Mon, 10 Apr 2023 23:55:36 -0700 (PDT)
X-Google-Smtp-Source: AKy350ZrsPd8G4tkwqcJfLbRy5yd5WQq51HiKg3l0+zbzKKMWhVaXKtP/pVtrYG0ybGrKVrvsfL9Hg==
X-Received: by 2002:a7b:cd0a:0:b0:3ed:5a12:5641 with SMTP id f10-20020a7bcd0a000000b003ed5a125641mr8925371wmj.36.1681196136209;
        Mon, 10 Apr 2023 23:55:36 -0700 (PDT)
Received: from redhat.com ([2.52.10.80])
        by smtp.gmail.com with ESMTPSA id f1-20020adfe901000000b002f0442a2d3asm5474879wrm.48.2023.04.10.23.55.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Apr 2023 23:55:35 -0700 (PDT)
Date:   Tue, 11 Apr 2023 02:55:32 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Angus Chen <angus.chen@jaguarmicro.com>
Cc:     Jason Wang <jasowang@redhat.com>,
        "virtualization@lists.linux-foundation.org" 
        <virtualization@lists.linux-foundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] virtio_pci: Wait for legacy device to be reset
Message-ID: <20230411025335-mutt-send-email-mst@kernel.org>
References: <20230411013833.1305-1-angus.chen@jaguarmicro.com>
 <CACGkMEscqtaTpCed_f2cfknO4--mXCyp33u1CmZwNEZxyf=ifQ@mail.gmail.com>
 <TY2PR06MB3424BACFA8B6CB463C12E31E859A9@TY2PR06MB3424.apcprd06.prod.outlook.com>
 <20230411024459-mutt-send-email-mst@kernel.org>
 <TY2PR06MB3424E3C222C3B896BB583DFD859A9@TY2PR06MB3424.apcprd06.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <TY2PR06MB3424E3C222C3B896BB583DFD859A9@TY2PR06MB3424.apcprd06.prod.outlook.com>
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 11, 2023 at 06:49:03AM +0000, Angus Chen wrote:
> 
> 
> > -----Original Message-----
> > From: Michael S. Tsirkin <mst@redhat.com>
> > Sent: Tuesday, April 11, 2023 2:47 PM
> > To: Angus Chen <angus.chen@jaguarmicro.com>
> > Cc: Jason Wang <jasowang@redhat.com>;
> > virtualization@lists.linux-foundation.org; linux-kernel@vger.kernel.org
> > Subject: Re: [PATCH] virtio_pci: Wait for legacy device to be reset
> > 
> > On Tue, Apr 11, 2023 at 06:36:39AM +0000, Angus Chen wrote:
> > > Hi.
> > >
> > > > -----Original Message-----
> > > > From: Jason Wang <jasowang@redhat.com>
> > > > Sent: Tuesday, April 11, 2023 1:24 PM
> > > > To: Angus Chen <angus.chen@jaguarmicro.com>
> > > > Cc: mst@redhat.com; virtualization@lists.linux-foundation.org;
> > > > linux-kernel@vger.kernel.org
> > > > Subject: Re: [PATCH] virtio_pci: Wait for legacy device to be reset
> > > >
> > > > On Tue, Apr 11, 2023 at 9:39 AM Angus Chen
> > <angus.chen@jaguarmicro.com>
> > > > wrote:
> > > > >
> > > > > We read the status of device after reset,
> > > > > It is not guaranteed that the device be reseted successfully.
> > > > > We can use a while loop to make sure that,like the modern device did.
> > > > > The spec is not request it ,but it work.
> > > >
> > > > The only concern is if it's too late to do this.
> > > >
> > > > Btw, any reason you want to have a legacy hardware implementation. It
> > > > will be very tricky to work correctly.
> > >   En,I found this in the real production environment some times about one
> > year ago.
> > > and I fix this out of tree.our virtio card had been sold about thousands .
> > >
> > >   Now,we created a new card, it support virtio 0.95,1.0,1.1 etc.
> > 
> > I am not 100% sure what does this mean.
> > So it's a transitional device then?
> Hi mst,it is a real card in the In cloud computing ,not transitional device.

yes, a real card. But you said it supports 0.95, 1.0 and 1.1 guests,
so this is what the virtio spec calls a transitional device, right?

	To simplify transition from these earlier draft interfaces,
	a device MAY implement:

	\begin{description}
	\item[Transitional Device]
		a device supporting both drivers conforming to this
		specification, and allowing legacy drivers.
	\end{description}

or did I misunderstand?


> > 
> > 
> > >   And we use this host vdpa+ legacy virtio in vm to hot migration,we found
> > that the
> > >   Legacy model often get the middle state value after reset and probe again.
> > >   The Soc is Simulated by fpga which is run slower than the host,so the same
> > bug
> > >   Is found more frequently when the host use the other kernel like ubuntu or
> > centos8.
> > >
> > >   So we hope we can fix this by upstream .
> > > >
> > > > Thanks
> > > >
> > > > >
> > > > > Signed-off-by: Angus Chen <angus.chen@jaguarmicro.com>
> > > > > ---
> > > > >  drivers/virtio/virtio_pci_legacy.c | 4 +++-
> > > > >  1 file changed, 3 insertions(+), 1 deletion(-)
> > > > >
> > > > > diff --git a/drivers/virtio/virtio_pci_legacy.c
> > b/drivers/virtio/virtio_pci_legacy.c
> > > > > index 2257f1b3d8ae..f2d241563e4f 100644
> > > > > --- a/drivers/virtio/virtio_pci_legacy.c
> > > > > +++ b/drivers/virtio/virtio_pci_legacy.c
> > > > > @@ -14,6 +14,7 @@
> > > > >   *  Michael S. Tsirkin <mst@redhat.com>
> > > > >   */
> > > > >
> > > > > +#include <linux/delay.h>
> > > > >  #include "linux/virtio_pci_legacy.h"
> > > > >  #include "virtio_pci_common.h"
> > > > >
> > > > > @@ -97,7 +98,8 @@ static void vp_reset(struct virtio_device *vdev)
> > > > >         vp_legacy_set_status(&vp_dev->ldev, 0);
> > > > >         /* Flush out the status write, and flush in device writes,
> > > > >          * including MSi-X interrupts, if any. */
> > > > > -       vp_legacy_get_status(&vp_dev->ldev);
> > > > > +       while (vp_legacy_get_status(&vp_dev->ldev))
> > > > > +               msleep(1);
> > > > >         /* Flush pending VQ/configuration callbacks. */
> > > > >         vp_synchronize_vectors(vdev);
> > > > >  }
> > > > > --
> > > > > 2.25.1
> > > > >
> > >
> 

