Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 552F5654725
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Dec 2022 21:31:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229793AbiLVUbA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Dec 2022 15:31:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229583AbiLVUa6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Dec 2022 15:30:58 -0500
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [IPv6:2001:4b98:dc2:55:216:3eff:fef7:d647])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85270101CE;
        Thu, 22 Dec 2022 12:30:56 -0800 (PST)
Received: from pendragon.ideasonboard.com (213-243-189-158.bb.dnainternet.fi [213.243.189.158])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 54CF3471;
        Thu, 22 Dec 2022 21:30:52 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1671741052;
        bh=+1jkARAbTLLjLgzzWLH5WqP65CFDkpPXBUpu0s8gVDM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=D+IuuP+uoj0/dvs3mNCGmKnxDEXKxLnS0YEjNJ21Mqtqq6QKzpgViEEMo3Z04rtt0
         PkeuUOEOX56quXb0jEBcshXwyy3o1JX6l9m+Fu3Sw9gDx4f723VI4PDHKnREbvO/hV
         sKnaT1kvpBrHfe550vSjHRhP/ZXFaUWmAqR+a5kc=
Date:   Thu, 22 Dec 2022 22:30:47 +0200
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     Umang Jain <umang.jain@ideasonboard.com>
Cc:     linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-staging@lists.linux.dev,
        linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Adrien Thierry <athierry@redhat.com>,
        Stefan Wahren <stefan.wahren@i2se.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Dan Carpenter <error27@gmail.com>,
        Nicolas Saenz Julienne <nsaenz@kernel.org>,
        Phil Elwell <phil@raspberrypi.com>,
        Dave Stevenson <dave.stevenson@raspberrypi.com>,
        Kieran Bingham <kieran.bingham@ideasonboard.com>
Subject: Re: [PATCH v2 1/4] staging: vc04_services: Stop leaking platform
 device on error path
Message-ID: <Y6S+d512bYo2BF0O@pendragon.ideasonboard.com>
References: <20221222191500.515795-1-umang.jain@ideasonboard.com>
 <20221222191500.515795-2-umang.jain@ideasonboard.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20221222191500.515795-2-umang.jain@ideasonboard.com>
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

On Fri, Dec 23, 2022 at 12:44:57AM +0530, Umang Jain wrote:
> vchiq driver registers the child platform devices in
> vchiq_register_child(). However, in the registration error code path,
> currently the driver is leaking platform devices by not destroying the
> return platform device. Plug this leak using platform_device_put() as
> mentioned in the documentation for platform_device_register().
> 
> Signed-off-by: Umang Jain <umang.jain@ideasonboard.com>
> ---
>  drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.c b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.c
> index dc33490ba7fb..fc7ea7ba97b2 100644
> --- a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.c
> +++ b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.c
> @@ -1779,6 +1779,7 @@ vchiq_register_child(struct platform_device *pdev, const char *name)
>  	child = platform_device_register_full(&pdevinfo);
>  	if (IS_ERR(child)) {
>  		dev_warn(&pdev->dev, "%s not registered\n", name);
> +		platform_device_put(child);

If IS_ERR(child), what do you expect platform_device_put(child) to do ?
And have you read the implementation of platform_device_register_full()
?

>  		child = NULL;
>  	}
>  

-- 
Regards,

Laurent Pinchart
