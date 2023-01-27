Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C4AD67F04D
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Jan 2023 22:19:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230039AbjA0VTO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Jan 2023 16:19:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229832AbjA0VTM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jan 2023 16:19:12 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3638A40BEF;
        Fri, 27 Jan 2023 13:19:10 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B37A161D9D;
        Fri, 27 Jan 2023 21:19:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 137A7C433D2;
        Fri, 27 Jan 2023 21:19:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1674854349;
        bh=BoEWb+D0FLWYI3MwK+cVB2EfOXPGnBl2AFeClrE2Bek=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=SSC1VGO9lRHmWDRAD471nojO2NdRI3w/3kmzdKZkqjeB8p+ifE2oVyzmSvbp0lLRG
         0n1GmDvFfYBRgLBHs3KjJnouqPmG0MENUAaG+L0m6RpirFmN08txo7qKQ/HK6of2Au
         cj2VUxhrH+6VrVV1qXmyNA7U92zjIgmeJcdQtQ2e3Q5HOlFsywNboP6LHoI0jb+eXw
         tFiMwcHOzrfADxg9r2XTdOVXPWquxYwQh2k73yGymuNB/ISgG8jMER3G19cWE1A0kD
         G+1ccuF0Rz6RDdFZ4IbPMVS+V7vLBVzGxKsfufq+T/HrnTKYBSElPhS/kvxMup+i6b
         j7CibLx1h3t9g==
Message-ID: <0c35c8b6de2b3049e4162012082d08f2.sboyd@kernel.org>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <Y9P4h5H78ZkgTpIY@linaro.org>
References: <20230112135224.3837820-1-quic_bjorande@quicinc.com> <40b90d7309246484afa09b2d2b2e23e7.sboyd@kernel.org> <20230112215038.7rl6fzbprj7xsny4@builder.lan> <Y9P4h5H78ZkgTpIY@linaro.org>
Subject: Re: [PATCH] clk: qcom: gdsc: Disable HW control until supported
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <quic_bjorande@quicinc.com>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Taniya Das <quic_tdas@quicinc.com>,
        Rajendra Nayak <quic_rjendra@quicinc.com>,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>
To:     Abel Vesa <abel.vesa@linaro.org>,
        Bjorn Andersson <andersson@kernel.org>
Date:   Fri, 27 Jan 2023 13:19:06 -0800
User-Agent: alot/0.10
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Abel Vesa (2023-01-27 08:15:03)
> On 23-01-12 15:50:38, Bjorn Andersson wrote:
> > On Thu, Jan 12, 2023 at 11:10:40AM -0800, Stephen Boyd wrote:
> > > Quoting Bjorn Andersson (2023-01-12 05:52:24)
> > > > Software normally uses the SW_COLLAPSE bit to collapse a GDSC, but =
in
> > > > some scenarios it's beneficial to let the hardware perform this wit=
hout
> > > > software intervention.
> > > >=20
> > > > This is done by configuring the GDSC in "hardware control" state, in
> > > > which case the SW_COLLAPSE bit is ignored and some hardware signal =
is
> > > > relies upon instead.
> > > >=20
> > > > The GDSCs are modelled as power-domains in Linux and as such it's
> > > > reasonable to assume that the device drivers intend for the hardware
> > > > block to be accessible when their power domain is active.
> > > >=20
> > > > But in the current implementation, any GDSC that is marked to suppo=
rt
> > > > hardware control, gets hardware control unconditionally while the
> > > > client driver requests it to be active. It's therefor conceivable t=
hat
> > > > the hardware collapses a GDSC while Linux is accessing resources
> > > > depending on it.
> > >=20
> > > Why would software want the GDSC to be enabled and accessing resources
> > > while the hardware signals that it isn't required?
> >=20
> > Wouldn't you want a logical OR between these two? As currently written,
> > no attention is given to the software's need for keeping the GDSC
> > active.
>=20
> Looking at this more closely, it is weird nobody complained about GDSC
> consumers collapsing out of the blue yet.

Probably the hardware requests the gdsc to be enabled by default and
only drops the request when it knows it is idle and not doing anything?
I'm imagining an open drain sort of signal where the hardware pulls the
line when it wants to power down and then lets go when it wants to
operate normally.

>=20
> >=20
> > > It sounds like hardware control isn't complete?
> > >=20
> >=20
> > Correct, we're lacking the means for a client driver to affect the
> > hardware vs software control.
> >=20
> > > >=20
> > > > There are ongoing discussions about how to properly expose this con=
trol
> > >=20
> > > Any link? When we implemented hardware clk gating years ago the design
> > > was to have software override hardware control when the clk was enabl=
ed
> > > in software and let the hardware control go into effect when the clk =
was
> > > disabled in software.
>=20
> Discussion is off list for now.

