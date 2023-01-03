Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 70ECD65C2F3
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Jan 2023 16:25:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233417AbjACPYW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Jan 2023 10:24:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233189AbjACPYV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jan 2023 10:24:21 -0500
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [IPv6:2001:4d48:ad52:32c8:5054:ff:fe00:142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5155C25F0
        for <linux-kernel@vger.kernel.org>; Tue,  3 Jan 2023 07:24:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=oZxDj67clABGqk6QiAxQ1JKQPGByRK02SwvUmbeTMn8=; b=gREsp7c/pgSY0ZE4usD2NOCJHO
        oakwK+2yr6xyLWA/n6WwecO5MWP+So0e3jK4uW5vlVn4pnZt0N2jwyemoFxJVXLILwmBsYrduKlai
        enUaiwdeiyz6uUoiqTNYv9/mudm2i/Afu3QhEbpoHNc9ILJr5bMRnNabf8SvKIae57M0HbBEik2+v
        S5e1H7OiYX8cyXTzHGbsUxGC74L6l8G384u4ixpWRHEwsGPVCpET6914qx87Yeuxh9vi+xGDf5m65
        NE5MARMnmmlVsn2LxdC6V5JAz1/va9m1E+ExWMRlMDtSC6iaUYxPyIA+ZEFIDpQAHLny6dRuYzggu
        b0JPYPBQ==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:35942)
        by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <linux@armlinux.org.uk>)
        id 1pCj9F-0005Ux-SQ; Tue, 03 Jan 2023 15:24:17 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.94.2)
        (envelope-from <linux@shell.armlinux.org.uk>)
        id 1pCj9E-0002Ak-C3; Tue, 03 Jan 2023 15:24:16 +0000
Date:   Tue, 3 Jan 2023 15:24:16 +0000
From:   "Russell King (Oracle)" <linux@armlinux.org.uk>
To:     Hector Martin <marcan@marcan.st>
Cc:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Maxime Ripard <mripard@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH v2] nvmem: fix registration vs use race
Message-ID: <Y7RIoO39gSkhqQGm@shell.armlinux.org.uk>
References: <E1pCiUe-00457v-SQ@rmk-PC.armlinux.org.uk>
 <169464ed-34c2-08d3-efee-686c9a5eb15d@marcan.st>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <169464ed-34c2-08d3-efee-686c9a5eb15d@marcan.st>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 04, 2023 at 12:20:15AM +0900, Hector Martin wrote:
> On 03/01/2023 23.42, Russell King (Oracle) wrote:
> > The i.MX6 CPU frequency driver sometimes fails to register at boot time
> > due to nvmem_cell_read_u32() sporadically returning -ENOENT.
> > 
> > This happens because there is a window where __nvmem_device_get() in
> > of_nvmem_cell_get() is able to return the nvmem device, but as cells
> > have been setup, nvmem_find_cell_entry_by_node() returns NULL.
> > 
> > The occurs because the nvmem core registration code violates one of the
> > fundamental principles of kernel programming: do not publish data
> > structures before their setup is complete.
> > 
> > Fix this by making nvmem core code conform with this principle.
> > 
> > Fixes: eace75cfdcf7 ("nvmem: Add a simple NVMEM framework for nvmem providers")
> > Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
> > ---
> > v2: add fixes tag
> > 
> >  drivers/nvmem/core.c | 18 ++++++++----------
> >  1 file changed, 8 insertions(+), 10 deletions(-)
> > 
> > diff --git a/drivers/nvmem/core.c b/drivers/nvmem/core.c
> > index 321d7d63e068..6b89fb6fa582 100644
> > --- a/drivers/nvmem/core.c
> > +++ b/drivers/nvmem/core.c
> > @@ -835,22 +835,16 @@ struct nvmem_device *nvmem_register(const struct nvmem_config *config)
> >  	nvmem->dev.groups = nvmem_dev_groups;
> >  #endif
> >  
> > -	dev_dbg(&nvmem->dev, "Registering nvmem device %s\n", config->name);
> > -
> > -	rval = device_register(&nvmem->dev);
> > -	if (rval)
> > -		goto err_put_device;
> > -
> >  	if (nvmem->nkeepout) {
> >  		rval = nvmem_validate_keepouts(nvmem);
> >  		if (rval)
> > -			goto err_device_del;
> > +			goto err_put_device;
> 
> You can't call put_device() on a device that hasn't gone through
> device_initialize() yet.

Right, which is what I just realised while writing the previous reply.
We need to use device_initialize() and device_add(), so we can call
put_device() on it.

Error paths are difficult to properly test. :(

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 40Mbps down 10Mbps up. Decent connectivity at last!
