Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6785B72DDAD
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Jun 2023 11:30:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238689AbjFMJaG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Jun 2023 05:30:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233791AbjFMJ37 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Jun 2023 05:29:59 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD1FEB7;
        Tue, 13 Jun 2023 02:29:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1686648598; x=1718184598;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=9iJSS+fYCSN4GX9xxSm4DKGKOLWhgyVoGNnqxqQ6SbY=;
  b=Yx3edj3QGpLLtRHETUdVeDc2Ldbqp2KlOiKv4ltcKpyJJmvwIZAom+Zc
   oJxtnFRFEi0TY0vg4l7wwoma6AO/xYuhBYdvRO6iZ2tyZA5tbtlBEj4pJ
   PTlUYXUyzo4wYD2+Sa3IzVDmpBWlbeV9c/7s5vksa0A5855JJAA4d9e1x
   A1NDPuX5FigbBA5nUnWr4RjE7y5m2tcOHTfpvf0uzYd2vQm/E4++LBsnG
   NYNRrWRximpbKfjKrKSQpunznjkzY/2DbmmR7Bi19o/KOvOGUPcQ2PcLN
   P4HniG5m/FglHjP0jlmDiVhuuABWdFJvtDr1XymxU+98CVIVl327FA1nh
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10739"; a="347932658"
X-IronPort-AV: E=Sophos;i="6.00,239,1681196400"; 
   d="scan'208";a="347932658"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jun 2023 02:27:31 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10739"; a="688946802"
X-IronPort-AV: E=Sophos;i="6.00,239,1681196400"; 
   d="scan'208";a="688946802"
Received: from turnipsi.fi.intel.com (HELO kekkonen.fi.intel.com) ([10.237.72.44])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jun 2023 02:27:27 -0700
Received: from kekkonen.localdomain (localhost [IPv6:::1])
        by kekkonen.fi.intel.com (Postfix) with SMTP id F3AFB1216CF;
        Tue, 13 Jun 2023 12:27:24 +0300 (EEST)
Date:   Tue, 13 Jun 2023 09:27:24 +0000
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
Message-ID: <ZIg2fAMxhHgHY1Lk@kekkonen.localdomain>
References: <20230609154900.43024-1-andriy.shevchenko@linux.intel.com>
 <20230609154900.43024-4-andriy.shevchenko@linux.intel.com>
 <ZIbgLIEylgZsxXAB@kekkonen.localdomain>
 <ZIc3enu+EW93WjW7@smile.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZIc3enu+EW93WjW7@smile.fi.intel.com>
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andy,

On Mon, Jun 12, 2023 at 06:19:22PM +0300, Andy Shevchenko wrote:
> On Mon, Jun 12, 2023 at 09:06:52AM +0000, Sakari Ailus wrote:
> > On Fri, Jun 09, 2023 at 06:49:00PM +0300, Andy Shevchenko wrote:
> 
> ...
> 
> > > -	if (of_device_is_compatible(dev->of_node, "hisilicon,hisi-ahci"))
> > > +	if (device_is_compatible(dev, "hisilicon,hisi-ahci"))
> > >  		hpriv->flags |= AHCI_HFLAG_NO_FBS | AHCI_HFLAG_NO_NCQ;
> > >  
> > > -	port = acpi_device_get_match_data(dev);
> > > +	port = device_get_match_data(dev);
> > 
> > There are just a handful of users for acpi_device_get_match_data() in the
> > tree. The code could be moved to acpi_fwnode_device_get_match_data() after
> > coverting these. May be out of scope of this set though.
> 
> Why do we need that one if we can use device_get_match_data() directly?

That was what I wanted to point your attention to. ;-)

> It will be also flexible in case one of OF code will need something like
> this (custom info structure for the respective compatible string).
> That said, I don't think we need to change to acpi_*() whatever.

I agree.

-- 
Kind regards,

Sakari Ailus
