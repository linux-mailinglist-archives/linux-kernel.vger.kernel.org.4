Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 15BE8731B65
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Jun 2023 16:30:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245604AbjFOOaw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Jun 2023 10:30:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231159AbjFOOau (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Jun 2023 10:30:50 -0400
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DFB852721
        for <linux-kernel@vger.kernel.org>; Thu, 15 Jun 2023 07:30:47 -0700 (PDT)
Received: by mail-lf1-x12c.google.com with SMTP id 2adb3069b0e04-4f122ff663eso10624786e87.2
        for <linux-kernel@vger.kernel.org>; Thu, 15 Jun 2023 07:30:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1686839444; x=1689431444;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=04jEXUdrrSwU5Xd9HQj3J49NirU0pS8GLPvuDSKUyoA=;
        b=naQ8ba0znniMNpMRx2pprtzmQ8plJIPBd9/YnvZRJy3GcsHnH0MKoTg3cgTx4YHi7Q
         mKmafC+3thFGDDAowt7bP1rAqvMU9D9h4Kq+oKQxifnFyc2FjtEfLD0j08COqUS0yyV7
         ONNG12f/Z2epDsgp5eN1klolH+7dlQqeNEyQ0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686839444; x=1689431444;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=04jEXUdrrSwU5Xd9HQj3J49NirU0pS8GLPvuDSKUyoA=;
        b=L7Z2Hpyt3oUSEdfnuNYrH+sYL8Hi+UH+vQeZtEhKJ2rCxNZD+Rr5zzozj/hOEDwA97
         f233BjAIt9NfKR8M9vZN2s4yPZhMPJg8cN7MjQ4wYq2wiqeS75+L9Ev8QLpO5OcNnug7
         GkEXRlAa7z1FNinYDMzhOoXcEwX/rDzLJJU3Zwrz7KkJCEprDNd6vR0psWe5FVi6uM29
         738MqpCp6fFSDwofu4R6gVJxBpcfA5u03RUWcdAXIb3/lIYYOvp8cS/KkH9EWp6IaEPm
         OmX5YQQFodwqHsvu/NAcyYdOAuFFzR+jz8GgOHZjuZjVshViz9a3x1wZbmv4gL7G/yg4
         0IYQ==
X-Gm-Message-State: AC+VfDxOFsgJeXlSMUkKANEYhONUn8XrLa/1j0cZJo9mDNKMTG3mCtO2
        Bk4wOorFfLh6UXavr6OTU99KTGoPG1/ZOeVnHeW1l306
X-Google-Smtp-Source: ACHHUZ7XIEaqhGXjNNpzAT3H6avum2RkF7vr/qUtp4WYvbciqh67AA2psyhvFSUQU0pgFDE+YRyt5Q==
X-Received: by 2002:ac2:464d:0:b0:4f4:c972:981f with SMTP id s13-20020ac2464d000000b004f4c972981fmr11779317lfo.54.1686839444065;
        Thu, 15 Jun 2023 07:30:44 -0700 (PDT)
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com. [209.85.128.49])
        by smtp.gmail.com with ESMTPSA id zo18-20020a170906ff5200b0096ae4451c65sm9542049ejb.157.2023.06.15.07.30.42
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 15 Jun 2023 07:30:42 -0700 (PDT)
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-3f7f7dfc037so126455e9.0
        for <linux-kernel@vger.kernel.org>; Thu, 15 Jun 2023 07:30:42 -0700 (PDT)
X-Received: by 2002:a05:600c:5196:b0:3f7:3654:8d3 with SMTP id
 fa22-20020a05600c519600b003f7365408d3mr168273wmb.2.1686839442384; Thu, 15 Jun
 2023 07:30:42 -0700 (PDT)
MIME-Version: 1.0
References: <20230612163256.1.I7b8f60b3fbfda068f9bf452d584dc934494bfbfa@changeid>
 <86ad3ffb-fbe2-9bed-751d-684994b71e9d@collabora.com> <CAD=FV=XGN7NEFjtAAr+y_Vfth0MKL875B1+mqzmy3yAfteNxuQ@mail.gmail.com>
 <CAEXTbpcaG1h-AD3SEkznefimMGmvEUtTwQBV9MQ9c+Q-Q+z6GA@mail.gmail.com>
