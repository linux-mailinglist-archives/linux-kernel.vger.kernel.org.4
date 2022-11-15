Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C552629826
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Nov 2022 13:07:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229709AbiKOMHK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Nov 2022 07:07:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229769AbiKOMG4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Nov 2022 07:06:56 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37E8BDF0F
        for <linux-kernel@vger.kernel.org>; Tue, 15 Nov 2022 04:05:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1668513930;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=BI6S1D/Aw6YmKbDYrXeofwR77FnCGKUq367vbCtHncY=;
        b=UDOqgq0iMOHpg+ArCIJhd7nKTku9Bv3fAT+uVBqO8/DP3RILZ52IvZYI+iU5fv1CkT2iVL
        2mL4PkwaD3JYUByJsPWcs105Kix2Iqwry/t82zh74crIRbK86xPPLGvwC6JC+zVxlOQgYV
        z21Qt5z01bZzKomfxGFsHHwGC25ofEw=
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-626-rVnG8IBUO8G8SuptAjauTw-1; Tue, 15 Nov 2022 07:05:26 -0500
X-MC-Unique: rVnG8IBUO8G8SuptAjauTw-1
Received: by mail-pj1-f70.google.com with SMTP id b1-20020a17090a10c100b0020da29fa5e5so7428601pje.2
        for <linux-kernel@vger.kernel.org>; Tue, 15 Nov 2022 04:05:26 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BI6S1D/Aw6YmKbDYrXeofwR77FnCGKUq367vbCtHncY=;
        b=0eUOmCTwbNO6IpeGKlYb3PU6sS5q2tcFhyvbmCyXH0mZBEz68xGHR+FrvNZFQGNRlN
         ZmT09oG8MOT/xbv2BPHrnEMSlqOhvt0+BDGlNdaQzI5xi5HPa4+NDiFKsqGIeyjpoEFl
         40tt1fsPHJDkSeM4EFmokB8Hv8YAJvi0wERpxZZT67tMwN7OgdCnYQAk3MAZEesq7us0
         CEqYOEsA8h8EemTRMuJToCIRgg6WhT6EW4iTN3YbiEFO719DGqSjqP/qSAv5dXtD02G1
         PJTG9Rjxm4E1XUAytkHcf4ZVHkR7vnS6VRiRiCT6nz+USwMslQsBoZYinTe5lZ/foSTn
         dZHg==
X-Gm-Message-State: ANoB5pmxb+DJoG61Y7FO5l13tP7iSNWmb8aJcVnM4O8AJeyBW6Bhuop+
        sm/mCJ3dq6LUxigv/8S8N1uZN8AnRxlsbODsoQpS1j69Dz/YX/VmtnlWkbp+sdzeV7OjjuJ/Jky
        qEI7YFbMW9rUDI3VreB1bt9bpIUrIbUtPRhC9uALK
X-Received: by 2002:aa7:9389:0:b0:572:7833:57f0 with SMTP id t9-20020aa79389000000b00572783357f0mr2103004pfe.86.1668513925829;
        Tue, 15 Nov 2022 04:05:25 -0800 (PST)
X-Google-Smtp-Source: AA0mqf7dRERembHuf2S3cUPeNOIQU19imq4Tat99d+XaGBGjf3AXMe4z9dktfG3ZbtKf8xsy4NnK/be7oI+mqXPB8rQ=
X-Received: by 2002:aa7:9389:0:b0:572:7833:57f0 with SMTP id
 t9-20020aa79389000000b00572783357f0mr2102982pfe.86.1668513925546; Tue, 15 Nov
 2022 04:05:25 -0800 (PST)
MIME-Version: 1.0
References: <20221110141335.62171-1-sgarzare@redhat.com> <CAJaqyWdvdy2QxuuyPRtfBKtuObrMg_kX_R9hdui+Oh72XtJ7Qw@mail.gmail.com>
 <20221111163007.35kvkodvk6zpimmu@sgarzare-redhat> <CAJaqyWfYx+63-hOp0K8fznkyjkScKu6-r8CUPd3eD96oKCHu9A@mail.gmail.com>
 <20221114151111.6ay3ra4shzj3k2lg@sgarzare-redhat>
In-Reply-To: <20221114151111.6ay3ra4shzj3k2lg@sgarzare-redhat>
From:   Eugenio Perez Martin <eperezma@redhat.com>
Date:   Tue, 15 Nov 2022 13:04:49 +0100
Message-ID: <CAJaqyWem5n1jaXd65LMR0nGnd1Jort19E9beZef8a+gnFJ3JOA@mail.gmail.com>
Subject: Re: [PATCH] vdpa_sim: fix vringh initialization in vdpasim_queue_ready()
To:     Stefano Garzarella <sgarzare@redhat.com>
Cc:     virtualization@lists.linux-foundation.org,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>, linux-kernel@vger.kernel.org
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

