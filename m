Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 74A1062BD5E
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Nov 2022 13:18:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233327AbiKPMSS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Nov 2022 07:18:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238515AbiKPMR3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Nov 2022 07:17:29 -0500
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB278BC39;
        Wed, 16 Nov 2022 04:13:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1668600798; x=1700136798;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=bIII9nqAa33Yiw1THwvOqyZ2a3+KL2FjBXLs9hG8bVk=;
  b=E02QI3u41BWb/kGwv+eclktm4T5Q/NpG8BR5+jP7QwitkuxbkTJ+pwev
   d/GdjPsfQiQF5sdIVEski3Ae8KXvMMfnEN4QmVjTxeHBHP4yMAklB2BIt
   /H9cq3iCAD3AJ/lGzoAa4QZt985ITV/jGQN1onPt03mwUCrPiFBEXBMb1
   BGAjuF/bwkzbivvTw4lheV3wzhcYQKO2EjDZRnKEbLS9ozkGsNHwS3hmF
   g2Czo89+3HAFGYctJU5wPqpXs1Zzd1R2MhDZ2ftVnQ62JOcvjm1IVEsZ6
   ZvbsPV9Jn23hUCKomPNr0Y73UVdkvzaafi8YhW+3p5S/DpJb0OHzrrL58
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10532"; a="314343637"
X-IronPort-AV: E=Sophos;i="5.96,167,1665471600"; 
   d="scan'208";a="314343637"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Nov 2022 04:13:18 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10532"; a="781745068"
X-IronPort-AV: E=Sophos;i="5.96,167,1665471600"; 
   d="scan'208";a="781745068"
Received: from kuha.fi.intel.com ([10.237.72.185])
  by fmsmga001.fm.intel.com with SMTP; 16 Nov 2022 04:13:15 -0800
Received: by kuha.fi.intel.com (sSMTP sendmail emulation); Wed, 16 Nov 2022 14:13:15 +0200
Date:   Wed, 16 Nov 2022 14:13:15 +0200
From:   Heikki Krogerus <heikki.krogerus@linux.intel.com>
To:     Sven Peter <sven@svenpeter.dev>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/4] usb: typec: tipd: Cleanup resources if
 devm_tps6598_psy_register fails
Message-ID: <Y3TT23pkf3g0VC+g@kuha.fi.intel.com>
References: <20221114174449.34634-1-sven@svenpeter.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221114174449.34634-1-sven@svenpeter.dev>
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 14, 2022 at 06:44:46PM +0100, Sven Peter wrote:
> We can't just return if devm_tps6598_psy_register fails since previous
> resources are not devres managed and have yet to be cleaned up.
> 
> Fixes: 10eb0b6ac63a ("usb: typec: tps6598x: Export some power supply properties")
> Signed-off-by: Sven Peter <sven@svenpeter.dev>

I think this should also automatically go to the stable tree.

Reviewed-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>

> ---
>  drivers/usb/typec/tipd/core.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/usb/typec/tipd/core.c b/drivers/usb/typec/tipd/core.c
> index 748ff4f6b5f6..ebc786d728e2 100644
> --- a/drivers/usb/typec/tipd/core.c
> +++ b/drivers/usb/typec/tipd/core.c
> @@ -827,7 +827,7 @@ static int tps6598x_probe(struct i2c_client *client)
>  
>  	ret = devm_tps6598_psy_register(tps);
>  	if (ret)
> -		return ret;
> +		goto err_role_put;
>  
>  	tps->port = typec_register_port(&client->dev, &typec_cap);
>  	if (IS_ERR(tps->port)) {

thanks,

-- 
heikki
