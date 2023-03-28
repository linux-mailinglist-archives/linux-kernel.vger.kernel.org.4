Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E37D66CC160
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Mar 2023 15:51:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230505AbjC1NvL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Mar 2023 09:51:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229532AbjC1NvI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Mar 2023 09:51:08 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F5921A5;
        Tue, 28 Mar 2023 06:51:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1680011467; x=1711547467;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=4f34PnpSuMKxCqB8q6OdwG/bM/9+5JldPB2xfHWuiwM=;
  b=YeO+3fZIqNCQ8+ZWRZ6Dh72ua7v6rzaInbIaIGhLBqchopCOiQXDeSln
   zrxg+GCvVGYSgsG65hBCnwODanAyAGjgbM2P0zTFC5CWjuAq9B9aG5SrP
   Do2KD47z7UWdxr77MClTOh/SkakMmGNFlOnRdOePJdbsvintNSma7i7s1
   AnzUzlkUlBhChd4yt8+8MKRHIHBGYDDqkQCRB7D9nGaQyZJHw2LGa5CNx
   LBiy9g4Hnoax/BFjczDO6AxyixaLtzKz9QdqBIqcvJMBaBx84R6s4utyR
   kZURL8LUFE+h0wdKRwk/Zs1LIW6OumUZKGui7yq4Y5ldb+UR3JjGOCPpu
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10662"; a="320967280"
X-IronPort-AV: E=Sophos;i="5.98,297,1673942400"; 
   d="scan'208";a="320967280"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Mar 2023 06:51:07 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10662"; a="827483837"
X-IronPort-AV: E=Sophos;i="5.98,297,1673942400"; 
   d="scan'208";a="827483837"
Received: from kuha.fi.intel.com ([10.237.72.185])
  by fmsmga001.fm.intel.com with SMTP; 28 Mar 2023 06:51:04 -0700
Received: by kuha.fi.intel.com (sSMTP sendmail emulation); Tue, 28 Mar 2023 16:51:03 +0300
Date:   Tue, 28 Mar 2023 16:51:03 +0300
From:   Heikki Krogerus <heikki.krogerus@linux.intel.com>
To:     Roger Quadros <rogerq@kernel.org>
Cc:     gregkh@linuxfoundation.org, vigneshr@ti.com, srk@ti.com,
        r-gunasekaran@ti.com, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Aswath Govindraju <a-govindraju@ti.com>
Subject: Re: [PATCH] usb: typec: tps6598x: Add support for polling interrupts
 status
Message-ID: <ZCLwx8hU8V+nkzcS@kuha.fi.intel.com>
References: <20230324131853.41102-1-rogerq@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230324131853.41102-1-rogerq@kernel.org>
X-Spam-Status: No, score=-2.4 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 24, 2023 at 03:18:53PM +0200, Roger Quadros wrote:
> From: Aswath Govindraju <a-govindraju@ti.com>
> 
> Some development boards don't have the interrupt line connected.
> 
> In such cases we can resort to polling the interrupt status.
> 
> Signed-off-by: Aswath Govindraju <a-govindraju@ti.com>
> Signed-off-by: Roger Quadros <rogerq@kernel.org>

Reviewed-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>

> ---
>  drivers/usb/typec/tipd/core.c | 41 ++++++++++++++++++++++++++++++-----
>  1 file changed, 36 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/usb/typec/tipd/core.c b/drivers/usb/typec/tipd/core.c
> index 485b90c13078..d28ffa10a122 100644
> --- a/drivers/usb/typec/tipd/core.c
> +++ b/drivers/usb/typec/tipd/core.c
> @@ -16,6 +16,7 @@
>  #include <linux/usb/typec.h>
>  #include <linux/usb/typec_altmode.h>
>  #include <linux/usb/role.h>
> +#include <linux/workqueue.h>
>  
>  #include "tps6598x.h"
>  #include "trace.h"
> @@ -97,6 +98,8 @@ struct tps6598x {
>  
>  	int wakeup;
>  	u16 pwr_status;
> +	struct delayed_work	wq_poll;
> +	irq_handler_t irq_handler;
>  };
>  
>  static enum power_supply_property tps6598x_psy_props[] = {
> @@ -568,6 +571,18 @@ static irqreturn_t tps6598x_interrupt(int irq, void *data)
>  	return IRQ_NONE;
>  }
>  
> +/* Time interval for Polling */
> +#define POLL_INTERVAL	500 /* msecs */
> +static void tps6598x_poll_work(struct work_struct *work)
> +{
> +	struct tps6598x *tps = container_of(to_delayed_work(work),
> +					    struct tps6598x, wq_poll);
> +
> +	tps->irq_handler(0, tps);
> +	queue_delayed_work(system_power_efficient_wq,
> +			   &tps->wq_poll, msecs_to_jiffies(POLL_INTERVAL));
> +}
> +
>  static int tps6598x_check_mode(struct tps6598x *tps)
>  {
>  	char mode[5] = { };
> @@ -746,6 +761,7 @@ static int tps6598x_probe(struct i2c_client *client)
>  			TPS_REG_INT_PLUG_EVENT;
>  	}
>  
> +	tps->irq_handler = irq_handler;
>  	/* Make sure the controller has application firmware running */
>  	ret = tps6598x_check_mode(tps);
>  	if (ret)
> @@ -837,10 +853,18 @@ static int tps6598x_probe(struct i2c_client *client)
>  			dev_err(&client->dev, "failed to register partner\n");
>  	}
>  
> -	ret = devm_request_threaded_irq(&client->dev, client->irq, NULL,
> -					irq_handler,
> -					IRQF_SHARED | IRQF_ONESHOT,
> -					dev_name(&client->dev), tps);
> +	if (client->irq) {
> +		ret = devm_request_threaded_irq(&client->dev, client->irq, NULL,
> +						irq_handler,
> +						IRQF_SHARED | IRQF_ONESHOT,
> +						dev_name(&client->dev), tps);
> +	} else {
> +		dev_warn(tps->dev, "Unable to find the interrupt, switching to polling\n");
> +		INIT_DELAYED_WORK(&tps->wq_poll, tps6598x_poll_work);
> +		queue_delayed_work(system_power_efficient_wq, &tps->wq_poll,
> +				   msecs_to_jiffies(POLL_INTERVAL));
> +	}
> +
>  	if (ret)
>  		goto err_disconnect;
>  
> @@ -848,7 +872,7 @@ static int tps6598x_probe(struct i2c_client *client)
>  	fwnode_handle_put(fwnode);
>  
>  	tps->wakeup = device_property_read_bool(tps->dev, "wakeup-source");
> -	if (tps->wakeup) {
> +	if (tps->wakeup && client->irq) {
>  		device_init_wakeup(&client->dev, true);
>  		enable_irq_wake(client->irq);
>  	}
> @@ -887,6 +911,9 @@ static int __maybe_unused tps6598x_suspend(struct device *dev)
>  		enable_irq_wake(client->irq);
>  	}
>  
> +	if (!client->irq)
> +		cancel_delayed_work_sync(&tps->wq_poll);
> +
>  	return 0;
>  }
>  
> @@ -900,6 +927,10 @@ static int __maybe_unused tps6598x_resume(struct device *dev)
>  		enable_irq(client->irq);
>  	}
>  
> +	if (client->irq)
> +		queue_delayed_work(system_power_efficient_wq, &tps->wq_poll,
> +				   msecs_to_jiffies(POLL_INTERVAL));
> +
>  	return 0;
>  }
>  
> -- 
> 2.34.1

-- 
heikki
