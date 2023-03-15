Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 43F396BA59C
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Mar 2023 04:29:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230390AbjCOD3J (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Mar 2023 23:29:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230336AbjCOD24 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Mar 2023 23:28:56 -0400
Received: from mail-io1-xd31.google.com (mail-io1-xd31.google.com [IPv6:2607:f8b0:4864:20::d31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F0E65A6ED
        for <linux-kernel@vger.kernel.org>; Tue, 14 Mar 2023 20:28:55 -0700 (PDT)
Received: by mail-io1-xd31.google.com with SMTP id b5so7298872iow.0
        for <linux-kernel@vger.kernel.org>; Tue, 14 Mar 2023 20:28:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1678850933;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KHJv8+oprMyTG8LLowWuTDSnzgqZct/FrXmCJG1m1N8=;
        b=E9y0viNou8XTccqIF7nChT4t+S/RO+S43g8Yi6qhmRl67Mc8Jp2q0qh02d3Zj6ltm7
         3++Hj2kFeVOM8T0bceft9TDEYRcPUwEJw3FIyloAw0Lk35wqe2+hnNQm0zGCcn229Fk0
         eOanbixHkHR++JqIkACWcNjYBlI/BxKBQxWms=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678850933;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KHJv8+oprMyTG8LLowWuTDSnzgqZct/FrXmCJG1m1N8=;
        b=4N9JX9lEkpbSxFH2Aqf2CIkOHxy0j7BPd4cDh/RtqMXF0RZXMcAae7RQ/asQCqK7XR
         2m5AXG6EZqwIcZ/PwIuh2MldsN57iY5G2q3414WJnSi+AUogHJny8hKdpppVyvaen66d
         2nz8pp52e9GtZSvGSI6RH0A4DJV4O7n1RiSZ2khkz+lrR3FGyQYRNjStud2H5ABLt1jz
         InGsA571BBS5swmBEjgY31IopxS6ScShoZw0QxQ/uge8PWE6vDqCGB9LTNQJWFZSj73n
         HkxYymLCNFOXLJlEZd6Uo/e2uvwwaAlrrXXGvs7Sr1J+k3TVGgeM3J+5Spe8Ks0NEQ7+
         q+nA==
X-Gm-Message-State: AO0yUKVCjjTheZYIG7tgb4YkQiHJX4a6xmvQutc0rzNlnQImwQCVMzMa
        c1grPGtmhkjx57ZHwWr8LEew3CF5+f0J7U7uChYYXw==
X-Google-Smtp-Source: AK7set+K7jxkr7x8BZk6qGVZSfKCUnhLEKrVm/pbz3cErtANxa+XHpoQoJ+pTsmTBi35XTKMaOL6QXGQ+aywcAvRAUo=
X-Received: by 2002:a6b:6a0a:0:b0:745:b287:c281 with SMTP id
 x10-20020a6b6a0a000000b00745b287c281mr17750961iog.2.1678850933695; Tue, 14
 Mar 2023 20:28:53 -0700 (PDT)
MIME-Version: 1.0
References: <20230314110043.2139111-1-treapking@chromium.org> <CAD=FV=W=jVsvD620wWKfniRYQNJnb7goDUKb_HhL_qVxLYGZOA@mail.gmail.com>
In-Reply-To: <CAD=FV=W=jVsvD620wWKfniRYQNJnb7goDUKb_HhL_qVxLYGZOA@mail.gmail.com>
From:   Pin-yen Lin <treapking@chromium.org>
Date:   Wed, 15 Mar 2023 11:28:42 +0800
Message-ID: <CAEXTbpe6EyukjKfgaVtHdMK2Ppw715kUUnOqvFa+tEX913p9aQ@mail.gmail.com>
Subject: Re: [PATCH 1/2] drm/bridge: ps8640: Skip redundant bridge enable
To:     Doug Anderson <dianders@chromium.org>
Cc:     Andrzej Hajda <andrzej.hajda@intel.com>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Robert Foss <rfoss@kernel.org>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org
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

Hi Doug,

On Wed, Mar 15, 2023 at 5:31=E2=80=AFAM Doug Anderson <dianders@chromium.or=
g> wrote:
>
> Hi,
>
> On Tue, Mar 14, 2023 at 4:00=E2=80=AFAM Pin-yen Lin <treapking@chromium.o=
rg> wrote:
> >
> > Skip the drm_bridge_chain_pre_enable call when the bridge is already
> > pre_enabled. This make pre_enable and post_disable (thus
> > pm_runtime_get/put) symmetric.
> >
> > Fixes: 46f206304db0 ("drm/bridge: ps8640: Rework power state handling")
> > Signed-off-by: Pin-yen Lin <treapking@chromium.org>
> > ---
> >
> >  drivers/gpu/drm/bridge/parade-ps8640.c | 3 ++-
> >  1 file changed, 2 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/gpu/drm/bridge/parade-ps8640.c b/drivers/gpu/drm/b=
ridge/parade-ps8640.c
> > index 4b361d7d5e44..08de501c436e 100644
> > --- a/drivers/gpu/drm/bridge/parade-ps8640.c
> > +++ b/drivers/gpu/drm/bridge/parade-ps8640.c
> > @@ -557,7 +557,8 @@ static struct edid *ps8640_bridge_get_edid(struct d=
rm_bridge *bridge,
> >          * EDID, for this chip, we need to do a full poweron, otherwise=
 it will
> >          * fail.
> >          */
> > -       drm_atomic_bridge_chain_pre_enable(bridge, connector->state->st=
ate);
> > +       if (poweroff)
> > +               drm_atomic_bridge_chain_pre_enable(bridge, connector->s=
tate->state);
>
> It always seemed weird to me that this function was asymmetric, so I
> like this change, thanks!
>
> I also remember wondering before how this function was safe, though.
> The callpath for getting here from the ioctl is documented in the
> function and when I look at it I wonder if anything is preventing the
> bridge from being enabled / disabled through normal means at the same
> time your function is running. That could cause all sorts of badness
> if it is indeed possible. Does anyone reading this know if that's
> indeed a problem?

If the "normal mean" is disabling the bridge, then we are probably
disabling the whole display pipeline. If so, is the EDID still
relevant in this case?

drm_get_edid returns NULL whenever error happens, and the helpers seem
to handle this case properly.
>
> I suppose that, if this is unsafe, it's no more unsafe now than it was
> before your patch, so I guess:
>
> Reviewed-by: Douglas Anderson <dianders@chromium.org>
>
> If there are no issues, I'll plan to land this patch and the next one
> to drm-misc-next sometime late-ish next week.

Thanks for the review. I'll submit a v2 to collect the review tags and
fix up the nit in patch 2/2.

Best regards,
Pin-yen
