Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 69EC0628391
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Nov 2022 16:12:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237117AbiKNPMY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Nov 2022 10:12:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236428AbiKNPMV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Nov 2022 10:12:21 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F32871085
        for <linux-kernel@vger.kernel.org>; Mon, 14 Nov 2022 07:11:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1668438687;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=d+pdot0+mJYBeC5ZDxgJijt7mCtgiiV6z+4YR5gwxYg=;
        b=DYpnePp4tiLknTIiKFyiY/vv6XRS3J68Ed68qMdAY9y2quyHCmYLeeAD1bfH+gA59XP/Da
        HX5o8gU+vPVrHOwcVI67bE+46MpkS+v/nIJWzHs8Bs8AfXHrBDwauqn/j/2kZn6zGQYbvv
        mr4fg+dtbBUeFB6+IiW0ibrzf+PbLMY=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-656-xdNvXiBGNK2i--qHDk7WOw-1; Mon, 14 Nov 2022 10:11:25 -0500
X-MC-Unique: xdNvXiBGNK2i--qHDk7WOw-1
Received: by mail-qt1-f197.google.com with SMTP id v12-20020ac8578c000000b003a50eb13e29so8189632qta.3
        for <linux-kernel@vger.kernel.org>; Mon, 14 Nov 2022 07:11:25 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=d+pdot0+mJYBeC5ZDxgJijt7mCtgiiV6z+4YR5gwxYg=;
        b=Y2YiohfBEHrM+H1eNeXlN1TjgR67Y0lM9l25oJZcUBn9XXrZ8X/pv0aKukV5hh4VyU
         rFZwlEVs6VjBJU2CN3o+MDF0l07KgasfcjjA2R+WB7S4XbW+dtNzIsoq3z2pZiuXuKGn
         rWwdcoU5xSFxOp/mLjoZZ5pKI72OL54tghRlCxnK1BrSHRT5RFgdJ2C+BcVY5E1bf6vC
         ciC7Xd8IMVlb70Hx15hAuzKJZ1Tf2P381MpOyh5N9EnOfSuSX8mPcYK+RvSFvYB3Kgy5
         COuscRN5B4jY1cgtL2LHXpGA+nYVOtO1vQaaol0n/XxN3to2hkPfddENcIcrpYD4uGbk
         4KIA==
X-Gm-Message-State: ANoB5pk+E0nOBJSEz6ejekfp6aOBBB8Ed0/KSkYshp8pBxh6KRdSP/Aw
        FrvWGjnlVpE8AuoTkTPINuulk3BZYVV52vBcdfCyFMLicjcyShNdZPTIDSxvJ0Op5viUAuhxKe/
        hHrd7ur+FKVnhaz47ZgyoQ0rU
X-Received: by 2002:a05:6214:5bc9:b0:49f:8cd3:eaee with SMTP id lr9-20020a0562145bc900b0049f8cd3eaeemr12840843qvb.56.1668438685317;
        Mon, 14 Nov 2022 07:11:25 -0800 (PST)
X-Google-Smtp-Source: AA0mqf7no97ZrLRX04h0RS4jVHzW30d1xawZi1Yv4WoqReZkcMrTy6YSIC876bMhqPMVK58DZtNi6A==
X-Received: by 2002:a05:6214:5bc9:b0:49f:8cd3:eaee with SMTP id lr9-20020a0562145bc900b0049f8cd3eaeemr12840825qvb.56.1668438685082;
        Mon, 14 Nov 2022 07:11:25 -0800 (PST)
Received: from sgarzare-redhat (host-82-53-134-234.retail.telecomitalia.it. [82.53.134.234])
        by smtp.gmail.com with ESMTPSA id s1-20020a05620a0bc100b006faaf6dc55asm6695115qki.22.2022.11.14.07.11.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Nov 2022 07:11:24 -0800 (PST)
Date:   Mon, 14 Nov 2022 16:11:11 +0100
From:   Stefano Garzarella <sgarzare@redhat.com>
To:     Eugenio Perez Martin <eperezma@redhat.com>
Cc:     virtualization@lists.linux-foundation.org,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] vdpa_sim: fix vringh initialization in
 vdpasim_queue_ready()
Message-ID: <20221114151111.6ay3ra4shzj3k2lg@sgarzare-redhat>
References: <20221110141335.62171-1-sgarzare@redhat.com>
 <CAJaqyWdvdy2QxuuyPRtfBKtuObrMg_kX_R9hdui+Oh72XtJ7Qw@mail.gmail.com>
 <20221111163007.35kvkodvk6zpimmu@sgarzare-redhat>
 <CAJaqyWfYx+63-hOp0K8fznkyjkScKu6-r8CUPd3eD96oKCHu9A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <CAJaqyWfYx+63-hOp0K8fznkyjkScKu6-r8CUPd3eD96oKCHu9A@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 14, 2022 at 10:13:51AM +0100, Eugenio Perez Martin wrote:
