Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B63CB6FF676
	for <lists+linux-kernel@lfdr.de>; Thu, 11 May 2023 17:50:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238196AbjEKPua (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 May 2023 11:50:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238516AbjEKPuI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 May 2023 11:50:08 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8EBD31BF7;
        Thu, 11 May 2023 08:49:56 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 240FA64F2B;
        Thu, 11 May 2023 15:49:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 389D8C433EF;
        Thu, 11 May 2023 15:49:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1683820195;
        bh=RzwjDhzV3yJQDSeDJjbJnBZmMPRfwj3OgBfoVE7uCZ8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=CmeVwW1UCj956nS4l+FsyOehTGzvQKTenh+zQTKFD0wnPkSOn/sWszEVoQ8zQzW8l
         zTmFUxreErTlpUOrJ0TrXrwFBLx618+rg+iC32Jp19R11GR8VJL82VPDw8zjVDMYTI
         CofwSQYq2OJwazwdqGwdE4IKCiGOe3uJY3yWowDmSD5L8myiVHp56t+lGNPslsgRaa
         N+ugMdrakI5tfPFzJFxfaX6FDfRzoeQueUQFHk3/g2qGI9C2sXXaC99/np8MA2kkVQ
         lrOiqTv50JAIrU79R7KV1S1pQh9sHB7VK4/Ee8MHlu0p85VCn+gsAeqkYH/28PfXqI
         u7CkQ8CFsn6Dw==
Date:   Thu, 11 May 2023 08:53:31 -0700
From:   Bjorn Andersson <andersson@kernel.org>
To:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc:     Kuogee Hsieh <quic_khsieh@quicinc.com>,
        dri-devel@lists.freedesktop.org, robdclark@gmail.com,
        sean@poorly.run, swboyd@chromium.org, dianders@chromium.org,
        vkoul@kernel.org, daniel@ffwll.ch, airlied@gmail.com,
        agross@kernel.org, quic_abhinavk@quicinc.com,
        quic_jesszhan@quicinc.com, quic_sbillaka@quicinc.com,
        marijn.suijten@somainline.org, freedreno@lists.freedesktop.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 1/2] drm/msm/dp: enable HDP plugin/unplugged
 interrupts to hpd_enable/disable
Message-ID: <20230511155331.2jmfe7xcs5tihdgb@ripper>
References: <1683750665-8764-1-git-send-email-quic_khsieh@quicinc.com>
 <1683750665-8764-2-git-send-email-quic_khsieh@quicinc.com>
 <CAA8EJprtQF0x_LCOTrt5bvRnJ+xRz6QxLF6QAP-4Pff6V5TJ2g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAA8EJprtQF0x_LCOTrt5bvRnJ+xRz6QxLF6QAP-4Pff6V5TJ2g@mail.gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 11, 2023 at 07:24:46AM +0300, Dmitry Baryshkov wrote:
> On Wed, 10 May 2023 at 23:31, Kuogee Hsieh <quic_khsieh@quicinc.com> wrote:
> >
> > The internal_hpd flag was introduced to handle external DP HPD derived from GPIO
> > pinmuxed into DP controller. HPD plug/unplug interrupts cannot be enabled until
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
> 
> Thanks for debugging this!
> 
> However after looking at the driver I think there is more than this.
> 
> We have several other places gated on internal_hpd flag, where we do
> not have a strict ordering of events.
> I see that dp_hpd_plug_handle() and dp_hpd_unplug_handle() also toggle
> DP_DP_IRQ_HPD_INT_MASK and DP_DP_HPD_REPLUG_INT_MASK depending on
> internal_hpd. Can we toggle all 4 interrupts from the
> hpd_enable/hpd_disable functions? If we can do it, then I think we can
> drop the internal_hpd flag completely.
> 

Yes, that's what I believe the DRM framework intend us to do.

The problem, and reason why I didn't do tat in my series, was that in
order to update the INT_MASKs you need to clock the IP-block and that's
done elsewhere.

So, for the internal_hpd case, it seems appropriate to pm_runtime_get()
in hpd_enable() and unmask the HPD interrupts, and mask the interrupts
and pm_runtime_put() in hpd_disable().


