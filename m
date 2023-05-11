Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C75B6FF8F2
	for <lists+linux-kernel@lfdr.de>; Thu, 11 May 2023 19:56:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238617AbjEKRzy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 May 2023 13:55:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239026AbjEKRzw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 May 2023 13:55:52 -0400
Received: from mail-lj1-x229.google.com (mail-lj1-x229.google.com [IPv6:2a00:1450:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 089B19EFF
        for <linux-kernel@vger.kernel.org>; Thu, 11 May 2023 10:55:15 -0700 (PDT)
Received: by mail-lj1-x229.google.com with SMTP id 38308e7fff4ca-2ac8c0fbb16so83207811fa.2
        for <linux-kernel@vger.kernel.org>; Thu, 11 May 2023 10:55:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1683827711; x=1686419711;
        h=cc:to:subject:message-id:date:user-agent:from:references
         :in-reply-to:mime-version:from:to:cc:subject:date:message-id
         :reply-to;
        bh=I268knal+2KeE9++tXp0D/dHgwY+VJy+gOSFMyEBkyg=;
        b=H9AMwmvg3R9PRWCnnM9QU6ng7hJoiAwaLqK8VFv7omaksSkAYIiDWf79Ym35HWYgsO
         fmdFHk0Xgg5XKoVlt0tU0nykMXUsAUhBDThCzr9dHki5XeSsBlPtJpigX0NdUQQxdhVo
         2dfHBCqDQbPf6RufwlAO44kYTK7h8yTFugmYQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683827711; x=1686419711;
        h=cc:to:subject:message-id:date:user-agent:from:references
         :in-reply-to:mime-version:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=I268knal+2KeE9++tXp0D/dHgwY+VJy+gOSFMyEBkyg=;
        b=VdTrJuZJtS2gHuMwiopX3owE/W1czFmHc4n02+y6q07xCHyjUWmFfp3Ny4lTVDsoUr
         GkDqzdk/aI7ie3y6lMyrP63Pfy54T6CkNhPcaWExWjjEI5+Z5ypZyRzRlIDiitgr6s9c
         8T0UbtZgddU7SOT10M9WsiEa/w7Ocn9JvGAk2QYELcoSxiAUOUDiFhgjPdPoJb5KEX1b
         a6KahJ3FLXCC26QxW2qOd6eDH1fsNpPuHj3UdYzf2FqS4FUxFgJt1VIwNOVnbvl+fLik
         oE9VcG25ykbnU4G5iciZ5dL87nXL3yiGmZBNKK4A1rmHokIXuiYZSl228imf68N8BFfv
         6fyw==
X-Gm-Message-State: AC+VfDx4ELvUiky7cU+1ELthr/f1ThNjh0DndJ2GSrxzaFAMHcPxexRV
        Ca94A9pukbJfPhxDzVK5q7DOIGbuqIuEYlYs9prF2w==
X-Google-Smtp-Source: ACHHUZ4h3boit+aKT/Be7LtygqxC+W91LZoG+r5wgMkvlDBMysdL1l3xTVsAf/S8n02qS37aG8H3OMAkJmQTWscQfwA=
X-Received: by 2002:a2e:875a:0:b0:2ad:996f:5d11 with SMTP id
 q26-20020a2e875a000000b002ad996f5d11mr3402693ljj.28.1683827710964; Thu, 11
 May 2023 10:55:10 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 11 May 2023 10:55:10 -0700
MIME-Version: 1.0
In-Reply-To: <20230511154416.67habdpdasy2szvs@ripper>
References: <1683750665-8764-1-git-send-email-quic_khsieh@quicinc.com>
 <1683750665-8764-2-git-send-email-quic_khsieh@quicinc.com>
 <CAE-0n53ywhgFhJXA9krBo-Ds6ezM0K8n6w0xnVZj+sTJ4qt9cA@mail.gmail.com>
 <6830a829-5b8a-a05a-da6a-5aaaeef23e57@quicinc.com> <20230511154416.67habdpdasy2szvs@ripper>
From:   Stephen Boyd <swboyd@chromium.org>
User-Agent: alot/0.10
Date:   Thu, 11 May 2023 10:55:10 -0700
Message-ID: <CAE-0n51Q0crYrELM1GnY5xbBezeOryRa4D5STR7TG_yqz0YOUA@mail.gmail.com>
Subject: Re: [PATCH v1 1/2] drm/msm/dp: enable HDP plugin/unplugged interrupts
 to hpd_enable/disable
To:     Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Bjorn Andersson <andersson@kernel.org>
Cc:     Kuogee Hsieh <quic_khsieh@quicinc.com>, agross@kernel.org,
        airlied@gmail.com, daniel@ffwll.ch, dianders@chromium.org,
        dmitry.baryshkov@linaro.org, dri-devel@lists.freedesktop.org,
        robdclark@gmail.com, sean@poorly.run, vkoul@kernel.org,
        quic_jesszhan@quicinc.com, quic_sbillaka@quicinc.com,
        marijn.suijten@somainline.org, freedreno@lists.freedesktop.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Bjorn Andersson (2023-05-11 08:44:16)
> On Wed, May 10, 2023 at 05:39:07PM -0700, Abhinav Kumar wrote:
> >
> >
> > On 5/10/2023 4:55 PM, Stephen Boyd wrote:
> > > Quoting Kuogee Hsieh (2023-05-10 13:31:04)
> > > > The internal_hpd flag was introduced to handle external DP HPD derived from GPIO
> > > > pinmuxed into DP controller.
> > >
> > > Was it? It looks more like it was done to differentiate between eDP and
> > > DP, because internal_hpd is set only if DRM_BRIDGE_OP_HPD is set on the
> > > bridge and we only set the bridge op if the connector type is DP. The
> > > assumption looks like if you have DP connector_type, you have the gpio
> > > pinmuxed for "dp_hot" mode, which isn't exactly true. We don't treat
> > > that gpio as an irq either, because it isn't. Instead the gpio is muxed
> > > to the mdss inside the SoC and then that generates an mdss interrupt
> > > that's combined with non-HPD things like "video ready".
> > >
> > > If that all follows, then I don't quite understand why we're setting
> > > internal_hpd to false at all at runtime. It should be set to true at
> > > some point, but ideally that point is during probe.
> > >
> >
> > Kuogee had the same thought originally but were not entirely sure of this
> > part of the commit message in Bjorn's original commit which introduced these
> > changes.
> >
> > "This difference is not appropriately represented by the "is_edp"
> > boolean, but is properly represented by the frameworks invocation of the
> > hpd_enable() and hpd_disable() callbacks. Switch the current condition
> > to rely on these callbacks instead"
> >
> > Does this along with below documentation mean we should generate the hpd
> > interrupts only after hpd_enable callback happens?
> >
> > " * Call &drm_bridge_funcs.hpd_enable if implemented and register the given
> > @cb
> >  * and @data as hot plug notification callback. From now on the @cb will be
> >  * called with @data when an output status change is detected by the bridge,
> >  * until hot plug notification gets disabled with drm_bridge_hpd_disable().
> > "
> >
> > Bjorn, can you please clarify this?
> >
>
> We currently have 3 cases:
>
> 1) DP with GPIO: No downstream drm_bridge are connected, is_edp = false
> and internal HPD-logic is in used (internal_hpd = true). Power needs to
> be on at all times etc.
>
> 2) DP without GPIO: Downstream drm_bridge connected, is_edp = false and
> internal HPD-logic should not be used/enabled (internal_hpd = false).
> Power doesn't need to be on unless hpd_notify is invoked to tell us that
> there's something connected...
>
> 3) eDP with or without HPD signal and/or HPD gpio. Downstream
> drm_bridge/panel is connected, is_edp = true and internal HPD logic is
> short-circuited regardless of the panel providing HPD signal or not.

Oh weird. I thought that the "is_edp" controller on sc7280 didn't have
HPD hardware in the PHY (phy@aec2a00), hence all the logic to avoid
using the HPD interrupts and bits there. What is "is_edp" about then?

>
>
> In #1 dp_bridge_hpd_enable() will be invoked to indicate that the DP
> controller is expected to perform HPD handling. In #2
> dp_bridge_hpd_enable() will _not_ be invoked, instead some downstream
> drm_bridge/panel will get the hpd_enable() callback and will be
> responsible to updating the HPD state of the chain, which will cause
> hpd_notify to be invoked.
>
>
> Note that #3 is based entirely on the controller, it has currently no
> relation to what is attached. It seems reasonable that this is just
> another case of #2 (perhaps just always reporting
> connector_status_connected?).
>

Looking at drm_bridge_connector_detect() the default is to consider
DRM_MODE_CONNECTOR_eDP as connector_status_connected. I wonder if
panel_bridge_bridge_funcs can gain a 'detect' function and also set
DRM_BRIDGE_OP_DETECT if the connector_type is DRM_MODE_CONNECTOR_eDP.
