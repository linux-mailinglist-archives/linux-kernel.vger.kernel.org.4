Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A72885FC0C7
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Oct 2022 08:39:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229589AbiJLGjV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Oct 2022 02:39:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229517AbiJLGjT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Oct 2022 02:39:19 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC2EC564E0;
        Tue, 11 Oct 2022 23:39:18 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5B03861341;
        Wed, 12 Oct 2022 06:39:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BC41AC433C1;
        Wed, 12 Oct 2022 06:39:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1665556757;
        bh=B1ff8uHzFrPosXTXSv8vraozDbLxdmDekoGelWUPSek=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=SUgtgHCR+BXs1NX4KxvttGTrUGPZxsG4fIToaGlU4mZcGCNw3VYsy+Lf93UieiKMy
         Qt6b3qMC/+AQFAOyMJ0qe0xZd2ZNYusRevgylGZO9g3irg+AdBRUkGoVfZo210nQjj
         To774GG+Gv9hwX5PjzPn9kCeb5can2NJ93A3dXevJXMln0QgMz+L3DODLhDeDknOsA
         Nf50V1wyDmAi7UKChVOIDoZwsAMzP9rnhp+ku4eWB5splzA9eLI+ivP109uluFMo0q
         0P1zSLdkvxvoLzX6MJ7uCKZwZeAK4aoX5lC9aYG9jEZ1/Hyh90Kjn5gEBcUr4Ntw4/
         fuB0lDLq5GyCA==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan@kernel.org>)
        id 1oiVOV-0006Bh-R6; Wed, 12 Oct 2022 08:39:08 +0200
Date:   Wed, 12 Oct 2022 08:39:07 +0200
From:   Johan Hovold <johan@kernel.org>
To:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc:     Johan Hovold <johan+linaro@kernel.org>,
        Vinod Koul <vkoul@kernel.org>, Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 08/13] phy: qcom-qmp-pcie: drop power-down delay config
Message-ID: <Y0ZhC0apqGoAyeII@hovoldconsulting.com>
References: <20221011131416.2478-1-johan+linaro@kernel.org>
 <20221011131416.2478-9-johan+linaro@kernel.org>
 <66261491-530d-c368-6cc8-daeef74fcbda@linaro.org>
 <Y0V1TIBySTPhYqX/@hovoldconsulting.com>
 <ebe1e26a-7335-29ac-4990-6b8fdb02ba7c@linaro.org>
 <Y0V66q53I4ivlXI+@hovoldconsulting.com>
 <dbd85c78-86dc-8dd0-83d2-43af933e5a92@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <dbd85c78-86dc-8dd0-83d2-43af933e5a92@linaro.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 11, 2022 at 05:41:28PM +0300, Dmitry Baryshkov wrote:
> On 11/10/2022 17:17, Johan Hovold wrote:

> > Yeah, I noticed that ipq8074 was the first to abuse the prwdn_delay
> > and possibly because of it starting the PHY already in its PCS table
> > (which it never should have).
> > 
> > I'm talking about the intent of pwrdn_delay which was to add a delay
> > after powering-on the phy and before starting it.
> > 
> > The vendor driver has a 1 ms delay after starting the PHY and before it
> > starts polling as the PHY on newer SoC tend to take > 1 ms before they
> > are ready.
> > 
> > So, I still claim that that delay in the vendor driver is a different
> > one entirely.
> > 
> >> Thus, I'd say, the PCIe delay should be moved after the registers
> >> programming.
> > 
> > No, not necessarily. Again, that's an optimisation in the vendor driver
> > to avoid polling so many times. Since I can say for sure that there are
> > no PHY that start in less than 1 ms, I wouldn't add it unconditionally.
> 
> I don't think it's an optimization. For me it looks like some kind of 
> stabilization delay before touching pipe clocks.

I meant that it's effectively an optimisation as the driver still works
without that unconditional delay after starting the PHY and before
polling its status. And the mainline poll-loop takes care of waiting
also for that 1 ms of "stabilisation".

But I guess you could be right in that later contributors have seen that
delay in the vendor driver and thought that prwdn_delay corresponds to
it without noticing that they are not at all equivalent.

As the current delay is pretty much pointless (you can wait for 20 ms if
you want, it doesn't matter as the PHY hasn't been started yet) I guess
we can move it and avoid a few loops when polling for the status.

[ The next batch of clean ups also increases that silly 10 us polling
period. ]

> > Either way, separate change.
> >   
> >>>> I think we can either drop this delay completely, or move it before
> >>>> read_poll_timeout().
> >>>
> >>> It definitely shouldn't be used for any new platforms, but I opted for
> >>> the conservative route of keeping it in case some of the older platforms
> >>> actually do need it.
> >>>
> >>> My bet is that this is all copy-paste cruft that could be removed, but
> >>> I'd rather do that as a separate follow-on change. Perhaps after testing
> >>> some more SoC after removing the delay.
> >>>
> >>> SC8280XP certainly doesn't need it.
> >>
> >> I think in our case this delay just falls into status polling. We'd
> >> probably need it, if we'd add the noretain handling.
> > 
> > I'm not sure I understand what you're referring to here ("noretain
> > handling")?
> 
>  From what I see in the downstream (4.19 at hand), the sequence is the 
> following:
> 
> program_phy_config() // including SW_RESET & START_CTRL
> 
> delay
> 
> for pipe clocks:
> clk_set_flags(info->hdl, CLKFLAG_NORETAIN_MEM)
> clk_set_flags(info->hdl, CLKFLAG_NORETAIN_PERIPH)

Heh. Crazy vendor-kernel magic.

> set clock rates, prepare & enable pipe clocks
> 
> wmb()
> 
> poll for the PHY STATUS

But 5.4 has something similar:

	program + start
	delay
	enable pipe clock
	poll for status

Johan
