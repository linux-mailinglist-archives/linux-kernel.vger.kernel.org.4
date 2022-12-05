Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1296064379B
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Dec 2022 23:03:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232636AbiLEWDQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Dec 2022 17:03:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232018AbiLEWDN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Dec 2022 17:03:13 -0500
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [IPv6:2001:4b98:dc2:55:216:3eff:fef7:d647])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE4152C7;
        Mon,  5 Dec 2022 14:03:12 -0800 (PST)
Received: from pendragon.ideasonboard.com (213-243-189-158.bb.dnainternet.fi [213.243.189.158])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 3C11C589;
        Mon,  5 Dec 2022 23:03:10 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1670277790;
        bh=R9c+OK/QPNRPg641/oRs3vSbSAY/lw4zvCkJ30yFVJU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=KM0GT23gcFzckrirUJPZHUHs8sNnm3m3U0umeR2qmWhQ4ecqIRp8gLbiiZTVTrbcu
         yhbF7p1qfmqPUlr+x6S0sGBmiZvk7hclhVdemSDBWlWNv3zl6MtZcRLgmJQIA6blHu
         xfvjPi5k0c2YjqG9U/JBvNyeToTmAfmTtzxI7gkc=
Date:   Tue, 6 Dec 2022 00:03:07 +0200
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     Ricardo Ribalda <ribalda@chromium.org>
Cc:     Yunke Cao <yunkec@chromium.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        linux-media@vger.kernel.org,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 1/3] media: v4l2-dev.c: Add Meta: to the name of
 metadata devices
Message-ID: <Y45qmwEAGKvfewCh@pendragon.ideasonboard.com>
References: <20220920-resend-meta-v4-0-3ac355b66723@chromium.org>
 <20220920-resend-meta-v4-1-3ac355b66723@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220920-resend-meta-v4-1-3ac355b66723@chromium.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Ricardo,

Thank you for the patch.

On Fri, Dec 02, 2022 at 06:08:17PM +0100, Ricardo Ribalda wrote:
> Devices with Metadata output (like uvc), create two video devices, one
> for the data itself and another one for the metadata.
> 
> Add a "Meta: " to the beginning of the device name, as suggested by Mauro,
> to avoid having multiple devices with the same name.
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

This will break userspace I'm afraid. libcamera looks up video devices
by entity names for multiple platforms. I wouldn't be surprised if other
userspace applications did something similar.

> +		strscpy(vdev->name, aux, sizeof(aux));
> +	}
> +
>  	/* v4l2_fh support */
>  	spin_lock_init(&vdev->fh_lock);
>  	INIT_LIST_HEAD(&vdev->fh_list);
> 

-- 
Regards,

Laurent Pinchart
