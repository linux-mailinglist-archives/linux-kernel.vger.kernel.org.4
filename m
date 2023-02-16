Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 63613698E25
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Feb 2023 08:56:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229684AbjBPH4J (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Feb 2023 02:56:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229508AbjBPH4G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Feb 2023 02:56:06 -0500
Received: from mail-vk1-xa32.google.com (mail-vk1-xa32.google.com [IPv6:2607:f8b0:4864:20::a32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE16B45F56
        for <linux-kernel@vger.kernel.org>; Wed, 15 Feb 2023 23:55:09 -0800 (PST)
Received: by mail-vk1-xa32.google.com with SMTP id f17so804169vkm.2
        for <linux-kernel@vger.kernel.org>; Wed, 15 Feb 2023 23:55:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=xONmYBw6JTvrmLO+BA4K5ITh/kiXRq2fHlncM+ovzGs=;
        b=hjpwgbhflizIPQ8Ei73NkCuu8TvOmmoAobeCoLPA8SxjBaAmOI0B61L5Vu8/4mGSHs
         Lpj/DzyA7JzX3tlFL+FZC60MNAFU2i+wAXx0StOQFyjZ7YFVlfidBhpRZM5ZzF2NeYcC
         aQYiYAUH7/8kxnBUvc40ECxmm13ILwd5m0ZCE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xONmYBw6JTvrmLO+BA4K5ITh/kiXRq2fHlncM+ovzGs=;
        b=ykHWgP7dgQLDnr1UL5h/sfjjMX2wVFNhZw6DjdVHv+aU/0pl3I1FKcvwfnSb6V2vDP
         CCtPsOcSyD3lEmXuBpxZsgTyf4FbGc2y0fnsx8acZ7eoKEechw2ITmLKQ3T48CscAZjl
         8HMf9jmJkK32HltxYrwEuF0XaBHiWeiUNefxJAJ7paUnr5WJr+xMjxSlIVJOeOqDz0t9
         o1yMlb94nhuEz4H4BuiHtBOFr+4ViHaX4AQSLtqv4PpM4rXzSsDxPBciqRvzsi3krezX
         KCdYYo+Vd7VjkRAFjx1KY9ecwe9aTpeijIyS4SXmIvOC1B+ahW9kd2jp/iE4n3xuql+f
         4hNQ==
X-Gm-Message-State: AO0yUKXlN+GQfYGLW6ugU+JgytAE4IkNveHYM15SrcfB1ldDXH9QvDoN
        e7bdnI76vRvXJnIc2zPlgdkeyTNnupGlct5Dd/KQDQ==
X-Google-Smtp-Source: AK7set/28STVRdRWXGf4bMCmP2aoX0xrfMB9bmkBz4FxvyVRel7OQwwriFZLqi7THD11no6OYGV4osSvAvDXEdCPURo=
X-Received: by 2002:a1f:a447:0:b0:3e8:66ce:a639 with SMTP id
 n68-20020a1fa447000000b003e866cea639mr780129vke.2.1676534074560; Wed, 15 Feb
 2023 23:54:34 -0800 (PST)
MIME-Version: 1.0
References: <20230214134127.59273-1-angelogioacchino.delregno@collabora.com> <20230214134127.59273-12-angelogioacchino.delregno@collabora.com>
In-Reply-To: <20230214134127.59273-12-angelogioacchino.delregno@collabora.com>
From:   Chen-Yu Tsai <wenst@chromium.org>
Date:   Thu, 16 Feb 2023 15:54:23 +0800
Message-ID: <CAGXv+5HpWTTqrFKhkUDoZWa4h1wm=OuDHgFyMQsL-C4xKVfqOg@mail.gmail.com>
Subject: Re: [PATCH v2 11/47] clk: mediatek: mt8365: Convert simple_gate to
 mtk_gate clocks
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
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 14, 2023 at 9:41 PM AngeloGioacchino Del Regno
<angelogioacchino.delregno@collabora.com> wrote:
>
> On this SoC some clocks apparently don't have different offsets for
> set/clr/sta registers hence they can be set, cleared and status-read
> on one register: this means that it was possible to use simpler gate
> clocks instead of custom mtk_gate ones.
>
> In preparation for converting this clock driver to the common probe
> mechanism for MediaTek clocks, perform a conversion from simple_gate
> to mtk_gate clocks since the latter does provide implicit support
> for simple gate clocks as well.
>
> Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>

Reviewed-by: Chen-Yu Tsai <wenst@chromium.org>
