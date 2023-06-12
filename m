Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 04F2A72C5B8
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Jun 2023 15:21:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235513AbjFLNU5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Jun 2023 09:20:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229781AbjFLNUz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Jun 2023 09:20:55 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54F50B8;
        Mon, 12 Jun 2023 06:20:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1686576054; x=1718112054;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=sSKazqk8pLT68/V8f34A6Z/gkcMXHhg/HflTcf8eD9A=;
  b=J6KwkvMR37ejyMO/iQG2r4naTqztlT5llD927RwHtw21NI7LW5uvs3o3
   aW2YY8W0wCmCdWwPeNHuhcuRB7o0sLGJ1uLI0LKNKCM8rT0XZRanFCooo
   OqEHZpbSseGGfSpmp2EEovsiZGY3FljkLhzozzXEquRkyDKKxGD0lvqQc
   aAn8xyoceKRau7kfKBASlXY2ORCeS+LJJoOaAjbG1jlCq+dcvPmyDogDi
   W9b9GyPaZHEshu2Is0q6sKUyRH4J0kzYRkzHY2hkBP80BNAqKZvktnTTn
   zfR8NgrTrQeEgUDia7D5GdyHcnPR8bEUznk6yKkW79LmuteUOB62s6Ibo
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10739"; a="338396092"
X-IronPort-AV: E=Sophos;i="6.00,236,1681196400"; 
   d="scan'208";a="338396092"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jun 2023 06:20:53 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10739"; a="714401057"
X-IronPort-AV: E=Sophos;i="6.00,236,1681196400"; 
   d="scan'208";a="714401057"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga007.fm.intel.com with ESMTP; 12 Jun 2023 06:20:50 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1q8hTV-0037fa-0V;
        Mon, 12 Jun 2023 16:20:49 +0300
Date:   Mon, 12 Jun 2023 16:20:48 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Serge Semin <Sergey.Semin@baikalelectronics.ru>,
        Damien Le Moal <dlemoal@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-acpi@vger.kernel.org
Cc:     Hans de Goede <hdegoede@redhat.com>, Jens Axboe <axboe@kernel.dk>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>,
        Daniel Scally <djrscally@gmail.com>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Sakari Ailus <sakari.ailus@linux.intel.com>
Subject: Re: [PATCH v1 3/3] ata: ahci_platform: Make code agnostic to OF/ACPI
Message-ID: <ZIcbsKxxZcAhLx+N@smile.fi.intel.com>
References: <20230609152507.77649-1-andriy.shevchenko@linux.intel.com>
 <20230609152507.77649-4-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230609152507.77649-4-andriy.shevchenko@linux.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 09, 2023 at 06:25:07PM +0300, Andy Shevchenko wrote:
> With the help of a new device_is_compatible() make
> the driver code agnostic to the OF/ACPI. This makes
> it neater. As a side effect the header inclusions is
> corrected (seems mod_devicetable.h was implicitly
> included).

...

> -	if (of_device_is_compatible(dev->of_node, "hisilicon,hisi-ahci"))
> +	if (device_is_compatible(dev, "hisilicon,hisi-ahci"))
>  		hpriv->flags |= AHCI_HFLAG_NO_FBS | AHCI_HFLAG_NO_NCQ;
>  
>  	port = acpi_device_get_match_data(dev);

Oops, missed this one, will send a v2. This is Friday :-)

-- 
With Best Regards,
Andy Shevchenko


