Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ECC1062BDAC
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Nov 2022 13:24:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232035AbiKPMYS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Nov 2022 07:24:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238368AbiKPMX6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Nov 2022 07:23:58 -0500
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A32352F3AE;
        Wed, 16 Nov 2022 04:20:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1668601207; x=1700137207;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=tWFmfZcPgAmvyY4okt6g2a6aSaasopth4mQqEysO6Ag=;
  b=KHiNwlSGdr8Bvm5vmGMbfkaHu4dz4IRkDZ74OCTSV/On8b7TBcB2mYNt
   aADyhTB2BtyWNsX2zumPpm2B5XHmOxsNkY71FomKjS1XGDpv2Ol/rIUI8
   VCGWdkhhc3d02cUrMyL43cJ4HAuEF00n13QP9ILwUn0eqCnOq7AIyD/Ff
   CS1jlYt09xWQJB0KjQHbQXcfWOk4VAL1vbR+03pIR49daz3zwsE+XadJ9
   7VMC7I57tOIXG1NbCg/mjSMwDkcIb7/zk6JNLx4dH2ZatmzrV3Qmw6+cX
   wt4RWdZU8XMVm9HZs8IkL5UK2TYd+DHwsC3zvto/1l9Bhei9Aa0spe7mi
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10532"; a="339343150"
X-IronPort-AV: E=Sophos;i="5.96,167,1665471600"; 
   d="scan'208";a="339343150"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Nov 2022 04:20:07 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10532"; a="781747380"
X-IronPort-AV: E=Sophos;i="5.96,167,1665471600"; 
   d="scan'208";a="781747380"
Received: from kuha.fi.intel.com ([10.237.72.185])
  by fmsmga001.fm.intel.com with SMTP; 16 Nov 2022 04:20:04 -0800
Received: by kuha.fi.intel.com (sSMTP sendmail emulation); Wed, 16 Nov 2022 14:20:03 +0200
Date:   Wed, 16 Nov 2022 14:20:03 +0200
From:   Heikki Krogerus <heikki.krogerus@linux.intel.com>
To:     Sven Peter <sven@svenpeter.dev>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/4] usb: typec: tipd: Fix typec_unregister_port error
 paths
Message-ID: <Y3TVc0pTy6G2Q1Ot@kuha.fi.intel.com>
References: <20221114174449.34634-1-sven@svenpeter.dev>
 <20221114174449.34634-3-sven@svenpeter.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221114174449.34634-3-sven@svenpeter.dev>
X-Spam-Status: No, score=-7.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 14, 2022 at 06:44:48PM +0100, Sven Peter wrote:
> typec_unregister_port is only called for some error paths after
> typec_register_port was successful. Ensure it's called in all
> cases.
> 
> Fixes: 92440202a880 ("usb: typec: tipd: Only update power status on IRQ")
> Signed-off-by: Sven Peter <sven@svenpeter.dev>

Also direct stable material.

Reviewed-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>

> ---
>  drivers/usb/typec/tipd/core.c | 7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/usb/typec/tipd/core.c b/drivers/usb/typec/tipd/core.c
> index 824e573af570..c35501a92b4d 100644
> --- a/drivers/usb/typec/tipd/core.c
> +++ b/drivers/usb/typec/tipd/core.c
> @@ -839,7 +839,7 @@ static int tps6598x_probe(struct i2c_client *client)
>  		ret = tps6598x_read16(tps, TPS_REG_POWER_STATUS, &tps->pwr_status);
>  		if (ret < 0) {
>  			dev_err(tps->dev, "failed to read power status: %d\n", ret);
> -			goto err_role_put;
> +			goto err_unregister_port;
>  		}
>  		ret = tps6598x_connect(tps);
>  		if (ret)
> @@ -852,8 +852,7 @@ static int tps6598x_probe(struct i2c_client *client)
>  					dev_name(&client->dev), tps);
>  	if (ret) {
>  		tps6598x_disconnect(tps, 0);
> -		typec_unregister_port(tps->port);
> -		goto err_role_put;
> +		goto err_unregister_port;
>  	}
>  
>  	i2c_set_clientdata(client, tps);
> @@ -861,6 +860,8 @@ static int tps6598x_probe(struct i2c_client *client)
>  
>  	return 0;
>  
> +err_unregister_port:
> +	typec_unregister_port(tps->port);
>  err_role_put:
>  	usb_role_switch_put(tps->role_sw);
>  err_fwnode_put:

thanks,

-- 
heikki
