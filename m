Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 97AF46712CB
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Jan 2023 05:50:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229525AbjAREul (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Jan 2023 23:50:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbjAREug (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jan 2023 23:50:36 -0500
Received: from mail-lj1-x236.google.com (mail-lj1-x236.google.com [IPv6:2a00:1450:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2AC54E536
        for <linux-kernel@vger.kernel.org>; Tue, 17 Jan 2023 20:50:34 -0800 (PST)
Received: by mail-lj1-x236.google.com with SMTP id s25so35397067lji.2
        for <linux-kernel@vger.kernel.org>; Tue, 17 Jan 2023 20:50:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=content-transfer-encoding:cc:to:subject:message-id:date:user-agent
         :from:references:in-reply-to:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mxHmCLyxCtxqovft70l3YWZ7M9nPAwuaYmzKmP5Vdk8=;
        b=QHN9KuLNwUOEpAQz7/9/npcURu9nh3xi4LJG8DdLa3vO3LQMZdIxS+2rNCBviCh3oA
         bBD7qjE1rLw3m/tVpdzEqpdHYfx9xcVyvpnGDYHzb28AWUwtQHhqtULHg+i86JB0uOmY
         mCH1MaCVxU+yaR0WqvnG3OE8OYw+4tQjE2DIk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:user-agent
         :from:references:in-reply-to:mime-version:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=mxHmCLyxCtxqovft70l3YWZ7M9nPAwuaYmzKmP5Vdk8=;
        b=ZjEzDWssIHzN/gbgdWVHBfCs9aaZKOXFBhmoTyfMIIImVJaLc0MMRtEVyeYHT8XrN+
         ikCd8NoOG5b/K/mJ1quaJ27GhoRbql9V3VnNkYnxoHgpkCuYKmLD6zuITYC9Mv0zjjM1
         fURZsZHGg+OLjFLY++sbeKaasSvtTytnKhMln5UcTzF0QYMttC1QsKCLlnAhFj/xIvZK
         O7c/sMr+Dn/NqQ31Q/cZiUWOjbOwOhrG3BDOUQJML5N5EY8McgR6LCew2+H80Dgcksly
         XvLD/LruJE5k1SBU3IoslBorZhyZUllhY8K1LGnbuAi/BTTjLtwb2DMVtgZGXO0XcbAF
         GY3A==
X-Gm-Message-State: AFqh2ko0G9GIq6uwDMWCdaQeCuSRKZdy7I1XhW9WzWQx8dmp7aNvaTdf
        UehRbS+dMqdh+YuPo711Y70dpcysc/O5nooh/b4iTmg3pA8Nqg==
X-Google-Smtp-Source: AMrXdXs1wB3tC8P9IFtpxqdvJAiuejEDy4DNJkFrxMFxuFOT6senstkO3M6au8sdTnY8QF0yYjtgWQ2Ygcu8p6F9+3o=
X-Received: by 2002:a2e:a49a:0:b0:28b:6abf:29ea with SMTP id
 h26-20020a2ea49a000000b0028b6abf29eamr496414lji.359.1674017433221; Tue, 17
 Jan 2023 20:50:33 -0800 (PST)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 17 Jan 2023 20:50:32 -0800
MIME-Version: 1.0
In-Reply-To: <CAPY8ntCcHG2A7LHT-jVa9SzvPggxBP8z-t_3rEy+YY8UVHNL9A@mail.gmail.com>
References: <20230106030108.2542081-1-swboyd@chromium.org> <CAPY8ntA=Dq6GFQ3gEOm9PzPyOa9bHTr8JrpXLibnai7xKqRbpQ@mail.gmail.com>
 <CAE-0n53UFuyYvjJUWViXy9Eex2mpBRJGtt4vGc2cbFZS9i8xFw@mail.gmail.com> <CAPY8ntCcHG2A7LHT-jVa9SzvPggxBP8z-t_3rEy+YY8UVHNL9A@mail.gmail.com>
From:   Stephen Boyd <swboyd@chromium.org>
User-Agent: alot/0.10
Date:   Tue, 17 Jan 2023 20:50:32 -0800
Message-ID: <CAE-0n52fLBLG2dkCe7376TrfoGLcVrYTHYnULNvnbVEZAT-CNw@mail.gmail.com>
Subject: Re: [PATCH] drm/panel: boe-tv101wum-nl6: Ensure DSI writes succeed
 during disable
To:     Dave Stevenson <dave.stevenson@raspberrypi.com>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Rob Clark <robdclark@chromium.org>,
        Douglas Anderson <dianders@chromium.org>,
        Jitao Shi <jitao.shi@mediatek.com>,
        yangcong <yangcong5@huaqin.corp-partner.google.com>,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        patches@lists.linux.dev, linux-mediatek@lists.infradead.org,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Sam Ravnborg <sam@ravnborg.org>,
        linux-arm-kernel@lists.infradead.org
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

Quoting Dave Stevenson (2023-01-16 06:11:02)
> Hi Stephen
>
> On Fri, 13 Jan 2023 at 21:12, Stephen Boyd <swboyd@chromium.org> wrote:
> >
> >
> > Thanks for the info! It says "Drivers that need the underlying device t=
o
> > be powered to perform these operations will first need to make sure it=
=E2=80=99s
> > been properly enabled." Does that mean the panel driver needs to make
> > sure the underlying dsi host device is powered? The sentence is too
> > ambiguous for me to understand what 'drivers' and 'underlying device'
> > are.
>
> The DSI host driver (ie in your case something under
> drivers/gpu/drm/msm/dsi) should ensure that a transfer can be made,
> regardless of state.
>
> I must say that this has been documented as the case, but doesn't
> necessarily reflect reality in a number of drivers.

Alright, thanks for the clarification.

> >
> > Cool. Glad that we can clean that up with your series.
> >
> > Is it wrong to split unprepare to a disable and unprepare phase? I'm no=
t
> > super keen on fixing 6.1 stable kernels by opting this driver into the
> > ordering change. Splitting the phase into two is small and simple and
> > works. I suspect changing the ordering may uncover more bugs, or be a
> > larger task. I'd be glad to test that series[2] from you to get rid of
> > [3].
>
> Ah, I hadn't realised it was a regression in a released kernel :(
>
> Splitting into a disable and unprepare is totally fine. Normally
> disable would normally disable the panel and backlight (probably by
> drm_panel before the panel disable call), with unprepare disabling
> power and clocks
>
> Do note that AIUI you will be telling the panel to enter sleep mode
> whilst video is still being transmitted. That should be safe as the
> panel has to still be partially active to handle an exit sleep mode
> command, but actually powering hardware down at that point could cause
> DSI bus arbitration errors as clock or data lanes could be pulled down
> when the host is trying to adopt HS or LP11.
>

Ok. I don't think I'm running into that issue, but I have run into a
different issue. I tried to split the prepare phase into enable and
prepare with the DSI writes in the enable to make things symmetric but
that totally failed. Now I get lots of timeouts when enabling the panel.

This patch is still the best fix I have. Maybe with your series we can
combine the unprepare and disable ops together again (i.e. revert this)
so that power is removed immediately after sending the DSI commands?  Or
is that not enough to avoid the DSI bus arbitration problems you're
talking about? When is the host adopting HS or LP11 with regards to the
bridge ops?
