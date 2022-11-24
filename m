Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E1BE637D79
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Nov 2022 17:06:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229611AbiKXQGk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Nov 2022 11:06:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229476AbiKXQGi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Nov 2022 11:06:38 -0500
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1CE7615AAA9;
        Thu, 24 Nov 2022 08:06:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1669305998; x=1700841998;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=YvIW7uqHijKFD2vDLNW5+bbKzKM0bZDIyB8ZehT5fEs=;
  b=oB+c5kSR4Vkmc63+Yqw2ltsYyitDqme/p5zhUuqVBnZIpYTb/hMJZhvU
   c5FCJgaLFKOmenQJfuh9pL0tBLbqyw79tHUeot+uX9zI0/mlEFKbIMBfK
   kSp+g9Iw9jtwlnfFstE+0RalIfZHdpeDCBz+O64gWkAj3tHfhjTQsGdCw
   ZY/Hec5JvgJ7j9d6R3oQVQnSFc4VQDPQ5aCPcWp4Ztm1yjuO0+Ve+k0lk
   NroEmnWOqaBKbcy6JSco6CtMww+uS+sJyGX95KQNiykblDe1bRxRvFFuT
   7fwSVWYI9gnva/AwaSgjnP4wJl8dRzGNqJyuXvVxt1fqmaDKx2lFBgrtM
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10541"; a="341220935"
X-IronPort-AV: E=Sophos;i="5.96,190,1665471600"; 
   d="scan'208";a="341220935"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Nov 2022 08:06:37 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10541"; a="816891210"
X-IronPort-AV: E=Sophos;i="5.96,190,1665471600"; 
   d="scan'208";a="816891210"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga005.jf.intel.com with ESMTP; 24 Nov 2022 08:06:34 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@intel.com>)
        id 1oyEkC-00GphT-2V;
        Thu, 24 Nov 2022 18:06:32 +0200
Date:   Thu, 24 Nov 2022 18:06:32 +0200
From:   Andy Shevchenko <andriy.shevchenko@intel.com>
To:     Tony Lindgren <tony@atomide.com>
Cc:     Jiri Slaby <jirislaby@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        Johan Hovold <johan@kernel.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        linux-serial@vger.kernel.org, linux-omap@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/1] serial: core: Start managing serial controllers
 to enable runtime PM
Message-ID: <Y3+WiArMrBPTwdaq@smile.fi.intel.com>
References: <20220615062455.15490-1-tony@atomide.com>
 <Yrmfr3GfXYhclKXA@kroah.com>
 <Yrm1HaUtjTMcSIE+@atomide.com>
 <562c1505-d3bc-6422-9598-15c399e6fbba@kernel.org>
 <Y3+PoxJNJm0Pe+Xm@atomide.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y3+PoxJNJm0Pe+Xm@atomide.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 24, 2022 at 05:37:07PM +0200, Tony Lindgren wrote:
> * Jiri Slaby <jirislaby@kernel.org> [221124 06:53]:
> > On 27. 06. 22, 15:48, Tony Lindgren wrote:

...

> > And you are objecting that mostly (or in all cases?), there will never be
> > "serial controller 2"?
> 
> I'm was not aware of the need for multiple serial port controllers
> connected to a single hardware controller struct device. Is there an
> example for that somewhere?

I would be on the safest side here by assuming that's possible
(QEMU and FPGA are the first that comes to my mind of such possibilities).

-- 
With Best Regards,
Andy Shevchenko


