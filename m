Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 203AC72E6D1
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Jun 2023 17:15:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241267AbjFMPOk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Jun 2023 11:14:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240619AbjFMPOh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Jun 2023 11:14:37 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60050D2;
        Tue, 13 Jun 2023 08:14:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1686669276; x=1718205276;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=1dqtMpffhBApmbkC9z66BtFzjGnGgIfDciQZLOFF+e4=;
  b=hrWxgVG6OQprk8QN0YOslm7Uw9BfHk+W0crutwH4NraKrW6Hm6mEj9QH
   hUcoQQSyvqf3KEvxsCcXbxhCj6Y8F4RRlWC8XDkzQHFN7o0Q/OYJ+GLyh
   p7jLL3oeRLnPF16+FNToCVyjBzX0atZSGti4Ni9ModKiyQcoDW/kikD+m
   qbo9x/Cm5J5dum4/RSjQ5mBleN4kUtjiiyK2E/x2A+V23Gl/7IHupzfde
   hUDyjJSR4Q/0MdgETPQr1gCl0bR8gabA9J+HFGOVzib6pAeyP7nZjHWyD
   lSQtg7+B0aK7FBmXzvcMzuihK9v/rGz8Jsv+zkWoQVMDeu/M4thga86CX
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10740"; a="361731765"
X-IronPort-AV: E=Sophos;i="6.00,240,1681196400"; 
   d="scan'208";a="361731765"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jun 2023 08:14:35 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10740"; a="824427658"
X-IronPort-AV: E=Sophos;i="6.00,240,1681196400"; 
   d="scan'208";a="824427658"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga002.fm.intel.com with ESMTP; 13 Jun 2023 08:14:32 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1q95j4-003U5b-1f;
        Tue, 13 Jun 2023 18:14:30 +0300
Date:   Tue, 13 Jun 2023 18:14:30 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Serge Semin <Sergey.Semin@baikalelectronics.ru>
Cc:     Damien Le Moal <dlemoal@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-acpi@vger.kernel.org, Hans de Goede <hdegoede@redhat.com>,
        Jens Axboe <axboe@kernel.dk>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>,
        Daniel Scally <djrscally@gmail.com>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Sakari Ailus <sakari.ailus@linux.intel.com>
Subject: Re: [PATCH v2 2/3] device property: Implement device_is_compatible()
Message-ID: <ZIiH1iAbjLoUScyb@smile.fi.intel.com>
References: <20230609154900.43024-1-andriy.shevchenko@linux.intel.com>
 <20230609154900.43024-3-andriy.shevchenko@linux.intel.com>
 <20230613094508.mnmktmmt4l657ymj@mobilestation>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230613094508.mnmktmmt4l657ymj@mobilestation>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 13, 2023 at 12:45:08PM +0300, Serge Semin wrote:
> On Fri, Jun 09, 2023 at 06:48:59PM +0300, Andy Shevchenko wrote:
> > Some users want to use the struct device pointer to see if the
> > device is compatible in terms of Open Firmware specifications,
> > i.e. if it has a 'compatible' property and it matches to the
> > given value. Provide inline helper for the users.
> 
> IMO much useful wrapper. Thanks for the patch.
> Reviewed-by: Serge Semin <fancer.lancer@gmail.com>

There is a v3. Do you mind to tag it as well?

-- 
With Best Regards,
Andy Shevchenko


