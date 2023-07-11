Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E13874F0E8
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jul 2023 15:59:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233165AbjGKN7j (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jul 2023 09:59:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232972AbjGKN7i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jul 2023 09:59:38 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25B769E
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jul 2023 06:59:37 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B1C90614F9
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jul 2023 13:59:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BFEA9C433C7;
        Tue, 11 Jul 2023 13:59:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1689083976;
        bh=uRUeM9qi1QR7xru0lAhOTh84xX/soNLIk48/O5v1Evo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Yc3PQS0MHhAGCNYqLUuRTLj3Heuk5JFWk+3p/IByvLfeGxx2gQWrGMDRZIyzM13eO
         6TBeQdxuvdffQXwG9JHFVYMM/lDGZgRiHyOTj7wMpfsmX/QdVQ8MPAKWySLmKiRzQA
         R3opcDHF3zsFsZdp1l1y44rO0fYa6StQ5EyQF16g=
Date:   Tue, 11 Jul 2023 15:59:33 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Abhijit Gangurde <abhijit.gangurde@amd.com>
Cc:     linux-kernel@vger.kernel.org, Nipun.Gupta@amd.com,
        nikhil.agarwal@amd.com, puneet.gupta@amd.com, git@amd.com,
        michal.simek@amd.com,
        Pieter Jansen van Vuuren <pieter.jansen-van-vuuren@amd.com>
Subject: Re: [PATCH 2/4] cdx: add sysfs for reset_all
Message-ID: <2023071111-unreached-probation-45c5@gregkh>
References: <20230711121027.936487-1-abhijit.gangurde@amd.com>
 <20230711121027.936487-3-abhijit.gangurde@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230711121027.936487-3-abhijit.gangurde@amd.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 11, 2023 at 05:40:25PM +0530, Abhijit Gangurde wrote:
> Add sysfs for reset_all entry which resets all the
> devices on the CDX bus.

On all CDX busses, right?  Why all?  Why not per-bus?


> 
> Co-developed-by: Puneet Gupta <puneet.gupta@amd.com>
> Signed-off-by: Puneet Gupta <puneet.gupta@amd.com>
> Co-developed-by: Nipun Gupta <nipun.gupta@amd.com>
> Signed-off-by: Nipun Gupta <nipun.gupta@amd.com>
> Signed-off-by: Abhijit Gangurde <abhijit.gangurde@amd.com>
> Reviewed-by: Pieter Jansen van Vuuren <pieter.jansen-van-vuuren@amd.com>
> Tested-by: Nikhil Agarwal <nikhil.agarwal@amd.com>
> ---
>  Documentation/ABI/testing/sysfs-bus-cdx | 11 ++++++++++
>  drivers/cdx/cdx.c                       | 29 +++++++++++++++++++++++++
>  2 files changed, 40 insertions(+)
> 
> diff --git a/Documentation/ABI/testing/sysfs-bus-cdx b/Documentation/ABI/testing/sysfs-bus-cdx
> index 0afa85b3c63b..d9e00058471d 100644
> --- a/Documentation/ABI/testing/sysfs-bus-cdx
> +++ b/Documentation/ABI/testing/sysfs-bus-cdx
> @@ -22,6 +22,17 @@ Description:
>  
>  		  # echo 0 > /sys/bus/cdx/enable
>  
> +What:		/sys/bus/cdx/reset_all
> +Date:		July 2023
> +Contact:	puneet.gupta@amd.com
> +Description:
> +		Writing y/1/on to this file resets all the devices
> +		present on the CDX bus
> +
> +		For example::
> +
> +		  # echo 1 > /sys/bus/cdx/reset_all

What does resetting a device mean will happen?

> +
>  What:		/sys/bus/cdx/devices/.../vendor
>  Date:		March 2023
>  Contact:	nipun.gupta@amd.com
> diff --git a/drivers/cdx/cdx.c b/drivers/cdx/cdx.c
> index 48c493a43491..4d20047b55bb 100644
> --- a/drivers/cdx/cdx.c
> +++ b/drivers/cdx/cdx.c
> @@ -106,6 +106,11 @@ int cdx_dev_reset(struct device *dev)
>  }
>  EXPORT_SYMBOL_GPL(cdx_dev_reset);
>  
> +static int reset_cdx_device(struct device *dev, void *data)
> +{
> +	return cdx_dev_reset(dev);
> +}
> +
>  /**
>   * cdx_unregister_device - Unregister a CDX device
>   * @dev: CDX device
> @@ -433,9 +438,33 @@ static ssize_t rescan_store(const struct bus_type *bus,
>  }
>  static BUS_ATTR_WO(rescan);
>  
> +static ssize_t reset_all_store(const struct bus_type *bus,
> +			       const char *buf, size_t count)
> +{
> +	bool val;
> +	int ret;
> +
> +	if (kstrtobool(buf, &val) < 0)
> +		return -EINVAL;
> +
> +	if (!val)
> +		return -EINVAL;
> +
> +	/* Reset all the devices attached to cdx bus */
> +	ret = bus_for_each_dev(bus, NULL, NULL, reset_cdx_device);

No locking needed?


> +	if (ret) {
> +		pr_err("error in CDX bus reset\n");

What error?  For what device?  Put the error message in the reset
callback, not here, as you have no idea what device failed.

thanks,

greg k-h
