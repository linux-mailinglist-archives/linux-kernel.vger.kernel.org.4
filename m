Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 39DA76E3E38
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Apr 2023 05:35:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230063AbjDQDfN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 16 Apr 2023 23:35:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230288AbjDQDef (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Apr 2023 23:34:35 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8CA1F3C01
        for <linux-kernel@vger.kernel.org>; Sun, 16 Apr 2023 20:32:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1681702323;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Ot4mAzk1dD+VO6IKPj86pu2eAQn+6tiF/RKoyglMHgI=;
        b=UZnWxHo4sA0NIvSoynBwRyocZ9WTNn0L+0gJhDsPIytg6ct6IaFMbqV7LgsrU+yeN9tfac
        kNZvTxP6Bc0YwKAOfF+x6M2Iy6sD3O+vDfIXP61wyNMq2UJ9Bq6wNUKP7xr9Zd8fbKb6qG
        Fku+CpW9zRYXlt42HxtrkEO9As6VJOs=
Received: from mail-oa1-f69.google.com (mail-oa1-f69.google.com
 [209.85.160.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-168-Ka8-8ubdMpK90UOnqr3OEQ-1; Sun, 16 Apr 2023 23:32:02 -0400
X-MC-Unique: Ka8-8ubdMpK90UOnqr3OEQ-1
Received: by mail-oa1-f69.google.com with SMTP id 586e51a60fabf-1878ffe6eddso6164018fac.13
        for <linux-kernel@vger.kernel.org>; Sun, 16 Apr 2023 20:32:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681702321; x=1684294321;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ot4mAzk1dD+VO6IKPj86pu2eAQn+6tiF/RKoyglMHgI=;
        b=aB9cpDRdyenh+d3pJeAti2BedhAg+7d5PK6gngQdLWnUU7hgYAlj7otWQJ/uPCc7n6
         CFfeq7DukP+moS4lsDN+hKuMMSapC0bb+0anTbCv/ASew+MrrEuLX64OuXzz6ou2ugKp
         S1162elNLwJVULa+YZzVlDRD3y8+hchO1YZk0adTL2HPZx1wHitS3KDtD+srTlbc15In
         4BCdUeTgUEfDLvG/08D2/Gl4f09JxEBMH0B5Osep1Ni8LuYrJwQJJ1bz/7R+sNGaw87c
         O+9EHsS/OgZlnfVZhtiMbGZrQWNngpMkEWA1xeLWixnSNBRX5ZTVOu5ErseTabrXBaoy
         rF+w==
X-Gm-Message-State: AAQBX9c4LdvMgeHCfQjL0b62LkghpGWu4Wj3Nr2ES0O4RStl2ikiit1d
        /ddE4DaAYeHaTVM4ymBhh4WfNtnMXgYKjARj+RG01trFmYn6+xZSlinoUUep4RjQyQpxA9AykU0
        FW2KQ8+iN3oeC1oWCS+XWLJfIAyoPBueP0eS0lmdu7aIkqXm6/GA=
X-Received: by 2002:a05:6870:b605:b0:184:5497:53e6 with SMTP id cm5-20020a056870b60500b00184549753e6mr4511733oab.3.1681702321610;
        Sun, 16 Apr 2023 20:32:01 -0700 (PDT)
X-Google-Smtp-Source: AKy350a1OSW7Q3WyPX8YhgEEOJFU2G0q8lgnrVvLOt3ciyV8fmwl1u54r2QQlagOxp9oJTR/pFZt15KWbVevkS6IVh0=
X-Received: by 2002:a05:6870:b605:b0:184:5497:53e6 with SMTP id
 cm5-20020a056870b60500b00184549753e6mr4511728oab.3.1681702321435; Sun, 16 Apr
 2023 20:32:01 -0700 (PDT)
MIME-Version: 1.0
References: <20230415021959.197891-1-lulu@redhat.com>
In-Reply-To: <20230415021959.197891-1-lulu@redhat.com>
From:   Jason Wang <jasowang@redhat.com>
Date:   Mon, 17 Apr 2023 11:31:50 +0800
Message-ID: <CACGkMEtu=Xiqc1JJrRVZ40dGsP8su_USq3ZJAWKgb4QaA4F5xw@mail.gmail.com>
Subject: Re: [PATCH v2] vhost_vdpa: fix unmap process in no-batch mode
To:     Cindy Lu <lulu@redhat.com>
Cc:     mst@redhat.com, virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Apr 15, 2023 at 10:20=E2=80=AFAM Cindy Lu <lulu@redhat.com> wrote:
>
> While using the no-batch mode with vIOMMU enabled
> Qemu will call a large memory to unmap. Much larger than the memory
> mapped to the kernel. The iotlb is NULL in the kernel and will return fai=
l.

This patch looks good but I don't understand the above. I think it's
better to explain why such large unmap will lead to this error:

Is it a batched unmap or a [0, ULONG_MAX] map? How could we end up the NULL=
?

> Which causes failure.
> To fix this, we will not remove the AS while the iotlb->nmaps is 0.
> This will free in the vhost_vdpa_clean
>
> Signed-off-by: Cindy Lu <lulu@redhat.com>

Do we need a fix tag and does it need to go for -stable?

Thanks

> ---
>  drivers/vhost/vdpa.c | 8 +-------
>  1 file changed, 1 insertion(+), 7 deletions(-)
>
> diff --git a/drivers/vhost/vdpa.c b/drivers/vhost/vdpa.c
> index 7be9d9d8f01c..74c7d1f978b7 100644
> --- a/drivers/vhost/vdpa.c
> +++ b/drivers/vhost/vdpa.c
> @@ -851,11 +851,7 @@ static void vhost_vdpa_unmap(struct vhost_vdpa *v,
>                 if (!v->in_batch)
>                         ops->set_map(vdpa, asid, iotlb);
>         }
> -       /* If we are in the middle of batch processing, delay the free
> -        * of AS until BATCH_END.
> -        */
> -       if (!v->in_batch && !iotlb->nmaps)
> -               vhost_vdpa_remove_as(v, asid);
> +
>  }
>
>  static int vhost_vdpa_va_map(struct vhost_vdpa *v,
> @@ -1112,8 +1108,6 @@ static int vhost_vdpa_process_iotlb_msg(struct vhos=
t_dev *dev, u32 asid,
>                 if (v->in_batch && ops->set_map)
>                         ops->set_map(vdpa, asid, iotlb);
>                 v->in_batch =3D false;
> -               if (!iotlb->nmaps)
> -                       vhost_vdpa_remove_as(v, asid);
>                 break;
>         default:
>                 r =3D -EINVAL;
> --
> 2.34.3
>

