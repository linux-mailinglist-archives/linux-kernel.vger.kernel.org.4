Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 022426BE879
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Mar 2023 12:42:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229916AbjCQLmk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Mar 2023 07:42:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230316AbjCQLm2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Mar 2023 07:42:28 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5761FE2502
        for <linux-kernel@vger.kernel.org>; Fri, 17 Mar 2023 04:42:08 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9E41F6226D
        for <linux-kernel@vger.kernel.org>; Fri, 17 Mar 2023 11:41:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AE2E7C4339E;
        Fri, 17 Mar 2023 11:41:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1679053282;
        bh=NINThgLOnVyfwje3zr7Z16A6rkOVt5LLWlVF/0uTe7U=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Mm2qmBEW/NGYUqsAe4UxAOLCj0yVoiciB8f5fBsKJOudOVJgBNayzqvHuijJeoTfE
         EHWZF1iJq3DFkmrvk66BuxdksID8l6c/Ga1zopJeM7oObJbvuvmWENJHzdhTfMwdLl
         88ONOlDTjzeb3tO+vIpKk9/FYKT3IZ919Klpc9x4=
Date:   Fri, 17 Mar 2023 12:41:19 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Heiner Kallweit <hkallweit1@gmail.com>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] base: soc: set machine name in soc_device_register if
 empty
Message-ID: <ZBRR35SVZeP652Z1@kroah.com>
References: <d667b435-bf4c-ee7d-2da8-559354124578@gmail.com>
 <ZBP14wghbJPCnAFJ@kroah.com>
 <39e60d57-60f1-d706-d922-0411252d4567@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <39e60d57-60f1-d706-d922-0411252d4567@gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 17, 2023 at 10:25:50AM +0100, Heiner Kallweit wrote:
> On 17.03.2023 06:08, Greg Kroah-Hartman wrote:
> > On Thu, Mar 16, 2023 at 09:35:59PM +0100, Heiner Kallweit wrote:
> >> Several SoC drivers use the same of-based mechanism to populate the machine
> >> name. Therefore move this to the core and try to populate the machine name
> >> in soc_device_register if it's not set yet.
> >>
> >> Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
> >> ---
> >>  drivers/base/soc.c | 15 +++++++++++++++
> >>  1 file changed, 15 insertions(+)
> >>
> >> diff --git a/drivers/base/soc.c b/drivers/base/soc.c
> >> index 0fb1d4ab9..8dec5228f 100644
> >> --- a/drivers/base/soc.c
> >> +++ b/drivers/base/soc.c
> >> @@ -7,6 +7,7 @@
> >>  
> >>  #include <linux/sysfs.h>
> >>  #include <linux/init.h>
> >> +#include <linux/of.h>
> >>  #include <linux/stat.h>
> >>  #include <linux/slab.h>
> >>  #include <linux/idr.h>
> >> @@ -110,6 +111,18 @@ static void soc_release(struct device *dev)
> >>  	kfree(soc_dev);
> >>  }
> >>  
> >> +static void soc_device_set_machine(struct soc_device_attribute *soc_dev_attr)
> >> +{
> >> +	struct device_node *np;
> >> +
> >> +	if (soc_dev_attr->machine)
> >> +		return;
> >> +
> >> +	np = of_find_node_by_path("/");
> >> +	of_property_read_string(np, "model", &soc_dev_attr->machine);
> >> +	of_node_put(np);
> >> +}
> >> +
> >>  static struct soc_device_attribute *early_soc_dev_attr;
> >>  
> >>  struct soc_device *soc_device_register(struct soc_device_attribute *soc_dev_attr)
> >> @@ -118,6 +131,8 @@ struct soc_device *soc_device_register(struct soc_device_attribute *soc_dev_attr
> >>  	const struct attribute_group **soc_attr_groups;
> >>  	int ret;
> >>  
> >> +	soc_device_set_machine(soc_dev_attr);
> >> +
> > 
> > Does this mean some SoC drivers should also be changed at the same time
> > if they are trying to do this?
> > 
> The then duplicated code can be removed from SoC drivers afterwards.
> There's no need to do it at the same time.
> This change just adds a fallback in case the SoC driver doesn't set "machine".
> Means if a SoC driver populates machine differently, then this is respected
> and not overwritten.

Please send this as a patch series that add this, and then removes this
code from the SoC drivers so we can verify that it is all working
properly.

> > And is "model" the correct of property for this?  I thought that devices
> > also had "model" as a valid entry, is this documented somewhere in the
> > DTS schema that I couldn't find?
> > 
> 
> "model" is used by basically all SoC drivers for this purpose, a quick grep reveals:
> 
> drivers/soc/samsung/exynos-chipid.c:    of_property_read_string(root, "model", &soc_dev_attr->machine);
> drivers/soc/fsl/guts.c: if (of_property_read_string(of_root, "model", &machine))
> drivers/soc/amlogic/meson-mx-socinfo.c: of_property_read_string(np, "model", &soc_dev_attr->machine);
> drivers/soc/amlogic/meson-gx-socinfo.c: of_property_read_string(np, "model", &soc_dev_attr->machine);
> drivers/soc/aspeed/aspeed-socinfo.c:    of_property_read_string(np, "model", &machine);
> drivers/soc/ti/k3-socinfo.c:    of_property_read_string(node, "model", &soc_dev_attr->machine);
> drivers/soc/loongson/loongson2_guts.c:  if (of_property_read_string(root, "model", &machine))
> drivers/soc/renesas/renesas-soc.c:      of_property_read_string(np, "model", &soc_dev_attr->machine);
> drivers/soc/imx/soc-imx.c:      ret = of_property_read_string(root, "model", &soc_dev_attr->machine);
> drivers/soc/imx/soc-imx8m.c:    ret = of_property_read_string(of_root, "model", &soc_dev_attr->machine);
> 
> Some don't set machine at all.

So will this break systems that were not previously doing this by
showing an odd value?

thanks,

greg k-h
