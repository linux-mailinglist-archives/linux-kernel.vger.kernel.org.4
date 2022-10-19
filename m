Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CF07C604F75
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Oct 2022 20:18:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231207AbiJSSS3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Oct 2022 14:18:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230384AbiJSSS0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Oct 2022 14:18:26 -0400
Received: from mail-lj1-x22b.google.com (mail-lj1-x22b.google.com [IPv6:2a00:1450:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B318117A951
        for <linux-kernel@vger.kernel.org>; Wed, 19 Oct 2022 11:18:24 -0700 (PDT)
Received: by mail-lj1-x22b.google.com with SMTP id m23so23254427lji.2
        for <linux-kernel@vger.kernel.org>; Wed, 19 Oct 2022 11:18:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=cc:to:subject:message-id:date:user-agent:from:references
         :in-reply-to:mime-version:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DYmA2npJfXhHXFoKn9kFfgCa71PIgLYjoU3KPYvRPHA=;
        b=kGRprgSUM8lTBlW8zqBWoIwTa5uCiuXkO78/MtHWCgThCp8UbJGApDkGXVMtxq4SIA
         PLHeEkh2/eloOwCwlQh5XkWVwk80krDYZjOHQBv27A7p9OWppE+2GVNww7sqRttyOtxp
         dFrt0Vnon2I5yZ7XbP8lyhX4qVMaVhrGMi3RY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:user-agent:from:references
         :in-reply-to:mime-version:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DYmA2npJfXhHXFoKn9kFfgCa71PIgLYjoU3KPYvRPHA=;
        b=0AbnT3Diz1GBZhIehKoJO4VKCeO+Q+ylUHrmBGfs9l2epg9mUpCIRhxkeopCOx7sin
         mH5Z/UKy2YN54LC/qFa4dvaezocsRPTE1iLBNeYX2zrhMDlplTE7pyQ3rXD0JHoe3IRD
         9+ixL4O85KmOfIjrbJ4WmsD2Ix8Fz+JtNGJkP6Iujew9QuhBK3YE2LLlS5Vi3LFnfnDp
         1E3p8u+0N5m3erokZP1yeQ9Fa3wJB3qLjWHs8RD97i28fPHnH/IeDkhvvh7IeK/fIw85
         VwMaT+QApmLUpneka6rLizsBhB+JsHbs17jdQFYjssu0em+hL2hueMRB5NqiNzCsmpgv
         4hJw==
X-Gm-Message-State: ACrzQf01NYU8Q7uRJTDRZVn8xSLYt2AmKZ/OofgCJiANtCLAkXK0pNov
        crAoIWoiNfQvYOpV9XS8T8HMub14FOID/h6KQHnvAQ==
X-Google-Smtp-Source: AMsMyM4OHbZpFn4TlgBY8PVtEg6nRKnm608OiyAU1q0PQj09/Mu1jAmz9crlKqa1XYSQsQ6jiD+jnNAFTXJZe8lFGw0=
X-Received: by 2002:a05:651c:4d4:b0:271:7c44:fbe5 with SMTP id
 e20-20020a05651c04d400b002717c44fbe5mr1654120lji.39.1666203502862; Wed, 19
 Oct 2022 11:18:22 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 19 Oct 2022 18:18:22 +0000
MIME-Version: 1.0
In-Reply-To: <20221017121813.1.I59700c745fbc31559a5d5c8e2a960279c751dbd5@changeid>
References: <20221017121813.1.I59700c745fbc31559a5d5c8e2a960279c751dbd5@changeid>
From:   Stephen Boyd <swboyd@chromium.org>
User-Agent: alot/0.10
Date:   Wed, 19 Oct 2022 18:18:22 +0000
Message-ID: <CAE-0n51Fdp6hGqWdBy1zgb0XwqQXPveG7tQahP4hjM_Jg9hkYw@mail.gmail.com>
Subject: Re: [PATCH] drm/bridge: ps8640: Add back the 50 ms mystery delay
 after HPD
To:     Douglas Anderson <dianders@chromium.org>,
        dri-devel@lists.freedesktop.org
Cc:     Rock Chiu <rock.chiu@paradetech.corp-partner.google.com>,
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

Quoting Douglas Anderson (2022-10-17 12:18:51)
> Back in commit 826cff3f7ebb ("drm/bridge: parade-ps8640: Enable
> runtime power management") we removed a mysterious 50 ms delay because
> "Parade's support [couldn't] explain what the delay [was] for".
>
> While I'm always a fan of removing mysterious delays, I suspect that
> we need this mysterious delay to avoid some problems.
>
> Specifically, what I found recently is that on sc7180-trogdor-homestar
> sometimes the AUX backlight wasn't initializing properly. Some
> debugging showed that the drm_dp_dpcd_read() function that the AUX
> backlight driver was calling was returning bogus data about 1% of the
> time when I booted up. This confused
> drm_panel_dp_aux_backlight(). From continued debugging:
> - If I retried the read then the read worked just fine.
> - If I added a loop to perform the same read that
>   drm_panel_dp_aux_backlight() was doing 30 times at bootup I could
>   see that some percentage of the time the first read would give bogus
>   data but all 29 additional reads would always be fine.
> - If I added a large delay _after_ powering on the panel but before
>   powering on PS8640 I could still reproduce the problem.
> - If I added a delay after PS8640 powered on then I couldn't reproduce
>   the problem.
> - I couldn't reproduce the problem on a board with the same panel but
>   the ti-sn65dsi86 bridge chip.
>
> To me, the above indicated that there was a problem with PS8640 and
> not the panel.
>
> I don't really have any insight into what's going on in the MCU, but
> my best guess is that when the MCU itself sees the HPD go high that it
> does some AUX transfers itself and this is confusing things.
>
> Let's go back and add back in the mysterious 50 ms delay. We only want
> to do this the first time we see HPD go high after booting the MCU,
> not every time we double-check HPD.
>
> With this, the backlight initializes reliably on homestar.
>
> Fixes: 826cff3f7ebb ("drm/bridge: parade-ps8640: Enable runtime power management")
> Signed-off-by: Douglas Anderson <dianders@chromium.org>
> ---

Reviewed-by: Stephen Boyd <swboyd@chromium.org>
