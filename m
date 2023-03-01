Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DDA166A71FC
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Mar 2023 18:22:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229777AbjCARWG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Mar 2023 12:22:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229527AbjCARWF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Mar 2023 12:22:05 -0500
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84950457F7;
        Wed,  1 Mar 2023 09:22:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1677691324; x=1709227324;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Niz37kpNrb24aJbPIb2oGvSA7MbMhlMx0//dlVBp93s=;
  b=aGSfgY39UDGczOVdOFofUnF4XPrKzxIV9Ba9aSfXrERVAjN8mDPUqmLq
   bi/2FtaNRCXaFqzXZr/LeSHuxgIS6Y8Qv1vxi+2b8/kl/PRGtYM6PdzKN
   UF9XWLS+9J1TsnOXD1isIx0FDsjsWikX1QfVu0ouLtyleGRUqsLH1KECK
   g/Cgjeb908E7RuGSMIMA7uKarjJ7LB85WRqfxPxRrRCXR5TMrrrZ+qzUb
   aLufEJEKQYutgKxVkiLVKK5pvGLAtjJvlc9pTJryKuYhXQNSUq2xZmGRP
   81HcrdfmCz2c0AR2nHJlU8gUlIrScAWKsaVEz3W6C/PpHVpSVGHMEnSWp
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10636"; a="331949389"
X-IronPort-AV: E=Sophos;i="5.98,225,1673942400"; 
   d="scan'208";a="331949389"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Mar 2023 09:21:59 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10636"; a="667933625"
X-IronPort-AV: E=Sophos;i="5.98,225,1673942400"; 
   d="scan'208";a="667933625"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga007.jf.intel.com with ESMTP; 01 Mar 2023 09:21:55 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1pXQ9K-00DqxI-0Y;
        Wed, 01 Mar 2023 19:21:54 +0200
Date:   Wed, 1 Mar 2023 19:21:53 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Henning Schild <henning.schild@siemens.com>
Cc:     Pavel Machek <pavel@ucw.cz>, Lee Jones <lee@kernel.org>,
        Hans de Goede <hdegoede@redhat.com>,
        Mark Gross <markgross@kernel.org>,
        linux-kernel@vger.kernel.org, linux-leds@vger.kernel.org,
        platform-driver-x86@vger.kernel.org
Subject: Re: [PATCH v2 1/3] leds: simatic-ipc-leds-gpio: move two extra gpio
 pins into another table
Message-ID: <Y/+JsTpONdhk/nwG@smile.fi.intel.com>
References: <20230301170215.23382-1-henning.schild@siemens.com>
 <20230301170215.23382-2-henning.schild@siemens.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230301170215.23382-2-henning.schild@siemens.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 01, 2023 at 06:02:13PM +0100, Henning Schild wrote:
> There are two special pins needed to init the LEDs. We used to have them
> at the end of the gpiod_lookup table to give to "leds-gpio". A cleaner
> way is to have a dedicated table for the special pins.

...

> +	.dev_id = NULL,

Technically speaking this is redundant. Maybe you wanted to be more explicit
with a comment like

	.dev_id = NULL,		/* Filled during initialization */

...

> +	.dev_id = NULL,

Ditto.

-- 
With Best Regards,
Andy Shevchenko