=F0=9F=98=8E

>=20
> >=20
> > That sounds very reasonable, but it is not what's implemented in this
> > file.
> >=20
> > In gdsc_enable() we disable SW_COLLAPSE and then immediately give the
> > control to the hardware, and in gdsc_disable() we disable hardware
> > control and then set SW_COLLAPSE.
> >=20
> > So effectively the GDSC state is either off when Linux says so, or in
> > hardware control.
> >=20
>=20
> The discussed solution is the have a generic genpd API that is
> specifically for marking a PD in HW-controlled mode, while keeping other
> resources enabled from the consumer driver.

Alright.

>=20
> > > Hopefully with power domains this could be
> > > implemented in a better way by connecting hardware mode to some
> > > performance state so that enabling the power domain goes to software
> > > mode and then transitioning to a performance state switches to hardwa=
re
> > > control mode.
> > >=20
> >=20
> > Right, this would allow the software to keep the GDSC on, give the
> > control to the hardware or collapse it.
> >=20
> > The question is how the "some performance state" should be implemented.
> >=20
> > > > to the client drivers, but until conclusion in that discussion is
> > > > reached, the safer option would be to keep the GDSC in software con=
trol
> > > > mode.
> > > >=20
> > > > Signed-off-by: Bjorn Andersson <quic_bjorande@quicinc.com>
> > > > ---
> > > >  drivers/clk/qcom/gdsc.c | 48 ++++++-------------------------------=
----
> > > >  1 file changed, 7 insertions(+), 41 deletions(-)
> > > >=20
> > > > diff --git a/drivers/clk/qcom/gdsc.c b/drivers/clk/qcom/gdsc.c
> > > > index 9e4d6ce891aa..6d3b36a52a48 100644
> > > > --- a/drivers/clk/qcom/gdsc.c
> > > > +++ b/drivers/clk/qcom/gdsc.c
> > > > @@ -439,6 +398,13 @@ static int gdsc_init(struct gdsc *sc)
> > > >                 on =3D true;
> > > >         }
> > > > =20
> > > > +       /* Disable HW trigger mode until propertly supported */
> > > > +       if (sc->flags & HW_CTRL) {
> > > > +               ret =3D gdsc_hwctrl(sc, false);
> > > > +               if (ret < 0)
> > > > +                       return ret;
> > > > +       }
> > > > +
> > >=20
> > > Is it a problem for all hardware controlled gdscs? Or just some of th=
em?
> > > Should we backport this to stable kernels?
> >=20
> > Sorry, I probably wasn't clear enough. There is no observed problem,
> > this simply knocks out the hardware control mode.
> >=20
> > The reason for sending this ahead of a design conclusion is that the
> > current behavior doesn't make sense to me (Linux says "enable!" and we
> > just ignore that) and consider how the "some performance state" would
> > relate to this, I don't see that it will be an amendment to the current
> > flow.
>=20
> I agree. The fact that this did not create any issues yet doesn't mean
> we should stick with the current implementation. In fact, disabling
> HW-control altogether (for now) is more reasonable.

Any change needs testing. For all I know, this breaks drivers or
firmware that are expecting power control to be hardware based (e.g.
maybe video firmware is polling the gdsc to make sure it turns off). Or
it causes a large power regression in the active use case because now
the gdsc is on far more often. Has any of this sort of testing been
done? Changing things because they don't make sense is not a great
argument.

>=20
> >=20
> > > I seem to recall that hardware mode was required for some drivers like
> > > camera and video?
> >=20
> > Given that the current implementation only adhere to the hardware signal
> > in-between gdsc_enable() and gdsc_disable(), the drivers for these
> > blocks must have been written such that the software-state covers the
> > needs of the hardware.
> >=20
> > As mentioned above, the opposite is however not clear. The GDSC might be
> > collapsed at any time, even if Linux thinks it has the GDSC
> > non-collapsed. I not clear to me why the current logic hasn't caused
> > strange issues for us over the years...

Ok, but it hasn't caused us any issues so far. For all I know this patch
will cause problems. I don't see the harm in waiting for the final
solution to appear at a later time.

> >=20
> > > Are they going to keep working if we simply knock out the hardware
> > > control mode here?
> >=20
> > If anything, we might keep the light on longer than today by missing
> > opportunities where the hardware control currently collapses the GDSC
> > behind Linux's back - and we haven't noticed.
> >=20

Yep!
