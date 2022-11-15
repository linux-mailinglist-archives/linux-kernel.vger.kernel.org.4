Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1BC47629091
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Nov 2022 04:11:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232257AbiKODLh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Nov 2022 22:11:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231602AbiKODLd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Nov 2022 22:11:33 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD061D6E
        for <linux-kernel@vger.kernel.org>; Mon, 14 Nov 2022 19:10:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1668481832;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=LmxdoJVLhZiX760c9V3GI6qvw0JOeU/gMUZ23fFnOlw=;
        b=Jw7MiLS2/NM3Lr42LU7ODvg+YQO4n3C1/2JxFvFZQs/mQKXQGPEI7wymZFDcY3adI6KP42
        grvf4sPrpnyYf7VaC1KGZJ6qRpyj4EJHpwSCpK183hMEuJM/XqIfbtcImCox9lp8KDCFg0
        H7wJFtSY75/3kmA6toGXKfk0BlfOcF8=
Received: from mail-oi1-f199.google.com (mail-oi1-f199.google.com
 [209.85.167.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-184-VqFKE2j3MoSsUZ0p9u89PQ-1; Mon, 14 Nov 2022 22:10:31 -0500
X-MC-Unique: VqFKE2j3MoSsUZ0p9u89PQ-1
Received: by mail-oi1-f199.google.com with SMTP id k26-20020a54469a000000b0035ac1417866so3453892oic.18
        for <linux-kernel@vger.kernel.org>; Mon, 14 Nov 2022 19:10:30 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LmxdoJVLhZiX760c9V3GI6qvw0JOeU/gMUZ23fFnOlw=;
        b=xUvgoKzivO5HkPTWJ46cxDSTGU59qG/v0f3Bi9TM8gve2qkuUbx3wTCSZs3E4RJPTV
         zt06pO0WH/zJvDRu/JaaZqpj5nztnI3WwAqdGnenWFP5EXy/PDDYjU1xS3t0t2HwYOfK
         e05WgNqxLK6UAdV9jkq/yh7sfXtWtNm7Cl0cvgZrFUXyszXtk3OH2MkTtWIUrAKqeB28
         cUs16+cQYgk+I8nUsIamfF+qus+5uOQ0YoRrUNPuLdtmLgddLphfQ98zRKhbCt54/2uK
         qcqNEMZ8WO7t/SkFyjLI7ggAdm/BcCgLazeJgcDqj6cJZj3wJpfjZqvraxDFVcglRGd4
         sk9g==
X-Gm-Message-State: ANoB5pmlL8iTlk0xXv9Oo114UxD+PvgGnOdtMsy0C9QE0JSnHb1jRf9E
        DVgVcS4qHvafbLGBvTiaJpxgFGVD+8TJq2SguauY1yjdA8Og2JSs9a5u/JZFblGYOAH4bK+MH1E
        wYDnc0UD+1pfKyGfauIDVpcv6jWwBD43/kaXIEOCQ
X-Received: by 2002:a05:6830:124d:b0:66c:64d6:1bb4 with SMTP id s13-20020a056830124d00b0066c64d61bb4mr7778953otp.201.1668481830420;
        Mon, 14 Nov 2022 19:10:30 -0800 (PST)
X-Google-Smtp-Source: AA0mqf5nQCT0S5bfmSNmyom39QUjcF9+M0QJTqpWCFA4vh7lW7Nl7FALwgg20OyeHrd9FTYTBTir8WX55xcLO1GjW0c=
X-Received: by 2002:a05:6830:124d:b0:66c:64d6:1bb4 with SMTP id
 s13-20020a056830124d00b0066c64d61bb4mr7778949otp.201.1668481830217; Mon, 14
 Nov 2022 19:10:30 -0800 (PST)
MIME-Version: 1.0
References: <20221114131759.57883-1-elic@nvidia.com> <20221114131759.57883-3-elic@nvidia.com>
In-Reply-To: <20221114131759.57883-3-elic@nvidia.com>
From:   Jason Wang <jasowang@redhat.com>
Date:   Tue, 15 Nov 2022 11:10:19 +0800
Message-ID: <CACGkMEtEKyeYM4AxWY3Zjx9_4sHGGvBL=3hGHgd5y-bnP3EhMg@mail.gmail.com>
Subject: Re: [PATH v2 2/8] vdpa/mlx5: Return error on vlan ctrl commands if
 not supported
To:     Eli Cohen <elic@nvidia.com>
Cc:     mst@redhat.com, linux-kernel@vger.kernel.org,
        virtualization@lists.linux-foundation.org, si-wei.liu@oracle.com,
        eperezma@redhat.com, lulu@redhat.com
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

On Mon, Nov 14, 2022 at 9:18 PM Eli Cohen <elic@nvidia.com> wrote:
>
> Check if VIRTIO_NET_F_CTRL_VLAN is negotiated and return error if
> control VQ command is received.
>
> Signed-off-by: Eli Cohen <elic@nvidia.com>

Acked-by: Jason Wang <jasowang@redhat.com>

Thanks

> ---
>  drivers/vdpa/mlx5/net/mlx5_vnet.c | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/drivers/vdpa/mlx5/net/mlx5_vnet.c b/drivers/vdpa/mlx5/net/mlx5_vnet.c
> index 3fb06dcee943..01da229d22da 100644
> --- a/drivers/vdpa/mlx5/net/mlx5_vnet.c
> +++ b/drivers/vdpa/mlx5/net/mlx5_vnet.c
> @@ -1823,6 +1823,9 @@ static virtio_net_ctrl_ack handle_ctrl_vlan(struct mlx5_vdpa_dev *mvdev, u8 cmd)
>         size_t read;
>         u16 id;
>
> +       if (!(ndev->mvdev.actual_features & BIT_ULL(VIRTIO_NET_F_CTRL_VLAN)))
> +               return status;
> +
>         switch (cmd) {
>         case VIRTIO_NET_CTRL_VLAN_ADD:
>                 read = vringh_iov_pull_iotlb(&cvq->vring, &cvq->riov, &vlan, sizeof(vlan));
> --
> 2.38.1
>

