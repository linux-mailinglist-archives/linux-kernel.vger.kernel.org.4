Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 19D7A6FF62D
	for <lists+linux-kernel@lfdr.de>; Thu, 11 May 2023 17:40:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238769AbjEKPkq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 May 2023 11:40:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238768AbjEKPkn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 May 2023 11:40:43 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F09E5BA5;
        Thu, 11 May 2023 08:40:41 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 04D8164F18;
        Thu, 11 May 2023 15:40:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2C80EC433EF;
        Thu, 11 May 2023 15:40:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1683819640;
        bh=//YCHN0izg/VsWfOmB6peEqK02YPQEdFXzbMANOXruY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=CzBfZu5f6wQiV92wXoVyExa/7BfTK/ZgvqHLo3t53uI5HtgRqEBSX5XLpZr5raHAy
         tX9SISUN0TGWnt+aKhh9VVytV6pl6a6QsGlxOqJJZny/wfrMnE7sq55w0CDHMs388+
         oD90KzFckhB52iXunQOP1SxmtMuuOHb79gkmJVuI2W8/2OPlnysjcJY5I1iwh0sfSH
         rjtOX/llHkK2sKIEYn4jFqJI5EFU/Y7BixHALg51mYaFTqZm8Tkyw+O4agw7mRT/f8
         mtqAkHfyILHQHCHQMIH4wGxBEFDVfWo+wSvXE+YjXAoF8wHX8+mq8AmYlsFxWWMpKe
         ep2fy9yQ9T1NA==
Date:   Thu, 11 May 2023 08:44:16 -0700
From:   Bjorn Andersson <andersson@kernel.org>
To:     Abhinav Kumar <quic_abhinavk@quicinc.com>
Cc:     Stephen Boyd <swboyd@chromium.org>,
        Kuogee Hsieh <quic_khsieh@quicinc.com>, agross@kernel.org,
        airlied@gmail.com, daniel@ffwll.ch, dianders@chromium.org,
        dmitry.baryshkov@linaro.org, dri-devel@lists.freedesktop.org,
        robdclark@gmail.com, sean@poorly.run, vkoul@kernel.org,
        quic_jesszhan@quicinc.com, quic_sbillaka@quicinc.com,
        marijn.suijten@somainline.org, freedreno@lists.freedesktop.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 1/2] drm/msm/dp: enable HDP plugin/unplugged
 interrupts to hpd_enable/disable
Message-ID: <20230511154416.67habdpdasy2szvs@ripper>
References: <1683750665-8764-1-git-send-email-quic_khsieh@quicinc.com>
 <1683750665-8764-2-git-send-email-quic_khsieh@quicinc.com>
 <CAE-0n53ywhgFhJXA9krBo-Ds6ezM0K8n6w0xnVZj+sTJ4qt9cA@mail.gmail.com>
 <6830a829-5b8a-a05a-da6a-5aaaeef23e57@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6830a829-5b8a-a05a-da6a-5aaaeef23e57@quicinc.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 10, 2023 at 05:39:07PM -0700, Abhinav Kumar wrote:
> 
> 
> On 5/10/2023 4:55 PM, Stephen Boyd wrote:
> > Quoting Kuogee Hsieh (2023-05-10 13:31:04)
> > > The internal_hpd flag was introduced to handle external DP HPD derived from GPIO
> > > pinmuxed into DP controller.
> > 
> > Was it? It looks more like it was done to differentiate between eDP and
> > DP, because internal_hpd is set only if DRM_BRIDGE_OP_HPD is set on the
> > bridge and we only set the bridge op if the connector type is DP. The
> > assumption looks like if you have DP connector_type, you have the gpio
> > pinmuxed for "dp_hot" mode, which isn't exactly true. We don't treat
> > that gpio as an irq either, because it isn't. Instead the gpio is muxed
> > to the mdss inside the SoC and then that generates an mdss interrupt
> > that's combined with non-HPD things like "video ready".
> > 
> > If that all follows, then I don't quite understand why we're setting
> > internal_hpd to false at all at runtime. It should be set to true at
> > some point, but ideally that point is during probe.
> > 
> 
> Kuogee had the same thought originally but were not entirely sure of this
> part of the commit message in Bjorn's original commit which introduced these
> changes.
> 
> "This difference is not appropriately represented by the "is_edp"
> boolean, but is properly represented by the frameworks invocation of the
> hpd_enable() and hpd_disable() callbacks. Switch the current condition
> to rely on these callbacks instead"
> 
> Does this along with below documentation mean we should generate the hpd
> interrupts only after hpd_enable callback happens?
> 
> " * Call &drm_bridge_funcs.hpd_enable if implemented and register the given
> @cb
>  * and @data as hot plug notification callback. From now on the @cb will be
>  * called with @data when an output status change is detected by the bridge,
>  * until hot plug notification gets disabled with drm_bridge_hpd_disable().
> "
> 
> Bjorn, can you please clarify this?
> 

