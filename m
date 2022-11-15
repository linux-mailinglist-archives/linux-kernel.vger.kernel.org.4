Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 222876294AF
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Nov 2022 10:45:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238102AbiKOJpl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Nov 2022 04:45:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238043AbiKOJpe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Nov 2022 04:45:34 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0783220187
        for <linux-kernel@vger.kernel.org>; Tue, 15 Nov 2022 01:44:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1668505478;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=0vWBmmZ+MaaTNoor+4JgOmz7dmr0qFnAhYd6s3lBFUI=;
        b=ZHZqkVd4gsKRoG+w36HetlWKjamTVqqz5J1R8YdUnfALBaAIuWel6ypBDXFQ4yd7WC/WGM
        /GJbn9PaYw59t49u48P5jqFlX0d3EvZO38M+ccFwYDjDjUTJBScZ3PB4b6DPYig1Q4sMcA
        AC1Dm7F8CUTRFk0p3k4ChxHhlbjoyuU=
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com
 [209.85.210.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-590-9LUjXmFMP0W1OEIAHwU-0Q-1; Tue, 15 Nov 2022 04:44:35 -0500
X-MC-Unique: 9LUjXmFMP0W1OEIAHwU-0Q-1
Received: by mail-pf1-f200.google.com with SMTP id cj8-20020a056a00298800b0056cee8a0cf8so7471002pfb.9
        for <linux-kernel@vger.kernel.org>; Tue, 15 Nov 2022 01:44:34 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0vWBmmZ+MaaTNoor+4JgOmz7dmr0qFnAhYd6s3lBFUI=;
        b=YMluWSM7D4ajp1bomNRqqGFECDhyxq0UMciiumSOYjlFmEy8Uw4avd9bHVz4nBm8Ag
         glyR/08oaEbenNLPcrNeXPUnmk+ZyhX/C+RQE0JxoLn/UMav6hQvSi/CJu0ogpvl4wKU
         FeWcGuqzh6j+OqK8bk0h3M3t3kIXB0USa2lwOenFVnYGMaPXklXXikhuuk4IQLxa1cnK
         /1sYQSIPpdmAgduCcdy3AuMeeVGeRNylOqY0qabMhIAQs3oNbUCxIyy5znFLyXoNaPdf
         POu7R0mTqKzkZ0GF/7euv2FGMkZXUBdEnW8oMLC/J1k3sOuUM6YGkZCxA82kWlaklii3
         MiSQ==
X-Gm-Message-State: ANoB5pkSRTaAOWMrE/aw0mauuwFD5sX1+5XvpE5sU7Y7LsNXTdtzAd10
        dkE3zjUPdUY4YdHUKTWqnz/dKWE3cMlzddCaAm6i0+qjaXQ26NnpL12t7TVpx+gkEbXDmXDizxi
        5mLkY8B4y3O+b6tVTcI/l+AyRwk3xYTaxBKBvvE7q
X-Received: by 2002:a63:942:0:b0:43c:b43f:5228 with SMTP id 63-20020a630942000000b0043cb43f5228mr16064361pgj.58.1668505474022;
        Tue, 15 Nov 2022 01:44:34 -0800 (PST)
X-Google-Smtp-Source: AA0mqf43WRfjzPq1IwIinTobpP8n7DU67GGyyPyGFWJnRVW1tpkA7R3+pueZU5O0fWJQkQzgWakieDpZzmd8cv37euU=
X-Received: by 2002:a63:942:0:b0:43c:b43f:5228 with SMTP id
 63-20020a630942000000b0043cb43f5228mr16064342pgj.58.1668505473833; Tue, 15
 Nov 2022 01:44:33 -0800 (PST)
MIME-Version: 1.0
References: <20221114131759.57883-1-elic@nvidia.com> <20221114131759.57883-3-elic@nvidia.com>
In-Reply-To: <20221114131759.57883-3-elic@nvidia.com>
From:   Eugenio Perez Martin <eperezma@redhat.com>
Date:   Tue, 15 Nov 2022 10:43:58 +0100
Message-ID: <CAJaqyWdYuFJ8nvc2YuoFMO=dj_GVMSghj016jU-X75WvXPXL2g@mail.gmail.com>
Subject: Re: [PATH v2 2/8] vdpa/mlx5: Return error on vlan ctrl commands if
 not supported
To:     Eli Cohen <elic@nvidia.com>
Cc:     mst@redhat.com, jasowang@redhat.com, linux-kernel@vger.kernel.org,
        virtualization@lists.linux-foundation.org, si-wei.liu@oracle.com,
        lulu@redhat.com
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

On Mon, Nov 14, 2022 at 2:18 PM Eli Cohen <elic@nvidia.com> wrote:
>
> Check if VIRTIO_NET_F_CTRL_VLAN is negotiated and return error if
> control VQ command is received.
>
> Signed-off-by: Eli Cohen <elic@nvidia.com>

Acked-by: Eugenio P=C3=A9rez <eperezma@redhat.com>

> ---
>  drivers/vdpa/mlx5/net/mlx5_vnet.c | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/drivers/vdpa/mlx5/net/mlx5_vnet.c b/drivers/vdpa/mlx5/net/ml=
x5_vnet.c
> index 3fb06dcee943..01da229d22da 100644
> --- a/drivers/vdpa/mlx5/net/mlx5_vnet.c
> +++ b/drivers/vdpa/mlx5/net/mlx5_vnet.c
> @@ -1823,6 +1823,9 @@ static virtio_net_ctrl_ack handle_ctrl_vlan(struct =
mlx5_vdpa_dev *mvdev, u8 cmd)
>         size_t read;
>         u16 id;
>
> +       if (!(ndev->mvdev.actual_features & BIT_ULL(VIRTIO_NET_F_CTRL_VLA=
N)))
> +               return status;
> +
>         switch (cmd) {
>         case VIRTIO_NET_CTRL_VLAN_ADD:
>                 read =3D vringh_iov_pull_iotlb(&cvq->vring, &cvq->riov, &=
vlan, sizeof(vlan));
> --
> 2.38.1
>

