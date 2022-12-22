Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 849656545A5
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Dec 2022 18:36:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230161AbiLVRgJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Dec 2022 12:36:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229952AbiLVRgG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Dec 2022 12:36:06 -0500
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9C1E1A227;
        Thu, 22 Dec 2022 09:36:02 -0800 (PST)
Received: from pendragon.ideasonboard.com (213-243-189-158.bb.dnainternet.fi [213.243.189.158])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 84DCC471;
        Thu, 22 Dec 2022 18:35:59 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1671730559;
        bh=hijU5pTXB9YZuj+LHk38stTpLiPyJVSZ9fnlhqOpl6U=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ZfjxJDyvMexcyKmDO90zNzxc5PBx4obzRRTCt0NCsODTJtAA4ePHWp1NSQLNf8qS0
         8HKCuBYz31mwT0gpEzW+q/n2izA0iLxyad05Vc2aUyqd/EWNz9Ks/5Yn3G9/j4cueX
         JEc6+v3RGhX+ImnYDq9VHb8xqWMJNWe+KSpwTdUg=
Date:   Thu, 22 Dec 2022 19:35:54 +0200
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     Umang Jain <umang.jain@ideasonboard.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev,
        linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-media@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Stefan Wahren <stefan.wahren@i2se.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Adrien Thierry <athierry@redhat.com>,
        Dan Carpenter <error27@gmail.com>,
        Nicolas Saenz Julienne <nsaenz@kernel.org>,
        Phil Elwell <phil@raspberrypi.com>,
        Dave Stevenson <dave.stevenson@raspberrypi.com>,
        Kieran Bingham <kieran.bingham@ideasonboard.com>
Subject: Re: [PATCH] staging: vc04_services: vchiq_arm: Create
 platform_device per device
Message-ID: <Y6SVegtHvwQ3p+3K@pendragon.ideasonboard.com>
References: <20221220084404.19280-1-umang.jain@ideasonboard.com>
 <Y6Lqs8RUiyi452gM@pendragon.ideasonboard.com>
 <Y6MF3l40WM3onmyO@kroah.com>
 <d48462f6-de4c-2816-0a7a-b3b13993604c@ideasonboard.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <d48462f6-de4c-2816-0a7a-b3b13993604c@ideasonboard.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Umang,

