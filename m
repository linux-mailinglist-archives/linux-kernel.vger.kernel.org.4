Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 680716DD3F7
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Apr 2023 09:22:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229794AbjDKHWA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Apr 2023 03:22:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229485AbjDKHV7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Apr 2023 03:21:59 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A712E4
        for <linux-kernel@vger.kernel.org>; Tue, 11 Apr 2023 00:21:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1681197677;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=tAZEXAkipCz/UZI0IW4Zs9IwForteUAjpxiZW8fBEfw=;
        b=iQpf/gRzm4S+8WCCfF4SmyZQWwMvUX6CfEiSRc7NEQjwHoE2gJoa1eLyo+e3qyUcg7k9bc
        5kfGcG/iyQg/4PNO+TxSj5+7/kHcqafCN4G+yqJcwjBqp4bNDELjW7CiIPxaCzoHZqf0Er
        1TRit8Izy7o6MukvoXOGwpVRmsaeJIA=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-202-KmN_gJSUPGWmaDVcBY0l8g-1; Tue, 11 Apr 2023 03:21:16 -0400
X-MC-Unique: KmN_gJSUPGWmaDVcBY0l8g-1
Received: by mail-wr1-f72.google.com with SMTP id k17-20020adfb351000000b002efa910ecebso1265127wrd.8
        for <linux-kernel@vger.kernel.org>; Tue, 11 Apr 2023 00:21:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1681197675;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tAZEXAkipCz/UZI0IW4Zs9IwForteUAjpxiZW8fBEfw=;
        b=ay3hxrW+HwzKLFqIt6nl5oJUWhHi+HA9iNPUFlR60Z7su1dVTtqgoWPyxHspd5yibY
         1RSOYloNoGrNPG3KHOCYCfq19pydY6YWCKl+sCPbbtUvCx2OzHuRfK1fmmMvUVKU/nCY
         2UgD/f+x2v6m1y1F/OLgco1WxJ/QQ0Nhtuci4Xu4L+L/BIxoWuFvfg/Zbo7MyYfGa2au
         VR6UYX+TLTJiAofJMTvukot4mUsDKabx26ioIhQz4SEQBo0il9Pv4BVVLaouNki4bu8d
         FDoUJa6PcrSWo2wbuJ5ctA4wZ5jUgh+LPNqpRdM4jWMuntpERfa+sCHRsohNZgZNVyyN
         a+2A==
X-Gm-Message-State: AAQBX9dLOju60+oqfRxbKnNACmoMbUbBE1UfNUs21g9nyn3OLzKVgEPl
        BWU6qKuDHMpjZ1omKowOJwjkg9nMsAfsJfAXkbA0p4mVGeUEopO0W+IlgV3qBkvWdYFSHZ0Gscb
        m2/2mMtE4NhBKnfv4PiW7vodI
X-Received: by 2002:adf:cf11:0:b0:2ef:eb54:4dbc with SMTP id o17-20020adfcf11000000b002efeb544dbcmr5751655wrj.28.1681197675015;
        Tue, 11 Apr 2023 00:21:15 -0700 (PDT)
X-Google-Smtp-Source: AKy350bRKpwgpjP8BABfdHYs8C9Q+Dd81bOh2t9RU67SmRqY79xVbk1X/TA83fjyWrCHVFs3idDVkQ==
X-Received: by 2002:adf:cf11:0:b0:2ef:eb54:4dbc with SMTP id o17-20020adfcf11000000b002efeb544dbcmr5751640wrj.28.1681197674610;
        Tue, 11 Apr 2023 00:21:14 -0700 (PDT)
Received: from redhat.com ([2.52.10.80])
        by smtp.gmail.com with ESMTPSA id e4-20020a5d5944000000b002f02df4c7a3sm5734273wri.30.2023.04.11.00.21.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Apr 2023 00:21:13 -0700 (PDT)
Date:   Tue, 11 Apr 2023 03:21:10 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Angus Chen <angus.chen@jaguarmicro.com>
Cc:     Jason Wang <jasowang@redhat.com>,
        "virtualization@lists.linux-foundation.org" 
        <virtualization@lists.linux-foundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] virtio_pci: Wait for legacy device to be reset
