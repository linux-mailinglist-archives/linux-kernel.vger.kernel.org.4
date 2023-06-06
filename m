Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 48E617234F8
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Jun 2023 04:03:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232896AbjFFCDm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Jun 2023 22:03:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232528AbjFFCDj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Jun 2023 22:03:39 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A1021B8
        for <linux-kernel@vger.kernel.org>; Mon,  5 Jun 2023 19:03:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1686016980;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=/G6C9VSQMGK50X1DW2+MpQLN1ZZJnh0O9qWc8VaDzp0=;
        b=PeVbaO1WVIrPOZtbLxloBeCGEootFMrU8jgRnc8gxTb/zWYqj0ygj0ArFpQdOFaZc3AjR/
        /BA91/8FHfEv47dDbtEYM5DPmSmyhB8QiPo7tYH1Z79FhFhL59sCc8aBXPy2QtF7+KJa48
        k/z2Nrky20RO7RtB0ccd6UudSy/WvuU=
Received: from mail-lf1-f70.google.com (mail-lf1-f70.google.com
 [209.85.167.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-517-tLejWf0YMeWSxbBYbCha2A-1; Mon, 05 Jun 2023 22:02:59 -0400
X-MC-Unique: tLejWf0YMeWSxbBYbCha2A-1
Received: by mail-lf1-f70.google.com with SMTP id 2adb3069b0e04-4f6224e3d54so1739592e87.0
        for <linux-kernel@vger.kernel.org>; Mon, 05 Jun 2023 19:02:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686016978; x=1688608978;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/G6C9VSQMGK50X1DW2+MpQLN1ZZJnh0O9qWc8VaDzp0=;
        b=VY+BI8S656mVo/fNtF4Rx3DHoWbFJahQ9/GaB27S4KxiD4NIJPetvcEnhoSmykH1hq
         o/Cq4HVPwnoY8U3qVJFnO6z6mQ2Ll5x/Tpf9nTekyw2MXG8mIEsHn5HwS0TCc47/3qGt
         T6kAyvfe1k6SRMcaH60QcKYMkMMlC694vh/nSh1EU2tRcoztVOdvGqSD+s3FwADCug9o
         jEMA+iEwqx/10j1GdBRMhvOIkxYMLjvPoap+ZqbJsD5I99AuqDWpquRuJb7PJgDuiOcl
         92k66FK7gY7SAExL57u33kof96Z2uAPZhSl3cFHiqMsToLNMeBRW4BCZlvv5CoXJP77K
         v9OA==
X-Gm-Message-State: AC+VfDwRbJbuRLjwgLuJfMsOLfohL0NPCrzirSBXDeRTdGgxoMLaWNi7
        Nlihlvv8e3HZ5H2f9mmoevvD6/gF8f4pXlJy1OtRLn28nWPYeuQfg7Zm6i0Q+gmmsBZCNn5rdJz
        eRC4d7wo0vn5ybV3gUcHLve6z24YJIq+5NxaLASYz
X-Received: by 2002:ac2:53bc:0:b0:4f6:13f1:38a4 with SMTP id j28-20020ac253bc000000b004f613f138a4mr329975lfh.41.1686016977879;
        Mon, 05 Jun 2023 19:02:57 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ4cIrBnY4kB+bFDDnz2MbnqOP3zSg9ihJbXJhmZVFaL69cW56OPxFnisU6fg5GCTP07K87hMgp4Ask3xq2jWEU=
X-Received: by 2002:ac2:53bc:0:b0:4f6:13f1:38a4 with SMTP id
 j28-20020ac253bc000000b004f613f138a4mr329964lfh.41.1686016977603; Mon, 05 Jun
 2023 19:02:57 -0700 (PDT)
MIME-Version: 1.0
References: <20230605210237.60988-1-brett.creeley@amd.com>
In-Reply-To: <20230605210237.60988-1-brett.creeley@amd.com>
From:   Jason Wang <jasowang@redhat.com>
Date:   Tue, 6 Jun 2023 10:02:46 +0800
Message-ID: <CACGkMEuurGtxQW4a9xnEzBsjHV+tKPPPFr8+qUm2=OoYH8pSsA@mail.gmail.com>
Subject: Re: [RFC PATCH net] virtio_net: Prevent napi_weight changes with
 VIRTIO_NET_F_NOTF_COAL support
To:     Brett Creeley <brett.creeley@amd.com>
Cc:     linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        virtualization@lists.linux-foundation.org,
        alvaro.karsz@solid-run.com, pabeni@redhat.com, kuba@kernel.org,
        edumazet@google.com, davem@davemloft.net,
        xuanzhuo@linux.alibaba.com, mst@redhat.com, shannon.nelson@amd.com
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

On Tue, Jun 6, 2023 at 5:03=E2=80=AFAM Brett Creeley <brett.creeley@amd.com=
> wrote:
>
> Commit 699b045a8e43 ("net: virtio_net: notifications coalescing
> support") added support for VIRTIO_NET_F_NOTF_COAL. The get_coalesce
> call made changes to report "1" in tx_max_coalesced_frames if
> VIRTIO_NET_F_NOTF_COAL is not supported and napi.weight is non-zero.
> However, the napi_weight value could still be changed by the
> set_coalesce call regardless of whether or not the device supports
> VIRTIO_NET_F_NOTF_COAL.
>
> It seems like the tx_max_coalesced_frames value should not control more
> than 1 thing (i.e. napi_weight and the device's tx_max_packets). So, fix
> this by only allowing the napi_weight change if VIRTIO_NET_F_NOTF_COAL
> is not supported by the virtio device.
>
> It wasn't clear to me if this was the intended behavior, so that's why
> I'm sending this as an RFC patch initially. Based on the feedback, I
> will resubmit as an official patch.

It seems the current code is fine since:

Before tx coalescing, we have two modes for tx interrupt:

1) TX NAPI mode, using NAPI to recycle xmit packets
2) TX no-NAPI mode, depends on the start_xmit() to recycle xmit packets

Each has their own use cases. E.g 1) seems to have better buffer
interaction with TCP. But 2) seems to behave better if user cares
about PPS and it can gives us 2x PPS when using a vhost-user backend.

