Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CF00F6DD33C
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Apr 2023 08:45:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229981AbjDKGpK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Apr 2023 02:45:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229536AbjDKGpI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Apr 2023 02:45:08 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CEDD6E60
        for <linux-kernel@vger.kernel.org>; Mon, 10 Apr 2023 23:44:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1681195469;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ce3o9m8QJKudhAZFM4SLAGCXqk/LwfHWpmmOCipSLBY=;
        b=BfC9p2BCcEfE1KW0/JKNBsBT4APXxed9f/6lXLh1C3mmHp9UnVo3JwPjOHHmKbtYnKXRKc
        44zbGabTtp/+SjhC/7vsyzcsPAfRHqSHx2wRxBNcJSVwzE+BsC8ToSq+EML4NRJ0m1ftgN
        nqRS6cf1cg/t00YevDFBLGeWGnxux08=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-117-PqGzCGM7NaK0roKJ1sBw6w-1; Tue, 11 Apr 2023 02:44:27 -0400
X-MC-Unique: PqGzCGM7NaK0roKJ1sBw6w-1
Received: by mail-wm1-f71.google.com with SMTP id l36-20020a05600c1d2400b003edd119ec9eso2140699wms.0
        for <linux-kernel@vger.kernel.org>; Mon, 10 Apr 2023 23:44:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1681195466;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ce3o9m8QJKudhAZFM4SLAGCXqk/LwfHWpmmOCipSLBY=;
        b=rGufKh5tcC1aPlF8j8m84ay8/E6Sto47I5gW4pbhRuj1b5YMtOakR290GuL4xZ0Xd1
         qG8auBJTWyo5fHR3lcPdhyFMN/cQ7CA/VcPK0dr+1BHFICywDGs48AzJefeJfo841mWa
         LE//53n0QmoZAgOSFmuKNhSFlJAdEUQrbycOCy4cU675UhHfBL7/A4w4o6iz9moXrRwz
         fv5Sky1ZI116+xxOJMhfBNzRTEMEtynnj5XDzSCViZz4aHp4JIyrpWptObpRt9X8ptq3
         sWcScBaJg14z6QJztYPGRzvU3wbokscIO6xUHspFpGiKM8aJoUc/oiknnOF23MQqLpcf
         gQwQ==
X-Gm-Message-State: AAQBX9fBRW7SU2t/pYjHvinA6MsU5G3xPKsvd6o9xbuRoMGi2GtC4Nzm
        bCWzg8vX2ZugX9gy4FBPyjngHXKxGSrW+PsPf40FUy/+EWx/z6/2OOxI8T9/+M6JHMCH3HOBZiI
        42p7+J0SkMZbU/q5KXUsfyTQW
X-Received: by 2002:a5d:544b:0:b0:2ef:5d73:f6b7 with SMTP id w11-20020a5d544b000000b002ef5d73f6b7mr5727289wrv.13.1681195466637;
        Mon, 10 Apr 2023 23:44:26 -0700 (PDT)
X-Google-Smtp-Source: AKy350ZRDGqjLP0vISyJctE2RVlecshmpp3ic4ZGNdzUIANxMkFafXjwaw0b2tY98SsLDju/2XSNiw==
X-Received: by 2002:a5d:544b:0:b0:2ef:5d73:f6b7 with SMTP id w11-20020a5d544b000000b002ef5d73f6b7mr5727281wrv.13.1681195466347;
        Mon, 10 Apr 2023 23:44:26 -0700 (PDT)
Received: from redhat.com ([2.52.10.80])
        by smtp.gmail.com with ESMTPSA id i2-20020a05600011c200b002d7a75a2c20sm13712803wrx.80.2023.04.10.23.44.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Apr 2023 23:44:25 -0700 (PDT)
Date:   Tue, 11 Apr 2023 02:44:22 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Jason Wang <jasowang@redhat.com>
Cc:     Angus Chen <angus.chen@jaguarmicro.com>,
        "virtualization@lists.linux-foundation.org" 
        <virtualization@lists.linux-foundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] virtio_pci: Wait for legacy device to be reset
