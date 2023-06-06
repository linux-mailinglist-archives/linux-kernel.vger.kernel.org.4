Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 425547234FA
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Jun 2023 04:04:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233001AbjFFCEc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Jun 2023 22:04:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232528AbjFFCEa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Jun 2023 22:04:30 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C30B3130
        for <linux-kernel@vger.kernel.org>; Mon,  5 Jun 2023 19:03:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1686017013;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Z1Ccl3e5U8u2+piXpey/hOv34+n9CVP0Hq28UZVhm38=;
        b=AqC64Yn/VqE3AHsOWRHsSY2m1lk5cSQn84lPHeLlnVy3o9WES//JMzRgabmOoiHEtv5JDh
        zyRKUgUYbBmsPc5N3Gyd0ryKDxRu/7ZwzAQgb8Bv06m0jAnhLzhxbWu0OkScFaJcvn3pSn
        U9hz9gkqAfmAhN2orS96Swx+c7ebVf0=
Received: from mail-lf1-f71.google.com (mail-lf1-f71.google.com
 [209.85.167.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-262-eXrYIGnENRy4hAqIv46jkQ-1; Mon, 05 Jun 2023 22:03:32 -0400
X-MC-Unique: eXrYIGnENRy4hAqIv46jkQ-1
Received: by mail-lf1-f71.google.com with SMTP id 2adb3069b0e04-4f61f59c230so1818284e87.2
        for <linux-kernel@vger.kernel.org>; Mon, 05 Jun 2023 19:03:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686017010; x=1688609010;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Z1Ccl3e5U8u2+piXpey/hOv34+n9CVP0Hq28UZVhm38=;
        b=K51JhMydSZnVrO6XZB4o+NTJebgvBsHtZDyZDPFcdh0wgg3v+Y0GvDWz8KfQiVToNb
         +pYRgxfm8c/JOtP4khYXb5ffD/U+TayIAYhQZS2krLjCa+/pwdotldmBm8A9S2nNPYPm
         Dwk4Y4vhhy1qjd4jwV+g555h1/RNking3Auc0PzSmfFgvzp/bx7pWwA+trlyupXtYMAU
         Mxi2ESijCzMOI7iXqngncj3pM9hWnw8r9H76J5cFkAk9KmfSb0mJmK7/56D4RVGRWg+n
         65Cyjy4sj5rQQ8J31P+dWlcxAlB2V95XSHXQdUlgUbE605ntEZ5FDhm8qBzSW5FyHtNi
         7vYw==
X-Gm-Message-State: AC+VfDwXBjKJQHHleU7JGwZofYPKlCo361QPMwe8zFaerZvbR0WXk94t
        WWNiPQFk6tIxpPb00Vz6A48NG1eRnDoYQ8lSM4IlSHZ6X4soiKknQLOI8Hw/baG5v8oyQx7p0RC
        12ZCMiF7o62LsR5nT6cL6ZLowLTK9ZH5C/rYQav0h
X-Received: by 2002:a19:700a:0:b0:4f6:140e:c9bf with SMTP id h10-20020a19700a000000b004f6140ec9bfmr364859lfc.22.1686017010561;
        Mon, 05 Jun 2023 19:03:30 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ7tUXEvqHcY5X0N1auu65CSDbYsRfvVM8LVgBQkpZ8dI8mxtplO6IPvFP1wcP1ZT7NJpRubNU9Fxph4bbAotkg=
X-Received: by 2002:a19:700a:0:b0:4f6:140e:c9bf with SMTP id
 h10-20020a19700a000000b004f6140ec9bfmr364846lfc.22.1686017010284; Mon, 05 Jun
 2023 19:03:30 -0700 (PDT)
MIME-Version: 1.0
References: <20230605210237.60988-1-brett.creeley@amd.com> <1686016374.4953902-2-xuanzhuo@linux.alibaba.com>
In-Reply-To: <1686016374.4953902-2-xuanzhuo@linux.alibaba.com>
From:   Jason Wang <jasowang@redhat.com>
Date:   Tue, 6 Jun 2023 10:03:19 +0800
Message-ID: <CACGkMEuCGPWJVG0knTnG-1YxbACZLXLTrFMqt=eKiV-K_B_8FA@mail.gmail.com>
Subject: Re: [RFC PATCH net] virtio_net: Prevent napi_weight changes with
 VIRTIO_NET_F_NOTF_COAL support
To:     Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Cc:     Brett Creeley <brett.creeley@amd.com>, shannon.nelson@amd.com,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        virtualization@lists.linux-foundation.org,
        alvaro.karsz@solid-run.com, pabeni@redhat.com, kuba@kernel.org,
        edumazet@google.com, davem@davemloft.net, mst@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 6, 2023 at 9:57=E2=80=AFAM Xuan Zhuo <xuanzhuo@linux.alibaba.co=
m> wrote:
>
> On Mon, 5 Jun 2023 14:02:36 -0700, Brett Creeley <brett.creeley@amd.com> =
wrote:
> > Commit 699b045a8e43 ("net: virtio_net: notifications coalescing
> > support") added support for VIRTIO_NET_F_NOTF_COAL. The get_coalesce
> > call made changes to report "1" in tx_max_coalesced_frames if
> > VIRTIO_NET_F_NOTF_COAL is not supported and napi.weight is non-zero.
> > However, the napi_weight value could still be changed by the
> > set_coalesce call regardless of whether or not the device supports
> > VIRTIO_NET_F_NOTF_COAL.
> >
> > It seems like the tx_max_coalesced_frames value should not control more
> > than 1 thing (i.e. napi_weight and the device's tx_max_packets). So, fi=
x
> > this by only allowing the napi_weight change if VIRTIO_NET_F_NOTF_COAL
> > is not supported by the virtio device.
>
>
> @Jason I wonder should we keep this function to change the napi weight by=
 the
> coalesec command.

I think so, explained in another thread.

Thanks

>
> Thanks.
>
> >
> > It wasn't clear to me if this was the intended behavior, so that's why
> > I'm sending this as an RFC patch initially. Based on the feedback, I
> > will resubmit as an official patch.
> >
> > Fixes: 699b045a8e43 ("net: virtio_net: notifications coalescing support=
")
> > Signed-off-by: Brett Creeley <brett.creeley@amd.com>
> > ---
> >  drivers/net/virtio_net.c | 24 +++++++++++++-----------
> >  1 file changed, 13 insertions(+), 11 deletions(-)
> >
> > diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> > index 486b5849033d..e28387866909 100644
> > --- a/drivers/net/virtio_net.c
> > +++ b/drivers/net/virtio_net.c
> > @@ -2990,19 +2990,21 @@ static int virtnet_set_coalesce(struct net_devi=
ce *dev,
> >       int ret, i, napi_weight;
> >       bool update_napi =3D false;
> >
> > -     /* Can't change NAPI weight if the link is up */
> > -     napi_weight =3D ec->tx_max_coalesced_frames ? NAPI_POLL_WEIGHT : =
0;
> > -     if (napi_weight ^ vi->sq[0].napi.weight) {
> > -             if (dev->flags & IFF_UP)
> > -                     return -EBUSY;
> > -             else
> > -                     update_napi =3D true;
> > -     }
> > -
> > -     if (virtio_has_feature(vi->vdev, VIRTIO_NET_F_NOTF_COAL))
> > +     if (virtio_has_feature(vi->vdev, VIRTIO_NET_F_NOTF_COAL)) {
> >               ret =3D virtnet_send_notf_coal_cmds(vi, ec);
> > -     else
> > +     } else {
> > +             /* Can't change NAPI weight if the link is up */
> > +             napi_weight =3D ec->tx_max_coalesced_frames ?
> > +                     NAPI_POLL_WEIGHT : 0;
> > +             if (napi_weight ^ vi->sq[0].napi.weight) {
> > +                     if (dev->flags & IFF_UP)
> > +                             return -EBUSY;
> > +                     else
> > +                             update_napi =3D true;
> > +             }
> > +
> >               ret =3D virtnet_coal_params_supported(ec);
> > +     }
> >
> >       if (ret)
> >               return ret;
> > --
> > 2.17.1
> >
>

