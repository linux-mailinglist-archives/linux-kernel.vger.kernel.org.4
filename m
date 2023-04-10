Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 03B206DC50C
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Apr 2023 11:24:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229695AbjDJJX7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Apr 2023 05:23:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229485AbjDJJX6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Apr 2023 05:23:58 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3C681A8;
        Mon, 10 Apr 2023 02:23:56 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5EE0C619B3;
        Mon, 10 Apr 2023 09:23:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0B046C433EF;
        Mon, 10 Apr 2023 09:23:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1681118635;
        bh=R54MSizWyXP9eI7MRC18h4wRC0Ayb+rInv30WCznnkU=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=lRHQu9xTUTeA6JRlAON4EgWlklpuC79vN8O70QbGmK2Mv1WRLvC7F28/yhGK59bZl
         Hubhq19X6JmejMoOWQWrGarIlLJ4X2gRAwVkoGKeXAw8BNfQ6slXXchg444J1FfY3J
         BX3JqgC+53C/o8svuPakDwYjf8ajnFhXyH1svqiY3QyXtA+fGdpk52KPXwwb7rx4S/
         WKIZcFLA57C7JipEuFRp6en9R5bFiXhTQOJdFkHa6yOabOSkwTSVPvykiAIbfuvqT0
         6ijoffecVs6yiwGne1a5jNYhxlBGPULaRrEMS978JUVfTPNc1Zv4MACGFEdsRbX0uf
         5jkDAIft9t76w==
Date:   Mon, 10 Apr 2023 10:23:50 +0100
From:   Mauro Carvalho Chehab <mchehab@kernel.org>
To:     Max Staudt <mstaudt@chromium.org>
Cc:     Hans Verkuil <hverkuil@xs4all.nl>, linux-media@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Ricardo Ribalda <ribalda@chromium.org>,
        Yunke Cao <yunkec@chromium.org>,
        Tomasz Figa <tfiga@chromium.org>
Subject: Re: [PATCH v1] media: vivid: Add webcam parameter for (un)limited
 bandwidth
Message-ID: <20230410102350.382f7d02@sal.lan>
In-Reply-To: <20230410063356.3894767-1-mstaudt@chromium.org>
References: <20230410063356.3894767-1-mstaudt@chromium.org>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.37; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Mon, 10 Apr 2023 15:33:56 +0900
Max Staudt <mstaudt@chromium.org> escreveu:

> This adds an option for higher frame rates from a simulated webcam.
> 
> Currently, vivid emulates (amongst other things) a webcam with somewhat
> limited bandwidth - higher resolutions deliver fewer frames per second:
> 
> $ yavta --enum-formats -c /dev/video0
> Device /dev/video0 opened.
> Device `vivid' on `platform:vivid-000' (driver 'vivid') supports video, capture, without mplanes.
> - Available formats:
> 	Format 0: YUYV (56595559)
> 	Type: Video capture (1)
> 	Name: YUYV 4:2:2
> 	Frame size: 320x180 (1/1, 1/2, 1/4, 1/5, 1/10, 2/25, 1/15, 1/25, 1/30, 1/40, 1/50, 1/60)
> 	Frame size: 640x360 (1/1, 1/2, 1/4, 1/5, 1/10, 2/25, 1/15, 1/25, 1/30, 1/40)
> 	Frame size: 640x480 (1/1, 1/2, 1/4, 1/5, 1/10, 2/25, 1/15, 1/25)
> 	Frame size: 1280x720 (1/1, 1/2, 1/4, 1/5, 1/10, 2/25)
> 	Frame size: 1920x1080 (1/1, 1/2, 1/4, 1/5)
> 	Frame size: 3840x2160 (1/1, 1/2)
> 
> In some test cases, it is useful to allow for higher frame rates, as
> configurations such as 720p@30 FPS have become commonplace now.
> 
> With `webcam_bandwidth_limit=0` we get more options:
> 
> $ yavta --enum-formats -c /dev/video0
> Device /dev/video0 opened.
> Device `vivid' on `platform:vivid-000' (driver 'vivid') supports video, capture, without mplanes.
> - Available formats:
> 	Format 0: YUYV (56595559)
> 	Type: Video capture (1)
> 	Name: YUYV 4:2:2
> 	Frame size: 320x180 (1/1, 1/2, 1/4, 1/5, 1/10, 2/25, 1/15, 1/25, 1/30, 1/40, 1/50, 1/60)
> 	Frame size: 640x360 (1/1, 1/2, 1/4, 1/5, 1/10, 2/25, 1/15, 1/25, 1/30, 1/40, 1/50, 1/60)
> 	Frame size: 640x480 (1/1, 1/2, 1/4, 1/5, 1/10, 2/25, 1/15, 1/25, 1/30, 1/40, 1/50, 1/60)
> 	Frame size: 1280x720 (1/1, 1/2, 1/4, 1/5, 1/10, 2/25, 1/15, 1/25, 1/30, 1/40, 1/50, 1/60)
> 	Frame size: 1920x1080 (1/1, 1/2, 1/4, 1/5, 1/10, 2/25, 1/15, 1/25, 1/30, 1/40, 1/50, 1/60)
> 	Frame size: 3840x2160 (1/1, 1/2, 1/4, 1/5, 1/10, 2/25, 1/15, 1/25, 1/30, 1/40, 1/50, 1/60)
> 
> Passes v4l2-compliance 1.25.0-5039 from v4l-utils git ccc08732823f
> 
> Signed-off-by: Max Staudt <mstaudt@chromium.org>
> ---
>  Documentation/admin-guide/media/vivid.rst     | 25 +++++++++++++++++++
>  drivers/media/test-drivers/vivid/vivid-core.c |  8 ++++++
>  drivers/media/test-drivers/vivid/vivid-core.h |  1 +
>  .../media/test-drivers/vivid/vivid-vid-cap.c  | 18 ++++++++++---
>  4 files changed, 48 insertions(+), 4 deletions(-)
> 
> diff --git a/Documentation/admin-guide/media/vivid.rst b/Documentation/admin-guide/media/vivid.rst
> index 58ac25b2c385..e65067550efc 100644
> --- a/Documentation/admin-guide/media/vivid.rst
> +++ b/Documentation/admin-guide/media/vivid.rst
> @@ -110,6 +110,28 @@ all configurable using the following module options:
>  
>  		num_inputs=8 input_types=0xffa9
>  
> +- webcam_bandwidth_limit:
> +
> +	whether a simulated webcam offers fewer frames per second for higher
> +	resolutions. This only affects webcam inputs as selected in input_types
> +	and is ignored for all other inputs. It affects all webcam inputs of
> +	a vivid instance.
> +
> +		- 0: All predefined frame intervals available for all
> +		     predefined resolutions
> +		- 1: Simulate limited bandwidth by removing two FPS rates
> +		     for each step up in resolution

