Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8EBAC6330B4
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Nov 2022 00:30:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231589AbiKUXaK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Nov 2022 18:30:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229501AbiKUXaF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Nov 2022 18:30:05 -0500
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [IPv6:2001:4b98:dc2:55:216:3eff:fef7:d647])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F37C0D5A3C;
        Mon, 21 Nov 2022 15:30:03 -0800 (PST)
Received: from pendragon.ideasonboard.com (62-78-145-57.bb.dnainternet.fi [62.78.145.57])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 79B0E88F;
        Tue, 22 Nov 2022 00:30:02 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1669073402;
        bh=R1fDWsTgVU6ADGQUzmzjfRj4xG9TLcrH33UvFQBX/Ns=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=YSTTDQiEemoRQM4f4ZmrxvmyUwDPynmN2iE6DdXOJPu9wzgn8OWdT3AbuZO0HJg0q
         ZJ2WG5lSbkm0LD7XiZOUeNSKzIsIuE6PyEpRRQiFASpsSNA9U3MnB5O0mjJC0eE29h
         Tk/nVO/mqnipaCGOk4SF8pHmQoQvxu/yd3z0SP9c=
Date:   Tue, 22 Nov 2022 01:29:47 +0200
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     Umang Jain <umang.jain@ideasonboard.com>
Cc:     linux-media@vger.kernel.org, kernel-list@raspberrypi.com,
        linux-kernel@vger.kernel.org, linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org,
        linux-staging@lists.linux.dev,
        Broadcom internal kernel review list 
        <bcm-kernel-feedback-list@broadcom.com>,
        Dave Stevenson <dave.stevenson@raspberrypi.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Naushir Patuck <naush@raspberrypi.com>,
        David Plowman <david.plowman@raspberrypi.com>,
        Kieran Bingham <kieran.bingham@ideasonboard.com>
Subject: Re: [PATCH 12/14] staging: vc04_services: bcm2835_isp: Allow
 multiple users
Message-ID: <Y3wJ6/+Hl6JTm1Bu@pendragon.ideasonboard.com>
References: <20221121214722.22563-1-umang.jain@ideasonboard.com>
 <20221121214722.22563-13-umang.jain@ideasonboard.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20221121214722.22563-13-umang.jain@ideasonboard.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Umang and Naush,

Thank you for the patch.

On Tue, Nov 22, 2022 at 03:17:20AM +0530, Umang Jain wrote:
> From: Naushir Patuck <naush@raspberrypi.com>
> 
> Add a second (identical) set of device nodes to allow concurrent use of
> the bcm2835-isp hardware by another user. This change effectively
> creates a second state structure (struct bcm2835_isp_dev) to maintain
> independent state for the second user. Node and media entity names are
> appened with the instance index appropriately.
> 
> Further users can be added by changing the BCM2835_ISP_NUM_INSTANCES
> define.
> 
> Signed-off-by: Naushir Patuck <naush@raspberrypi.com>
> Signed-off-by: Umang Jain <umang.jain@ideasonboard.com>

Let's squash this with 09/14.

