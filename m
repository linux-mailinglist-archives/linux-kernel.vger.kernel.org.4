Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 789246A4DFC
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Feb 2023 23:27:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229576AbjB0W0a (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Feb 2023 17:26:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229625AbjB0W01 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Feb 2023 17:26:27 -0500
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E09621E295;
        Mon, 27 Feb 2023 14:26:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1677536786; x=1709072786;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=6WX/2Onyg9x63WanP5UR91f+qXPV22K5cjEmlaSBNB8=;
  b=Sr8zY+a8J8ucD7j+AAgWeH13U3W0FNimFfPFbLt85yeqIMxAADv0yJ4o
   oGOeSeRzjA/Rr1KCWF4fPtW1up7vNel1BmG5hXTYVbsa1stK8GZUAcWPL
   xi5G99YwM4MBjZdBLoblchnm+VkV8gai/6l4CYLFWRR/j+CZ7NnmXRmc8
   o64T7gvd5OiD7lB/CflBwgWg2vK4YpgqlVr1aQoXWo3s+e+zga6G3UjyM
   TC/V1woH9uxvEoEWz1iqRHczvDsZnnDvbSWCLtTM9bxBmM+sqez2fSHit
   1KSx3++Zjk+0H/qcKF42yKGWkES6uqAbe0Gn7h60S0veknAZQi6xRWQrK
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10634"; a="336267497"
X-IronPort-AV: E=Sophos;i="5.98,220,1673942400"; 
   d="scan'208";a="336267497"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Feb 2023 14:26:25 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10634"; a="762909968"
X-IronPort-AV: E=Sophos;i="5.98,220,1673942400"; 
   d="scan'208";a="762909968"
Received: from smile.fi.intel.com ([10.237.72.54])
  by FMSMGA003.fm.intel.com with ESMTP; 27 Feb 2023 14:26:21 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1pWlwp-00D1Zn-2t;
        Tue, 28 Feb 2023 00:26:19 +0200
Date:   Tue, 28 Feb 2023 00:26:19 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Vladimir Oltean <vladimir.oltean@nxp.com>
Cc:     Daniel Scally <djrscally@gmail.com>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: Implementation of fwnode_operations :: device_get_match_data()
 for software nodes?
Message-ID: <Y/0uC1LgeWR0V0ts@smile.fi.intel.com>
References: <20230223203713.hcse3mkbq3m6sogb@skbuf>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230223203713.hcse3mkbq3m6sogb@skbuf>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 23, 2023 at 10:37:13PM +0200, Vladimir Oltean wrote:
> Hi,
> 
> I have a need to instantiate a driver written for OF which calls
> device_get_match_data(dev) to get various information based on the
> compatible string.
> 
> I am creating a software node based on the following properties:
> 
> 	struct property_entry props[2] = {
> 		PROPERTY_ENTRY_STRING("compatible", compatible),
> 		{},
> 	};
> 
> (I see I'm not the only one doing this, some drivers/platform/x86/x86-android-tablets.c
> and drivers/platform/chrome/chromeos_laptop.c also do it)
> 
> and the driver in question does begin to probe, but its match_data is
> NULL, because the operation from the title isn't implemented for
> software nodes. So probing ultimately fails.
> 
> Is there some sort or reason why this doesn't exist, other than a lack
> of need?
> 
> Can someone please help me with an implementation of this feature?

I believe that there are few reasons for that:
1) (besides that what Heikki mentioned);
2) the software nodes only for quirks, seems you are trying to implement
something that should have to be implemented as proper DT / ACPI device node.

Can you elaborate why do you need that (as you see no other board file requires
this)?

-- 
With Best Regards,
Andy Shevchenko


