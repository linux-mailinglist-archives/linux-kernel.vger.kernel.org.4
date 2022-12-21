Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 52321653012
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Dec 2022 12:15:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234283AbiLULPK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Dec 2022 06:15:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbiLULPH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Dec 2022 06:15:07 -0500
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [IPv6:2001:4b98:dc2:55:216:3eff:fef7:d647])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C15122514;
        Wed, 21 Dec 2022 03:15:06 -0800 (PST)
Received: from pendragon.ideasonboard.com (213-243-189-158.bb.dnainternet.fi [213.243.189.158])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 17D1BFB;
        Wed, 21 Dec 2022 12:15:04 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1671621304;
        bh=yveR9JIKb30hOShJCMWYbHM+OTy0mDpxYqQ6MAD0wM8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=g4NV3YicSsx56dEf3CRfEx2oD8ZVtpxrwM8Qvzjg0L1OEZsqKcjJyP6as+Zv6+8YC
         DJ7CAxa+7tog2sqUnc92yoXqWelxKN7UTaTY0pJGHWi7hAWVM5HNvL0IUKpvaCkRr8
         +jGtdvbLc/yB2sNTIYpmK1dfjuwiVpTEl2d4gvP8=
Date:   Wed, 21 Dec 2022 13:14:59 +0200
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     Umang Jain <umang.jain@ideasonboard.com>
Cc:     linux-staging@lists.linux.dev,
        linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-media@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Stefan Wahren <stefan.wahren@i2se.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Adrien Thierry <athierry@redhat.com>,
        Dan Carpenter <error27@gmail.com>,
        Nicolas Saenz Julienne <nsaenz@kernel.org>,
        Phil Elwell <phil@raspberrypi.com>,
        Dave Stevenson <dave.stevenson@raspberrypi.com>,
        Kieran Bingham <kieran.bingham@ideasonboard.com>
Subject: Re: [PATCH] staging: vc04_services: vchiq_arm: Create
 platform_device per device
Message-ID: <Y6Lqs8RUiyi452gM@pendragon.ideasonboard.com>
References: <20221220084404.19280-1-umang.jain@ideasonboard.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20221220084404.19280-1-umang.jain@ideasonboard.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Umang,

Thank you for the patch.

On Tue, Dec 20, 2022 at 02:14:04PM +0530, Umang Jain wrote:
> Create a proper per device platorm_device structure for all the child
> devices that needs to be registered by vchiq platform driver. Replace
> the vchiq_register_child() with platform_add_devices() to register the
> child devices.

This explains what the patch does, but not why.

> This is part of an effort to address TODO item "Get rid of all non
> essential global structures and create a proper per device structure"

And this explains part of the reason only. Could you please expand the
commit message with the reasoning behind this change ? It's not clear
from the change below why this is needed and good.

> Signed-off-by: Umang Jain <umang.jain@ideasonboard.com>
> ---
>  .../interface/vchiq_arm/vchiq_arm.c           | 59 ++++++++++---------
>  1 file changed, 31 insertions(+), 28 deletions(-)
> 
> diff --git a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.c b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.c
> index 22de23f3af02..fa42ea3791a7 100644
> --- a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.c
> +++ b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.c
> @@ -65,8 +65,29 @@ int vchiq_susp_log_level = VCHIQ_LOG_ERROR;
>  DEFINE_SPINLOCK(msg_queue_spinlock);
>  struct vchiq_state g_state;
>  
> -static struct platform_device *bcm2835_camera;
> -static struct platform_device *bcm2835_audio;
> +static u64 vchiq_device_dmamask = DMA_BIT_MASK(32);

The fact that this isn't const and is used by two different
platform_device instances is worrying. Either it can be made const, or
it's wrong.

> +
> +static struct platform_device bcm2835_camera = {
> +	.name		= "bcm2835-camera",
> +	.id		= PLATFORM_DEVID_NONE,
> +	.dev		= {
> +		.dma_mask	= &vchiq_device_dmamask,
> +	}
> +};
> +
> +static struct platform_device bcm2835_audio = {
> +	.name		= "bcm2835_audio",
> +	.id		= PLATFORM_DEVID_NONE,
> +	.dev		= {
> +		.dma_mask	= &vchiq_device_dmamask,
> +	}
> +

Extra blank line.

> +};
> +
> +static struct platform_device *vchiq_devices[] __initdata = {

Make it const.

> +	&bcm2835_camera,
> +	&bcm2835_audio,
> +};
>  
>  struct vchiq_drvdata {
>  	const unsigned int cache_line_size;
> @@ -1763,28 +1784,6 @@ static const struct of_device_id vchiq_of_match[] = {
>  };
>  MODULE_DEVICE_TABLE(of, vchiq_of_match);
>  
> -static struct platform_device *
> -vchiq_register_child(struct platform_device *pdev, const char *name)
> -{
> -	struct platform_device_info pdevinfo;
> -	struct platform_device *child;
> -
> -	memset(&pdevinfo, 0, sizeof(pdevinfo));
> -
> -	pdevinfo.parent = &pdev->dev;
> -	pdevinfo.name = name;
> -	pdevinfo.id = PLATFORM_DEVID_NONE;
> -	pdevinfo.dma_mask = DMA_BIT_MASK(32);
> -
> -	child = platform_device_register_full(&pdevinfo);
> -	if (IS_ERR(child)) {
> -		dev_warn(&pdev->dev, "%s not registered\n", name);
> -		child = NULL;
> -	}
> -
> -	return child;
> -}
> -
>  static int vchiq_probe(struct platform_device *pdev)
>  {
>  	struct device_node *fw_node;
> @@ -1832,8 +1831,11 @@ static int vchiq_probe(struct platform_device *pdev)
>  		goto error_exit;
>  	}
>  
> -	bcm2835_camera = vchiq_register_child(pdev, "bcm2835-camera");
> -	bcm2835_audio = vchiq_register_child(pdev, "bcm2835_audio");
> +	err = platform_add_devices(vchiq_devices, ARRAY_SIZE(vchiq_devices));
> +	if (err) {
> +		dev_warn(&pdev->dev, "Failed to add vchiq child devices");
> +		goto error_exit;
> +	}

If you unbind and rebind this driver, the platform_device instances
defined as global variables will be reused, and I'm pretty sure that
will cause issues, for instance with the kobj->state_initialized check
in kobject_init() (called from device_initialize(), itself called from
platform_device_register(), from platform_add_devices()). I'm not sure
static instances of platform_device are a very good idea in general.

>  
>  	return 0;
>  
> @@ -1845,8 +1847,9 @@ static int vchiq_probe(struct platform_device *pdev)
>  
>  static int vchiq_remove(struct platform_device *pdev)
>  {
> -	platform_device_unregister(bcm2835_audio);
> -	platform_device_unregister(bcm2835_camera);
> +	for (unsigned int i = 0; i < ARRAY_SIZE(vchiq_devices); i++)
> +		platform_device_unregister(vchiq_devices[i]);
> +
>  	vchiq_debugfs_deinit();
>  	vchiq_deregister_chrdev();
>  

-- 
Regards,

Laurent Pinchart
