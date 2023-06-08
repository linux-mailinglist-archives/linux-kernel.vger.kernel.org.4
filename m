Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D48D77281BD
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Jun 2023 15:49:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236650AbjFHNtl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Jun 2023 09:49:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236531AbjFHNtg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Jun 2023 09:49:36 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0491726AB;
        Thu,  8 Jun 2023 06:49:34 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4E35364DC7;
        Thu,  8 Jun 2023 13:49:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A369EC433A1;
        Thu,  8 Jun 2023 13:49:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686232173;
        bh=Sa9nZsCxkXD9FQ5kXqqWNAwoYbU5YK9mi/D75HIteHg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=VSb9bu4GA6/8gt/eIjkIakHh/kPuBohC729d4Zdzb7MdeFx0pnKEHWKW/iPHMIC2j
         7ahFbG4Hox64nxj1XbVLLr4TbyKKgXcwk+KWc5AAUGpcp2TbHX4b38Ce/IdlVoMzOx
         HsdHyGKBBYsxnk9BNvjmj+IkAGd6L96+Kps2cvQLIOtbDR0B9MoLTk9GiClGFoEdGq
         vZBZ0XuacaNRCwSwoTXefyJvJUTEjOQRcFTplMkePgRN5iDPN52bUZH5B1ETv7PSLj
         8i9K5aH4ujLfNAEiSVuCKoJt04YbjTvEfttiUWbLCUGfUmt0wYQiNSX22IpDWTWkPS
         blwaVMP24omnw==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan@kernel.org>)
        id 1q7G1W-0001f5-Up; Thu, 08 Jun 2023 15:49:59 +0200
Date:   Thu, 8 Jun 2023 15:49:58 +0200
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
Message-ID: <ZIHchsMdf2nPv3wh@hovoldconsulting.com>
References: <20230607100540.31045-1-johan+linaro@kernel.org>
 <20230607100540.31045-3-johan+linaro@kernel.org>
 <20230608130246.GF5672@thinkpad>
 <ZIHTBw3pMNjieVyj@hovoldconsulting.com>
 <20230608132313.GG5672@thinkpad>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230608132313.GG5672@thinkpad>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 08, 2023 at 06:53:13PM +0530, Manivannan Sadhasivam wrote:
> On Thu, Jun 08, 2023 at 03:09:27PM +0200, Johan Hovold wrote:
> > On Thu, Jun 08, 2023 at 06:32:46PM +0530, Manivannan Sadhasivam wrote:
> > > On Wed, Jun 07, 2023 at 12:05:40PM +0200, Johan Hovold wrote:
> > > > Some dwc3 glue drivers are currently accessing the driver data of the
> > > > child core device directly, which is clearly a bad idea as the child may
> > > > not have probed yet or may have been unbound from its driver.
> > > > 
> > > > As a workaround until the glue drivers have been fixed, clear the driver
> > > > data pointer before allowing the glue parent device to runtime suspend
> > > > to prevent its driver from accessing data that has been freed during
> > > > unbind.
> > 
> > > > @@ -1929,6 +1929,11 @@ static int dwc3_remove(struct platform_device *pdev)
> > > >  	pm_runtime_disable(&pdev->dev);
> > > >  	pm_runtime_dont_use_autosuspend(&pdev->dev);
> > > >  	pm_runtime_put_noidle(&pdev->dev);
> > > > +	/*
> > > > +	 * HACK: Clear the driver data, which is currently accessed by parent
> > > > +	 * glue drivers, before allowing the parent to suspend.
> > > > +	 */
> > > > +	platform_set_drvdata(pdev, NULL);
> > > 
> > > This is required because you have seen the glue driver going to runtime suspend
> > > once the below pm_runtime_set_suspended() is completed?
> > 
> > This is based on analysis of the code. The parent (glue) can not suspend
> > while the child (core) is in the active state, but once we set the
> > suspended state that could happen.
> 
> I could see that the driver core is setting drvdata to NULL during
> device_unbind_cleanup(), so not sure if this scenario could be met otherwise it
> will be redundant.

If this was redundant I wouldn't have added it. ;)

The parent driver has no business accessing the driver data of the child
in the first place, but it must absolutely not do so after the child has
been unbound from its driver and the driver data is getting freed.

Relying on the clean up in driver core that resets this pointer does not
work as that would still leave a window where the parent could access
this stale data.

Johan
