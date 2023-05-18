Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F8B3708075
	for <lists+linux-kernel@lfdr.de>; Thu, 18 May 2023 13:52:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230419AbjERLwt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 May 2023 07:52:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230255AbjERLwr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 May 2023 07:52:47 -0400
Received: from mail-yb1-xb31.google.com (mail-yb1-xb31.google.com [IPv6:2607:f8b0:4864:20::b31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3592C0
        for <linux-kernel@vger.kernel.org>; Thu, 18 May 2023 04:52:38 -0700 (PDT)
Received: by mail-yb1-xb31.google.com with SMTP id 3f1490d57ef6-ba827a34ba8so2745855276.0
        for <linux-kernel@vger.kernel.org>; Thu, 18 May 2023 04:52:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google; t=1684410758; x=1687002758;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mBVrcck5s6OuGtzh+rhmsWfcN2VuaI9gIbet+WEeIh0=;
        b=IBDQjG8w9HEylhywOl9vA5UIZfMIJ+hgwPjUGH9uO2EPPc35MaAWOzPXbLXGzuGgF5
         rnmZ/vwuvY9uQanydicMziFTcVFah8uNnePp6rPNZxtDUGKcGoQbrFF5qXACHrR37bHc
         dF4lF06QhJ95zo/CznbKZS48Iv+Fh7kS3DbhI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684410758; x=1687002758;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mBVrcck5s6OuGtzh+rhmsWfcN2VuaI9gIbet+WEeIh0=;
        b=GlSL2cXELCo0Kka2j6S8Gg3jbP+ncny7pcqA4uhhJqmeMgwx2eUOJA1+L6WBNQWrIw
         +VKXkObJQdDrbwinzetk7BjkCiwLl9zLzwtH1qNQzSeKg45IqcaqcHTXwm0QW5/PnkqV
         RBQPev3udILzi+3y3BTLaTEQf9fL54+yoq3eeb1ZRwUnhXOeu55YOt+0akP/ZzrfhjYl
         9HzL31gIKhKtQd00PbM73/BXMktkfF0hhODqTNH0ibUbPodVvF6o6TxXXkGek4Be0Ska
         rDEkVXZcE7O0qu1zs6qZA5RKDFvK3+NhVPlsDcv/J8frUmPtrebGjdSE6m+1bpkgYpGp
         D2xg==
X-Gm-Message-State: AC+VfDy970PdTbZyvYQCTjxOUj9MNevIAhonT8n5sbeRcR0MKg59Nf2X
        fg4gyhgEg+Bcgghc0sWZjsQWW6azXzlvEAMOMkbOOg==
X-Google-Smtp-Source: ACHHUZ548aNPyGdZgjeLL3XrPR2B6YAlN0Zu3cNB03mO7YKE5/94BhuZByCCpE5y5jDki39KJwQtDgcCv5qSvsFrCfs=
X-Received: by 2002:a25:e70f:0:b0:b9e:3bea:ebd2 with SMTP id
 e15-20020a25e70f000000b00b9e3beaebd2mr944887ybh.31.1684410758177; Thu, 18 May
 2023 04:52:38 -0700 (PDT)
MIME-Version: 1.0
References: <20230515235713.232939-1-aford173@gmail.com> <20230515235713.232939-3-aford173@gmail.com>
In-Reply-To: <20230515235713.232939-3-aford173@gmail.com>
From:   Jagan Teki <jagan@amarulasolutions.com>
Date:   Thu, 18 May 2023 17:22:26 +0530
Message-ID: <CAMty3ZB9xrO+LPGVCcoDfdWo9CP_DLVhaKm33y768+ix6nP7cQ@mail.gmail.com>
Subject: Re: [PATCH V6 2/6] drm: bridge: samsung-dsim: Fix PMS Calculator on imx8m[mnp]
To:     Adam Ford <aford173@gmail.com>
Cc:     dri-devel@lists.freedesktop.org, aford@beaconembedded.com,
        Lucas Stach <l.stach@pengutronix.de>,
        Chen-Yu Tsai <wenst@chromium.org>,
        Frieder Schrempf <frieder.schrempf@kontron.de>,
        Andrzej Hajda <andrzej.hajda@intel.com>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Robert Foss <rfoss@kernel.org>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Inki Dae <inki.dae@samsung.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Marek Vasut <marex@denx.de>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 16, 2023 at 5:27=E2=80=AFAM Adam Ford <aford173@gmail.com> wrot=
e:
>
> According to Table 13-45 of the i.MX8M Mini Reference Manual, the min
> and max values for M and the frequency range for the VCO_out
> calculator were incorrect.  This information was contradicted in other
> parts of the mini, nano and plus manuals.  After reaching out to my
> NXP Rep, when confronting him about discrepencies in the Nano manual,
> he responded with:
>  "Yes it is definitely wrong, the one that is part
>   of the NOTE in MIPI_DPHY_M_PLLPMS register table against PMS_P,
>   PMS_M and PMS_S is not correct. I will report this to Doc team,
>   the one customer should be take into account is the Table 13-40
>   DPHY PLL Parameters and the Note above."
>
> These updated values also match what is used in the NXP downstream
> kernel.
>
> To fix this, make new variables to hold the min and max values of m
> and the minimum value of VCO_out, and update the PMS calculator to
> use these new variables instead of using hard-coded values to keep
> the backwards compatibility with other parts using this driver.
>
> Fixes: 4d562c70c4dc ("drm: bridge: samsung-dsim: Add i.MX8M Mini/Nano sup=
port")
> Signed-off-by: Adam Ford <aford173@gmail.com>
> Reviewed-by: Lucas Stach <l.stach@pengutronix.de>
> Tested-by: Chen-Yu Tsai <wenst@chromium.org>
> Tested-by: Frieder Schrempf <frieder.schrempf@kontron.de>
> Reviewed-by: Frieder Schrempf <frieder.schrempf@kontron.de>
> ---

Reviewed-by: Jagan Teki <jagan@amarulasolutions.com>
Tested-by: Jagan Teki <jagan@amarulasolutions.com> # imx8mm-icore
