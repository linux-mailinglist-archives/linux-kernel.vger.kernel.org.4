Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 80D996C8C1E
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Mar 2023 08:13:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232064AbjCYHNq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 25 Mar 2023 03:13:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229722AbjCYHNn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Mar 2023 03:13:43 -0400
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E9E54EC2;
        Sat, 25 Mar 2023 00:13:42 -0700 (PDT)
Received: by mail-ed1-x535.google.com with SMTP id eh3so16006264edb.11;
        Sat, 25 Mar 2023 00:13:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679728421;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IM+nUWgRuPmPrHEx7a7/E/AWE3vW5VKDZlbVcGCYHMc=;
        b=orqylAL0Bl+ispOzAPhx38/5/cGdyHe8UCc4aTge5CVBGASyZnSHRdjGNV+n0KcFSf
         pKT99BkCBuPc7baw1wX3i0KvCyMC7yeEvD+bGOk9jwEpPDs85DyC758fOrrc+xZIiMU3
         vhgf38omSNUGsem0M8zxcp4w67/bzCchmLp7UdqEjykFsOKod2+LLoCkfDySppkg93z1
         rd8zNYDea8xJecQixvsGRUG3RRUf/6RF28JoJX0tPVJ97RH70Fcfyp+qJElnKQhtRmDW
         nzXLYwLIGl6oDA4WRZXGFbfy2wfTrdohhfFmaNA//URpwdQ9gfLrfRr8fx0X9iAA7jLb
         rx1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679728421;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IM+nUWgRuPmPrHEx7a7/E/AWE3vW5VKDZlbVcGCYHMc=;
        b=OYuUUdu5osOaBo3NdfUYvFjtBoIH9SvjY1nFs8By8hesB7yIOpZJaH5AMP3a3EatEK
         R1SGUBeVNDIi+nxT4bVOm8akV6mKtkYzdHBwJBhRcmw5ksVyLsxD0CMRKurfP9yV0624
         P/d+9uvezxqTsGVYAiTa81jYClqbvzM1aY2ORepPuuN9yOSk2vApp2wQkHoIVVbLMg30
         FLILUpzMbC9BJf6jEn5j4/DN/vmCyySWaUyO+N9u3PFedvHq5pNOh7qDBNJQa7exsL13
         ckc85o6EDUB+f6sXlL+KSi/6LRYPBfyKRJEhEp8IoqE4kz9fFHcvk5m9hnEaqzLnL5dY
         Srpw==
X-Gm-Message-State: AAQBX9enWuN82qm2O6vdTBrAtlptvzHvXIs9kHdRs5w+8r6qpi274OVM
        yA22z5cfYgVk95EMA8FqNoLWWz4ITUA=
X-Google-Smtp-Source: AKy350ZcUUX6ku/r3vzVB1zVlgqKWIU80Ihe3H4eMBgK1umX3QGAjiQnUC5hVyZEW11hIFtXMiPysg==
X-Received: by 2002:a17:907:8d88:b0:93f:1d2e:8aed with SMTP id tf8-20020a1709078d8800b0093f1d2e8aedmr1839736ejc.50.1679728421133;
        Sat, 25 Mar 2023 00:13:41 -0700 (PDT)
Received: from kista.localnet (82-149-1-233.dynamic.telemach.net. [82.149.1.233])
        by smtp.gmail.com with ESMTPSA id c19-20020a170906155300b0093ebc654f78sm1313809ejd.25.2023.03.25.00.13.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 25 Mar 2023 00:13:40 -0700 (PDT)
From:   Jernej =?utf-8?B?xaBrcmFiZWM=?= <jernej.skrabec@gmail.com>
To:     linux-media@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org,
        linux-staging@lists.linux.dev,
        Paul Kocialkowski <paul.kocialkowski@bootlin.com>
Cc:     Paul Kocialkowski <paul.kocialkowski@bootlin.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Samuel Holland <samuel@sholland.org>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Adam Pigg <adam@piggz.co.uk>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Subject: Re: [PATCH 6/9] media: sun6i-csi: capture: Implement MC I/O with extended
 enum_fmt
