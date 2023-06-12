Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B35672C9B0
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Jun 2023 17:19:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234291AbjFLPTe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Jun 2023 11:19:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237684AbjFLPTa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Jun 2023 11:19:30 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7F9D1BF;
        Mon, 12 Jun 2023 08:19:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1686583168; x=1718119168;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=PW9PXZwKMY7BWzJITAK+1Q8pomGm7fv3ToyFNWA8I7Y=;
  b=KuEAXx9Mx4s3QaoSgI/lpIEGrZcQInPCsOvVu/87bnu9CljVHo7z29ZQ
   pnk1pH1jBxXwh/mbgz6MBXopbUD5YMRh7k+uzWQ5gCO6ABeEiN8w3hgYv
   hCHhjlWUzkverUrkbdX2QNyqA1aoliFfsdINkArokG6dfThfA5vK0OIZ3
   ejGXDY4yUwNzK9Zq9Kho+vSyMs4uU693VQcAXPAtNMfTSs9uXJvgMsobe
   3HsOCSLP+azqzvT1fLHtF/BSVa+3R+N8TpmOuObLYFVmULy526baymEWj
   qaEqoHj2xNZcbLvH5EXPqf8vt8MGUWdEysFfLK8MD5Aq//P6nc50Cj1aa
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10739"; a="360556257"
X-IronPort-AV: E=Sophos;i="6.00,236,1681196400"; 
   d="scan'208";a="360556257"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jun 2023 08:19:28 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10739"; a="741066735"
X-IronPort-AV: E=Sophos;i="6.00,236,1681196400"; 
   d="scan'208";a="741066735"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga008.jf.intel.com with ESMTP; 12 Jun 2023 08:19:25 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1q8jKF-00397J-0c;
        Mon, 12 Jun 2023 18:19:23 +0300
Date:   Mon, 12 Jun 2023 18:19:22 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Sakari Ailus <sakari.ailus@linux.intel.com>
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
Message-ID: <ZIc3enu+EW93WjW7@smile.fi.intel.com>
References: <20230609154900.43024-1-andriy.shevchenko@linux.intel.com>
 <20230609154900.43024-4-andriy.shevchenko@linux.intel.com>
 <ZIbgLIEylgZsxXAB@kekkonen.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZIbgLIEylgZsxXAB@kekkonen.localdomain>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 12, 2023 at 09:06:52AM +0000, Sakari Ailus wrote:
> On Fri, Jun 09, 2023 at 06:49:00PM +0300, Andy Shevchenko wrote:

...

> > -	if (of_device_is_compatible(dev->of_node, "hisilicon,hisi-ahci"))
> > +	if (device_is_compatible(dev, "hisilicon,hisi-ahci"))
> >  		hpriv->flags |= AHCI_HFLAG_NO_FBS | AHCI_HFLAG_NO_NCQ;
> >  
> > -	port = acpi_device_get_match_data(dev);
> > +	port = device_get_match_data(dev);
> 
> There are just a handful of users for acpi_device_get_match_data() in the
> tree. The code could be moved to acpi_fwnode_device_get_match_data() after
> coverting these. May be out of scope of this set though.

Why do we need that one if we can use device_get_match_data() directly?
It will be also flexible in case one of OF code will need something like
this (custom info structure for the respective compatible string).
That said, I don't think we need to change to acpi_*() whatever.

-- 
With Best Regards,
Andy Shevchenko


