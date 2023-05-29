Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EFFC87146BA
	for <lists+linux-kernel@lfdr.de>; Mon, 29 May 2023 10:57:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231739AbjE2I47 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 May 2023 04:56:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230390AbjE2I45 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 May 2023 04:56:57 -0400
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B443E91;
        Mon, 29 May 2023 01:56:55 -0700 (PDT)
Received: from pendragon.ideasonboard.com (om126255106133.24.openmobile.ne.jp [126.255.106.133])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 9ED086D5;
        Mon, 29 May 2023 10:56:33 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1685350594;
        bh=rayQWHHa9JlAPYgWdLbLAtmB25Gu7jfFbx7UIlsifWY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=N4tsmrQbXzVDFOdg6rvkoOiQXwAGtY7NUvlO0LH0E4OgVqRbRbWo87EWVWgkn12dl
         B1FeKY7mekQXcKApavsWKEkkRAuFc19CXGEIBegHs6YqVc/zXd1FcoHH9TVpoHeEf2
         8OlP0oAWEbMlc6ixPCr5N72Twecjg8nUfz+rulWA=
Date:   Mon, 29 May 2023 11:56:56 +0300
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     Biju Das <biju.das.jz@bp.renesas.com>
Cc:     Marc Zyngier <maz@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Zheng Wang <zyytlz.wz@163.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        "linux-renesas-soc@vger.kernel.org" 
        <linux-renesas-soc@vger.kernel.org>
Subject: Re: [PATCH] usb: gadget: udc: renesas_usb3: Fix RZ/V2M
 {modprobe,bind} error
Message-ID: <20230529085656.GL25984@pendragon.ideasonboard.com>
References: <20230526143615.372338-1-biju.das.jz@bp.renesas.com>
 <20230529061714.GA25984@pendragon.ideasonboard.com>
 <OS0PR01MB592296756992262EC6D382D0864A9@OS0PR01MB5922.jpnprd01.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <OS0PR01MB592296756992262EC6D382D0864A9@OS0PR01MB5922.jpnprd01.prod.outlook.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Biju,

On Mon, May 29, 2023 at 08:42:34AM +0000, Biju Das wrote:
> > Subject: Re: [PATCH] usb: gadget: udc: renesas_usb3: Fix RZ/V2M
> > {modprobe,bind} error
> > 
> > Hi Biju,
> > 
> > Thank you for the patch.
> > 
> > On Fri, May 26, 2023 at 03:36:15PM +0100, Biju Das wrote:
> > > Currently {modprobe, bind} after {rmmod, unbind} results in probe
> > failure.
> > >
> > > genirq: Flags mismatch irq 22. 00000004 (85070400.usb3drd) vs.
> > > 00000004 (85070400.usb3drd)
> > > renesas_usb3: probe of 85070000.usb3peri failed with error -16
> > >
> > > Fix this issue by replacing "parent dev"->"dev" as the irq resource is
> > > managed by this driver.
> > 
> > If the dev pointer passed to devm_request_irq() is not the correct one,
> > how does it work the first time the driver is loaded ?
> 
> + Marc/ Kernel.org to give some feedback on this issue
> 
> I believe there may be a bug in the genirq (kernel/irq) driver.
> first time it works ok. Maybe this driver is caching on unload
> with null value and comparing with actual one (irq 22) during reload??
> 
> Maybe genirq expert can comment what went wrong here??

I'm curious to understand this (an update to the commit message would
then be nice), but regardless, I think the code change is fine.

> > > Fixes: 9cad72dfc556 ("usb: gadget: Add support for RZ/V2M USB3DRD
> > driver"
> > 
> > There's a missing ')' at the end of the line.
> 
> Oops missed it.
> 
> > > Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
> > > ---
> > >  drivers/usb/gadget/udc/renesas_usb3.c | 2 +-
> > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > >
> > > diff --git a/drivers/usb/gadget/udc/renesas_usb3.c
> > > b/drivers/usb/gadget/udc/renesas_usb3.c
> > > index aac8bc185afa..4a37b2e4b9b3 100644
> > > --- a/drivers/usb/gadget/udc/renesas_usb3.c
> > > +++ b/drivers/usb/gadget/udc/renesas_usb3.c
> > > @@ -2877,7 +2877,7 @@ static int renesas_usb3_probe(struct platform_device *pdev)
> > >  		struct rzv2m_usb3drd *ddata = dev_get_drvdata(pdev->dev.parent);
> > >
> > >  		usb3->drd_reg = ddata->reg;
> > > -		ret = devm_request_irq(ddata->dev, ddata->drd_irq,
> > > +		ret = devm_request_irq(&pdev->dev, ddata->drd_irq,
> > >  				       renesas_usb3_otg_irq, 0,
> > >  				       dev_name(ddata->dev), usb3);
> > 
> > Shouldn't you use dev_name(&pdev->dev) too ?
> 
> This irq resource belongs to usb3drd driver and is managed by renesas_usb3 driver.
> It is just representation of irqname and cat /proc/interrupts shows the correct 
> irq resource name. with dev_name(ddata->dev), it displays correct resource name
> associated with the handler.
> 
> root@rzv2m:~# cat /proc/interrupts | grep usb
>  22:          0     GICv2 274 Level     85070400.usb3drd
>  23:        353     GICv2 277 Level     xhci-hcd:usb1
>  28:          0     GICv2 278 Level     85070000.usb3peri

The name is just informative so I suppose it's ok. It makes me wonder,
though, if the usb3drd driver shouldn't register the interrupt handler
itself.

> > >  		if (ret < 0)

-- 
Regards,

Laurent Pinchart
