Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6788968E9D3
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Feb 2023 09:24:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229741AbjBHIYR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Feb 2023 03:24:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230256AbjBHIYP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Feb 2023 03:24:15 -0500
Received: from mail-vs1-xe2f.google.com (mail-vs1-xe2f.google.com [IPv6:2607:f8b0:4864:20::e2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DF3E1CF65
        for <linux-kernel@vger.kernel.org>; Wed,  8 Feb 2023 00:24:13 -0800 (PST)
Received: by mail-vs1-xe2f.google.com with SMTP id d66so19014601vsd.9
        for <linux-kernel@vger.kernel.org>; Wed, 08 Feb 2023 00:24:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=l4fNY1QmPgc1eDxWIcVEmeoLEE0WYG7olhyPqNb4FPA=;
        b=IcMXQ/M2g9B25Yan+ex4qiEFyvr/DLfBMCj/Ps2VNy2dCwYBQ8Xfk5ckQTCPWYjnZ+
         0vwnnzDsnYI7MmW8ZWVOG1pOMYWyOiGsaI+QbFoeaMrIbwbMn73ti2t67wtyWy8RguGT
         XSkdYHbsbxZYebvANHSkqQvDkevan1O/BFD+U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=l4fNY1QmPgc1eDxWIcVEmeoLEE0WYG7olhyPqNb4FPA=;
        b=SAqgOkONy+TfzHybPuzF6k6m7OwYMwTfDb7T2OpqzzLhXTBj8Rn9zq180TbhQcogfz
         k2R669sgBQEGMQi7V7RBvLOOO3i/wAhD7YjW8R+38riexMKlfiqF58lt1BIrgAZzxc7J
         jdpa5a9eq+q88O02zQp+u/Bm0ayhkM2qeHTEWMaXdRJjKBZLjgibGXqVR0DsnggzJIBR
         j3OrqOuDa0RbvzYgcvfy2U7casX1hURox9ZfAGMDLbEr92zqR1oF7cV98Xp11bRbO67Q
         oZeF8Hz2ygVnBQf0s8P5dRvG358IrdkwmeI2+TZ8el5uLsPHrSwCpGZ5YRmhumTqoOiO
         adTw==
X-Gm-Message-State: AO0yUKUENvR6Iw1pS9r4SIUs/2rVusNukDL808qbooj+rYnw/Ec7WEFN
        vwmR5h4X9dXT4XYRLFPCDvRvOlVpO+j7QD+Sp1vHEA==
X-Google-Smtp-Source: AK7set/lc8VtASNtxb17NapmM4msjQBcz/1VBanIWZdAGanrOgaYsuc2JpxRWYXCQehO9HTtrZ7t92NrGgP+qsH8+PI=
X-Received: by 2002:a05:6102:4b8:b0:3fe:ae88:d22 with SMTP id
 r24-20020a05610204b800b003feae880d22mr1519662vsa.65.1675844652747; Wed, 08
 Feb 2023 00:24:12 -0800 (PST)
MIME-Version: 1.0
References: <20230206152928.918562-1-angelogioacchino.delregno@collabora.com>
 <20230206152928.918562-10-angelogioacchino.delregno@collabora.com>
 <CAGXv+5GfwY2+55UupTUNYVudg3-YDQtkkfhT=M53CJwdqG=ERg@mail.gmail.com>
 <b7b35901-59aa-5342-1bd1-5ed591a0469c@collabora.com> <CAGXv+5HNs-74COE_5V4O_ykLJN=K4YVR-5SNwcPTBcxFMoRm5g@mail.gmail.com>
 <d07156bd-95e6-5c7d-b88e-1c4a5dfc3a07@collabora.com>
In-Reply-To: <d07156bd-95e6-5c7d-b88e-1c4a5dfc3a07@collabora.com>
From:   Chen-Yu Tsai <wenst@chromium.org>
Date:   Wed, 8 Feb 2023 16:24:01 +0800
Message-ID: <CAGXv+5H07KEOhk_4BPU6Su5f2WmGygLEGSeCD9bqgdH3ix+=Rw@mail.gmail.com>
Subject: Re: [PATCH v1 09/45] clk: mediatek: mt2712: Change to use
 module_platform_driver macro
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

On Tue, Feb 7, 2023 at 6:50 PM AngeloGioacchino Del Regno
<angelogioacchino.delregno@collabora.com> wrote:
>
> Il 07/02/23 10:30, Chen-Yu Tsai ha scritto:
> > On Tue, Feb 7, 2023 at 5:00 PM AngeloGioacchino Del Regno
> > <angelogioacchino.delregno@collabora.com> wrote:
> >>
> >> Il 07/02/23 07:33, Chen-Yu Tsai ha scritto:
> >>> On Mon, Feb 6, 2023 at 11:29 PM AngeloGioacchino Del Regno
> >>> <angelogioacchino.delregno@collabora.com> wrote:
> >>>>
> >>>> Now that all of the clocks in clk-mt2712.c are using the common
> >>>> mtk_clk_simple_{probe,remove}() callbacks we can safely migrate
> >>>> to module_platform_driver.
> >>>
> >>> Instead of splitting the conversion into a module among many patches,
> >>> I'd do it in one go. With one patch we get a working module instead
> >>> of a half-baked one half way through the series.
> >>>
> >>
> >> If you really want I can eventually do that in one go - in any case, the
> >> sense of having this split in multiple commits is:
> >>    - Bisectability: topckgen/mcucfg migration being faulty would point at
> >>                     one commit doing just that, making it easier for whoever
> >>                     is trying to debug that to find what could've gone wrong;
> >
> > This part I agree with.
> >
> >>    - Slow changes:  A driver being a platform_driver doesn't mean that it *has*
> >>                     to be compiled as a module: infact, we can use the .remove()
> >>                     callback even with built-in drivers (as you can remove one
> >>                     and re-add it during runtime from sysfs)
> >
> > I think the part that tripped me up was that in this patch's case it
> > was already a platform driver, just a builtin one (without the
> > builtin_platform_driver sugar).
> >
> >>    - Signaling completion:
> >>                     Saying "this is complete" in this case is performed in the
> >>                     last patches of the series, where only the Kconfig is being
> >>                     changed to allow the module build for (most)all.
> >
> > I'm concerned about people randomly cherry-picking patches. Unfortunately
> > not everyone lives on mainline, us included. (I'm sure Android has it
> > worse.) Many won't see the complete patch series, doubly so if we merge
> > it in stages. Better we give one complete patch that converts the
> > boilerplate code from "can't work as module" to "can work as module".
> > I do agree we should keep all the other cleanups and migration to
> > simple/pdev_probe separate for bisectability.
> >
>
> One complete patch meaning that migrating to mtk_clk_simple_probe() should be
> squashed with moving apmixedsys away?
>
> So one patch doing the *big* change, and then one changing the driver to use
> the module_platform_driver() macro and tristate in Kconfig?

I'd also add MOD_DEVICE_TABLE. Module autoloading doesn't work otherwise.

The rest of the MODULE_INFO stuff I don't really have a preference on,
but I don't know if there would be any issues with loading a module
that doesn't have MODULE_LICENSE. Maybe the default is "GPL"?

> I would be more comfortable changing the order of commits at this point,
> apmixedsys error handling Fixes -> apmixedsys moved in its own file ->
> migrate others to mtk_clk_simple_probe() *and* Kconfig changes
>
> What do you think?

Sounds good. That way a) apmixed sys error handling could be cleanly
backported if anyone cares, and b) code movement is contained in one patch.

