Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 55A3363A141
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Nov 2022 07:33:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229841AbiK1Gbv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Nov 2022 01:31:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229621AbiK1Gbs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Nov 2022 01:31:48 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4AC0412D35;
        Sun, 27 Nov 2022 22:31:47 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id A8981CE0A25;
        Mon, 28 Nov 2022 06:31:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A120FC433D6;
        Mon, 28 Nov 2022 06:31:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1669617103;
        bh=GoMPjr5XsVPNgE8a7EZDAqFErocF043LS2O0MhMI8uE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=nuUMVY/m7QpEi5j3ZUXuVzKX48kyIktz+8oGrms1mxwO3gFhPahaWakPyGUEp2wJP
         KjvePJS5XucxQM3wKk9KGFYE8d4kkZv0D3/ELB5JAJJA5oVoIAi+ucKUdhnBsP6E+y
         GdMfUK1NzYgQ/hphGoQZ1QfpZ5C9VMn5BUUJIGVxl2cgF3amNkzYjw34J4W3n7Cb1B
         CQp5ji3dVoZDWt8Wf6K8BUQyQK/qYkevIE8w8QNaVlV113B9Q0srkWx91uOZ569oUG
         /N8QO574kH45ZkkMgBp+L1SXIYs2QIFhUjoikAuOFvNMS8RR+bPhkm0Dbv/BOGvkIf
         4XTP1CtUamZwg==
Date:   Sun, 27 Nov 2022 23:31:41 -0700
From:   Nathan Chancellor <nathan@kernel.org>
To:     Paul Kocialkowski <paul.kocialkowski@bootlin.com>
Cc:     linux-media@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
        linux-kernel@vger.kernel.org, linux-staging@lists.linux.dev,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Samuel Holland <samuel@sholland.org>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Hans Verkuil <hans.verkuil@cisco.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        llvm@lists.linux.dev
Subject: Re: [PATCH v8 3/6] staging: media: Add support for the Allwinner A31
 ISP
Message-ID: <Y4RVzSM4FQ/tYQAV@dev-arch.thelio-3990X>
References: <20221103163717.246217-1-paul.kocialkowski@bootlin.com>
 <20221103163717.246217-4-paul.kocialkowski@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221103163717.246217-4-paul.kocialkowski@bootlin.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Paul,

On Thu, Nov 03, 2022 at 05:37:14PM +0100, Paul Kocialkowski wrote:
> Some Allwinner platforms come with an Image Signal Processor, which
> supports various features in order to enhance and transform data
> received by image sensors into good-looking pictures. In most cases,
> the data is raw bayer, which gets internally converted to RGB and
> finally YUV, which is what the hardware produces.
> 
> This driver supports ISPs that are similar to the A31 ISP, which was
> the first standalone ISP found in Allwinner platforms. Simpler ISP
> blocks were found in the A10 and A20, where they are tied to a CSI
> controller. Newer generations of Allwinner SoCs (starting with the
> H6, H616, etc) come with a new camera subsystem and revised ISP.
> Even though these previous and next-generation ISPs are somewhat
> similar to the A31 ISP, they have enough significant differences to
> be out of the scope of this driver.
> 
> While the ISP supports many features, including 3A and many
> enhancement blocks, this implementation is limited to the following:
> - V3s (V3/S3) platform support;
> - Bayer media bus formats as input;
> - Semi-planar YUV (NV12/NV21) as output;
> - Debayering with per-component gain and offset configuration;
> - 2D noise filtering with configurable coefficients.
> 
> Since many features are missing from the associated uAPI, the driver
> is aimed to integrate staging until all features are properly
> described.
> 
> On the technical side, it uses the v4l2 and media controller APIs,
> with a video node for capture, a processor subdev and a video node
> for parameters submission. A specific uAPI structure and associated
> v4l2 meta format are used to configure parameters of the supported
> modules.
> 
> One particular thing about the hardware is that configuration for
> module registers needs to be stored in a DMA buffer and gets copied
> to actual registers by the hardware at the next vsync, when instructed
> by a flag. This is handled by the "state" mechanism in the driver.
> 
> Signed-off-by: Paul Kocialkowski <paul.kocialkowski@bootlin.com>

