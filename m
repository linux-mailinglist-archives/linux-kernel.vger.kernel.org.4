Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE4DE653D2B
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Dec 2022 09:51:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235160AbiLVIvh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Dec 2022 03:51:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235042AbiLVIva (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Dec 2022 03:51:30 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E52FB07
        for <linux-kernel@vger.kernel.org>; Thu, 22 Dec 2022 00:50:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1671699048;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=rihYLtMNexBi4ea2dVCxoV+JrDk3iR9PPcCTgjqYYNs=;
        b=W3vkOwbPutpLhyEZnePiaEiYRKSYFx3KpKsFUbYdMJsPGD1LA5FuP5kREEqzyMtJNxNhBQ
        2m5L/lnXe/oFK4nS9aA9MaAl2NeQw+cd5PSZG4aAn/Pj5mQ1SCg2/tTt6vPDKWFmZ15isp
        VUSXugceer9CRvn4oMQIjTd++J+EYpo=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-204-il0yr_5sP4ivvV72oo3l6g-1; Thu, 22 Dec 2022 03:50:46 -0500
X-MC-Unique: il0yr_5sP4ivvV72oo3l6g-1
Received: by mail-ed1-f72.google.com with SMTP id s13-20020a056402520d00b0046c78433b54so1058861edd.16
        for <linux-kernel@vger.kernel.org>; Thu, 22 Dec 2022 00:50:46 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rihYLtMNexBi4ea2dVCxoV+JrDk3iR9PPcCTgjqYYNs=;
        b=uyhPwqzJAOqQxpAhChqoKa00k/16wWiUlbD8cSizYw176/C6MLm/CBL6UdlpCSl9fr
         39Tej3GVscuuJpmTiCDhqCMyEQEG6RZMpCP+5BSfeRynQBYSeU9q0odpaTVDHtjMdCCn
         nz3NC85Lsir3ZvaAo+1yBjSwHXKqyzhbPj5v+B40Z5ejAdvwjyPoYOiL56dR/65du8p7
         iqFbC2h+7kZeNzXoSL4xxAWoXGdpgMKojUfsbiNCG+glT2ILhMNcIQQexAopXQGlbnvH
         +W5UHBrTNr6Ijp4qP3DSlwqGBPpAAbUmjhiB9C+HCBscX6/r9im+DAbp4ATOm58d54ku
         3Msg==
X-Gm-Message-State: AFqh2kq8sGdR4qHZP5ONJeV6o5YtggeK9IDXRc1hbKyaxSa2sJY1iorv
        oCwn8aiuRbEh3VFs7/3E9kn61hxZu6tV/CGnn4bs4t44Dmt1T8IVUQKkyS/T9ZOk0jcnhgyt6fB
        PkeV/9EphMHvyHjbtlJen9pRBBIJ29VxSJQtv26VE
X-Received: by 2002:a05:6402:a56:b0:479:4078:401a with SMTP id bt22-20020a0564020a5600b004794078401amr586697edb.92.1671699045190;
        Thu, 22 Dec 2022 00:50:45 -0800 (PST)
X-Google-Smtp-Source: AMrXdXsbBSXswfsPwLDaQxFpURZIxMsQ0jJiG8gfU8jOACaUIjDzA/NpcIZY60My8vepZynF4yJoUc6iIP8B1nmK9hs=
X-Received: by 2002:a05:6402:a56:b0:479:4078:401a with SMTP id
 bt22-20020a0564020a5600b004794078401amr586695edb.92.1671699045045; Thu, 22
 Dec 2022 00:50:45 -0800 (PST)
MIME-Version: 1.0
References: <20221222050052.20785-1-jasowang@redhat.com>
In-Reply-To: <20221222050052.20785-1-jasowang@redhat.com>
From:   Eugenio Perez Martin <eperezma@redhat.com>
Date:   Thu, 22 Dec 2022 09:50:08 +0100
Message-ID: <CAJaqyWc5WtnP1K0JALvBV7Q_aiD5id=gjAC+n+hKLBVJaePx-Q@mail.gmail.com>
Subject: Re: [PATCH V2 0/4] Vendor stats support in vdpasim_net
To:     Jason Wang <jasowang@redhat.com>
Cc:     mst@redhat.com, sgarzare@redhat.com,
        virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org
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

On Thu, Dec 22, 2022 at 6:01 AM Jason Wang <jasowang@redhat.com> wrote:
>
> Hi All:
>
> This series implements vendor stats in vdpasim_net. Please review.
>
> Thanks
>

Apart from the commented blanks,

Acked-by: Eugenio P=C3=A9rez <eperezma@redhat.com>

Thanks!

> Changes since V1:
> - typo fixes
> - move the duplicated get_vendor_vq_stats() in
>   vdpasim_batch_config_ops to vdpa_sim_config_ops
> - use -EOPNOTSUPP instead of -EINVAL in vdpasim_get_vq_stats
> - introdce a dedicated variable to record the successful cvq request
>   and track the number of requests correctly
>
> Jason Wang (4):
>   vdpa_sim: switch to use __vdpa_alloc_device()
>   vdpasim: customize allocation size
>   vdpa_sim: support vendor statistics
>   vdpa_sim_net: vendor satistics
>
>  drivers/vdpa/vdpa_sim/vdpa_sim.c     |  33 +++-
>  drivers/vdpa/vdpa_sim/vdpa_sim.h     |   4 +
>  drivers/vdpa/vdpa_sim/vdpa_sim_blk.c |   1 +
>  drivers/vdpa/vdpa_sim/vdpa_sim_net.c | 221 ++++++++++++++++++++++++++-
>  4 files changed, 248 insertions(+), 11 deletions(-)
>
> --
> 2.25.1
>