Message-ID: <20230411032014-mutt-send-email-mst@kernel.org>
References: <20230411013833.1305-1-angus.chen@jaguarmicro.com>
 <CACGkMEscqtaTpCed_f2cfknO4--mXCyp33u1CmZwNEZxyf=ifQ@mail.gmail.com>
 <TY2PR06MB3424BACFA8B6CB463C12E31E859A9@TY2PR06MB3424.apcprd06.prod.outlook.com>
 <20230411024459-mutt-send-email-mst@kernel.org>
 <TY2PR06MB3424E3C222C3B896BB583DFD859A9@TY2PR06MB3424.apcprd06.prod.outlook.com>
 <20230411025335-mutt-send-email-mst@kernel.org>
 <TY2PR06MB3424DB10784CA5504A10099E859A9@TY2PR06MB3424.apcprd06.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <TY2PR06MB3424DB10784CA5504A10099E859A9@TY2PR06MB3424.apcprd06.prod.outlook.com>
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 11, 2023 at 07:17:14AM +0000, Angus Chen wrote:
> 
> 
> > -----Original Message-----
> > From: Michael S. Tsirkin <mst@redhat.com>
> > Sent: Tuesday, April 11, 2023 2:56 PM
> > To: Angus Chen <angus.chen@jaguarmicro.com>
> > Cc: Jason Wang <jasowang@redhat.com>;
> > virtualization@lists.linux-foundation.org; linux-kernel@vger.kernel.org
> > Subject: Re: [PATCH] virtio_pci: Wait for legacy device to be reset
> > 
> > On Tue, Apr 11, 2023 at 06:49:03AM +0000, Angus Chen wrote:
> > >
> > >
> > > > -----Original Message-----
> > > > From: Michael S. Tsirkin <mst@redhat.com>
> > > > Sent: Tuesday, April 11, 2023 2:47 PM
> > > > To: Angus Chen <angus.chen@jaguarmicro.com>
> > > > Cc: Jason Wang <jasowang@redhat.com>;
> > > > virtualization@lists.linux-foundation.org; linux-kernel@vger.kernel.org
> > > > Subject: Re: [PATCH] virtio_pci: Wait for legacy device to be reset
> > > >
> > > > On Tue, Apr 11, 2023 at 06:36:39AM +0000, Angus Chen wrote:
> > > > > Hi.
> > > > >
> > > > > > -----Original Message-----
> > > > > > From: Jason Wang <jasowang@redhat.com>
> > > > > > Sent: Tuesday, April 11, 2023 1:24 PM
> > > > > > To: Angus Chen <angus.chen@jaguarmicro.com>
> > > > > > Cc: mst@redhat.com; virtualization@lists.linux-foundation.org;
> > > > > > linux-kernel@vger.kernel.org
> > > > > > Subject: Re: [PATCH] virtio_pci: Wait for legacy device to be reset
> > > > > >
> > > > > > On Tue, Apr 11, 2023 at 9:39 AM Angus Chen
> > > > <angus.chen@jaguarmicro.com>
> > > > > > wrote:
> > > > > > >
> > > > > > > We read the status of device after reset,
> > > > > > > It is not guaranteed that the device be reseted successfully.
> > > > > > > We can use a while loop to make sure that,like the modern device did.
> > > > > > > The spec is not request it ,but it work.
> > > > > >
> > > > > > The only concern is if it's too late to do this.
> > > > > >
> > > > > > Btw, any reason you want to have a legacy hardware implementation. It
> > > > > > will be very tricky to work correctly.
> > > > >   En,I found this in the real production environment some times about
> > one
> > > > year ago.
> > > > > and I fix this out of tree.our virtio card had been sold about thousands .
> > > > >
> > > > >   Now,we created a new card, it support virtio 0.95,1.0,1.1 etc.
> > > >
> > > > I am not 100% sure what does this mean.
> > > > So it's a transitional device then?
> > > Hi mst,it is a real card in the In cloud computing ,not transitional device.
> > 
> > yes, a real card. But you said it supports 0.95, 1.0 and 1.1 guests,
> > so this is what the virtio spec calls a transitional device, right?
> > 
> > 	To simplify transition from these earlier draft interfaces,
> > 	a device MAY implement:
> > 
> > 	\begin{description}
> > 	\item[Transitional Device]
> > 		a device supporting both drivers conforming to this
> > 		specification, and allowing legacy drivers.
> > 	\end{description}
> > 
> > or did I misunderstand?
> > 
> Yes, I'm not sure whether I make myself clear. 
> We support the vritio spec  0.95, 1.0 and 1.1 in the same card.
> And the numer of devices is 1k per one card.
> 
> Btw, thanks a lot for the work of redhat, we just Implement the virtio protocol by hardware.

Yes, not very clear still. What are the device and vendor ID of the
card? Does it have the virtio capabilities?
Thanks

> > 
> > > >
> > > >
> > > > >   And we use this host vdpa+ legacy virtio in vm to hot migration,we
> > found
> > > > that the
> > > > >   Legacy model often get the middle state value after reset and probe
> > again.
> > > > >   The Soc is Simulated by fpga which is run slower than the host,so the
> > same
> > > > bug
> > > > >   Is found more frequently when the host use the other kernel like
> > ubuntu or
> > > > centos8.
> > > > >
> > > > >   So we hope we can fix this by upstream .
> > > > > >
> > > > > > Thanks
> > > > > >
> > > > > > >
> > > > > > > Signed-off-by: Angus Chen <angus.chen@jaguarmicro.com>
> > > > > > > ---
> > > > > > >  drivers/virtio/virtio_pci_legacy.c | 4 +++-
> > > > > > >  1 file changed, 3 insertions(+), 1 deletion(-)
> > > > > > >
> > > > > > > diff --git a/drivers/virtio/virtio_pci_legacy.c
> > > > b/drivers/virtio/virtio_pci_legacy.c
> > > > > > > index 2257f1b3d8ae..f2d241563e4f 100644
> > > > > > > --- a/drivers/virtio/virtio_pci_legacy.c
> > > > > > > +++ b/drivers/virtio/virtio_pci_legacy.c
> > > > > > > @@ -14,6 +14,7 @@
> > > > > > >   *  Michael S. Tsirkin <mst@redhat.com>
> > > > > > >   */
> > > > > > >
> > > > > > > +#include <linux/delay.h>
> > > > > > >  #include "linux/virtio_pci_legacy.h"
> > > > > > >  #include "virtio_pci_common.h"
> > > > > > >
> > > > > > > @@ -97,7 +98,8 @@ static void vp_reset(struct virtio_device *vdev)
> > > > > > >         vp_legacy_set_status(&vp_dev->ldev, 0);
> > > > > > >         /* Flush out the status write, and flush in device writes,
> > > > > > >          * including MSi-X interrupts, if any. */
> > > > > > > -       vp_legacy_get_status(&vp_dev->ldev);
> > > > > > > +       while (vp_legacy_get_status(&vp_dev->ldev))
> > > > > > > +               msleep(1);
> > > > > > >         /* Flush pending VQ/configuration callbacks. */
> > > > > > >         vp_synchronize_vectors(vdev);
> > > > > > >  }
> > > > > > > --
> > > > > > > 2.25.1
> > > > > > >
> > > > >
> > >
> 

