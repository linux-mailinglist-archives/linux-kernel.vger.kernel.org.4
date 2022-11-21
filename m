Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 562DA633085
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Nov 2022 00:11:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230471AbiKUXL2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Nov 2022 18:11:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230448AbiKUXLC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Nov 2022 18:11:02 -0500
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [IPv6:2001:4b98:dc2:55:216:3eff:fef7:d647])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 219B0CFEAB;
        Mon, 21 Nov 2022 15:11:01 -0800 (PST)
Received: from pendragon.ideasonboard.com (62-78-145-57.bb.dnainternet.fi [62.78.145.57])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 0709B88F;
        Tue, 22 Nov 2022 00:10:57 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1669072258;
        bh=ICJPXGJqDl9B3gvjBQthmk++7OSwnmdB2if8+GkFegI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=c0fewawBZ8Edft7Kcnd4/D7sloM4SAArROsqUQe7gH6bug4V0LnxLG7Fa3I0kRmBc
         fWLWNTkZ3qskp3V5whidiHdjwUfL808skXA+CtcC7i1UQJSqSYNPO+BracngmUr2Tg
         nuOmpRnfn88GdxKjefvPsM/IFBBvIUuXYWmCT/rw=
Date:   Tue, 22 Nov 2022 01:10:42 +0200
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
Subject: Re: [PATCH 14/14] staging: vc04_services: vchiq: Load bcm2835_isp
 driver from vchiq
Message-ID: <Y3wFckW8FW8fEhDy@pendragon.ideasonboard.com>
References: <20221121214722.22563-1-umang.jain@ideasonboard.com>
 <20221121214722.22563-15-umang.jain@ideasonboard.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20221121214722.22563-15-umang.jain@ideasonboard.com>
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

On Tue, Nov 22, 2022 at 03:17:22AM +0530, Umang Jain wrote:
> From: Naushir Patuck <naush@raspberrypi.com>
> 
> bcmn2835_isp is a platform driver dependent on vchiq,
> therefore add the load/unload functions for it to vchiq.

The commit message mentiones a platform driver, but the code handles a
platform device.

The rest looks fine to me.

> Signed-off-by: Naushir Patuck <naush@raspberrypi.com>
> Signed-off-by: Umang Jain <umang.jain@ideasonboard.com>
> ---
>  drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.c b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.c
> index 642fdbc0d654..2d070f80a170 100644
> --- a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.c
> +++ b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.c
> @@ -67,6 +67,7 @@ struct vchiq_state g_state;
>  
>  static struct platform_device *bcm2835_camera;
>  static struct platform_device *bcm2835_audio;
> +static struct platform_device *bcm2835_isp;
>  static struct platform_device *vcsm_cma;
>  
>  struct vchiq_drvdata {
> @@ -1836,6 +1837,7 @@ static int vchiq_probe(struct platform_device *pdev)
>  	vcsm_cma = vchiq_register_child(pdev, "vcsm-cma");
>  	bcm2835_camera = vchiq_register_child(pdev, "bcm2835-camera");
>  	bcm2835_audio = vchiq_register_child(pdev, "bcm2835_audio");
> +	bcm2835_isp = vchiq_register_child(pdev, "bcm2835-isp");
>  
>  	return 0;
>  
> @@ -1847,6 +1849,7 @@ static int vchiq_probe(struct platform_device *pdev)
>  
>  static int vchiq_remove(struct platform_device *pdev)
>  {
> +	platform_device_unregister(bcm2835_isp);
>  	platform_device_unregister(bcm2835_audio);
>  	platform_device_unregister(bcm2835_camera);
>  	platform_device_unregister(vcsm_cma);

-- 
Regards,

Laurent Pinchart