> ---
>  .../bcm2835-isp/bcm2835-v4l2-isp.c            | 77 +++++++++++++++----
>  1 file changed, 61 insertions(+), 16 deletions(-)
> 
> diff --git a/drivers/staging/vc04_services/bcm2835-isp/bcm2835-v4l2-isp.c b/drivers/staging/vc04_services/bcm2835-isp/bcm2835-v4l2-isp.c
> index cb7cdba76682..0dbcb25595e7 100644
> --- a/drivers/staging/vc04_services/bcm2835-isp/bcm2835-v4l2-isp.c
> +++ b/drivers/staging/vc04_services/bcm2835-isp/bcm2835-v4l2-isp.c
> @@ -28,13 +28,19 @@
>  
>  MODULE_IMPORT_NS(DMA_BUF);
>  
> +/*
> + * We want to instantiate 2 independent instances allowing 2 simultaneous users
> + * of the ISP hardware.
> + */
> +#define BCM2835_ISP_NUM_INSTANCES 2
> +
>  static unsigned int debug;
>  module_param(debug, uint, 0644);
>  MODULE_PARM_DESC(debug, "activates debug info");
>  
> -static unsigned int video_nr = 13;
> -module_param(video_nr, uint, 0644);
> -MODULE_PARM_DESC(video_nr, "base video device number");
> +static unsigned int video_nr[BCM2835_ISP_NUM_INSTANCES] = { 13, 20 };
> +module_param_array(video_nr, uint, NULL, 0644);
> +MODULE_PARM_DESC(video_nr, "base video device numbers");
>  
>  #define BCM2835_ISP_NAME "bcm2835-isp"
>  #define BCM2835_ISP_ENTITY_NAME_LEN 32
> @@ -1286,6 +1292,7 @@ static int bcm2835_isp_get_supported_fmts(struct bcm2835_isp_node *node)
>   * or output nodes.
>   */
>  static int register_node(struct bcm2835_isp_dev *dev,
> +			 unsigned int instance,
>  			 struct bcm2835_isp_node *node,
>  			 int index)
>  {
> @@ -1447,7 +1454,7 @@ static int register_node(struct bcm2835_isp_dev *dev,
>  	snprintf(vfd->name, sizeof(node->vfd.name), "%s-%s%d", BCM2835_ISP_NAME,
>  		 node->name, node->id);
>  
> -	ret = video_register_device(vfd, VFL_TYPE_VIDEO, video_nr + index);
> +	ret = video_register_device(vfd, VFL_TYPE_VIDEO, video_nr[instance]);
>  	if (ret) {
>  		v4l2_err(&dev->v4l2_dev,
>  			 "Failed to register video %s[%d] device node\n",
> @@ -1668,9 +1675,8 @@ static int media_controller_register(struct bcm2835_isp_dev *dev)
>  	return ret;
>  }
>  
> -static int bcm2835_isp_remove(struct platform_device *pdev)
> +static void bcm2835_isp_remove_instance(struct bcm2835_isp_dev *dev)
>  {
> -	struct bcm2835_isp_dev *dev = platform_get_drvdata(pdev);
>  	unsigned int i;
>  
>  	media_controller_unregister(dev);
> @@ -1685,11 +1691,11 @@ static int bcm2835_isp_remove(struct platform_device *pdev)
>  					      dev->component);
>  
>  	vchiq_mmal_finalise(dev->mmal_instance);
> -
> -	return 0;
>  }
>  
> -static int bcm2835_isp_probe(struct platform_device *pdev)
> +static int bcm2835_isp_probe_instance(struct platform_device *pdev,
> +				      struct bcm2835_isp_dev **dev_int,
> +				      unsigned int instance)
>  {
>  	struct bcm2835_isp_dev *dev;
>  	unsigned int i;
> @@ -1699,6 +1705,7 @@ static int bcm2835_isp_probe(struct platform_device *pdev)
>  	if (!dev)
>  		return -ENOMEM;
>  
> +	*dev_int = dev;
>  	dev->dev = &pdev->dev;
>  
>  	ret = v4l2_device_register(&pdev->dev, &dev->v4l2_dev);
> @@ -1716,7 +1723,7 @@ static int bcm2835_isp_probe(struct platform_device *pdev)
>  	if (ret) {
>  		v4l2_err(&dev->v4l2_dev,
>  			 "%s: failed to create ril.isp component\n", __func__);
> -		goto error;
> +		return ret;
>  	}
>  
>  	if (dev->component->inputs < BCM2835_ISP_NUM_OUTPUTS ||
> @@ -1728,7 +1735,7 @@ static int bcm2835_isp_probe(struct platform_device *pdev)
>  			  BCM2835_ISP_NUM_OUTPUTS,
>  			  dev->component->outputs,
>  			  BCM2835_ISP_NUM_CAPTURES + BCM2835_ISP_NUM_METADATA);
> -		goto error;
> +		return -EINVAL;
>  	}
>  
>  	atomic_set(&dev->num_streaming, 0);
> @@ -1736,17 +1743,55 @@ static int bcm2835_isp_probe(struct platform_device *pdev)
>  	for (i = 0; i < BCM2835_ISP_NUM_NODES; i++) {
>  		struct bcm2835_isp_node *node = &dev->node[i];
>  
> -		ret = register_node(dev, node, i);
> +		ret = register_node(dev, instance, node, i);
>  		if (ret)
> -			goto error;
> +			return ret;
>  	}
>  
>  	ret = media_controller_register(dev);
>  	if (ret)
> -		goto error;
> +		return ret;
> +
> +	return 0;
> +}
> +
> +static int bcm2835_isp_remove(struct platform_device *pdev)
> +{
> +	struct bcm2835_isp_dev **bcm2835_isp_instances;
> +	unsigned int i;
> +
> +	bcm2835_isp_instances = platform_get_drvdata(pdev);
> +	for (i = 0; i < BCM2835_ISP_NUM_INSTANCES; i++) {
> +		if (bcm2835_isp_instances[i])
> +			bcm2835_isp_remove_instance(bcm2835_isp_instances[i]);
> +	}
> +
> +	return 0;
> +}
> +
> +static int bcm2835_isp_probe(struct platform_device *pdev)
> +{
> +	struct bcm2835_isp_dev **bcm2835_isp_instances;
> +	unsigned int i;
> +	int ret;
> +
> +	bcm2835_isp_instances = devm_kzalloc(&pdev->dev,
> +					     sizeof(bcm2835_isp_instances) *
> +						      BCM2835_ISP_NUM_INSTANCES,
> +					     GFP_KERNEL);
> +	if (!bcm2835_isp_instances)
> +		return -ENOMEM;
> +
> +	platform_set_drvdata(pdev, bcm2835_isp_instances);
> +
> +	for (i = 0; i < BCM2835_ISP_NUM_INSTANCES; i++) {
> +		ret = bcm2835_isp_probe_instance(pdev,
> +						 &bcm2835_isp_instances[i], i);
> +		if (ret)
> +			goto error;
> +	}
>  
> -	platform_set_drvdata(pdev, dev);
> -	v4l2_info(&dev->v4l2_dev, "Loaded V4L2 %s\n", BCM2835_ISP_NAME);
> +	dev_info(&pdev->dev, "Loaded V4L2 %s\n", BCM2835_ISP_NAME);
>  	return 0;
>  
>  error:

-- 
Regards,

Laurent Pinchart
