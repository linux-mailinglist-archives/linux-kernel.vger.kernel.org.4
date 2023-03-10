Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C5B6C6B37C4
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Mar 2023 08:51:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229936AbjCJHvT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Mar 2023 02:51:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229933AbjCJHvP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Mar 2023 02:51:15 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 691656FFF2
        for <linux-kernel@vger.kernel.org>; Thu,  9 Mar 2023 23:51:11 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 085DA60EFC
        for <linux-kernel@vger.kernel.org>; Fri, 10 Mar 2023 07:51:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 06124C433EF;
        Fri, 10 Mar 2023 07:51:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1678434670;
        bh=/Bq/av451YzweCCOPw+RantvVT9w+XlNfixUTmOPEB8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=zurZTbOP/tkaifQfk97LY1Z04bkumFbIV604E7GQEPEDrAZRfzSNnVfgQg1rgbRBZ
         duLByxrJUnkaAVpKc5Jp+hTGJMBR6+HPnQLUbcNdXoU3c3/l0R9e1au+MAF4UgC+j8
         kT1NAULYxvvb47UGLjvpAm5w+DEjr1E2mou1kd1s=
Date:   Fri, 10 Mar 2023 08:51:07 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Xujun Leng <lengxujun2007@126.com>
Cc:     linux-kernel@vger.kernel.org, rafael@kernel.org
Subject: Re: [PATCH] driver core: platform: added arguments check for
 platform_device_add_resources()
Message-ID: <ZArha1XDXWV1QVIz@kroah.com>
References: <ZAnvpUp3TuIEc2kC@kroah.com>
 <20230310065546.22948-1-lengxujun2007@126.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230310065546.22948-1-lengxujun2007@126.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 10, 2023 at 02:55:46PM +0800, Xujun Leng wrote:
> > On Tue, Mar 07, 2023 at 01:01:16PM +0800, Xujun Leng wrote:
> > > In the follow two cases, platform_device_add_resources() can lead an
> > > invalid address access:
> > > 1) If (!res && num > 0), pdev->resource will be set to NULL but
> > >    pdev->num_resources > 0, then a later platform_get_resource() will
> > >    cause invalid address access.
> > > 2) If (res && num == 0), because num == 0 cause kmalloc_slab() returns
> > >    ZERO_SIZE_PTR, then kmemdup() will copy data to the invalid address
> > >    ZERO_SIZE_PTR.
> > > 
> > > Signed-off-by: Xujun Leng <lengxujun2007@126.com>
> > > ---
> > >  drivers/base/platform.c | 3 +++
> > >  1 file changed, 3 insertions(+)
> > > 
> > > diff --git a/drivers/base/platform.c b/drivers/base/platform.c
> > > index 77510e4f47de..a060941c3076 100644
> > > --- a/drivers/base/platform.c
> > > +++ b/drivers/base/platform.c
> > > @@ -606,6 +606,9 @@ int platform_device_add_resources(struct platform_device *pdev,
> > >  {
> > >  	struct resource *r = NULL;
> > >  
> > > +	if ((!res && num > 0) || (res && num == 0))
> > > +		return -EINVAL;
> > 
> > What driver is causing this check to fail today?  Shouldn't that be
> > fixed instead?
> 
> Ok, I got it. It's the caller's responsibility to take care about that.

Maybe, I don't know, which is why I am asking what driver is triggering
this kind of failure.  Can you point me at one that causes this so we
can see if this is something that a driver should be catching before it
calls this, or if it is something that this core function should catch
instead?

thanks,

greg k-h
