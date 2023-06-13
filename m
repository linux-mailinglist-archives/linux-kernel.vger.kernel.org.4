Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E13772DE0B
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Jun 2023 11:45:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240098AbjFMJpV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Jun 2023 05:45:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241789AbjFMJpO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Jun 2023 05:45:14 -0400
Received: from post.baikalelectronics.com (post.baikalelectronics.com [213.79.110.86])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id C9A7AAC;
        Tue, 13 Jun 2023 02:45:10 -0700 (PDT)
Received: from post.baikalelectronics.com (localhost.localdomain [127.0.0.1])
        by post.baikalelectronics.com (Proxmox) with ESMTP id 494B9E0DEC;
        Tue, 13 Jun 2023 12:45:09 +0300 (MSK)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        baikalelectronics.ru; h=cc:cc:content-type:content-type:date
        :from:from:in-reply-to:message-id:mime-version:references
        :reply-to:subject:subject:to:to; s=post; bh=j7ofUeP49paxvIgDMuJ8
        em4j9tJ1KL/nPsMR7budhZA=; b=odWiLvP75WDQntxsQowgHxcFLsn2NozBrF5K
        27xbiiIbFZHCz9o4m3q7GzI1V897l5Un6LPwXudI8S+QIAKkeB23pWMfKN2bmb/v
        PoSe6N7qykf654Pg+SRBD8MFTG5x1I8IustJ+PEBnTvIbnSxQVD+a3xVj/DNNyYP
        SC/LGPY=
Received: from mail.baikal.int (mail.baikal.int [192.168.51.25])
        by post.baikalelectronics.com (Proxmox) with ESMTP id 1F878E0DE4;
        Tue, 13 Jun 2023 12:45:09 +0300 (MSK)
Received: from mobilestation (10.8.30.34) by mail (192.168.51.25) with
 Microsoft SMTP Server (TLS) id 15.0.1395.4; Tue, 13 Jun 2023 12:45:08 +0300
Date:   Tue, 13 Jun 2023 12:45:08 +0300
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
Subject: Re: [PATCH v2 2/3] device property: Implement device_is_compatible()
Message-ID: <20230613094508.mnmktmmt4l657ymj@mobilestation>
References: <20230609154900.43024-1-andriy.shevchenko@linux.intel.com>
 <20230609154900.43024-3-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20230609154900.43024-3-andriy.shevchenko@linux.intel.com>
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

On Fri, Jun 09, 2023 at 06:48:59PM +0300, Andy Shevchenko wrote:
> Some users want to use the struct device pointer to see if the
> device is compatible in terms of Open Firmware specifications,
> i.e. if it has a 'compatible' property and it matches to the
> given value. Provide inline helper for the users.

IMO much useful wrapper. Thanks for the patch.
Reviewed-by: Serge Semin <fancer.lancer@gmail.com>

-Serge(y)

> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
>  include/linux/property.h | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
> 
> diff --git a/include/linux/property.h b/include/linux/property.h
> index 695053c60306..0222b77dd75c 100644
> --- a/include/linux/property.h
> +++ b/include/linux/property.h
> @@ -85,6 +85,18 @@ bool fwnode_device_is_compatible(const struct fwnode_handle *fwnode, const char
>  	return fwnode_property_match_string(fwnode, "compatible", compat) >= 0;
>  }
>  
> +/**
> + * device_is_compatible - match 'compatible' property of the device with a given string
> + * @dev: Pointer to the struct device
> + * @compat: The string to match 'compatible' property with
> + *
> + * Returns: true if matches, otherwise false.
> + */
> +static inline bool device_is_compatible(const struct device *dev, const char *compat)
> +{
> +	return fwnode_device_is_compatible(dev_fwnode(dev), compat);
> +}
> +
>  int fwnode_property_get_reference_args(const struct fwnode_handle *fwnode,
>  				       const char *prop, const char *nargs_prop,
>  				       unsigned int nargs, unsigned int index,
> -- 
> 2.40.0.1.gaa8946217a0b
> 
> 

