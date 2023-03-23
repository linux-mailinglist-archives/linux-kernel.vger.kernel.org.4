Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 22F336C61EA
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Mar 2023 09:37:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231616AbjCWIhR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Mar 2023 04:37:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231419AbjCWIgq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Mar 2023 04:36:46 -0400
Received: from relay4-d.mail.gandi.net (relay4-d.mail.gandi.net [217.70.183.196])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45C981C307;
        Thu, 23 Mar 2023 01:35:35 -0700 (PDT)
Received: (Authenticated sender: alexandre.belloni@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id 97094E0009;
        Thu, 23 Mar 2023 08:34:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1679560492;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=6YZqYhanJlzsbbzWH9tc0xb9I/fhYOruscuJphWFDBY=;
        b=I50PUNdhyDIplZ2wdoDQIqjMkjdRbktrRl+qzzBLdiembPcdFhh2wyAsXGnFx1uTjoObdg
        IER2i0mWiwSsVl7WCtn9SGf6xYqLxq9HHszR5+s0RSBnC0Rld4aYgDGfY1y8IHxOYrMIsA
        ROrQmVhVg/KAijUCXnOIqGPp43vjrFS6HxJhtp9qAXfDqVc1DPVGREwXw3LcZr7BLs48Qj
        E68qiF5QWy49tq9gqmpmLdiyw4L/c9xqRbeH0meM1NHYyI2fN8xrk8vHMgkRUDPpaDy73G
        6IacuiNeSObPxXjCSCJqrdA4dvvfe+0nFOS+SAkeHGkZkjMq+7sM7hjm6vZQlg==
Date:   Thu, 23 Mar 2023 09:34:51 +0100
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     Dhruva Gole <d-gole@ti.com>
Cc:     Vibhore Vardhan <vibhore@ti.com>, linux-rtc@vger.kernel.org,
        Alessandro Zummo <a.zummo@towertech.it>,
        linux-kernel@vger.kernel.org, Nishanth Menon <nm@ti.com>
Subject: Re: [PATCH] rtc: k3: handle errors while enabling wake irq
Message-ID: <20230323083451a4171c6b@mail.local>
References: <20230323081942.951542-1-d-gole@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230323081942.951542-1-d-gole@ti.com>
X-Spam-Status: No, score=-0.9 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 23/03/2023 13:49:42+0530, Dhruva Gole wrote:
> Due to the potential failure of enable_irq_wake(), it would be better to
> check it and return error if it fails.
> 
> Fixes: b09d633575e5 ("rtc: Introduce ti-k3-rtc")
> Cc: Nishanth Menon <nm@ti.com>
> Signed-off-by: Dhruva Gole <d-gole@ti.com>
> ---
>  drivers/rtc/rtc-ti-k3.c | 11 ++++++++++-
>  1 file changed, 10 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/rtc/rtc-ti-k3.c b/drivers/rtc/rtc-ti-k3.c
> index ba23163cc042..ef9d7e1cf92e 100644
> --- a/drivers/rtc/rtc-ti-k3.c
> +++ b/drivers/rtc/rtc-ti-k3.c
> @@ -630,9 +630,18 @@ MODULE_DEVICE_TABLE(of, ti_k3_rtc_of_match_table);
>  static int __maybe_unused ti_k3_rtc_suspend(struct device *dev)
>  {
>  	struct ti_k3_rtc *priv = dev_get_drvdata(dev);
> +	int error;

This variable is not necessary.

>  
>  	if (device_may_wakeup(dev))
> -		enable_irq_wake(priv->irq);
> +		error = enable_irq_wake(priv->irq);
> +
> +	if (error) {
> +		dev_err(dev,
> +			"failed to enable irq wake on IRQ %d: %d\n",
> +			priv->irq, error);

Please remove this message, this is too verbose and there is no action
for the user apart from trying to go to suspend again.

> +		return error;
> +	}
> +
>  	return 0;
>  }
>  
> -- 
> 2.25.1
> 

-- 
Alexandre Belloni, co-owner and COO, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
