Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DBB646BBF26
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Mar 2023 22:34:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231937AbjCOVeN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Mar 2023 17:34:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229556AbjCOVeK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Mar 2023 17:34:10 -0400
Received: from mail-io1-xd32.google.com (mail-io1-xd32.google.com [IPv6:2607:f8b0:4864:20::d32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 873E199BEA
        for <linux-kernel@vger.kernel.org>; Wed, 15 Mar 2023 14:34:08 -0700 (PDT)
Received: by mail-io1-xd32.google.com with SMTP id o14so2902215ioa.3
        for <linux-kernel@vger.kernel.org>; Wed, 15 Mar 2023 14:34:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1678916046;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bxQiJhldQojh4IbDRDL1+iMAuzL0o4Se1pqroOsNCwQ=;
        b=gmAtNBMc7/vjNIghl49Q+TQX+Sj/wxnxkzMgubxh4Vm1nnU/q9DoZIeMmj2/a0SuJo
         te0L/G+P8auI0scnh3z7CgsSx57w9UKrTwVaGcubR9xv1eJROolJf/jg1RFvXrha0y4h
         crhwUQRV5uuyD0Zn0KzA9lCPnWJPL5KqyZ650=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678916046;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bxQiJhldQojh4IbDRDL1+iMAuzL0o4Se1pqroOsNCwQ=;
        b=OAZPX882wW2BPvA1MqRXgNyojH+eHMmbFOWX1t5UB8CSHs+EoZv46UkkqN/TOEx9ia
         QtpH08ssHEl/SuhjG5iFd2czv0AiPdm87Q5de6O3h/NKVgZSXPWfrdEr3FknKE5ZgpIC
         MVtfNz1gu1cRQ4B5xKbGGDX1sXOp4ThYOUvhKoBpo9spqSD2xP7baM98eUZgFYs5YB0i
         qsrHP1b4MDGhgmyQTpV3uFhCHXJRAVZZJkrooU6YfY043LlKn3zbAm5R6GuNVYEON5qa
         LcZc8+qR6+u2G/LJlh8cou3ZdU6cosXVee9/RbOxQgyNkgBxpwpwhb4ekaSvHOXmw4MC
         LDMA==
X-Gm-Message-State: AO0yUKX3wViNkmCZfH4Y51pzw1ZNQ4Y7IrTGWUm03AZC9Z4S2lTSFBaO
        4MgdDbQOHTfTuI5tVqCJHMMCodidPVCPGwH0Ez0=
X-Google-Smtp-Source: AK7set88ooW+YaPyPBg9uMhX/FQiZClUiAZquRBUok/EZ9vkorH1kmf+toN3sGFflRIaSYfsyGzAqg==
X-Received: by 2002:a6b:f617:0:b0:74c:b8f9:651b with SMTP id n23-20020a6bf617000000b0074cb8f9651bmr13014089ioh.1.1678916046072;
        Wed, 15 Mar 2023 14:34:06 -0700 (PDT)
Received: from mail-il1-f182.google.com (mail-il1-f182.google.com. [209.85.166.182])
        by smtp.gmail.com with ESMTPSA id y22-20020a02bb16000000b003fd73ca55c4sm1969169jan.91.2023.03.15.14.34.04
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 15 Mar 2023 14:34:04 -0700 (PDT)
Received: by mail-il1-f182.google.com with SMTP id h7so11112858ila.5
        for <linux-kernel@vger.kernel.org>; Wed, 15 Mar 2023 14:34:04 -0700 (PDT)
X-Received: by 2002:a05:6e02:549:b0:315:8e92:39ad with SMTP id
 i9-20020a056e02054900b003158e9239admr3841409ils.1.1678916043909; Wed, 15 Mar
 2023 14:34:03 -0700 (PDT)
MIME-Version: 1.0
References: <20230314110043.2139111-1-treapking@chromium.org>
 <CAD=FV=W=jVsvD620wWKfniRYQNJnb7goDUKb_HhL_qVxLYGZOA@mail.gmail.com> <CAEXTbpe6EyukjKfgaVtHdMK2Ppw715kUUnOqvFa+tEX913p9aQ@mail.gmail.com>
In-Reply-To: <CAEXTbpe6EyukjKfgaVtHdMK2Ppw715kUUnOqvFa+tEX913p9aQ@mail.gmail.com>
From:   Doug Anderson <dianders@chromium.org>
Date:   Wed, 15 Mar 2023 14:33:51 -0700
X-Gmail-Original-Message-ID: <CAD=FV=VLh37hFpLwyuPoGNDCpvVL7FGLySVp7d1W788YkjNYog@mail.gmail.com>
Message-ID: <CAD=FV=VLh37hFpLwyuPoGNDCpvVL7FGLySVp7d1W788YkjNYog@mail.gmail.com>
Subject: Re: [PATCH 1/2] drm/bridge: ps8640: Skip redundant bridge enable
To:     Pin-yen Lin <treapking@chromium.org>
Cc:     Andrzej Hajda <andrzej.hajda@intel.com>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Robert Foss <rfoss@kernel.org>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Tue, Mar 14, 2023 at 8:28=E2=80=AFPM Pin-yen Lin <treapking@chromium.org=
> wrote:
>
> Hi Doug,
>
> On Wed, Mar 15, 2023 at 5:31=E2=80=AFAM Doug Anderson <dianders@chromium.=
org> wrote:
> >
> > Hi,
> >
> > On Tue, Mar 14, 2023 at 4:00=E2=80=AFAM Pin-yen Lin <treapking@chromium=
.org> wrote:
> > >
> > > Skip the drm_bridge_chain_pre_enable call when the bridge is already
> > > pre_enabled. This make pre_enable and post_disable (thus
> > > pm_runtime_get/put) symmetric.
> > >
> > > Fixes: 46f206304db0 ("drm/bridge: ps8640: Rework power state handling=
")
> > > Signed-off-by: Pin-yen Lin <treapking@chromium.org>
> > > ---
> > >
> > >  drivers/gpu/drm/bridge/parade-ps8640.c | 3 ++-
> > >  1 file changed, 2 insertions(+), 1 deletion(-)
> > >
> > > diff --git a/drivers/gpu/drm/bridge/parade-ps8640.c b/drivers/gpu/drm=
/bridge/parade-ps8640.c
> > > index 4b361d7d5e44..08de501c436e 100644
> > > --- a/drivers/gpu/drm/bridge/parade-ps8640.c
> > > +++ b/drivers/gpu/drm/bridge/parade-ps8640.c
> > > @@ -557,7 +557,8 @@ static struct edid *ps8640_bridge_get_edid(struct=
 drm_bridge *bridge,
> > >          * EDID, for this chip, we need to do a full poweron, otherwi=
se it will
> > >          * fail.
> > >          */
> > > -       drm_atomic_bridge_chain_pre_enable(bridge, connector->state->=
state);
> > > +       if (poweroff)
> > > +               drm_atomic_bridge_chain_pre_enable(bridge, connector-=
>state->state);
> >
> > It always seemed weird to me that this function was asymmetric, so I
> > like this change, thanks!
> >
> > I also remember wondering before how this function was safe, though.
> > The callpath for getting here from the ioctl is documented in the
> > function and when I look at it I wonder if anything is preventing the
> > bridge from being enabled / disabled through normal means at the same
> > time your function is running. That could cause all sorts of badness
> > if it is indeed possible. Does anyone reading this know if that's
> > indeed a problem?
>
> If the "normal mean" is disabling the bridge, then we are probably
> disabling the whole display pipeline. If so, is the EDID still
> relevant in this case?

In general when we do a "modeset" I believe that the display pipeline
is disabled and re-enabled. On a Chromebook test image you can see
this disable / re-enable happen when you switch between "VT2" and the
main login screen.

If the display pipeline is disabled / re-enabled then it should still
be fine to keep the EDID cached, so that's not what I'm worried about.
I'm more worried that someone could be querying the EDID at the same
time that someone else was turning the screen off. In that case it
would be possible for "poweroff" to be true (because the screen was on
when we started reading the EDID) and then partway through the screen
could get turned off.

-Doug