> Thing is, apmixedsys is not a simple_probe driver and will never be, so
> it feels wrong to move that inside of a commit that converts to simple_probe()...

Agreed.

Thanks
ChenYu

> >>> The subject could say "Convert X driver from builtin to module". And
> >>> instead of "migrate to module_platform_driver", the body could say
> >>> "convert to module by switching to module_platform_driver, and adding
> >>> missing MODULE_* statements". I believe this constitutes one logical
> >>> change. Maybe the accompanying Kconfig change should be included as
> >>> well?
> >>>
> >>
> >> But again, I don't have *really strong* opinions on this, if not preferences
> >> for how I'd like to see the changes getting in: this series brings big changes
> >> that would be done in many more commits if they were scattered in more series.
> >> Another point about having this conversion performed in multiple commits is
> >> showing how it was done and how to replicate it for a different driver...
> >
> > In the past I've seen some comments from other maintainers about keeping
> > (module|builtin)_X_driver consistent with its Kconfig entry. That sort of
> > plays into my argument that this bit should be kept atomic.
> >
> > There are a couple patches where you convert directly from CLK_OF_DECLARE
> > to module_platform_driver. We could work those out case by case?
> >
> >>>> Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
> >>>> ---
> >>>>    drivers/clk/mediatek/clk-mt2712.c | 10 ++--------
> >>>>    1 file changed, 2 insertions(+), 8 deletions(-)
> >>>>
> >>>> diff --git a/drivers/clk/mediatek/clk-mt2712.c b/drivers/clk/mediatek/clk-mt2712.c
> >>>> index c5fd76d1b9df..65c1cbcbd54e 100644
> >>>> --- a/drivers/clk/mediatek/clk-mt2712.c
> >>>> +++ b/drivers/clk/mediatek/clk-mt2712.c
> >>>> @@ -1028,7 +1028,7 @@ static const struct of_device_id of_match_clk_mt2712_simple[] = {
> >>>>           { /* sentinel */ }
> >>>>    };
> >>>>
> >>>> -static struct platform_driver clk_mt2712_simple_drv = {
> >>>> +static struct platform_driver clk_mt2712_drv = {
> >>>
> >>> Why the name change? If you do change the name, could you also change
> >>> the of match table's name as well to be consistent, and also mention
> >>> the change in the commit log?
> >>
> >> It simply looked like being a good idea, as "simple" made sense when we had two
> >> platform_driver in one file, one using simple_probe, one using a custom probe
> >> function.
> >> The latter going away forever means that there's no more distinction to do
> >> between the two, hence my rename here...
> >>
> >> Regarding the of_match_table name change... I'm sorry, I genuinely forgot to
> >> change it, my intention was infact to actually be consistent... :-)
> >>
> >>>
> >>> I'd just leave it alone though.
> >>
> >> I had to explain my reasoning about all of the above, so I'll just wait for
> >> your opinion again before going for a v2! :-)
> >
> > Thanks again for working on this.
> >
> > ChenYu
>
>
>
