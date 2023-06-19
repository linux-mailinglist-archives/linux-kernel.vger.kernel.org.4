Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F3FFA735B2F
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Jun 2023 17:33:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231791AbjFSPd3 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Mon, 19 Jun 2023 11:33:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229519AbjFSPd0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Jun 2023 11:33:26 -0400
Received: from mail-oo1-f51.google.com (mail-oo1-f51.google.com [209.85.161.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A414C9;
        Mon, 19 Jun 2023 08:33:24 -0700 (PDT)
Received: by mail-oo1-f51.google.com with SMTP id 006d021491bc7-55e299e1d02so1653080eaf.1;
        Mon, 19 Jun 2023 08:33:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687188803; x=1689780803;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :reply-to:in-reply-to:references:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=xPFXYlRHAa3U0GY2gSsZaKSWcpvM3hRa94CDc3700HE=;
        b=jJOMLhe+cAskWXv4MeJvC6VKNfelpLHNcSNqSD47TEjxZI7vgD0gWlbjWzR1qPG/k9
         GnUpXeA+qE1sHHH+tn05s7MZTHvRGkSebn6c05T1coRDRK+jaNKvgyQJJOsTSDqYK9Vu
         2SB8wPhWYbhQeFMkFcPUIAMc3hEAHViDMxMkcRYmwpukGUsOQ+effihI1dHH7ftzWJY6
         k6yuuSe8Cv7cfzNSOsuhucrIpqSw2+IEg3ZjEQKlDqhwDyHg2eAKGQZlOJt+WFTavomE
         3x883Ab8MxhZE8SdK9L26aBNUzJIM83mIiFMpVpPLG8l2CE+qnNjBLFJE9xWz/tdb5qS
         JjgA==
X-Gm-Message-State: AC+VfDzMuQoWZEjnMXUMlmvcCLfkbt9GGDgoKMhnsvJO48Xsx9PmWHTx
        e9i5tRlEGFKRrSBAti99bpGvye3/NzJRog==
X-Google-Smtp-Source: ACHHUZ7MdWUXYvt+kjRYqvFExVbA34y/25NFyEO5NbUhEBVyFpzwaNyY/hNbhxg5Gux1GK9GIm0Zgg==
X-Received: by 2002:a4a:c919:0:b0:558:b78d:8d1e with SMTP id v25-20020a4ac919000000b00558b78d8d1emr5583364ooq.7.1687188803117;
        Mon, 19 Jun 2023 08:33:23 -0700 (PDT)
Received: from mail-oi1-f179.google.com (mail-oi1-f179.google.com. [209.85.167.179])
        by smtp.gmail.com with ESMTPSA id k13-20020a4ad98d000000b005526bfbf131sm61598oou.26.2023.06.19.08.33.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 19 Jun 2023 08:33:22 -0700 (PDT)
Received: by mail-oi1-f179.google.com with SMTP id 5614622812f47-39cd084ea62so2657972b6e.0;
        Mon, 19 Jun 2023 08:33:22 -0700 (PDT)
X-Received: by 2002:a05:6808:1a29:b0:39e:de09:8b96 with SMTP id
 bk41-20020a0568081a2900b0039ede098b96mr2946266oib.34.1687188801974; Mon, 19
 Jun 2023 08:33:21 -0700 (PDT)
MIME-Version: 1.0
References: <20230613114904.15749-1-frank.li@vivo.com> <20230613114904.15749-11-frank.li@vivo.com>
 <91db8e7b-29fb-3c43-ac38-008ebc9b1f6b@gmail.com>
In-Reply-To: <91db8e7b-29fb-3c43-ac38-008ebc9b1f6b@gmail.com>
Reply-To: wens@csie.org
From:   Chen-Yu Tsai <wens@csie.org>
Date:   Mon, 19 Jun 2023 23:33:10 +0800
X-Gmail-Original-Message-ID: <CAGb2v65xzhzVp+pBsa_Z3aHtK4LOpiTbhA749doMpwSTwDtxCg@mail.gmail.com>
Message-ID: <CAGb2v65xzhzVp+pBsa_Z3aHtK4LOpiTbhA749doMpwSTwDtxCg@mail.gmail.com>
Subject: Re: [PATCH v3 11/12] thermal/drivers/generic-adc: Register thermal
 zones as hwmon sensors
To:     Matthias Brugger <matthias.bgg@gmail.com>
Cc:     Yangtao Li <frank.li@vivo.com>, glaroque@baylibre.com,
        rafael@kernel.org, daniel.lezcano@linaro.org, amitk@kernel.org,
        rui.zhang@intel.com, shawnguo@kernel.org, s.hauer@pengutronix.de,
        kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        thara.gopinath@gmail.com, agross@kernel.org, andersson@kernel.org,
        konrad.dybcio@linaro.org, anarsoul@gmail.com,
        tiny.windzz@gmail.com, jernej.skrabec@gmail.com,
        samuel@sholland.org, thierry.reding@gmail.com,
        jonathanh@nvidia.com, edubezval@gmail.com, j-keerthy@ti.com,
        angelogioacchino.delregno@collabora.com, bchihi@baylibre.com,
        niklas.soderlund+renesas@ragnatech.se, wenst@chromium.org,
        linux-pm@vger.kernel.org, linux-amlogic@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-arm-msm@vger.kernel.org, linux-sunxi@lists.linux.dev,
        linux-tegra@vger.kernel.org, linux-omap@vger.kernel.org,
        linux-mediatek@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 19, 2023 at 11:17 PM Matthias Brugger
<matthias.bgg@gmail.com> wrote:
>
>
>
> On 13/06/2023 13:49, Yangtao Li wrote:
> > From: Chen-Yu Tsai <wenst@chromium.org>
> >
> > Register thermal zones as hwmon sensors to let userspace read
> > temperatures using standard hwmon interface.
> >
> > Signed-off-by: Chen-Yu Tsai <wenst@chromium.org>
> > [Yangtao change to use dev_warn and remove return]
> > Signed-off-by: Yangtao Li <frank.li@vivo.com>
> > ---
> >   drivers/thermal/thermal-generic-adc.c | 5 +++++
> >   1 file changed, 5 insertions(+)
> >
> > diff --git a/drivers/thermal/thermal-generic-adc.c b/drivers/thermal/thermal-generic-adc.c
> > index 017b0ce52122..9531bc2f2ce7 100644
> > --- a/drivers/thermal/thermal-generic-adc.c
> > +++ b/drivers/thermal/thermal-generic-adc.c
> > @@ -13,6 +13,8 @@
> >   #include <linux/slab.h>
> >   #include <linux/thermal.h>
> >
> > +#include "thermal_hwmon.h"
> > +
> >   struct gadc_thermal_info {
> >       struct device *dev;
> >       struct thermal_zone_device *tz_dev;
> > @@ -153,6 +155,9 @@ static int gadc_thermal_probe(struct platform_device *pdev)
> >               return ret;
> >       }
> >
> > +     if (devm_thermal_add_hwmon_sysfs(&pdev->dev, gti->tz_dev))
> > +             dev_warn(&pdev->dev, "Failed to add hwmon sysfs attributes\n");
>
> Isn't that already done by patch 1/12?

I think patch 12 should just be squashed in?

> Regards,
> Matthias
>
> > +
> >       return 0;
> >   }
> >
