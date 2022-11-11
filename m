Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D73BD625F81
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Nov 2022 17:31:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234028AbiKKQbO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Nov 2022 11:31:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232901AbiKKQbK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Nov 2022 11:31:10 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00DB3DED0
        for <linux-kernel@vger.kernel.org>; Fri, 11 Nov 2022 08:30:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1668184216;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=QiAHvW1lwp0CJd5SRYZObGD0Bl407lB+/Pr36qn3nJ8=;
        b=VZvLSDrXUQZsU0SYDVRoanTlCObxj8OUshPEiQ/AQaIw73jn6YggUeavzs5cLEy1sbSZ/W
        cc3JP+ZoUh1SlWaLAUBkrjbbuPUjpZ6bj1DdStfdjgfE8gEfjhLJOuUyZzbtD2qfHAcpkR
        VG4aDiVx3CusFmcx+Z2tg863LkjZ7VM=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-595-HbUoiZE4OsWIlwq4B43Qqw-1; Fri, 11 Nov 2022 11:30:15 -0500
X-MC-Unique: HbUoiZE4OsWIlwq4B43Qqw-1
Received: by mail-qv1-f72.google.com with SMTP id l6-20020ad44446000000b004bb60364075so3980964qvt.13
        for <linux-kernel@vger.kernel.org>; Fri, 11 Nov 2022 08:30:15 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QiAHvW1lwp0CJd5SRYZObGD0Bl407lB+/Pr36qn3nJ8=;
        b=zzQm1V5ezgKbvdlyBDnzMF2FqfXCZ6TXEy4UNqjtcSUEosYgsTUe0yfY5mPzqBJ4Iw
         2STTiRm6S7GwH13RpF1cR2SLaOvB/sRi0Q/jhcL8FUhf8LABbtVPJ9ZMYtRVJHfEha7l
         zOGQh4ZPU4MIgnA94uE4CWRTLiSK1njLrobqVIT8Jq3IHPKq5EoStTgXLwBxtYgOmN2p
         j7EpmVmWImCfJNteMWORE2ni1xQz/JipqtMCuF1y0/wMeqaHqjAq2UMPQeIVpR+BUO9j
         7elEFcwx7++JcUjn/ZOFk1Vy2ITg2h9W7I4MTgzyjh6UGrdF8nphlXtgO/0ujLkEwjsz
         xQ7g==
X-Gm-Message-State: ANoB5pkxwFUKCVRVxdFNSV7SmgXL5Hns8RdrvIRbmXltjHXBwoGup+ur
        VCUlX0CCVd8RXAa99QUU3uzKOs6MWLV/yeBLhOHw7j98q1Oinu1ylcjV8wNhS+U7+aCulVvybzS
        jnBQiH1CGjdg03UwoLQ5U2sT7
X-Received: by 2002:ac8:72c4:0:b0:3a4:e32b:2f7e with SMTP id o4-20020ac872c4000000b003a4e32b2f7emr2011251qtp.320.1668184215307;
        Fri, 11 Nov 2022 08:30:15 -0800 (PST)
X-Google-Smtp-Source: AA0mqf54BT35cnejvOXQWGDStq9BX5uwI1sP1wxyjss0lhi6HO25WV7hDVOfAJ76tOFzj+0UuIRBTQ==
X-Received: by 2002:ac8:72c4:0:b0:3a4:e32b:2f7e with SMTP id o4-20020ac872c4000000b003a4e32b2f7emr2011227qtp.320.1668184215057;
        Fri, 11 Nov 2022 08:30:15 -0800 (PST)
Received: from sgarzare-redhat (host-82-53-134-234.retail.telecomitalia.it. [82.53.134.234])
        by smtp.gmail.com with ESMTPSA id z17-20020ac86b91000000b0038d9555b580sm1454930qts.44.2022.11.11.08.30.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Nov 2022 08:30:14 -0800 (PST)
