Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C0AC3604F92
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Oct 2022 20:23:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231172AbiJSSXC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Oct 2022 14:23:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229648AbiJSSW4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Oct 2022 14:22:56 -0400
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92CC21BE430
        for <linux-kernel@vger.kernel.org>; Wed, 19 Oct 2022 11:22:54 -0700 (PDT)
Received: by mail-ej1-x635.google.com with SMTP id y14so41926315ejd.9
        for <linux-kernel@vger.kernel.org>; Wed, 19 Oct 2022 11:22:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=PXuk6gd0GXNAFejWrIRQ8xF5Y0pe8OGG5T6m5TWLME0=;
        b=Bkk2lQkeEKnnk9M34tqIFo43P8iACO9rIBHG4ONJ1kdDTC7bbmF0EF95lNM7A8piwB
         ysdneGiA449i+JcW63RSC/aZGryOs0G7aWVEQlKnP2YfnREc4R79dDOmtXs26mrb0d+b
         lp+XG3sbC8dHCfYJ0kHVFKqcFKEPmegDl3jC8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PXuk6gd0GXNAFejWrIRQ8xF5Y0pe8OGG5T6m5TWLME0=;
        b=1UiwVfsxYScFfMY2V+ZeD2u4TV7X1XLYoB1lR/H7M58NyfMJsgKNXyokHpTZHRm7aC
         Nm3kbXRDYPh4LG5ikHq7sCU7QM0+xpHom0VyiydQPmh/PoSlYXp/jbrIRSxxZYh2GtUL
         lF/TTm/BzWkJBfTgzTS34wzAPyqr8CuaqVOvh0+dTqME3CDwSl2BcNzcBbIFv+77L+8i
         h9gv3vfmhbdIpQMybm5ZnQouIN0wyB8c2JF4EPfC3Oo1VpP2aFH3nZsWWFXeYQNC+M8O
         b1/h7SDgnTRQc/mGWfIwtlEw81zGe5BVefSM65zvzcWs1mSNLofyeoo7ftW3pzHWfiEd
         tPNw==
X-Gm-Message-State: ACrzQf3GuDeWdcAqab2prpppyvXyVItJy4GBCEVO5kU+/+INbEgPa/by
        gu3pHVlRsFE1KJ3+4J4YspNXS2NoMlIcX1A7
X-Google-Smtp-Source: AMsMyM5OkW8p3D8VpnJP5WwC4AyjoWY6yTb0Z0hdZa2V0cCBapR9Ue7o+26ldlQ9vvN24raXD7y4Vw==
X-Received: by 2002:a17:907:60d5:b0:78d:f741:7f9b with SMTP id hv21-20020a17090760d500b0078df7417f9bmr7762016ejc.314.1666203772552;
        Wed, 19 Oct 2022 11:22:52 -0700 (PDT)
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com. [209.85.221.54])
        by smtp.gmail.com with ESMTPSA id la5-20020a170907780500b0077f20a722dfsm9315293ejc.165.2022.10.19.11.22.51
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 19 Oct 2022 11:22:51 -0700 (PDT)
Received: by mail-wr1-f54.google.com with SMTP id a3so30448046wrt.0
        for <linux-kernel@vger.kernel.org>; Wed, 19 Oct 2022 11:22:51 -0700 (PDT)
X-Received: by 2002:a5d:6488:0:b0:22b:3b0b:5e72 with SMTP id
 o8-20020a5d6488000000b0022b3b0b5e72mr6228612wri.138.1666203770860; Wed, 19
 Oct 2022 11:22:50 -0700 (PDT)
MIME-Version: 1.0
References: <20221017121813.1.I59700c745fbc31559a5d5c8e2a960279c751dbd5@changeid>
 <CAE-0n51Fdp6hGqWdBy1zgb0XwqQXPveG7tQahP4hjM_Jg9hkYw@mail.gmail.com>
