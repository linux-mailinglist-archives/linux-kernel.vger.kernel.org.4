Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D7EC0607A22
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Oct 2022 17:09:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230153AbiJUPJs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Oct 2022 11:09:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230108AbiJUPJi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Oct 2022 11:09:38 -0400
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9EFA81DDCA
        for <linux-kernel@vger.kernel.org>; Fri, 21 Oct 2022 08:09:31 -0700 (PDT)
Received: by mail-ed1-x531.google.com with SMTP id e18so7015523edj.3
        for <linux-kernel@vger.kernel.org>; Fri, 21 Oct 2022 08:09:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=E1t79Ir1ooVQXjUw4JlL4xRT2xhdG4RFYt/CAeAMdpQ=;
        b=St93DXqgP0zZHnIJbveQ9TzrvZTY+c6nimZS314QJguPEYlZCp6RwSmz/FIKQOMMlM
         gIiWsPe7ZRFSLa04YVZsDsNvvJaKBd8NL1C6/Fs6eCd8ESmYs+r3PH5KC8SdcxlJo3xz
         uGuVFvQkwOF8m9ZYTWKzLyLjOheypPI1G0Qvs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=E1t79Ir1ooVQXjUw4JlL4xRT2xhdG4RFYt/CAeAMdpQ=;
        b=G8mEiuDIQNXqPbBKlaGyDwJCG9ckC0nF/64OcJTmjVv+gs5hJw5Df95hfYHeGyEhI2
         tXRr4f9cVcMGZL3+6AhBTtSOZXmCdxvwLuUOs1yjk0hDJlDZ2D1JV+M/JXAN5jQ4K8L6
         aWVpaODAes+Gio7DglaAjxTF+KT/Ymju8D6gFYkyNvOuDqoDs37BggKR4CZ5GhvYhYuU
         eU9hjn/4Uw48CXR3XzqPL/AKvZCLnGC8pZW1MhI9+qeNSYQizHyIOJ7AbRk1zNRNvZN3
         1sljhLH8nd5Ozl0KhdetutVDevrv65JfYX198OcwB+nNvRQzHTXy5Hk/D3xIIjxqrf6y
         DCgA==
X-Gm-Message-State: ACrzQf3KHYzvrE54+ak6IGGsTQyifKr1ctmN2qrHVZw8q+0OI5oYi1lb
        B2eKqyZ6fsosACbFDlo8WtzmVITc8vpddP/4
X-Google-Smtp-Source: AMsMyM7Dv2wExeZr1MEAdvc6LHTcf0jNeCsjbNORqA8As+/9npMdmzBZWo6nfmRa/2a0gYLCg0OIuw==
X-Received: by 2002:a05:6402:538f:b0:444:c17b:1665 with SMTP id ew15-20020a056402538f00b00444c17b1665mr18082966edb.98.1666364969889;
        Fri, 21 Oct 2022 08:09:29 -0700 (PDT)
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com. [209.85.221.48])
        by smtp.gmail.com with ESMTPSA id qn24-20020a170907211800b0073c10031dc9sm11770584ejb.80.2022.10.21.08.09.26
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 21 Oct 2022 08:09:26 -0700 (PDT)
Received: by mail-wr1-f48.google.com with SMTP id n12so5233150wrp.10
        for <linux-kernel@vger.kernel.org>; Fri, 21 Oct 2022 08:09:26 -0700 (PDT)
X-Received: by 2002:a05:6000:3c1:b0:236:5779:546d with SMTP id
 b1-20020a05600003c100b002365779546dmr1615303wrg.405.1666364965966; Fri, 21
 Oct 2022 08:09:25 -0700 (PDT)
MIME-Version: 1.0
References: <20221017121813.1.I59700c745fbc31559a5d5c8e2a960279c751dbd5@changeid>
 <CAE-0n51Fdp6hGqWdBy1zgb0XwqQXPveG7tQahP4hjM_Jg9hkYw@mail.gmail.com> <CAD=FV=WvUtgH-_p+jHiOsRkOFdcH9ND_=pX8SyYGTne-MZj6Fw@mail.gmail.com>
