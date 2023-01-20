Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 90B6B6748D0
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Jan 2023 02:28:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229805AbjATB2V (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Jan 2023 20:28:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229560AbjATB2Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jan 2023 20:28:16 -0500
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [IPv6:2001:4b98:dc2:55:216:3eff:fef7:d647])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C59432511;
        Thu, 19 Jan 2023 17:28:10 -0800 (PST)
Received: from pendragon.ideasonboard.com (213-243-189-158.bb.dnainternet.fi [213.243.189.158])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 0C919514;
        Fri, 20 Jan 2023 02:28:07 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1674178088;
        bh=X0HOvhmLDrQGLDDPb3/eIBIXq95Sy11uu6swxZDUNro=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=S/N1qMM20n53QIcvPqw6rjEWS4R4xGxt0TnZalAJmWqndBf8dn2eIVlyOhtICQUhq
         eZXlkuEGIt8FeaI6R3jiQfO1Syg154omFYP1QIHwgyoowu1/NGZYy9IqpiQimlO9LK
         Kry4gABVjr1Ix/L7r+kN78zDUXDIZEAHrJ0IJrqI=
Date:   Fri, 20 Jan 2023 03:28:05 +0200
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
        Dave Stevenson <dave.stevenson@raspberrypi.com>,
        Kieran Bingham <kieran.bingham@ideasonboard.com>,
        Paul Elder <paul.elder@ideasonboard.com>
Subject: Re: [PATCH v5 2/6] staging: vc04_services: bcm2835-audio: Drop
 include Makefile directive
Message-ID: <Y8nuJfuzW9QBcSVd@pendragon.ideasonboard.com>
References: <20230119115503.268693-1-umang.jain@ideasonboard.com>
 <20230119115503.268693-3-umang.jain@ideasonboard.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230119115503.268693-3-umang.jain@ideasonboard.com>
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

On Thu, Jan 19, 2023 at 05:24:59PM +0530, Umang Jain wrote:
> Drop the include directive they can break the build one only wants to
> build a subdirectory. Replace with "../" for the includes, in the
> bcm2835.h instead.

I assume you meant

Drop the include directive. They can break the build, when one only
wants to build a subdirectory.

> Suggested-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Signed-off-by: Umang Jain <umang.jain@ideasonboard.com>
> ---
>  drivers/staging/vc04_services/bcm2835-audio/Makefile  | 2 --
>  drivers/staging/vc04_services/bcm2835-audio/bcm2835.h | 3 ++-
>  2 files changed, 2 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/staging/vc04_services/bcm2835-audio/Makefile b/drivers/staging/vc04_services/bcm2835-audio/Makefile
> index fc7ac6112a3e..01ceebdf88e7 100644
> --- a/drivers/staging/vc04_services/bcm2835-audio/Makefile
> +++ b/drivers/staging/vc04_services/bcm2835-audio/Makefile
> @@ -1,5 +1,3 @@
>  # SPDX-License-Identifier: GPL-2.0
>  obj-$(CONFIG_SND_BCM2835)	+= snd-bcm2835.o
>  snd-bcm2835-objs		:= bcm2835.o bcm2835-ctl.o bcm2835-pcm.o bcm2835-vchiq.o
> -
> -ccflags-y += -I $(srctree)/$(src)/../include

The reason for this, I assume, is that the driver is in staging. The
vchiq.h file should live in include/linux/raspberrypi/, not
drivers/staging/vc04_services/include/linux/raspberrypi/, so an
additional include directory is added in order to use

#include <linux/raspberrypi/vchiq.h>

When the code will get out of staging, vchiq.h will go to
include/linux/raspberrypi/, the extra include directory will be dropped,
and all will be well without having to change any source file.

With this patch, we'll have to undo the change below to
drivers/staging/vc04_services/bcm2835-audio/bcm2835.h when vc04_services
will get out of staging.

Greg, is that what you prefer ?

> diff --git a/drivers/staging/vc04_services/bcm2835-audio/bcm2835.h b/drivers/staging/vc04_services/bcm2835-audio/bcm2835.h
> index 38b7451d77b2..0a81383c475a 100644
> --- a/drivers/staging/vc04_services/bcm2835-audio/bcm2835.h
> +++ b/drivers/staging/vc04_services/bcm2835-audio/bcm2835.h
> @@ -6,11 +6,12 @@
>  
>  #include <linux/device.h>
>  #include <linux/wait.h>
> -#include <linux/raspberrypi/vchiq.h>
>  #include <sound/core.h>
>  #include <sound/pcm.h>
>  #include <sound/pcm-indirect.h>
>  
> +#include "../include/linux/raspberrypi/vchiq.h"
> +
>  #define MAX_SUBSTREAMS   (8)
>  #define AVAIL_SUBSTREAMS_MASK  (0xff)
>  

-- 
Regards,

Laurent Pinchart
