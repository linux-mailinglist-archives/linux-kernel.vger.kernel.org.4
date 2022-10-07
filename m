Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 764FE5F7C5C
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Oct 2022 19:38:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229838AbiJGRif (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Oct 2022 13:38:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229799AbiJGRib (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Oct 2022 13:38:31 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF5A6D18DB
        for <linux-kernel@vger.kernel.org>; Fri,  7 Oct 2022 10:38:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1665164310;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=mSmq7YAIgG0OFPktF2tekjkR7mxUEjzv5TQchgD/VEg=;
        b=FhBCeoR4dzXdtktoUPaaH0tdSFLsmiCu14g8lZg16NsAtO0DzQ7vgbW43eoe/QxI9dk5rw
        ZgG4PqXWz4YifUR5ZHw0udR7RgHMVSOHmDONyc1EFt+qG+Fl1eI9qKHr6ZjZHfWRR6LsMt
        eEIyTtS5stwr2qvmN5I0QPoXmYk67B4=
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com
 [209.85.210.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-580-fn4N0JDaN7KovxRByPTsOA-1; Fri, 07 Oct 2022 13:38:27 -0400
X-MC-Unique: fn4N0JDaN7KovxRByPTsOA-1
Received: by mail-pf1-f197.google.com with SMTP id 7-20020a056a00070700b0056264748f0fso3209563pfl.21
        for <linux-kernel@vger.kernel.org>; Fri, 07 Oct 2022 10:38:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mSmq7YAIgG0OFPktF2tekjkR7mxUEjzv5TQchgD/VEg=;
        b=lLR320iBDf3vFq3zFLKE59NiQ3ifopyjzPcpDCjBB9BuIRsPxWjiGEY/g8mTDk1nGX
         0BvNbozR8KUc7q/uvT5ci72hG2HXrBEuAmmm6x7Tpv+9IRYTEGBtbd0RDm2qIiTdXLpW
         bCNPZ9s7tW3EgTDE9uRBBaj31DhCyVRTHlIfkK37bJQZ41NNOh2gvvILt3W2IDu4ykI3
         t+ZkKHOHtwVCqpBJoo+5Qhk7pAPw47eNiYFRweF/TjGqftGBJctrQoSzP4FZ2SXOlF0J
         ijLOu/8M55uTX5iU/Z7sNloCyboWEqWOMVtbrNUbBMzk2XpZDXV43xI9wAVSSx+aWOlm
         byOw==
X-Gm-Message-State: ACrzQf2nJzd1hrFv7UXF83YcasuFDkYsm18C0REfCFRsFR2Mq8sMO04Y
        fpGzR5KwZPTDmaMuOvnt6p8haQwKsFrlszAt3BkHCrz7gX7KslXDMVPlfsOTJzQ0RGTAzIwheuU
        Ig2J56cu8IFjYvHWybGU2PX/Ed+HRpQQCwpum29u/
X-Received: by 2002:a17:90b:1f86:b0:205:d3d0:1931 with SMTP id so6-20020a17090b1f8600b00205d3d01931mr6629516pjb.211.1665164305301;
        Fri, 07 Oct 2022 10:38:25 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM61NiugludrzTm7+yFAwZAJ3P8Ip21UuDCpH1dMKu2OwIgPwwbTgHFTE5G3Rh3hnXCFUPzO5jOqAAQvod5kF6M=
X-Received: by 2002:a17:90b:1f86:b0:205:d3d0:1931 with SMTP id
 so6-20020a17090b1f8600b00205d3d01931mr6629490pjb.211.1665164305024; Fri, 07
 Oct 2022 10:38:25 -0700 (PDT)
MIME-Version: 1.0
References: <20220811084749.83809-1-sgarzare@redhat.com>
In-Reply-To: <20220811084749.83809-1-sgarzare@redhat.com>
From:   Eugenio Perez Martin <eperezma@redhat.com>
Date:   Fri, 7 Oct 2022 19:37:48 +0200
Message-ID: <CAJaqyWf7FEFZTu0eWNCt1Bd0UjpiFdLipq65vWsM=Nhkqhd3fQ@mail.gmail.com>
Subject: Re: [PATCH] vdpa: fix warning casts when building with C=2
To:     Stefano Garzarella <sgarzare@redhat.com>
Cc:     virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 11, 2022 at 10:48 AM Stefano Garzarella <sgarzare@redhat.com> w=
rote:
>
> Use __virtio16_to_cpu() to read `max_virtqueue_pairs` field in
> virtio_net_config since its type is __virtio16.
>
> This silences the following warning when building with `make C=3D2`:
>
>     ../drivers/vdpa/vdpa.c:811:19: warning: cast to restricted __le16
>     ../drivers/vdpa/vdpa.c:811:19: warning: cast from restricted __virtio=
16
>
> Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>

Acked-by: Eugenio P=C3=A9rez <eperezma@redhat.com>

> ---
>  drivers/vdpa/vdpa.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/vdpa/vdpa.c b/drivers/vdpa/vdpa.c
> index c06c02704461..2466d5087478 100644
> --- a/drivers/vdpa/vdpa.c
> +++ b/drivers/vdpa/vdpa.c
> @@ -808,7 +808,7 @@ static int vdpa_dev_net_mq_config_fill(struct vdpa_de=
vice *vdev,
>         if ((features & BIT_ULL(VIRTIO_NET_F_MQ)) =3D=3D 0)
>                 return 0;
>
> -       val_u16 =3D le16_to_cpu(config->max_virtqueue_pairs);
> +       val_u16 =3D __virtio16_to_cpu(true, config->max_virtqueue_pairs);
>         return nla_put_u16(msg, VDPA_ATTR_DEV_NET_CFG_MAX_VQP, val_u16);
>  }
>
> --
> 2.37.1
>

