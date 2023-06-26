Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D62C73DC96
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Jun 2023 12:58:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230073AbjFZK6F convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Mon, 26 Jun 2023 06:58:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230019AbjFZK6B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Jun 2023 06:58:01 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54AC78F
        for <linux-kernel@vger.kernel.org>; Mon, 26 Jun 2023 03:58:00 -0700 (PDT)
Received: from ptz.office.stw.pengutronix.de ([2a0a:edc0:0:900:1d::77] helo=[IPv6:::1])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <l.stach@pengutronix.de>)
        id 1qDjun-0005JX-Es; Mon, 26 Jun 2023 12:57:49 +0200
Message-ID: <3927bb24f1f3480bf2d25a9a0f608aec9e58240d.camel@pengutronix.de>
Subject: Re: [PATCH v10 01/11] drm/etnaviv: Add a dedicated function to
 register an irq handler
From:   Lucas Stach <l.stach@pengutronix.de>
To:     Sui Jingfeng <suijingfeng@loongson.cn>,
        Sui Jingfeng <18949883232@163.com>,
        Russell King <linux+etnaviv@armlinux.org.uk>,
        Christian Gmeiner <christian.gmeiner@gmail.com>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        etnaviv@lists.freedesktop.org
Date:   Mon, 26 Jun 2023 12:57:37 +0200
In-Reply-To: <c1bac8c0-062a-72ed-e120-802965472191@loongson.cn>
References: <20230620094716.2231414-1-18949883232@163.com>
         <20230620094716.2231414-2-18949883232@163.com>
         <77f62814f98dd2728a1e4747f0db6b2a3cfa2c11.camel@pengutronix.de>
         <52751b55-ce34-f3a8-b3c0-4858ad984622@loongson.cn>
         <21f781a548cef63312df56cb2265de9a7c9a0901.camel@pengutronix.de>
         <c1bac8c0-062a-72ed-e120-802965472191@loongson.cn>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
