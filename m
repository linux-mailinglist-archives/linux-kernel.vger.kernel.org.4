Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 128FE6EC6EA
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Apr 2023 09:21:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229941AbjDXHVB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Apr 2023 03:21:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230020AbjDXHU6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Apr 2023 03:20:58 -0400
Received: from mail-vk1-xa33.google.com (mail-vk1-xa33.google.com [IPv6:2607:f8b0:4864:20::a33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF48C2729
        for <linux-kernel@vger.kernel.org>; Mon, 24 Apr 2023 00:20:32 -0700 (PDT)
Received: by mail-vk1-xa33.google.com with SMTP id 71dfb90a1353d-441134c09cdso2871630e0c.0
        for <linux-kernel@vger.kernel.org>; Mon, 24 Apr 2023 00:20:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1682320832; x=1684912832;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=InRVR5tViOC9ShtIBT4ewDyQe/oRbEDimCDKVkObJco=;
        b=GH2STlEFktHM2bkMFI1q6ADmk9pyiHflx3473RYpy5DlEJA+9Re+2Fj76zdfR24ljy
         rr+Zz18yIbv59TCnqcl0Ak8PrPTO8JbKuMxizV6GkylJ8F79Wc4SC157k2cCQbFRtfBK
         prSycLhVOXqitti6e6Mys2T1CXOu0lYMLpnCk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682320832; x=1684912832;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=InRVR5tViOC9ShtIBT4ewDyQe/oRbEDimCDKVkObJco=;
        b=jrdovJXh7hcHFUON97Lf/qM/QbHKTizpsInW/SmZ+HHHMPqas2Gzuu06Ax38zilf8M
         DeHfg0kv9gO9jzV6a9v0uLqXyyVvSkf2fzpq2gcR96KFvuohXFhk2bpbG4ZqzNVCcTEL
         FCC2ftPmKjoFaeggMnpRr5pw2eqLhCViGrFIkro2EfevOA0dQn0VhrfWlKIkCx2vUrBS
         2peixIb3jDZUP2R2wUYSn+a9F6CS8eSuH9meibbcygl9nGCt7u/X7+9yCmljpaVumCO7
         JXGvivjX2GFkPZeZne5iOYC0UQwWf9EKYD/nZjBOJ9KBvATXR4q5U/LiYun+UtaCL7gH
         lXuw==
X-Gm-Message-State: AAQBX9ehPt/aWhmWe3EFiEaFdCFlFMP1hfJfAllgTwG53+kF2Gscf14i
        bajJMYGTlgWLnAMxDCJdnip8ot9Hi/AAPNWMq0GwWQ==
X-Google-Smtp-Source: AKy350YuctfBKriko29k+cGfbV+w1OLRc1OuTx3Hk0RuY+HlIwk3Pv/0iPX9qpxRnYDkWfQIietUJK3kZuZPFQzYRfQ=
X-Received: by 2002:a1f:3f53:0:b0:43f:fc32:15f0 with SMTP id
 m80-20020a1f3f53000000b0043ffc3215f0mr3519433vka.14.1682320831928; Mon, 24
 Apr 2023 00:20:31 -0700 (PDT)
MIME-Version: 1.0
References: <20230423121232.1345909-1-aford173@gmail.com>
In-Reply-To: <20230423121232.1345909-1-aford173@gmail.com>
From:   Chen-Yu Tsai <wenst@chromium.org>
Date:   Mon, 24 Apr 2023 15:20:20 +0800
Message-ID: <CAGXv+5EqdFb1hgQ0uP=hmPDrAH_enp39PSUxmQ6WDZ+0h-vd6w@mail.gmail.com>
Subject: Re: [PATCH V2 0/6] drm: bridge: samsung-dsim: Support variable clocking
To:     Adam Ford <aford173@gmail.com>
Cc:     dri-devel@lists.freedesktop.org,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Robert Foss <rfoss@kernel.org>,
        Jonas Karlman <jonas@kwiboo.se>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        aford@beaconembedded.com,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Frieder Schrempf <frieder.schrempf@kontron.de>,
        Jagan Teki <jagan@amarulasolutions.com>,
        Andrzej Hajda <andrzej.hajda@intel.com>,
        m.szyprowski@samsung.com, dario.binacchi@amarulasolutions.com,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Apr 23, 2023 at 8:12=E2=80=AFPM Adam Ford <aford173@gmail.com> wrot=
e:
>
> This series fixes the blanking pack size and the PMS calculation.  It the=
n
> adds support to allows the DSIM to dynamically DPHY clocks, and support
> non-burst mode while allowing the removal of the hard-coded clock values
> for the PLL for imx8m mini/nano/plus, and it allows the removal of the
> burst-clock device tree entry when burst-mode isn't supported by connecte=
d
> devices like an HDMI brige.  In that event, the HS clock is set to the va=
lue
> requested by the bridge chip.
>
> This has been tested on both an i.MX8M Nano and i.MX8M Plus, and should w=
ork
> on i.MX8M Mini as well.
>
>
> Adam Ford (5):
>   drm: bridge: samsung-dsim: Fix PMS Calculator on imx8m[mnp]
>   drm: bridge: samsung-dsim: Fetch pll-clock-frequency automatically
>   drm: bridge: samsung-dsim: Dynamically configure DPHY timing
>   drm: bridge: samsung-dsim: Support non-burst mode
>   drm: bridge: samsung-dsim: Let blanking calcuation work in non-burst
>     mode
>
> Lucas Stach (1):
>   drm: bridge: samsung-dsim: fix blanking packet size calculation

This makes the micro-HDMI port on my Hummingboard Pulse (w/ i.MX8M Mini SOM=
)
work properly, so the whole series is

Tested-by: Chen-Yu Tsai <wenst@chromium.org>

Thanks!
