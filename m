Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B319660557
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Jan 2023 18:10:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231307AbjAFRJ6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Jan 2023 12:09:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229568AbjAFRJ4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Jan 2023 12:09:56 -0500
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7555B34D65
        for <linux-kernel@vger.kernel.org>; Fri,  6 Jan 2023 09:09:54 -0800 (PST)
Received: by mail-wr1-x432.google.com with SMTP id m7so1842033wrn.10
        for <linux-kernel@vger.kernel.org>; Fri, 06 Jan 2023 09:09:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=LSsjSZLw2nnMiY4uzIYBeHgb7SrIecIpavNAgqHfew4=;
        b=gI+GkFENMZ1YF4920k6ktVFlhiSghkF8wasO8OI39wGNMuhF10+5nC9KSEq9YCtsk8
         pnXEKaD1vYI868EzTmj9lF6ZZIPlP71fSozVJH4v+CM60J2YTCG5nwxNtXOugvZk25ic
         2SgxHHn/nG2E2VRa00sEYKMPIqrhWI1OduxEMe6N3fTzIl1a5C1frS+SOcndNjmRb6qG
         kqiRhEAvIv3zAuuevWyLbf3gxdbMKrTBwA+bzhCTyGnaVwm3utYD0z00sbK8zUudq7vF
         O6NIQyUZ1tJ8ZA1i9qsaRtaMk5I8ZHPryXno8bfi+m4DqIKyUFuLsqEMRyUXktzE8rZE
         A1cQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LSsjSZLw2nnMiY4uzIYBeHgb7SrIecIpavNAgqHfew4=;
        b=MB4MhpwIa5C0gtu1hGhCC4ZhivkZwcQ9hhl5KDWRujaKjrW7kss3P/0olPhQgFMrTf
         Dlv050jVKJqbcdI6e32PixtH0gIWQzD8kELXUiOr5kRSDZ8h/q9F3pkQYpewFn8Rw5rb
         GhfQaEcuucVCP9Io6mLrdlAzan0j0YW6FjpiLqhkN5m78bZl1rtLoW+nKf9bYRQ4Ityk
         t5Pk2jPc/jlguNzYmaaNw3WbdP+Eq/LqnQcUqGhkS2YsPt/Qe87lioeiGh3uECwQjcPi
         zmJLMs2I058g3TpvZM+KdyYPNXclzJbISC09h4KsVR84LeLJ4QpC6CzDVrw8KwEjW8Xb
         FSNA==
X-Gm-Message-State: AFqh2kq+yFX2BqYZsyDohKWxWDlmunsuVVQ2zSbyTEZfV/GZktoqWwn5
        0g7qE1mmWpD/QJLqhIRh+jjeIw==
X-Google-Smtp-Source: AMrXdXvP048hXDp25O/bVkFsD7hfVgHLup2HHrx0e83cjxssZRjxMAk2z+wtJBwXQZaVb4ItdMtHkw==
X-Received: by 2002:a5d:56c1:0:b0:288:d139:3690 with SMTP id m1-20020a5d56c1000000b00288d1393690mr21420018wrw.67.1673024993035;
        Fri, 06 Jan 2023 09:09:53 -0800 (PST)
Received: from blmsp ([2001:4091:a245:805c:8713:84e4:2a9e:cbe8])
        by smtp.gmail.com with ESMTPSA id t17-20020a05600001d100b00241d21d4652sm1733540wrx.21.2023.01.06.09.09.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Jan 2023 09:09:52 -0800 (PST)