In-Reply-To: <CAEXTbpcaG1h-AD3SEkznefimMGmvEUtTwQBV9MQ9c+Q-Q+z6GA@mail.gmail.com>
From:   Doug Anderson <dianders@chromium.org>
Date:   Thu, 15 Jun 2023 07:30:29 -0700
X-Gmail-Original-Message-ID: <CAD=FV=Vz4d6WZanHRY_6CdOSCVqxiWxs3mDwi_Vw27aDpdzuZg@mail.gmail.com>
Message-ID: <CAD=FV=Vz4d6WZanHRY_6CdOSCVqxiWxs3mDwi_Vw27aDpdzuZg@mail.gmail.com>
Subject: Re: [PATCH] drm/bridge: ps8640: Drop the ability of ps8640 to fetch
 the EDID
To:     Pin-yen Lin <treapking@chromium.org>
Cc:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        dri-devel@lists.freedesktop.org,
        Maxime Ripard <mripard@kernel.org>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        Icenowy Zheng <uwu@icenowy.me>,
        linux-mediatek@lists.infradead.org,
        Andrzej Hajda <andrzej.hajda@intel.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Dave Stevenson <dave.stevenson@raspberrypi.com>,
        David Airlie <airlied@gmail.com>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Robert Foss <rfoss@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Thu, Jun 15, 2023 at 1:47=E2=80=AFAM Pin-yen Lin <treapking@chromium.org=
