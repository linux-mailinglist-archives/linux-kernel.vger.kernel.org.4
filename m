Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 19AC0679B2A
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Jan 2023 15:10:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234074AbjAXOKL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Jan 2023 09:10:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234830AbjAXOKF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jan 2023 09:10:05 -0500
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 291C642BE0
        for <linux-kernel@vger.kernel.org>; Tue, 24 Jan 2023 06:10:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1674569405; x=1706105405;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=UNacka9lrZnr7IeUsHuQGraBd1jLsQWcx8Ru8TAitrM=;
  b=gDhE9TENRs4ptmQLbHfhL0hcEyKp5GJzPmyiRGPVsKPWGB7EsAGLPhId
   0YhqPkOuZ86N0rncMKczv/UXQKd1gL6Yo+fWENpP4+Yb0RVQrfS/u0J7j
   +j1yvndVLo+aUfxdLRn7OZ1QR5YoMJE+xBiFkPdC1WoWJXhMXNqLy6C2b
   C4r7fxySVzwFEfn0K2jrhbAVh6Aq6xoGN8H8gTcTsIVvmGrjNbQjUK39/
   Oh19VdyI6rD3jPIW0ZLCcIvoYm75q1p7pDbDyTfna7fq6xqUcUAwcz7xy
   fOZez/r36H6j7u4Meu9d7YFB+LnPJR5o1pXnxbictwC9ig1O8C4bErW/n
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10599"; a="412531082"
X-IronPort-AV: E=Sophos;i="5.97,242,1669104000"; 
   d="scan'208";a="412531082"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jan 2023 06:10:04 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10599"; a="804613311"
X-IronPort-AV: E=Sophos;i="5.97,242,1669104000"; 
   d="scan'208";a="804613311"
Received: from kuha.fi.intel.com ([10.237.72.185])
  by fmsmga001.fm.intel.com with SMTP; 24 Jan 2023 06:10:00 -0800
Received: by kuha.fi.intel.com (sSMTP sendmail emulation); Tue, 24 Jan 2023 16:09:59 +0200
Date:   Tue, 24 Jan 2023 16:09:59 +0200
From:   Heikki Krogerus <heikki.krogerus@linux.intel.com>
To:     Victor Ding <victording@chromium.org>
Cc:     linux-kernel@vger.kernel.org, chrome-platform@lists.linux.dev,
        lee.jones@linaro.org, groeck@chromium.org,
        enric.balletbo@collabora.com, tzungbi@kernel.org,
        sebastian.reichel@collabora.com, gregkh@linuxfoundation.org,
        gustavoars@kernel.org, bleung@chromium.org, dustin@howett.net,
        dnojiri@chromium.org, tinghan.shen@mediatek.com,
        pmalani@chromium.org
Subject: Re: [PATCH v3] platform/chrome: cros_ec_typec: allow deferred probe
 of switch handles
Message-ID: <Y8/mt7CU+t4msyix@kuha.fi.intel.com>
References: <20230124075555.v3.1.I6c0a089123fdf143f94ef4cca8677639031856cf@changeid>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230124075555.v3.1.I6c0a089123fdf143f94ef4cca8677639031856cf@changeid>
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 24, 2023 at 07:56:32AM +0000, Victor Ding wrote:
> `fwnode_typec_{retimer,mux,switch}_get()` could return `-EPROBE_DEFER`,
> which is called from `cros_typec_get_switch_handles`. When this happens,
> it does not indicate absence of switches; instead, it only hints that
> probing of switches should occur at a later time.
> 
> Progagate `-EPROBE_DEFER` to upper layer logic so that they can re-try
> probing switches as a better time.
> 
> Signed-off-by: Victor Ding <victording@chromium.org>

Reviewed-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>

> ---
> 
> Changes in v3:
> - Reverted unnecessary change.
> 
> Changes in v2:
> - Coverted switch-block to nested if-blocks.
> 
>  drivers/platform/chrome/cros_ec_typec.c | 24 ++++++++++++++++--------
>  1 file changed, 16 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/platform/chrome/cros_ec_typec.c b/drivers/platform/chrome/cros_ec_typec.c
> index 59de4ce01fab..de480ab10488 100644
> --- a/drivers/platform/chrome/cros_ec_typec.c
> +++ b/drivers/platform/chrome/cros_ec_typec.c
> @@ -145,27 +145,33 @@ static int cros_typec_get_switch_handles(struct cros_typec_port *port,
>  					 struct fwnode_handle *fwnode,
>  					 struct device *dev)
>  {
> +	int ret = 0;
> +
>  	port->mux = fwnode_typec_mux_get(fwnode, NULL);
>  	if (IS_ERR(port->mux)) {
> -		dev_dbg(dev, "Mux handle not found.\n");
> +		ret = PTR_ERR(port->mux);
> +		dev_dbg(dev, "Mux handle not found: %d.\n", ret);
>  		goto mux_err;
>  	}
>  
>  	port->retimer = fwnode_typec_retimer_get(fwnode);
>  	if (IS_ERR(port->retimer)) {
> -		dev_dbg(dev, "Retimer handle not found.\n");
> +		ret = PTR_ERR(port->retimer);
> +		dev_dbg(dev, "Retimer handle not found: %d.\n", ret);
>  		goto retimer_sw_err;
>  	}
>  
>  	port->ori_sw = fwnode_typec_switch_get(fwnode);
>  	if (IS_ERR(port->ori_sw)) {
> -		dev_dbg(dev, "Orientation switch handle not found.\n");
> +		ret = PTR_ERR(port->ori_sw);
> +		dev_dbg(dev, "Orientation switch handle not found: %d\n", ret);
>  		goto ori_sw_err;
>  	}
>  
>  	port->role_sw = fwnode_usb_role_switch_get(fwnode);
>  	if (IS_ERR(port->role_sw)) {
> -		dev_dbg(dev, "USB role switch handle not found.\n");
> +		ret = PTR_ERR(port->role_sw);
> +		dev_dbg(dev, "USB role switch handle not found: %d\n", ret);
>  		goto role_sw_err;
>  	}
>  
> @@ -181,7 +187,7 @@ static int cros_typec_get_switch_handles(struct cros_typec_port *port,
>  	typec_mux_put(port->mux);
>  	port->mux = NULL;
>  mux_err:
> -	return -ENODEV;
> +	return ret;
>  }
>  
>  static int cros_typec_add_partner(struct cros_typec_data *typec, int port_num,
> @@ -423,9 +429,11 @@ static int cros_typec_init_ports(struct cros_typec_data *typec)
>  		}
>  
>  		ret = cros_typec_get_switch_handles(cros_port, fwnode, dev);
> -		if (ret)
> -			dev_dbg(dev, "No switch control for port %d\n",
> -				port_num);
> +		if (ret) {
> +			dev_dbg(dev, "No switch control for port %d, err: %d\n", port_num, ret);
> +			if (ret == -EPROBE_DEFER)
> +				goto unregister_ports;
> +		}
>  
>  		ret = cros_typec_register_port_altmodes(typec, port_num);
>  		if (ret) {
> -- 
> 2.39.1.405.gd4c25cc71f-goog

-- 
heikki