On Thu, Dec 22, 2022 at 01:59:28PM +0530, Umang Jain wrote:
> On 12/21/22 6:40 PM, Greg Kroah-Hartman wrote:
> > On Wed, Dec 21, 2022 at 01:14:59PM +0200, Laurent Pinchart wrote:
> >> On Tue, Dec 20, 2022 at 02:14:04PM +0530, Umang Jain wrote:
> >>> Create a proper per device platorm_device structure for all the child
> >>> devices that needs to be registered by vchiq platform driver. Replace
> >>> the vchiq_register_child() with platform_add_devices() to register the
> >>> child devices.
> >>
> >> This explains what the patch does, but not why.
> >>
> >>> This is part of an effort to address TODO item "Get rid of all non
> >>> essential global structures and create a proper per device structure"
> >>
> >> And this explains part of the reason only. Could you please expand the
> >> commit message with the reasoning behind this change ? It's not clear
> >> from the change below why this is needed and good.
> 
> Ok, I thought the TODO reference was sufficient but I'll expand on it.
>
> >>> Signed-off-by: Umang Jain <umang.jain@ideasonboard.com>
> >>> ---
> >>>   .../interface/vchiq_arm/vchiq_arm.c           | 59 ++++++++++---------
> >>>   1 file changed, 31 insertions(+), 28 deletions(-)
> >>>
> >>> diff --git a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.c b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.c
> >>> index 22de23f3af02..fa42ea3791a7 100644
> >>> --- a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.c
> >>> +++ b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.c
> >>> @@ -65,8 +65,29 @@ int vchiq_susp_log_level = VCHIQ_LOG_ERROR;
> >>>   DEFINE_SPINLOCK(msg_queue_spinlock);
> >>>   struct vchiq_state g_state;
> >>>   
> >>> -static struct platform_device *bcm2835_camera;
> >>> -static struct platform_device *bcm2835_audio;
> >>> +static u64 vchiq_device_dmamask = DMA_BIT_MASK(32);
> >>
> >> The fact that this isn't const and is used by two different
> >> platform_device instances is worrying. Either it can be made const, or
> >> it's wrong.
> 
> ack.
>
> >>> +
> >>> +static struct platform_device bcm2835_camera = {
> >>> +	.name		= "bcm2835-camera",
> >>> +	.id		= PLATFORM_DEVID_NONE,
> >>> +	.dev		= {
> >>> +		.dma_mask	= &vchiq_device_dmamask,
> >>> +	}
> >>> +};
> >>> +
> >>> +static struct platform_device bcm2835_audio = {
> >>> +	.name		= "bcm2835_audio",
> >>> +	.id		= PLATFORM_DEVID_NONE,
> >>> +	.dev		= {
> >>> +		.dma_mask	= &vchiq_device_dmamask,
> >>> +	}
> >>> +
> >>
> >> Extra blank line.
> 
> oops, checkpatch.pl didn't catch this :-/
>
> >>> +};
> >>> +
> >>> +static struct platform_device *vchiq_devices[] __initdata = {
> >> Make it const.
> >>
> >>> +	&bcm2835_camera,
> >>> +	&bcm2835_audio,
> >>> +};
> >>>   
> >>>   struct vchiq_drvdata {
> >>>   	const unsigned int cache_line_size;
> >>> @@ -1763,28 +1784,6 @@ static const struct of_device_id vchiq_of_match[] = {
> >>>   };
> >>>   MODULE_DEVICE_TABLE(of, vchiq_of_match);
> >>>   
> >>> -static struct platform_device *
> >>> -vchiq_register_child(struct platform_device *pdev, const char *name)
> >>> -{
> >>> -	struct platform_device_info pdevinfo;
> >>> -	struct platform_device *child;
> >>> -
> >>> -	memset(&pdevinfo, 0, sizeof(pdevinfo));
> >>> -
> >>> -	pdevinfo.parent = &pdev->dev;
> >>> -	pdevinfo.name = name;
> >>> -	pdevinfo.id = PLATFORM_DEVID_NONE;
> >>> -	pdevinfo.dma_mask = DMA_BIT_MASK(32);
> >>> -
> >>> -	child = platform_device_register_full(&pdevinfo);
> >>> -	if (IS_ERR(child)) {
> >>> -		dev_warn(&pdev->dev, "%s not registered\n", name);
> >>> -		child = NULL;
> >>> -	}
> >>> -
> >>> -	return child;
> >>> -}
> >>> -
> >>>   static int vchiq_probe(struct platform_device *pdev)
> >>>   {
> >>>   	struct device_node *fw_node;
> >>> @@ -1832,8 +1831,11 @@ static int vchiq_probe(struct platform_device *pdev)
> >>>   		goto error_exit;
> >>>   	}
> >>>   
> >>> -	bcm2835_camera = vchiq_register_child(pdev, "bcm2835-camera");
> >>> -	bcm2835_audio = vchiq_register_child(pdev, "bcm2835_audio");
> >>> +	err = platform_add_devices(vchiq_devices, ARRAY_SIZE(vchiq_devices));
> >>> +	if (err) {
> >>> +		dev_warn(&pdev->dev, "Failed to add vchiq child devices");
> >>> +		goto error_exit;
> >>> +	}
> >>
> >> If you unbind and rebind this driver, the platform_device instances
> >> defined as global variables will be reused, and I'm pretty sure that
> >> will cause issues, for instance with the kobj->state_initialized check
> >> in kobject_init() (called from device_initialize(), itself called from
> >> platform_device_register(), from platform_add_devices()). I'm not sure
> >> static instances of platform_device are a very good idea in general.
> >
> > static instances of any device are a horrible idea, but it seems that
> > many drivers do this and abuse platform devices this way :(
> 
> It seems  I have been a victim of the abuse usage while looking for 
> platform_device references in the codebase. I'm working on a new 
> approach for this.
> 
> Currently (as per the linux-next branch), the vchiq driver will happily 
> carry on if any of the child  platform device registration fails. That 
> means if bcm2835-audio fails to register, bcm2835-camera will  still 
> kept registered I suppose.
> 
> However with usage of platform_add_devices() in this patch, I introduced 
> a functionality change (I'm realizing this now) - any failure of child 
> platform device registeration will -unregister- all the other platform 
> devices i.e. if bcm2835-audio fails, bcm2835-camera will also get 
> unregistered.
> 
> Should I be working towards the status-quo behavior ? Or it's sane to 
> unregistered other platform devices if one of the fails like 
> platform_add_devices() does ? (This affects my new approach as well, 
> hence the question)

If it doesn't cause too much extra complexity, it would be nice to skip
devices that can't be registered successfully, and still support the
other ones. I don't expect registration failures to be a occuring
normally, so if this causes too much completely, I think it would still
be fine to fail more harshly.

> > Ideally this should be done properly, with the correct devices created
> > automatically based on the device tree structure, NOT hard-coded into a
> > .c file like this.
> >
> > So I too really do not like this change, why are these not being created
> > by the firware layer automatically?
> 
> Not sure if this is a helpful comment, but as far I know, there can be 
> vchiq child platform devices which probably don't have a Device tree 
> entry. like the bcm2835-isp [1] I posted earlier.
> 
> [1] https://lore.kernel.org/lkml/20221121214722.22563-1-umang.jain@ideasonboard.com/

Those devices are implemented and exposed by the firmware running on the
VC4. The device tree describes the VC4 itself with the resources
required to communicate with it through a mailbox interface. I was going
to say that the platform devices are then created based on what the
firmware exposes, but that's not right, they're indeed hardcoded in the
vchiq driver. Adding corresponding DT nodes (as children of the vchiq DT
node) could make sense. Dave, do you have any opinion on this ?

-- 
Regards,

Laurent Pinchart