Message-ID: <20230411024155-mutt-send-email-mst@kernel.org>
References: <20230411013833.1305-1-angus.chen@jaguarmicro.com>
 <CACGkMEscqtaTpCed_f2cfknO4--mXCyp33u1CmZwNEZxyf=ifQ@mail.gmail.com>
 <TY2PR06MB3424BACFA8B6CB463C12E31E859A9@TY2PR06MB3424.apcprd06.prod.outlook.com>
 <CACGkMEuOK+XqSa93a7+ki25yjVWSzfSzd5nsqMUo8sH1=B9hRg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CACGkMEuOK+XqSa93a7+ki25yjVWSzfSzd5nsqMUo8sH1=B9hRg@mail.gmail.com>
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 11, 2023 at 02:39:34PM +0800, Jason Wang wrote:
> On Tue, Apr 11, 2023 at 2:36 PM Angus Chen <angus.chen@jaguarmicro.com> wrote:
> >
> > Hi.
> >
> > > -----Original Message-----
> > > From: Jason Wang <jasowang@redhat.com>
> > > Sent: Tuesday, April 11, 2023 1:24 PM
> > > To: Angus Chen <angus.chen@jaguarmicro.com>
> > > Cc: mst@redhat.com; virtualization@lists.linux-foundation.org;
> > > linux-kernel@vger.kernel.org
> > > Subject: Re: [PATCH] virtio_pci: Wait for legacy device to be reset
> > >
> > > On Tue, Apr 11, 2023 at 9:39 AM Angus Chen <angus.chen@jaguarmicro.com>
> > > wrote:
> > > >
> > > > We read the status of device after reset,
> > > > It is not guaranteed that the device be reseted successfully.
> > > > We can use a while loop to make sure that,like the modern device did.
> > > > The spec is not request it ,but it work.
> > >
> > > The only concern is if it's too late to do this.
> > >
> > > Btw, any reason you want to have a legacy hardware implementation. It
> > > will be very tricky to work correctly.
> >   En,I found this in the real production environment some times about one year ago.
> > and I fix this out of tree.our virtio card had been sold about thousands .
> >
> >   Now,we created a new card, it support virtio 0.95,1.0,1.1 etc.
> >   And we use this host vdpa+ legacy virtio in vm to hot migration,we found that the
> >   Legacy model often get the middle state value after reset and probe again.
> >   The Soc is Simulated by fpga which is run slower than the host,so the same bug
> >   Is found more frequently when the host use the other kernel like ubuntu or centos8.
> >
> >   So we hope we can fix this by upstream .
> 
> I think you can do mediation in your hypervisor.
> 
> When trapping set_status(), the hypervisor will not return until it
> reads 0 from the hardware?
> 
> Thanks

Note that for legacy guests, 0 status write is not the only way
to reset the device, writing 0 into pa is another.



> > >
> > > Thanks
> > >
> > > >
> > > > Signed-off-by: Angus Chen <angus.chen@jaguarmicro.com>
> > > > ---
> > > >  drivers/virtio/virtio_pci_legacy.c | 4 +++-
> > > >  1 file changed, 3 insertions(+), 1 deletion(-)
> > > >
> > > > diff --git a/drivers/virtio/virtio_pci_legacy.c b/drivers/virtio/virtio_pci_legacy.c
> > > > index 2257f1b3d8ae..f2d241563e4f 100644
> > > > --- a/drivers/virtio/virtio_pci_legacy.c
> > > > +++ b/drivers/virtio/virtio_pci_legacy.c
> > > > @@ -14,6 +14,7 @@
> > > >   *  Michael S. Tsirkin <mst@redhat.com>
> > > >   */
> > > >
> > > > +#include <linux/delay.h>
> > > >  #include "linux/virtio_pci_legacy.h"
> > > >  #include "virtio_pci_common.h"
> > > >
> > > > @@ -97,7 +98,8 @@ static void vp_reset(struct virtio_device *vdev)
> > > >         vp_legacy_set_status(&vp_dev->ldev, 0);
> > > >         /* Flush out the status write, and flush in device writes,
> > > >          * including MSi-X interrupts, if any. */
> > > > -       vp_legacy_get_status(&vp_dev->ldev);
> > > > +       while (vp_legacy_get_status(&vp_dev->ldev))
> > > > +               msleep(1);
> > > >         /* Flush pending VQ/configuration callbacks. */
> > > >         vp_synchronize_vectors(vdev);
> > > >  }
> > > > --
> > > > 2.25.1
> > > >
> >