So we leave an option to switch between those two via sq.napi_weight

ethtool -C tx-frames-irq 0 // To disable tx interrupts
ethtool -C tx-frames-irq 1 // To enable tx interrupts

After tx intr coleasing, we want to stick to this API.

ethtool -C tx-frames-irq 0 // To disable tx interrupts
ethtool -C tx-frames-irq N (N>=3D1) // To enable tx interrupts

Thanks

>
> Fixes: 699b045a8e43 ("net: virtio_net: notifications coalescing support")
> Signed-off-by: Brett Creeley <brett.creeley@amd.com>
> ---
>  drivers/net/virtio_net.c | 24 +++++++++++++-----------
>  1 file changed, 13 insertions(+), 11 deletions(-)
>
> diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> index 486b5849033d..e28387866909 100644
> --- a/drivers/net/virtio_net.c
> +++ b/drivers/net/virtio_net.c
> @@ -2990,19 +2990,21 @@ static int virtnet_set_coalesce(struct net_device=
 *dev,
>         int ret, i, napi_weight;
>         bool update_napi =3D false;
>
> -       /* Can't change NAPI weight if the link is up */
> -       napi_weight =3D ec->tx_max_coalesced_frames ? NAPI_POLL_WEIGHT : =
0;
> -       if (napi_weight ^ vi->sq[0].napi.weight) {
> -               if (dev->flags & IFF_UP)
> -                       return -EBUSY;
> -               else
> -                       update_napi =3D true;
> -       }
> -
> -       if (virtio_has_feature(vi->vdev, VIRTIO_NET_F_NOTF_COAL))
> +       if (virtio_has_feature(vi->vdev, VIRTIO_NET_F_NOTF_COAL)) {
>                 ret =3D virtnet_send_notf_coal_cmds(vi, ec);
> -       else
> +       } else {
> +               /* Can't change NAPI weight if the link is up */
> +               napi_weight =3D ec->tx_max_coalesced_frames ?
> +                       NAPI_POLL_WEIGHT : 0;
> +               if (napi_weight ^ vi->sq[0].napi.weight) {
> +                       if (dev->flags & IFF_UP)
> +                               return -EBUSY;
> +                       else
> +                               update_napi =3D true;
> +               }
> +
>                 ret =3D virtnet_coal_params_supported(ec);
> +       }
>
>         if (ret)
>                 return ret;
> --
> 2.17.1
>