In-Reply-To: <CAE-0n51Fdp6hGqWdBy1zgb0XwqQXPveG7tQahP4hjM_Jg9hkYw@mail.gmail.com>
From:   Doug Anderson <dianders@chromium.org>
Date:   Wed, 19 Oct 2022 11:22:39 -0700
X-Gmail-Original-Message-ID: <CAD=FV=WvUtgH-_p+jHiOsRkOFdcH9ND_=pX8SyYGTne-MZj6Fw@mail.gmail.com>
Message-ID: <CAD=FV=WvUtgH-_p+jHiOsRkOFdcH9ND_=pX8SyYGTne-MZj6Fw@mail.gmail.com>
Subject: Re: [PATCH] drm/bridge: ps8640: Add back the 50 ms mystery delay
 after HPD
To:     Stephen Boyd <swboyd@chromium.org>
Cc:     dri-devel@lists.freedesktop.org,
        Rock Chiu <rock.chiu@paradetech.corp-partner.google.com>,
        Hsin-Yi Wang <hsinyi@chromium.org>,
        Jason Yen <jason.yen@paradetech.corp-partner.google.com>,
        Chen-Yu Tsai <wenst@chromium.org>,
        Andrzej Hajda <andrzej.hajda@intel.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Philip Chen <philipchen@chromium.org>,
        Robert Foss <robert.foss@linaro.org>,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Wed, Oct 19, 2022 at 11:18 AM Stephen Boyd <swboyd@chromium.org> wrote:
>
> Quoting Douglas Anderson (2022-10-17 12:18:51)
> > Back in commit 826cff3f7ebb ("drm/bridge: parade-ps8640: Enable
> > runtime power management") we removed a mysterious 50 ms delay because
> > "Parade's support [couldn't] explain what the delay [was] for".
> >
> > While I'm always a fan of removing mysterious delays, I suspect that
> > we need this mysterious delay to avoid some problems.
> >
> > Specifically, what I found recently is that on sc7180-trogdor-homestar
> > sometimes the AUX backlight wasn't initializing properly. Some
> > debugging showed that the drm_dp_dpcd_read() function that the AUX
> > backlight driver was calling was returning bogus data about 1% of the
> > time when I booted up. This confused
> > drm_panel_dp_aux_backlight(). From continued debugging:
> > - If I retried the read then the read worked just fine.
> > - If I added a loop to perform the same read that
> >   drm_panel_dp_aux_backlight() was doing 30 times at bootup I could
> >   see that some percentage of the time the first read would give bogus
> >   data but all 29 additional reads would always be fine.
> > - If I added a large delay _after_ powering on the panel but before
> >   powering on PS8640 I could still reproduce the problem.
> > - If I added a delay after PS8640 powered on then I couldn't reproduce
> >   the problem.
> > - I couldn't reproduce the problem on a board with the same panel but
> >   the ti-sn65dsi86 bridge chip.
> >
> > To me, the above indicated that there was a problem with PS8640 and
> > not the panel.
> >
> > I don't really have any insight into what's going on in the MCU, but
> > my best guess is that when the MCU itself sees the HPD go high that it
> > does some AUX transfers itself and this is confusing things.
> >
> > Let's go back and add back in the mysterious 50 ms delay. We only want
> > to do this the first time we see HPD go high after booting the MCU,
> > not every time we double-check HPD.
> >
> > With this, the backlight initializes reliably on homestar.
> >
> > Fixes: 826cff3f7ebb ("drm/bridge: parade-ps8640: Enable runtime power management")
> > Signed-off-by: Douglas Anderson <dianders@chromium.org>
> > ---
>
> Reviewed-by: Stephen Boyd <swboyd@chromium.org>

I'm not expecting any other reviews of this patch, though I'm happy to
be proven wrong. As a heads up, I'll plan to land this on Friday
(roughly 2 days from now) in "drm-misc-fixes" barring anything else.
If anyone else plans to offer any opinions about this patch or just
wants more time to review, please shout.

-Doug
