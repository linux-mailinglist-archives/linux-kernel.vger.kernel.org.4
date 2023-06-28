Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 65BB6740876
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Jun 2023 04:36:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231194AbjF1Cf6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Jun 2023 22:35:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230108AbjF1Cf4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Jun 2023 22:35:56 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7317B129
        for <linux-kernel@vger.kernel.org>; Tue, 27 Jun 2023 19:35:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1687919710;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=dRFSqjQ8goVbgezkdLbcR17PF9Y4JZ+FcQZ0y0X5sGQ=;
        b=UU/q/H2VC/4SgJi41WmXlouT1og/lrf+jpjWfUtkCr6VCEFoawa4j3815XP3VW53j0fLt5
        ZqJA6MGdrKWxCynwf6Qy79pFoKq+A3EOX7CItoRZgbMEMz+fD4Q4D/gNRiV9bliTqwPf4S
        wIW5Q5bsnNsFI1CWZSYHUSSyitrP7vY=
Received: from mail-lf1-f69.google.com (mail-lf1-f69.google.com
 [209.85.167.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-194-y5A-FAOCOCS78EsH7hFkgw-1; Tue, 27 Jun 2023 22:35:09 -0400
X-MC-Unique: y5A-FAOCOCS78EsH7hFkgw-1
Received: by mail-lf1-f69.google.com with SMTP id 2adb3069b0e04-4fb913e8cddso118624e87.0
        for <linux-kernel@vger.kernel.org>; Tue, 27 Jun 2023 19:35:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687919707; x=1690511707;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dRFSqjQ8goVbgezkdLbcR17PF9Y4JZ+FcQZ0y0X5sGQ=;
        b=RaW/yiZAcVVhPtFZfMLdEv8cNArKzTcs8ZegrcWs/xS0bgyI6oaspPCxWuXM90/knU
         /Ta/rFPWMl9YmFmGUUQE3lyWGevCqkfB3CBi2mOSFqlLSqDFPRspE19id2A1ExOKXRJq
         yGBcrfjeyYZjWLQsGo//h/zoLK8AZ+GxulkMGAYX4zrN69zU5N1HBaDrrw87q48FS3HJ
         bRJImUP2iwftnu76CKgQdSPUvKNqbn6OJrFrFQseBFLHsI7j5GpHzb6vTOff3Aba0RkM
         eUqf1GIfvITrum5ymX8BmPa0Be2ytcHo+XX/Yk/cpP20wzYldAq1EGYGC+XMe8vt8Fhl
         Xixg==
X-Gm-Message-State: AC+VfDziHH61bVyiOa4baNOcyafc8Vqchz50HuyLlaRM7dqHNjb5A0I6
        CG6PRDr9fI0ecsFggJF52/UsRY+MfVSkkYLREyTKzMK/sr3M7nA4ykF45LQg23u5Z5Fi1D8mv+Q
        WShcpGzuDMBKxpJdfLAP8LQiWeEri2i0eczFUXUqw
X-Received: by 2002:a05:6512:1284:b0:4f9:5ca0:9334 with SMTP id u4-20020a056512128400b004f95ca09334mr13621876lfs.34.1687919706915;
        Tue, 27 Jun 2023 19:35:06 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ5xylHTvh/QQtP38BdSnzUfN0JkrGyzTKp0POais1RFAfmEoycQEQtV+DQPp1OpEQfGy/r+jgJaS3aGfUM8vzg=
X-Received: by 2002:a05:6512:1284:b0:4f9:5ca0:9334 with SMTP id
 u4-20020a056512128400b004f95ca09334mr13621868lfs.34.1687919706658; Tue, 27
 Jun 2023 19:35:06 -0700 (PDT)
MIME-Version: 1.0
References: <20230627113652.65283-1-maxime.coquelin@redhat.com> <20230627113652.65283-3-maxime.coquelin@redhat.com>
In-Reply-To: <20230627113652.65283-3-maxime.coquelin@redhat.com>
From:   Jason Wang <jasowang@redhat.com>
Date:   Wed, 28 Jun 2023 10:34:55 +0800
Message-ID: <CACGkMEuKyeFoaAfVfBKMv43sdX7GQDQyDLO-+eukg29t+0Ef0g@mail.gmail.com>
Subject: Re: [PATCH v1 2/2] vduse: enable Virtio-net device type
To:     Maxime Coquelin <maxime.coquelin@redhat.com>
Cc:     xieyongji@bytedance.com, mst@redhat.com, david.marchand@redhat.com,
        lulu@redhat.com, linux-kernel@vger.kernel.org,
        virtualization@lists.linux-foundation.org, netdev@vger.kernel.org,
        xuanzhuo@linux.alibaba.com, eperezma@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 27, 2023 at 7:37=E2=80=AFPM Maxime Coquelin
<maxime.coquelin@redhat.com> wrote:
>
> This patch adds Virtio-net device type to the supported
> devices types. Initialization fails if the device does
> not support VIRTIO_F_VERSION_1 feature, in order to
> guarantee the configuration space is read-only.
>
> Signed-off-by: Maxime Coquelin <maxime.coquelin@redhat.com>

Acked-by: Jason Wang <jasowang@redhat.com>

Thanks

> ---
>  drivers/vdpa/vdpa_user/vduse_dev.c | 6 ++++++
>  1 file changed, 6 insertions(+)
>
> diff --git a/drivers/vdpa/vdpa_user/vduse_dev.c b/drivers/vdpa/vdpa_user/=
vduse_dev.c
> index c1c2f4c711ae..89088fa27026 100644
> --- a/drivers/vdpa/vdpa_user/vduse_dev.c
> +++ b/drivers/vdpa/vdpa_user/vduse_dev.c
> @@ -142,6 +142,7 @@ static struct workqueue_struct *vduse_irq_bound_wq;
>
>  static u32 allowed_device_id[] =3D {
>         VIRTIO_ID_BLOCK,
> +       VIRTIO_ID_NET,
>  };
>
>  static inline struct vduse_dev *vdpa_to_vduse(struct vdpa_device *vdpa)
> @@ -1668,6 +1669,10 @@ static bool features_is_valid(struct vduse_dev_con=
fig *config)
>                         (config->features & (1ULL << VIRTIO_BLK_F_CONFIG_=
WCE)))
>                 return false;
>
> +       if ((config->device_id =3D=3D VIRTIO_ID_NET) &&
> +                       !(config->features & (1ULL << VIRTIO_F_VERSION_1)=
))
> +               return false;
> +
>         return true;
>  }
>
> @@ -2023,6 +2028,7 @@ static const struct vdpa_mgmtdev_ops vdpa_dev_mgmtd=
ev_ops =3D {
>
>  static struct virtio_device_id id_table[] =3D {
>         { VIRTIO_ID_BLOCK, VIRTIO_DEV_ANY_ID },
> +       { VIRTIO_ID_NET, VIRTIO_DEV_ANY_ID },
>         { 0 },
>  };
>
> --
> 2.41.0
>

