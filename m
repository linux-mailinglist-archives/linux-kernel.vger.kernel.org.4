Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BDA1B651BFF
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Dec 2022 08:55:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233036AbiLTHzO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Dec 2022 02:55:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229690AbiLTHzL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Dec 2022 02:55:11 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 822B92629;
        Mon, 19 Dec 2022 23:55:10 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 3DBA7B8105C;
        Tue, 20 Dec 2022 07:55:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A6CD7C433EF;
        Tue, 20 Dec 2022 07:55:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1671522907;
        bh=Tyff5dKkJUEMJgpOCplHCQLNFPV2khvh5mON+5VPI9w=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=L1jWkxqZy7WM77o3a+22gS5N/twe7BP74DnPzl0gynYuF9JdkfQB+FkmLu4HajH0m
         JmBWY6bDKaLO6pQB/eAZfrQBsPD9zfZK0vxFkkWG17qCI/wLHoGAdh9qSvlM8Rxt/T
         ZOVpPUFKhd/e362JjgZdarddkMfsb2jiDW6pL36tNXagoE/TdSmocusVZdozAk2p1J
         BwYU1lo8gzDApn5TlvHgTAxWYg/zFZT0zxS7mZXMnTKO1RtdOywql0lwv+eRKKJe9M
         umOYeL/zAvN1t5FEL6SOPucJSMA+Ri3/uOp/eod+tDzFnoeuJzBi6WrZQhe79pmIEZ
         9VZA+bySEvXSw==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan@kernel.org>)
        id 1p7XTc-00015F-D2; Tue, 20 Dec 2022 08:55:52 +0100
Date:   Tue, 20 Dec 2022 08:55:52 +0100
From:   Johan Hovold <johan@kernel.org>
To:     Matthias Kaehlcke <mka@chromium.org>, Rob Herring <robh@kernel.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Douglas Anderson <dianders@chromium.org>,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
        Stefan Wahren <stefan.wahren@i2se.com>,
        Ravi Chandra Sadineni <ravisadineni@chromium.org>
Subject: Re: [PATCH] usb: misc: onboard_usb_hub: Don't defer probing for
 'incomplete' DT nodes
Message-ID: <Y6FqiA/SoZHr36jl@hovoldconsulting.com>
References: <20221220004427.1.If5e7ec83b1782e4dffa6ea759416a27326c8231d@changeid>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221220004427.1.If5e7ec83b1782e4dffa6ea759416a27326c8231d@changeid>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 20, 2022 at 12:45:01AM +0000, Matthias Kaehlcke wrote:
> Some boards have device tree nodes for USB hubs supported by the
> onboard_usb_hub driver, but the nodes don't have all properties
> needed for the driver to work properly (which is not necessarily
> an error in the DT). Currently _find_onboard_hub() returns
> -EPROBE_DEFER in such cases, which results in an unusable USB hub,
> since successive probes fail in the same way. Use the absence of
> the "vdd" supply as an indicator of such 'incomplete' DT nodes
> and return -ENODEV.
> 
> Fixes: 8bc063641ceb ("usb: misc: Add onboard_usb_hub driver")
> Reported-by: Stefan Wahren <stefan.wahren@i2se.com>
> Signed-off-by: Matthias Kaehlcke <mka@chromium.org>
> ---
> 
>  drivers/usb/misc/onboard_usb_hub.c | 9 +++++++++
>  1 file changed, 9 insertions(+)
> 
> diff --git a/drivers/usb/misc/onboard_usb_hub.c b/drivers/usb/misc/onboard_usb_hub.c
> index d63c63942af1..2968da515016 100644
> --- a/drivers/usb/misc/onboard_usb_hub.c
> +++ b/drivers/usb/misc/onboard_usb_hub.c
> @@ -363,6 +363,15 @@ static struct onboard_hub *_find_onboard_hub(struct device *dev)
>  	hub = dev_get_drvdata(&pdev->dev);
>  	put_device(&pdev->dev);
>  
> +	/*
> +	 * Some boards have device tree nodes for USB hubs supported by this
> +	 * driver, but the nodes don't have all properties needed for the driver
> +	 * to work properly. Use the absence of the "vdd" supply as an indicator
> +	 * of such nodes.
> +	 */
> +	if (!of_get_property(pdev->dev.of_node, "vdd", NULL))
> +		return ERR_PTR(-ENODEV);

Does this not break your original use case? Don't you want "vdd-supply"
here?

That said, this seems like the wrong property to look for both in
principle and as it is described as optional by the binding:

	Documentation/devicetree/bindings/usb/realtek,rts5411.yaml

It seems that you should use the compatible property and check that it
holds one of the expected values:

 - usbbda,5411
 - usbbda,411

rather than treat every hub node as describing a realtek hub (AFAIK,
there is no generic binding for this yet).

> +
>  	/*
>  	 * The presence of drvdata ('hub') indicates that the platform driver
>  	 * finished probing. This handles the case where (conceivably) we could

Johan
