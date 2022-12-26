Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4EE946561B3
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Dec 2022 10:52:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231981AbiLZJwl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Dec 2022 04:52:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231777AbiLZJwd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Dec 2022 04:52:33 -0500
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 413AC26D7;
        Mon, 26 Dec 2022 01:52:31 -0800 (PST)
Received: from pendragon.ideasonboard.com (213-243-189-158.bb.dnainternet.fi [213.243.189.158])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 20032105;
        Mon, 26 Dec 2022 10:52:28 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1672048348;
        bh=IP01iTw+jkDQhcsmqIdJCkLtVcOOCHr8DT1FEqfvifE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=F/2YrpukGsFzkZwuvdcboDnD1NaFAN8EXNM9kB9jcPue2ADS/Sqj9XIB5+bU0uZxx
         mPgPvBFOaXGw6to7DYMF+j5hJ8C00AfkleOHvasGxcII/b4fHFSVXJvlSlBKf3Pdmr
         k4HXrc2OQmRHUBEFErnnQgB4hud09Z2n/dDwJq5E=
Date:   Mon, 26 Dec 2022 11:52:23 +0200
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     Kieran Bingham <kieran.bingham@ideasonboard.com>
Cc:     linux-media@vger.kernel.org,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [RFC PATCH] media: v4l2-dev: sysfs: Support streaming attribute
Message-ID: <Y6lu14VsuH1LbqFH@pendragon.ideasonboard.com>
References: <20221223231736.2111774-1-kieran.bingham@ideasonboard.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20221223231736.2111774-1-kieran.bingham@ideasonboard.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Kieran,

Thank you for the patch.

On Fri, Dec 23, 2022 at 11:17:35PM +0000, Kieran Bingham wrote:
> Provide a streaming attribute to allow userspace to interogate if a device
> is actively streaming or not.
> 
> This will allow desktop notifications to report if a camera or device
> is active on the system, rather than just 'open' which can occur when
> configuring the device.
> 
> Bug: https://gitlab.freedesktop.org/pipewire/pipewire/-/issues/2669
> Signed-off-by: Kieran Bingham <kieran.bingham@ideasonboard.com>
> ---
> 
> This is a quick POC to see if such a facility makes sense.
> I'm weary that not all video devices may have the queues registered on
> the struct video_device, but this seems like an effective way to be able
> to determine if a device is actively streaming on a system.

I can imagine multiple problems, from race conditions to permissions and
privacy. In order to comment on the fitness of this solution to address
the problem you're trying to solve, could you describe the actual
problem ?

>  Documentation/ABI/stable/sysfs-class-video |  9 +++++++++
>  MAINTAINERS                                |  1 +
>  drivers/media/v4l2-core/v4l2-dev.c         | 13 +++++++++++++
>  3 files changed, 23 insertions(+)
>  create mode 100644 Documentation/ABI/stable/sysfs-class-video
> 
> diff --git a/Documentation/ABI/stable/sysfs-class-video b/Documentation/ABI/stable/sysfs-class-video
> new file mode 100644
> index 000000000000..99dd27475a92
> --- /dev/null
> +++ b/Documentation/ABI/stable/sysfs-class-video
> @@ -0,0 +1,9 @@
> +What:		/sys/class/video4linux/video<n>/streaming
> +Date:		January 2023
> +KernelVersion:	6.3
> +Contact:	Kieran Bingham <kieran.bingham@ideasonboard.com>
> +Description:
> +		Indicates if the video device has an actively streaming queue.
> +		This may indicate that the device is capturing or outputing
> +		video data.
> +Users:
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 11987154eeee..8449f5a6c0da 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -12867,6 +12867,7 @@ S:	Maintained
>  W:	https://linuxtv.org
>  Q:	http://patchwork.kernel.org/project/linux-media/list/
>  T:	git git://linuxtv.org/media_tree.git
> +F:	Documentation/ABI/stable/sysfs-class-video
>  F:	Documentation/admin-guide/media/
>  F:	Documentation/devicetree/bindings/media/
>  F:	Documentation/driver-api/media/
> diff --git a/drivers/media/v4l2-core/v4l2-dev.c b/drivers/media/v4l2-core/v4l2-dev.c
> index 397d553177fa..7d800309d076 100644
> --- a/drivers/media/v4l2-core/v4l2-dev.c
> +++ b/drivers/media/v4l2-core/v4l2-dev.c
> @@ -30,6 +30,7 @@
>  #include <media/v4l2-device.h>
>  #include <media/v4l2-ioctl.h>
>  #include <media/v4l2-event.h>
> +#include <media/videobuf2-core.h>
>  
>  #define VIDEO_NUM_DEVICES	256
>  #define VIDEO_NAME              "video4linux"
> @@ -85,7 +86,19 @@ static ssize_t name_show(struct device *cd,
>  }
>  static DEVICE_ATTR_RO(name);
>  
> +static ssize_t streaming_show(struct device *cd,
> +			      struct device_attribute *attr, char *buf)
> +{
> +	struct video_device *vdev = to_video_device(cd);
> +
> +	int active = vdev->queue ? vb2_is_streaming(vdev->queue) : false;
> +
> +	return sprintf(buf, "%s\n", active ? "active" : "inactive");
> +}
> +static DEVICE_ATTR_RO(streaming);
> +
>  static struct attribute *video_device_attrs[] = {
> +	&dev_attr_streaming.attr,
>  	&dev_attr_name.attr,
>  	&dev_attr_dev_debug.attr,
>  	&dev_attr_index.attr,

-- 
Regards,

Laurent Pinchart
