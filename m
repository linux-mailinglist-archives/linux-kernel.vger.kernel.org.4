Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 594126FAFAF
	for <lists+linux-kernel@lfdr.de>; Mon,  8 May 2023 14:11:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233588AbjEHMLW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 May 2023 08:11:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233367AbjEHMLU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 May 2023 08:11:20 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60C2624A86;
        Mon,  8 May 2023 05:11:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1683547879; x=1715083879;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=wVUf8c/kunkFyESKf/owncML98JcZqQ/1UWdjP88PRA=;
  b=Z8JqvSas4bns22GBDQiHW3srP336Ifi71AViZE/jIS9NjL3aNbVsruFY
   /5UIhstUHEqSVp7mzhvpw2Ysk/dBmPO1hcfWY6VFezERMFQFd6jFCfgb3
   +0pc4MIH145/QNoJ3ATMdj4W7eRik/gzH8849Km6+myBIH53tN3DsV4F7
   n6ynVqo4gv1SrLVcqEjn8peeAaCmKZT9NvcdO1WLhhAS1FyyiWvZ6W5XO
   eF6YeBBvaK4PKMDGWWcrjHyeeJP7zg3Ebp9Z9rjNf761V+ux2xMO7g1Uf
   tPPWFlTeYU/yZbQtrzlrFobODlcPMRAe3mxbSSmoxLdmHihZ0570mE6us
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10703"; a="349658540"
X-IronPort-AV: E=Sophos;i="5.99,258,1677571200"; 
   d="scan'208";a="349658540"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 May 2023 05:11:18 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10703"; a="788073376"
X-IronPort-AV: E=Sophos;i="5.99,258,1677571200"; 
   d="scan'208";a="788073376"
Received: from smile.fi.intel.com ([10.237.72.54])
  by FMSMGA003.fm.intel.com with ESMTP; 08 May 2023 05:11:13 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@intel.com>)
        id 1pvzhv-00AqpH-35;
        Mon, 08 May 2023 15:11:11 +0300
Date:   Mon, 8 May 2023 15:11:11 +0300
From:   Andy Shevchenko <andriy.shevchenko@intel.com>
To:     Tony Lindgren <tony@atomide.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>, Dhruva Gole <d-gole@ti.com>,
        Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        Johan Hovold <johan@kernel.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-serial@vger.kernel.org
Subject: Re: [PATCH v10 1/1] serial: core: Start managing serial controllers
 to enable runtime PM
Message-ID: <ZFjm3/aKHNKch1lA@smile.fi.intel.com>
References: <20230508110339.38699-1-tony@atomide.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230508110339.38699-1-tony@atomide.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 08, 2023 at 02:03:35PM +0300, Tony Lindgren wrote:
> We want to enable runtime PM for serial port device drivers in a generic
> way. To do this, we want to have the serial core layer manage the
> registered physical serial controller devices.
> 
> To do this, let's set up a struct bus and struct device for the serial
> core controller as suggested by Greg and Jiri. The serial core controller
> devices are children of the physical serial port device. The serial core
> controller device is needed to support multiple different kind of ports
> connected to single physical serial port device.
> 
> Let's also set up a struct device for the serial core port. The serial
> core port instances are children of the serial core controller device.
> 
> With the serial core port device we can now flush pending TX on the
> runtime PM resume as suggested by Johan.

Sorry, I'm on vacation. But just brief comments below.
In general looks good to me.

...

> -obj-$(CONFIG_SERIAL_CORE) += serial_core.o
> +obj-$(CONFIG_SERIAL_CORE) += serial_base.o
> +serial_base-objs := serial_core.o serial_base_bus.o serial_ctrl.o serial_port.o

'objs' is for user space tools, kernel should use 'y'

...

> +static DEFINE_RUNTIME_DEV_PM_OPS(serial_port_pm, NULL,
> +				 serial_port_runtime_resume, NULL);

Maybe

static DEFINE_RUNTIME_DEV_PM_OPS(serial_port_pm,
				 NULL, serial_port_runtime_resume, NULL);

for better logical split?

-- 
With Best Regards,
Andy Shevchenko


