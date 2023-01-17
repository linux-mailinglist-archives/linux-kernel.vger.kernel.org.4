Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CF15166DCC2
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Jan 2023 12:43:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236812AbjAQLny (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Jan 2023 06:43:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236747AbjAQLnv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jan 2023 06:43:51 -0500
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FC812DE54;
        Tue, 17 Jan 2023 03:43:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1673955830; x=1705491830;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=imB9YxQa8VlfGq2xlLTsoJA/LByTPqGbSSSCO3xAm58=;
  b=grzAoe+Yal6NTdZpGu7oSVSbKotts7odNccggVAEpxsA7SrZOZK/dfni
   TwpCzbpLigEqSiYwMUweNu+P3y98TJtuUuzVwpvqX/UibwDbf6yrkhtAN
   E2eVPvKToAj6Slt/lJfPIF0j8JcT6jBAak9+CALsDkzl97jOW4ocZxAIr
   MiLSyISM/bJzNE/Wy6xsV4XOMzE5Ji8AgyLriuGxj/Aq6KbIQ9z6NkDiW
   qFW0NRHvlOQxUKxQURDCi7kDxTFUlczrx6IaSP9CmKwB2a+Bx1sY12jCY
   9MaATyHOxAhTWEe2S/PX9hvfVoE2QtrrVJxEo5uWsW1JeU2KKvV4CY03L
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10592"; a="387024664"
X-IronPort-AV: E=Sophos;i="5.97,222,1669104000"; 
   d="scan'208";a="387024664"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jan 2023 03:43:41 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10592"; a="801717277"
X-IronPort-AV: E=Sophos;i="5.97,222,1669104000"; 
   d="scan'208";a="801717277"
Received: from kuha.fi.intel.com ([10.237.72.185])
  by fmsmga001.fm.intel.com with SMTP; 17 Jan 2023 03:43:38 -0800
Received: by kuha.fi.intel.com (sSMTP sendmail emulation); Tue, 17 Jan 2023 13:43:38 +0200
Date:   Tue, 17 Jan 2023 13:43:38 +0200
From:   Heikki Krogerus <heikki.krogerus@linux.intel.com>
To:     Prashant Malani <pmalani@chromium.org>
Cc:     linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
        bleung@chromium.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH 3/3] usb: typec: Make bus switch code retimer-aware
Message-ID: <Y8aJ6hp4WhGJ4KAG@kuha.fi.intel.com>
References: <20230112221609.540754-1-pmalani@chromium.org>
 <20230112221609.540754-4-pmalani@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230112221609.540754-4-pmalani@chromium.org>
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 12, 2023 at 10:16:08PM +0000, Prashant Malani wrote:
> Since ports can have retimers associated with them, update the Type-C
> alternate mode bus code to also set retimer state when the switch state
> is updated.
> 
> While we are here, make the typec_retimer_dev_type declaration in the
> retimer.h file as extern, so that the header file can be successfully
> included in the bus code without redeclaration compilation errors.
> 
> Signed-off-by: Prashant Malani <pmalani@chromium.org>

Reviewed-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>

> ---
>  drivers/usb/typec/bus.c     | 22 ++++++++++++++++++++++
>  drivers/usb/typec/retimer.h |  2 +-
>  2 files changed, 23 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/usb/typec/bus.c b/drivers/usb/typec/bus.c
> index 9f1bbd26ca47..0c8d554240be 100644
> --- a/drivers/usb/typec/bus.c
> +++ b/drivers/usb/typec/bus.c
> @@ -11,6 +11,22 @@
>  #include "bus.h"
>  #include "class.h"
>  #include "mux.h"
> +#include "retimer.h"
> +
> +static inline int
> +typec_altmode_set_retimer(struct altmode *alt, unsigned long conf, void *data)
> +{
> +	struct typec_retimer_state state;
> +
> +	if (!alt->retimer)
> +		return 0;
> +
> +	state.alt = &alt->adev;
> +	state.mode = conf;
> +	state.data = data;
> +
> +	return typec_retimer_set(alt->retimer, &state);
> +}
>  
>  static inline int
>  typec_altmode_set_mux(struct altmode *alt, unsigned long conf, void *data)
> @@ -31,6 +47,12 @@ typec_altmode_set_mux(struct altmode *alt, unsigned long conf, void *data)
>  static inline int
>  typec_altmode_set_switches(struct altmode *alt, unsigned long conf, void *data)
>  {
> +	int ret;
> +
> +	ret = typec_altmode_set_retimer(alt, conf, data);
> +	if (ret)
> +		return ret;
> +
>  	return typec_altmode_set_mux(alt, conf, data);
>  }
>  
> diff --git a/drivers/usb/typec/retimer.h b/drivers/usb/typec/retimer.h
> index e34bd23323be..d6a5ef9881e1 100644
> --- a/drivers/usb/typec/retimer.h
> +++ b/drivers/usb/typec/retimer.h
> @@ -12,7 +12,7 @@ struct typec_retimer {
>  
>  #define to_typec_retimer(_dev_) container_of(_dev_, struct typec_retimer, dev)
>  
> -const struct device_type typec_retimer_dev_type;
> +extern const struct device_type typec_retimer_dev_type;
>  
>  #define is_typec_retimer(dev) ((dev)->type == &typec_retimer_dev_type)
>  
> -- 
> 2.39.0.314.g84b9a713c41-goog

-- 
heikki
