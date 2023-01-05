Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6DDC665EA30
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Jan 2023 12:49:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232772AbjAELtR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Jan 2023 06:49:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231797AbjAELtO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jan 2023 06:49:14 -0500
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C40F3056F;
        Thu,  5 Jan 2023 03:49:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1672919353; x=1704455353;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=AlB44ILVDfhAz3wCQTSWYJqtu5wh8dBHyGkGiHnpByQ=;
  b=RP0UgnQCzzqCpOhWahFuswZWxCOufWra3xyvlKM2L6ieBSLL2e4USUIv
   M0q7qx3Zz0HU9jfbS+5ks4g+Q8HidkrUpPEI/gkTT/4Vqdl7/1bRIxtuT
   3/J+R0PfLSV2AFlu9/b5Jx2QLu90uM1k1iit793vyg3ted+2/JRMJcHp3
   sQyYMeADDY9bir5t5xQNZQDMqLCFl3Nj5CB1pRTkhk7GnutXaevS2avtB
   z/2Tj1AVWqz+PfhJDEVFYhXjfDTxB12CVtRUlmAQ4VnD8kBrOIquwovjZ
   KvSUBXVboQvSTaScx9MZ7urhLq2oxWktWUe6LEUh8/CSy40FGB6aZvBSV
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10580"; a="408435394"
X-IronPort-AV: E=Sophos;i="5.96,302,1665471600"; 
   d="scan'208";a="408435394"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jan 2023 03:49:13 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10580"; a="797901229"
X-IronPort-AV: E=Sophos;i="5.96,302,1665471600"; 
   d="scan'208";a="797901229"
Received: from kuha.fi.intel.com ([10.237.72.185])
  by fmsmga001.fm.intel.com with SMTP; 05 Jan 2023 03:49:09 -0800
Received: by kuha.fi.intel.com (sSMTP sendmail emulation); Thu, 05 Jan 2023 13:49:08 +0200
Date:   Thu, 5 Jan 2023 13:49:08 +0200
From:   Heikki Krogerus <heikki.krogerus@linux.intel.com>
To:     Jun Nie <jun.nie@linaro.org>
Cc:     gregkh@linuxfoundation.org, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, devicetree@vger.kernel.org,
        sven@svenpeter.dev, shawn.guo@linaro.org,
        bryan.odonoghue@linaro.org
Subject: Re: [PATCH 2/2] usb: typec: tipd: Support wakeup
Message-ID: <Y7a5NFMAxhuD4qEr@kuha.fi.intel.com>
References: <20230105075058.924680-1-jun.nie@linaro.org>
 <20230105075058.924680-2-jun.nie@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230105075058.924680-2-jun.nie@linaro.org>
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 05, 2023 at 03:50:58PM +0800, Jun Nie wrote:
> Enable wakeup when pluging or unpluging USB cable. It is up to other
> components to hold system in active mode, such as display, so that
> user can receive the notification.
> 
> Signed-off-by: Jun Nie <jun.nie@linaro.org>

Reviewed-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>

> ---
>  drivers/usb/typec/tipd/core.c | 38 +++++++++++++++++++++++++++++++++++
>  1 file changed, 38 insertions(+)
> 
> diff --git a/drivers/usb/typec/tipd/core.c b/drivers/usb/typec/tipd/core.c
> index 46a4d8b128f0..485b90c13078 100644
> --- a/drivers/usb/typec/tipd/core.c
> +++ b/drivers/usb/typec/tipd/core.c
> @@ -95,6 +95,7 @@ struct tps6598x {
>  	struct power_supply_desc psy_desc;
>  	enum power_supply_usb_type usb_type;
>  
> +	int wakeup;
>  	u16 pwr_status;
>  };
>  
> @@ -846,6 +847,12 @@ static int tps6598x_probe(struct i2c_client *client)
>  	i2c_set_clientdata(client, tps);
>  	fwnode_handle_put(fwnode);
>  
> +	tps->wakeup = device_property_read_bool(tps->dev, "wakeup-source");
> +	if (tps->wakeup) {
> +		device_init_wakeup(&client->dev, true);
> +		enable_irq_wake(client->irq);
> +	}
> +
>  	return 0;
>  
>  err_disconnect:
> @@ -870,6 +877,36 @@ static void tps6598x_remove(struct i2c_client *client)
>  	usb_role_switch_put(tps->role_sw);
>  }
>  
> +static int __maybe_unused tps6598x_suspend(struct device *dev)
> +{
> +	struct i2c_client *client = to_i2c_client(dev);
> +	struct tps6598x *tps = i2c_get_clientdata(client);
> +
> +	if (tps->wakeup) {
> +		disable_irq(client->irq);
> +		enable_irq_wake(client->irq);
> +	}
> +
> +	return 0;
> +}
> +
> +static int __maybe_unused tps6598x_resume(struct device *dev)
> +{
> +	struct i2c_client *client = to_i2c_client(dev);
> +	struct tps6598x *tps = i2c_get_clientdata(client);
> +
> +	if (tps->wakeup) {
> +		disable_irq_wake(client->irq);
> +		enable_irq(client->irq);
> +	}
> +
> +	return 0;
> +}
> +
> +static const struct dev_pm_ops tps6598x_pm_ops = {
> +	SET_SYSTEM_SLEEP_PM_OPS(tps6598x_suspend, tps6598x_resume)
> +};
> +
>  static const struct of_device_id tps6598x_of_match[] = {
>  	{ .compatible = "ti,tps6598x", },
>  	{ .compatible = "apple,cd321x", },
> @@ -886,6 +923,7 @@ MODULE_DEVICE_TABLE(i2c, tps6598x_id);
>  static struct i2c_driver tps6598x_i2c_driver = {
>  	.driver = {
>  		.name = "tps6598x",
> +		.pm = &tps6598x_pm_ops,
>  		.of_match_table = tps6598x_of_match,
>  	},
>  	.probe_new = tps6598x_probe,
> -- 
> 2.34.1

thanks,

-- 
heikki
