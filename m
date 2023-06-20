Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 784C573669B
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Jun 2023 10:48:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232029AbjFTIsZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Jun 2023 04:48:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231320AbjFTIsX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Jun 2023 04:48:23 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C09B10D5;
        Tue, 20 Jun 2023 01:48:20 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1CC7C60FB7;
        Tue, 20 Jun 2023 08:48:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7F979C433C8;
        Tue, 20 Jun 2023 08:48:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1687250899;
        bh=We4GUkRxhS1fDYslOlxwNOQXBwPb0a3KCLEG71iYALM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=GSICaezSfcdPMn56iSmebYQ6YK4Q8EWXfX1wHQ2tHHMo6nfrJU1kpYIynrVPPGGfG
         CgeQeWbIBnLuykiGyZS7JG13eCQBla7lljNNZxNzyQ/C/IpvICvifvvNLxJSqq65n5
         3Dq3G+eZVHMQflpW/WsOBrb60LngaWNoGjj/tG6eCOjesZ3cEAHHGXKpl1oXHZaKrJ
         3Ul98sD5Y/ek+EH/0n82rLb+cFWH5ur/5I8NeDAF0NIgxQrjz0WRT1rqAZgVXsG6fs
         64KYDRWfNVvJqCXNTnvvN0mChXhFnPYdYiYjretoVVZKDPmlvwWjFW8Cz34MRA3eRS
         YyVqPcri6yUdQ==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan@kernel.org>)
        id 1qBX2B-0007Un-9w; Tue, 20 Jun 2023 10:48:19 +0200
Date:   Tue, 20 Jun 2023 10:48:19 +0200
From:   Johan Hovold <johan@kernel.org>
To:     Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc:     linux-renesas-soc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Subject: Re: [RFC PATCH 2/5] gnss: ubx: use new helper to remove open coded
 regulator handling
Message-ID: <ZJFn04P7_JhC24ST@hovoldconsulting.com>
References: <20230523064310.3005-1-wsa+renesas@sang-engineering.com>
 <20230523064310.3005-3-wsa+renesas@sang-engineering.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230523064310.3005-3-wsa+renesas@sang-engineering.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 23, 2023 at 08:43:07AM +0200, Wolfram Sang wrote:
> v_bckp shall always be enabled as long as the device exists. We now have
> a regulator helper for that, use it.
> 
> Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
> ---
>  drivers/gnss/ubx.c | 26 ++++----------------------
>  1 file changed, 4 insertions(+), 22 deletions(-)
> 
> diff --git a/drivers/gnss/ubx.c b/drivers/gnss/ubx.c
> index c01e1e875727..c8d027973b85 100644
> --- a/drivers/gnss/ubx.c
> +++ b/drivers/gnss/ubx.c
> @@ -17,7 +17,6 @@
>  #include "serial.h"
>  
>  struct ubx_data {
> -	struct regulator *v_bckp;
>  	struct regulator *vcc;
>  };
>  
> @@ -106,30 +105,16 @@ static int ubx_probe(struct serdev_device *serdev)
>  		goto err_free_gserial;
>  	}
>  
> -	data->v_bckp = devm_regulator_get_optional(&serdev->dev, info->v_bckp_name);
> -	if (IS_ERR(data->v_bckp)) {
> -		ret = PTR_ERR(data->v_bckp);
> -		if (ret == -ENODEV)
> -			data->v_bckp = NULL;
> -		else
> -			goto err_free_gserial;
> -	}
> -
> -	if (data->v_bckp) {
> -		ret = regulator_enable(data->v_bckp);
> -		if (ret)
> -			goto err_free_gserial;
> -	}
> +	ret = devm_regulator_get_enable_optional(&serdev->dev, info->v_bckp_name);
> +	if (ret < 0 && ret != -ENODEV)
> +		goto err_free_gserial;

I'm a bit torn about this one as I'm generally sceptical of devres and
especially helpers that enable or register resources, which just tends to
lead to subtle bugs.

But if there's one place where this new helper, which importantly does
not return a pointer to the regulator, may be useful I guess it's here.

Care to respin this one after dropping the merge patch?

Johan
