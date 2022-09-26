Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 730235EAE6B
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Sep 2022 19:44:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231256AbiIZRoZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Sep 2022 13:44:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229552AbiIZRoE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Sep 2022 13:44:04 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3878E5FDE2
        for <linux-kernel@vger.kernel.org>; Mon, 26 Sep 2022 10:12:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1664212346;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Q8TVvcJ30CTD8a6Vgbigv610XMxBdF4giUO+wK1XSR8=;
        b=N4+LHGBIrFQ2AGEOspgUvMr87hlKlpYQ1NFbsqIshHyVZNy8JNsqJbkRe/YXaAx3xh7//K
        vLO4nCSvN7h+butuXk47F+XfPKCdbQnkbxruAhPHdnmhI/SvibxUc+aKmva+j/EVR87du4
        LXBNKShiO3mjV6RWLuOZbTDnPMBSOYo=
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com
 [209.85.214.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-569-g6_SLYsDMWaWo_y1RcTGEA-1; Mon, 26 Sep 2022 13:12:20 -0400
X-MC-Unique: g6_SLYsDMWaWo_y1RcTGEA-1
Received: by mail-pl1-f199.google.com with SMTP id d14-20020a170902cece00b001784b73823aso4754529plg.1
        for <linux-kernel@vger.kernel.org>; Mon, 26 Sep 2022 10:12:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date;
        bh=Q8TVvcJ30CTD8a6Vgbigv610XMxBdF4giUO+wK1XSR8=;
        b=JKENobxQ1okHGFmMsnf6VpPNF/6NHIBMamjrsshVyBa5zHxic8RE1JiTaEguOzxRvn
         RFka53EQvxzU3J/EeYZsXa+FhMOjs5Z7iEP24PxYPLjqEzTEk9CfmsB9C5p0HZmpx7/A
         iPgeVTMhA0E55MatuGshhSD0YBnFEraCzX+TBmOk2LUDlGFQNozYxoBGM1RZas60Jc5X
         GZZEDnmTZ7+QKwFTT0i5MHf8r+1wJ7GAoeR639SuJ2DwXqf20dYYfs64BASgIAQdQ4zO
         QKSOTlPGqqdBG4TMPmbJNmZwN2KXi1FfRKyGl4iGDcVdOtWJUPrz/0G7HFF6VIZ5th5d
         NBnA==
X-Gm-Message-State: ACrzQf11Jy36syTfYFPTKgJz+7sANpCc1cPGOcfdpjlgjZaGAseSUEVc
        a1VhTvPvfJJyVbF2msCUDNXN/42hKrvUS5TV1s9HltcyVMiTJ7eXxtMh+ENd/lSZg7n4rT71MWF
        p3+FpI+cY4xl3x09snKhT/ak/eQdv1CzrMaWSCTdV
X-Received: by 2002:a17:902:ec8d:b0:178:2914:b5a0 with SMTP id x13-20020a170902ec8d00b001782914b5a0mr22773468plg.17.1664212338171;
        Mon, 26 Sep 2022 10:12:18 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM4CLPJb0AOZwFuD2qBQu8m1xJ+Lz7YEIegZoPZ4JhSNcr3g7ocPAelQb54tqCImnfYZiOkWHOhJnJgfwIKDkzI=
X-Received: by 2002:a17:902:ec8d:b0:178:2914:b5a0 with SMTP id
 x13-20020a170902ec8d00b001782914b5a0mr22773447plg.17.1664212337962; Mon, 26
 Sep 2022 10:12:17 -0700 (PDT)
MIME-Version: 1.0
References: <20220817221956.1149183-1-stefanha@redhat.com>
In-Reply-To: <20220817221956.1149183-1-stefanha@redhat.com>
From:   Eugenio Perez Martin <eperezma@redhat.com>
Date:   Mon, 26 Sep 2022 19:11:41 +0200
Message-ID: <CAJaqyWexDNxsEPTdCfSWWvBsCKWtydUEgqxRXn9SAPhuGja66A@mail.gmail.com>
Subject: Re: [PATCH] Documentation: add basic information on vDPA
To:     Stefan Hajnoczi <stefanha@redhat.com>
Cc:     virtualization@lists.linux-foundation.org,
        Jason Wang <jasowang@redhat.com>, linux-kernel@vger.kernel.org,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Stefano Garzarella <sgarzare@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 18, 2022 at 12:20 AM Stefan Hajnoczi <stefanha@redhat.com> wrot=
e:
>
> The vDPA driver framework is largely undocumented. Add a basic page that
> describes what vDPA is, where to get more information, and how to use
> the simulator for testing.
>
> In the future it would be nice to add an overview of the driver API as
> well as comprehensive doc comments.
>
> Cc: "Michael S. Tsirkin" <mst@redhat.com>
> Cc: Jason Wang <jasowang@redhat.com>
> Cc: Stefano Garzarella <sgarzare@redhat.com>
> Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>

If I'm still on time,

Reviewed-by: Eugenio P=C3=A9rez <eperezma@redhat.com>

Thanks!

> ---
>  Documentation/driver-api/index.rst |  1 +
>  Documentation/driver-api/vdpa.rst  | 40 ++++++++++++++++++++++++++++++
>  2 files changed, 41 insertions(+)
>  create mode 100644 Documentation/driver-api/vdpa.rst
>
> diff --git a/Documentation/driver-api/index.rst b/Documentation/driver-ap=
i/index.rst
> index d3a58f77328e..e307779568d4 100644
> --- a/Documentation/driver-api/index.rst
> +++ b/Documentation/driver-api/index.rst
> @@ -103,6 +103,7 @@ available subsections can be seen below.
>     switchtec
>     sync_file
>     tty/index
> +   vdpa
>     vfio-mediated-device
>     vfio
>     vfio-pci-device-specific-driver-acceptance
> diff --git a/Documentation/driver-api/vdpa.rst b/Documentation/driver-api=
/vdpa.rst
> new file mode 100644
> index 000000000000..75c666548e1d
> --- /dev/null
> +++ b/Documentation/driver-api/vdpa.rst
> @@ -0,0 +1,40 @@
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +vDPA - VIRTIO Data Path Acceleration
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +
> +The vDPA driver framework can be used to implement VIRTIO devices that a=
re
> +backed by physical hardware or by software. While the device's data path
> +complies with the VIRTIO specification, the control path is driver-speci=
fic and
> +a netlink interface exists for instantiating devices.
> +
> +vDPA devices can be attached to the kernel's VIRTIO device drivers or ex=
posed
> +to userspace emulators/virtualizers such as QEMU through vhost.
> +
> +The driver API is not documented beyond the doc comments in <linux/vdpa.=
h>. The
> +netlink API is not documented beyond the doc comments in <linux/uapi/vdp=
a.h>.
> +The existing vDPA drivers serve as reference code for those wishing to d=
evelop
> +their own drivers.
> +
> +See https://vdpa-dev.gitlab.io/ for more information about vDPA.
> +
> +Questions can be sent to the virtualization@lists.linux-foundation.org m=
ailing
> +list.
> +
> +Device simulators
> +-----------------
> +
> +There are software vDPA device simulators for testing, prototyping, and
> +development purposes. The simulators do not require physical hardware.
> +
> +Available simulators include:
> +
> +- `vdpa_sim_net` implements a virtio-net loopback device.
> +- `vdpa_sim_blk` implements a memory-backed virtio-blk device.
> +
> +To use `vdpa_sim_blk` through vhost::
> +
> +  # modprobe vhost_vdpa
> +  # modprobe vdpa_sim_blk
> +  # vdpa dev add name vdpa-blk1 mgmtdev vdpasim_blk
> +  ...use /dev/vhost-dev-0...
> +  # vdpa dev del vdpa-blk1
> --
> 2.37.2
>

