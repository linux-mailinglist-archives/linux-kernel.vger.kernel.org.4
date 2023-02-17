Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A608E69AF48
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Feb 2023 16:16:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229575AbjBQPQ2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Feb 2023 10:16:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229770AbjBQPQZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Feb 2023 10:16:25 -0500
Received: from mail-io1-xd2b.google.com (mail-io1-xd2b.google.com [IPv6:2607:f8b0:4864:20::d2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE2806666B
        for <linux-kernel@vger.kernel.org>; Fri, 17 Feb 2023 07:16:22 -0800 (PST)
Received: by mail-io1-xd2b.google.com with SMTP id p131so566650iod.1
        for <linux-kernel@vger.kernel.org>; Fri, 17 Feb 2023 07:16:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=y6tSzB6GogvHu+/Sj0xL4Z/TCcT8KX/q0mTJTQsyK7Q=;
        b=OfLZ+n93gBE6JvkCeqIGlnC8EIWeE8iaemwIwdZO4mH8UCtTnPE7WBlzR0w48SrvVA
         lWlf7c9NRg0a4o1ixTNkNXrxTq301dM7B1noIBSe5AIIU4tqwWWtR+92s1zlFLwdkG2A
         hRFzbk1CV2c7DL0f0FGcIgHJjv/5hBFBO8gck=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=y6tSzB6GogvHu+/Sj0xL4Z/TCcT8KX/q0mTJTQsyK7Q=;
        b=Kf9LhA4nHKG/bCpASeMZGS2RJQS6LU+xG2yfu3v+KfIYLUri6gpn0EZZP4sn6O0ypU
         N9ZzedJ/HgBkD/CMNnrBJm8yujz9vaT4ugSl5r5Z5xwJDr23iLzFDh+TH+ik7PdK4TaA
         R52YQzPbadv2Uz1mQfjDWMgZIlqCdJ12+u8ovHULmTEIoWyGKDRQEsEetf8DWspdfvGM
         3TAAdVkKbhnM5duwWWrERNN3PNtCZ70X09FkOKFTz2yM18TMmNI+xH4bwR+X/kWTS6H7
         KDISsPCKkj/8UhZv86CV/CPDDOypax4FQMDLCMv8zhCHiY8bJ5/Rz0nfoN+N/4V80JAb
         UMfw==
X-Gm-Message-State: AO0yUKVEB3g8vyaG0oLz5QM/skmO+akJwMl90vBCnDstOQbAQFQ56Qob
        QhjRUVPHhm8Pqe7F/JDhflNk9M0Atd+7RgFTbxOtww==
X-Google-Smtp-Source: AK7set8VgsRphz5Zi8p+HUY1vqyOrAxOOrq9Nf9k7JovWnJ/H3Qd2Ajyc+oIGlzTDEOE6C0axpa5HWHEqdT2NLOEaS8=
X-Received: by 2002:a02:2907:0:b0:3a9:6e13:781b with SMTP id
 p7-20020a022907000000b003a96e13781bmr544032jap.3.1676646982352; Fri, 17 Feb
 2023 07:16:22 -0800 (PST)
MIME-Version: 1.0
References: <20230214134127.59273-1-angelogioacchino.delregno@collabora.com>
 <20230214134127.59273-38-angelogioacchino.delregno@collabora.com>
 <CAGXv+5H7=rOwVK2SapqyeKHKnRJMwXFf1OSD-qhgjkbkoR=Zmw@mail.gmail.com> <c9bd53f9-7d5a-6e2d-4062-297158661422@collabora.com>
In-Reply-To: <c9bd53f9-7d5a-6e2d-4062-297158661422@collabora.com>
From:   Chen-Yu Tsai <wenst@chromium.org>
Date:   Fri, 17 Feb 2023 23:16:10 +0800
Message-ID: <CAGXv+5GigndbJ2rfpRUfti-9DO1gyfOQ-difX-oOqSTF2dup_g@mail.gmail.com>
Subject: Re: [PATCH v2 37/47] clk: mediatek: Split MT8195 clock drivers and
 allow module build
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

On Fri, Feb 17, 2023 at 7:29 PM AngeloGioacchino Del Regno
<angelogioacchino.delregno@collabora.com> wrote:
>
> Il 17/02/23 05:31, Chen-Yu Tsai ha scritto:
> > On Tue, Feb 14, 2023 at 9:42 PM AngeloGioacchino Del Regno
> > <angelogioacchino.delregno@collabora.com> wrote:
> >>
> >> MT8195 clock drivers were encapsulated in one single (and big) Kconfig
> >> option: there's no reason to do that, as it is totally unnecessary to
> >> build in all or none of them.
> >>
> >> Split them out: keep boot-critical clocks as bool and allow choosing
> >> non critical clocks as tristate.
> >>
> >> Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
> >> ---
> >>   drivers/clk/mediatek/Kconfig  | 86 +++++++++++++++++++++++++++++++++++
> >>   drivers/clk/mediatek/Makefile | 20 +++++---
> >>   2 files changed, 99 insertions(+), 7 deletions(-)
> >>
> >> diff --git a/drivers/clk/mediatek/Kconfig b/drivers/clk/mediatek/Kconfig
> >> index 45b7aea7648d..88937d111e98 100644
> >> --- a/drivers/clk/mediatek/Kconfig
> >> +++ b/drivers/clk/mediatek/Kconfig
> >> @@ -692,6 +692,92 @@ config COMMON_CLK_MT8195
> >>           help
> >>             This driver supports MediaTek MT8195 clocks.
> >>
> >> +config COMMON_CLK_MT8195_APUSYS
> >> +       tristate "Clock driver for MediaTek MT8195 apusys"
> >> +       depends on COMMON_CLK_MT8195
> >
> > Would something like
> >
> >            default COMMON_CLK_MT8195
> >
> > help with the transition?
> >
> > Otherwise we'd need to add a whole lot more stuff to arm64's defconfig,
> > and anyone running `make olddefconfig` would have many of their clock
> > drivers no longer available.
> >
> > Same applies to the MT8186 split.
> >
> > Seems like not all MediaTek SoCs apply this pattern, but at least MT7986,
> > MT8167, MT8173, MT8183 do this.
> >
> > ChenYu
>
> Right. Since MT8195 machines have been out in the wild for a bit of time now,
> I think it's worth following your advice and add `default COMMON_CLK_MT8195`
> to the new configuration options.
>
> As for MT8186, currently, there's only one board supported upstream, which
> is the "unobtainable" EVB so I would rather not do that for MT8186, unless
> you have any strong opinions on that.

I'd like something that provides a reasonable working machine if possible.
If people need to customize to shrink their kernel, they could disable the
options later on. At least for ChromeOS we'll probably start off with them
all built-in, and later on maybe experiment a bit with modules.

ChenYu
