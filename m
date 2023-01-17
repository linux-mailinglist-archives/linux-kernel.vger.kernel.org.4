Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5140A66DCBD
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Jan 2023 12:42:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236672AbjAQLmo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Jan 2023 06:42:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235897AbjAQLmk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jan 2023 06:42:40 -0500
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A2219012;
        Tue, 17 Jan 2023 03:42:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1673955760; x=1705491760;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=L2Mpvw1T5mkrtqn1GsvAMIMZtRNRFrll7lHm1p+0s8k=;
  b=IIBcvQ7al0/9/X+WOoqrs9EGg8jOJTOlxQcNfbmM16cTZaZvE+OH/vzg
   nVS+lCrc83NnwocEqjbbA+EV7KJsNJkrDrfu+77tc6ZJ5BFfLkZzIiDQn
   Si63uu123bJJMfRIH+thO4gamcAJGe/V0E8jHSOvAc2W8DXVhNEdJT6Zy
   Iyj1vIfmm77aLkg3UL0/jHYRmnIAgaF0pvXPHll1n4sT/Hyu4Yi7IcuAV
   H4UOiPKqLbTq1awX0rfVpvuq+LOQRluzXGgTEVDSOT5pVbEW/0wuKdlol
   m+RKxMlr88GThjNlh9UfXlpOWhIQjfSIqEBSbuH1amKA2RpvgsM3dcZi8
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10592"; a="387024518"
X-IronPort-AV: E=Sophos;i="5.97,222,1669104000"; 
   d="scan'208";a="387024518"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jan 2023 03:42:39 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10592"; a="801716990"
X-IronPort-AV: E=Sophos;i="5.97,222,1669104000"; 
   d="scan'208";a="801716990"
Received: from kuha.fi.intel.com ([10.237.72.185])
  by fmsmga001.fm.intel.com with SMTP; 17 Jan 2023 03:42:36 -0800
Received: by kuha.fi.intel.com (sSMTP sendmail emulation); Tue, 17 Jan 2023 13:42:36 +0200
Date:   Tue, 17 Jan 2023 13:42:36 +0200
From:   Heikki Krogerus <heikki.krogerus@linux.intel.com>
To:     Prashant Malani <pmalani@chromium.org>
Cc:     linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
        bleung@chromium.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH 2/3] usb: typec: Add wrapper for bus switch set code
Message-ID: <Y8aJrND3oukulX5g@kuha.fi.intel.com>
References: <20230112221609.540754-1-pmalani@chromium.org>
 <20230112221609.540754-3-pmalani@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230112221609.540754-3-pmalani@chromium.org>
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 12, 2023 at 10:16:07PM +0000, Prashant Malani wrote:
> Add a wrapper that calls the set() function for various switches
> associated with a port altmode.
> 
> Right now, it just wraps the existing typec_mux_set() command,
> but it can be expanded to include other switches in future patches.
> 
> No functional changes introduced by this patch.
> 
> Signed-off-by: Prashant Malani <pmalani@chromium.org>

Reviewed-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>

> ---
>  drivers/usb/typec/bus.c | 11 +++++++++--
>  1 file changed, 9 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/usb/typec/bus.c b/drivers/usb/typec/bus.c
> index 31c2a3130cad..9f1bbd26ca47 100644
> --- a/drivers/usb/typec/bus.c
> +++ b/drivers/usb/typec/bus.c
> @@ -27,6 +27,13 @@ typec_altmode_set_mux(struct altmode *alt, unsigned long conf, void *data)
>  	return typec_mux_set(alt->mux, &state);
>  }
>  
> +/* Wrapper to set various Type-C port switches together. */
> +static inline int
> +typec_altmode_set_switches(struct altmode *alt, unsigned long conf, void *data)
> +{
> +	return typec_altmode_set_mux(alt, conf, data);
> +}
> +
>  static int typec_altmode_set_state(struct typec_altmode *adev,
>  				   unsigned long conf, void *data)
>  {
> @@ -35,7 +42,7 @@ static int typec_altmode_set_state(struct typec_altmode *adev,
>  
>  	port_altmode = is_port ? to_altmode(adev) : to_altmode(adev)->partner;
>  
> -	return typec_altmode_set_mux(port_altmode, conf, data);
> +	return typec_altmode_set_switches(port_altmode, conf, data);
>  }
>  
>  /* -------------------------------------------------------------------------- */
> @@ -73,7 +80,7 @@ int typec_altmode_notify(struct typec_altmode *adev,
>  	is_port = is_typec_port(adev->dev.parent);
>  	partner = altmode->partner;
>  
> -	ret = typec_altmode_set_mux(is_port ? altmode : partner, conf, data);
> +	ret = typec_altmode_set_switches(is_port ? altmode : partner, conf, data);
>  	if (ret)
>  		return ret;
>  
> -- 
> 2.39.0.314.g84b9a713c41-goog

-- 
heikki
