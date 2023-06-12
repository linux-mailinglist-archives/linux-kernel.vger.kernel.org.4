Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A27C372BBDF
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Jun 2023 11:16:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230330AbjFLJQx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Jun 2023 05:16:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230248AbjFLJQN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Jun 2023 05:16:13 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40EF910F6;
        Mon, 12 Jun 2023 02:08:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1686560920; x=1718096920;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=J/S7V8+HVwkpJMLv53fZLJ/jvv80wurEbD2/hKCUU1o=;
  b=bK74TQ0Tt4Zay8w1tAsa69ggTMKAgNS+kwHPkzYM6lovCcphNmgz9cHd
   o+M9YEH3dW7xQDA1JSQSqALeMcHy/rucMIbk/CWrr84YhFmgWLI/qu+KN
   rJqyIwPD9139y2VFw7qaQ36UYSrPPzcKkV4zlT76u4tNRbjZVk/5+hOlv
   KbNrkIe6ztNMuma4J3o9LH91Uy0gtXjqJQGF+eS5ccG9HLda+ofQw48M0
   rgFtFEP7T0mkJL3B+RVgmbUeW3/fmO4VzBpEe4kHt2qp7bQj/CLDVEolG
   Wrw4898YETlGNuro31a0lbHoYqHsSs/jdrLsgG/k+X7vHAgzNjPkHDM1u
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10738"; a="355484770"
X-IronPort-AV: E=Sophos;i="6.00,236,1681196400"; 
   d="scan'208";a="355484770"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jun 2023 02:06:59 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10738"; a="885347093"
X-IronPort-AV: E=Sophos;i="6.00,236,1681196400"; 
   d="scan'208";a="885347093"
Received: from turnipsi.fi.intel.com (HELO kekkonen.fi.intel.com) ([10.237.72.44])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jun 2023 02:06:55 -0700
Received: from kekkonen.localdomain (localhost [IPv6:::1])
        by kekkonen.fi.intel.com (Postfix) with SMTP id 500C7120BE1;
        Mon, 12 Jun 2023 12:06:52 +0300 (EEST)
Date:   Mon, 12 Jun 2023 09:06:52 +0000
From:   Sakari Ailus <sakari.ailus@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Damien Le Moal <dlemoal@kernel.org>,
        Serge Semin <Sergey.Semin@baikalelectronics.ru>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-acpi@vger.kernel.org, Hans de Goede <hdegoede@redhat.com>,
        Jens Axboe <axboe@kernel.dk>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>,
        Daniel Scally <djrscally@gmail.com>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>
Subject: Re: [PATCH v2 3/3] ata: ahci_platform: Make code agnostic to OF/ACPI
Message-ID: <ZIbgLIEylgZsxXAB@kekkonen.localdomain>
References: <20230609154900.43024-1-andriy.shevchenko@linux.intel.com>
 <20230609154900.43024-4-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230609154900.43024-4-andriy.shevchenko@linux.intel.com>
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andy,

On Fri, Jun 09, 2023 at 06:49:00PM +0300, Andy Shevchenko wrote:
> With the help of a new device_is_compatible() make
> the driver code agnostic to the OF/ACPI. This makes
> it neater. As a side effect the header inclusions is
> corrected (seems mod_devicetable.h was implicitly
> included).
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

There are just a handful of users for acpi_device_get_match_data() in the
tree. The code could be moved to acpi_fwnode_device_get_match_data() after
coverting these. May be out of scope of this set though.

>  	if (!port)
>  		port = &ahci_port_info;
>  

-- 
Kind regards,

Sakari Ailus