User-Agent: Evolution 3.46.4 (3.46.4-1.fc37) 
MIME-Version: 1.0
X-SA-Exim-Connect-IP: 2a0a:edc0:0:900:1d::77
X-SA-Exim-Mail-From: l.stach@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Samstag, dem 24.06.2023 um 23:53 +0800 schrieb Sui Jingfeng:
> Hi,
> 
> On 2023/6/21 18:16, Lucas Stach wrote:
> > Am Mittwoch, dem 21.06.2023 um 17:20 +0800 schrieb Sui Jingfeng:
> > > Hi,
> > > 
> > > On 2023/6/21 17:07, Lucas Stach wrote:
> > > > Am Dienstag, dem 20.06.2023 um 17:47 +0800 schrieb Sui Jingfeng:
> > > > > From: Sui Jingfeng <suijingfeng@loongson.cn>
> > > > > 
> > > > > Because getting IRQ from a device is platform-dependent, PCI devices have
> > > > > different methods for getting an IRQ. This patch is a preparation to extend
> > > > > this driver for supporting the PCI devices.
> > > > > 
> > > > > Cc: Lucas Stach <l.stach@pengutronix.de>
> > > > > Cc: Christian Gmeiner <christian.gmeiner@gmail.com>
> > > > > Cc: Philipp Zabel <p.zabel@pengutronix.de>
> > > > > Cc: Bjorn Helgaas <bhelgaas@google.com>
> > > > > Cc: Daniel Vetter <daniel@ffwll.ch>
> > > > > Signed-off-by: Sui Jingfeng <suijingfeng@loongson.cn>
> > > > > ---
> > > > >    drivers/gpu/drm/etnaviv/etnaviv_gpu.c | 32 +++++++++++++++++++--------
> > > > >    1 file changed, 23 insertions(+), 9 deletions(-)
> > > > > 
> > > > > diff --git a/drivers/gpu/drm/etnaviv/etnaviv_gpu.c b/drivers/gpu/drm/etnaviv/etnaviv_gpu.c
> > > > > index de8c9894967c..a03e81337d8f 100644
> > > > > --- a/drivers/gpu/drm/etnaviv/etnaviv_gpu.c
> > > > > +++ b/drivers/gpu/drm/etnaviv/etnaviv_gpu.c
> > > > > @@ -1817,6 +1817,27 @@ static const struct of_device_id etnaviv_gpu_match[] = {
> > > > >    };
> > > > >    MODULE_DEVICE_TABLE(of, etnaviv_gpu_match);
> > > > >    
> > > > > +static int etnaviv_gpu_register_irq(struct etnaviv_gpu *gpu, int irq)
> > > > > +{
> > > > > +	struct device *dev = gpu->dev;
> > > > > +	int err;
> > > > > +
> > > > > +	if (irq < 0)
> > > > > +		return irq;
> > > > > +
> > > > > +	err = devm_request_irq(dev, irq, irq_handler, 0, dev_name(dev), gpu);
> > > > > +	if (err) {
> > > > > +		dev_err(dev, "failed to request irq %u: %d\n", irq, err);
> > > > > +		return err;
> > > > > +	}
> > > > > +
> > > > > +	gpu->irq = irq;
> > > > > +
> > > > > +	dev_info(dev, "irq(%d) handler registered\n", irq);
> > > > There is no reason to put this into the kernel log.
> > > I want to see the IRQ of the device when debugging,
> > > 
> > > etnaviv actually print very less.
> > > 
> > > This serve as a minimal signal  to us the etnaviv_gpu_register_irq()
> > > function is successful at driver load time.
> > > 
> > And debugging is a very different use-case than normal operation. If
> > it's needed at all, downgrade this to dev_dbg. This isn't interesting
> > information for a ordinary user of a system.
> > 
> > > >    It's no different
> > > > than other resources to the driver and we don't log each one of those
> > > > either.
> > > > 
> > > > In fact I don't see any reason for this change in the first place.
> > > > Effectively you are moving a single function call into a new function,
> > > > which doesn't seem like an improvement.
> > > This is to make the patch easy to review, each patch is only introduce a
> > > small function,
> > > 
> > What I'm saying is that I don't see the need to introduce this function
> > at all. All you need to do is move platform_get_irq out into the
> > platform device code path. The devm_request_irq can stay where it is,
> > as the only difference between platform and PCI device is how the irq
> > number is retrieved from the platform.
> 
> Yes, you are right. I understand what are asking, but my point is:
> 
> 
> This patch is paving the way for us to introduce the PCI device driver.
> 
> All of the patches before the patch 
> v10-0006-drm-etnaviv-Add-driver-support-for-the-PCI-devic.patch
> 
> are actually doing the preparation.
> 
> 
> Look at the patch 0006, I achieve the goal by 128 insertions and 7 
> deletions.
> 
> while the only 7 deletions are actually for code shading(convert the 
> static function to global function).
> 
> There is No large area diff and NO distortion.
> 
> The goal is adding a PCI device driver on the top of what we already have.
> 
> 
> Before the cleanup, the etnaviv_gpu_platform_probe() function is just 
> like is a *glue*.
> 
> Originally,  it integrate a lot of irrelevant part together.
> 
> 
> 1.  Mapping MMIO registers make it platform-dependent;
> 
> 2.  Calling platform_get_irq(pdev, 0) make it platform-dependent;
> 
I get that and I'm fine with moving this out of this function. But
that's not what you are actually doing in this patch. You are moving
devm_request_irq out of this function, which isn't necessary, since the
request IRQ is not platform dependent. It's the retrieval of the IRQ
number to request (platform_get_irq/pdev->irq) which is platform
dependent.

Regards,
Lucas

> 3.  Getting Clocks by calling devm_clk_get() make it platform-dependent;
> 
> 4.  Calling component_add() make it subsytem and framework-dependent;
> 
> 
> All of above list item is deny us to introduce the PCI device driver 
> wrapper.
> 
> It(sub-functional code) is not relevant to each other.
> 
> Hence the first five patch is actually do the clean,
> 
> for the clarify(and tidy and good looking) of the patch 6.
> 
> 
> I will drop the printing, but keep the cleanup function there,
> 
> Is this acceptable?
> 
> 
> > Regards,
> > Lucas
> > 
> > > which is paving the way for we introducing the PCI device driver.
> > > 
> > > Otherwise when we introducing the PCI device driver, the patch is looks
> > > ugly,
> > > 
> > > It is difficult to review.
> > > 
> > > > Regards,
> > > > Lucas
> > > > 
> > > > > +
> > > > > +	return 0;
> > > > > +}
> > > > > +
> > > > >    static int etnaviv_gpu_platform_probe(struct platform_device *pdev)
> > > > >    {
> > > > >    	struct device *dev = &pdev->dev;
> > > > > @@ -1837,16 +1858,9 @@ static int etnaviv_gpu_platform_probe(struct platform_device *pdev)
> > > > >    		return PTR_ERR(gpu->mmio);
> > > > >    
> > > > >    	/* Get Interrupt: */
> > > > > -	gpu->irq = platform_get_irq(pdev, 0);
> > > > > -	if (gpu->irq < 0)
> > > > > -		return gpu->irq;
> > > > > -
> > > > > -	err = devm_request_irq(&pdev->dev, gpu->irq, irq_handler, 0,
> > > > > -			       dev_name(gpu->dev), gpu);
> > > > > -	if (err) {
> > > > > -		dev_err(dev, "failed to request IRQ%u: %d\n", gpu->irq, err);
> > > > > +	err = etnaviv_gpu_register_irq(gpu, platform_get_irq(pdev, 0));
> > > > > +	if (err)
> > > > >    		return err;
> > > > > -	}
> > > > >    
> > > > >    	/* Get Clocks: */
> > > > >    	gpu->clk_reg = devm_clk_get_optional(&pdev->dev, "reg");
> 

