Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D1B945E987E
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Sep 2022 06:46:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233071AbiIZEqH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Sep 2022 00:46:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232864AbiIZEqE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Sep 2022 00:46:04 -0400
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96F5B25C64
        for <linux-kernel@vger.kernel.org>; Sun, 25 Sep 2022 21:46:03 -0700 (PDT)
Received: by mail-ed1-x531.google.com with SMTP id f20so7369790edf.6
        for <linux-kernel@vger.kernel.org>; Sun, 25 Sep 2022 21:46:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=GKd+KibcA7wD8ErQ8sO7ehtOzCO6uw/Hd3dxETjovTU=;
        b=MisSV+HRw/LJWZJcvdnRBsPW9i+WLR4S1mM7YIkWHfEv15TthAYsnjbrw6YLWbO9na
         X6lDHFY4Dj+sfKrfioRsI+OIXJ56vWLuiClvMpNnNSVmZk9Tvk8udewqTVwN9vTZUrlq
         bsiuLN15l2QYRQwh+Q5BkU/k+1YD/kk7F3/KQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=GKd+KibcA7wD8ErQ8sO7ehtOzCO6uw/Hd3dxETjovTU=;
        b=FjmUtVqIczFLssdc/kG+u9Mn2mNeS6lzF3EMKGzOh5naqABEltghZHwTdeCsM//DG2
         GpQysMSpN9jgmyOcmoR3CfmeguC+Fkjkf9M6PY6OImseer7py7nZxMNO0IZzT7lrVTew
         jDtffXC+kt5uKMxNVIauXy8vJL1Qi5XY6AgtUjA2tqudretho2cRfOkpOMSgpoMpS6Tg
         YW7A0/szuCvBjNvgJ6xJ1QlQP5EH+vu5c1OxqDRXyEsMA1szg/jRngruZ/7KM44f5xKK
         29AjOkeSQkp4f/ZnncTk/A6maHt9Gg1Dcs/LJszIh1Lzsz/dBheofURprc/tLJhB5dnQ
         4yjQ==
X-Gm-Message-State: ACrzQf28AGkFYYZcrqF9d6g0GGdQlDVqL6xv+nEcXdFHKcz1ekD8u0G/
        9kcUC5h4YKt3JIYyOO3Bft44Abc7syfPtqLuk/6s5w==
X-Google-Smtp-Source: AMsMyM74bWt/B81kSLAhztgFdynh6LDkbwyJGa1xI5v9ufRmkfPJAR5bmcGaTQGc7Yq0TXJgiLXm1wIg2wUX5kApuSg=
X-Received: by 2002:a05:6402:280f:b0:44e:ee5c:da6b with SMTP id
 h15-20020a056402280f00b0044eee5cda6bmr20473424ede.256.1664167561950; Sun, 25
 Sep 2022 21:46:01 -0700 (PDT)
MIME-Version: 1.0
References: <20220922091841.4099-1-miles.chen@mediatek.com>
In-Reply-To: <20220922091841.4099-1-miles.chen@mediatek.com>
From:   Chen-Yu Tsai <wenst@chromium.org>
Date:   Mon, 26 Sep 2022 12:45:50 +0800
Message-ID: <CAGXv+5HT4w+y8ntSgBdpYPc4M5=erQNxYOc3-jGFNrZ+HJTA=Q@mail.gmail.com>
Subject: Re: [PATCH v3 0/7] clk: mediatek: use mtk_clk_simple_probe to simplify
To:     Miles Chen <miles.chen@mediatek.com>
Cc:     Stephen Boyd <sboyd@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        linux-kernel@vger.kernel.org,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Chun-Jie Chen <chun-jie.chen@mediatek.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 22, 2022 at 5:19 PM Miles Chen <miles.chen@mediatek.com> wrote:
>
> Hi everyone,
>
> This is v3 patches to use mtk_clk_simple_probe to simplify driver. It is almost
> a RESEND patch, the only difference is adding reviewed-by tags and a tested-by tag
> to the commit messages.
>
> I tested the series on MT8192 and MT6779.
> This patch is based on next-20220921 and [1].
>
> Change since v1:
> - Angelo's patch [1] already exported mtk_clk_simple_probe and mtk_clk_simple_remove,
> so drop this part from my v1 and depends on [1].
> - add a reviewed-by tag
>
> Change since v2:
> - add reviewed-by tags and a tested-by tag
>
> mtk_clk_simple_probe() was introduced by Chun-Jie in commit
> c58cd0e40ffa ("clk: mediatek: Add mtk_clk_simple_probe() to simplify clock providers")
> and mtk_clk_simple_remove() was added in commit
> commit 2204d96b1919 ("clk: mediatek: Add mtk_clk_simple_remove()")
>
> With mtk_clk_simple_probe and mtk_clk_simple_remove,
> we can get rid of defining the same probe function in clk drivers.
> mtk_clk_simple_probe and mtk_clk_simple_remove are used in new platforms
> now, let's apply them to old SoCs.
>
> The process is quite straightforward:
> a. Look up probe functions which can be replaced by mtk_clk_simple_probe()
> b. Add mtk_clk_desc and add .data
> c. Replace the probe function with mtk_clk_simple_probe and mtk_clk_simple_remove
>
> Thanks,
> Miles
>
> [1] https://lore.kernel.org/lkml/20220921091455.41327-1-angelogioacchino.delregno@collabora.com/
>
>
>
> Miles Chen (7):
>   clk: mediatek: mt2701: use mtk_clk_simple_probe to simplify driver
>   clk: mediatek: mt2712: use mtk_clk_simple_probe to simplify driver
>   clk: mediatek: mt6765: use mtk_clk_simple_probe to simplify driver
>   clk: mediatek: mt6779: use mtk_clk_simple_probe to simplify driver
>   clk: mediatek: mt6797: use mtk_clk_simple_probe to simplify driver
>   clk: mediatek: mt8183: use mtk_clk_simple_probe to simplify driver
>   clk: mediatek: mt8192: add mtk_clk_simple_remove

I've queued this series up here [1] and will send a pull request to
the clock maintainer later this week.

[1] https://git.kernel.org/pub/scm/linux/kernel/git/wens/linux.git/log/?h=clk-mtk-for-6.1
