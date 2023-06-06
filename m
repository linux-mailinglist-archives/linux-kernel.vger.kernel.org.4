Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F77672347F
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Jun 2023 03:30:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233624AbjFFBaW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Jun 2023 21:30:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229667AbjFFBaU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Jun 2023 21:30:20 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A846C102
        for <linux-kernel@vger.kernel.org>; Mon,  5 Jun 2023 18:29:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1686014976;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=LO0PcoIQipRUJHYAP4IZqQY6Y4aLmW6KIu9FvB1onCA=;
        b=SbfCjf/BhLm68DtmdtVWQKGTfZA42ZougQdNGNd9m/YwUYw99VJNU5YUcY49loDexsa/Dj
        BqOHfLcDUE0MhkDNrfqfZbNdVrSyV5ndfX5EvmktT8Sa+UnGOccxItiMHxSZzPOkxT0UvU
        DFEQDDNH1fpInc/Q0sHEli96MF1PdUg=
Received: from mail-lj1-f200.google.com (mail-lj1-f200.google.com
 [209.85.208.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-610-xkTozMKkPauVKtPk8QhExA-1; Mon, 05 Jun 2023 21:29:35 -0400
X-MC-Unique: xkTozMKkPauVKtPk8QhExA-1
Received: by mail-lj1-f200.google.com with SMTP id 38308e7fff4ca-2b1b1693338so26602341fa.3
        for <linux-kernel@vger.kernel.org>; Mon, 05 Jun 2023 18:29:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686014974; x=1688606974;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LO0PcoIQipRUJHYAP4IZqQY6Y4aLmW6KIu9FvB1onCA=;
        b=iTLtKOSnaq+El51Ce469Vod+7MPF/KckIko/5PUQpYvpxQfrjL5p+j8JKUZNH9EnB/
         csMqE1LT+8qvR46LRrTqukekQl3/DqYQH8acsPfd/4szWlJdBsY4NSlTSMqhDxi/DvhI
         e6HAdx6BhueEkP/2l+/ydN8QuqE4xpoW++1ZT9FTbNaAnfOz4EdjvjRH1LKC/l5YdRO7
         lXdaCo0j5M3TGRnwJvZN8o3I8i2XiH546pczqN7Y6qevzdpWu/5dwhFBEBLdMvsBtOX6
         PHmWRUhRXnnWYjuxpY8kFUNpgM/6I5z+4/E0bFn6gNStHGKuaQ5fWOFDYXpqqrRM5VeP
         8M4A==
X-Gm-Message-State: AC+VfDxthjvPHerjIxMK/ZtodiQN/X8NlIHGOyswFwafrFrqnlBos8ET
        ka0PebrFEf1x0OcLlXLJ2eJnqArpzzfMGeuUyhVfURKNBFEQD2oIXGUWSvTwif0nGSwTrnCyQXW
        vWTmOoEXKbkk3S11MXSBBMxmB5tiMQMX6sTxGn7G9
X-Received: by 2002:a05:651c:90:b0:2ac:770f:8831 with SMTP id 16-20020a05651c009000b002ac770f8831mr471625ljq.40.1686014974165;
        Mon, 05 Jun 2023 18:29:34 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ7q8xwsG2H2HJLbjrNSEB15Tcb4Vhw2h23yOvguszqhRoiFXNx/aA4LQRn2qI/jZv0NF0GvO+g7EwDrFoZVmEY=
X-Received: by 2002:a05:651c:90:b0:2ac:770f:8831 with SMTP id
 16-20020a05651c009000b002ac770f8831mr471619ljq.40.1686014973831; Mon, 05 Jun
 2023 18:29:33 -0700 (PDT)
MIME-Version: 1.0
References: <20230605110644.151211-1-sgarzare@redhat.com> <20230605084104-mutt-send-email-mst@kernel.org>
 <24fjdwp44hovz3d3qkzftmvjie45er3g3boac7aezpvzbwvuol@lmo47ydvnqau>
 <20230605085840-mutt-send-email-mst@kernel.org> <gi2hngx3ndsgz5d2rpqjywdmou5vxhd7xgi5z2lbachr7yoos4@kpifz37oz2et>
 <20230605095404-mutt-send-email-mst@kernel.org> <32ejjuvhvcicv7wjuetkv34qtlpa657n4zlow4eq3fsi2twozk@iqnd2t5tw2an>
In-Reply-To: <32ejjuvhvcicv7wjuetkv34qtlpa657n4zlow4eq3fsi2twozk@iqnd2t5tw2an>
From:   Jason Wang <jasowang@redhat.com>
Date:   Tue, 6 Jun 2023 09:29:22 +0800
Message-ID: <CACGkMEu3PqQ99UoKF5NHgVADD3q=BF6jhLiyumeT4S1QCqN1tw@mail.gmail.com>
Subject: Re: [PATCH] vhost-vdpa: filter VIRTIO_F_RING_PACKED feature
To:     Stefano Garzarella <sgarzare@redhat.com>
Cc:     "Michael S. Tsirkin" <mst@redhat.com>,
        Shannon Nelson <shannon.nelson@amd.com>,
        virtualization@lists.linux-foundation.org, netdev@vger.kernel.org,
        =?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>,
        Tiwei Bie <tiwei.bie@intel.com>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 5, 2023 at 10:58=E2=80=AFPM Stefano Garzarella <sgarzare@redhat=
.com> wrote:
>
> On Mon, Jun 05, 2023 at 09:54:57AM -0400, Michael S. Tsirkin wrote:
> >On Mon, Jun 05, 2023 at 03:30:35PM +0200, Stefano Garzarella wrote:
> >> On Mon, Jun 05, 2023 at 09:00:25AM -0400, Michael S. Tsirkin wrote:
> >> > On Mon, Jun 05, 2023 at 02:54:20PM +0200, Stefano Garzarella wrote:
> >> > > On Mon, Jun 05, 2023 at 08:41:54AM -0400, Michael S. Tsirkin wrote=
:
> >> > > > On Mon, Jun 05, 2023 at 01:06:44PM +0200, Stefano Garzarella wro=
te:
> >> > > > > vhost-vdpa IOCTLs (eg. VHOST_GET_VRING_BASE, VHOST_SET_VRING_B=
ASE)
> >> > > > > don't support packed virtqueue well yet, so let's filter the
> >> > > > > VIRTIO_F_RING_PACKED feature for now in vhost_vdpa_get_feature=
s().
> >> > > > >
> >> > > > > This way, even if the device supports it, we don't risk it bei=
ng
> >> > > > > negotiated, then the VMM is unable to set the vring state prop=
erly.
> >> > > > >
> >> > > > > Fixes: 4c8cf31885f6 ("vhost: introduce vDPA-based backend")
> >> > > > > Cc: stable@vger.kernel.org
> >> > > > > Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
> >> > > > > ---
> >> > > > >
> >> > > > > Notes:
> >> > > > >     This patch should be applied before the "[PATCH v2 0/3] vh=
ost_vdpa:
> >> > > > >     better PACKED support" series [1] and backported in stable=
 branches.
> >> > > > >
> >> > > > >     We can revert it when we are sure that everything is worki=
ng with
> >> > > > >     packed virtqueues.
> >> > > > >
> >> > > > >     Thanks,
> >> > > > >     Stefano
> >> > > > >
> >> > > > >     [1] https://lore.kernel.org/virtualization/20230424225031.=
18947-1-shannon.nelson@amd.com/
> >> > > >
> >> > > > I'm a bit lost here. So why am I merging "better PACKED support"=
 then?
> >> > >
> >> > > To really support packed virtqueue with vhost-vdpa, at that point =
we would
> >> > > also have to revert this patch.
> >> > >
> >> > > I wasn't sure if you wanted to queue the series for this merge win=
dow.
> >> > > In that case do you think it is better to send this patch only for=
 stable
> >> > > branches?
> >> > > > Does this patch make them a NOP?
> >> > >
> >> > > Yep, after applying the "better PACKED support" series and being
> >> > > sure that
> >> > > the IOCTLs of vhost-vdpa support packed virtqueue, we should rever=
t this
> >> > > patch.
> >> > >
> >> > > Let me know if you prefer a different approach.
> >> > >
> >> > > I'm concerned that QEMU uses vhost-vdpa IOCTLs thinking that the k=
ernel
> >> > > interprets them the right way, when it does not.
> >> > >
> >> > > Thanks,
> >> > > Stefano
> >> > >
> >> >
> >> > If this fixes a bug can you add Fixes tags to each of them? Then it'=
s ok
> >> > to merge in this window. Probably easier than the elaborate
> >> > mask/unmask dance.
> >>
> >> CCing Shannon (the original author of the "better PACKED support"
> >> series).
> >>
> >> IIUC Shannon is going to send a v3 of that series to fix the
> >> documentation, so Shannon can you also add the Fixes tags?
> >>
> >> Thanks,
> >> Stefano
> >
> >Well this is in my tree already. Just reply with
> >Fixes: <>
> >to each and I will add these tags.
>
> I tried, but it is not easy since we added the support for packed
> virtqueue in vdpa and vhost incrementally.
>
> Initially I was thinking of adding the same tag used here:
>
> Fixes: 4c8cf31885f6 ("vhost: introduce vDPA-based backend")
>
> Then I discovered that vq_state wasn't there, so I was thinking of
>
> Fixes: 530a5678bc00 ("vdpa: support packed virtqueue for set/get_vq_state=
()")
>
> So we would have to backport quite a few patches into the stable branches=
.
> I don't know if it's worth it...
>
> I still think it is better to disable packed in the stable branches,
> otherwise I have to make a list of all the patches we need.
>
> Any other ideas?

AFAIK, except for vp_vdpa, pds seems to be the first parent that
supports packed virtqueue. Users should not notice anything wrong if
they don't use packed virtqueue. And the problem of vp_vdpa + packed
virtqueue came since the day0 of vp_vdpa. It seems fine to do nothing
I guess.

Thanks

>
> Thanks,
> Stefano
>
>

