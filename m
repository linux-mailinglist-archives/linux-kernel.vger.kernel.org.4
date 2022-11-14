Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D05B6278CE
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Nov 2022 10:15:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236320AbiKNJPb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Nov 2022 04:15:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235832AbiKNJP3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Nov 2022 04:15:29 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84B9764EB
        for <linux-kernel@vger.kernel.org>; Mon, 14 Nov 2022 01:14:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1668417270;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=5hofss//ywoRNQpOC2hnRbrd17v1Z4Ke0Sn/QHTSNDA=;
        b=F33jSbHMhEN21tkWRItyGwjXo3BjvhxakrY3L6A54lg2CSYSpkTc/RMU9y/2QaxDwTMJsc
        kSeemLmsxUTVSo2A1n1YcwaSvTVMwV/tw8BkNRsrdsFyNH+j9QEWSMjBQxJXRsqeZWCHBO
        ch33ztSQK99w8xOx+Kczo3fdiD5dDi4=
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com
 [209.85.215.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-168-deKax_B9P_WTDSU-3Im1Lg-1; Mon, 14 Nov 2022 04:14:29 -0500
X-MC-Unique: deKax_B9P_WTDSU-3Im1Lg-1
Received: by mail-pg1-f200.google.com with SMTP id k16-20020a635a50000000b0042986056df6so5551772pgm.2
        for <linux-kernel@vger.kernel.org>; Mon, 14 Nov 2022 01:14:29 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5hofss//ywoRNQpOC2hnRbrd17v1Z4Ke0Sn/QHTSNDA=;
        b=xXapzN8Z7zCsjYHG+R5fB6hZrXCJKHL9FkL41aJOgkD6gHl9DA24KMINF9p+fQxcEz
         lfiVO8v6e6A4OID12/NGhXUHZuiz3B0vLY5Z2GoHWWfZKtf4WmxwRRDOHtCBEOMLPZWm
         g5WQk/3TMbGu0vcBb/DdFC4cMM6gKUJGfURDazlh1Fx1koVQc5w6qijZm0Goazh06XbP
         3Z/oxCXv7CnzfjdlIoAPG034sOD+e1tOGX4mAmtWRpU50Ctj5elQoY+hzYjyaH61EnBG
         0X5qDU5+uo7T2GbJFvfQutpX5Dv3gkUC1eZeMBM4k7Ra2UV9/WrXsB9nZJIvhF7nulDC
         koQQ==
X-Gm-Message-State: ANoB5plMsSkFAeR+wyiuIKLfvspE4kFITalsZzDixfVfCVuQNttWVg9b
        A3Z0WRw+Ttwr4G1UmOOcMootB867LPKvSu/fkxFev8mAnSvIBnpTgHTEtHaDlaycBRoJAnGDwmt
        o9vGcAgRnYFT1JQGxjpLU5jGoUS1veCvA8njAtxew
X-Received: by 2002:a17:902:d708:b0:186:5ce5:8022 with SMTP id w8-20020a170902d70800b001865ce58022mr12448092ply.62.1668417268341;
        Mon, 14 Nov 2022 01:14:28 -0800 (PST)
X-Google-Smtp-Source: AA0mqf4uO4nzhKMggeTT26a72aOVoPNbqhtrc2BIEVlMFyRN31zZBc0rw4X7Ojkw+dhSiJdJC0duVUo5tp3z0w2bohI=
X-Received: by 2002:a17:902:d708:b0:186:5ce5:8022 with SMTP id
 w8-20020a170902d70800b001865ce58022mr12448076ply.62.1668417268052; Mon, 14
 Nov 2022 01:14:28 -0800 (PST)
MIME-Version: 1.0
References: <20221110141335.62171-1-sgarzare@redhat.com> <CAJaqyWdvdy2QxuuyPRtfBKtuObrMg_kX_R9hdui+Oh72XtJ7Qw@mail.gmail.com>
 <20221111163007.35kvkodvk6zpimmu@sgarzare-redhat>
In-Reply-To: <20221111163007.35kvkodvk6zpimmu@sgarzare-redhat>
From:   Eugenio Perez Martin <eperezma@redhat.com>
Date:   Mon, 14 Nov 2022 10:13:51 +0100
Message-ID: <CAJaqyWfYx+63-hOp0K8fznkyjkScKu6-r8CUPd3eD96oKCHu9A@mail.gmail.com>
Subject: Re: [PATCH] vdpa_sim: fix vringh initialization in vdpasim_queue_ready()
To:     Stefano Garzarella <sgarzare@redhat.com>
Cc:     virtualization@lists.linux-foundation.org,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 11, 2022 at 5:30 PM Stefano Garzarella <sgarzare@redhat.com> wr=
ote:
>
> On Fri, Nov 11, 2022 at 04:40:33PM +0100, Eugenio Perez Martin wrote:
> >On Thu, Nov 10, 2022 at 3:13 PM Stefano Garzarella <sgarzare@redhat.com>=
 wrote:
> >>
> >> When we initialize vringh, we should pass the features and the
> >> number of elements in the virtqueue negotiated with the driver,
> >> otherwise operations with vringh may fail.
> >>
> >> This was discovered in a case where the driver sets a number of
> >> elements in the virtqueue different from the value returned by
> >> .get_vq_num_max().
> >>
> >> In vdpasim_vq_reset() is safe to initialize the vringh with
> >> default values, since the virtqueue will not be used until
> >> vdpasim_queue_ready() is called again.
> >>
> >> Fixes: 2c53d0f64c06 ("vdpasim: vDPA device simulator")
> >> Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
> >> ---
> >>  drivers/vdpa/vdpa_sim/vdpa_sim.c | 3 +--
> >>  1 file changed, 1 insertion(+), 2 deletions(-)
> >>
> >> diff --git a/drivers/vdpa/vdpa_sim/vdpa_sim.c b/drivers/vdpa/vdpa_sim/=
vdpa_sim.c
> >> index b071f0d842fb..b20689f8fe89 100644
> >> --- a/drivers/vdpa/vdpa_sim/vdpa_sim.c
> >> +++ b/drivers/vdpa/vdpa_sim/vdpa_sim.c
> >> @@ -67,8 +67,7 @@ static void vdpasim_queue_ready(struct vdpasim *vdpa=
sim, unsigned int idx)
> >>  {
> >>         struct vdpasim_virtqueue *vq =3D &vdpasim->vqs[idx];
> >>
> >> -       vringh_init_iotlb(&vq->vring, vdpasim->dev_attr.supported_feat=
ures,
> >> -                         VDPASIM_QUEUE_MAX, false,
> >> +       vringh_init_iotlb(&vq->vring, vdpasim->features, vq->num, fals=
e,
> >>                           (struct vring_desc *)(uintptr_t)vq->desc_add=
r,
> >>                           (struct vring_avail *)
> >>                           (uintptr_t)vq->driver_addr,
> >> --
> >> 2.38.1
> >>
> >
> >I think this is definitely an improvement, but I'd say we should go a
> >step further and rename VDPASIM_QUEUE_MAX to VDPASIM_QUEUE_DEFAULT. As
> >you point out in the patch message it is not a max anymore.
>
> I'm not sure about renaming since it is the value returned by
> vdpasim_get_vq_num_max, so IMHO the _MAX suffix is fine.

Oh that's a very good point. But then I guess a conformant driver
should never set more descriptors than that.

Would it be convenient to make the default queue size of 32768 and let
the guest specify less descriptors than that? Default configuration
will consume more memory then.

> But I admit that initially I didn't understand whether it's the maximum
> number of queues or elements, so maybe VDPASIM_VQ_NUM_MAX is better.
>
> >
> >Another thing to note is that we don't have a way to report that
> >userspace indicated a bad value for queue length. With the current
> >code vringh will not initialize at all if I'm not wrong, so we should
> >prevent userspace to put a bad num.
>
> Right!
>
> >
> >Ideally, we should repeat the tests of vring_init_kern at
> >vdpasim_set_vq_num. We could either call it with NULL vring addresses
> >to check for -EINVAL, or simply repeat the conditional (!num || num >
> >0xffff || (num & (num - 1))). I'd say the first one is better to not
> >go out of sync.
>
> Or we could do the check in vdpasim_set_vq_ready() and set it not ready
> if the vq_num is wrong.
>

Maybe it is the right place to do it, but the device is initiated at
that point so the driver needs to perform a full reset.

As a reference, qemu will retain the last valid size set to a vq, or
the default. This is because it ignores the bad values systematically.
Not sure what is more conformant actually :).


> >
> >All of that can be done on top anyway, so for this patch:
> >
> >Acked-by: Eugenio P=C3=A9rez <eperezma@redhat.com>
> >
>
> Thanks for the review,
> Stefano
>

