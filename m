Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E6FD6607E93
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Oct 2022 21:02:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230292AbiJUTCK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Oct 2022 15:02:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230190AbiJUTBq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Oct 2022 15:01:46 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E2ED2764DC;
        Fri, 21 Oct 2022 12:01:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1666378904; x=1697914904;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=KEST6tJWT2v7gvYlEM0LvQZkO/ctHEeheF3BY2Di7TQ=;
  b=ZhS158PUvMfGcMLXPVIr6r1t0zS00YXNNgVKXsS1tNYTWxB0D1VHKzQU
   Y/7PLLy3A/2UavdZGCbSBQeM4AWhoRpccS8xYIg29ceg+sMdkVYVRAEa5
   3OCQlhK6Jq5o87fgo3n6+T62GueA6gAvLxd5iYmkouFLNA3gExYT+eFw1
   g1xsREZ0Sm/yDUeVcj7vePAfstTqDzzUkpGkpoYA5ejepu3PhqPQiQi9i
   kJvAZPdr8QMJfJHA2hJJ89ksMTGIrHQK2QKzYQgkheoNxI+ViRbzum8/k
   MKqDwnnr/hUOtYq4Q+4OFATPEllL4kNc4Gr52H0DLgXcEC9ZXDmign4a6
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10507"; a="304695186"
X-IronPort-AV: E=Sophos;i="5.95,202,1661842800"; 
   d="scan'208";a="304695186"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Oct 2022 12:01:38 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10507"; a="959756321"
X-IronPort-AV: E=Sophos;i="5.95,202,1661842800"; 
   d="scan'208";a="959756321"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga005.fm.intel.com with ESMTP; 21 Oct 2022 12:01:36 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1olxGw-0009M9-1o;
        Fri, 21 Oct 2022 22:01:34 +0300
Date:   Fri, 21 Oct 2022 22:01:34 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     linuxppc-dev@lists.ozlabs.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-acpi@vger.kernel.org
Cc:     Qiang Zhao <qiang.zhao@nxp.com>, Li Yang <leoyang.li@nxp.com>,
        Daniel Scally <djrscally@gmail.com>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Sakari Ailus <sakari.ailus@linux.intel.com>
Subject: Re: [PATCH v2 0/2] gpiolib: more cleanups to get rid of of_node
Message-ID: <Y1LsjgEHXz621by6@smile.fi.intel.com>
References: <20221005152947.71696-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221005152947.71696-1-andriy.shevchenko@linux.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 05, 2022 at 06:29:45PM +0300, Andy Shevchenko wrote:
> One more user outside of GPIO library and pin control folders needs
> to be updated to use fwnode instead of of_node. To make this easier
> introduce a helper in property.h and convert the user.
> 
> Note, the helper will be useful not only for the current users,
> but any future ones that want to replace of_device_is_compatible()
> with analogous fwnode API.
> 
> Changelog v2:
> - placed new helper correctly in the property.h

Any comments on the series?

-- 
With Best Regards,
Andy Shevchenko