Date:   Sat, 25 Mar 2023 08:13:39 +0100
Message-ID: <3225394.44csPzL39Z@kista>
In-Reply-To: <20230324151228.2778112-7-paul.kocialkowski@bootlin.com>
References: <20230324151228.2778112-1-paul.kocialkowski@bootlin.com>
 <20230324151228.2778112-7-paul.kocialkowski@bootlin.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dne petek, 24. marec 2023 ob 16:12:25 CET je Paul Kocialkowski napisal(a):
> This driver needs the media-controller API to operate and should not be
> considered as a video-device-centric implementation.
> 
> Properly report the IO_MC device cap and extend the enum_fmt
> implementation to support enumeration with an explicit mbus_code.
> 
> Signed-off-by: Paul Kocialkowski <paul.kocialkowski@bootlin.com>
> ---
>  .../sunxi/sun6i-csi/sun6i_csi_capture.c       | 36 ++++++++++++++++---
>  1 file changed, 32 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/media/platform/sunxi/sun6i-csi/sun6i_csi_capture.c b/drivers/media/platform/sunxi/sun6i-csi/sun6i_csi_capture.c
> index 6ce7f1d3ed57..9627030ff060 100644
> --- a/drivers/media/platform/sunxi/sun6i-csi/sun6i_csi_capture.c
> +++ b/drivers/media/platform/sunxi/sun6i-csi/sun6i_csi_capture.c
> @@ -777,13 +777,40 @@ static int sun6i_csi_capture_enum_fmt(struct file *file, void *private,
>  				      struct v4l2_fmtdesc *fmtdesc)
>  {
>  	u32 index = fmtdesc->index;
> +	u32 mbus_code = fmtdesc->mbus_code;

Nit: reverse christmas tree.

Other than that:

Reviewed-by: Jernej Skrabec <jernej.skrabec@gmail.com>

Best regards,
Jernej

> +	unsigned int index_valid = 0;
> +	unsigned int i;
> +
> +	if (!mbus_code) {
> +		if (index >= ARRAY_SIZE(sun6i_csi_capture_formats))
> +			return -EINVAL;
> +
> +		fmtdesc->pixelformat =
> +			sun6i_csi_capture_formats[index].pixelformat;
> +
> +		return 0;
> +	}
> +
> +	/* Check capture pixel format matching with mbus code. */
>  
> -	if (index >= ARRAY_SIZE(sun6i_csi_capture_formats))
> +	if (!sun6i_csi_bridge_format_find(mbus_code))
>  		return -EINVAL;
>  
> -	fmtdesc->pixelformat = sun6i_csi_capture_formats[index].pixelformat;
> +	for (i = 0; i < ARRAY_SIZE(sun6i_csi_capture_formats); i++) {
> +		u32 pixelformat = sun6i_csi_capture_formats[i].pixelformat;
>  
> -	return 0;
> +		if (!sun6i_csi_capture_format_check(pixelformat, mbus_code))
> +			continue;
> +
> +		if (index == index_valid) {
> +			fmtdesc->pixelformat = pixelformat;
> +			return 0;
> +		}
> +
> +		index_valid++;
> +	}
> +
> +	return -EINVAL;
>  }
>  
>  static int sun6i_csi_capture_g_fmt(struct file *file, void *private,
> @@ -1039,7 +1066,8 @@ int sun6i_csi_capture_setup(struct sun6i_csi_device *csi_dev)
>  
>  	strscpy(video_dev->name, SUN6I_CSI_CAPTURE_NAME,
>  		sizeof(video_dev->name));
> -	video_dev->device_caps = V4L2_CAP_VIDEO_CAPTURE | V4L2_CAP_STREAMING;
> +	video_dev->device_caps = V4L2_CAP_VIDEO_CAPTURE | V4L2_CAP_STREAMING |
> +				 V4L2_CAP_IO_MC;
>  	video_dev->vfl_dir = VFL_DIR_RX;
>  	video_dev->release = video_device_release_empty;
>  	video_dev->fops = &sun6i_csi_capture_fops;
> -- 
> 2.39.2
> 
> 


