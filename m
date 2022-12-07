Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D56446456E2
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Dec 2022 10:53:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229727AbiLGJxY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Dec 2022 04:53:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229489AbiLGJxW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Dec 2022 04:53:22 -0500
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47DA8165B6;
        Wed,  7 Dec 2022 01:53:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1670406801; x=1701942801;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=ckCdaqkC+O54IBwNTLI3L1oxHJmIGNMoNna/nA9awds=;
  b=Rnsll2bmac+/Ow+L4CL7HNTHxHwc6oc6n4vlB4Tsj8kzXs0pkA54RHO4
   PJv10vz2hKNrw3/AgrorU+qoqM9I7DPZZoLOVFGtMisD44jBUSDgK+Fc/
   YyJSR4QxC/xYzvAoHAUJ5ZpYg6fmRfr69Qu26t0UpG0SXsCZ+pMkZyTC1
   nesB9bO1kTelwNQsvpBS5DZCtZbvs8pJj0auIJxRa2SAlZADhwWaL2QMd
   0wxYcaSVuQWEzRvXFbzgI3F4zEZxGdnXng9UKMwQHrhTr53lt9p206il0
   Dxg079UWYAw9GabbyHrJYFkNqJeGXC26jZhNmGLoVtUVW0o2uPlB+qYpj
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10553"; a="314498611"
X-IronPort-AV: E=Sophos;i="5.96,225,1665471600"; 
   d="scan'208";a="314498611"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Dec 2022 01:53:20 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10553"; a="624242066"
X-IronPort-AV: E=Sophos;i="5.96,225,1665471600"; 
   d="scan'208";a="624242066"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga006.jf.intel.com with ESMTP; 07 Dec 2022 01:53:15 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1p2r73-005hNA-0o;
        Wed, 07 Dec 2022 11:53:13 +0200
Date:   Wed, 7 Dec 2022 11:53:12 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Sakari Ailus <sakari.ailus@linux.intel.com>
Cc:     Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        =?iso-8859-1?Q?Cl=E9ment_L=E9ger?= <clement.leger@bootlin.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Daniel Scally <djrscally@gmail.com>,
        Hans de Goede <hdegoede@redhat.com>,
        linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-media@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Yong Zhi <yong.zhi@intel.com>,
        Bingbu Cao <bingbu.cao@intel.com>,
        Tianshu Qiu <tian.shu.qiu@intel.com>,
        Daniel Scally <dan.scally@ideasonboard.com>,
        Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <senozhatsky@chromium.org>
Subject: Re: [PATCH v2 1/4] media: ipu3-cio2: Don't dereference fwnode handle
Message-ID: <Y5BiiAwukaVrIvpF@smile.fi.intel.com>
References: <20221121152704.30180-1-andriy.shevchenko@linux.intel.com>
 <Y35wQuIbiCxyaOyp@smile.fi.intel.com>
 <Y5BWuXjipZcMXlan@paasikivi.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y5BWuXjipZcMXlan@paasikivi.fi.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-7.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 07, 2022 at 09:02:49AM +0000, Sakari Ailus wrote:
> On Wed, Nov 23, 2022 at 09:10:58PM +0200, Andy Shevchenko wrote:
> > Dunno what happened to my previous reply to this. Okay, trying again...
> > 
> > + Cc: Petr, Sergey
> > 
> > On Mon, Nov 21, 2022 at 05:27:01PM +0200, Andy Shevchenko wrote:
> > > Use acpi_fwnode_handle() instead of dereferencing an fwnode handle directly,
> > > which is a better coding practice.
> > 
> > It appears that this series depends on fd070e8ceb90 ("test_printf: Refactor
> > fwnode_pointer() to make it more readable") which is in PRINTK tree.
> > 
> > Sakari, Mauro, if you are okay to route this via that tree, can we get your
> > tags for that? Otherwise we need to postpone this till v6.2-rc1 (but I would
> > like to decrease the chances to appear a new user of the to be removed API).
> > 
> > Note, that Greg Acked v1 of the swnode patches (which are the same in v2).
> 
> Sorry for the late reply. Feel free to do that if it's not too late, with:
> 
> Acked-by: Sakari Ailus <sakari.ailus@linux.intel.com>

Thank you!
I think it's a bit late for printk tree to consume this. If it's the case
(Petr?) then I will submit a new version after v6.2-rc1 is out.

> I don't think the linkelihood for having a new user for this API is high.

-- 
With Best Regards,
Andy Shevchenko


