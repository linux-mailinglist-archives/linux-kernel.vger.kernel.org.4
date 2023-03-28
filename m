Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BCF046CC117
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Mar 2023 15:36:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233183AbjC1NgN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Mar 2023 09:36:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232776AbjC1NgK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Mar 2023 09:36:10 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4DB072713;
        Tue, 28 Mar 2023 06:35:47 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id A4483CE1D0B;
        Tue, 28 Mar 2023 13:35:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BC6ACC4339C;
        Tue, 28 Mar 2023 13:35:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1680010516;
        bh=k7B50eOUaIqO0y0tx+624NKxyiYI62MTUuFy5J3oNR4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=oFgEPrvuCVNG1w1Ymg3p8HqRstdy/Y66hPoy0MHI/dmhNuf2RvaqVn+3NrixP7Ho5
         wanGMkr3pqtcjBSM0BbqOGPz7UrGCyraevUnYbCTOsx3V/w7KZrYvJ1GMM+b8A3LSM
         giAdwHthr2jMeZ8WwdDR3JV4li1FrgHrk8ig8mPlJGYOyYpOnTMOBJln+te1FDqKia
         OnlvRm4a8cCH3t6rOEFlgTdAGn4gayvZFaeQlf1A+Bt/QelvyxQR2ms0hJ6fExA9O3
         32OZRgsO0wsTW4qDa0zoBj4guHe3cS+JVod+csfJMeWlAFFAj83bvmaujfjoCY+sRl
         APO0yNfRO82yA==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan@kernel.org>)
        id 1ph9U1-0008Se-5W; Tue, 28 Mar 2023 15:35:29 +0200
Date:   Tue, 28 Mar 2023 15:35:29 +0200
From:   Johan Hovold <johan@kernel.org>
To:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc:     andersson@kernel.org, Thinh.Nguyen@synopsys.com,
        gregkh@linuxfoundation.org, mathias.nyman@intel.com,
        konrad.dybcio@linaro.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, linux-arm-msm@vger.kernel.org,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH 5/5] usb: dwc3: qcom: Allow runtime PM
Message-ID: <ZCLtITAsPiCnmndQ@hovoldconsulting.com>
References: <20230325165217.31069-1-manivannan.sadhasivam@linaro.org>
 <20230325165217.31069-6-manivannan.sadhasivam@linaro.org>
 <ZCK3fGkgowvAd6Dw@hovoldconsulting.com>
 <20230328100501.GD5695@thinkpad>
 <ZCLbCJi80AKyVgnq@hovoldconsulting.com>
 <20230328125705.GG5695@thinkpad>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230328125705.GG5695@thinkpad>
X-Spam-Status: No, score=-5.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 28, 2023 at 06:27:05PM +0530, Manivannan Sadhasivam wrote:
> On Tue, Mar 28, 2023 at 02:18:16PM +0200, Johan Hovold wrote:

> > > > > @@ -948,6 +948,8 @@ static int dwc3_qcom_remove(struct platform_device *pdev)
> > > > >  	struct device *dev = &pdev->dev;
> > > > >  	int i;
> > > > >  
> > > > > +	pm_runtime_get_sync(dev);
> > > > 
> > > > This call needs to be balanced. But this is a fix for a bug in the
> > > > current implementation that should go in a separate patch.
> > > 
> > > Ok. For balancing I could add pm_runtime_put_noidle() before pm_runtime_disable.
> > 
> > You should do it after disabling runtime pm.
> 
> May I know why?

The usage counter should be balanced after disabling runtime PM so that
there is no window where you could get a racing suspend request.

> > > > > +
> > > > >  	device_remove_software_node(&qcom->dwc3->dev);
> > > > >  	of_platform_depopulate(dev);
> > > > >  
> > > > > @@ -960,7 +962,6 @@ static int dwc3_qcom_remove(struct platform_device *pdev)
> > > > >  	dwc3_qcom_interconnect_exit(qcom);
> > > > >  	reset_control_assert(qcom->resets);
> > > > >  
> > > > > -	pm_runtime_allow(dev);
> > > > >  	pm_runtime_disable(dev);
> > > > >  
> > > > >  	return 0;

Johan
