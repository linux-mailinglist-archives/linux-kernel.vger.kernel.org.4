Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 26A756CBEE2
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Mar 2023 14:18:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231871AbjC1MSP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Mar 2023 08:18:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230413AbjC1MSN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Mar 2023 08:18:13 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E9709760;
        Tue, 28 Mar 2023 05:18:06 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 351F161724;
        Tue, 28 Mar 2023 12:18:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 986D5C433D2;
        Tue, 28 Mar 2023 12:18:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1680005884;
        bh=JFb4CJYh/zHMZB7uquVZ8w/JgqwAaE+MeIk8cINQV2o=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=D/DN9DlCvX5QzsP4e4iSCRS5rwNZeLmgd+TZW63OaNPnFYghVNzeRUwgdz6XZl2sE
         PG0dE/YPddpac4qhU9Q3os9qO/SQ7EAMKfLCDFRsTWfdouLQVXRMyEe2Kx4TfG/OYq
         1qACH/wXiLugETcEOcaeMMVWR+xQ3CgRbeJf0mYww/ib2b4tNKsqJ+zHm/JvNKdXyV
         VT5ypklw0eT1e1DGXvpZ8bH9P06o+89jnpkMkWVofbFSO+zI3q6KRgwbZlS1SCIgRo
         hU5cuPeEhY/b4D4LcvJWLNRxotH8uXqDHjMTeY8mFoyuyWjy9o10n5ljtSgc5dXVm/
         GpPh7xqmngLtA==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan@kernel.org>)
        id 1ph8HI-0006bl-Tu; Tue, 28 Mar 2023 14:18:16 +0200
Date:   Tue, 28 Mar 2023 14:18:16 +0200
From:   Johan Hovold <johan@kernel.org>
To:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc:     andersson@kernel.org, Thinh.Nguyen@synopsys.com,
        gregkh@linuxfoundation.org, mathias.nyman@intel.com,
        konrad.dybcio@linaro.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, linux-arm-msm@vger.kernel.org,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH 5/5] usb: dwc3: qcom: Allow runtime PM
Message-ID: <ZCLbCJi80AKyVgnq@hovoldconsulting.com>
References: <20230325165217.31069-1-manivannan.sadhasivam@linaro.org>
 <20230325165217.31069-6-manivannan.sadhasivam@linaro.org>
 <ZCK3fGkgowvAd6Dw@hovoldconsulting.com>
 <20230328100501.GD5695@thinkpad>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230328100501.GD5695@thinkpad>
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 28, 2023 at 03:35:01PM +0530, Manivannan Sadhasivam wrote:
> On Tue, Mar 28, 2023 at 11:46:36AM +0200, Johan Hovold wrote:
> > On Sat, Mar 25, 2023 at 10:22:17PM +0530, Manivannan Sadhasivam wrote:
> > > dwc3-qcom driver is capable of doing runtime PM on its own, but currently
> > > it requires userspace intervention to enable it. But there is no harm in
> > > letting the driver to enable runtime PM on its own. So let's get rid of the
> > > "pm_runtime_forbid()" and make sure that the dependency is maintained with
> > > child devices using "pm_suspend_ignore_children(dev, false)".
> > 
> > Well, the potential harm is that these paths have hardly been tested so
> > enabling it by default is a risk (e.g. as you noticed when trying to
> > enable this by default). And especially if we don't address the layering
> > violations first.
> > 
> 
> I certainly tested this on a couple of boards with host and gadget mode and
> noticed no issue (except one issue noticed by Steev on a docking station with
> display but that should be related to orientation switch).
> 
> Even if we allow runtime PM on this driver, still userspace needs to enable it
> for dwc3 and xhci drivers. So this essentially reduces one step in that process
> if someone tries to enable runtime PM for usb intentionally. So I don't forsee a
> potential harm here.

Well this whole driver is a mess so I don't have any problem imagining
ways in which things can break. ;)

> > > Also during remove(), the device needs to be waken up first if it was
> > > runtime suspended. Finally, pm_runtime_allow() can be removed.
> > > 
> > > Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> > > ---
> > >  drivers/usb/dwc3/dwc3-qcom.c | 5 +++--
> > >  1 file changed, 3 insertions(+), 2 deletions(-)
> > > 
> > > diff --git a/drivers/usb/dwc3/dwc3-qcom.c b/drivers/usb/dwc3/dwc3-qcom.c
> > > index f1059dfcb0e8..5f26bb66274f 100644
> > > --- a/drivers/usb/dwc3/dwc3-qcom.c
> > > +++ b/drivers/usb/dwc3/dwc3-qcom.c
> > > @@ -920,7 +920,7 @@ static int dwc3_qcom_probe(struct platform_device *pdev)
> > >  	qcom->is_suspended = false;
> > >  	pm_runtime_set_active(dev);
> > >  	pm_runtime_enable(dev);
> > > -	pm_runtime_forbid(dev);
> > > +	pm_suspend_ignore_children(dev, false);
> > 
> > There's no need to explicitly disable ignore-children as that is the
> > default.
> > 
> 
> Other dwc drivers were doing it, so I thought someone (maintainer) wanted to
> explicitly disable ignore_children. But if that's not the case, I can remove it.

Yeah, please remove it. I doubt these runtime pm implementations have
gotten much review.

Note how several dwc3 glue drivers just do an unconditional get in
probe(), which means that these paths are probably never exercised at
all and effectively amounts to that pm_runtime_forbid() you are removing
here.

Probably there to tick off "runtime pm" on some internal project
manager's list of "features".

> > >  	return 0;
> > >  
> > > @@ -948,6 +948,8 @@ static int dwc3_qcom_remove(struct platform_device *pdev)
> > >  	struct device *dev = &pdev->dev;
> > >  	int i;
> > >  
> > > +	pm_runtime_get_sync(dev);
> > 
> > This call needs to be balanced. But this is a fix for a bug in the
> > current implementation that should go in a separate patch.
> > 
> 
> Ok. For balancing I could add pm_runtime_put_noidle() before pm_runtime_disable.

You should do it after disabling runtime pm.

> > > +
> > >  	device_remove_software_node(&qcom->dwc3->dev);
> > >  	of_platform_depopulate(dev);
> > >  
> > > @@ -960,7 +962,6 @@ static int dwc3_qcom_remove(struct platform_device *pdev)
> > >  	dwc3_qcom_interconnect_exit(qcom);
> > >  	reset_control_assert(qcom->resets);
> > >  
> > > -	pm_runtime_allow(dev);
> > >  	pm_runtime_disable(dev);
> > >  
> > >  	return 0;

Johan