>On Fri, Nov 11, 2022 at 5:30 PM Stefano Garzarella <sgarzare@redhat.com> wrote:
>>
>> On Fri, Nov 11, 2022 at 04:40:33PM +0100, Eugenio Perez Martin wrote:
>> >On Thu, Nov 10, 2022 at 3:13 PM Stefano Garzarella <sgarzare@redhat.com> wrote:
>> >>
>> >> When we initialize vringh, we should pass the features and the
>> >> number of elements in the virtqueue negotiated with the driver,
>> >> otherwise operations with vringh may fail.
>> >>
>> >> This was discovered in a case where the driver sets a number of
>> >> elements in the virtqueue different from the value returned by
>> >> .get_vq_num_max().
>> >>
>> >> In vdpasim_vq_reset() is safe to initialize the vringh with
>> >> default values, since the virtqueue will not be used until
>> >> vdpasim_queue_ready() is called again.
>> >>
>> >> Fixes: 2c53d0f64c06 ("vdpasim: vDPA device simulator")
>> >> Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
>> >> ---
>> >>  drivers/vdpa/vdpa_sim/vdpa_sim.c | 3 +--
>> >>  1 file changed, 1 insertion(+), 2 deletions(-)
>> >>
>> >> diff --git a/drivers/vdpa/vdpa_sim/vdpa_sim.c b/drivers/vdpa/vdpa_sim/vdpa_sim.c
>> >> index b071f0d842fb..b20689f8fe89 100644
>> >> --- a/drivers/vdpa/vdpa_sim/vdpa_sim.c
>> >> +++ b/drivers/vdpa/vdpa_sim/vdpa_sim.c
>> >> @@ -67,8 +67,7 @@ static void vdpasim_queue_ready(struct vdpasim *vdpasim, unsigned int idx)
>> >>  {
>> >>         struct vdpasim_virtqueue *vq = &vdpasim->vqs[idx];
>> >>
>> >> -       vringh_init_iotlb(&vq->vring, vdpasim->dev_attr.supported_features,
>> >> -                         VDPASIM_QUEUE_MAX, false,
>> >> +       vringh_init_iotlb(&vq->vring, vdpasim->features, vq->num, false,
>> >>                           (struct vring_desc *)(uintptr_t)vq->desc_addr,
>> >>                           (struct vring_avail *)
>> >>                           (uintptr_t)vq->driver_addr,
>> >> --
>> >> 2.38.1
>> >>
>> >
>> >I think this is definitely an improvement, but I'd say we should go a
>> >step further and rename VDPASIM_QUEUE_MAX to VDPASIM_QUEUE_DEFAULT. As
>> >you point out in the patch message it is not a max anymore.
>>
>> I'm not sure about renaming since it is the value returned by
>> vdpasim_get_vq_num_max, so IMHO the _MAX suffix is fine.
>
>Oh that's a very good point. But then I guess a conformant driver
>should never set more descriptors than that.

Yep, right!

>
>Would it be convenient to make the default queue size of 32768 and let

Yep, I think it makes sense.

>the guest specify less descriptors than that? Default configuration
>will consume more memory then.

Do you mean for the driver point of view?

Because IIUC in vringh we don't allocate anything related to the queue 
size.

>
>> But I admit that initially I didn't understand whether it's the maximum
>> number of queues or elements, so maybe VDPASIM_VQ_NUM_MAX is better.
>>
>> >
>> >Another thing to note is that we don't have a way to report that
>> >userspace indicated a bad value for queue length. With the current
>> >code vringh will not initialize at all if I'm not wrong, so we should
>> >prevent userspace to put a bad num.
>>
>> Right!
>>
>> >
>> >Ideally, we should repeat the tests of vring_init_kern at
>> >vdpasim_set_vq_num. We could either call it with NULL vring addresses
>> >to check for -EINVAL, or simply repeat the conditional (!num || num >
>> >0xffff || (num & (num - 1))). I'd say the first one is better to not
>> >go out of sync.
>>
>> Or we could do the check in vdpasim_set_vq_ready() and set it not ready
>> if the vq_num is wrong.
>>
>
>Maybe it is the right place to do it, but the device is initiated at
>that point so the driver needs to perform a full reset.
>

Yes, but the driver is misbehaving, so it might be okay to request a 
full reset.

>As a reference, qemu will retain the last valid size set to a vq, or
>the default. This is because it ignores the bad values systematically.
>Not sure what is more conformant actually :).
>

Me too :-)

Thanks,
Stefano

