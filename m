Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0BF7462BD67
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Nov 2022 13:19:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238274AbiKPMTU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Nov 2022 07:19:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233757AbiKPMSz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Nov 2022 07:18:55 -0500
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2CED19299;
        Wed, 16 Nov 2022 04:16:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1668601007; x=1700137007;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Kld9+FCgnDWWPXOQyz5B+ufruORjgyFwrxZMOIEZ/4Y=;
  b=PBYeYEewn/jx28gLRTHXR0fbv+SKRRd+DJCGzqUODX7zHVJ9l+7eH1Kw
   G8kxP3QTE4C+JAsuw1D2mK/lpnB0+MtgMaKdss2NYrMLr2UzvbsehFdi5
   4vmbQizOGfuZckH9mK/lpdgGgGyvFU3HNQbSKDrQdqDPxYvBIkzLyRbmK
   Qv0H7540zC9V/xXJ7DgPtwiGZmzBfhxHuujQpWga5LJu7TGVt7AmAprm/
   r2qzznEtS6aUX2SXIW2OqZDxnFffmbLg2Hwxv6aF/owh/zSFGmEUSdBqk
   qmEeJB/KP10ZArXBYOesSjtxRI8k9S4D7vvnPnIVJrzq4Pe1IOPmo2ckf
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10532"; a="312536543"
X-IronPort-AV: E=Sophos;i="5.96,167,1665471600"; 
   d="scan'208";a="312536543"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Nov 2022 04:16:47 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10532"; a="781746014"
X-IronPort-AV: E=Sophos;i="5.96,167,1665471600"; 
   d="scan'208";a="781746014"
Received: from kuha.fi.intel.com ([10.237.72.185])
  by fmsmga001.fm.intel.com with SMTP; 16 Nov 2022 04:16:45 -0800
Received: by kuha.fi.intel.com (sSMTP sendmail emulation); Wed, 16 Nov 2022 14:16:44 +0200
Date:   Wed, 16 Nov 2022 14:16:44 +0200
From:   Heikki Krogerus <heikki.krogerus@linux.intel.com>
To:     Sven Peter <sven@svenpeter.dev>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/4] usb: typec: tipd: Fix spurious fwnode_handle_put in
 error path
Message-ID: <Y3TUrDTZl4jM7C66@kuha.fi.intel.com>
References: <20221114174449.34634-1-sven@svenpeter.dev>
 <20221114174449.34634-2-sven@svenpeter.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221114174449.34634-2-sven@svenpeter.dev>
X-Spam-Status: No, score=-7.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 14, 2022 at 06:44:47PM +0100, Sven Peter wrote:
> The err_role_put error path always calls fwnode_handle_put to release
> the fwnode. This path can be reached after probe itself has already
> released that fwnode though. Fix that by moving fwnode_handle_put in the
> happy path to the very end.
> 
> Fixes: 18a6c866bb19 ("usb: typec: tps6598x: Add USB role switching logic")
> Signed-off-by: Sven Peter <sven@svenpeter.dev>

This looks like stable material as well.

Reviewed-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>

> ---
>  drivers/usb/typec/tipd/core.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/usb/typec/tipd/core.c b/drivers/usb/typec/tipd/core.c
> index ebc786d728e2..824e573af570 100644
> --- a/drivers/usb/typec/tipd/core.c
> +++ b/drivers/usb/typec/tipd/core.c
> @@ -834,7 +834,6 @@ static int tps6598x_probe(struct i2c_client *client)
>  		ret = PTR_ERR(tps->port);
>  		goto err_role_put;
>  	}
> -	fwnode_handle_put(fwnode);
>  
>  	if (tps->status & TPS_STATUS_PLUG_PRESENT) {
>  		ret = tps6598x_read16(tps, TPS_REG_POWER_STATUS, &tps->pwr_status);
> @@ -858,6 +857,7 @@ static int tps6598x_probe(struct i2c_client *client)
>  	}
>  
>  	i2c_set_clientdata(client, tps);
> +	fwnode_handle_put(fwnode);
>  
>  	return 0;
>  

thanks,

-- 
heikki
