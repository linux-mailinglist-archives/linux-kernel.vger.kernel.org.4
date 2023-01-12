Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B6B44668648
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Jan 2023 23:01:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232919AbjALWBm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Jan 2023 17:01:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232172AbjALWAx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jan 2023 17:00:53 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2AFCF1036;
        Thu, 12 Jan 2023 13:50:50 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B75E06219A;
        Thu, 12 Jan 2023 21:50:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4D45DC433D2;
        Thu, 12 Jan 2023 21:50:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1673560241;
        bh=z1MVMcH0nUjiEFIsfjTFo2Vx+dvmKdXcPvV0HKaKxAE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=OiutwahifQL/899zlEGanAIEpICX83Nbr6CVNdhFwHgvP2t5Ph6DPrx/slQnUXEnN
         7BKqOVlUPWraGw13BUSPlxlFTmKAlEd050kJ2/vvRJNuxZ2iiLwB8sHWrVBMK04A3w
         wQLGEL0JaSEU+fV+vaYE05Kvexz/TCXW2lQZ4Q4ADbgontV28eTOLgkvGQmQQld+Fh
         Lg2pOyJKsyOM9Mr3YDc3MynUE7uFJIUB6/9r7Yxs3lQH1bKea+a94mAwAsWP8tHqzw
         6nCUWXkx/w0p754W76FM0bKzRdqoDUb+NGMY4sYNf1VRzAYuEteO7MkAt83PyqPj/8
         azqqN/STjsBXA==
Date:   Thu, 12 Jan 2023 15:50:38 -0600
From:   Bjorn Andersson <andersson@kernel.org>
To:     Stephen Boyd <sboyd@kernel.org>
Cc:     Abel Vesa <abel.vesa@linaro.org>, Andy Gross <agross@kernel.org>,
        Bjorn Andersson <quic_bjorande@quicinc.com>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Taniya Das <quic_tdas@quicinc.com>,
        Rajendra Nayak <quic_rjendra@quicinc.com>,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH] clk: qcom: gdsc: Disable HW control until supported
Message-ID: <20230112215038.7rl6fzbprj7xsny4@builder.lan>
References: <20230112135224.3837820-1-quic_bjorande@quicinc.com>
 <40b90d7309246484afa09b2d2b2e23e7.sboyd@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <40b90d7309246484afa09b2d2b2e23e7.sboyd@kernel.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 12, 2023 at 11:10:40AM -0800, Stephen Boyd wrote:
> Quoting Bjorn Andersson (2023-01-12 05:52:24)
> > Software normally uses the SW_COLLAPSE bit to collapse a GDSC, but in
> > some scenarios it's beneficial to let the hardware perform this without
> > software intervention.
> > 
> > This is done by configuring the GDSC in "hardware control" state, in
> > which case the SW_COLLAPSE bit is ignored and some hardware signal is
> > relies upon instead.
> > 
> > The GDSCs are modelled as power-domains in Linux and as such it's
> > reasonable to assume that the device drivers intend for the hardware
> > block to be accessible when their power domain is active.
> > 
> > But in the current implementation, any GDSC that is marked to support
> > hardware control, gets hardware control unconditionally while the
> > client driver requests it to be active. It's therefor conceivable that
> > the hardware collapses a GDSC while Linux is accessing resources
> > depending on it.
> 
> Why would software want the GDSC to be enabled and accessing resources
> while the hardware signals that it isn't required?

Wouldn't you want a logical OR between these two? As currently written,
no attention is given to the software's need for keeping the GDSC
active.

> It sounds like hardware control isn't complete?
> 

Correct, we're lacking the means for a client driver to affect the
hardware vs software control.

> > 
> > There are ongoing discussions about how to properly expose this control
> 
> Any link? When we implemented hardware clk gating years ago the design
> was to have software override hardware control when the clk was enabled
> in software and let the hardware control go into effect when the clk was
> disabled in software.

That sounds very reasonable, but it is not what's implemented in this
file.

In gdsc_enable() we disable SW_COLLAPSE and then immediately give the
control to the hardware, and in gdsc_disable() we disable hardware
control and then set SW_COLLAPSE.

So effectively the GDSC state is either off when Linux says so, or in
hardware control.

> Hopefully with power domains this could be
> implemented in a better way by connecting hardware mode to some
> performance state so that enabling the power domain goes to software
> mode and then transitioning to a performance state switches to hardware
> control mode.
> 

Right, this would allow the software to keep the GDSC on, give the
control to the hardware or collapse it.

The question is how the "some performance state" should be implemented.

> > to the client drivers, but until conclusion in that discussion is
> > reached, the safer option would be to keep the GDSC in software control
> > mode.
> > 
> > Signed-off-by: Bjorn Andersson <quic_bjorande@quicinc.com>
> > ---
> >  drivers/clk/qcom/gdsc.c | 48 ++++++-----------------------------------
> >  1 file changed, 7 insertions(+), 41 deletions(-)
> > 
> > diff --git a/drivers/clk/qcom/gdsc.c b/drivers/clk/qcom/gdsc.c
> > index 9e4d6ce891aa..6d3b36a52a48 100644
> > --- a/drivers/clk/qcom/gdsc.c
> > +++ b/drivers/clk/qcom/gdsc.c
> > @@ -439,6 +398,13 @@ static int gdsc_init(struct gdsc *sc)
> >                 on = true;
> >         }
> >  
> > +       /* Disable HW trigger mode until propertly supported */
> > +       if (sc->flags & HW_CTRL) {
> > +               ret = gdsc_hwctrl(sc, false);
> > +               if (ret < 0)
> > +                       return ret;
> > +       }
> > +
> 
> Is it a problem for all hardware controlled gdscs? Or just some of them?
> Should we backport this to stable kernels?

Sorry, I probably wasn't clear enough. There is no observed problem,
this simply knocks out the hardware control mode.

The reason for sending this ahead of a design conclusion is that the
current behavior doesn't make sense to me (Linux says "enable!" and we
just ignore that) and consider how the "some performance state" would
relate to this, I don't see that it will be an amendment to the current
flow.

> I seem to recall that hardware mode was required for some drivers like
> camera and video?

Given that the current implementation only adhere to the hardware signal
in-between gdsc_enable() and gdsc_disable(), the drivers for these
blocks must have been written such that the software-state covers the
needs of the hardware.

As mentioned above, the opposite is however not clear. The GDSC might be
collapsed at any time, even if Linux thinks it has the GDSC
non-collapsed. I not clear to me why the current logic hasn't caused
strange issues for us over the years...

> Are they going to keep working if we simply knock out the hardware
> control mode here?

If anything, we might keep the light on longer than today by missing
opportunities where the hardware control currently collapses the GDSC
behind Linux's back - and we haven't noticed.

Regards,
Bjorn
