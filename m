Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 289896F67D5
	for <lists+linux-kernel@lfdr.de>; Thu,  4 May 2023 10:55:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230049AbjEDIz3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 May 2023 04:55:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229535AbjEDIzZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 May 2023 04:55:25 -0400
Received: from mail-yw1-x112b.google.com (mail-yw1-x112b.google.com [IPv6:2607:f8b0:4864:20::112b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA7E730ED
        for <linux-kernel@vger.kernel.org>; Thu,  4 May 2023 01:55:23 -0700 (PDT)
Received: by mail-yw1-x112b.google.com with SMTP id 00721157ae682-55aa1da9d4aso2132387b3.2
        for <linux-kernel@vger.kernel.org>; Thu, 04 May 2023 01:55:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1683190523; x=1685782523;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=qh1qSkuyv2vGK4cRlclNgqnUk0gpRzXVLpoZ9by6rLA=;
        b=LutfW/hky6cKmdiUEIPvHTI8rqouC7m+5riODh7gjThHjXccV6Rw1CDXqY/CbeZemw
         R+ZBaOCIKienQBYR97Fjqe4pdcGG/3rZJvxXGDjHVSvNcqJR/nOx5FMwJBd6Nc8gCURR
         o7vFQTvZA0c0qoOTY8kOulU2IOUEaGhvhjAERtmLMI3qqTrn/n/bLB6Xk+EXT9k1X2Au
         BJZj5jhfVDMn5pwqoJ4damHAqG4QW/KnQ4aKYMMIrp9naO5HDdWb4VcxuLw8LZL8ZI1q
         lwIX6VEzU5yR8enTxG+CPogP5EEpDdPTMIES1g0QtEfrbVICD2hkHY6aoInLtSRlxxvd
         TF3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683190523; x=1685782523;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qh1qSkuyv2vGK4cRlclNgqnUk0gpRzXVLpoZ9by6rLA=;
        b=WYgUd6Qa80qOVNSaPg8X0+1HwyGDahDHbSQPzPTLU0Lg23fRlKt5dmjLawr4MlJi8A
         rCXMVESL146HyBPIIGGa3ExOYsZ069Yf60QgUqn/VGCFFD/bkwEw52LRl6BdyU+QTCT3
         ndQiuqWwsCWqFJUqV2mMbSu5CBhwuHwO6khPaO7Vyl3CHrjVaLV7TBdEbfOoZ4F44G9T
         rfzc637yk3uTAgeCPn8Yu6taVyNHhI0vKg3C4fsXrSHvczYbhnCfVOJOmNrfo5UyV40J
         /152MV2ZM0vzauSRzgQ1D5xiBGNmxRG0YowpAK/rxU1jL/Y0x1ulmMvcgsfcSnSHkbgI
         wbKQ==
X-Gm-Message-State: AC+VfDxRiMl1Nyg8WyLFjjJIcmZOl4UszSoTzhdolb5XrSK7tcF+KcFY
        +LsmFkmLUe3ndC+rZ16mFqcoCwSSyIkCRoPUbWB4sNUbw+IJTDH3
X-Google-Smtp-Source: ACHHUZ4guAhY7shonB5ivhaqy8LCBNhETDsG4ZBO3PsnT+cSA7hvtjT6pQ0FeMQ+3yssq6kNLUluJwgeQfRLJkKbyMg=
X-Received: by 2002:a0d:d892:0:b0:55a:64f0:366 with SMTP id
 a140-20020a0dd892000000b0055a64f00366mr1570885ywe.7.1683190522694; Thu, 04
 May 2023 01:55:22 -0700 (PDT)
MIME-Version: 1.0
References: <20230425034010.3789376-1-quic_bjorande@quicinc.com>
 <20230425034010.3789376-6-quic_bjorande@quicinc.com> <ZFD8oQETtLuDH2Xg@hovoldconsulting.com>
 <20230504031354.GE870858@hu-bjorande-lv.qualcomm.com> <ZFNvHgaYsHUc2Y9L@hovoldconsulting.com>
In-Reply-To: <ZFNvHgaYsHUc2Y9L@hovoldconsulting.com>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date:   Thu, 4 May 2023 11:55:11 +0300
Message-ID: <CAA8EJpr3VaVuXro6yqfUtAOrF9fcQgsy9kbSGhhrA6sTP5sLaA@mail.gmail.com>
Subject: Re: [PATCH 5/7] phy: qcom-qmp-combo: Introduce drm_bridge
To:     Johan Hovold <johan@kernel.org>
Cc:     Bjorn Andersson <quic_bjorande@quicinc.com>,
        Vinod Koul <vkoul@kernel.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 4 May 2023 at 11:38, Johan Hovold <johan@kernel.org> wrote:
>
> On Wed, May 03, 2023 at 08:13:54PM -0700, Bjorn Andersson wrote:
> > On Tue, May 02, 2023 at 02:05:53PM +0200, Johan Hovold wrote:
> > > On Mon, Apr 24, 2023 at 08:40:08PM -0700, Bjorn Andersson wrote:
> > > > The QMP combo PHY sits in an of_graph connected between the DisplayPort
> > > > controller and a USB Type-C connector (or possibly a redriver).
> > > >
> > > > The TCPM needs to be able to convey the HPD signal to the DisplayPort
> > > > controller, but no directly link is provided by DeviceTree so the signal
> > > > needs to "pass through" the QMP combo phy.
> > > >
> > > > Handle this by introducing a drm_bridge which upon initialization finds
> > > > the next bridge (i.e. the usb-c-connector) and chain this together. This
> > > > way HPD changes in the connector will propagate to the DisplayPort
> > > > driver.
> > > >
> > > > The connector bridge is resolved lazily, as the TCPM is expected to be
> > > > able to resolve the typec mux and switch at probe time, so the QMP combo
> > > > phy will probe before the TCPM.
> > > >
> > > > Signed-off-by: Bjorn Andersson <quic_bjorande@quicinc.com>
> > > > ---
> > > >  drivers/phy/qualcomm/phy-qcom-qmp-combo.c | 36 +++++++++++++++++++++++
> > > >  1 file changed, 36 insertions(+)
> > > >
> > > > diff --git a/drivers/phy/qualcomm/phy-qcom-qmp-combo.c b/drivers/phy/qualcomm/phy-qcom-qmp-combo.c
> > > > index 5d6d6ef3944b..84bc08002537 100644
> > > > --- a/drivers/phy/qualcomm/phy-qcom-qmp-combo.c
> > > > +++ b/drivers/phy/qualcomm/phy-qcom-qmp-combo.c
>
> > > > @@ -3196,6 +3200,34 @@ static int qmp_combo_register_clocks(struct qmp_combo *qmp, struct device_node *
> > > >   return devm_add_action_or_reset(qmp->dev, phy_clk_release_provider, dp_np);
> > > >  }
> > > >
> > > > +static int qmp_combo_bridge_attach(struct drm_bridge *bridge,
> > > > +                            enum drm_bridge_attach_flags flags)
> > > > +{
> > > > + struct qmp_combo *qmp = container_of(bridge, struct qmp_combo, bridge);
> > > > + struct drm_bridge *next_bridge;
> > > > +
> > > > + if (!(flags & DRM_BRIDGE_ATTACH_NO_CONNECTOR))
> > > > +         return -EINVAL;
> > > > +
> > > > + next_bridge = devm_drm_of_get_bridge(qmp->dev, qmp->dev->of_node, 0, 0);
> > > > + if (IS_ERR(next_bridge))
> > > > +         return dev_err_probe(qmp->dev, PTR_ERR(next_bridge), "failed to acquire drm_bridge\n");
> > >
> > > Using dev_err_probe() in an attach callback looks wrong as these
> > > functions should not be returning -EPROBE_DEFER (and this is not a probe
> > > function).
> >
> > The problem is that this might return EPROBE_DEFER, and at least today
> > propagates out to returning EPROBE_DEFER from our DP controller's
> > bind().
>
> Due to the known issue with the MSM driver panel lookup, or due to some
> more fundamental problem with the stack?

Ideally MSM DP driver should call component_add() only when the next
bridge is available. This is how we handle it for the DSI case.
However I'm yet to see the changes to dp_display_probe() which make
actual use of the done_probing callback. And even that will only fix
the eDP case. For the normal DP case we have no way of being properly
notified when the next bridge becomes available. So the driver will
try to drm_bridge_attach() from the component's bind() callback and
return an error if the chain is not (yet) fully available.

>
> At least in the former case, I don't think we should hide the fact that
> we have an unresolved issue with the MSM driver this way even if it
> means printing an extra error message until it has been resolved (cf.
> the panel lookup errors that we've intentionally kept in place).
>
> > This is not optimal, but unfortunately we have a two way dependency
> > across the of_graph, so we need to make one of the sides lazy...
>
> But this comments seems to suggest this is a bigger issue than the panel
> lookup.
>
> Could you describe the issue in some more detail (e.g. when would you
> see -EPROBE_DEFER here)?
>
> Johan



-- 
With best wishes
Dmitry