This patch is now in -next as commit e3185e1d7c14 ("media: staging:
media: Add support for the Allwinner A31 ISP"), where it causes the
following clang warnings:

> +void sun6i_isp_capture_configure(struct sun6i_isp_device *isp_dev)
> +{
> +	unsigned int width, height;
> +	unsigned int stride_luma, stride_chroma = 0;
> +	unsigned int stride_luma_div4, stride_chroma_div4;
> +	const struct sun6i_isp_capture_format *format;
> +	const struct v4l2_format_info *info;
> +	u32 pixelformat;
> +
> +	sun6i_isp_capture_dimensions(isp_dev, &width, &height);
> +	sun6i_isp_capture_format(isp_dev, &pixelformat);
> +
> +	format = sun6i_isp_capture_format_find(pixelformat);
> +	if (WARN_ON(!format))
> +		return;
> +
> +	sun6i_isp_load_write(isp_dev, SUN6I_ISP_MCH_SIZE_CFG_REG,
> +			     SUN6I_ISP_MCH_SIZE_CFG_WIDTH(width) |
> +			     SUN6I_ISP_MCH_SIZE_CFG_HEIGHT(height));
> +
> +	info = v4l2_format_info(pixelformat);
> +	if (WARN_ON(!info))
> +		return;
> +
> +	stride_luma = width * info->bpp[0];
> +	stride_luma_div4 = DIV_ROUND_UP(stride_luma, 4);
> +
> +	if (info->comp_planes > 1) {
> +		stride_chroma = width * info->bpp[1] / info->hdiv;
> +		stride_chroma_div4 = DIV_ROUND_UP(stride_chroma, 4);
> +	}
> +
> +	sun6i_isp_load_write(isp_dev, SUN6I_ISP_MCH_CFG_REG,
> +			     SUN6I_ISP_MCH_CFG_EN |
> +			     SUN6I_ISP_MCH_CFG_OUTPUT_FMT(format->output_format) |
> +			     SUN6I_ISP_MCH_CFG_STRIDE_Y_DIV4(stride_luma_div4) |
> +			     SUN6I_ISP_MCH_CFG_STRIDE_UV_DIV4(stride_chroma_div4));
> +}


  drivers/staging/media/sunxi/sun6i-isp/sun6i_isp_capture.c:135:6: error: variable 'stride_chroma_div4' is used uninitialized whenever 'if' condition is false [-Werror,-Wsometimes-uninitialized]
          if (info->comp_planes > 1) {
              ^~~~~~~~~~~~~~~~~~~~~
  drivers/staging/media/sunxi/sun6i-isp/sun6i_isp_capture.c:144:42: note: uninitialized use occurs here
                              SUN6I_ISP_MCH_CFG_STRIDE_UV_DIV4(stride_chroma_div4));
                                                                ^~~~~~~~~~~~~~~~~~
  drivers/staging/media/sunxi/sun6i-isp/sun6i_isp_reg.h:249:48: note: expanded from macro 'SUN6I_ISP_MCH_CFG_STRIDE_UV_DIV4'
  #define SUN6I_ISP_MCH_CFG_STRIDE_UV_DIV4(v)     (((v) << 20) & GENMASK(30, 20))
                                                    ^
  drivers/staging/media/sunxi/sun6i-isp/sun6i_isp_capture.c:135:2: note: remove the 'if' if its condition is always true
          if (info->comp_planes > 1) {
          ^~~~~~~~~~~~~~~~~~~~~~~~~~~
  drivers/staging/media/sunxi/sun6i-isp/sun6i_isp_capture.c:112:51: note: initialize the variable 'stride_chroma_div4' to silence this warning
          unsigned int stride_luma_div4, stride_chroma_div4;
                                                          ^
                                                            = 0

Does stride_chroma_div4 want to just be initialized to zero?

> +static int sun6i_isp_proc_notifier_bound(struct v4l2_async_notifier *notifier,
> +					 struct v4l2_subdev *remote_subdev,
> +					 struct v4l2_async_subdev *async_subdev)
> +{
> +	struct sun6i_isp_device *isp_dev =
> +		container_of(notifier, struct sun6i_isp_device, proc.notifier);
> +	struct sun6i_isp_proc_async_subdev *proc_async_subdev =
> +		container_of(async_subdev, struct sun6i_isp_proc_async_subdev,
> +			     async_subdev);
> +	struct sun6i_isp_proc *proc = &isp_dev->proc;
> +	struct sun6i_isp_proc_source *source = proc_async_subdev->source;
> +	bool enabled;
> +
> +	switch (source->endpoint.base.port) {
> +	case SUN6I_ISP_PORT_CSI0:
> +		source = &proc->source_csi0;
> +		enabled = true;
> +		break;
> +	case SUN6I_ISP_PORT_CSI1:
> +		source = &proc->source_csi1;
> +		enabled = !proc->source_csi0.expected;
> +		break;
> +	default:
> +		break;
> +	}
> +
> +	source->subdev = remote_subdev;
> +
> +	return sun6i_isp_proc_link(isp_dev, SUN6I_ISP_PROC_PAD_SINK_CSI,
> +				   remote_subdev, enabled);
> +}

  drivers/staging/media/sunxi/sun6i-isp/sun6i_isp_proc.c:418:2: error: variable 'enabled' is used uninitialized whenever switch default is taken [-Werror,-Wsometimes-uninitialized]
          default:
          ^~~~~~~
  drivers/staging/media/sunxi/sun6i-isp/sun6i_isp_proc.c:425:23: note: uninitialized use occurs here
                                    remote_subdev, enabled);
                                                    ^~~~~~~
  drivers/staging/media/sunxi/sun6i-isp/sun6i_isp_proc.c:407:14: note: initialize the variable 'enabled' to silence this warning
          bool enabled;
                      ^
                      = 0

Should there be an early return in the default case?

I do not mind sending patches if you are unable to, assuming I have the
right fixes.

Cheers,
Nathan
