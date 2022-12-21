Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7679C65386C
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Dec 2022 23:16:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234636AbiLUWQM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Dec 2022 17:16:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230514AbiLUWQJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Dec 2022 17:16:09 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E60041DA7C;
        Wed, 21 Dec 2022 14:16:07 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 638206196F;
        Wed, 21 Dec 2022 22:16:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EE690C433D2;
        Wed, 21 Dec 2022 22:16:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1671660966;
        bh=oFrVcBqFN7oHWyDWaYKcWcUp0kA0koghMSrov+JCFbA=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=NyiDZT4cj+Dj7SimIYwropBlGfNADMPlhmBVqpwCOGXuV6hg/Vy30Lp6V9UPdHlpx
         JYB8qfEmiLplHfyUjjlrEZrL03tVAOLHoRxq1UTMPHGVXgXsASU8Nn0ZK1j5G1kIxq
         JZC9PwmJloPF27g21DYMVnSRTzkL4v28QXb/E0I227KG2hll8yYVEt6QF4A9+hG4Et
         BCXcf1F96LnK55JzWAjulRj1AVzExF//lUaDOLRRG4YJC+MEo8J0EehTsAzDr/JUt2
         boSI92AynRYQnLxk9Campos72SeBtfQs/8errGGMY0B7+jOdWIXwVdO0yd4iqFnD0Z
         RcTnoersU6h/Q==
Date:   Wed, 21 Dec 2022 22:16:01 +0000
From:   Mauro Carvalho Chehab <mchehab@kernel.org>
To:     Ricardo Ribalda <ribalda@chromium.org>
Cc:     Yunke Cao <yunkec@chromium.org>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        linux-media@vger.kernel.org,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 1/3] media: v4l2-dev.c: Add Meta: to the name of
 metadata devices
Message-ID: <20221221221601.1636c763@sal.lan>
In-Reply-To: <20220920-resend-meta-v4-1-3ac355b66723@chromium.org>
References: <20220920-resend-meta-v4-0-3ac355b66723@chromium.org>
        <20220920-resend-meta-v4-1-3ac355b66723@chromium.org>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.35; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Fri, 02 Dec 2022 18:08:17 +0100
Ricardo Ribalda <ribalda@chromium.org> escreveu:

> Devices with Metadata output (like uvc), create two video devices, one
> for the data itself and another one for the metadata.
> 
> Add a "Meta: " to the beginning of the device name, as suggested by Mauro,
> to avoid having multiple devices with the same name.

Hmm... I don't remember when I suggested it, but I suspect that such
change could cause regressions on userspace.

I double-checked: the two apps I know that have code to detect meta
devices (Camorama and ZBar) won't be affected by name changes, as they
always open v4l2 devnodes before start seeing them as capture devices,
and run VIDIOC_QUERYCAP to check for V4L2_CAP_VIDEO_CAPTURE:

   if (first_device < 0) {
        fd = open(file, O_RDWR);
        if (fd < 0) {
            devices[n_devices].is_valid = FALSE;
        } else {
            if (ioctl(fd, VIDIOC_QUERYCAP, &vid_cap) == -1) {
                devices[n_devices].is_valid = FALSE;
            } else if (!(vid_cap.device_caps & V4L2_CAP_VIDEO_CAPTURE)) {
                devices[n_devices].is_valid = FALSE;
            } else {
                n_valid_devices++;
                devices[n_devices].is_valid = TRUE;
            }
        }

        close(fd);
    } else {
        devices[n_devices].is_valid = devices[first_device].is_valid;
    }

You need to double-check if this won't cause userspace regressions, specially
on browsers, as they have more complex logic, and seem to have already some
logic to detect and remove meta files.

> 
> Fixes v4l2-compliance:
> Media Controller ioctls:
>      fail: v4l2-test-media.cpp(205): v2_entity_names_set.find(key) != v2_entity_names_set.end()
>    test MEDIA_IOC_G_TOPOLOGY: FAIL
>      fail: v4l2-test-media.cpp(394): num_data_links != num_links
>    test MEDIA_IOC_ENUM_ENTITIES/LINKS: FAIL
> 
> Suggested-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
> Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
> ---
>  drivers/media/v4l2-core/v4l2-dev.c | 9 +++++++++
>  1 file changed, 9 insertions(+)
> 
> diff --git a/drivers/media/v4l2-core/v4l2-dev.c b/drivers/media/v4l2-core/v4l2-dev.c
> index 397d553177fa..5c2c9ebb6b96 100644
> --- a/drivers/media/v4l2-core/v4l2-dev.c
> +++ b/drivers/media/v4l2-core/v4l2-dev.c
> @@ -901,6 +901,15 @@ int __video_register_device(struct video_device *vdev,
>  	if (WARN_ON(type != VFL_TYPE_SUBDEV && !vdev->device_caps))
>  		return -EINVAL;
>  
> +	/* Add Meta: to metadata device names */
> +	if (vdev->device_caps &
> +	    (V4L2_CAP_META_CAPTURE | V4L2_CAP_META_OUTPUT)) {
> +		char aux[sizeof(vdev->name)];
> +
> +		snprintf(aux, sizeof(aux), "Meta: %s", vdev->name);
> +		strscpy(vdev->name, aux, sizeof(aux));
> +	}
> +
>  	/* v4l2_fh support */
>  	spin_lock_init(&vdev->fh_lock);
>  	INIT_LIST_HEAD(&vdev->fh_list);
> 
