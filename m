Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 25C8A6748E6
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Jan 2023 02:34:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230010AbjATBeJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Jan 2023 20:34:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230023AbjATBdt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jan 2023 20:33:49 -0500
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [IPv6:2001:4b98:dc2:55:216:3eff:fef7:d647])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD34340BD5;
        Thu, 19 Jan 2023 17:33:42 -0800 (PST)
Received: from pendragon.ideasonboard.com (213-243-189-158.bb.dnainternet.fi [213.243.189.158])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 18F9F514;
        Fri, 20 Jan 2023 02:33:41 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1674178421;
        bh=9F69pML5IKaohPNvpEQRBmkT48/bJRXEmHfktbOJy4A=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=msIHbk+MIhS+IaAqqpZ6a1qU4JsDPohFBk0wlbUdMWTkXxmq/SRvuiMWpzckDcdzs
         0jiXF5qB7rYjOuAq0oLb/OjFxSGUxFdox/JDHjPQ4+oN3qa6sv8ku9i0QzwhS0jLbv
         n150m5npsM3ogBpr6NJ8WBUcsM6X1RcJgfnScNBo=
Date:   Fri, 20 Jan 2023 03:33:38 +0200
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
Subject: Re: [PATCH v5 4/6] staging: vc04_services: vchiq-mmal: Drop include
 Makefile directive
Message-ID: <Y8nvcr+4w4ph8YnA@pendragon.ideasonboard.com>
References: <20230119115503.268693-1-umang.jain@ideasonboard.com>
 <20230119115503.268693-5-umang.jain@ideasonboard.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230119115503.268693-5-umang.jain@ideasonboard.com>
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

On Thu, Jan 19, 2023 at 05:25:01PM +0530, Umang Jain wrote:
> Drop the include directive they can break the build one only wants to
> build a subdirectory. Replace with "../" for the includes, in the
> mmal-vchiq.c instead.
> 
> Suggested-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Signed-off-by: Umang Jain <umang.jain@ideasonboard.com>
> ---
>  drivers/staging/vc04_services/vchiq-mmal/Makefile     | 4 ----
>  drivers/staging/vc04_services/vchiq-mmal/mmal-vchiq.c | 2 +-
>  2 files changed, 1 insertion(+), 5 deletions(-)
> 
> diff --git a/drivers/staging/vc04_services/vchiq-mmal/Makefile b/drivers/staging/vc04_services/vchiq-mmal/Makefile
> index c7d3b06e17ce..6937f6534c26 100644
> --- a/drivers/staging/vc04_services/vchiq-mmal/Makefile
> +++ b/drivers/staging/vc04_services/vchiq-mmal/Makefile
> @@ -2,7 +2,3 @@
>  bcm2835-mmal-vchiq-objs := mmal-vchiq.o
>  
>  obj-$(CONFIG_BCM2835_VCHIQ_MMAL) += bcm2835-mmal-vchiq.o
> -
> -ccflags-y += \
> -	-I$(srctree)/$(src)/.. \
> -	-I$(srctree)/$(src)/../include

Same comments as for 2/6, although, if we decide to drop 2/6, you could
still remove the first of these two -I entries.

> diff --git a/drivers/staging/vc04_services/vchiq-mmal/mmal-vchiq.c b/drivers/staging/vc04_services/vchiq-mmal/mmal-vchiq.c
> index 6b5879a33780..234e3764db64 100644
> --- a/drivers/staging/vc04_services/vchiq-mmal/mmal-vchiq.c
> +++ b/drivers/staging/vc04_services/vchiq-mmal/mmal-vchiq.c
> @@ -23,9 +23,9 @@
>  #include <linux/slab.h>
>  #include <linux/completion.h>
>  #include <linux/vmalloc.h>
> -#include <linux/raspberrypi/vchiq.h>
>  #include <media/videobuf2-vmalloc.h>
>  
> +#include "../include/linux/raspberrypi/vchiq.h"
>  #include "mmal-common.h"
>  #include "mmal-vchiq.h"
>  #include "mmal-msg.h"

-- 
Regards,

Laurent Pinchart
