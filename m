Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7015067464C
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Jan 2023 23:39:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230522AbjASWjj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Jan 2023 17:39:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230287AbjASWiu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jan 2023 17:38:50 -0500
Received: from relay2-d.mail.gandi.net (relay2-d.mail.gandi.net [217.70.183.194])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 276211733;
        Thu, 19 Jan 2023 14:21:02 -0800 (PST)
Received: (Authenticated sender: alexandre.belloni@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id B273340002;
        Thu, 19 Jan 2023 22:20:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1674166861;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=JzI2BBY9Cf0YhTb4joKcfr5g3ofBMzEdkRpv4V0Rp8E=;
        b=X93PJHXqQe97cE1WT5YAtKJQ1d1Ns1wxNlgvt0acE2hVHOO5jIkUJrdr+V9Z/8crMEbyef
        lUhozrzBFmFEtCPcOYaXWlLdLLUURK6+pg4FudiFI0jezfcb7wkgzp3NdzJDIeU2Iy3+1N
        Vqe+MIgMcawrKw5t5vgNlJEBTWbg+XOjiFJKCYSJWBbMOPhz8JQZvVWj45doRVn4SIAMbX
        xJesRpFTkggc0bG0bmE3GCyr2LQ/vnzbgTvHepwFMrAuCnkO4MhLmWfFffT7mBYz+E8mUc
        Kg2+UYm3uAspYRqTcICKke9mxH1cC1ajVv4P7lU/BQxQSD1w1DU6MwWlB8e1QQ==
Date:   Thu, 19 Jan 2023 23:20:59 +0100
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     Dennis Lambe Jr <dennis@sparkcharge.io>
Cc:     Alessandro Zummo <a.zummo@towertech.it>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Atsushi Nemoto <atsushi.nemoto@sord.co.jp>,
        =?iso-8859-1?Q?Myl=E8ne?= Josserand 
        <mylene.josserand@free-electrons.com>,
        Gary Bisson <gary.bisson@boundarydevices.com>,
        Javier Martinez Canillas <javier@osg.samsung.com>,
        Troy Kisky <troy.kisky@boundarydevices.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-rtc@vger.kernel.org
Subject: Re: [PATCH v3 1/3] rtc: m41t80: probe: use IS_ENABLED for CONFIG_OF
Message-ID: <Y8nCS8Z0QKzbeY2G@mail.local>
References: <20230119213903.899756-1-dennis@sparkcharge.io>
 <20230119213903.899756-2-dennis@sparkcharge.io>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230119213903.899756-2-dennis@sparkcharge.io>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 19/01/2023 21:39:01+0000, Dennis Lambe Jr wrote:
> The style guide recommends IS_ENABLED rather than ifdef for wrapping
> conditional code wherever possible.
> 
> Functions that are only called on DeviceTree platforms would otherwise
> need to be cluttered up with __maybe_unused, which is especially
> undesirable if there's nothing inherently DT-specific about those
> functions.
> 
> Signed-off-by: Dennis Lambe Jr <dennis@sparkcharge.io>
> ---
> 
> Notes:
>     v1 -> v2: spelling fix in changelog
> 
>  drivers/rtc/rtc-m41t80.c | 9 +++++----
>  1 file changed, 5 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/rtc/rtc-m41t80.c b/drivers/rtc/rtc-m41t80.c
> index 494052dbd39f..f963b76e5fc0 100644
> --- a/drivers/rtc/rtc-m41t80.c
> +++ b/drivers/rtc/rtc-m41t80.c
> @@ -909,10 +909,11 @@ static int m41t80_probe(struct i2c_client *client)
>  	if (IS_ERR(m41t80_data->rtc))
>  		return PTR_ERR(m41t80_data->rtc);
>  
> -#ifdef CONFIG_OF
> -	wakeup_source = of_property_read_bool(client->dev.of_node,
> -					      "wakeup-source");
> -#endif
> +	if (IS_ENABLED(CONFIG_OF)) {
> +		wakeup_source = of_property_read_bool(client->dev.of_node,
> +						      "wakeup-source");
> +	}
> +

A way better patch would switch to fwnode_property_read_bool

>  	if (client->irq > 0) {
>  		rc = devm_request_threaded_irq(&client->dev, client->irq,
>  					       NULL, m41t80_handle_irq,
> -- 
> 2.25.1
> 

-- 
Alexandre Belloni, co-owner and COO, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
