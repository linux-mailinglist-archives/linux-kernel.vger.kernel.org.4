Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 40E346BE07C
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Mar 2023 06:09:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229958AbjCQFI7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Mar 2023 01:08:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229542AbjCQFI4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Mar 2023 01:08:56 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C949F59E64
        for <linux-kernel@vger.kernel.org>; Thu, 16 Mar 2023 22:08:55 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 325E062189
        for <linux-kernel@vger.kernel.org>; Fri, 17 Mar 2023 05:08:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 21EA7C433EF;
        Fri, 17 Mar 2023 05:08:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1679029734;
        bh=U2RiO7q0dh14jL/UPhGppHMn6kvfKx8vzEP16yVWbl0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=MEKtoyLf0ppEVS0c20BIsCokmOpmFWLH+vctocN4vf5YRQhZKFw9ZvoqmCtqDa9QS
         Dl8KRn+ak2X6peIafRvDbQFh7dY5vfOzBNhoIrC4pZx8ymazYeCphCAV/qPfB+2T+6
         bXhAC6TKhhuSTeL2j622tfcAq3JnMe26VULVtS0I=
Date:   Fri, 17 Mar 2023 06:08:51 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Heiner Kallweit <hkallweit1@gmail.com>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] base: soc: set machine name in soc_device_register if
 empty
Message-ID: <ZBP14wghbJPCnAFJ@kroah.com>
References: <d667b435-bf4c-ee7d-2da8-559354124578@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d667b435-bf4c-ee7d-2da8-559354124578@gmail.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 16, 2023 at 09:35:59PM +0100, Heiner Kallweit wrote:
> Several SoC drivers use the same of-based mechanism to populate the machine
> name. Therefore move this to the core and try to populate the machine name
> in soc_device_register if it's not set yet.
> 
> Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
> ---
>  drivers/base/soc.c | 15 +++++++++++++++
>  1 file changed, 15 insertions(+)
> 
> diff --git a/drivers/base/soc.c b/drivers/base/soc.c
> index 0fb1d4ab9..8dec5228f 100644
> --- a/drivers/base/soc.c
> +++ b/drivers/base/soc.c
> @@ -7,6 +7,7 @@
>  
>  #include <linux/sysfs.h>
>  #include <linux/init.h>
> +#include <linux/of.h>
>  #include <linux/stat.h>
>  #include <linux/slab.h>
>  #include <linux/idr.h>
> @@ -110,6 +111,18 @@ static void soc_release(struct device *dev)
>  	kfree(soc_dev);
>  }
>  
> +static void soc_device_set_machine(struct soc_device_attribute *soc_dev_attr)
> +{
> +	struct device_node *np;
> +
> +	if (soc_dev_attr->machine)
> +		return;
> +
> +	np = of_find_node_by_path("/");
> +	of_property_read_string(np, "model", &soc_dev_attr->machine);
> +	of_node_put(np);
> +}
> +
>  static struct soc_device_attribute *early_soc_dev_attr;
>  
>  struct soc_device *soc_device_register(struct soc_device_attribute *soc_dev_attr)
> @@ -118,6 +131,8 @@ struct soc_device *soc_device_register(struct soc_device_attribute *soc_dev_attr
>  	const struct attribute_group **soc_attr_groups;
>  	int ret;
>  
> +	soc_device_set_machine(soc_dev_attr);
> +

Does this mean some SoC drivers should also be changed at the same time
if they are trying to do this?

And is "model" the correct of property for this?  I thought that devices
also had "model" as a valid entry, is this documented somewhere in the
DTS schema that I couldn't find?

thanks,

greg k-h
