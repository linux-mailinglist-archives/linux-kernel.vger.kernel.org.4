Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7823E69A4F9
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Feb 2023 06:02:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229585AbjBQFCY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Feb 2023 00:02:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229554AbjBQFCW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Feb 2023 00:02:22 -0500
Received: from mail-vs1-xe2b.google.com (mail-vs1-xe2b.google.com [IPv6:2607:f8b0:4864:20::e2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 227605A3AA
        for <linux-kernel@vger.kernel.org>; Thu, 16 Feb 2023 21:02:21 -0800 (PST)
Received: by mail-vs1-xe2b.google.com with SMTP id k6so4419977vsk.1
        for <linux-kernel@vger.kernel.org>; Thu, 16 Feb 2023 21:02:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=i/LoJUyP6LIWBGDbBIfrVpo/ZcUi8rR5q545T8LMRsM=;
        b=QW9jmwdqQetQtJ4m+DAPg2UMM3M8eQrqOiUf2cFhGvdmRC1Q8IVxeWd3vvYTVM4Kg7
         4NG7rEiSnVe0bmqG1eg/qDu59Zl2rDcdmyFtTec1Amp2ZFCV1gA7bSSVafcsJiA00Plv
         FkF6BK54sGad4++sAH5L/X8W79Kx7/gg1Bmsc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=i/LoJUyP6LIWBGDbBIfrVpo/ZcUi8rR5q545T8LMRsM=;
        b=XxGKA0f/hTEH/wun6ZCWequmcZY39u7Dc42QF2RdhrXC5p+jvXenxdg+EBQVmcrKbP
         uCIMmElB3oLLosbrRlGVDisjHnfgf/pDeN5U+bGm162odSURpM01/tsYDekO3QlFuNbW
         Wt9yM5HdTybJynPK2x5TAWeIfsAXVQ969kIDmoK6C+347Xckohsj9IjM0aVl/yA1hTLu
         G5j8dhcCl3Fmlr1OHvYiDiWdfQFL5iv2e73/1MDdXBuFX9Yt1c2rznXDZ5Ng8AqvV0Wx
         lodxJCBZ1IqTg2yVpejeW8EwBu0Ell8bu/OBrCvYwTY/tVKP2/FdY/pdM3RopIgKuWGn
         TWWw==
X-Gm-Message-State: AO0yUKXpIo+gjev6NcO8maA1v+aXTQhZ3mCGcccFzbXjaXZzt/MWOoNS
        GD7fc1mFnfmTHuTrdMCAZgUozdqsx5IcCEb6SOJM7Q==
X-Google-Smtp-Source: AK7set++VQifD1GEuW1izZhS6MZDE6Ea7vwpiMNICqDrdAHn1j+yeN310Pi4k4OdPcpmKFqoprypxB/1QcYFV1t/SH4=
X-Received: by 2002:a67:f749:0:b0:3fc:58d:f90f with SMTP id
 w9-20020a67f749000000b003fc058df90fmr1542797vso.60.1676610140223; Thu, 16 Feb
 2023 21:02:20 -0800 (PST)
MIME-Version: 1.0
References: <20230214134127.59273-1-angelogioacchino.delregno@collabora.com>
 <20230214134127.59273-40-angelogioacchino.delregno@collabora.com> <CAGXv+5FtWp8BvLHJmJvXe=eXvM10-LTjQo9PkH1xKMvzY6YiHA@mail.gmail.com>
In-Reply-To: <CAGXv+5FtWp8BvLHJmJvXe=eXvM10-LTjQo9PkH1xKMvzY6YiHA@mail.gmail.com>
From:   Chen-Yu Tsai <wenst@chromium.org>
Date:   Fri, 17 Feb 2023 13:02:08 +0800
Message-ID: <CAGXv+5Hs+dB0dN6tCmLdQX+srcAzavk39fis0hMjf0ZC6UqX1w@mail.gmail.com>
Subject: Re: [PATCH v2 39/47] clk: mediatek: Allow MT7622 clocks to be built
 as modules
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
        linux-mediatek@lists.infradead.org, kernel@collabora.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 17, 2023 at 12:32 PM Chen-Yu Tsai <wenst@chromium.org> wrote:
>
> On Tue, Feb 14, 2023 at 9:42 PM AngeloGioacchino Del Regno
> <angelogioacchino.delregno@collabora.com> wrote:
> >
> > Now that all drivers are using the simple probe mechanism change the
> > MT7622 clock drivers to tristate in Kconfig to allow module build.
> >
> > Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
> > ---
> >  drivers/clk/mediatek/Kconfig | 8 ++++----
> >  1 file changed, 4 insertions(+), 4 deletions(-)
> >
> > diff --git a/drivers/clk/mediatek/Kconfig b/drivers/clk/mediatek/Kconfig
> > index b5636b3225e8..55727889ebf5 100644
> > --- a/drivers/clk/mediatek/Kconfig
> > +++ b/drivers/clk/mediatek/Kconfig
> > @@ -336,7 +336,7 @@ config COMMON_CLK_MT6797_VENCSYS
> >           This driver supports MediaTek MT6797 vencsys clocks.
> >
> >  config COMMON_CLK_MT7622
> > -       bool "Clock driver for MediaTek MT7622"
> > +       tristate "Clock driver for MediaTek MT7622"
>
> Same as MT2712, mt7622-apmixedsys is builtin_platform_driver.

I figured it out, so

Reviewed-by: Chen-Yu Tsai <wenst@chromium.org>
