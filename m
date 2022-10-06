Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B71135F6626
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Oct 2022 14:34:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231238AbiJFMeV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Oct 2022 08:34:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231362AbiJFMeQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Oct 2022 08:34:16 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D69E18B2F;
        Thu,  6 Oct 2022 05:34:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1665059654; x=1696595654;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=KLPlNjfONSRgkRmAk1/3zUaUpgzi9KonOZUB6whE/kI=;
  b=dhmZvqh2UDyFPxEe4xaBXs/Pn6QnSOG9iVN0RYIqyG0a30xcFswFXMws
   KyPQNfE5ljEreAOWfUxs1ENU5vkwSlUV2VUSkvjE64M8dx3oNLMicKIPJ
   90280pHFEqsVYXxKHQJ1HVBQtOOlNP9BGKs84/0pQzlb8m/BQazocs5/M
   9FQj8sTWucC8D/20ELIIBfDhxKe1CzdtunvbhlvznOVvPu3rSy303oqde
   MyKcUf7vcQmI5QrVrwfo85rs6NisUr38Q5RZTO8QwDVWeKelq7ZKKIky/
   HR6XMJJJ9DYFjrH4fTS2NwLNAQuOUZGwSucwYEYdw1DSCdIBCEqulOz4g
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10491"; a="303406042"
X-IronPort-AV: E=Sophos;i="5.95,163,1661842800"; 
   d="scan'208";a="303406042"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Oct 2022 05:34:14 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10491"; a="953601835"
X-IronPort-AV: E=Sophos;i="5.95,163,1661842800"; 
   d="scan'208";a="953601835"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga005.fm.intel.com with ESMTP; 06 Oct 2022 05:34:12 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1ogQ4o-0038tb-1b;
        Thu, 06 Oct 2022 15:34:10 +0300
Date:   Thu, 6 Oct 2022 15:34:10 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Sakari Ailus <sakari.ailus@linux.intel.com>
Cc:     linuxppc-dev@lists.ozlabs.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-acpi@vger.kernel.org, Qiang Zhao <qiang.zhao@nxp.com>,
        Li Yang <leoyang.li@nxp.com>,
        Daniel Scally <djrscally@gmail.com>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>
Subject: Re: [PATCH v2 1/2] device property: Introduce
 fwnode_device_is_compatible() helper
Message-ID: <Yz7LQuf0L29cne3I@smile.fi.intel.com>
References: <20221005152947.71696-1-andriy.shevchenko@linux.intel.com>
 <20221005152947.71696-2-andriy.shevchenko@linux.intel.com>
 <Yz3xsmy/3wlntStv@paasikivi.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Yz3xsmy/3wlntStv@paasikivi.fi.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-7.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 05, 2022 at 09:05:54PM +0000, Sakari Ailus wrote:
> On Wed, Oct 05, 2022 at 06:29:46PM +0300, Andy Shevchenko wrote:

...

> fwnode_property_match_string() returns zero on success, therefore >= 0 is
> not needed. I'd just use !fwnode_property_match_string(...).

No, it's bug in the documentation, thanks to rising an attention,
I forgot to send a fix for it earlier.

> For both patches:
> 
> Reviewed-by: Sakari Ailus <sakari.ailus@linux.intel.com>

Thanks, but as stated above the condition in my patch is correct.
It seems due to documentation bug we have some kind of "buggy" code,
luckily not too many to fix.

That said, I'm not going to resend this until PPC (Freescale) maintainers
ask for it. Yang, what's your vision on this series?

-- 
With Best Regards,
Andy Shevchenko


