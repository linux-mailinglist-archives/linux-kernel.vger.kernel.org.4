Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C8B46A5022
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Feb 2023 01:27:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229574AbjB1A1G (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Feb 2023 19:27:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229489AbjB1A1E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Feb 2023 19:27:04 -0500
Received: from mail-io1-xd29.google.com (mail-io1-xd29.google.com [IPv6:2607:f8b0:4864:20::d29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4CE7923D8E
        for <linux-kernel@vger.kernel.org>; Mon, 27 Feb 2023 16:27:03 -0800 (PST)
Received: by mail-io1-xd29.google.com with SMTP id d12so3382614ioe.10
        for <linux-kernel@vger.kernel.org>; Mon, 27 Feb 2023 16:27:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=J4dpmjldCe+HY2ES0MFLHn2sS+ItBfNAWhdQJof6PBI=;
        b=TpO+O+hxXuNDUwB79mR9KtWXctPZotDM9vhyCIcH6Jc2f2Y35AnyS+Cv+eluuuFqx0
         3a5m/YFwr3YLlY0Latc16v0xtytbe/eWenIXf9AXgNtpOcY40dkrAl15c0MUJQwuoLf/
         1bo2qseIehw6e2br6xQzfDlhjVYwJx/7bpnjI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=J4dpmjldCe+HY2ES0MFLHn2sS+ItBfNAWhdQJof6PBI=;
        b=TLMgs3YjU38ftd9mQSHr6B0ZPeSaVjbrs16YlQGk8SMlLFV8ZI07krX1XVVS4AZ2Pt
         7aOZqoIbokwX/AsWMcdhydVMrw+hyZxAD8g2gd/7Dqk+bRshfzjiDoElLsSveEdMUZZ3
         m6xbLJoDmAwhzUB8TYez8gHj7BpGZkCudHkx33SMjRvWLRjHarMgUeqMbdsg7oCC7o94
         UHAk7/k2fziAAmHLZxYHZOmX0ctcuAu/H94M/oMf1HsXmcqCksFoB/fY5oyEfHmyWV/p
         yrc4iF4zMOCafgMbJ7dmO6I/PsoJ70XHlO06uIf2tDT5z8eR43bta24P2JWg1+fu7Ovu
         czsw==
X-Gm-Message-State: AO0yUKUEjvmaZTE/wb5cBsH6P2VE/PTHHK7lmlBXqH5l9Alttrg4hbAo
        FVlhmj5SCdr+cMInbYsnpCIjtZzYqDNds1zf
X-Google-Smtp-Source: AK7set/dTjdgu+k3/rz5osr54vROCCOI0+/h95fL5fmv1vFoVRPi9eUsUOERen6bE3Nmi5ORQ80tBQ==
X-Received: by 2002:a5d:88d2:0:b0:718:cf71:b633 with SMTP id i18-20020a5d88d2000000b00718cf71b633mr709544iol.8.1677544022402;
        Mon, 27 Feb 2023 16:27:02 -0800 (PST)
Received: from mail-io1-f44.google.com (mail-io1-f44.google.com. [209.85.166.44])
        by smtp.gmail.com with ESMTPSA id f13-20020a5edf0d000000b007437276ae6dsm2671010ioq.3.2023.02.27.16.26.59
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 27 Feb 2023 16:27:00 -0800 (PST)
Received: by mail-io1-f44.google.com with SMTP id q6so3397819iot.2
        for <linux-kernel@vger.kernel.org>; Mon, 27 Feb 2023 16:26:59 -0800 (PST)
X-Received: by 2002:a02:858c:0:b0:3c5:1971:1b7f with SMTP id
 d12-20020a02858c000000b003c519711b7fmr440124jai.6.1677544019208; Mon, 27 Feb
 2023 16:26:59 -0800 (PST)
MIME-Version: 1.0
References: <20230131141756.RFT.v2.1.I723a3761d57ea60c5dd754c144aed6c3b2ea6f5a@changeid>
 <CAPY8ntAUhVB6UtQTeHAcxNW950Ou+NcEoGwk3JnVWLay89_0Nw@mail.gmail.com>
In-Reply-To: <CAPY8ntAUhVB6UtQTeHAcxNW950Ou+NcEoGwk3JnVWLay89_0Nw@mail.gmail.com>
From:   Doug Anderson <dianders@chromium.org>
Date:   Mon, 27 Feb 2023 16:26:47 -0800
X-Gmail-Original-Message-ID: <CAD=FV=UNx7ivymvpGKcuyvvepvo-T2B2aREJy2GyawTHCnazsw@mail.gmail.com>
Message-ID: <CAD=FV=UNx7ivymvpGKcuyvvepvo-T2B2aREJy2GyawTHCnazsw@mail.gmail.com>
Subject: Re: [RFT PATCH v2 1/3] drm/bridge: tc358762: Set pre_enable_prev_first
To:     Dave Stevenson <dave.stevenson@raspberrypi.com>
Cc:     dri-devel@lists.freedesktop.org, Rob Clark <robdclark@gmail.com>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        freedreno@lists.freedesktop.org,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Jonas Karlman <jonas@kwiboo.se>, linux-arm-msm@vger.kernel.org,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Robert Foss <robert.foss@linaro.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Vinod Koul <vkoul@kernel.org>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Andrzej Hajda <andrzej.hajda@intel.com>,
        Sean Paul <sean@poorly.run>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Wed, Feb 1, 2023 at 1:51=E2=80=AFAM Dave Stevenson
<dave.stevenson@raspberrypi.com> wrote:
>
> On Tue, 31 Jan 2023 at 22:22, Douglas Anderson <dianders@chromium.org> wr=
ote:
> >
> > Set the "pre_enable_prev_first" as provided by commit 4fb912e5e190
> > ("drm/bridge: Introduce pre_enable_prev_first to alter bridge init
> > order"). This should allow us to revert commit ec7981e6c614
> > ("drm/msm/dsi: don't powerup at modeset time for parade-ps8640") and
> > commit 7d8e9a90509f ("drm/msm/dsi: move DSI host powerup to modeset
> > time").
>
> I see no reference in the TC358762 datasheet to requiring the DSI
> interface to be in any particular state.
> However, setting this flag does mean that the DSI host doesn't need to
> power up and down for each host_transfer request from
> tc358762_pre_enable/tc358762_init, so on that basis I'm good with it.
>
> Reviewed-by: Dave Stevenson <dave.stevenson@raspberrypi.com>
>
> > Cc: Dave Stevenson <dave.stevenson@raspberrypi.com>
> > Cc: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> > Cc: Abhinav Kumar <quic_abhinavk@quicinc.com>
> > Signed-off-by: Douglas Anderson <dianders@chromium.org>
> > ---
> >
> > (no changes since v1)
> >
> >  drivers/gpu/drm/bridge/tc358762.c | 1 +
> >  1 file changed, 1 insertion(+)
> >
> > diff --git a/drivers/gpu/drm/bridge/tc358762.c b/drivers/gpu/drm/bridge=
/tc358762.c
> > index 0b6a28436885..77f7f7f54757 100644
> > --- a/drivers/gpu/drm/bridge/tc358762.c
> > +++ b/drivers/gpu/drm/bridge/tc358762.c
> > @@ -229,6 +229,7 @@ static int tc358762_probe(struct mipi_dsi_device *d=
si)
> >         ctx->bridge.funcs =3D &tc358762_bridge_funcs;
> >         ctx->bridge.type =3D DRM_MODE_CONNECTOR_DPI;
> >         ctx->bridge.of_node =3D dev->of_node;
> > +       ctx->bridge.pre_enable_prev_first =3D true;
> >
> >         drm_bridge_add(&ctx->bridge);

Abhinav asked what the plan was for landing this [1]. Since this isn't
urgent, I guess the plan is to land patch #1 in drm-misc-next. Then we
sit and wait until it percolates into mainline and, once it does, then
patch #2 and #3 can land.

Since I have Dave's review I can commit this to drm-misc-next myself.
My plan will be to wait until Thursday or Friday of this week (to give
people a bit of time to object) and then land patch #1. Then I'll
snooze things for a while and poke Abhinav and Dmitry to land patch #2
/ #3 when I notice it in mainline. If, at any point, someone comes out
of the woodwork and yells that this is breaking them then, worst case,
we can revert.

[1] https://lore.kernel.org/r/1f204585-88e2-abae-1216-92f739ac9e91@quicinc.=
com/
