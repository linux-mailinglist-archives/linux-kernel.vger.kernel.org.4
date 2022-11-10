Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC232623A9A
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Nov 2022 04:48:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232469AbiKJDsn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Nov 2022 22:48:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229784AbiKJDsm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Nov 2022 22:48:42 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A7CEC77E
        for <linux-kernel@vger.kernel.org>; Wed,  9 Nov 2022 19:47:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1668052067;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=5wnyLGqWnXrVwpHf/LqVqqWLtFDmz9WDDkL1ZC0aJ6U=;
        b=NIucLtV0f+Eku8HcNrDAgP5oldKG4z9pmh4JJ+B6APB86pM2Np2calwpudFPN/pTjgE1Ce
        1rnjcUUMAHqfafgLFy3Z20elFai4HG12jDJlBVCnU+3nxvUjHuaBPg/cxR+UawARXV5kgw
        H0b/Y3Fos+S32rS0ZLZsd2f6ohuU0W4=
Received: from mail-ot1-f69.google.com (mail-ot1-f69.google.com
 [209.85.210.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-103-zZwYNfyTN_-cNdpMBMldgw-1; Wed, 09 Nov 2022 22:47:45 -0500
X-MC-Unique: zZwYNfyTN_-cNdpMBMldgw-1
Received: by mail-ot1-f69.google.com with SMTP id cj4-20020a056830640400b0065c0c211f4dso463853otb.8
        for <linux-kernel@vger.kernel.org>; Wed, 09 Nov 2022 19:47:45 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5wnyLGqWnXrVwpHf/LqVqqWLtFDmz9WDDkL1ZC0aJ6U=;
        b=eCA8uy+Ejfe+rsyGXSfcUE0ac04H+G2+ZCl+8w8dMk/zvig34RaKHaHadQX/OjgUL3
         fMUJu0dOr0I37/PthVMqCcwTzaxKAwLMOaGx11walg42NaM4lCmvEByf9Fe0Zu/7nVF4
         UILDDSOYfZLdWZvffUDABr5yaHSn/NPiH/CplAMBQvCC2nE2yS9KT+ZSAbw8h8ZWwXMo
         EN/drlMDTN8qVJM/en/C60uFbZ1R+aCWRTqFbgfWLH+7TUZOTc+wbVi8ilDYZ+Lz4j0V
         s66gH2ZdXA/Y1DWNG3k3qem+gTWyZfvU7QbNSlgk4akMP8TggVoAyRor8zAH6urcEoV/
         vTEA==
X-Gm-Message-State: ACrzQf0yY6rTIIO+8P3QZHZyKxG2vUJiTav48oHla61S88Pd6Ccgxor0
        iM8v+BS0jUp7ug3ly3P2SwAjmPP4yAjohCTdRm+Zpga6R/TrnUaB0ZhGM8QuW9CFudl3GyQcIsi
        GtdA9IiIIrdyv1stmloQlu+RRzhJajdlVbXrSq2KN
X-Received: by 2002:a05:6871:54e:b0:13b:29b7:e2e8 with SMTP id t14-20020a056871054e00b0013b29b7e2e8mr45757628oal.35.1668052065151;
        Wed, 09 Nov 2022 19:47:45 -0800 (PST)
X-Google-Smtp-Source: AMsMyM4OG8TXscyRn+mvNZ5Q9caypOByTT7AsfeH9vDE9c7xEhzAoS8lLQpAWuyuFSiUnVRVjbupPFvOzyuw4NNzA0Q=
X-Received: by 2002:a05:6871:54e:b0:13b:29b7:e2e8 with SMTP id
 t14-20020a056871054e00b0013b29b7e2e8mr45757624oal.35.1668052064920; Wed, 09
 Nov 2022 19:47:44 -0800 (PST)
MIME-Version: 1.0
References: <20221101111655.1947-1-angus.chen@jaguarmicro.com>
 <CACGkMEs6ZTrf0NMXGuM=VYZC+zAujigiTG2CgE8gAdvxHc2Q7A@mail.gmail.com> <TY2PR06MB342458CA2B7B5B8FDCD3366185019@TY2PR06MB3424.apcprd06.prod.outlook.com>
In-Reply-To: <TY2PR06MB342458CA2B7B5B8FDCD3366185019@TY2PR06MB3424.apcprd06.prod.outlook.com>
From:   Jason Wang <jasowang@redhat.com>
Date:   Thu, 10 Nov 2022 11:47:33 +0800
Message-ID: <CACGkMEuQTob8DYwYAa20-3SdHWoZJ+EnxJCKm+xR4_gUHRcd8g@mail.gmail.com>
Subject: Re: [PATCH] virtio_pci: modify ENOENT to EINVAL
To:     Angus Chen <angus.chen@jaguarmicro.com>
Cc:     "mst@redhat.com" <mst@redhat.com>,
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

On Thu, Nov 10, 2022 at 11:31 AM Angus Chen <angus.chen@jaguarmicro.com> wrote:
>
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

Ok, I see, ENOENT is not very popular on linux but I'm not sure it's
worth bothering.

>
> I think EINVAL is used when the value of some parameter is wrong.
> Btw,it not a big deal,I can modify the robot to workaround.

Btw, the error code is not a part of the ABI, so depending on that is
kind of fragile.

Thanks

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