IMO, instead of a parameter that just enables/disables the bandwidth
limit, the best would be to have a parameter specifying the bandwidth
(with 0 meaning unlimited). 

If not used, vivid would initialize it to dev->webcam_bandwidth_limit,
so a read operation will show the current limit.

Regards,
Mauro

> +
> +	The default is for all webcams to cap their FPS at high resolutions.
> +	This maintains the behaviour known from earlier versions of vivid.
> +
> +	To enable all frame rates across all resolutions on webcam inputs, load
> +	vivid with this option set to 0:
> +
> +	.. code-block:: none
> +
> +		webcam_bandwidth_limit=0
> +
>  - num_outputs:
>  
>  	the number of outputs, one for each instance. By default 2 outputs
> @@ -336,6 +358,9 @@ supports frames per second settings of 10, 15, 25, 30, 50 and 60 fps. Which ones
>  are available depends on the chosen framesize: the larger the framesize, the
>  lower the maximum frames per second.
>  
> +The FPS limit for higher resolutions can be disabled by passing the
> +`webcam_bandwidth_limit=0` parameter.
> +
>  The initially selected colorspace when you switch to the webcam input will be
>  sRGB.
>  
> diff --git a/drivers/media/test-drivers/vivid/vivid-core.c b/drivers/media/test-drivers/vivid/vivid-core.c
> index f28440e6c9f8..720ffe470709 100644
> --- a/drivers/media/test-drivers/vivid/vivid-core.c
> +++ b/drivers/media/test-drivers/vivid/vivid-core.c
> @@ -143,6 +143,11 @@ MODULE_PARM_DESC(input_types, " input types, default is 0xe4. Two bits per input
>  			      "\t\t    bits 0-1 == input 0, bits 31-30 == input 15.\n"
>  			      "\t\t    Type 0 == webcam, 1 == TV, 2 == S-Video, 3 == HDMI");
>  
> +/* Default: limited webcam bandwidth */
> +static bool webcam_bandwidth_limit[VIVID_MAX_DEVS] = { [0 ... (VIVID_MAX_DEVS - 1)] = true };
> +module_param_array(webcam_bandwidth_limit, bool, NULL, 0444);

I would also use 0666, to allow changing this on runtime.