But for edp and external HPD-signal we also need to make sure power is
on while something is connected...

> I went on and checked other places where it is used:
> - dp_hpd_unplug_handle(), guarding DP_DP_HPD_PLUG_INT_MASK toggling. I
> think we can drop these two calls completely. The function is under
> the event_mutex protection, so other events can not interfere.
> - dp_bridge_hpd_notify(). What is the point of this check? If some
> other party informs us of the HPD event, we'd better handle it instead
> of dropping it. Correct?  In other words, I'd prefer seeing the
> hpd_event_thread removal. Instead of that I think that on
> HPD/plug/unplug/etc. IRQ the driver should call into the drm stack,
> then the hpd_notify call should process those events.
> 

I agree, that seems to be what's expected of us from the DRM framework.

Regards,
Bjorn

> 
> > ---
> >  drivers/gpu/drm/msm/dp/dp_display.c | 27 ++++++++++++++-------------
> >  1 file changed, 14 insertions(+), 13 deletions(-)
> >
> > diff --git a/drivers/gpu/drm/msm/dp/dp_display.c b/drivers/gpu/drm/msm/dp/dp_display.c
> > index 3e13acdf..71aa944 100644
> > --- a/drivers/gpu/drm/msm/dp/dp_display.c
> > +++ b/drivers/gpu/drm/msm/dp/dp_display.c
> > @@ -1088,13 +1088,6 @@ static void dp_display_config_hpd(struct dp_display_private *dp)
> >         dp_display_host_init(dp);
> >         dp_catalog_ctrl_hpd_config(dp->catalog);
> >
> > -       /* Enable plug and unplug interrupts only if requested */
> > -       if (dp->dp_display.internal_hpd)
> > -               dp_catalog_hpd_config_intr(dp->catalog,
> > -                               DP_DP_HPD_PLUG_INT_MASK |
> > -                               DP_DP_HPD_UNPLUG_INT_MASK,
> > -                               true);
> > -
> >         /* Enable interrupt first time
> >          * we are leaving dp clocks on during disconnect
> >          * and never disable interrupt
> > @@ -1396,12 +1389,6 @@ static int dp_pm_resume(struct device *dev)
> >
> >         dp_catalog_ctrl_hpd_config(dp->catalog);
> >
> > -       if (dp->dp_display.internal_hpd)
> > -               dp_catalog_hpd_config_intr(dp->catalog,
> > -                               DP_DP_HPD_PLUG_INT_MASK |
> > -                               DP_DP_HPD_UNPLUG_INT_MASK,
> > -                               true);
> > -
> >         if (dp_catalog_link_is_connected(dp->catalog)) {
> >                 /*
> >                  * set sink to normal operation mode -- D0
> > @@ -1801,15 +1788,29 @@ void dp_bridge_hpd_enable(struct drm_bridge *bridge)
> >  {
> >         struct msm_dp_bridge *dp_bridge = to_dp_bridge(bridge);
> >         struct msm_dp *dp_display = dp_bridge->dp_display;
> > +       struct dp_display_private *dp;
> > +
> > +       dp = container_of(dp_display, struct dp_display_private, dp_display);
> >
> >         dp_display->internal_hpd = true;
> > +       dp_catalog_hpd_config_intr(dp->catalog,
> > +                               DP_DP_HPD_PLUG_INT_MASK |
> > +                               DP_DP_HPD_UNPLUG_INT_MASK,
> > +                               true);
> >  }
> >
> >  void dp_bridge_hpd_disable(struct drm_bridge *bridge)
> >  {
> >         struct msm_dp_bridge *dp_bridge = to_dp_bridge(bridge);
> >         struct msm_dp *dp_display = dp_bridge->dp_display;
> > +       struct dp_display_private *dp;
> > +
> > +       dp = container_of(dp_display, struct dp_display_private, dp_display);
> >
> > +       dp_catalog_hpd_config_intr(dp->catalog,
> > +                               DP_DP_HPD_PLUG_INT_MASK |
> > +                               DP_DP_HPD_UNPLUG_INT_MASK,
> > +                               false);
> >         dp_display->internal_hpd = false;
> >  }
> 
> --
> With best wishes
> Dmitry