Date:   Fri, 11 Nov 2022 17:30:07 +0100
From:   Stefano Garzarella <sgarzare@redhat.com>
To:     Eugenio Perez Martin <eperezma@redhat.com>
Cc:     virtualization@lists.linux-foundation.org,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] vdpa_sim: fix vringh initialization in
 vdpasim_queue_ready()
Message-ID: <20221111163007.35kvkodvk6zpimmu@sgarzare-redhat>
References: <20221110141335.62171-1-sgarzare@redhat.com>
 <CAJaqyWdvdy2QxuuyPRtfBKtuObrMg_kX_R9hdui+Oh72XtJ7Qw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJaqyWdvdy2QxuuyPRtfBKtuObrMg_kX_R9hdui+Oh72XtJ7Qw@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 11, 2022 at 04:40:33PM +0100, Eugenio Perez Martin wrote:
>On Thu, Nov 10, 2022 at 3:13 PM Stefano Garzarella <sgarzare@redhat.com> wrote:
>>
>> When we initialize vringh, we should pass the features and the
>> number of elements in the virtqueue negotiated with the driver,
>> otherwise operations with vringh may fail.
>>
>> This was discovered in a case where the driver sets a number of
>> elements in the virtqueue different from the value returned by
>> .get_vq_num_max().
>>
>> In vdpasim_vq_reset() is safe to initialize the vringh with
>> default values, since the virtqueue will not be used until
>> vdpasim_queue_ready() is called again.
>>
>> Fixes: 2c53d0f64c06 ("vdpasim: vDPA device simulator")
>> Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
>> ---
>>  drivers/vdpa/vdpa_sim/vdpa_sim.c | 3 +--
>>  1 file changed, 1 insertion(+), 2 deletions(-)
>>
>> diff --git a/drivers/vdpa/vdpa_sim/vdpa_sim.c b/drivers/vdpa/vdpa_sim/vdpa_sim.c
>> index b071f0d842fb..b20689f8fe89 100644
>> --- a/drivers/vdpa/vdpa_sim/vdpa_sim.c
>> +++ b/drivers/vdpa/vdpa_sim/vdpa_sim.c
>> @@ -67,8 +67,7 @@ static void vdpasim_queue_ready(struct vdpasim *vdpasim, unsigned int idx)
>>  {
>>         struct vdpasim_virtqueue *vq = &vdpasim->vqs[idx];
>>
>> -       vringh_init_iotlb(&vq->vring, vdpasim->dev_attr.supported_features,
>> -                         VDPASIM_QUEUE_MAX, false,
>> +       vringh_init_iotlb(&vq->vring, vdpasim->features, vq->num, false,
>>                           (struct vring_desc *)(uintptr_t)vq->desc_addr,
>>                           (struct vring_avail *)
>>                           (uintptr_t)vq->driver_addr,
>> --
>> 2.38.1
>>
>
>I think this is definitely an improvement, but I'd say we should go a
>step further and rename VDPASIM_QUEUE_MAX to VDPASIM_QUEUE_DEFAULT. As
>you point out in the patch message it is not a max anymore.

I'm not sure about renaming since it is the value returned by 
vdpasim_get_vq_num_max, so IMHO the _MAX suffix is fine.
But I admit that initially I didn't understand whether it's the maximum 
number of queues or elements, so maybe VDPASIM_VQ_NUM_MAX is better.

>
>Another thing to note is that we don't have a way to report that
>userspace indicated a bad value for queue length. With the current
>code vringh will not initialize at all if I'm not wrong, so we should
>prevent userspace to put a bad num.

Right!

>
>Ideally, we should repeat the tests of vring_init_kern at
>vdpasim_set_vq_num. We could either call it with NULL vring addresses
>to check for -EINVAL, or simply repeat the conditional (!num || num >
>0xffff || (num & (num - 1))). I'd say the first one is better to not
>go out of sync.

Or we could do the check in vdpasim_set_vq_ready() and set it not ready 
if the vq_num is wrong.

>
>All of that can be done on top anyway, so for this patch:
>
>Acked-by: Eugenio Pérez <eperezma@redhat.com>
>

Thanks for the review,
Stefano