> +MODULE_PARM_DESC(webcam_bandwidth_limit, " for webcam inputs, cap FPS at higher frame sizes (default: true).");
> +
>  /* Default: 2 outputs */
>  static unsigned num_outputs[VIVID_MAX_DEVS] = { [0 ... (VIVID_MAX_DEVS - 1)] = 2 };
>  module_param_array(num_outputs, uint, NULL, 0444);
> @@ -940,6 +945,9 @@ static int vivid_detect_feature_set(struct vivid_dev *dev, int inst,
>  	v4l2_info(&dev->v4l2_dev, "using %splanar format API\n",
>  			dev->multiplanar ? "multi" : "single ");
>  
> +	/* Are "webcam" type inputs of this instance rate limited? */
> +	dev->webcam_bandwidth_limit = webcam_bandwidth_limit[inst];
> +
>  	/* how many inputs do we have and of what type? */
>  	dev->num_inputs = num_inputs[inst];
>  	if (node_type & 0x20007) {
> diff --git a/drivers/media/test-drivers/vivid/vivid-core.h b/drivers/media/test-drivers/vivid/vivid-core.h
> index 473f3598db5a..aa38988384e4 100644
> --- a/drivers/media/test-drivers/vivid/vivid-core.h
> +++ b/drivers/media/test-drivers/vivid/vivid-core.h
> @@ -186,6 +186,7 @@ struct vivid_dev {
>  	unsigned int			num_hdmi_outputs;
>  	u8				output_type[MAX_OUTPUTS];
>  	u8				output_name_counter[MAX_OUTPUTS];
> +	bool				webcam_bandwidth_limit;
>  	bool				has_audio_inputs;
>  	bool				has_audio_outputs;
>  	bool				has_vid_cap;
> diff --git a/drivers/media/test-drivers/vivid/vivid-vid-cap.c b/drivers/media/test-drivers/vivid/vivid-vid-cap.c
> index c0999581c599..347c51f36386 100644
> --- a/drivers/media/test-drivers/vivid/vivid-vid-cap.c
> +++ b/drivers/media/test-drivers/vivid/vivid-vid-cap.c
> @@ -79,6 +79,14 @@ static const struct v4l2_fract webcam_intervals[VIVID_WEBCAM_IVALS] = {
>  	{  1, 60 },
>  };
>  
> +static inline unsigned webcam_ival_count(const struct vivid_dev *dev,
> +					 unsigned frmsize_idx)
> +{
> +	return dev->webcam_bandwidth_limit ?
> +		2 * (VIVID_WEBCAM_SIZES - frmsize_idx) :
> +		2 * (VIVID_WEBCAM_SIZES);
> +}
> +
>  static int vid_cap_queue_setup(struct vb2_queue *vq,
>  		       unsigned *nbuffers, unsigned *nplanes,
>  		       unsigned sizes[], struct device *alloc_devs[])
> @@ -773,14 +781,16 @@ int vivid_s_fmt_vid_cap(struct file *file, void *priv,
>  			compose->height /= factor;
>  		}
>  	} else if (vivid_is_webcam(dev)) {
> +		unsigned ival_sz = webcam_ival_count(dev, dev->webcam_size_idx);
> +
>  		/* Guaranteed to be a match */
>  		for (i = 0; i < ARRAY_SIZE(webcam_sizes); i++)
>  			if (webcam_sizes[i].width == mp->width &&
>  					webcam_sizes[i].height == mp->height)
>  				break;
>  		dev->webcam_size_idx = i;
> -		if (dev->webcam_ival_idx >= 2 * (VIVID_WEBCAM_SIZES - i))
> -			dev->webcam_ival_idx = 2 * (VIVID_WEBCAM_SIZES - i) - 1;
> +		if (dev->webcam_ival_idx >= ival_sz)
> +			dev->webcam_ival_idx = ival_sz - 1;
>  		vivid_update_format_cap(dev, false);
>  	} else {
>  		struct v4l2_rect r = { 0, 0, mp->width, mp->height };
> @@ -1908,7 +1918,7 @@ int vidioc_enum_frameintervals(struct file *file, void *priv,
>  			break;
>  	if (i == ARRAY_SIZE(webcam_sizes))
>  		return -EINVAL;
> -	if (fival->index >= 2 * (VIVID_WEBCAM_SIZES - i))
> +	if (fival->index >= webcam_ival_count(dev, i))
>  		return -EINVAL;
>  	fival->type = V4L2_FRMIVAL_TYPE_DISCRETE;
>  	fival->discrete = webcam_intervals[fival->index];
> @@ -1935,7 +1945,7 @@ int vivid_vid_cap_s_parm(struct file *file, void *priv,
>  			  struct v4l2_streamparm *parm)
>  {
>  	struct vivid_dev *dev = video_drvdata(file);
> -	unsigned ival_sz = 2 * (VIVID_WEBCAM_SIZES - dev->webcam_size_idx);
> +	unsigned ival_sz = webcam_ival_count(dev, dev->webcam_size_idx);
>  	struct v4l2_fract tpf;
>  	unsigned i;
>  
