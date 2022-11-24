Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D705F63743B
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Nov 2022 09:41:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230042AbiKXIlu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Nov 2022 03:41:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229790AbiKXIls (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Nov 2022 03:41:48 -0500
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64F79BCA9;
        Thu, 24 Nov 2022 00:41:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1669279307; x=1700815307;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=sjWDb836xFTamN2ETa2XyR2Y3MbHGsy8VxBoR88LjKU=;
  b=eOnwKnFK9tFsC2tWIaq9FQFML2y+hFvf2YaoaZSn8s31m4QBQI2JBHNl
   dWFX88pv+QCNGhlC3tjalUTC13DjexXnwNdYgJv0n+XHoJey8YdT0qPHm
   C5kth9kViNEqK+7oKQJgTvwSdj33WkeUyU6p44oEoR6MX+lXtaxSzJwQM
   4szCS+qnaUcV84Mgn67HtCo50chrP2vH6XQnJwMFGyGs1Zd2PW5YjIa7O
   0Tb2zE15SF7SJZpT8xIyfWFBsKpmKkOnGj+phH47lj1sSr9em50BsgnHu
   wg7GeGE/pLqXhy8wtvP+OB3G5VdKQQK6z7u10PxcMGdQvzQ7cwNCOt1Q9
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10540"; a="312953017"
X-IronPort-AV: E=Sophos;i="5.96,189,1665471600"; 
   d="scan'208";a="312953017"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Nov 2022 00:41:47 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10540"; a="705674601"
X-IronPort-AV: E=Sophos;i="5.96,189,1665471600"; 
   d="scan'208";a="705674601"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga008.fm.intel.com with ESMTP; 24 Nov 2022 00:41:44 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@intel.com>)
        id 1oy7ni-00Gf8f-2S;
        Thu, 24 Nov 2022 10:41:42 +0200
Date:   Thu, 24 Nov 2022 10:41:42 +0200
From:   Andy Shevchenko <andriy.shevchenko@intel.com>
To:     Tony Lindgren <tony@atomide.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        Jiri Slaby <jirislaby@kernel.org>,
        Johan Hovold <johan@kernel.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        linux-serial@vger.kernel.org, linux-omap@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 2/2] serial: core: Add port port device to flush TX on
 runtime resume
Message-ID: <Y38uRqAFjKpAPy8J@smile.fi.intel.com>
References: <20221123082825.32820-1-tony@atomide.com>
 <20221123082825.32820-2-tony@atomide.com>
 <Y35oT9/3OKRciWCP@smile.fi.intel.com>
 <Y38UQXbzw54Jo93s@atomide.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y38UQXbzw54Jo93s@atomide.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 24, 2022 at 08:50:41AM +0200, Tony Lindgren wrote:
> * Andy Shevchenko <andriy.shevchenko@intel.com> [221123 18:37]:
> > On Wed, Nov 23, 2022 at 10:28:25AM +0200, Tony Lindgren wrote:
> > > +EXPORT_SYMBOL(serial_port_get);
> > 
> > Can we move these to namespace from day 1?
> 
> Assuming you mean EXPORT_SYMBOL_NS(), sure.
> 
> But we might be better off doing the following:
> 
> - Move already exported uart_add_one_port() and uart_remove_one_port()
>   from serial_core to serial_port as wrapper functions for serial_core
> 
> - Export new functions in serial_core for serial_core_register_port()
>   and serial_core_unregister_port() for serial_port to call
> 
> This would ensure both serial_core and serial_port modules are
> always loaded when a hardware specific serial port driver is
> loaded.
> 
> This should also leave out the need for serial_port_get() and
> serial_port_put().

Yes, this is good idea!

-- 
With Best Regards,
Andy Shevchenko


