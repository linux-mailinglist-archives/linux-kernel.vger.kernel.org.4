Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 21858659627
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Dec 2022 09:14:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234659AbiL3IOj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Dec 2022 03:14:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229477AbiL3IOg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Dec 2022 03:14:36 -0500
Received: from mail-vk1-xa31.google.com (mail-vk1-xa31.google.com [IPv6:2607:f8b0:4864:20::a31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4801D193D5
        for <linux-kernel@vger.kernel.org>; Fri, 30 Dec 2022 00:14:36 -0800 (PST)
Received: by mail-vk1-xa31.google.com with SMTP id z190so5593605vka.4
        for <linux-kernel@vger.kernel.org>; Fri, 30 Dec 2022 00:14:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=h/23SH/RDubUwtPhGDvvJ5R7dhk7aa2Q9znGGjv9398=;
        b=hQL750/SptDyM5zC9SONd1+yKhS6sU/IIgcEppsoQ+cTBrkG0dJKYth3P6vkDRv1m2
         rZSgt08UXmchg3fKG/2gV4l20jzUYuaKZ802nmCM+vwvC7x/OzXK0f1aVK4YC3dm/OYJ
         +vLtcMX04P3A/R8rugf17ELK3VwPbMxjI21wI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=h/23SH/RDubUwtPhGDvvJ5R7dhk7aa2Q9znGGjv9398=;
        b=Pix9e9rP470rQ0ZBbyAiZGiRPWFo+gkWosgYHIa5wDBdcBLz+DclUAx7HohaLm6ghK
         O+eeSRHEXJXgKg5mItiRWj59B7QI5oR1G6u7LmeV2YJmXaqzAgwLi6X5J/a/VlX9wJjv
         susq75OeffM7fTzR9mExS1eno9mudCKdzWLpYEv8ezZNEfjRXAu3DyHBsC+glsPGz0tr
         lbTuJNw8a7tQbubU4KUbcmtvlJLUr6yqKgUMkFzfH8KdmMWwm5x+LNg0DDExnzDqbOZK
         W8r340p5xGwQdvKgMeNQU0Al1jbqPFZLnjsxITNGW1SZ7fY7LjP9gO6MyWiZx1PWUeli
         ZJyA==
X-Gm-Message-State: AFqh2kqsU7c9+onHLkVWv25zBCDbS3GfB2nLDcR8e0DnB+W73IY2AM/J
        t0x2Yx/9GbPKUpqoenGkfu9CgZnbyVQKr+ZWqQt0AQ==
X-Google-Smtp-Source: AMrXdXv+RCjAisIysYzOgTd+TZASYGjgYmh6pgy5c7q3H14gY+3IMCe6R4lmwzLkmBOTPRmsWJgPiOASnjVqpAniq1Y=
X-Received: by 2002:a1f:940a:0:b0:3bd:e439:84e4 with SMTP id
 w10-20020a1f940a000000b003bde43984e4mr3202746vkd.11.1672388075447; Fri, 30
 Dec 2022 00:14:35 -0800 (PST)
MIME-Version: 1.0
References: <20221223094259.87373-1-angelogioacchino.delregno@collabora.com> <20221223094259.87373-24-angelogioacchino.delregno@collabora.com>
In-Reply-To: <20221223094259.87373-24-angelogioacchino.delregno@collabora.com>
From:   Chen-Yu Tsai <wenst@chromium.org>
Date:   Fri, 30 Dec 2022 16:14:24 +0800
Message-ID: <CAGXv+5HtEE_1wFOHwXLe+gJrcEgs63g-UpiiRXoSqh+fZW=N+Q@mail.gmail.com>
Subject: Re: [PATCH v2 23/23] clk: mediatek: clk-mt7986-topckgen: Migrate to mtk_clk_simple_probe()
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
> There are no more non-common calls in clk_mt7986_topckgen_probe():
> migrate this driver to mtk_clk_simple_probe().
>
> Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>

Reviewed-by: Chen-Yu Tsai <wenst@chromium.org>
