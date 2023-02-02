Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 09A82687600
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Feb 2023 07:43:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229667AbjBBGnr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Feb 2023 01:43:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229609AbjBBGnp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Feb 2023 01:43:45 -0500
Received: from mail-pg1-x533.google.com (mail-pg1-x533.google.com [IPv6:2607:f8b0:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1FEF79610;
        Wed,  1 Feb 2023 22:43:41 -0800 (PST)
Received: by mail-pg1-x533.google.com with SMTP id 78so613457pgb.8;
        Wed, 01 Feb 2023 22:43:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/6YmpgxqYHWFyDMFSqsB9v0H6/GVgLJ+dAGeGtmdKXU=;
        b=TqcYW+qnBnQySIccstphXQJ7F6RG+RhTdRL6onG8HxBk+/1LyjLDeFkjILMrM6cpci
         fwKhHC8v3E635H1GgEEpOgsAY8fd5EwTTQZoApwTQdlG2NvoS/pQQ5eVZJMzx27WkXny
         jP219rxjkY+AGURMMoJi7p5nfFxTSdcnsQPE4lAmvNIZnSTtAhP4q4VW9UnTrRD2CxwA
         +ajf3b24+drBPHmiK/vHe6ptteYKvHxGrNeZELOp9wj7vGHNkYu9kn3DwACQgxpT4/jr
         4lXAEy07w8jHZPiCpm35wHlVsk+yievpKhlUZZkXpJnLXBHQp5gy9HwUajBSO06liDUd
         Yl0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/6YmpgxqYHWFyDMFSqsB9v0H6/GVgLJ+dAGeGtmdKXU=;
        b=hdvlJs23h1mzj3aeIEc/YdCDQkfMTAIgkY1pE5vMc5huqPiJQDjDVRemooHUcBqyhF
         fV6fKSh4YjT7Om3HnM7Lf9LLxEapAMVFbFhXx1XOv10pjKX8vxhIxxwsr+p6zPSfv4uC
         pDl4+BToi7YC9h+g+zzUUdKVvZ/p0JerNBqJK8TYLuT7rcTY6wOLl0czyjhcysjoP6Ef
         4B6nJip5cXnvP97PDX5Q1CzkxtDMjrK2CWcmTZ3xjaxa8QvpecL1p0YqkeuTodlXMxV6
         luPa3SczDPhSLKb2Mif5IKiLkD+wXwA98z7NrjH4aPwdBiW1HzSpnT62/+mUL1dV3oyM
         n/6A==
X-Gm-Message-State: AO0yUKUk0krzpNXcYiWclZYkZQmUcv5q1AYkwh23fM7ZsUadBh0nm61i
        v/F/skHrfmwQvMgsZkaIwDfusQ2W4xEk2cEq3hQ=
X-Google-Smtp-Source: AK7set9FfOkCtldKGBIjsF9+aGWojF7+JU+GG1+akpUPeWmylHhn4anENWMbP9Du0zsSwhjdUW0d9FXr/c2CCMf3i7Q=
X-Received: by 2002:a63:5150:0:b0:4d0:370b:5027 with SMTP id
 r16-20020a635150000000b004d0370b5027mr887411pgl.8.1675320221232; Wed, 01 Feb
 2023 22:43:41 -0800 (PST)
MIME-Version: 1.0
References: <20230202064124.22277-1-zyytlz.wz@163.com>
In-Reply-To: <20230202064124.22277-1-zyytlz.wz@163.com>
From:   Zheng Hacker <hackerzheng666@gmail.com>
Date:   Thu, 2 Feb 2023 14:43:29 +0800
Message-ID: <CAJedcCw6DwgUyt4EDnWcw-xGZ3pRo5gbPqVjG5LM3AmHWGomNw@mail.gmail.com>
Subject: Re: [PATCH v2] scsi: virtio_scsi: Fix poential NULL pointer
 dereference in virtscsi_rescan_hotunplug
To:     Zheng Wang <zyytlz.wz@163.com>
Cc:     mst@redhat.com, jasowang@redhat.com, pbonzini@redhat.com,
        stefanha@redhat.com, jejb@linux.ibm.com,
        martin.petersen@oracle.com,
        virtualization@lists.linux-foundation.org,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        security@kernel.org, alex000young@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

After writing the patch, I found there is an old patch about this issue.
The link is : https://lore.kernel.org/all/ecb2f3c6-af8c-dd43-1dcf-0b5e8a9d8=
848@redhat.com/

Best regards,
Zheng Wang

Zheng Wang <zyytlz.wz@163.com> =E4=BA=8E2023=E5=B9=B42=E6=9C=882=E6=97=A5=
=E5=91=A8=E5=9B=9B 14:42=E5=86=99=E9=81=93=EF=BC=9A
>
> There is no check about the return value of kmalloc in
> virtscsi_rescan_hotunplug. Add the check to avoid use
> of null pointer 'inq_result' in case of the failure
> of kmalloc.
>
> Signed-off-by: Zheng Wang <zyytlz.wz@163.com>
> ---
> v2:
> - add kfree to avoid memory leak
> ---
>  drivers/scsi/virtio_scsi.c | 13 +++++++++++--
>  1 file changed, 11 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/scsi/virtio_scsi.c b/drivers/scsi/virtio_scsi.c
> index d07d24c06b54..a66d8815d738 100644
> --- a/drivers/scsi/virtio_scsi.c
> +++ b/drivers/scsi/virtio_scsi.c
> @@ -330,7 +330,7 @@ static void virtscsi_handle_param_change(struct virti=
o_scsi *vscsi,
>         scsi_device_put(sdev);
>  }
>
> -static void virtscsi_rescan_hotunplug(struct virtio_scsi *vscsi)
> +static int virtscsi_rescan_hotunplug(struct virtio_scsi *vscsi)
>  {
>         struct scsi_device *sdev;
>         struct Scsi_Host *shost =3D virtio_scsi_host(vscsi->vdev);
> @@ -338,6 +338,11 @@ static void virtscsi_rescan_hotunplug(struct virtio_=
scsi *vscsi)
>         int result, inquiry_len, inq_result_len =3D 256;
>         char *inq_result =3D kmalloc(inq_result_len, GFP_KERNEL);
>
> +       if (!inq_result) {
> +               kfree(inq_result);
> +               return -ENOMEM;
> +       }
> +
>         shost_for_each_device(sdev, shost) {
>                 inquiry_len =3D sdev->inquiry_len ? sdev->inquiry_len : 3=
6;
>
> @@ -366,6 +371,7 @@ static void virtscsi_rescan_hotunplug(struct virtio_s=
csi *vscsi)
>         }
>
>         kfree(inq_result);
> +       return 0;
>  }
>
>  static void virtscsi_handle_event(struct work_struct *work)
> @@ -374,12 +380,15 @@ static void virtscsi_handle_event(struct work_struc=
t *work)
>                 container_of(work, struct virtio_scsi_event_node, work);
>         struct virtio_scsi *vscsi =3D event_node->vscsi;
>         struct virtio_scsi_event *event =3D &event_node->event;
> +       int ret =3D 0;
>
>         if (event->event &
>             cpu_to_virtio32(vscsi->vdev, VIRTIO_SCSI_T_EVENTS_MISSED)) {
>                 event->event &=3D ~cpu_to_virtio32(vscsi->vdev,
>                                                    VIRTIO_SCSI_T_EVENTS_M=
ISSED);
> -               virtscsi_rescan_hotunplug(vscsi);
> +               ret =3D virtscsi_rescan_hotunplug(vscsi);
> +               if (ret)
> +                       return;
>                 scsi_scan_host(virtio_scsi_host(vscsi->vdev));
>         }
>
> --
> 2.25.1
>
