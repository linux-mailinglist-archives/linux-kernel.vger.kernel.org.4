Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 93308735431
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Jun 2023 12:53:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232314AbjFSKxf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Jun 2023 06:53:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230299AbjFSKw5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Jun 2023 06:52:57 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A6C21989;
        Mon, 19 Jun 2023 03:51:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1687171903; x=1718707903;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=0gHuAJ40Q9gRcooXE/8H5FzrlZe7FbBINKYbuTzVjls=;
  b=ARRdL0dmi5bMUYZ+XBkyxCgzN/HHYTZg97k/S/WeRFCJPE4c/4kmJsPa
   h5bV7QNuD4PwXjmm2aJBBCz/2ivL/sDxESGgqADpTFozYcrwIXkzw9Yi2
   YYk35v4ou2zI0OEPTrAQSQe22TJV4gHHwF9M1X8VasO1DJ2MJpj9Rs6ev
   xZ8dubhJ3SzQssA0+28HuVsVc3i/4Ogl2f59WS7h/OFf8oDpHI4wtvItM
   GXccUoTZIOe7jqyzXysnmA0VfEcdGS0Xf33VyciholU+DFUb7RaS2o/SH
   GrzXDjEA5oN56kU/wLpTzcWbxYC77TcKg3gDLqDFMKfashOfCW2IOeJKN
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10745"; a="339214275"
X-IronPort-AV: E=Sophos;i="6.00,254,1681196400"; 
   d="scan'208";a="339214275"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jun 2023 03:51:43 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10745"; a="783666787"
X-IronPort-AV: E=Sophos;i="6.00,254,1681196400"; 
   d="scan'208";a="783666787"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga004.fm.intel.com with ESMTP; 19 Jun 2023 03:51:40 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1qBCTy-004yCe-1k;
        Mon, 19 Jun 2023 13:51:38 +0300
Date:   Mon, 19 Jun 2023 13:51:38 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-acpi@vger.kernel.org, Hans de Goede <hdegoede@redhat.com>,
        Jens Axboe <axboe@kernel.dk>,
        Damien Le Moal <dlemoal@kernel.org>,
        Len Brown <lenb@kernel.org>,
        Daniel Scally <djrscally@gmail.com>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Sakari Ailus <sakari.ailus@linux.intel.com>
Subject: Re: [PATCH v3 0/3] device property: Introduce device_is_compatible()
Message-ID: <ZJAzOpq5U98MoTOo@smile.fi.intel.com>
References: <20230612161011.86871-1-andriy.shevchenko@linux.intel.com>
 <CAJZ5v0hgNMWNtkAF7YY24cFvsnGYYYHMW1c4NekaNmyqYf=0tA@mail.gmail.com>
 <CAJZ5v0gX9h_Edj2aMcAvH=dvLTwg=+_aZbpcgbkz-8uK737SVg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJZ5v0gX9h_Edj2aMcAvH=dvLTwg=+_aZbpcgbkz-8uK737SVg@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 16, 2023 at 09:07:06PM +0200, Rafael J. Wysocki wrote:
> On Fri, Jun 16, 2023 at 7:55 PM Rafael J. Wysocki <rafael@kernel.org> wrote:
> > On Mon, Jun 12, 2023 at 6:12 PM Andy Shevchenko
> > <andriy.shevchenko@linux.intel.com> wrote:

> > > --
> >
> > All applied as 6.5 material, thanks!
> 
> But I see that Greg has taken it too, so I'll drop it.

Yep, thank you, guys!

-- 
With Best Regards,
Andy Shevchenko


