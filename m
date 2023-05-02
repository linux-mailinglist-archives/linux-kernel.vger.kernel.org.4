Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 033596F3F21
	for <lists+linux-kernel@lfdr.de>; Tue,  2 May 2023 10:32:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233018AbjEBIcR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 May 2023 04:32:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233158AbjEBIcP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 May 2023 04:32:15 -0400
Received: from mail-vk1-xa2e.google.com (mail-vk1-xa2e.google.com [IPv6:2607:f8b0:4864:20::a2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F19A1708
        for <linux-kernel@vger.kernel.org>; Tue,  2 May 2023 01:32:13 -0700 (PDT)
Received: by mail-vk1-xa2e.google.com with SMTP id 71dfb90a1353d-440403d34a4so1142502e0c.0
        for <linux-kernel@vger.kernel.org>; Tue, 02 May 2023 01:32:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1683016332; x=1685608332;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BWWyc2tyY3cwMkEDQu1WnxOmxyqSb2T1IrD/g9kPDzA=;
        b=m4zzl8uYhRR6saMsdg3HPWejhXX3EOg4vViRVqma5993YCVSIQZjduQGi72S0WJ5sd
         4WTFkG1sbxGBAgm2SZhve6R/MSf9A0gKtyLGB4fb+6O0NQ2nUUwt1ms2ST/2/ysxlLnG
         6L5OvsE45iAWgObykhNpbpj8GzaTj7PtGKND0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683016332; x=1685608332;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BWWyc2tyY3cwMkEDQu1WnxOmxyqSb2T1IrD/g9kPDzA=;
        b=TzUgUxWD6M79zbYMyuhqNStfyzRONdEYBxHom6zuX2C9CrXWIQQQAHnEBgqAxVIyMo
         EkQrs/OxtubIbjS1/Mw2UAVBy+t0Ht3VZLsKOUOCUEPknK0SXbxYdQXK+k8mPR4IutFS
         bO7iJehocM3dxKpJTYIU/X9jo7DSTziOZYpdnMzfBM3kENhgABZGjm5/c587h/Lp/xYR
         fMLfUe9ickiwtgm66curjMBZBRThj+5K8BQo5M50NAIzLOAjvEwRwNd2F0nbnAHjAt2H
         8uk7vWvZEnkYEbwH3EmEfZFaXyAhmOJl/O3TgwOVRw1exIdzNR2Xp6RL8G992OvqpMwq
         k9JA==
X-Gm-Message-State: AC+VfDwC1v7arGJ/OA3kmszFsyhiHdqV38Pl8IhPhUCCYSifzrTDel3o
        uqtlz7j7fpkq1zZFcMEaQY8lr3i/qOtGDpcobNtajA==
X-Google-Smtp-Source: ACHHUZ5UDSO2uA/JaGBLjILILIaC8pFpNUUBWNxuhSKBA+IGQzD9k10JlpYY4wrx63nUb6DgXoNMZwzlQMBcV/ZzgsQ=
X-Received: by 2002:a1f:450a:0:b0:44b:2450:e4c8 with SMTP id
 s10-20020a1f450a000000b0044b2450e4c8mr5604804vka.9.1683016332576; Tue, 02 May
 2023 01:32:12 -0700 (PDT)
MIME-Version: 1.0
References: <20230502010759.17282-1-aford173@gmail.com>
In-Reply-To: <20230502010759.17282-1-aford173@gmail.com>
From:   Chen-Yu Tsai <wenst@chromium.org>
Date:   Tue, 2 May 2023 16:32:01 +0800
Message-ID: <CAGXv+5E00dGDjVz=XNc=bGLsxisA=ShrqESQZLg+MsN-xKe5qQ@mail.gmail.com>
Subject: Re: [PATCH V3 0/7] drm: bridge: samsung-dsim: Support variable clocking
To:     Adam Ford <aford173@gmail.com>
Cc:     dri-devel@lists.freedesktop.org, marex@denx.de,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Robert Foss <rfoss@kernel.org>,
        Jonas Karlman <jonas@kwiboo.se>, aford@beaconembedded.com,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        linux-kernel@vger.kernel.org,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Andrzej Hajda <andrzej.hajda@intel.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Jagan Teki <jagan@amarulasolutions.com>
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

On Tue, May 2, 2023 at 9:08=E2=80=AFAM Adam Ford <aford173@gmail.com> wrote=
:
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
> Adam Ford (6):
>   drm: bridge: samsung-dsim: Fix PMS Calculator on imx8m[mnp]
>   drm: bridge: samsung-dsim: Fetch pll-clock-frequency automatically
>   drm: bridge: samsung-dsim: Select GENERIC_PHY_MIPI_DPHY
>   drm: bridge: samsung-dsim: Dynamically configure DPHY timing
>   drm: bridge: samsung-dsim: Support non-burst mode
>   drm: bridge: samsung-dsim: Let blanking calcuation work in non-burst
>     mode
>
> Lucas Stach (1):
>   drm: bridge: samsung-dsim: fix blanking packet size calculation

Still works, so whole series is

Tested-by: Chen-Yu Tsai <wenst@chromium.org>

on i.MX8M Mini based Hummingboard Pulse.
