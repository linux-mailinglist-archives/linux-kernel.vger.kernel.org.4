Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B4DE6CF98A
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Mar 2023 05:25:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229595AbjC3DZ2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Mar 2023 23:25:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229462AbjC3DZZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Mar 2023 23:25:25 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED4872703
        for <linux-kernel@vger.kernel.org>; Wed, 29 Mar 2023 20:24:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1680146682;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=g7uFfI1fsGCC/n/5t6QQvqawvrwGbuPsvHs1UC6idrw=;
        b=VZ5js+Rxwi8JT4gjyS/iYYH1JMIi74VGXB84AMm+ZeRMc9bdhNbPFHmlMy371J2ckCeYz5
        XYpuMjOP8JqZCk9+bYqcu2sWb4leptAYyCaKLi/vWSwslNSepINOQi3G4BMYhX+sldtR0V
        680alVRD5Hx6dPB3YR72ZffMAYS76iQ=
Received: from mail-oa1-f72.google.com (mail-oa1-f72.google.com
 [209.85.160.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-654-VAFmaqHpMW6PtF0I0cmKAw-1; Wed, 29 Mar 2023 23:24:40 -0400
X-MC-Unique: VAFmaqHpMW6PtF0I0cmKAw-1
Received: by mail-oa1-f72.google.com with SMTP id 586e51a60fabf-17e3d37b3e6so9329040fac.22
        for <linux-kernel@vger.kernel.org>; Wed, 29 Mar 2023 20:24:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680146679; x=1682738679;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=g7uFfI1fsGCC/n/5t6QQvqawvrwGbuPsvHs1UC6idrw=;
        b=PmPpphpRM1BCA3cRp8u9iP0DxFFNUVTmzhIy5IVlEZHdfjQLCLZEis2DNbn/Q+ArvD
         H4pD3cgd5Y8adQzmWcGaM7vjznMmgOH7qa4kF8BybB3IWWGK/ToJdWh569xZTs08DXE0
         CQNsV4v2CCDrffrcBNDH1haQSnFFXMNTj9Uaw/8eJeNKi3V/NtGe9V02M3bq5N3S4wOd
         k/aSqY0h8UFQcu2uqSHQCDvVqoifDESKpq452QWlJEr+xkqOcaVLTEhhJ+yMgx0oZgIf
         oiYmRIXcpGWMFE8A4lUIxc5cHeREjtiRx7+Ppj/dPapn8FYWXtsWBODwD8uujtiV0tDU
         OdxQ==
X-Gm-Message-State: AO0yUKUytl0jdhu1Sqjrx5hOL0XG+btv5d6STZbanFt1adxPtVRDPUrQ
        B3uAKhvM3UeWw8HOyE17FtfvbznJfB+tlTrtSdJXFd6vsfGQWjwcq3HIXvTWFEYux2JYQDnHAys
        4cMJ3tY9Mr87Rvb2I8ywyf1QM0P3NQuto1BxZsLgP
X-Received: by 2002:a05:6808:2093:b0:36e:f6f5:604c with SMTP id s19-20020a056808209300b0036ef6f5604cmr5185622oiw.9.1680146679313;
        Wed, 29 Mar 2023 20:24:39 -0700 (PDT)
X-Google-Smtp-Source: AK7set8EftVQXuCal8ybd7Qlu1fk08yAwpMbgwZQQQbRD2dkPI3Xpzujy35jtlaImIxct3d+mB5laCqF0wYNwYQzrUM=
X-Received: by 2002:a05:6808:2093:b0:36e:f6f5:604c with SMTP id
 s19-20020a056808209300b0036ef6f5604cmr5185617oiw.9.1680146679072; Wed, 29 Mar
 2023 20:24:39 -0700 (PDT)
MIME-Version: 1.0
References: <20230329160321.187176-1-sgarzare@redhat.com>
In-Reply-To: <20230329160321.187176-1-sgarzare@redhat.com>
From:   Jason Wang <jasowang@redhat.com>
Date:   Thu, 30 Mar 2023 11:24:27 +0800
Message-ID: <CACGkMEvWcuMnU-t4tNpC6uS_mtSzg=DYkVRDqVQDg3bMYS5Gcw@mail.gmail.com>
Subject: Re: [PATCH] vdpa_sim_net: complete the initialization before register
 the device
To:     Stefano Garzarella <sgarzare@redhat.com>
Cc:     virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org,
        =?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>,
        "Michael S. Tsirkin" <mst@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 30, 2023 at 12:03=E2=80=AFAM Stefano Garzarella <sgarzare@redha=
t.com> wrote:
>
> Initialization must be completed before calling _vdpa_register_device()
> since it can connect the device to the vDPA bus, so requests can arrive
> after that call.
>
> So for example vdpasim_net_work(), which uses the net->*_stats variables,
> can be scheduled before they are initialized.
>
> Let's move _vdpa_register_device() to the end of vdpasim_net_dev_add()
> and add a comment to avoid future issues.
>
> Fixes: 0899774cb360 ("vdpa_sim_net: vendor satistics")
> Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>

Acked-by: Jason Wang <jasowang@redhat.com>

This is needed for -stable.

Thanks

> ---
>
> Notes:
>     I don't have a reproducer, but I became aware of this problem while
>     I was changing the buffer allocation.
>
>     In the block device, as soon as the device is registered, the driver
>     sends several requests, and I guess this might happen for the net
>     device as well.
>
>     Thanks,
>     Stefano
>
>  drivers/vdpa/vdpa_sim/vdpa_sim_net.c | 13 +++++++++----
>  1 file changed, 9 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/vdpa/vdpa_sim/vdpa_sim_net.c b/drivers/vdpa/vdpa_sim=
/vdpa_sim_net.c
> index 862f405362de..dfe2ce341803 100644
> --- a/drivers/vdpa/vdpa_sim/vdpa_sim_net.c
> +++ b/drivers/vdpa/vdpa_sim/vdpa_sim_net.c
> @@ -466,16 +466,21 @@ static int vdpasim_net_dev_add(struct vdpa_mgmt_dev=
 *mdev, const char *name,
>
>         vdpasim_net_setup_config(simdev, config);
>
> -       ret =3D _vdpa_register_device(&simdev->vdpa, VDPASIM_NET_VQ_NUM);
> -       if (ret)
> -               goto reg_err;
> -
>         net =3D sim_to_net(simdev);
>
>         u64_stats_init(&net->tx_stats.syncp);
>         u64_stats_init(&net->rx_stats.syncp);
>         u64_stats_init(&net->cq_stats.syncp);
>
> +       /*
> +        * Initialization must be completed before this call, since it ca=
n
> +        * connect the device to the vDPA bus, so requests can arrive aft=
er
> +        * this call.
> +        */
> +       ret =3D _vdpa_register_device(&simdev->vdpa, VDPASIM_NET_VQ_NUM);
> +       if (ret)
> +               goto reg_err;
> +
>         return 0;
>
>  reg_err:
> --
> 2.39.2
>

