Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1236365370C
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Dec 2022 20:32:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234740AbiLUTcO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Dec 2022 14:32:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234209AbiLUTcK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Dec 2022 14:32:10 -0500
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D0DF15F0B;
        Wed, 21 Dec 2022 11:32:09 -0800 (PST)
Received: by mail-wm1-x330.google.com with SMTP id c65-20020a1c3544000000b003cfffd00fc0so2325464wma.1;
        Wed, 21 Dec 2022 11:32:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=+UwB8YFQzgwG8BjOAeX2tDFHU+o0BOKKcjrYgGzP1vA=;
        b=D9575x7xtb4F1WNG/+7M/9uYWsL8cB69hBx7F+3/VQ0sFOXBvLMV/z1doUMzPv8jop
         Q0J/Dz4C6i5r3vJ50Cg84XOLLYV924SF3I1sm3cSmkc3yZ6vMpILk8qRbFWvfHj7SqQ/
         bAqESABVsarqaCuak4Rp4WSsQTdIHpRl3qkEO+JOKwg4jcOp/yWntaGXDrnva3wSqwbY
         UiW0rFnpLE9N/8UJQ8iqXVqp4eyxsheVr4C5WUqKfshE+kHNOYdc4TSIHzl/T9ftk59B
         4c8jxdD5s5kqSUV8/jqWIOfiDL1n+rTBo9Tzv4V1cCYsxWWD1zb37seS/319YWpwlgPc
         1XIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+UwB8YFQzgwG8BjOAeX2tDFHU+o0BOKKcjrYgGzP1vA=;
        b=CeS2GM/MoP3giy2ztSQY3+tBmgdwFCSLo3qg9Jo2wljPqMd0IkQ0xZGDzEjKwWDjZb
         FDc+eT+epZHfPaHdgMf0KMVgN8kVxZiDsj3s9gQbelsP1M47cw3KAocD3XtFBOLEv4RP
         SokkOa301+Umil32yricGAqJNs/APWmtSC6oHL3QGMXiVhNAmHh67SQPQYAakn6o4hnf
         ihhU9WFbiBp46z/ZRJmCi1DLfggngRBmmhbnpkZw3e173fhVjMhje/PqeszQOguJ1S53
         XC9MXZhb2dD47LHFMULXduOjqAa3zgycGazGfb5r93MCD+XysC6vaRP15kPy71dDJTCZ
         hdIg==
X-Gm-Message-State: AFqh2kqE4M8pAn188EsgCzCvbFqzF+rYUOHDoDiLbNAIKVIgk2LOzXV4
        fR5Kcq/0rppO+qtV8PZz9Sw=
X-Google-Smtp-Source: AMrXdXv+IcZLB2hPBAZX9IZ5iqZXqlv8xDYzvzXS5CkY3kiwYo1W8iV+d5MKf0U9oDNxnPWeuEm1gQ==
X-Received: by 2002:a05:600c:a51:b0:3cf:6f4d:c259 with SMTP id c17-20020a05600c0a5100b003cf6f4dc259mr2312518wmq.39.1671651127512;
        Wed, 21 Dec 2022 11:32:07 -0800 (PST)
Received: from localhost ([2a00:23c5:dc8c:8701:1663:9a35:5a7b:1d76])
        by smtp.gmail.com with ESMTPSA id u7-20020a05600c4d0700b003d220ef3232sm3191634wmp.34.2022.12.21.11.32.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Dec 2022 11:32:06 -0800 (PST)
Date:   Wed, 21 Dec 2022 19:32:06 +0000
From:   Lorenzo Stoakes <lstoakes@gmail.com>
To:     "Michael S. Tsirkin" <mst@redhat.com>
Cc:     linux-kernel@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
        Anders Roxell <anders.roxell@linaro.org>,
        virtualization@lists.linux-foundation.org,
        linux-block@vger.kernel.org, Stefan Hajnoczi <stefanha@redhat.com>,
        Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH] virtio-blk: fix probe without CONFIG_BLK_DEV_ZONED
Message-ID: <Y6NfNoFdrxJXu82U@lucifer>
References: <20221220112340.518841-1-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221220112340.518841-1-mst@redhat.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 20, 2022 at 06:23:44AM -0500, Michael S. Tsirkin wrote:
> When building without CONFIG_BLK_DEV_ZONED, VIRTIO_BLK_F_ZONED
> is excluded from array of driver features.
> As a result virtio_has_feature panics in virtio_check_driver_offered_feature
> since that by design verifies that a feature we are checking for
> is listed in the feature array.
>
> To fix, replace the call to virtio_has_feature with a stub.
>
> Tested-by: Anders Roxell <anders.roxell@linaro.org>
> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> ---
>  drivers/block/virtio_blk.c | 11 ++++++++++-
>  1 file changed, 10 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/block/virtio_blk.c b/drivers/block/virtio_blk.c
> index 88b3639f8536..5ea1dc882a80 100644
> --- a/drivers/block/virtio_blk.c
> +++ b/drivers/block/virtio_blk.c
> @@ -760,6 +760,10 @@ static int virtblk_probe_zoned_device(struct virtio_device *vdev,
>  	return ret;
>  }
>
> +static inline bool virtblk_has_zoned_feature(struct virtio_device *vdev)
> +{
> +	return virtio_has_feature(vdev, VIRTIO_BLK_F_ZONED);
> +}
>  #else
>
>  /*
> @@ -775,6 +779,11 @@ static inline int virtblk_probe_zoned_device(struct virtio_device *vdev,
>  {
>  	return -EOPNOTSUPP;
>  }
> +
> +static inline bool virtblk_has_zoned_feature(struct virtio_device *vdev)
> +{
> +	return false;
> +}
>  #endif /* CONFIG_BLK_DEV_ZONED */
>
>  /* return id (s/n) string for *disk to *id_str
> @@ -1480,7 +1489,7 @@ static int virtblk_probe(struct virtio_device *vdev)
>  	virtblk_update_capacity(vblk, false);
>  	virtio_device_ready(vdev);
>
> -	if (virtio_has_feature(vdev, VIRTIO_BLK_F_ZONED)) {
> +	if (virtblk_has_zoned_feature(vdev)) {
>  		err = virtblk_probe_zoned_device(vdev, vblk, q);
>  		if (err)
>  			goto out_cleanup_disk;
> --
> MST
>
> _______________________________________________
> Virtualization mailing list
> Virtualization@lists.linux-foundation.org
> https://lists.linuxfoundation.org/mailman/listinfo/virtualization
Tested-by: Lorenzo Stoakes <lstoakes@gmail.com>
