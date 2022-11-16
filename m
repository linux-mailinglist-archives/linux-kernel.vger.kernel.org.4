Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 207A362BDF5
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Nov 2022 13:32:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232682AbiKPMcO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Nov 2022 07:32:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238967AbiKPMbH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Nov 2022 07:31:07 -0500
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85B731CF;
        Wed, 16 Nov 2022 04:30:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1668601847; x=1700137847;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=0fqitcSpYPi7eQtQF6HsWfypBSjjcqsdoukUK+6sJgA=;
  b=SNp41xo1eqb5fEP78mLPtKpdBjut6xR4GSIv5Sajv5KfTFc7pwvmXDxF
   gG5NbeucLoMIWn454eCb2USMIrOTzPFVh9fR5jFjA0Gg4uWQShtjCBVYc
   C7ezG0Bt5TABQdOru07AQm7NQY+sRTJBErWE5LSsr1CHSEWi1B/FAso2P
   xrETdUSaWN3nuK1x0ivXl6Mn+IXitFYpkIWa89YukpB1F3jlsNshxnvSp
   8xFIQNw6FRstfhDc640ZyTY6BZOvMvqEXzZSL67TX10dinnQTUU7tf66E
   LCoeRdm1u7FbDi2M4RguUp/ElIrcMWGSDB7UqD1AzEE+gWw7ZH7AnFaQv
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10532"; a="374664613"
X-IronPort-AV: E=Sophos;i="5.96,167,1665471600"; 
   d="scan'208";a="374664613"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Nov 2022 04:30:47 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10532"; a="781749769"
X-IronPort-AV: E=Sophos;i="5.96,167,1665471600"; 
   d="scan'208";a="781749769"
Received: from kuha.fi.intel.com ([10.237.72.185])
  by fmsmga001.fm.intel.com with SMTP; 16 Nov 2022 04:30:44 -0800
Received: by kuha.fi.intel.com (sSMTP sendmail emulation); Wed, 16 Nov 2022 14:30:44 +0200
Date:   Wed, 16 Nov 2022 14:30:44 +0200
From:   Heikki Krogerus <heikki.krogerus@linux.intel.com>
To:     Sven Peter <sven@svenpeter.dev>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 4/4] usb: typec: tipd: Move tps6598x_disconnect error
 path to its own label
Message-ID: <Y3TX9Fn/elHiWZFj@kuha.fi.intel.com>
References: <20221114174449.34634-1-sven@svenpeter.dev>
 <20221114174449.34634-4-sven@svenpeter.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221114174449.34634-4-sven@svenpeter.dev>
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 14, 2022 at 06:44:49PM +0100, Sven Peter wrote:
> While the code currently correctly calls tps6598x_disconnect before jumping
> to the error cleanup label it's inconsistent compared to all the other cleanup
> actions and prone to introduce bugs if any more resources are added.
> 
> Signed-off-by: Sven Peter <sven@svenpeter.dev>

Reviewed-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>

> ---
>  drivers/usb/typec/tipd/core.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/usb/typec/tipd/core.c b/drivers/usb/typec/tipd/core.c
> index c35501a92b4d..22ff212e05e6 100644
> --- a/drivers/usb/typec/tipd/core.c
> +++ b/drivers/usb/typec/tipd/core.c
> @@ -850,16 +850,16 @@ static int tps6598x_probe(struct i2c_client *client)
>  					irq_handler,
>  					IRQF_SHARED | IRQF_ONESHOT,
>  					dev_name(&client->dev), tps);
> -	if (ret) {
> -		tps6598x_disconnect(tps, 0);
> -		goto err_unregister_port;
> -	}
> +	if (ret)
> +		goto err_disconnect;
>  
>  	i2c_set_clientdata(client, tps);
>  	fwnode_handle_put(fwnode);
>  
>  	return 0;
>  
> +err_disconnect:
> +	tps6598x_disconnect(tps, 0);
>  err_unregister_port:
>  	typec_unregister_port(tps->port);
>  err_role_put:

thanks,

-- 
heikki
