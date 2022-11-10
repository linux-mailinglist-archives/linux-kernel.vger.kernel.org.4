Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ADEE4623B2E
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Nov 2022 06:20:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232107AbiKJFUz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Nov 2022 00:20:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229516AbiKJFUy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Nov 2022 00:20:54 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00AE4A45D
        for <linux-kernel@vger.kernel.org>; Wed,  9 Nov 2022 21:19:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1668057599;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=u96povSyy2sjnCyKRqs1RgXf1LgZIt4bA4dxaS0z0zE=;
        b=ChxRo4RsUYh7v1trYIi5KB35MGFgnUZeGXqP/r/KQ0XvCwrl6zx3Vdg99hFftHhdcoeH9D
        gc0WTCpBmuPMICcCB0XapzSjWiJsX0n2jIzTl+1bFFgoF45UTikUURDYO4fw1aOTPTbIWc
        U9aMQS2PGuNGaXgzhOVKdvTpKBytC6g=
Received: from mail-oo1-f69.google.com (mail-oo1-f69.google.com
 [209.85.161.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-517-OircnX4UN6KbR9Zmlx-fHA-1; Thu, 10 Nov 2022 00:19:57 -0500
X-MC-Unique: OircnX4UN6KbR9Zmlx-fHA-1
Received: by mail-oo1-f69.google.com with SMTP id c4-20020a4a9c44000000b00480da4502b9so279259ook.15
        for <linux-kernel@vger.kernel.org>; Wed, 09 Nov 2022 21:19:57 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=u96povSyy2sjnCyKRqs1RgXf1LgZIt4bA4dxaS0z0zE=;
        b=HHOMJ5DigFccFbnEH5xfDwX1Kj/dLO7IfiXWlcGJ5XwmnAFBWLPdKN6MEptTW4XuZO
         HHcI8grA03sIY+svDXiSfNHEuPDxNrn3TDVYYcfQ/NGL7fRJXiiyNv1PtIgIcRoeUWq3
         I0n/pJen1MfGcjmPnqMPc9CmziV8zVX5Z8vN1JiCYAsNwyGHimZA4B+Z9UWHb33z4cxp
         /6CE02ag6Ox46vtVt+0M++50ax4jpk27rEt0kTvCugHKtZ+crPvByztXRYDznfHlRdwG
         x8WY+TM3Uu1fu74fkzmFctfDcSiwWA6cwtuBipsxaNkGQmZWfCYC4cEHjparYiwYrHdp
         wYeA==
X-Gm-Message-State: ACrzQf1owC/lgiezAMF4b2VNeapin6681guRCSkANJ8VTxsYqVYbI8Zh
        b3pf9usXsNoxmE/cP2fjufoMesF7seO5vcflEMDLoOIJX09PalVXNH4UoffN4sIwn1sQl1AaGBI
        gW+IhQ6nAy8J/+4iKtRPH2DOThIvb5cJLMLsSpw0R
X-Received: by 2002:a9d:604f:0:b0:66c:64d6:1bb4 with SMTP id v15-20020a9d604f000000b0066c64d61bb4mr1101196otj.201.1668057597228;
        Wed, 09 Nov 2022 21:19:57 -0800 (PST)
X-Google-Smtp-Source: AMsMyM4tuNP7BSB9zdQWeAKCzstnEdGCPMlhRznQ9ZOEaMVRUjE1XOzntcNKT6xzKnDAKkwAAV+02rcn5e/H1U1+DX0=
X-Received: by 2002:a9d:604f:0:b0:66c:64d6:1bb4 with SMTP id
 v15-20020a9d604f000000b0066c64d61bb4mr1101189otj.201.1668057597016; Wed, 09
 Nov 2022 21:19:57 -0800 (PST)
MIME-Version: 1.0
References: <20221101111655.1947-1-angus.chen@jaguarmicro.com>
 <CACGkMEs6ZTrf0NMXGuM=VYZC+zAujigiTG2CgE8gAdvxHc2Q7A@mail.gmail.com>
 <TY2PR06MB342458CA2B7B5B8FDCD3366185019@TY2PR06MB3424.apcprd06.prod.outlook.com>
 <20221110000433-mutt-send-email-mst@kernel.org>
In-Reply-To: <20221110000433-mutt-send-email-mst@kernel.org>
From:   Jason Wang <jasowang@redhat.com>
Date:   Thu, 10 Nov 2022 13:19:45 +0800
Message-ID: <CACGkMEsc79Q+Sqbsxyqb2xhNHcQrphgdTh=QLS6zre3wfFwwNw@mail.gmail.com>
Subject: Re: [PATCH] virtio_pci: modify ENOENT to EINVAL
To:     "Michael S. Tsirkin" <mst@redhat.com>
Cc:     Angus Chen <angus.chen@jaguarmicro.com>,
        "virtualization@lists.linux-foundation.org" 
        <virtualization@lists.linux-foundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "lingshan.zhu@intel.com" <lingshan.zhu@intel.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 10, 2022 at 1:04 PM Michael S. Tsirkin <mst@redhat.com> wrote:
>
> On Thu, Nov 10, 2022 at 03:30:59AM +0000, Angus Chen wrote:
> > Hi Jason.
> >
> > > -----Original Message-----
> > > From: Jason Wang <jasowang@redhat.com>
> > > Sent: Wednesday, November 2, 2022 1:34 PM
> > > To: Angus Chen <angus.chen@jaguarmicro.com>
> > > Cc: mst@redhat.com; virtualization@lists.linux-foundation.org;
> > > linux-kernel@vger.kernel.org; lingshan.zhu@intel.com
> > > Subject: Re: [PATCH] virtio_pci: modify ENOENT to EINVAL
> > >
> > > On Tue, Nov 1, 2022 at 7:17 PM Angus Chen <angus.chen@jaguarmicro.com>
> > > wrote:
> > > >
> > > > Virtio_crypto use max_data_queues+1 to setup vqs,
> > > > we use vp_modern_get_num_queues to protect the vq range in setup_vq.
> > > > We could enter index >= vp_modern_get_num_queues(mdev) in setup_vq
> > > > if common->num_queues is not set well,and it return -ENOENT.
> > > > It is better to use -EINVAL instead.
> > >
> > > I'm not sure I get this. It would be better to describe:
> > >
> > > 1) what kind of issues can we see if we return -ENOENT
> > > 2) why -EINVAL can help in this case
> > >
> > > Thanks
> > Thank you for your reply.
> > We use a robot to test our dpu to get the return value of probe.
> >  We often get ENOENT form ' setup_vq ' function because of device error.
> > Most of time, my device can't handle queue_enable well.
> > This time,we get 'ENOENT' because the device set max_data_queues bigger than num_queues.
> >
> > I think EINVAL is used when the value of some parameter is wrong.
>
> I think I agree. Jason?

I'm fine with this then.

Thanks

>
> > Btw,it not a big deal,I can modify the robot to workaround.
> >
> > >
> > > >
> > > > Signed-off-by: Angus Chen <angus.chen@jaguarmicro.com>
> > > > ---
> > > >  drivers/virtio/virtio_pci_modern.c | 2 +-
> > > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > > >
> > > > diff --git a/drivers/virtio/virtio_pci_modern.c
> > > b/drivers/virtio/virtio_pci_modern.c
> > > > index c3b9f2761849..edf2e18014cd 100644
> > > > --- a/drivers/virtio/virtio_pci_modern.c
> > > > +++ b/drivers/virtio/virtio_pci_modern.c
> > > > @@ -303,7 +303,7 @@ static struct virtqueue *setup_vq(struct
> > > virtio_pci_device *vp_dev,
> > > >         int err;
> > > >
> > > >         if (index >= vp_modern_get_num_queues(mdev))
> > > > -               return ERR_PTR(-ENOENT);
> > > > +               return ERR_PTR(-EINVAL);
> > > >
> > > >         /* Check if queue is either not available or already active. */
> > > >         num = vp_modern_get_queue_size(mdev, index);
> > > > --
> > > > 2.25.1
> > > >
> >
>

