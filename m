Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA5EC6B6AA5
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Mar 2023 20:29:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230187AbjCLT27 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Mar 2023 15:28:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229671AbjCLT26 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Mar 2023 15:28:58 -0400
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 114002FCEE
        for <linux-kernel@vger.kernel.org>; Sun, 12 Mar 2023 12:28:57 -0700 (PDT)
Received: by mail-pj1-x1030.google.com with SMTP id o4so2886400pjq.4
        for <linux-kernel@vger.kernel.org>; Sun, 12 Mar 2023 12:28:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678649336;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=qfhIXoQOHQJr+gGO2qxo4oT4JoKm/10nWr5b3EbxW40=;
        b=Izm1xtXUrM5ET2LFvnd9qHyz2wuer8S4f0kqpsoe6aV2R7hdUbRk4Y5j4/bbOgGI+z
         RvIbIb9Z697jvIbHAC5lHHo1P3s0GpO9h14HyRwX3Hp9AMJZsxF/9kMozJ0irjgwKf6v
         M99Lkn004juVqxQRx6Rhh6p5BaSvxIVHHOHZshP/uc6XPc0BzF6qNpJgDnAp3B+5FDHZ
         zbgiApcjam4s+U1La0LbTdLOoWnWHFGKZhCyY8VhgaeoPv2U7tsudi1EKEgC1+XMpipV
         p0rgqf19aHsK3J1VeIAWukvmSicd3ga8IcQ6CqIidw1OgZX4XXNOGG1HxuQEq/PAXm2B
         1u5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678649336;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=qfhIXoQOHQJr+gGO2qxo4oT4JoKm/10nWr5b3EbxW40=;
        b=GZJKi+KHmYrXf/6cCK3Um9IXdvLsZDnbMtNcb+iOjeEGk/lIa5pZxaf5eQ50Ua8A0L
         lL1Rq6i4pZkzFAvZ55fA8cXZxSWQQgGe4PeIvcFlgZ/gVlUckNJSYyhWMMDfYkDlaLVC
         JVSLGygw97gYUMv4cf1zUgUvBbrMq86/d1twYWenXgZnLbBglxR0fT5Aobl0ToMnJf3Z
         mbYfne0Zb2EsUBJ3dSEgJVmQ0l5yahUCjgT2GjnBI55DzUMBqsI0jrHpsol7viYfswWi
         29d2PjaJDk6uyh3thatnqR/XWcsAriSROX5baV1Ou6EerSWPye/AOziUhGFQ93t827tP
         GFGw==
X-Gm-Message-State: AO0yUKWhRA0D2/2OMELYp+sYuzjpjswpqrSGx2wTH2x6D8BoTnGhCSOi
        u6d40qCu+tDD4jIz3MZWTjEpxN1dHLpDQnM6jD0yyjKhT1Y=
X-Google-Smtp-Source: AK7set+Ujk1wsgXpvSnRx5mIG+1Ilcjk1Xpo2ZGuCMkVBMpDf41SDnjqHHM8VTZ1TpnWOY3pZu/dWNZX8KpyGOJclvY=
X-Received: by 2002:a17:903:710:b0:19f:30be:e9f6 with SMTP id
 kk16-20020a170903071000b0019f30bee9f6mr1424089plb.6.1678649336371; Sun, 12
 Mar 2023 12:28:56 -0700 (PDT)
MIME-Version: 1.0
From:   Adam Ford <aford173@gmail.com>
Date:   Sun, 12 Mar 2023 14:28:45 -0500
Message-ID: <CAHCN7xJXMmwYqD=Eb2=_vJw390KAd6NgkWCpq6yCbAyaJ3xK5A@mail.gmail.com>
Subject: MXSFB and Video PLL clock on i.MX8M Mini/Nano Question
To:     arm-soc <linux-arm-kernel@lists.infradead.org>
Cc:     Marek Vasut <marex@denx.de>, Stefan Agner <stefan@agner.ch>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Jagan Teki <jagan@amarulasolutions.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I am trying to work through a series that was submitted for enabling
the DSI on the i.MX8M Mini and Nano.  I have extended this series to
route the DSI to an HDMI bridge, and I am able to get several
resolutions to properly sync on my monitor.  However, there are also a
 bunch that appear on the list when I run modetest that do not sync on
my monitor.

When running some debug code, it appears that it's related to the
clocking of the MXSFB driver.

From what I can tell, the MSXFB driver attempts to set the clock based
on the desired resolution and refresh rate.  When the default
VIDEO_PLL clock is set to 594MHz, many of the resolutions that cleanly
divide from the 594MHz clock appear to sync with my monitor.  However,
in order to get other resolutions to appear, I have to manually change
the device tree to set VIDEO_PLL to a different clock rate so MSXFB
can use it.  Unfortunately, that breaks the resolutions that used to
work.

I threw together a hack into the MXSFB driver which adds a new
optional clock to the MSXFB driver.  When I pass VIDEO_PLL to this
driver, it can automatically set the clock rate to match that of
whatever the desired clock is, and I can get many more resolutions to
appear.
Another advantage of this is that the Video_PLL can be the minimum
speed needed for a given rate instead of setting a higher rate, then
dividing it down.

I wasn't sure if that would be the best way to approach this, or if
someone had a better suggestion.

If this is the best approach, I can try to clean up my patch and
submit it to the mailing list for review.

thanks,

adam
