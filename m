Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E6886FF5F2
	for <lists+linux-kernel@lfdr.de>; Thu, 11 May 2023 17:28:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238712AbjEKP2S (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 May 2023 11:28:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232006AbjEKP2Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 May 2023 11:28:16 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 075F2DC;
        Thu, 11 May 2023 08:28:15 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 90F2864EF0;
        Thu, 11 May 2023 15:28:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C1A82C433EF;
        Thu, 11 May 2023 15:28:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1683818894;
        bh=bfzVkgchG3ADANDZ9tx7JhDsCOgB/EmrIyZFm4dmlJ8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=irNHUONwsI6CQtLpREtNLSyQ69irtMLtOthyrhALcmJVzvlWu74WO7y6iT8Nax/vt
         m/iT8bDf3ZfD1xzf+rwP+OXozll17Fvrxibk+XTJn6T7HLWHH76z5Y4TkaelGbJMuW
         4+dnu5w24X1HzFUX2jK/gIugQjwlfptG2xKFcSp6nhyYc2PTZ0V/om9HKqTuNYpEMl
         86/4HEiMLy7t3hrv8soCMojL2eBIeljcfbJ1p7JrUlAHlBUWTbQQVq9S6yEz2CNL5f
         GxF9oCtHdW27I2K3Ogs9Y1NlRuZx68aVMET5/xK9FJ/oNSiPDa6RtizaVoi/Bkc102
         KYnZPAr/nPsFg==
Date:   Thu, 11 May 2023 08:31:50 -0700
From:   Bjorn Andersson <andersson@kernel.org>
To:     Stephen Boyd <swboyd@chromium.org>
Cc:     Kuogee Hsieh <quic_khsieh@quicinc.com>, agross@kernel.org,
        airlied@gmail.com, daniel@ffwll.ch, dianders@chromium.org,
        dmitry.baryshkov@linaro.org, dri-devel@lists.freedesktop.org,
        robdclark@gmail.com, sean@poorly.run, vkoul@kernel.org,
        quic_abhinavk@quicinc.com, quic_jesszhan@quicinc.com,
        quic_sbillaka@quicinc.com, marijn.suijten@somainline.org,
        freedreno@lists.freedesktop.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 1/2] drm/msm/dp: enable HDP plugin/unplugged
 interrupts to hpd_enable/disable
Message-ID: <20230511153150.qn3psei655ixprtx@ripper>
References: <1683750665-8764-1-git-send-email-quic_khsieh@quicinc.com>
 <1683750665-8764-2-git-send-email-quic_khsieh@quicinc.com>
 <CAE-0n53ywhgFhJXA9krBo-Ds6ezM0K8n6w0xnVZj+sTJ4qt9cA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAE-0n53ywhgFhJXA9krBo-Ds6ezM0K8n6w0xnVZj+sTJ4qt9cA@mail.gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 10, 2023 at 04:55:04PM -0700, Stephen Boyd wrote:
> Quoting Kuogee Hsieh (2023-05-10 13:31:04)
> > The internal_hpd flag was introduced to handle external DP HPD derived from GPIO
> > pinmuxed into DP controller.
> 
> Was it? It looks more like it was done to differentiate between eDP and
> DP, because internal_hpd is set only if DRM_BRIDGE_OP_HPD is set on the
> bridge and we only set the bridge op if the connector type is DP. The
> assumption looks like if you have DP connector_type, you have the gpio
> pinmuxed for "dp_hot" mode, which isn't exactly true. We don't treat
> that gpio as an irq either, because it isn't. Instead the gpio is muxed
> to the mdss inside the SoC and then that generates an mdss interrupt
> that's combined with non-HPD things like "video ready".
> 

The purpose of "internal_hpd" is to indicate track if the internal
HPD-logic should be used or not.

> If that all follows, then I don't quite understand why we're setting
> internal_hpd to false at all at runtime. It should be set to true at
> some point, but ideally that point is during probe.
> 

The DRM framework will invoke hpd_enable on the bridge furthest out that
has OP_HPD. So in the case of HPD signal being pinmuxed into the
HPD-logic, dp_bridge_hpd_enable() will be invoked.

I therefor think the appropriate thing to do is to move the enablement
of the internal HPD-logic to dp_bridge_hpd_enable(), further more I
think the correct thing to do would be to tie the power state of the DP
block to this (and to when the external hpd_notify events signals that
there's something attached).

> > HPD plug/unplug interrupts cannot be enabled until
> > internal_hpd flag is set to true.
> > At both bootup and resume time, the DP driver will enable external DP
> > plugin interrupts and handle plugin interrupt accordingly. Unfortunately
> > dp_bridge_hpd_enable() bridge ops function was called to set internal_hpd
> > flag to true later than where DP driver expected during bootup time.
> >
> > This causes external DP plugin event to not get detected and display stays blank.
> > Move enabling HDP plugin/unplugged interrupts to dp_bridge_hpd_enable()/disable() to
> > set internal_hpd to true along with enabling HPD plugin/unplugged interrupts
> > simultaneously to avoid timing issue during bootup and resume.
> >
> > Fixes: cd198caddea7 ("drm/msm/dp: Rely on hpd_enable/disable callbacks")
> > Signed-off-by: Kuogee Hsieh <quic_khsieh@quicinc.com>
> > ---
> >  drivers/gpu/drm/msm/dp/dp_display.c | 27 ++++++++++++++-------------
> >  1 file changed, 14 insertions(+), 13 deletions(-)
> >
> > diff --git a/drivers/gpu/drm/msm/dp/dp_display.c b/drivers/gpu/drm/msm/dp/dp_display.c
> > index 3e13acdf..71aa944 100644
> > --- a/drivers/gpu/drm/msm/dp/dp_display.c
> > +++ b/drivers/gpu/drm/msm/dp/dp_display.c
> > @@ -1801,15 +1788,29 @@ void dp_bridge_hpd_enable(struct drm_bridge *bridge)
> >  {
> >         struct msm_dp_bridge *dp_bridge = to_dp_bridge(bridge);
> >         struct msm_dp *dp_display = dp_bridge->dp_display;
> > +       struct dp_display_private *dp;
> > +
> > +       dp = container_of(dp_display, struct dp_display_private, dp_display);
> >
> >         dp_display->internal_hpd = true;
> 
> Can we set internal_hpd to true during probe when we see that the hpd
> pinmux exists? Or do any of these bits toggle in the irq status register
> when the gpio isn't muxed to "dp_hot" or the controller is for eDP and
> it doesn't have any gpio connection internally? I'm wondering if we can
> get by with simply enabling the "dp_hot" pin interrupts
> (plug/unplug/replug/irq_hpd) unconditionally and not worrying about them
> if eDP is there (because the pin doesn't exist inside the SoC), or if DP
> HPD is being signalled out of band through type-c framework.

It seems logical to me that the panel driver should handle HPD signaling
(or signal it always-asserted), in which case it also seems reasonable
that hpd_enable() would not be invoked... I didn't go far enough into
that rabbit hole though, but I think it would allow us to drop the
is_edp flag (which isn't at all a property of the controller, but of
what you have connected).

I don't think we should peak into the pinmux settings to determine if
the internal HPD logic should be enabled or not, when the DRM framework
already has this callback to tell us "hey, you're the one doing HPD
detection!".


And as mentioned above, the continuation of this is to tie the power
state to hpd_enable/hpd_disable/hpd_notify and thereby allow the DP
block (and MMCX) to be powered down when nothing is connected (and we
don't need to drive the HPD logic).

Regards,
Bjorn
