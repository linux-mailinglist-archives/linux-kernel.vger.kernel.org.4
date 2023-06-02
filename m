Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C02CB7204F4
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Jun 2023 16:54:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234815AbjFBOyg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Jun 2023 10:54:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236262AbjFBOyV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Jun 2023 10:54:21 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE75EE62;
        Fri,  2 Jun 2023 07:54:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1685717651; x=1717253651;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=y53sMR24ZEtw6YFFN78RDscItf1umgQZI1yJzYfS/mw=;
  b=bakh7aT704hmVD+Z3xH06MmXIoCi5ymcCPhHrbySd5Md7a6CkEqZJ2Xp
   gl+mFljgWYZJxv45RjnMkE94pRuNBqttzyz9XduHKNZWI3PTrEtpO+ctq
   GW8vFQUkhqrh8qQJpKWrBZ0fjpGWC45ZpJ5OrJHGqn9tAMa8o/JoOtg1d
   1BsKIuvnYE4TE+I84U6sHMmBmcYR9ulr8zvGSxwHD1kODzwFytPQt+7pl
   W3UysjKNFfSgEm1VB8HbBDc0B4fb8iaifZTvpKwKAoYmu4SwdzXKFuQ1T
   ++xNMLXYZaN3fd1UfRnHSDEfaWL1M+HkYnwQihCeGvfYvzzoZW9Jg/Sxm
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10729"; a="335500572"
X-IronPort-AV: E=Sophos;i="6.00,213,1681196400"; 
   d="scan'208";a="335500572"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jun 2023 07:53:56 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10729"; a="658297330"
X-IronPort-AV: E=Sophos;i="6.00,213,1681196400"; 
   d="scan'208";a="658297330"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga003.jf.intel.com with ESMTP; 02 Jun 2023 07:53:53 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1q56A3-000fU6-1I;
        Fri, 02 Jun 2023 17:53:51 +0300
Date:   Fri, 2 Jun 2023 17:53:51 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Tony Lindgren <tony@atomide.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>, Dhruva Gole <d-gole@ti.com>,
        Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        John Ogness <john.ogness@linutronix.de>,
        Johan Hovold <johan@kernel.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        linux-omap@vger.kernel.org, linux-serial@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/1] serial: core: Fix error handling for
 serial_core_ctrl_device_add()
Message-ID: <ZHoCf50NnIeseQT8@smile.fi.intel.com>
References: <20230602070007.59268-1-tony@atomide.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230602070007.59268-1-tony@atomide.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 02, 2023 at 10:00:05AM +0300, Tony Lindgren wrote:
> Checking for NULL is incorrect as serial_base_ctrl_add() uses ERR_PTR().
> 
> Let's also pass any returned error along, there's no reason to translate
> all errors to -ENODEV.

Jiri already asked the same question I have had on a glance, and this all
solved here, so
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

> Fixes: 84a9582fd203 ("serial: core: Start managing serial controllers to enable runtime PM")
> Signed-off-by: Tony Lindgren <tony@atomide.com>
> ---
> 
> Changes since v1:
> 
> - Stop translating all errors to -ENODEV
> 
> - There's no need to use IS_ERR_OR_NULL() as noted by Jiri
> 
> ---
>  drivers/tty/serial/serial_core.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/tty/serial/serial_core.c b/drivers/tty/serial/serial_core.c
> --- a/drivers/tty/serial/serial_core.c
> +++ b/drivers/tty/serial/serial_core.c
> @@ -3342,8 +3342,8 @@ int serial_core_register_port(struct uart_driver *drv, struct uart_port *port)
>  	ctrl_dev = serial_core_ctrl_find(drv, port->dev, port->ctrl_id);
>  	if (!ctrl_dev) {
>  		new_ctrl_dev = serial_core_ctrl_device_add(port);
> -		if (!new_ctrl_dev) {
> -			ret = -ENODEV;
> +		if (IS_ERR(new_ctrl_dev)) {
> +			ret = PTR_ERR(new_ctrl_dev);
>  			goto err_unlock;
>  		}
>  		ctrl_dev = new_ctrl_dev;
> -- 
> 2.41.0

-- 
With Best Regards,
Andy Shevchenko


