Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 70FAD65223F
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Dec 2022 15:15:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233871AbiLTOPx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Dec 2022 09:15:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233876AbiLTOPX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Dec 2022 09:15:23 -0500
Received: from mail-il1-x135.google.com (mail-il1-x135.google.com [IPv6:2607:f8b0:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F26FD102E
        for <linux-kernel@vger.kernel.org>; Tue, 20 Dec 2022 06:15:22 -0800 (PST)
Received: by mail-il1-x135.google.com with SMTP id y3so6375566ilq.0
        for <linux-kernel@vger.kernel.org>; Tue, 20 Dec 2022 06:15:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=n5YVSZP1qMDUAMZj5yVmhmGJiwrbCGslZLrs7dgXveI=;
        b=aahg07TO5qqL2P8ldfKzEwDW1JTMSKZC7uZ2mS+qUzY52sD3nQxiCcE25vBpcZMwT7
         T0KbmRrQs2AL/Lk12okLloni24OffsT9qD+DcZwuA5dWv9rz/8xsHtOPduvCVfpPpOn+
         gekyUcos3FunUsdfbc3cGdQFcOxsjMgLrt1zE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=n5YVSZP1qMDUAMZj5yVmhmGJiwrbCGslZLrs7dgXveI=;
        b=f+rTs0clBnVGtduevmUu6EnkYr7mOjppHBLVK0wY+OqOHTMESBdBmPNvc8tNbP2JZt
         x8Cq5gc/xNDxFaSk0UzNKyxmrwv39L651A/ZAsoj0WpkyHL1m/ABnCW8hf+GJzzuDt1d
         rCtRbrMCTWNRXAs2zEYKQN8F6Gq0GDFP6cg3mJfe5FH4e/P4RITKmPNlOyS7uqb3I2O6
         NA/kyeiDAyUUnT/G0bTmTHM8fGjEq00MWDLco87SEaiA2XSF8cuPAJti0jlOqBxA3VXX
         S+CR5eC47zo81QF36/D+Sh2eFWbQxqkGiQfq6UPMcCiMLMnSB4qFSPEziBVkBlKLAwG9
         KMJw==
X-Gm-Message-State: AFqh2kryzn21jJADHAYAW+ucLIkXeneYwOgW96h1/b6KHe4yB2TEBUMx
        AoivMTEOAwmHMVNuay95xebFgA==
X-Google-Smtp-Source: AMrXdXuRFfwLfDBIq+/ekNW2bbhN+jz9C7S5kvkw7f7+IrC7TMcYvk71jw6fIXy2uItSi8mNpHIEtg==
X-Received: by 2002:a05:6e02:4aa:b0:300:9a8:f586 with SMTP id e10-20020a056e0204aa00b0030009a8f586mr7189236ils.16.1671545722315;
        Tue, 20 Dec 2022 06:15:22 -0800 (PST)
Received: from localhost (30.23.70.34.bc.googleusercontent.com. [34.70.23.30])
        by smtp.gmail.com with UTF8SMTPSA id x24-20020a0566380cb800b00389d6a02740sm4628983jad.157.2022.12.20.06.15.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 20 Dec 2022 06:15:21 -0800 (PST)
Date:   Tue, 20 Dec 2022 14:15:19 +0000
From:   Matthias Kaehlcke <mka@chromium.org>
To:     Johan Hovold <johan@kernel.org>
Cc:     Rob Herring <robh@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Douglas Anderson <dianders@chromium.org>,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
        Stefan Wahren <stefan.wahren@i2se.com>,
        Ravi Chandra Sadineni <ravisadineni@chromium.org>
Subject: Re: [PATCH] usb: misc: onboard_usb_hub: Don't defer probing for
 'incomplete' DT nodes
Message-ID: <Y6HDXiRzaAZ+3uTp@google.com>
References: <20221220004427.1.If5e7ec83b1782e4dffa6ea759416a27326c8231d@changeid>
 <Y6FqiA/SoZHr36jl@hovoldconsulting.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Y6FqiA/SoZHr36jl@hovoldconsulting.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Johan,

On Tue, Dec 20, 2022 at 08:55:52AM +0100, Johan Hovold wrote:
> On Tue, Dec 20, 2022 at 12:45:01AM +0000, Matthias Kaehlcke wrote:
> > Some boards have device tree nodes for USB hubs supported by the
> > onboard_usb_hub driver, but the nodes don't have all properties
> > needed for the driver to work properly (which is not necessarily
> > an error in the DT). Currently _find_onboard_hub() returns
> > -EPROBE_DEFER in such cases, which results in an unusable USB hub,
> > since successive probes fail in the same way. Use the absence of
> > the "vdd" supply as an indicator of such 'incomplete' DT nodes
> > and return -ENODEV.
> > 
> > Fixes: 8bc063641ceb ("usb: misc: Add onboard_usb_hub driver")
> > Reported-by: Stefan Wahren <stefan.wahren@i2se.com>
> > Signed-off-by: Matthias Kaehlcke <mka@chromium.org>
> > ---
> > 
> >  drivers/usb/misc/onboard_usb_hub.c | 9 +++++++++
> >  1 file changed, 9 insertions(+)
> > 
> > diff --git a/drivers/usb/misc/onboard_usb_hub.c b/drivers/usb/misc/onboard_usb_hub.c
> > index d63c63942af1..2968da515016 100644
> > --- a/drivers/usb/misc/onboard_usb_hub.c
> > +++ b/drivers/usb/misc/onboard_usb_hub.c
> > @@ -363,6 +363,15 @@ static struct onboard_hub *_find_onboard_hub(struct device *dev)
> >  	hub = dev_get_drvdata(&pdev->dev);
> >  	put_device(&pdev->dev);
> >  
> > +	/*
> > +	 * Some boards have device tree nodes for USB hubs supported by this
> > +	 * driver, but the nodes don't have all properties needed for the driver
> > +	 * to work properly. Use the absence of the "vdd" supply as an indicator
> > +	 * of such nodes.
> > +	 */
> > +	if (!of_get_property(pdev->dev.of_node, "vdd", NULL))
> > +		return ERR_PTR(-ENODEV);
> 
> Does this not break your original use case? Don't you want "vdd-supply"
> here?

Ouch, yes it does (to a certain degree). Thanks for pointing it out. My
sanity check didn't catch this because the platform driver still probes
successfully and powers the hub on.

> That said, this seems like the wrong property to look for both in
> principle and as it is described as optional by the binding:
> 
> 	Documentation/devicetree/bindings/usb/realtek,rts5411.yaml
> 
> It seems that you should use the compatible property and check that it
> holds one of the expected values:
> 
>  - usbbda,5411
>  - usbbda,411
> 
> rather than treat every hub node as describing a realtek hub (AFAIK,
> there is no generic binding for this yet).

The driver only probes for specific hub models, among them the Microchip
USB2514B hub with which Stefan encountered the regression [1].

My initial assumption when writing this driver was that the existence of
a node for a supported hub means that the driver should be used. However
the regression encountered by Stefan makes clear that this assumption is
incorrect. It's not common, but a device tree may have nodes for onboard
USB devices, among them hubs (which might become more common with this
driver). Not in all instances the hub nodes were added with the intention
of using this driver for power sequencing the hub (e.g. [2]). The
compatible string alone doesn't indicate that the onboard_hub driver
should be instantiated for a given hub, which is why I'm using the
existence of "vdd-supply" as indicator.

Thanks

m.

[1] https://lore.kernel.org/linux-usb/d04bcc45-3471-4417-b30b-5cf9880d785d@i2se.com/
[2] https://elixir.bootlin.com/linux/v6.1/source/arch/arm/boot/dts/bcm283x-rpi-lan7515.dtsi
