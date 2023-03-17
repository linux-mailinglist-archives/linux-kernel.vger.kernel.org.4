Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE6C66BE807
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Mar 2023 12:26:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230004AbjCQL0e (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Mar 2023 07:26:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229539AbjCQL0a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Mar 2023 07:26:30 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D28726A1F4
        for <linux-kernel@vger.kernel.org>; Fri, 17 Mar 2023 04:25:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1679052343;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=3eg+W4V459K453HHEWu6+WOIdJvDrwAbatlv4pe/Z8I=;
        b=LYssn6Kq6bpiOLz5CywMTWjZHFMrkz3zFjINv5EGN33/Qt3c2ASQf+l0Ep1xahKs0EjQr+
        JZwTkVgTQ6lFrIMNAacplxrsVYLOE9WG2M11s64iTMvLcYXHn68dsf7Y8GSbqZX7SXxbKi
        ZX+C8nSKqP3I5hALdB46zVI1n4PfBUQ=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-605-9J5DCpsBNUelN7dOyZlZfQ-1; Fri, 17 Mar 2023 07:25:40 -0400
X-MC-Unique: 9J5DCpsBNUelN7dOyZlZfQ-1
Received: by mail-wm1-f70.google.com with SMTP id t1-20020a7bc3c1000000b003dfe223de49so4131139wmj.5
        for <linux-kernel@vger.kernel.org>; Fri, 17 Mar 2023 04:25:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679052339;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3eg+W4V459K453HHEWu6+WOIdJvDrwAbatlv4pe/Z8I=;
        b=a+iLjV2n6Gj6ldL94E/ml5+IuT3fWoLUHQ6hV7DTmQx5IDCEomfPAD7LI+YqKzoabz
         vDTzfKt0TLRDRmofW9UyfxdHMwDtSJTqNy2NaW7P2LQusaRFd+v+MyUE/TUMphjm2ag7
         /ViaoWpjHgPYr68zn/glvLEkwkEl08tUjAlLBYva3PydGeQredmD26fsx10UbdvgD8BA
         5ay8dmVcDFmt1w5SlDVqVvLvTg69ZDs4qRBmyQWYZ7muX0hjUF7NZxUFiXvoIh2avjXe
         E8VwKpFs/61/N6SF8gUpHpcv/3jpllYk/b8fS3EEHcoCJLw1Wc7l+yTvgaSUJ/RrNez0
         Y6Ig==
X-Gm-Message-State: AO0yUKU8xH89V9hwWi3LCJeUhl0wgB7a7XVg5KIeYlZZTWq5+lQKh35Z
        1Qwq6odbgnjBBD5BqxW274fqxU7ADG1MXqaJRUpDwbNP6+BSeqN2W5TuT45J1wLoLm2bS3UclqF
        C3QMm7wakCeJkE34/4T00Kkfx
X-Received: by 2002:adf:ecc4:0:b0:2c5:510b:8f9c with SMTP id s4-20020adfecc4000000b002c5510b8f9cmr7021027wro.52.1679052339555;
        Fri, 17 Mar 2023 04:25:39 -0700 (PDT)
X-Google-Smtp-Source: AK7set9FZ5f9vlrQw7xgnuvkWSEFXAo8AQG5rmR3D2Ycyj5yA2kbAhnhVzi4UvMN5l8xZtTnmtbeRA==
X-Received: by 2002:adf:ecc4:0:b0:2c5:510b:8f9c with SMTP id s4-20020adfecc4000000b002c5510b8f9cmr7021010wro.52.1679052339284;
        Fri, 17 Mar 2023 04:25:39 -0700 (PDT)
Received: from sgarzare-redhat (host-82-57-51-170.retail.telecomitalia.it. [82.57.51.170])
        by smtp.gmail.com with ESMTPSA id r10-20020adfce8a000000b002cefcac0c62sm1770714wrn.9.2023.03.17.04.25.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Mar 2023 04:25:38 -0700 (PDT)
Date:   Fri, 17 Mar 2023 12:25:36 +0100
From:   Stefano Garzarella <sgarzare@redhat.com>
To:     Eugenio Perez Martin <eperezma@redhat.com>
Cc:     Jason Wang <jasowang@redhat.com>,
        virtualization@lists.linux-foundation.org,
        Andrey Zhadchenko <andrey.zhadchenko@virtuozzo.com>,
        netdev@vger.kernel.org, stefanha@redhat.com,
        linux-kernel@vger.kernel.org,
        "Michael S. Tsirkin" <mst@redhat.com>, kvm@vger.kernel.org
Subject: Re: [PATCH v2 4/8] vringh: support VA with iotlb
Message-ID: <20230317112536.t7gm4dop5cafgvoe@sgarzare-redhat>
References: <20230302113421.174582-1-sgarzare@redhat.com>
 <20230302113421.174582-5-sgarzare@redhat.com>
 <CAJaqyWdeEzKnYuX-c348vVg0PpUH4y-e1dSLhRvYem=MEDKE=Q@mail.gmail.com>
 <CAGxU2F7GZxMwLNsAebaPx61MoePYYmFS1q66An-EDhq4u+a9ng@mail.gmail.com>
 <CAJaqyWcAfyANeShsdV55vVkK=sHxGNVef7E7jj-CqTL7SbqhCg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJaqyWcAfyANeShsdV55vVkK=sHxGNVef7E7jj-CqTL7SbqhCg@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 17, 2023 at 10:49:27AM +0100, Eugenio Perez Martin wrote:
>On Thu, Mar 16, 2023 at 5:07 PM Stefano Garzarella <sgarzare@redhat.com> wrote:
>>
>> On Fri, Mar 3, 2023 at 3:39 PM Eugenio Perez Martin <eperezma@redhat.com> wrote:
>> >
>> > On Thu, Mar 2, 2023 at 12:35 PM Stefano Garzarella <sgarzare@redhat.com> wrote:
>> > >
>> > > vDPA supports the possibility to use user VA in the iotlb messages.
>> > > So, let's add support for user VA in vringh to use it in the vDPA
>> > > simulators.
>> > >
>> > > Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
>> > > ---
>> > >
>> > > Notes:
>> > >     v2:
>> > >     - replace kmap_atomic() with kmap_local_page() [see previous patch]
>> > >     - fix cast warnings when build with W=1 C=1
>> > >
>> > >  include/linux/vringh.h            |   5 +-
>> > >  drivers/vdpa/mlx5/net/mlx5_vnet.c |   2 +-
>> > >  drivers/vdpa/vdpa_sim/vdpa_sim.c  |   4 +-
>> > >  drivers/vhost/vringh.c            | 247 ++++++++++++++++++++++++------
>> > >  4 files changed, 205 insertions(+), 53 deletions(-)
>> > >
>>
>> [...]
>>
>> >
>> > It seems to me iotlb_translate_va and iotlb_translate_pa are very
>> > similar, their only difference is that the argument is that iov is
>> > iovec instead of bio_vec. And how to fill it, obviously.
>> >
>> > It would be great to merge both functions, only differing with a
>> > conditional on vrh->use_va, or generics, or similar. Or, if following
>> > the style of the rest of vringh code, to provide a callback to fill
>> > iovec (although I like conditional more).
>> >
>> > However I cannot think of an easy way to perform that without long
>> > macros or type erasure.
>>
>> Thank you for pushing me :-)
>> I finally managed to avoid code duplication (partial patch attached,
>> but not yet fully tested).
>>
>> @Jason: with this refactoring I removed copy_to_va/copy_to_pa, so I
>> also avoided getu16_iotlb_va/pa.
>>
>> I will send the full patch in v3, but I would like to get your opinion
>> first ;-)
>>
>>
>>
>> diff --git a/drivers/vhost/vringh.c b/drivers/vhost/vringh.c
>> index 0ba3ef809e48..71dd67700e36 100644
>> --- a/drivers/vhost/vringh.c
>> +++ b/drivers/vhost/vringh.c
>> @@ -1096,8 +1096,7 @@ EXPORT_SYMBOL(vringh_need_notify_kern);
>>
>>  static int iotlb_translate(const struct vringh *vrh,
>>                            u64 addr, u64 len, u64 *translated,
>> -                          struct bio_vec iov[],
>> -                          int iov_size, u32 perm)
>> +                          void *iov, int iov_size, bool iovec, u32 perm)
>
>I think this is an improvement, but we're doing type erasure here. I
>don't think it is a big deal since the function is not exported, it's
>pretty contained in this file, so I'd ack this version too. I'm just
>throwing ideas here:
>
>a) typedef the union {iovec, bio_vec} and use that type in the parameter.
>
>As a drawback, that union feels out of place in this file. Is this the
>only place where it is needed? I don't see other similar uses in the
>kernel.

iov_iter has something similar, but they are const pointers, so IIUC
it is not supposed to be used to set the bvec contents, just iterate it.

Anyway I thought something similar and should be doable, but since
it was internal API I went to type erasure.

>
>b) To convert from iov to bio_iov at return
>The drawback is the extra processing if the compiler is not smart
>enough to inline it. I prefer the previous one but I didn't want to
>omit it, just in case.

Yep, I prefer too the previous one, so let's go in that direction for
v3 ;-)

Thanks,
Stefano

