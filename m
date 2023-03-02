Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D7D16A85D6
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Mar 2023 17:07:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229674AbjCBQHA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Mar 2023 11:07:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229482AbjCBQG6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Mar 2023 11:06:58 -0500
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47AF3515DA;
        Thu,  2 Mar 2023 08:06:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1677773217; x=1709309217;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=VPSx/AhyKKGPzUlJ3kgpsLe16fwtwFBjOK+GiXUPDwI=;
  b=YX2G2H/gH222sjHD5lMmSQtcQFmh37vXu2fP9+TGgpAepngRjNh5YDza
   zkcXoVMFaWE2Bi+QGpugUBK1q52M91RDs3xyzdUEmZfOxCyPK9mOIkIa7
   1fgMABi4/Idl6O10SozZCxJMnw67V9Z9NzrNHCbuvHoX2TcZ/83r61hVu
   ffG0Pxhp0Pl/iq7ksF8GOdx2qJwXoiYqR4bha4uQGmuixreIB2LasF8dE
   pHqBexl+9d/BXpT0uvdD1shw1vndmj68lvjbd4ImVJ3Ejkwk+a6b9rxKC
   UXDgIuGN2fNz/trJBRScOdLima2S1QEkYqzC+52zl5sRS5JmSXpx0Z3hC
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10637"; a="323056341"
X-IronPort-AV: E=Sophos;i="5.98,228,1673942400"; 
   d="scan'208";a="323056341"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Mar 2023 08:06:56 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10637"; a="784886444"
X-IronPort-AV: E=Sophos;i="5.98,228,1673942400"; 
   d="scan'208";a="784886444"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga002.fm.intel.com with ESMTP; 02 Mar 2023 08:06:54 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@intel.com>)
        id 1pXlSG-00EQ6E-0q;
        Thu, 02 Mar 2023 18:06:52 +0200
Date:   Thu, 2 Mar 2023 18:06:51 +0200
From:   Andy Shevchenko <andriy.shevchenko@intel.com>
To:     Tony Lindgren <tony@atomide.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        Johan Hovold <johan@kernel.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-serial@vger.kernel.org
Subject: Re: [PATCH v5 1/1] serial: core: Start managing serial controllers
 to enable runtime PM
Message-ID: <ZADJm+co4goPgr7u@smile.fi.intel.com>
References: <20230116080002.47315-1-tony@atomide.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230116080002.47315-1-tony@atomide.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 16, 2023 at 09:59:58AM +0200, Tony Lindgren wrote:
> We want to enable runtime PM for serial port device drivers in a generic
> way. To do this, we want to have the serial core layer manage the
> registered physical serial controller devices.
> 
> To do this, let's set up a struct device for the serial core controller
> as suggested by Greg and Jiri. The serial core controller devices are
> children of the physical serial port device. The serial core controller
> device is needed to support multiple different kind of ports connected
> to single physical serial port device.
> 
> Let's also set up a struct device for the serial core port. The serial
> core port instances are children of the serial core controller device.
> 
> With the serial core port device we can now flush pending TX on the
> runtime PM resume as suggested by Johan.

A side note. Perhaps it makes sense to also clean up documentation somehow
related to this change. For example, I found that
Documentation/firmware-guide/acpi/enumeration.rst has this:

  "Note that standard UARTs are not busses so there is no struct uart_device,
   although some of them may be represented by struct serdev_device."

-- 
With Best Regards,
Andy Shevchenko


