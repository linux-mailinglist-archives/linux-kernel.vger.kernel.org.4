Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F7C26DD35B
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Apr 2023 08:48:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230251AbjDKGs3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Apr 2023 02:48:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229692AbjDKGsG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Apr 2023 02:48:06 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7BC9E5F
        for <linux-kernel@vger.kernel.org>; Mon, 10 Apr 2023 23:47:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1681195639;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=V9gO+bpW3AHSE73I26Y97+msrTI4VFvHhSOvSR3sXWM=;
        b=DdZlbDF780eS5ou/SqFVbz/kl4kj6YqkbcHdVA7L620PkXE0mTYxjkNfCg/sJK3LiBn/+p
        cnHJ0hUyHt8CY4B4YKmD5FWTCnIVf7AMAG4b4kR0pL9MsGYx4t6fg5fDQInVbnkPuBTKIw
        TLVQC7HJpc/1s4EaXqOqZxiHb1V/46U=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-592-JLo6zi3xM6SOzC3VOdHoWg-1; Tue, 11 Apr 2023 02:47:17 -0400
X-MC-Unique: JLo6zi3xM6SOzC3VOdHoWg-1
Received: by mail-wm1-f69.google.com with SMTP id d8-20020a05600c3ac800b003edf7d484d4so1363675wms.0
        for <linux-kernel@vger.kernel.org>; Mon, 10 Apr 2023 23:47:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1681195636;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=V9gO+bpW3AHSE73I26Y97+msrTI4VFvHhSOvSR3sXWM=;
        b=H+gvKRjn38CMjKxqc6z8OgpSPDadQ+h3CpaMPbBRS2CJX7U68WK93qZ/ddYJQBc3Fh
         LkcasyMNfRrWo50d7Hl8+Pzj9JCD/b+XX10aSStiYLKE7LLLxKGavdYoAXR0QprE/EpB
         oK5NA3B0tiERwFZWSpUAiWngXlBESntHqMBbWlC71sTYF/rIZ8JZZDk8QyligHN5dFP7
         r6bCGYDddq2KSiT9sdD6unLgAJtEUGLLzkMtVui6VpXDBOqJmvLiU3aOqBvP1brS56tM
         IZmdF7yTr64hV6kGK4ie3ovZGByRm6HHTF8kGQ74EsbTsilX6Z0CfbITKFuN0FsFI6Ji
         8XDg==
X-Gm-Message-State: AAQBX9cbrPqrV9YEH+gNAjt2zH68/Cc3rmuQ2vd0yoZ6X/+g6uxGWmyd
        FMDAIjgK9mtc+D+ReECynVesbk8ERYk+TwcrST5d1YOh+KEf5gCtjNac/ih2h6Q7QNbU+d1+eQ6
        FyhoOnY0qtgKvWmE6iXZupVfM
X-Received: by 2002:a5d:58eb:0:b0:2ce:a898:a896 with SMTP id f11-20020a5d58eb000000b002cea898a896mr1099895wrd.30.1681195636289;
        Mon, 10 Apr 2023 23:47:16 -0700 (PDT)
X-Google-Smtp-Source: AKy350Ydu2pmoQjR4kMU5a3KxFUS4XFNjSgufHz+X/MSysKL1tN1PNaTANuqPfv+5+xg+KFjjM9mHg==
X-Received: by 2002:a5d:58eb:0:b0:2ce:a898:a896 with SMTP id f11-20020a5d58eb000000b002cea898a896mr1099885wrd.30.1681195636004;
        Mon, 10 Apr 2023 23:47:16 -0700 (PDT)
Received: from redhat.com ([2.52.10.80])
        by smtp.gmail.com with ESMTPSA id m5-20020adfe945000000b002f006acacc1sm6337227wrn.97.2023.04.10.23.47.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Apr 2023 23:47:15 -0700 (PDT)
Date:   Tue, 11 Apr 2023 02:47:12 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Angus Chen <angus.chen@jaguarmicro.com>
Cc:     Jason Wang <jasowang@redhat.com>,
        "virtualization@lists.linux-foundation.org" 
        <virtualization@lists.linux-foundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] virtio_pci: Wait for legacy device to be reset
Message-ID: <20230411024459-mutt-send-email-mst@kernel.org>
References: <20230411013833.1305-1-angus.chen@jaguarmicro.com>
 <CACGkMEscqtaTpCed_f2cfknO4--mXCyp33u1CmZwNEZxyf=ifQ@mail.gmail.com>
 <TY2PR06MB3424BACFA8B6CB463C12E31E859A9@TY2PR06MB3424.apcprd06.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <TY2PR06MB3424BACFA8B6CB463C12E31E859A9@TY2PR06MB3424.apcprd06.prod.outlook.com>
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 11, 2023 at 06:36:39AM +0000, Angus Chen wrote:
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

I am not 100% sure what does this mean.
So it's a transitional device then?


>   And we use this host vdpa+ legacy virtio in vm to hot migration,we found that the
>   Legacy model often get the middle state value after reset and probe again.
>   The Soc is Simulated by fpga which is run slower than the host,so the same bug 
>   Is found more frequently when the host use the other kernel like ubuntu or centos8.
> 
>   So we hope we can fix this by upstream .
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

