Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7DF2C72DE4D
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Jun 2023 11:52:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233711AbjFMJwf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Jun 2023 05:52:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234891AbjFMJwb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Jun 2023 05:52:31 -0400
Received: from post.baikalelectronics.com (post.baikalelectronics.com [213.79.110.86])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 8D5EE90;
        Tue, 13 Jun 2023 02:52:29 -0700 (PDT)
Received: from post.baikalelectronics.com (localhost.localdomain [127.0.0.1])
        by post.baikalelectronics.com (Proxmox) with ESMTP id A383EE0DEC;
        Tue, 13 Jun 2023 12:52:28 +0300 (MSK)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        baikalelectronics.ru; h=cc:cc:content-type:content-type:date
        :from:from:in-reply-to:message-id:mime-version:references
        :reply-to:subject:subject:to:to; s=post; bh=hhKnhKZ4s9GqWYXGkZxF
        vGu3vgNA8L61Y7zmwmhPsUI=; b=S4aJU6/a/aTHLy6v6l4lI8OaIXtZRgVyn9ym
        jjUYeqvz+jlIcFcHTplVua7yiobrcQCIBhpU1HDrKCfMwpZ78m1Ov6eF4g4nw7D7
        Kpa8IEChTI9kXUeV4VEp3AQCy4LKsfksQnPz/avdR9EUhVRS6W2sSJJXXQziO1hb
        twVopO4=
Received: from mail.baikal.int (mail.baikal.int [192.168.51.25])
        by post.baikalelectronics.com (Proxmox) with ESMTP id 7EFFFE0DE4;
        Tue, 13 Jun 2023 12:52:28 +0300 (MSK)
Received: from mobilestation (10.8.30.34) by mail (192.168.51.25) with
 Microsoft SMTP Server (TLS) id 15.0.1395.4; Tue, 13 Jun 2023 12:52:27 +0300
Date:   Tue, 13 Jun 2023 12:52:27 +0300
From:   Serge Semin <Sergey.Semin@baikalelectronics.ru>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
CC:     Damien Le Moal <dlemoal@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        <linux-ide@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-acpi@vger.kernel.org>, Hans de Goede <hdegoede@redhat.com>,
        Jens Axboe <axboe@kernel.dk>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>,
        Daniel Scally <djrscally@gmail.com>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Sakari Ailus <sakari.ailus@linux.intel.com>
Subject: Re: [PATCH v2 3/3] ata: ahci_platform: Make code agnostic to OF/ACPI
Message-ID: <20230613095227.fr5j7i7mcdfmyxse@mobilestation>
References: <20230609154900.43024-1-andriy.shevchenko@linux.intel.com>
 <20230609154900.43024-4-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20230609154900.43024-4-andriy.shevchenko@linux.intel.com>
X-Originating-IP: [10.8.30.34]
X-ClientProxiedBy: MAIL.baikal.int (192.168.51.25) To mail (192.168.51.25)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 09, 2023 at 06:49:00PM +0300, Andy Shevchenko wrote:
> With the help of a new device_is_compatible() make
> the driver code agnostic to the OF/ACPI. This makes
> it neater. As a side effect the header inclusions is
> corrected (seems mod_devicetable.h was implicitly
> included).

I don't think the driver will get to be fully agnostic after this
patch because for instance the ahci_platform_get_resources() method
directly uses the OF-available functions, walks over the OF subnodes,
touches the OF-properties, etc. So AFAICS in order to be fully OF/ACPI
agnostic the entire libahci_platform.o driver needs to be converted
too, but it's not trivial at all.

Anyway as a start this patch looks good.
Reviewed-by: Serge Semin <fancer.lancer@gmail.com>

-Serge(y)

> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
>  drivers/ata/ahci_platform.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/ata/ahci_platform.c b/drivers/ata/ahci_platform.c
> index ab30c7138d73..81fc63f6b008 100644
> --- a/drivers/ata/ahci_platform.c
> +++ b/drivers/ata/ahci_platform.c
> @@ -9,14 +9,14 @@
>   */
>  
>  #include <linux/kernel.h>
> +#include <linux/mod_devicetable.h>
>  #include <linux/module.h>
>  #include <linux/pm.h>
>  #include <linux/device.h>
> -#include <linux/of_device.h>
>  #include <linux/platform_device.h>
> +#include <linux/property.h>
>  #include <linux/libata.h>
>  #include <linux/ahci_platform.h>
> -#include <linux/acpi.h>
>  #include <linux/pci_ids.h>
>  #include "ahci.h"
>  
> @@ -56,10 +56,10 @@ static int ahci_probe(struct platform_device *pdev)
>  	if (rc)
>  		return rc;
>  
> -	if (of_device_is_compatible(dev->of_node, "hisilicon,hisi-ahci"))
> +	if (device_is_compatible(dev, "hisilicon,hisi-ahci"))
>  		hpriv->flags |= AHCI_HFLAG_NO_FBS | AHCI_HFLAG_NO_NCQ;
>  
> -	port = acpi_device_get_match_data(dev);
> +	port = device_get_match_data(dev);
>  	if (!port)
>  		port = &ahci_port_info;
>  
> -- 
> 2.40.0.1.gaa8946217a0b
> 
> 

