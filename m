Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BAD7065962C
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Dec 2022 09:16:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234761AbiL3IQ1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Dec 2022 03:16:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234734AbiL3IQF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Dec 2022 03:16:05 -0500
Received: from mail-vs1-xe29.google.com (mail-vs1-xe29.google.com [IPv6:2607:f8b0:4864:20::e29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63BAF1A060
        for <linux-kernel@vger.kernel.org>; Fri, 30 Dec 2022 00:16:04 -0800 (PST)
Received: by mail-vs1-xe29.google.com with SMTP id s127so6670677vsb.5
        for <linux-kernel@vger.kernel.org>; Fri, 30 Dec 2022 00:16:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=KPlTEqYa3MYCMl9BvqJcl9vvn2yJXyimwlsnQsWb80g=;
        b=YhAxgjwByMUVtC0QltQ0WZbdI/jd05toOa5H1jc5GThVHN2I114FIGBg6IFEm61vTO
         vjueufSh3oZGhR632HQeIa257kEzkJLao4uA7qTC8d7DgDRea0pwxhRcTZcFSnZ9xmoj
         mnvt8dyoAkT7xtkdOpPxs554wJdeEe+ZrTvxY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KPlTEqYa3MYCMl9BvqJcl9vvn2yJXyimwlsnQsWb80g=;
        b=H7cR67bwISmtl0pI8FnVe0uW2lp5AD9Xn8ayzyqTBJIVjBSicz5NjvAhmJA6Ki7G7C
         2DRoN3x2Hnmmz81AV3qAntYIFwuiBaVKI7cmZnMY+xMzbwimsbhWYXRvfBlRFheAVOBE
         70FxfrGOrrUDJw45AXp9cCqHG7fW/klfSIg4hEf5ebePpakI6rZiFnwJt7ttEhJDcPSg
         HVbZE9kkNvSvhrUpHRandgA4pPlMAeuRplTaHCdP31lz63teDDrbNOpbQd8crxOOY9lp
         OjHVNgKcsogUWapMJk5FNqLFwHdMXhiiUTTo8SXKZhL+O3YH9eDwJM2Zg3KpzyIovaWE
         NUhA==
X-Gm-Message-State: AFqh2kqYxL83vjP0+9H3VRGrMoz3dCd7YxAxNF5TDKRY4XrnC6PQ35Zy
        BfUIC5LW+wiAYbr56JwDtpdTkkLdgtfgoBQbHUrDCg==
X-Google-Smtp-Source: AMrXdXv0jj8OdD6WjSDbEKQJNJ1yRigoEOsjWSkDG9TTutwpBPDNw73XntP58sJQMP+TekyU6XVuIFUl5/GDLYHuanA=
X-Received: by 2002:a05:6102:3e06:b0:3b5:fd8:7948 with SMTP id
 j6-20020a0561023e0600b003b50fd87948mr4003899vsv.85.1672388163532; Fri, 30 Dec
 2022 00:16:03 -0800 (PST)
MIME-Version: 1.0
References: <20221223094259.87373-1-angelogioacchino.delregno@collabora.com> <20221223094259.87373-21-angelogioacchino.delregno@collabora.com>
In-Reply-To: <20221223094259.87373-21-angelogioacchino.delregno@collabora.com>
From:   Chen-Yu Tsai <wenst@chromium.org>
Date:   Fri, 30 Dec 2022 16:15:52 +0800
Message-ID: <CAGXv+5E26i6F2BPZYDfRhM-OMei-Br276UNtRVr5=+7pT+HTqg@mail.gmail.com>
Subject: Re: [PATCH v2 20/23] clk: mediatek: clk-mt8186-topckgen: Migrate to mtk_clk_simple_probe()
To:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Cc:     mturquette@baylibre.com, sboyd@kernel.org, matthias.bgg@gmail.com,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        johnson.wang@mediatek.com, miles.chen@mediatek.com,
        fparent@baylibre.com, chun-jie.chen@mediatek.com,
        sam.shih@mediatek.com, y.oudjana@protonmail.com,
        nfraprado@collabora.com, rex-bc.chen@mediatek.com,
        ryder.lee@kernel.org, daniel@makrotopia.org,
        jose.exposito89@gmail.com, yangyingliang@huawei.com,
        pablo.sun@mediatek.com, msp@baylibre.com, weiyi.lu@mediatek.com,
        ikjn@chromium.org, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, devicetree@vger.kernel.org,
        kernel@collabora.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 23, 2022 at 5:43 PM AngeloGioacchino Del Regno
<angelogioacchino.delregno@collabora.com> wrote:
>
> As done with MT8192, migrate MT8186 topckgen away from a custom probe
> function and use mtk_clk_simple_{probe, remove}().
>
> Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>

Reviewed-by: Chen-Yu Tsai <wenst@chromium.org>
