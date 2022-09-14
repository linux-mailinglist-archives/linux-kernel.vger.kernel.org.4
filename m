Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4AAE85B805F
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Sep 2022 06:44:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229679AbiINEok (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Sep 2022 00:44:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229461AbiINEoh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Sep 2022 00:44:37 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 485E7BE1A
        for <linux-kernel@vger.kernel.org>; Tue, 13 Sep 2022 21:44:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1663130675;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=0uP/dYDukfABPX5tOREjXIZp/drleC3gX1NDy3hW6L4=;
        b=G/Xe1R5mOVrc8bWMFTur2uGsZWzk9uS1nwE+K/bhmiMkIvhUJLn1BnuGykl5avluEllIuu
        64Sjcl3buVnRlO86S7Jb1sDDiAA1Tu2o6Sbi83GOALRLOj31bbAzmsHiyIbhSXjXmkNuke
        +e467RlKAkICWbUS8y1NlEPFqldHFmI=
Received: from mail-vk1-f198.google.com (mail-vk1-f198.google.com
 [209.85.221.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-280--55iJauWPqW5ZUmFMT5LfA-1; Wed, 14 Sep 2022 00:44:26 -0400
X-MC-Unique: -55iJauWPqW5ZUmFMT5LfA-1
Received: by mail-vk1-f198.google.com with SMTP id n205-20020a1fa4d6000000b0037d1d4d3237so3176138vke.6
        for <linux-kernel@vger.kernel.org>; Tue, 13 Sep 2022 21:44:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=0uP/dYDukfABPX5tOREjXIZp/drleC3gX1NDy3hW6L4=;
        b=6ZgNCdEk/4JzXCjccu22cfPUIXHWVs442xFZiI7HPsu3gkzBB/OgH2ZPEUfYu9XjqO
         pM8e5mkKDS7hiroDy+LQvw4uKfBAelhXnf5TtC1VXKYZYFQdmAf8JwuYPEQWTrnjQnY6
         IY64TEKX5sQxlYgldUy7OIidQdot29dcmrDyY4fSkG+xNIZYHtr7Fa1eSZXpKNipoSPN
         8MdXO/murjNDEdy6CJNHGL3CdSWx+vpH/vuwPwkm+Qc4pZ/gKjLHWrjm+1eOZghwVs/t
         zYO+o/BhRkUCiQQcoICdqWgSD8BWqCUNBjv4miG5N0+6CIeAGSfHbhrMyElGc/0dAPWt
         XJbQ==
X-Gm-Message-State: ACgBeo2d4ciWSUDZEdB7BHP5SpuS4nfPyFTicBincVPKN2xQV9o75W59
        Se87pOjphRM9koxeLHSr11xAWNA2DJtGQGG9Xs9LmKwi/5OYmRO/AHkHd3SCGfCI9DE4GCDIuFD
        2MYJ9Ge6QFWZ/IOWLuOtM0MzdlqnEgB8I3trDwUdB
X-Received: by 2002:a1f:108:0:b0:3a2:3f56:967b with SMTP id 8-20020a1f0108000000b003a23f56967bmr4435940vkb.32.1663130665639;
        Tue, 13 Sep 2022 21:44:25 -0700 (PDT)
X-Google-Smtp-Source: AA6agR7UhudjBls/ikR/JKeDLGFvRxTVDmrJAnM5qjcacsqhaaksSBrx9zugp57J3hVHXHMLi7JBQ5TWqQsryli5FPk=
X-Received: by 2002:a1f:108:0:b0:3a2:3f56:967b with SMTP id
 8-20020a1f0108000000b003a23f56967bmr4435935vkb.32.1663130665389; Tue, 13 Sep
 2022 21:44:25 -0700 (PDT)
MIME-Version: 1.0
References: <20220912125019.833708-1-elic@nvidia.com>
In-Reply-To: <20220912125019.833708-1-elic@nvidia.com>
From:   Jason Wang <jasowang@redhat.com>
Date:   Wed, 14 Sep 2022 12:44:14 +0800
Message-ID: <CACGkMEsMm8nfsFNa=B-Zv-fukNex+M8vVoKOfjpr-TxgKXnVhA@mail.gmail.com>
Subject: Re: [PATCH] vdpa/mlx5: Fix MQ to support non power of two num queues
To:     Eli Cohen <elic@nvidia.com>
Cc:     mst <mst@redhat.com>, eperezma <eperezma@redhat.com>,
        Si-Wei Liu <si-wei.liu@oracle.com>,
        virtualization <virtualization@lists.linux-foundation.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 12, 2022 at 8:50 PM Eli Cohen <elic@nvidia.com> wrote:
>
> RQT objects require that a power of two value be configured for both
> rqt_max_size and rqt_actual size.
>
> For create_rqt, make sure to round up to the power of two the value of
> given by the user who created the vdpa device and given by
> ndev->rqt_size. The actual size is also rounded up to the power of two
> using the current number of VQs given by ndev->cur_num_vqs.
>
> Same goes with modify_rqt where we need to make sure act size is power
> of two based on the new number of QPs.
>
> Without this patch, attempt to create a device with non power of two QPs
> would result in error from firmware.
>
> Fixes: 52893733f2c5 ("vdpa/mlx5: Add multiqueue support")
> Signed-off-by: Eli Cohen <elic@nvidia.com>

Acked-by: Jason Wang <jasowang@redhat.com>

> ---
>  drivers/vdpa/mlx5/net/mlx5_vnet.c | 17 ++++++++++-------
>  1 file changed, 10 insertions(+), 7 deletions(-)
>
> diff --git a/drivers/vdpa/mlx5/net/mlx5_vnet.c b/drivers/vdpa/mlx5/net/mlx5_vnet.c
> index ed100a35e596..90913365def4 100644
> --- a/drivers/vdpa/mlx5/net/mlx5_vnet.c
> +++ b/drivers/vdpa/mlx5/net/mlx5_vnet.c
> @@ -1320,6 +1320,8 @@ static void teardown_vq(struct mlx5_vdpa_net *ndev, struct mlx5_vdpa_virtqueue *
>
>  static int create_rqt(struct mlx5_vdpa_net *ndev)
>  {
> +       int rqt_table_size = roundup_pow_of_two(ndev->rqt_size);
> +       int act_sz = roundup_pow_of_two(ndev->cur_num_vqs / 2);
>         __be32 *list;
>         void *rqtc;
>         int inlen;
> @@ -1327,7 +1329,7 @@ static int create_rqt(struct mlx5_vdpa_net *ndev)
>         int i, j;
>         int err;
>
> -       inlen = MLX5_ST_SZ_BYTES(create_rqt_in) + ndev->rqt_size * MLX5_ST_SZ_BYTES(rq_num);
> +       inlen = MLX5_ST_SZ_BYTES(create_rqt_in) + rqt_table_size * MLX5_ST_SZ_BYTES(rq_num);
>         in = kzalloc(inlen, GFP_KERNEL);
>         if (!in)
>                 return -ENOMEM;
> @@ -1336,12 +1338,12 @@ static int create_rqt(struct mlx5_vdpa_net *ndev)
>         rqtc = MLX5_ADDR_OF(create_rqt_in, in, rqt_context);
>
>         MLX5_SET(rqtc, rqtc, list_q_type, MLX5_RQTC_LIST_Q_TYPE_VIRTIO_NET_Q);
> -       MLX5_SET(rqtc, rqtc, rqt_max_size, ndev->rqt_size);
> +       MLX5_SET(rqtc, rqtc, rqt_max_size, rqt_table_size);
>         list = MLX5_ADDR_OF(rqtc, rqtc, rq_num[0]);
> -       for (i = 0, j = 0; i < ndev->rqt_size; i++, j += 2)
> +       for (i = 0, j = 0; i < act_sz; i++, j += 2)
>                 list[i] = cpu_to_be32(ndev->vqs[j % ndev->cur_num_vqs].virtq_id);
>
> -       MLX5_SET(rqtc, rqtc, rqt_actual_size, ndev->rqt_size);
> +       MLX5_SET(rqtc, rqtc, rqt_actual_size, act_sz);
>         err = mlx5_vdpa_create_rqt(&ndev->mvdev, in, inlen, &ndev->res.rqtn);
>         kfree(in);
>         if (err)
> @@ -1354,6 +1356,7 @@ static int create_rqt(struct mlx5_vdpa_net *ndev)
>
>  static int modify_rqt(struct mlx5_vdpa_net *ndev, int num)
>  {
> +       int act_sz = roundup_pow_of_two(num / 2);
>         __be32 *list;
>         void *rqtc;
>         int inlen;
> @@ -1361,7 +1364,7 @@ static int modify_rqt(struct mlx5_vdpa_net *ndev, int num)
>         int i, j;
>         int err;
>
> -       inlen = MLX5_ST_SZ_BYTES(modify_rqt_in) + ndev->rqt_size * MLX5_ST_SZ_BYTES(rq_num);
> +       inlen = MLX5_ST_SZ_BYTES(modify_rqt_in) + act_sz * MLX5_ST_SZ_BYTES(rq_num);
>         in = kzalloc(inlen, GFP_KERNEL);
>         if (!in)
>                 return -ENOMEM;
> @@ -1372,10 +1375,10 @@ static int modify_rqt(struct mlx5_vdpa_net *ndev, int num)
>         MLX5_SET(rqtc, rqtc, list_q_type, MLX5_RQTC_LIST_Q_TYPE_VIRTIO_NET_Q);
>
>         list = MLX5_ADDR_OF(rqtc, rqtc, rq_num[0]);
> -       for (i = 0, j = 0; i < ndev->rqt_size; i++, j += 2)
> +       for (i = 0, j = 0; i < act_sz; i++, j = j + 2)
>                 list[i] = cpu_to_be32(ndev->vqs[j % num].virtq_id);
>
> -       MLX5_SET(rqtc, rqtc, rqt_actual_size, ndev->rqt_size);
> +       MLX5_SET(rqtc, rqtc, rqt_actual_size, act_sz);
>         err = mlx5_vdpa_modify_rqt(&ndev->mvdev, in, inlen, ndev->res.rqtn);
>         kfree(in);
>         if (err)
> --
> 2.35.1
>

