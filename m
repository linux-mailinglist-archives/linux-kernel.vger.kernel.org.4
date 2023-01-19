Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C629672FDA
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Jan 2023 05:02:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230252AbjASEBm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Jan 2023 23:01:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229853AbjASDpJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jan 2023 22:45:09 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 235254B4B4
        for <linux-kernel@vger.kernel.org>; Wed, 18 Jan 2023 19:41:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1674099663;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=YyFYcgF+DoIeKq7lb/Kzjd5+kevHUn58LqiJELqcxVU=;
        b=GvH5AvzATFPMle6yEBV0ChBN6ICn3x8H8v2QxKn5Ifp1H+QTqW4FTR1epOU1iDtMRdLEOp
        O8CwQ5uiNYdev6z/X1OT3v3MFD5y53Vn70eyHgQSD7EQMQlzMUsEZiWQkkjB5ZTLyABgF5
        t3Zr6JfTxQ9XlmAAhEdDzWdaSiD92dE=
Received: from mail-oa1-f69.google.com (mail-oa1-f69.google.com
 [209.85.160.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-589-37VcO_zoNp-LNWiL4C6u3Q-1; Wed, 18 Jan 2023 22:20:47 -0500
X-MC-Unique: 37VcO_zoNp-LNWiL4C6u3Q-1
Received: by mail-oa1-f69.google.com with SMTP id 586e51a60fabf-15f2d95f1easo487851fac.2
        for <linux-kernel@vger.kernel.org>; Wed, 18 Jan 2023 19:20:47 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YyFYcgF+DoIeKq7lb/Kzjd5+kevHUn58LqiJELqcxVU=;
        b=cbK4mIQmEZAGRTnAK4AGELDKdNXitSBqvIQ4iOMHiimaAZ7XNBmk56DV5UnFLS1gv0
         4UDylmum7JI4V5qsBO8Tu9hQgYNYYHVL95CMM82IPt8FFgDhf6nYcSj63YoADU92mzw6
         302WQM3/Y4COx5pyjCDRg9W/9BLfOAxeNKoHldwafcSuhG50obFo5b0kVJF/6awogA/b
         PLinacCZyCH1kj7MMmowBKCCXXHr63Hyl1IVMzd/SimHH3Zkvcvt9AZKn0kIQgcNsXnw
         rfv23/Kd2W9sQ4pcIHgj5DDqO0THSJUKr4TRz9tmcimsG8AHjno1khVcMMwUSs2E0Jxy
         6LLQ==
X-Gm-Message-State: AFqh2kqdkZhKClYN212JROPWrNaGSYA6FgsQraeduGNnHRRxddLEHYCB
        +ARYeSZL8GpnMAwPPRajd2pow/PQRy5FqTAwkoRqylu1GrLBui62KbPzz+NLX/sfiONDPHksEFz
        OVzIEgMkhfdMjm2EaUUte3W0UgiIyOQju1RNDmGmz
X-Received: by 2002:a05:6870:6a91:b0:144:a97b:1ae2 with SMTP id mv17-20020a0568706a9100b00144a97b1ae2mr593133oab.35.1674098447066;
        Wed, 18 Jan 2023 19:20:47 -0800 (PST)
X-Google-Smtp-Source: AMrXdXtfPFuvSb1t3TeMovFK0J7New906+HRjOCUmcjVVqeG2vnLs69/M1W/0HSaALtkgqmNSJQUc+ZcxfnZmvsy7G8=
X-Received: by 2002:a05:6870:6a91:b0:144:a97b:1ae2 with SMTP id
 mv17-20020a0568706a9100b00144a97b1ae2mr593124oab.35.1674098446850; Wed, 18
 Jan 2023 19:20:46 -0800 (PST)
MIME-Version: 1.0
References: <20230118164359.1523760-1-eperezma@redhat.com> <20230118164359.1523760-3-eperezma@redhat.com>
In-Reply-To: <20230118164359.1523760-3-eperezma@redhat.com>
From:   Jason Wang <jasowang@redhat.com>
Date:   Thu, 19 Jan 2023 11:20:35 +0800
Message-ID: <CACGkMEtq_ZOoLaS=vGYPZUc45oP8ENa+5H1KVCF1NS=-SwuPQw@mail.gmail.com>
Subject: Re: [PATCH 2/2] vringh: fetch used_idx from vring at vringh_init_iotlb
To:     =?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>
Cc:     mst@redhat.com, leiyang@redhat.com,
        Laurent Vivier <lvivier@redhat.com>, sgarzare@redhat.com,
        Zhu Lingshan <lingshan.zhu@intel.com>,
        virtualization@lists.linux-foundation.org, si-wei.liu@oracle.com,
        linux-kernel@vger.kernel.org, lulu@redhat.com,
        Gautam Dawar <gdawar@xilinx.com>, alvaro.karsz@solid-run.com
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

On Thu, Jan 19, 2023 at 12:44 AM Eugenio P=C3=A9rez <eperezma@redhat.com> w=
rote:
>
> Starting from an used_idx different than 0 is needed in use cases like
> virtual machine migration.  Not doing so and letting the caller set an
> avail idx different than 0 causes destination device to try to use old
> buffers that source driver already recover and are not available
> anymore.
>
> While callers like vdpa_sim set avail_idx directly it does not set
> used_idx.  Instead of let the caller do the assignment, fetch it from
> the guest at initialization like vhost-kernel do.
>
> To perform the same at vring_kernel_init and vring_user_init is left for
> the future.
>
> Signed-off-by: Eugenio P=C3=A9rez <eperezma@redhat.com>
> ---
>  drivers/vhost/vringh.c | 25 +++++++++++++++++++++++--
>  1 file changed, 23 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/vhost/vringh.c b/drivers/vhost/vringh.c
> index 33eb941fcf15..0eed825197f2 100644
> --- a/drivers/vhost/vringh.c
> +++ b/drivers/vhost/vringh.c
> @@ -1301,6 +1301,17 @@ static inline int putused_iotlb(const struct vring=
h *vrh,
>         return 0;
>  }
>
> +/**
> + * vringh_update_used_idx - fetch used idx from driver's used split vrin=
g
> + * @vrh: The vring.
> + *
> + * Returns -errno or 0.
> + */
> +static inline int vringh_update_used_idx(struct vringh *vrh)
> +{
> +       return getu16_iotlb(vrh, &vrh->last_used_idx, &vrh->vring.used->i=
dx);
> +}
> +
>  /**
>   * vringh_init_iotlb - initialize a vringh for a ring with IOTLB.
>   * @vrh: the vringh to initialize.
> @@ -1319,8 +1330,18 @@ int vringh_init_iotlb(struct vringh *vrh, u64 feat=
ures,
>                       struct vring_avail *avail,
>                       struct vring_used *used)
>  {

While at this, I wonder if it's better to have a dedicated parameter
for last_avail_idx?

> -       return vringh_init_kern(vrh, features, num, weak_barriers,
> -                               desc, avail, used);
> +       int r =3D vringh_init_kern(vrh, features, num, weak_barriers, des=
c,
> +                                avail, used);
> +
> +       if (r !=3D 0)
> +               return r;
> +
> +       /* Consider the ring not initialized */
> +       if ((void *)desc =3D=3D used)
> +               return 0;

I don't understand when we can get this (actually it should be a bug
of the caller).

Thanks

> +
> +       return vringh_update_used_idx(vrh);
> +
>  }
>  EXPORT_SYMBOL(vringh_init_iotlb);
>
> --
> 2.31.1
>