> wrote:
>
> Hi Doug,
>
> On Thu, Jun 15, 2023 at 5:31=E2=80=AFAM Doug Anderson <dianders@chromium.=
org> wrote:
> >
> > Hi,
> >
> > On Wed, Jun 14, 2023 at 1:22=E2=80=AFAM AngeloGioacchino Del Regno
> > <angelogioacchino.delregno@collabora.com> wrote:
> > >
> > > Il 13/06/23 01:32, Douglas Anderson ha scritto:
> > > > In order to read the EDID from an eDP panel, you not only need to
> > > > power on the bridge chip itself but also the panel. In the ps8640
> > > > driver, this was made to work by having the bridge chip manually po=
wer
> > > > the panel on by calling pre_enable() on everything connectorward on
> > > > the bridge chain. This worked OK, but...
> > > >
> > > > ...when trying to do the same thing on ti-sn65dsi86, feedback was t=
hat
> > > > this wasn't a great idea. As a result, we designed the "DP AUX"
> > > > bus. With the design we ended up with the panel driver itself was i=
n
> > > > charge of reading the EDID. The panel driver could power itself on =
and
> > > > the bridge chip was able to power itself on because it implemented =
the
> > > > DP AUX bus.
> > > >
> > > > Despite the fact that we came up with a new scheme, implemented in =
on
> > > > ti-sn65dsi86, and even implemented it on parade-ps8640, we still ke=
pt
> > > > the old code around. This was because the new scheme required a DT
> > > > change. Previously the panel was a simple "platform_device" and in =
DT
> > > > at the top level. With the new design the panel needs to be listed =
in
> > > > DT under the DP controller node. The old code allowed us to properl=
y
> > > > fetch EDIDs with ps8640 with the old DTs.
> > > >
> > > > Unfortunately, the old code stopped working as of commit 102e80d1fa=
2c
> > > > ("drm/bridge: ps8640: Use atomic variants of drm_bridge_funcs"). Th=
ere
> > > > are cases at bootup where connector->state->state is NULL and the
> > > > kernel crashed at:
> > > > * drm_atomic_bridge_chain_pre_enable
> > > > * drm_atomic_get_old_bridge_state
> > > > * drm_atomic_get_old_private_obj_state
> > > >
> > > > A bit of digging was done to see if there was an easy fix but there
> > > > was nothing obvious. Instead, the only device using ps8640 the "old=
"
> > > > way had its DT updated so that the panel was no longer a simple
> > > > "platform_deice". See commit c2d94f72140a ("arm64: dts: mediatek:
> > > > mt8173-elm: Move display to ps8640 auxiliary bus") and commit
> > > > 113b5cc06f44 ("arm64: dts: mediatek: mt8173-elm: remove panel model
> > > > number in DT").
> > > >
> > > > Let's delete the old, crashing code so nobody gets tempted to copy =
it
> > > > or figure out how it works (since it doesn't).
> > > >
> > > > NOTE: from a device tree "purist" point of view, we're supposed to
> > > > keep old device trees working and this patch is technically "agains=
t
> > > > policy". Reasons I'm still proposing it anyway:
> > > > 1. Officially, old mt8173-elm device trees worked via the "little
> > > >     white lie" approach. The DT would list an arbitrary/representat=
ive
> > > >     panel that would be used for power sequencing. The mode informa=
tion
> > > >     in the panel driver would then be ignored / overridden by the E=
DID
> > > >     reading code in ps8640. I don't feel too terrible breaking DTs =
that
> > > >     contained the wrong "compatible" string to begin with. NOTE tha=
t
> > > >     any old device trees that _didn't_ lie about their compatible w=
ill
> > > >     still work because the mode information will come from the
> > > >     hardcoded panels in panel-edp.
> > > > 2. The only users of the old code were Chromebooks and Chromebooks
> > > >     don't bake their DTs into the BIOS (they are bundled with the
> > > >     kernel). Thus we don't need to worry about breaking someone usi=
ng
> > > >     an old DT with a new kernel.
> > > > 3. The old code was crashing anyway. If someone wants to fix the ol=
d
> > > >     code instead of deleting it then they have my blessing, but wit=
hout
> > > >     a proper fix the old code isn't useful.
> > > >
> > > > I'll list this as "Fixing" the code that made the old code start
> > > > failing. There's not lots of reason to bring this back any further
> > > > than that.
> > >
> > > Hoping to see removal of non-aux EDID reading code from all drivers t=
hat can
> > > support aux-bus is exactly why I moved Elm to the proper... aux-bus..=
 so...
> > >
> > > Yes! Let's go!
> > >
> > > >
> > > > Fixes: 102e80d1fa2c ("drm/bridge: ps8640: Use atomic variants of dr=
m_bridge_funcs")
> > >
> > > ...but this Fixes tag will cause this commit to be backported to kern=
el versions
> > > before my commit moving Elm to aux-bus, and break display on those.
> > >
> > > I would suggest to either find a different Fixes tag, or don't add an=
y, since
> > > technically this is a deprecation commit. We could imply that the old=
 technique
> > > is deprecated since kernel version X.Y and get away with it.
> > >
> > > Otherwise, if you want it backported *anyway*, the safest way would b=
e to Cc it
> > > to stable and explicitly say which versions should it be backported t=
o.
> >
> > The problem is that, as I understand it, as of commit 102e80d1fa2c
> > ("drm/bridge: ps8640: Use atomic variants of drm_bridge_funcs"),
> > things are broken anyway and you'll get a crash at bootup. However, if
> > you start at that commit and apply ${SUBJECT} patch, things actually
> > end up being less broken. It won't crash anymore and on any boards
> > that actually have the display that's specified in the DT compatible
> > the screen should actually work. Thus even without your patch to move
> > things over to the aux-bus it's still an improvement to take
> > ${SUBJECT} patch on any kernels that have that commit.
> >
> > I don't have an 'elm' device easily accessible, but I can figure out
> > how to get one if needed to confirm that's true. However, maybe it's
> > easy for you or Pin-Yen to confirm.
>
> The crash was there, but then commit 4fb912e5e190 ("drm/bridge:
> Introduce pre_enable_prev_first to alter bridge init order") added a
> NULL check on the state object in
> drm_atomic_bridge_chain_pre_enable(), which prevents the kernel crash
> on the latest kernel. And now the panel on "elm" Chromebook is
> actually working without an "aux-bus" node seemingly because the
> userspace is patient enough to keep retrying until the connector gets
> its state initialized. My elm device crashes again after reverting
> commit 4fb912e5e190.

Oh, right! I forgot about that. Commit 4fb912e5e190 ("drm/bridge:
Introduce pre_enable_prev_first to alter bridge init order") as a side
effect caused the crash not to happen, but that also essentially made
the pre-enable a "no-op".

Hmmm, maybe I'll re-post this patch and add that extra note in and
remove the Fixes tag just to keep it from being controversial. I'll
plan to do that ~tomorrow unless there are objections.

-Doug