In-Reply-To: <CAD=FV=WvUtgH-_p+jHiOsRkOFdcH9ND_=pX8SyYGTne-MZj6Fw@mail.gmail.com>
From:   Doug Anderson <dianders@chromium.org>
Date:   Fri, 21 Oct 2022 08:09:14 -0700
X-Gmail-Original-Message-ID: <CAD=FV=UUGnjb0_c3fwND-E8T5obvQAwu4ws0Q2Mm_gk3=wbvyA@mail.gmail.com>
Message-ID: <CAD=FV=UUGnjb0_c3fwND-E8T5obvQAwu4ws0Q2Mm_gk3=wbvyA@mail.gmail.com>
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
X-Spam-Status: No, score=-2.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Wed, Oct 19, 2022 at 11:22 AM Doug Anderson <dianders@chromium.org> wrote:
>
> Hi,
>
> On Wed, Oct 19, 2022 at 11:18 AM Stephen Boyd <swboyd@chromium.org> wrote:
> >
> > Quoting Douglas Anderson (2022-10-17 12:18:51)
> > > Back in commit 826cff3f7ebb ("drm/bridge: parade-ps8640: Enable
> > > runtime power management") we removed a mysterious 50 ms delay because
> > > "Parade's support [couldn't] explain what the delay [was] for".
> > >
> > > While I'm always a fan of removing mysterious delays, I suspect that
> > > we need this mysterious delay to avoid some problems.
> > >
> > > Specifically, what I found recently is that on sc7180-trogdor-homestar
> > > sometimes the AUX backlight wasn't initializing properly. Some
> > > debugging showed that the drm_dp_dpcd_read() function that the AUX
> > > backlight driver was calling was returning bogus data about 1% of the
> > > time when I booted up. This confused
> > > drm_panel_dp_aux_backlight(). From continued debugging:
> > > - If I retried the read then the read worked just fine.
> > > - If I added a loop to perform the same read that
> > >   drm_panel_dp_aux_backlight() was doing 30 times at bootup I could
> > >   see that some percentage of the time the first read would give bogus
> > >   data but all 29 additional reads would always be fine.
> > > - If I added a large delay _after_ powering on the panel but before
> > >   powering on PS8640 I could still reproduce the problem.
> > > - If I added a delay after PS8640 powered on then I couldn't reproduce
> > >   the problem.
> > > - I couldn't reproduce the problem on a board with the same panel but
> > >   the ti-sn65dsi86 bridge chip.
> > >
> > > To me, the above indicated that there was a problem with PS8640 and
> > > not the panel.
> > >
> > > I don't really have any insight into what's going on in the MCU, but
> > > my best guess is that when the MCU itself sees the HPD go high that it
> > > does some AUX transfers itself and this is confusing things.
> > >
> > > Let's go back and add back in the mysterious 50 ms delay. We only want
> > > to do this the first time we see HPD go high after booting the MCU,
> > > not every time we double-check HPD.
> > >
> > > With this, the backlight initializes reliably on homestar.
> > >
> > > Fixes: 826cff3f7ebb ("drm/bridge: parade-ps8640: Enable runtime power management")
> > > Signed-off-by: Douglas Anderson <dianders@chromium.org>
> > > ---
> >
> > Reviewed-by: Stephen Boyd <swboyd@chromium.org>
>
> I'm not expecting any other reviews of this patch, though I'm happy to
> be proven wrong. As a heads up, I'll plan to land this on Friday
> (roughly 2 days from now) in "drm-misc-fixes" barring anything else.
> If anyone else plans to offer any opinions about this patch or just
> wants more time to review, please shout.

As promised, pushed to drm-misc-fixes:

cb8e30ddb7e3 drm/bridge: ps8640: Add back the 50 ms mystery delay after HPD