On Mon, Nov 14, 2022 at 4:11 PM Stefano Garzarella <sgarzare@redhat.com> wrote:
>
> On Mon, Nov 14, 2022 at 10:13:51AM +0100, Eugenio Perez Martin wrote:
> >On Fri, Nov 11, 2022 at 5:30 PM Stefano Garzarella <sgarzare@redhat.com> wrote:
> >>
> >> On Fri, Nov 11, 2022 at 04:40:33PM +0100, Eugenio Perez Martin wrote:
> >> >On Thu, Nov 10, 2022 at 3:13 PM Stefano Garzarella <sgarzare@redhat.com> wrote:
> >> >>
> >> >> When we initialize vringh, we should pass the features and the
> >> >> number of elements in the virtqueue negotiated with the driver,
> >> >> otherwise operations with vringh may fail.
> >> >>
> >> >> This was discovered in a case where the driver sets a number of
> >> >> elements in the virtqueue different from the value returned by
> >> >> .get_vq_num_max().
> >> >>
> >> >> In vdpasim_vq_reset() is safe to initialize the vringh with
> >> >> default values, since the virtqueue will not be used until
> >> >> vdpasim_queue_ready() is called again.
> >> >>
> >> >> Fixes: 2c53d0f64c06 ("vdpasim: vDPA device simulator")
> >> >> Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
> >> >> ---
> >> >>  drivers/vdpa/vdpa_sim/vdpa_sim.c | 3 +--
> >> >>  1 file changed, 1 insertion(+), 2 deletions(-)
> >> >>
> >> >> diff --git a/drivers/vdpa/vdpa_sim/vdpa_sim.c b/drivers/vdpa/vdpa_sim/vdpa_sim.c
> >> >> index b071f0d842fb..b20689f8fe89 100644
> >> >> --- a/drivers/vdpa/vdpa_sim/vdpa_sim.c
> >> >> +++ b/drivers/vdpa/vdpa_sim/vdpa_sim.c
> >> >> @@ -67,8 +67,7 @@ static void vdpasim_queue_ready(struct vdpasim *vdpasim, unsigned int idx)
> >> >>  {
> >> >>         struct vdpasim_virtqueue *vq = &vdpasim->vqs[idx];
> >> >>
> >> >> -       vringh_init_iotlb(&vq->vring, vdpasim->dev_attr.supported_features,
> >> >> -                         VDPASIM_QUEUE_MAX, false,
> >> >> +       vringh_init_iotlb(&vq->vring, vdpasim->features, vq->num, false,
> >> >>                           (struct vring_desc *)(uintptr_t)vq->desc_addr,
> >> >>                           (struct vring_avail *)
> >> >>                           (uintptr_t)vq->driver_addr,
> >> >> --
> >> >> 2.38.1
> >> >>
> >> >
> >> >I think this is definitely an improvement, but I'd say we should go a
> >> >step further and rename VDPASIM_QUEUE_MAX to VDPASIM_QUEUE_DEFAULT. As
> >> >you point out in the patch message it is not a max anymore.
> >>
> >> I'm not sure about renaming since it is the value returned by
> >> vdpasim_get_vq_num_max, so IMHO the _MAX suffix is fine.
> >
> >Oh that's a very good point. But then I guess a conformant driver
> >should never set more descriptors than that.
>
> Yep, right!
>
> >
> >Would it be convenient to make the default queue size of 32768 and let
>
> Yep, I think it makes sense.
>
> >the guest specify less descriptors than that? Default configuration
> >will consume more memory then.
>
> Do you mean for the driver point of view?
>
> Because IIUC in vringh we don't allocate anything related to the queue
> size.
>

Right, I mean the driver that does not override the vring size will
start allocating bigger vrings by default. But I don't think that's a
problem actually, given that it is the simulator, just pointing it
out.

> >
> >> But I admit that initially I didn't understand whether it's the maximum
> >> number of queues or elements, so maybe VDPASIM_VQ_NUM_MAX is better.
> >>
> >> >
> >> >Another thing to note is that we don't have a way to report that
> >> >userspace indicated a bad value for queue length. With the current
> >> >code vringh will not initialize at all if I'm not wrong, so we should
> >> >prevent userspace to put a bad num.
> >>
> >> Right!
> >>
> >> >
> >> >Ideally, we should repeat the tests of vring_init_kern at
> >> >vdpasim_set_vq_num. We could either call it with NULL vring addresses
> >> >to check for -EINVAL, or simply repeat the conditional (!num || num >
> >> >0xffff || (num & (num - 1))). I'd say the first one is better to not
> >> >go out of sync.
> >>
> >> Or we could do the check in vdpasim_set_vq_ready() and set it not ready
> >> if the vq_num is wrong.
> >>
> >
> >Maybe it is the right place to do it, but the device is initiated at
> >that point so the driver needs to perform a full reset.
> >
>
> Yes, but the driver is misbehaving, so it might be okay to request a
> full reset.
>

Setting DEVICE_NEEDS_RESET in that case, right?

Thanks!

> >As a reference, qemu will retain the last valid size set to a vq, or
> >the default. This is because it ignores the bad values systematically.
> >Not sure what is more conformant actually :).
> >
>
> Me too :-)
>
> Thanks,
> Stefano
>