Date:   Fri, 6 Jan 2023 18:09:51 +0100
From:   Markus Schneider-Pargmann <msp@baylibre.com>
To:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Cc:     mturquette@baylibre.com, sboyd@kernel.org, matthias.bgg@gmail.com,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        wenst@chromium.org, johnson.wang@mediatek.com,
        miles.chen@mediatek.com, fparent@baylibre.com,
        chun-jie.chen@mediatek.com, sam.shih@mediatek.com,
        y.oudjana@protonmail.com, nfraprado@collabora.com,
        rex-bc.chen@mediatek.com, ryder.lee@kernel.org,
        daniel@makrotopia.org, jose.exposito89@gmail.com,
        yangyingliang@huawei.com, pablo.sun@mediatek.com,
        weiyi.lu@mediatek.com, ikjn@chromium.org,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, devicetree@vger.kernel.org,
        kernel@collabora.com
Subject: Re: [PATCH v2 05/23] clk: mediatek: clk-mtk: Propagate struct device
 for composites
Message-ID: <20230106170951.rn7w2lwwdckruuie@blmsp>
References: <20221223094259.87373-1-angelogioacchino.delregno@collabora.com>
 <20221223094259.87373-6-angelogioacchino.delregno@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20221223094259.87373-6-angelogioacchino.delregno@collabora.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Fri, Dec 23, 2022 at 10:42:41AM +0100, AngeloGioacchino Del Regno wrote:
> Like done for cpumux clocks, propagate struct device for composite
> clocks registered through clk-mtk helpers to be able to get runtime
> pm support for MTK clocks.
> 
> Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
> ---
>  drivers/clk/mediatek/clk-mt2701.c          | 4 ++--
>  drivers/clk/mediatek/clk-mt2712.c          | 4 ++--
>  drivers/clk/mediatek/clk-mt6779.c          | 4 ++--
>  drivers/clk/mediatek/clk-mt6795-pericfg.c  | 2 +-
>  drivers/clk/mediatek/clk-mt6795-topckgen.c | 2 +-
>  drivers/clk/mediatek/clk-mt6797.c          | 2 +-
>  drivers/clk/mediatek/clk-mt7622.c          | 5 +++--
>  drivers/clk/mediatek/clk-mt7629.c          | 4 ++--
>  drivers/clk/mediatek/clk-mt8135.c          | 4 ++--
>  drivers/clk/mediatek/clk-mt8167.c          | 4 ++--
>  drivers/clk/mediatek/clk-mt8173.c          | 4 ++--
>  drivers/clk/mediatek/clk-mt8183.c          | 6 +++---
>  drivers/clk/mediatek/clk-mt8186-mcu.c      | 2 +-
>  drivers/clk/mediatek/clk-mt8186-topckgen.c | 4 ++--
>  drivers/clk/mediatek/clk-mt8192.c          | 4 ++--
>  drivers/clk/mediatek/clk-mt8195-topckgen.c | 2 +-
>  drivers/clk/mediatek/clk-mt8365.c          | 5 +++--
>  drivers/clk/mediatek/clk-mt8516.c          | 4 ++--
>  drivers/clk/mediatek/clk-mtk.c             | 9 +++++----
>  drivers/clk/mediatek/clk-mtk.h             | 3 ++-
>  20 files changed, 41 insertions(+), 37 deletions(-)
> 
> diff --git a/drivers/clk/mediatek/clk-mt2701.c b/drivers/clk/mediatek/clk-mt2701.c
> index dcae25778817..bd62acb5d697 100644
> --- a/drivers/clk/mediatek/clk-mt2701.c
> +++ b/drivers/clk/mediatek/clk-mt2701.c
> @@ -684,7 +684,7 @@ static int mtk_topckgen_init(struct platform_device *pdev)
>  								clk_data);
>  
>  	mtk_clk_register_composites(top_muxes, ARRAY_SIZE(top_muxes),
> -				base, &mt2701_clk_lock, clk_data);
> +				base, &mt2701_clk_lock, clk_data, &pdev->dev);

The patch looks good in general, just a few nitpicks like this where you
could adjust the indentation to the open parenthesis.
'checkpatch.pl --strict' will show you all the locations where it is not
correct here and in other patches.

Best,
Markus
