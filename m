Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E5F8C66DCAF
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Jan 2023 12:40:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236331AbjAQLkj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Jan 2023 06:40:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236427AbjAQLkX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jan 2023 06:40:23 -0500
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 457A436088;
        Tue, 17 Jan 2023 03:40:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1673955613; x=1705491613;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=v75A534qzRSw/cVLn+ju/F2mrFa9its/Ud+z5imUOSc=;
  b=MbvsviK4POVWQY0P7FjOmjMVtTTOJQsTwLHmT/Hvi2zR2QU7rpt+M5b3
   f4cYrPak02zi8qxIZBK9eSogLqu4MT41o7DpMQo5tbul6AIYCWOaAuf9S
   G9qci0RP9HuKE2UwJvlzFWDJKwcz7mVZEjR9vGtJIxTpUD39umi+zynoz
   bAVw8aMt8pvFdvRAgPThRWugDFL+YJ8s3LvEyMxTsXw3q1T6di7QQLwQ8
   MIUxAljTC5Meix1+KWJWXWoSL7IOLcLYZrCZ39MD4voOi6Qw3HdCafVSI
   XCF9l+JnzKrr0WQmoBbrtSga/XoWn2cH4SHzDHDRfUomCHXloGypH6W1n
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10592"; a="304358968"
X-IronPort-AV: E=Sophos;i="5.97,222,1669104000"; 
   d="scan'208";a="304358968"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jan 2023 03:40:13 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10592"; a="801716416"
X-IronPort-AV: E=Sophos;i="5.97,222,1669104000"; 
   d="scan'208";a="801716416"
Received: from kuha.fi.intel.com ([10.237.72.185])
  by fmsmga001.fm.intel.com with SMTP; 17 Jan 2023 03:40:10 -0800
Received: by kuha.fi.intel.com (sSMTP sendmail emulation); Tue, 17 Jan 2023 13:40:09 +0200
Date:   Tue, 17 Jan 2023 13:40:09 +0200
From:   Heikki Krogerus <heikki.krogerus@linux.intel.com>
To:     Prashant Malani <pmalani@chromium.org>
Cc:     linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
        bleung@chromium.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH 1/3] usb: typec: Add retimer handle to port altmode
Message-ID: <Y8aJGSaFzhLucZvK@kuha.fi.intel.com>
References: <20230112221609.540754-1-pmalani@chromium.org>
 <20230112221609.540754-2-pmalani@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230112221609.540754-2-pmalani@chromium.org>
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 12, 2023 at 10:16:06PM +0000, Prashant Malani wrote:
> Just like it does with muxes, the Type-C bus code can update the state
> of connected retimers (especially when altmode-related transitions
> occur). Add a retimer handle to the port altmode struct to enable this.
> 
> Signed-off-by: Prashant Malani <pmalani@chromium.org>

Reviewed-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>

> ---
>  drivers/usb/typec/bus.h   |  2 ++
>  drivers/usb/typec/class.c | 15 +++++++++++++--
>  2 files changed, 15 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/usb/typec/bus.h b/drivers/usb/typec/bus.h
> index 56dec268d4dd..c89168857417 100644
> --- a/drivers/usb/typec/bus.h
> +++ b/drivers/usb/typec/bus.h
> @@ -7,11 +7,13 @@
>  
>  struct bus_type;
>  struct typec_mux;
> +struct typec_retimer;
>  
>  struct altmode {
>  	unsigned int			id;
>  	struct typec_altmode		adev;
>  	struct typec_mux		*mux;
> +	struct typec_retimer		*retimer;
>  
>  	enum typec_port_data		roles;
>  
> diff --git a/drivers/usb/typec/class.c b/drivers/usb/typec/class.c
> index 5897905cb4f0..ed3d070b1ca4 100644
> --- a/drivers/usb/typec/class.c
> +++ b/drivers/usb/typec/class.c
> @@ -583,6 +583,7 @@ void typec_unregister_altmode(struct typec_altmode *adev)
>  {
>  	if (IS_ERR_OR_NULL(adev))
>  		return;
> +	typec_retimer_put(to_altmode(adev)->retimer);
>  	typec_mux_put(to_altmode(adev)->mux);
>  	device_unregister(&adev->dev);
>  }
> @@ -2108,16 +2109,26 @@ typec_port_register_altmode(struct typec_port *port,
>  {
>  	struct typec_altmode *adev;
>  	struct typec_mux *mux;
> +	struct typec_retimer *retimer;
>  
>  	mux = typec_mux_get(&port->dev, desc);
>  	if (IS_ERR(mux))
>  		return ERR_CAST(mux);
>  
> +	retimer = typec_retimer_get(&port->dev);
> +	if (IS_ERR(retimer)) {
> +		typec_mux_put(mux);
> +		return ERR_CAST(retimer);
> +	}
> +
>  	adev = typec_register_altmode(&port->dev, desc);
> -	if (IS_ERR(adev))
> +	if (IS_ERR(adev)) {
> +		typec_retimer_put(retimer);
>  		typec_mux_put(mux);
> -	else
> +	} else {
>  		to_altmode(adev)->mux = mux;
> +		to_altmode(adev)->retimer = retimer;
> +	}
>  
>  	return adev;
>  }
> -- 
> 2.39.0.314.g84b9a713c41-goog

-- 
heikki
