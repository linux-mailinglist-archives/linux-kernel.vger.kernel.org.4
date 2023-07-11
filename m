Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC15F74F0DF
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jul 2023 15:58:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233140AbjGKN6J (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jul 2023 09:58:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233161AbjGKN6F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jul 2023 09:58:05 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B82C6B0
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jul 2023 06:58:03 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 55839614F9
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jul 2023 13:58:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5F391C433C8;
        Tue, 11 Jul 2023 13:58:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1689083882;
        bh=72vG4Jd3TO6C8yEgUaxxZPJBDDTMPR+UtkaS8gvGh1Q=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=d3Oi8XErvICjTFOUsBVK53tBJXmDstNs0uW288o1hVPqZwF4GYyveHjpkFeVwEUk9
         vZETThtFCLEI3qrIxLrxBb9hoo8AkBZsGeokPLF+RSEyBsFdPmMjc72wg2EwN5fzuW
         IUa6fixh3PG9InQs97VxArkg4XtNl2F/w6t/pSsE=
Date:   Tue, 11 Jul 2023 15:57:59 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Abhijit Gangurde <abhijit.gangurde@amd.com>
Cc:     linux-kernel@vger.kernel.org, Nipun.Gupta@amd.com,
        nikhil.agarwal@amd.com, puneet.gupta@amd.com, git@amd.com,
        michal.simek@amd.com,
        Pieter Jansen van Vuuren <pieter.jansen-van-vuuren@amd.com>
Subject: Re: [PATCH 1/4] cdx: add support for bus enable and disable
Message-ID: <2023071109-saturate-purist-d854@gregkh>
References: <20230711121027.936487-1-abhijit.gangurde@amd.com>
 <20230711121027.936487-2-abhijit.gangurde@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230711121027.936487-2-abhijit.gangurde@amd.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 11, 2023 at 05:40:24PM +0530, Abhijit Gangurde wrote:
> CDX bus needs to be disabled before updating/writing devices
> in the FPGA. Once the devices are written, the bus shall be
> enabled. This change provides sysfs entry to enable/disable the
> CDX bus.
> 
> Co-developed-by: Nipun Gupta <nipun.gupta@amd.com>
> Signed-off-by: Nipun Gupta <nipun.gupta@amd.com>
> Signed-off-by: Abhijit Gangurde <abhijit.gangurde@amd.com>
> Reviewed-by: Pieter Jansen van Vuuren <pieter.jansen-van-vuuren@amd.com>
> Tested-by: Nikhil Agarwal <nikhil.agarwal@amd.com>
> ---
>  Documentation/ABI/testing/sysfs-bus-cdx | 11 +++++
>  drivers/cdx/cdx.c                       | 26 ++++++++++++
>  drivers/cdx/controller/cdx_controller.c | 27 +++++++++++++
>  drivers/cdx/controller/mc_cdx_pcol.h    | 54 +++++++++++++++++++++++++
>  drivers/cdx/controller/mcdi_functions.c | 24 +++++++++++
>  drivers/cdx/controller/mcdi_functions.h | 16 ++++++++
>  include/linux/cdx/cdx_bus.h             |  6 +++
>  7 files changed, 164 insertions(+)
> 
> diff --git a/Documentation/ABI/testing/sysfs-bus-cdx b/Documentation/ABI/testing/sysfs-bus-cdx
> index 7af477f49998..0afa85b3c63b 100644
> --- a/Documentation/ABI/testing/sysfs-bus-cdx
> +++ b/Documentation/ABI/testing/sysfs-bus-cdx
> @@ -11,6 +11,17 @@ Description:
>  
>  		  # echo 1 > /sys/bus/cdx/rescan
>  
> +What:		/sys/bus/cdx/enable
> +Date:		July 2023
> +Contact:	nipun.gupta@amd.com
> +Description:
> +		Writing y/1/on to this file enables the CDX bus and
> +		writing n/0/off disables the bus.
> +
> +		For example to disable CDX bus::
> +
> +		  # echo 0 > /sys/bus/cdx/enable

What could go wrong!  :)

You don't say why disabling / enabling the bus is needed, this feels
like a very huge stick, why is this for all busses, and not just an
individual CDX bus?

> +
>  What:		/sys/bus/cdx/devices/.../vendor
>  Date:		March 2023
>  Contact:	nipun.gupta@amd.com
> diff --git a/drivers/cdx/cdx.c b/drivers/cdx/cdx.c
> index d2cad4c670a0..48c493a43491 100644
> --- a/drivers/cdx/cdx.c
> +++ b/drivers/cdx/cdx.c
> @@ -380,6 +380,30 @@ static struct attribute *cdx_dev_attrs[] = {
>  };
>  ATTRIBUTE_GROUPS(cdx_dev);
>  
> +static ssize_t enable_store(const struct bus_type *bus,
> +			    const char *buf, size_t count)
> +{
> +	struct cdx_controller *cdx;
> +	unsigned long index;
> +	bool enable;
> +	int ret;
> +
> +	if (kstrtobool(buf, &enable) < 0)
> +		return -EINVAL;
> +
> +	xa_for_each(&cdx_controllers, index, cdx) {
> +		if (cdx->enabled == enable)
> +			continue;
> +
> +		ret = cdx->ops->enable(cdx, enable);
> +		if (ret)
> +			dev_err(cdx->dev, "cdx bus enable/disable failed\n");

You can say if this was enabled or disabled to help figure things out.

> +	}

No locking needed at all?  What happens if controllers are added or
removed?

> +
> +	return count;
> +}
> +static BUS_ATTR_WO(enable);
> +
>  static ssize_t rescan_store(const struct bus_type *bus,
>  			    const char *buf, size_t count)
>  {
> @@ -410,6 +434,7 @@ static ssize_t rescan_store(const struct bus_type *bus,
>  static BUS_ATTR_WO(rescan);
>  
>  static struct attribute *cdx_bus_attrs[] = {
> +	&bus_attr_enable.attr,
>  	&bus_attr_rescan.attr,
>  	NULL,
>  };
> @@ -541,6 +566,7 @@ void cdx_unregister_controller(struct cdx_controller *cdx)
>  	if (cdx->id >= MAX_CDX_CONTROLLERS)
>  		return;
>  
> +	cdx->ops->enable(cdx, false);
>  	device_for_each_child(cdx->dev, NULL, cdx_unregister_device);
>  	xa_erase(&cdx_controllers, cdx->id);
>  }
> diff --git a/drivers/cdx/controller/cdx_controller.c b/drivers/cdx/controller/cdx_controller.c
> index dc52f95f8978..ac8081f23cbe 100644
> --- a/drivers/cdx/controller/cdx_controller.c
> +++ b/drivers/cdx/controller/cdx_controller.c
> @@ -45,6 +45,21 @@ void cdx_rpmsg_pre_remove(struct cdx_controller *cdx)
>  	cdx_mcdi_wait_for_quiescence(cdx->priv, MCDI_RPC_TIMEOUT);
>  }
>  
> +static int cdx_bus_enable(struct cdx_controller *cdx, bool enable)

Why not just a disable and enable callback instead of being forced to
always rembmer that "foo_enable(foo, false)" really is "foo_disable(foo)"?

This is messy, please be explicit.

thanks,

greg k-h