We currently have 3 cases:

1) DP with GPIO: No downstream drm_bridge are connected, is_edp = false
and internal HPD-logic is in used (internal_hpd = true). Power needs to
be on at all times etc.

2) DP without GPIO: Downstream drm_bridge connected, is_edp = false and
internal HPD-logic should not be used/enabled (internal_hpd = false).
Power doesn't need to be on unless hpd_notify is invoked to tell us that
there's something connected...

3) eDP with or without HPD signal and/or HPD gpio. Downstream
drm_bridge/panel is connected, is_edp = true and internal HPD logic is
short-circuited regardless of the panel providing HPD signal or not.


In #1 dp_bridge_hpd_enable() will be invoked to indicate that the DP
controller is expected to perform HPD handling. In #2
dp_bridge_hpd_enable() will _not_ be invoked, instead some downstream
drm_bridge/panel will get the hpd_enable() callback and will be
responsible to updating the HPD state of the chain, which will cause
hpd_notify to be invoked.


Note that #3 is based entirely on the controller, it has currently no
relation to what is attached. It seems reasonable that this is just
another case of #2 (perhaps just always reporting
connector_status_connected?).

Regards,
Bjorn

> > > HPD plug/unplug interrupts cannot be enabled until
> > > internal_hpd flag is set to true.
> > > At both bootup and resume time, the DP driver will enable external DP
> > > plugin interrupts and handle plugin interrupt accordingly. Unfortunately
> > > dp_bridge_hpd_enable() bridge ops function was called to set internal_hpd
> > > flag to true later than where DP driver expected during bootup time.
> > > 
> > > This causes external DP plugin event to not get detected and display stays blank.
> > > Move enabling HDP plugin/unplugged interrupts to dp_bridge_hpd_enable()/disable() to
> > > set internal_hpd to true along with enabling HPD plugin/unplugged interrupts
> > > simultaneously to avoid timing issue during bootup and resume.
> > > 
> > > Fixes: cd198caddea7 ("drm/msm/dp: Rely on hpd_enable/disable callbacks")
> > > Signed-off-by: Kuogee Hsieh <quic_khsieh@quicinc.com>
> > > ---
> > >   drivers/gpu/drm/msm/dp/dp_display.c | 27 ++++++++++++++-------------
> > >   1 file changed, 14 insertions(+), 13 deletions(-)
> > > 
> > > diff --git a/drivers/gpu/drm/msm/dp/dp_display.c b/drivers/gpu/drm/msm/dp/dp_display.c
> > > index 3e13acdf..71aa944 100644
> > > --- a/drivers/gpu/drm/msm/dp/dp_display.c
> > > +++ b/drivers/gpu/drm/msm/dp/dp_display.c
> > > @@ -1801,15 +1788,29 @@ void dp_bridge_hpd_enable(struct drm_bridge *bridge)
> > >   {
> > >          struct msm_dp_bridge *dp_bridge = to_dp_bridge(bridge);
> > >          struct msm_dp *dp_display = dp_bridge->dp_display;
> > > +       struct dp_display_private *dp;
> > > +
> > > +       dp = container_of(dp_display, struct dp_display_private, dp_display);
> > > 
> > >          dp_display->internal_hpd = true;
> > 
> > Can we set internal_hpd to true during probe when we see that the hpd
> > pinmux exists? Or do any of these bits toggle in the irq status register
> > when the gpio isn't muxed to "dp_hot" or the controller is for eDP and
> > it doesn't have any gpio connection internally? I'm wondering if we can
> > get by with simply enabling the "dp_hot" pin interrupts
> > (plug/unplug/replug/irq_hpd) unconditionally and not worrying about them
> > if eDP is there (because the pin doesn't exist inside the SoC), or if DP
> > HPD is being signalled out of band through type-c framework.
