Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 20F6C7280E5
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Jun 2023 15:09:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236560AbjFHNJG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Jun 2023 09:09:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232139AbjFHNJD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Jun 2023 09:09:03 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D94F1988;
        Thu,  8 Jun 2023 06:09:03 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A2FCC64D67;
        Thu,  8 Jun 2023 13:09:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EF4E8C433EF;
        Thu,  8 Jun 2023 13:09:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686229742;
        bh=XJFyzxyzQog03Y2H8SeTcQtE79dhC9sQakEAuil2jm0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=cX5KA6wERDqpAZubEQUCvUoHTzVVo13JHxluW9SV1bfTnbnEFXQ//RyyxhOojGYze
         ADVkS7ItlgonD3M9nO2F8Rl5Okj88hKxtzT8pAADaF8+sAene36qINELweca3Jnrw7
         fpmOuc8PDUGxjbl8+9+a2JwOSOfyo8mxx6wcPyYwa+AIFSMiHUvRsbxU9HVDAsCxRY
         VJlDfZXplN+wz4mBfzBdbKPGDfQgHVXV0zTCjcXL5DIr5sq/MSvWog7pF1uIVCS1nJ
         Lr7O9++v+MngJQ6FT79yG/kQyuYVc4VDZbpY422NhRpHl/bG1Q14dLYJxjd/cI03J+
         eQPAzEolN9kvg==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan@kernel.org>)
        id 1q7FOJ-0007xj-JZ; Thu, 08 Jun 2023 15:09:27 +0200
Date:   Thu, 8 Jun 2023 15:09:27 +0200
From:   Johan Hovold <johan@kernel.org>
To:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc:     Johan Hovold <johan+linaro@kernel.org>,
        Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Krishna Kurapati <quic_kriskura@quicinc.com>,
        linux-usb@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        Li Jun <jun.li@nxp.com>,
        Sandeep Maheswaram <quic_c_sanm@quicinc.com>
Subject: Re: [PATCH 2/2] USB: dwc3: fix use-after-free on core driver unbind
Message-ID: <ZIHTBw3pMNjieVyj@hovoldconsulting.com>
References: <20230607100540.31045-1-johan+linaro@kernel.org>
 <20230607100540.31045-3-johan+linaro@kernel.org>
 <20230608130246.GF5672@thinkpad>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230608130246.GF5672@thinkpad>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 08, 2023 at 06:32:46PM +0530, Manivannan Sadhasivam wrote:
> On Wed, Jun 07, 2023 at 12:05:40PM +0200, Johan Hovold wrote:
> > Some dwc3 glue drivers are currently accessing the driver data of the
> > child core device directly, which is clearly a bad idea as the child may
> > not have probed yet or may have been unbound from its driver.
> > 
> > As a workaround until the glue drivers have been fixed, clear the driver
> > data pointer before allowing the glue parent device to runtime suspend
> > to prevent its driver from accessing data that has been freed during
> > unbind.

> > @@ -1929,6 +1929,11 @@ static int dwc3_remove(struct platform_device *pdev)
> >  	pm_runtime_disable(&pdev->dev);
> >  	pm_runtime_dont_use_autosuspend(&pdev->dev);
> >  	pm_runtime_put_noidle(&pdev->dev);
> > +	/*
> > +	 * HACK: Clear the driver data, which is currently accessed by parent
> > +	 * glue drivers, before allowing the parent to suspend.
> > +	 */
> > +	platform_set_drvdata(pdev, NULL);
> 
> This is required because you have seen the glue driver going to runtime suspend
> once the below pm_runtime_set_suspended() is completed?

This is based on analysis of the code. The parent (glue) can not suspend
while the child (core) is in the active state, but once we set the
suspended state that could happen.

> >  
> >  	dwc3_free_event_buffers(dwc);

Johan
