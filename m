Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A31DE68815B
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Feb 2023 16:12:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230323AbjBBPMu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Feb 2023 10:12:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232066AbjBBPMp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Feb 2023 10:12:45 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32E0592EDE;
        Thu,  2 Feb 2023 07:12:16 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6C7DB61BAC;
        Thu,  2 Feb 2023 15:12:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C732AC433D2;
        Thu,  2 Feb 2023 15:12:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1675350729;
        bh=FADAJ7fzOlAj6IlWfkCJlp2pM9Mc7N/7WkC1EFkVr6E=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=D+JWXkktcZdpk+sJtWfWAUm/6ii8C9Z6B0+YMXdmxO+2q0Tv7ih8mv2D40/kIAaF3
         GGv/znKepBtd8jW7asVpLY7ZPIhbREaNIuaT9ydleVbx+itZqwa6BPiOXdtY8w3raO
         EmQT+3Dv7RBhD/4FwSn3qyntQU0U+WCxXa7ima3A8xoYNPjXQb7/GsL6eoTZAvTKtu
         bT+vzQkcLpvVtyuBClIPmNb7Xyzrk+e/lmgqyjT3MCdEM1UpZCyH8UvSpTMqCyiA/Q
         GSJLSGscUgYl0siR5b0oFIRalHhMKqBW0Ewl+LWa1UpBPKQQtbTzqXcL6XKHZKeZfi
         jRF1g5Dijx9gA==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan@kernel.org>)
        id 1pNbGL-0003yq-C3; Thu, 02 Feb 2023 16:12:34 +0100
Date:   Thu, 2 Feb 2023 16:12:33 +0100
From:   Johan Hovold <johan@kernel.org>
To:     Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc:     Johan Hovold <johan+linaro@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Alessandro Zummo <a.zummo@towertech.it>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Maximilian Luz <luzmaximilian@gmail.com>,
        linux-arm-msm@vger.kernel.org, linux-rtc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 16/24] rtc: pm8xxx: add support for nvmem offset
Message-ID: <Y9vS4TpVHDnGN0G/@hovoldconsulting.com>
References: <20230126142057.25715-1-johan+linaro@kernel.org>
 <20230126142057.25715-17-johan+linaro@kernel.org>
 <Y9PpQkW3Rtm+bi2V@mail.local>
 <Y9Py/+GpI8x8ldDG@hovoldconsulting.com>
 <Y9P2L9sNiHIZt3On@mail.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y9P2L9sNiHIZt3On@mail.local>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 27, 2023 at 05:05:03PM +0100, Alexandre Belloni wrote:
> On 27/01/2023 16:51:27+0100, Johan Hovold wrote:

> > > > @@ -380,9 +478,23 @@ static int pm8xxx_rtc_probe(struct platform_device *pdev)
> > > >  	rtc_dd->allow_set_time = of_property_read_bool(pdev->dev.of_node,
> > > >  						      "allow-set-time");
> > > >  
> > > > +	rtc_dd->nvmem_cell = devm_nvmem_cell_get(&pdev->dev, "offset");
> > > 
> > > Maybe we should get something more specific than just "offset" so this
> > > could be parsed in the RTC core at some point (this is the second RTC to
> > > behave like this)
> > 
> > Yes, that thought crossed my mind, but it's an nvmem cell name (label)
> > and not a generic devicetree property. If you look at the binding
> > document I think the name makes sense given the current description, and
> > I'm not sure changing to something like 'base' would be much of an
> > improvement.
> > 
> > I also don't expect there to be more broken RTCs out there like these
> > ones. Hopefully Qualcomm will even get this fixed at some point
> > themselves.
> > 
> > And I assume you were think of the old Atmel driver which uses a timer
> > counter and a scratch register as a base? That one is also a bit
> > different in that the timer can be reset, just not set.
> 
> Nope, I'm thinking about the gamecube one and probably the nintendo
> switch one which seems to behave similarly (no driver in the kernel
> though).

Found the gamecube one now (misread you comment above to imply that it
was also out of tree).

That one is also different in that the timer in that RTC can also be
set (e.g. like the atmel one), but for consistency with some firmware an
offset also needs to be read from SRAM (not NVRAM) and applied. That
offset is also never updated by Linux.

Johan
