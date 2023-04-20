Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 919746E8C87
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Apr 2023 10:18:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234388AbjDTISE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Apr 2023 04:18:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234241AbjDTISC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Apr 2023 04:18:02 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F07A3593
        for <linux-kernel@vger.kernel.org>; Thu, 20 Apr 2023 01:17:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1681978633;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=TcCts0FBwg+ql15Zg74annlCvcGEmkJ3XdHdhSrGCSk=;
        b=KU+eaJN/VOwyLatmZKk5fRblmVKSDuQlEeb+MGcqgtra0XsQq7epjl5cfgqOcDQPW7pd5m
        ZHI8GLxV1UY/nmNgtZluNQ4z3N9wUWZamWmsJkbe2qxa8hwa6nCGnLr7oEUf4w3ODGbC/r
        WmRvOxDE4MTfG3FvxVij8pA4Dl+kRnA=
Received: from mail-oi1-f200.google.com (mail-oi1-f200.google.com
 [209.85.167.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-644-UDCj0zOJOQ2dA0EG8UTHsw-1; Thu, 20 Apr 2023 04:17:11 -0400
X-MC-Unique: UDCj0zOJOQ2dA0EG8UTHsw-1
Received: by mail-oi1-f200.google.com with SMTP id 5614622812f47-38e551edfcaso537468b6e.0
        for <linux-kernel@vger.kernel.org>; Thu, 20 Apr 2023 01:17:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681978631; x=1684570631;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TcCts0FBwg+ql15Zg74annlCvcGEmkJ3XdHdhSrGCSk=;
        b=UA0VheUYUtFtKXC79UFSWEMZZp91N4EYYUyY37LqLpad9AC+POItPaC3TVXxx4RDez
         kOwPS13g+imiUtvNIGQymiUAcUFbfjUTlUvh+Wyv05GCyRDjhmghece1e8VfmV0xDTnU
         Eas6ZwzRv9uuR9IfCikDj4826O1CKrM8eG49YzilIK5CICnLXGEqI3tUpyvlJQ4yaCbg
         9s+2v0nvlGeUZTgw9wQz2XjTyL4lIZlXtZvgK4E/mNyv6mJcAFacZ2WtPmHdjwUctIsi
         lxN8Ls6Cd77ZC98sbavfj4xNwKZMcEyfxNa/MWsIr6JZPsVVXyDOfdoKWmlGc9AVumMe
         bzgg==
X-Gm-Message-State: AAQBX9eA6JFYlgFU/htz57HvbDnWeK+uZBrA9K6AaZ0HwwxsXT4IpSLf
        TcAL+qQkZP5bQbzJH8Wr8+d4e9ewcnbDxIpHHeAdtaCRWCuLcgEjiATQB3NrXom8nUvymrrbpZz
        SnFUAPrq/iKu6Qln1/bJAEFWU2pYXBzxW3xq39lLK
X-Received: by 2002:a05:6808:21a9:b0:38c:4c09:562b with SMTP id be41-20020a05680821a900b0038c4c09562bmr591459oib.13.1681978631147;
        Thu, 20 Apr 2023 01:17:11 -0700 (PDT)
X-Google-Smtp-Source: AKy350ZUNbIY/FbCEDeCAH9HwM45oznwUo7Bu6JSaRbc29sYjFlH/2jNMBNyp1Vlh6DNAv8XctEgLNUWW7vLtXzW+X8=
X-Received: by 2002:a05:6808:21a9:b0:38c:4c09:562b with SMTP id
 be41-20020a05680821a900b0038c4c09562bmr591454oib.13.1681978630926; Thu, 20
 Apr 2023 01:17:10 -0700 (PDT)
MIME-Version: 1.0
References: <20230420052026.1883230-1-peili.dev@gmail.com>
In-Reply-To: <20230420052026.1883230-1-peili.dev@gmail.com>
From:   Jason Wang <jasowang@redhat.com>
Date:   Thu, 20 Apr 2023 16:16:59 +0800
Message-ID: <CACGkMEtkkoJ23Me_dXTg0M575=OE2z_stQqwpuHVbZePrKR+uQ@mail.gmail.com>
Subject: Re: [RFC PATCH] Reduce vdpa initialization / startup overhead for ioctl()
To:     peili.dev@gmail.com
Cc:     linux-kernel@vger.kernel.org, eperezma@redhat.com,
        Pei Li <peili@andrew.cmu.edu>
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

On Thu, Apr 20, 2023 at 1:23=E2=80=AFPM <peili.dev@gmail.com> wrote:
>
> From: Pei Li <peili@andrew.cmu.edu>
>
> Signed-off-by: Pei Li <peili@andrew.cmu.edu>

Let's cc maintainers and have a change log for this patch.

More can be found at Documentation/process/submitting-patches.rst.

> ---
>  drivers/vhost/vdpa.c             | 77 +++++++++++++++++++++++++++++++-
>  include/uapi/linux/vhost.h       |  7 +++
>  include/uapi/linux/vhost_types.h |  1 +
>  tools/include/uapi/linux/vhost.h |  6 +++
>  4 files changed, 89 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/vhost/vdpa.c b/drivers/vhost/vdpa.c
> index 7be9d9d8f01c..5419db1dfb7a 100644
> --- a/drivers/vhost/vdpa.c
> +++ b/drivers/vhost/vdpa.c
> @@ -29,7 +29,8 @@ enum {
>         VHOST_VDPA_BACKEND_FEATURES =3D
>         (1ULL << VHOST_BACKEND_F_IOTLB_MSG_V2) |
>         (1ULL << VHOST_BACKEND_F_IOTLB_BATCH) |
> -       (1ULL << VHOST_BACKEND_F_IOTLB_ASID),
> +       (1ULL << VHOST_BACKEND_F_IOTLB_ASID) |
> +       (1ULL << VHOST_BACKEND_F_IOCTL_BATCH),
>  };
>
>  #define VHOST_VDPA_DEV_MAX (1U << MINORBITS)
> @@ -521,6 +522,68 @@ static long vhost_vdpa_resume(struct vhost_vdpa *v)
>         return ops->resume(vdpa);
>  }
>
> +static long vhost_vdpa_vring_ioctl_batch(struct vhost_vdpa *v, unsigned =
int cmd,
> +                                  void __user *argp)
> +{

While at it, I'd rather go with a general method to accept batching of
arbitrary combinations of multiple ioctls.

Thanks

> +       struct vdpa_device *vdpa =3D v->vdpa;
> +       const struct vdpa_config_ops *ops =3D vdpa->config;
> +       struct vhost_virtqueue *vq;
> +       struct vhost_vring_state s;
> +
> +       u32 idx, num, i;
> +       long r;
> +
> +       r =3D get_user(num, ((struct vhost_vring_state __user *)argp)->nu=
m);
> +       if (r < 0) {
> +               return r;
> +       }
> +
> +       num =3D array_index_nospec(num, v->nvqs);
> +
> +       struct vhost_vring_state states[num + 1];
> +
> +       if (copy_from_user(&states, argp, sizeof(states)))
> +               return -EFAULT;
> +
> +       switch (cmd) {
> +       case VHOST_VDPA_SET_VRING_ENABLE_BATCH:
> +               for (i =3D 1; i <=3D num; i++) {
> +                       i =3D array_index_nospec(i, num + 1);
> +                       idx =3D states[i].index;
> +                       if (idx >=3D v->nvqs)
> +                               return -ENOBUFS;
> +
> +                       idx =3D array_index_nospec(idx, v->nvqs);
> +
> +                       ops->set_vq_ready(vdpa, idx, 1);
> +               }
> +               return 0;
> +       case VHOST_VDPA_GET_VRING_GROUP_BATCH:
> +               if (!ops->get_vq_group)
> +                       return -EOPNOTSUPP;
> +
> +               for (i =3D 1; i <=3D num; i++) {
> +                       i =3D array_index_nospec(i, num + 1);
> +                       idx =3D states[i].index;
> +                       if (idx >=3D v->nvqs)
> +                               return -ENOBUFS;
> +                       idx =3D array_index_nospec(idx, v->nvqs);
> +                       states[i].num =3D ops->get_vq_group(vdpa, idx);
> +                       if (states[i].num >=3D vdpa->ngroups)
> +                               return -EIO;
> +               }
> +
> +               if (copy_to_user(argp, &states, sizeof(states)))
> +                       return -EFAULT;
> +
> +               return 0;
> +       default:
> +               r =3D ENOIOCTLCMD;
> +       }
> +
> +       return r;
> +}
> +
>  static long vhost_vdpa_vring_ioctl(struct vhost_vdpa *v, unsigned int cm=
d,
>                                    void __user *argp)
>  {
> @@ -533,6 +596,13 @@ static long vhost_vdpa_vring_ioctl(struct vhost_vdpa=
 *v, unsigned int cmd,
>         u32 idx;
>         long r;
>
> +       switch (cmd) {
> +               case VHOST_VDPA_SET_VRING_ENABLE_BATCH:
> +               // fall through
> +               case VHOST_VDPA_GET_VRING_GROUP_BATCH:
> +                       return vhost_vdpa_vring_ioctl_batch(v, cmd, argp)=
;
> +       }
> +
>         r =3D get_user(idx, (u32 __user *)argp);
>         if (r < 0)
>                 return r;
> @@ -630,7 +700,8 @@ static long vhost_vdpa_unlocked_ioctl(struct file *fi=
lep,
>                         return -EFAULT;
>                 if (features & ~(VHOST_VDPA_BACKEND_FEATURES |
>                                  BIT_ULL(VHOST_BACKEND_F_SUSPEND) |
> -                                BIT_ULL(VHOST_BACKEND_F_RESUME)))
> +                                BIT_ULL(VHOST_BACKEND_F_RESUME) |
> +                                BIT_ULL(VHOST_BACKEND_F_IOCTL_BATCH)))
>                         return -EOPNOTSUPP;
>                 if ((features & BIT_ULL(VHOST_BACKEND_F_SUSPEND)) &&
>                      !vhost_vdpa_can_suspend(v))
> @@ -638,6 +709,7 @@ static long vhost_vdpa_unlocked_ioctl(struct file *fi=
lep,
>                 if ((features & BIT_ULL(VHOST_BACKEND_F_RESUME)) &&
>                      !vhost_vdpa_can_resume(v))
>                         return -EOPNOTSUPP;
> +
>                 vhost_set_backend_features(&v->vdev, features);
>                 return 0;
>         }
> @@ -691,6 +763,7 @@ static long vhost_vdpa_unlocked_ioctl(struct file *fi=
lep,
>                         features |=3D BIT_ULL(VHOST_BACKEND_F_SUSPEND);
>                 if (vhost_vdpa_can_resume(v))
>                         features |=3D BIT_ULL(VHOST_BACKEND_F_RESUME);
> +               features |=3D BIT_ULL(VHOST_BACKEND_F_IOCTL_BATCH);
>                 if (copy_to_user(featurep, &features, sizeof(features)))
>                         r =3D -EFAULT;
>                 break;
> diff --git a/include/uapi/linux/vhost.h b/include/uapi/linux/vhost.h
> index 92e1b700b51c..edb8cc1b22c9 100644
> --- a/include/uapi/linux/vhost.h
> +++ b/include/uapi/linux/vhost.h
> @@ -188,4 +188,11 @@
>   */
>  #define VHOST_VDPA_RESUME              _IO(VHOST_VIRTIO, 0x7E)
>
> +
> +#define VHOST_VDPA_SET_VRING_ENABLE_BATCH      _IOW(VHOST_VIRTIO, 0x7F, =
\
> +                                            struct vhost_vring_state)
> +
> +#define VHOST_VDPA_GET_VRING_GROUP_BATCH       _IOWR(VHOST_VIRTIO, 0x82,=
 \
> +                                             struct vhost_vring_state)
> +
>  #endif
> diff --git a/include/uapi/linux/vhost_types.h b/include/uapi/linux/vhost_=
types.h
> index c5690a8992d8..ea232fbd436a 100644
> --- a/include/uapi/linux/vhost_types.h
> +++ b/include/uapi/linux/vhost_types.h
> @@ -166,4 +166,5 @@ struct vhost_vdpa_iova_range {
>  /* Device can be resumed */
>  #define VHOST_BACKEND_F_RESUME  0x5
>
> +#define VHOST_BACKEND_F_IOCTL_BATCH 0x6
>  #endif
> diff --git a/tools/include/uapi/linux/vhost.h b/tools/include/uapi/linux/=
vhost.h
> index 92e1b700b51c..d0ce141688ba 100644
> --- a/tools/include/uapi/linux/vhost.h
> +++ b/tools/include/uapi/linux/vhost.h
> @@ -188,4 +188,10 @@
>   */
>  #define VHOST_VDPA_RESUME              _IO(VHOST_VIRTIO, 0x7E)
>
> +#define VHOST_VDPA_SET_VRING_ENABLE_BATCH      _IOW(VHOST_VIRTIO, 0x7F, =
\
> +                                            struct vhost_vring_state)
> +
> +#define VHOST_VDPA_GET_VRING_GROUP_BATCH       _IOWR(VHOST_VIRTIO, 0x82,=
 \
> +                                             struct vhost_vring_state)
> +
>  #endif
> --
> 2.25.1
>

