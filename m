Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6294E623B1C
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Nov 2022 06:05:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229803AbiKJFFw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Nov 2022 00:05:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229514AbiKJFFt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Nov 2022 00:05:49 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC5F926579
        for <linux-kernel@vger.kernel.org>; Wed,  9 Nov 2022 21:04:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1668056695;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=gHT7iw7almXkodunne0Nx5UpThP9sgHSR7Y/qy0zMa4=;
        b=Ik/ehJvX3sFXFXRBnmD2kqZrFtrgowsr31EPTrPSg1R5ZqMmbiiN0ZCcJ5DjnGGOphqLyC
        +G3mvZKZAi3BAGvowcedXuOHV6wvRhBOqaDtELiQ4Nzq1ySAXN7NK05+apCVeOP61FUhT/
        EFIvRm/83msKQCyKs0GB3KUjl9KKpPg=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-462---znqMHwM1KnGVpsDDdfqg-1; Thu, 10 Nov 2022 00:04:54 -0500
X-MC-Unique: --znqMHwM1KnGVpsDDdfqg-1
Received: by mail-wr1-f70.google.com with SMTP id k1-20020adfb341000000b00238745c9b1aso79649wrd.5
        for <linux-kernel@vger.kernel.org>; Wed, 09 Nov 2022 21:04:53 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gHT7iw7almXkodunne0Nx5UpThP9sgHSR7Y/qy0zMa4=;
        b=dkPBcievZ440gRWPFcxlkF4WvD2XyAmIH0tLN1o8+8nIXedzDOck63qtJHL0nj+4bm
         /hX2BREnvK4UkI0Qz4GMKb6cGPoiwffix5rnRrrK+nd58VvGL1NDl5qia6sS2FuLCREC
         EvDb2ZRzKuYl+aDAUqmjJj9IPfYcWzisqv9gKvwsp0CEb9jHx34p3RkibpHHopd1lbWV
         FNWnxlJ8yTbZbmOJO21Gu+9KGs9+GsWUI/36tqKcBBNs3CmkztqWchf6QycYu6Gl0u8g
         T5lHUEvVT4+wVBHIfljxYO2Rjoe9S1lw5cANdNLsRL1Dicm2vL5rF8TnLvv/7qc/b375
         bftw==
X-Gm-Message-State: ACrzQf0U/noteHohMQVvvGncCdwi4wcUXVALIbFwpTBE93JjehAjqgTL
        k5I2BvjcUc4CgoLqk8qGVggz0nLB0xdwdL7Nyx6yWVEeKk8UOh8Xwpr9d3RQxmeQx3L77YjEHuf
        h/gYj+ajrgnT36dvAjfmXCzkv
X-Received: by 2002:a5d:598d:0:b0:236:8ef4:7324 with SMTP id n13-20020a5d598d000000b002368ef47324mr40926452wri.84.1668056692956;
        Wed, 09 Nov 2022 21:04:52 -0800 (PST)
X-Google-Smtp-Source: AMsMyM7Cy6n7vZ9A59gKH1yknUItYdABn1qHhTZB+YgamzQ1xGDDdIuS1j50cAfvCiDXMi+aekLTfQ==
X-Received: by 2002:a5d:598d:0:b0:236:8ef4:7324 with SMTP id n13-20020a5d598d000000b002368ef47324mr40926448wri.84.1668056692692;
        Wed, 09 Nov 2022 21:04:52 -0800 (PST)
Received: from redhat.com ([2.52.23.68])
        by smtp.gmail.com with ESMTPSA id g12-20020adffc8c000000b0022cd96b3ba6sm17090371wrr.90.2022.11.09.21.04.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Nov 2022 21:04:51 -0800 (PST)
Date:   Thu, 10 Nov 2022 00:04:48 -0500
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Angus Chen <angus.chen@jaguarmicro.com>
Cc:     Jason Wang <jasowang@redhat.com>,
        "virtualization@lists.linux-foundation.org" 
        <virtualization@lists.linux-foundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "lingshan.zhu@intel.com" <lingshan.zhu@intel.com>
Subject: Re: [PATCH] virtio_pci: modify ENOENT to EINVAL
Message-ID: <20221110000433-mutt-send-email-mst@kernel.org>
References: <20221101111655.1947-1-angus.chen@jaguarmicro.com>
 <CACGkMEs6ZTrf0NMXGuM=VYZC+zAujigiTG2CgE8gAdvxHc2Q7A@mail.gmail.com>
 <TY2PR06MB342458CA2B7B5B8FDCD3366185019@TY2PR06MB3424.apcprd06.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <TY2PR06MB342458CA2B7B5B8FDCD3366185019@TY2PR06MB3424.apcprd06.prod.outlook.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 10, 2022 at 03:30:59AM +0000, Angus Chen wrote:
> Hi Jason.
> 
> > -----Original Message-----
> > From: Jason Wang <jasowang@redhat.com>
> > Sent: Wednesday, November 2, 2022 1:34 PM
> > To: Angus Chen <angus.chen@jaguarmicro.com>
> > Cc: mst@redhat.com; virtualization@lists.linux-foundation.org;
> > linux-kernel@vger.kernel.org; lingshan.zhu@intel.com
> > Subject: Re: [PATCH] virtio_pci: modify ENOENT to EINVAL
> > 
> > On Tue, Nov 1, 2022 at 7:17 PM Angus Chen <angus.chen@jaguarmicro.com>
> > wrote:
> > >
> > > Virtio_crypto use max_data_queues+1 to setup vqs,
> > > we use vp_modern_get_num_queues to protect the vq range in setup_vq.
> > > We could enter index >= vp_modern_get_num_queues(mdev) in setup_vq
> > > if common->num_queues is not set well,and it return -ENOENT.
> > > It is better to use -EINVAL instead.
> > 
> > I'm not sure I get this. It would be better to describe:
> > 
> > 1) what kind of issues can we see if we return -ENOENT
> > 2) why -EINVAL can help in this case
> > 
> > Thanks
> Thank you for your reply.
> We use a robot to test our dpu to get the return value of probe.
>  We often get ENOENT form ' setup_vq ' function because of device error.
> Most of time, my device can't handle queue_enable well.
> This time,we get 'ENOENT' because the device set max_data_queues bigger than num_queues.
> 
> I think EINVAL is used when the value of some parameter is wrong.

I think I agree. Jason?

> Btw,it not a big deal,I can modify the robot to workaround.
> 
> > 
> > >
> > > Signed-off-by: Angus Chen <angus.chen@jaguarmicro.com>
> > > ---
> > >  drivers/virtio/virtio_pci_modern.c | 2 +-
> > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > >
> > > diff --git a/drivers/virtio/virtio_pci_modern.c
> > b/drivers/virtio/virtio_pci_modern.c
> > > index c3b9f2761849..edf2e18014cd 100644
> > > --- a/drivers/virtio/virtio_pci_modern.c
> > > +++ b/drivers/virtio/virtio_pci_modern.c
> > > @@ -303,7 +303,7 @@ static struct virtqueue *setup_vq(struct
> > virtio_pci_device *vp_dev,
> > >         int err;
> > >
> > >         if (index >= vp_modern_get_num_queues(mdev))
> > > -               return ERR_PTR(-ENOENT);
> > > +               return ERR_PTR(-EINVAL);
> > >
> > >         /* Check if queue is either not available or already active. */
> > >         num = vp_modern_get_queue_size(mdev, index);
> > > --
> > > 2.25.1
> > >
> 

