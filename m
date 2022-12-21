Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1BF9D6532B7
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Dec 2022 15:53:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230330AbiLUOxW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Dec 2022 09:53:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229472AbiLUOxQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Dec 2022 09:53:16 -0500
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5B3AF593;
        Wed, 21 Dec 2022 06:53:15 -0800 (PST)
Received: by mail-wm1-x332.google.com with SMTP id ja17so11341782wmb.3;
        Wed, 21 Dec 2022 06:53:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=HI1luplpZbZtMfrW5nz8VoSxbUmlQikDikFMZRlTu2s=;
        b=HjU2Xsm/p3k2oMOotYW1bG90VqwYKk0udzUiZrpCOrqK8D5YVaG0okQqr/krbzdPvT
         d6cmI1K4yKczRY2684TMMPfXopx+tdXVedtCi3o1vvtylN4mOYxWHnpmrEC4sUlZyJ4I
         YFGUhrHYelHkxkxMMqGNmnDhA7LMFg9f0w/wKQ3xnqDjsteeXVfaqctUDzkVhw5Vb9g8
         akso7CEDwRiCupt68D1l4silfCFiwhuW/+qkGialcjdh+dW5215IposnmA/f9D3bnyHD
         OplvWJVYw5WI/qMyM/6hKThcv6B4Q/pBnRDagFKR537egiOqoTGhfMo3AUdkaj85Di/z
         qZ8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HI1luplpZbZtMfrW5nz8VoSxbUmlQikDikFMZRlTu2s=;
        b=fMHcc1lnJ3cVRqszwmd++B/0SALQzLIebd7LHLaj0yBxVXsXtZaHTy40bM+SS57KW8
         AHQFp8wdedogzwZOcMW3CP1xX52vhutZysmtQRBYStoiAH3N0lMnnV2+WHnmcWSPT0Er
         Vy0gkJotz3blaLZ62htnM3XNORCGAsZmHqzjdUZs6TDyeTRT4D+vvYFW0WN2E/rpqPYZ
         XiSVsyFI4igWYSsRsktJrLX+361kObWyPBO1C/jGLpawW2uxRG2kvuL4luYxph+x8hSc
         uMQCFy5j1FrYIOOBmqEC702NllsKgXdE4CDiHSS30wzafScuUBT7Crfeb3bRriNUeHbo
         HalQ==
X-Gm-Message-State: AFqh2koUU5j/mesx9ICq1aC1WJ4S8tCXq6bFtu/Tr53fYde4aKA6ZkTe
        Pa1zcEId1Vdu52iwzvl5EcuxsjAM3UM=
X-Google-Smtp-Source: AMrXdXst1yNYFX8VIK8eFbGC1P22Qo5FLPmcWms3+sHZ3O7HzicFabe0T7S/tM9pJhQ378DR7ze0VA==
X-Received: by 2002:a05:600c:3d98:b0:3cf:d70d:d5a8 with SMTP id bi24-20020a05600c3d9800b003cfd70dd5a8mr1971568wmb.6.1671634394046;
        Wed, 21 Dec 2022 06:53:14 -0800 (PST)
Received: from localhost ([2a00:23c5:dc8c:8701:1663:9a35:5a7b:1d76])
        by smtp.gmail.com with ESMTPSA id iz13-20020a05600c554d00b003d33ab317dasm3076064wmb.14.2022.12.21.06.53.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Dec 2022 06:53:13 -0800 (PST)
Date:   Wed, 21 Dec 2022 14:53:12 +0000
From:   Lorenzo Stoakes <lstoakes@gmail.com>
To:     linux-block@vger.kernel.org,
        Dmitry Fomichev <dmitry.fomichev@wdc.com>,
        Stefan Hajnoczi <stefanha@redhat.com>,
        "Michael S . Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Jens Axboe <axboe@kernel.dk>
Cc:     Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        virtualization@lists.linux-foundation.org,
        virtio-dev@lists.oasis-open.org, linux-kernel@vger.kernel.org,
        Hannes Reinecke <hare@suse.de>,
        Sam Li <faithilikerun@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH] virtio-blk: avoid kernel panic on VIRTIO_BLK_F_ZONED
 check
Message-ID: <Y6Md2DuDigrnrvxU@lucifer>
References: <20221221140012.238494-1-lstoakes@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221221140012.238494-1-lstoakes@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 21, 2022 at 02:00:12PM +0000, Lorenzo Stoakes wrote:
> virtio zoned block device support is added by commit 0562d7bf1604
> ("virtio-blk: add support for zoned block devices") which adds
> VIRTIO_BLK_F_ZONED to the features array in virtio_blk.c but makes it
> conditional on CONFIG_BLK_DEV_ZONED.
>
> In it virtblk_probe() calls virtio_has_feature(vdev, VIRTIO_BLK_F_ZONED)
> unconditionally, which invokes virtio_check_driver_offered_feature().
> This function checks whether virtio_blk.feature_table (assigned to
> the static features array) contains the specified feature enum, and if not
> _causes a kernel panic_ via BUG().
>
> This therefore means that failing to enable CONFIG_BLK_DEV_ZONED while
> using virtio is a guaranteed kernel panic. Fix the issue by making the
> feature test also conditional on CONFIG_BLK_DEV_ZONED.
>
> Signed-off-by: Lorenzo Stoakes <lstoakes@gmail.com>
> ---
>  drivers/block/virtio_blk.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/drivers/block/virtio_blk.c b/drivers/block/virtio_blk.c
> index ff49052e26f7..34fdc141fb21 100644
> --- a/drivers/block/virtio_blk.c
> +++ b/drivers/block/virtio_blk.c
> @@ -1580,11 +1580,13 @@ static int virtblk_probe(struct virtio_device *vdev)
>  	virtblk_update_capacity(vblk, false);
>  	virtio_device_ready(vdev);
>
> +#ifdef CONFIG_BLK_DEV_ZONED
>  	if (virtio_has_feature(vdev, VIRTIO_BLK_F_ZONED)) {
>  		err = virtblk_probe_zoned_device(vdev, vblk, q);
>  		if (err)
>  			goto out_cleanup_disk;
>  	}
> +#endif /* CONFIG_BLK_DEV_ZONED */
>
>  	dev_info(&vdev->dev, "blk config size: %zu\n",
>  		sizeof(struct virtio_blk_config));
> --
> 2.39.0

Steven suggested use of IS_ENABLED() here which makes it rather less ugly, will
send as a v2.
