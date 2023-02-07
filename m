Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 17A6368D094
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Feb 2023 08:28:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229803AbjBGH2v (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Feb 2023 02:28:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229512AbjBGH2s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Feb 2023 02:28:48 -0500
Received: from mail-ua1-x92e.google.com (mail-ua1-x92e.google.com [IPv6:2607:f8b0:4864:20::92e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F22D33443
        for <linux-kernel@vger.kernel.org>; Mon,  6 Feb 2023 23:28:47 -0800 (PST)
Received: by mail-ua1-x92e.google.com with SMTP id l7so971356uao.13
        for <linux-kernel@vger.kernel.org>; Mon, 06 Feb 2023 23:28:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=HzjdoXctNUchxC8lTyeO8JDrtbzbdeV99CaKuJ4JayI=;
        b=VyL6/wHisq/CO8BrIHy/E1ZH+etzFmfEs6Fc0Xn26pS87rXRAGgbjDMCgy1VO9w2LD
         53GSLXS0tjoqspDOrc2sbsMG1jvLGphbz02oHV+YVrY8i9vVqtA+aUZl65UDERtK1jfR
         Wp/CP1B4JQ7BNsIMKRhf8hqg2ERetD+jUVZsY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HzjdoXctNUchxC8lTyeO8JDrtbzbdeV99CaKuJ4JayI=;
        b=HRV6Y7xAq3fCAM+2wGAAPenwSAjQIYD+pazQd2KSA14W+SByZ9/4V1641DRF7LsXJ2
         wVcsAFHrztmkE+05+Zdls5/ywI1OeUgHipjD911ZFy/IRFmGhUEsQ3aBIBQsxXk/nSRF
         vzp1CGV9tzibq78GZCvWLry4ISrn3QFSZLbkjTXN3WnbyWTToE12GSd0spdMT5IFstRB
         9USvjR/dykG0flj25F8hMgXk1FWDbmUdzEum5AMl02Ch3PFOwGYuzBE5ZMX1vma3W/oM
         dNP6KlNu39fuTnLdRqr0dbGsRI096W3JIZH3keLLKbGxKQ0soKXMMlq71CmUXRU2hiYP
         WsiQ==
X-Gm-Message-State: AO0yUKXiPZOsnbXITRNBx0jBCiPN3xI50pvB/Dq2xSpad7BXkRTRD1bR
        oHdU4HuG4QnmDF2PDe6QFwJ2SKPglWp2bi2UMnpoDg==
X-Google-Smtp-Source: AK7set8XFtuxBK35Pvm8tuc5v8uLTzBmZlvege+TNQdg4B3RZkkeRNjUNbCkF5kOjZv0eXvuVKh8HqhvTkURODvoF7g=
X-Received: by 2002:ab0:76c4:0:b0:5f0:4676:e4f1 with SMTP id
 w4-20020ab076c4000000b005f04676e4f1mr433891uaq.44.1675754926331; Mon, 06 Feb
 2023 23:28:46 -0800 (PST)
MIME-Version: 1.0
References: <20230206152928.918562-1-angelogioacchino.delregno@collabora.com> <20230206152928.918562-13-angelogioacchino.delregno@collabora.com>
In-Reply-To: <20230206152928.918562-13-angelogioacchino.delregno@collabora.com>
From:   Chen-Yu Tsai <wenst@chromium.org>
Date:   Tue, 7 Feb 2023 15:28:35 +0800
Message-ID: <CAGXv+5G0+pbgz_6ajWOYNLYMOn4a9+pmPKFngUCrQEtwZe8vVg@mail.gmail.com>
Subject: Re: [PATCH v1 12/45] clk: mediatek: mt8365: Convert to mtk_clk_simple_{probe,remove}()
To:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Cc:     mturquette@baylibre.com, sboyd@kernel.org, matthias.bgg@gmail.com,
        johnson.wang@mediatek.com, miles.chen@mediatek.com,
        chun-jie.chen@mediatek.com, daniel@makrotopia.org,
        fparent@baylibre.com, msp@baylibre.com, nfraprado@collabora.com,
        rex-bc.chen@mediatek.com, zhaojh329@gmail.com,
        sam.shih@mediatek.com, edward-jw.yang@mediatek.com,
        yangyingliang@huawei.com, granquet@baylibre.com,
        pablo.sun@mediatek.com, sean.wang@mediatek.com,
        chen.zhong@mediatek.com, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 6, 2023 at 11:30 PM AngeloGioacchino Del Regno
<angelogioacchino.delregno@collabora.com> wrote:
>
> Change the custom mt8365_simple_gate to be mtk_gate clocks and
> audio clocks to be composites to be consistent with all of the
> other MediaTek clock drivers, allowing to convert this entire
> driver to use the common mtk_clk_simple_probe() mechanism that
> also allows building this driver as module.

I think this would be easier to follow if it were split in half:
the first half migrating mt8365_simple_gate to mtk_gate, and the
second half converting to mtk_clk_simple_probe.

I assume git would generate better diffs after that.

> While at it, also perform some macro compression cleanups and
> switch to use module_platform_driver().

This would get split in half as well. The macro cleanups go with the
first half, and the switch to module_platform_driver goes with the
second.

> Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
> ---
>  drivers/clk/mediatek/clk-mt8365.c | 460 ++++++++----------------------
>  1 file changed, 124 insertions(+), 336 deletions(-)
>
> diff --git a/drivers/clk/mediatek/clk-mt8365.c b/drivers/clk/mediatek/clk-mt8365.c
> index 69f293497778..4bd624884b62 100644
> --- a/drivers/clk/mediatek/clk-mt8365.c
> +++ b/drivers/clk/mediatek/clk-mt8365.c
> @@ -1,6 +1,7 @@
>  // SPDX-License-Identifier: GPL-2.0
>  /*
>   * Copyright (C) 2022 MediaTek Inc.
> + * Copyright (C) 2023 Collabora Ltd.
>   */
>
>  #include <dt-bindings/clock/mediatek,mt8365-clk.h>
> @@ -17,7 +18,6 @@
>  #include "clk-gate.h"
>  #include "clk-mtk.h"
>  #include "clk-mux.h"
> -#include "clk-pll.h"

This should be in the previous patch?

Could you also remove some of the other inclusions that don't get
referenced after this patch?

>  static DEFINE_SPINLOCK(mt8365_clk_lock);
>
> @@ -383,31 +383,23 @@ static const char * const mbist_diag_parents[] = {
>         "univpll2_d8"
>  };
>
> -static const char * const apll_i2s0_parents[] = {
> +static const char * const apll_i2s_parents[] = {

Misc. unmentioned change. It makes sense, but please mention it.

ChenYu
