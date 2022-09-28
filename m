Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 319745ED56D
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Sep 2022 08:53:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231519AbiI1Gxx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Sep 2022 02:53:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233134AbiI1Gx0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Sep 2022 02:53:26 -0400
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C79E1F65C5
        for <linux-kernel@vger.kernel.org>; Tue, 27 Sep 2022 23:51:26 -0700 (PDT)
Received: by mail-ej1-x62d.google.com with SMTP id nb11so25094125ejc.5
        for <linux-kernel@vger.kernel.org>; Tue, 27 Sep 2022 23:51:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=VKS/VF0CIgvcZvBFOPg/1OgyZ/pIlJ2/81i9icexORw=;
        b=iECOdZjKhncEnAw0CsNKmcZACs/WmHxH0eaQ4q0VbDy5j5wDGWw1csn5q7gxcz31md
         iZAjgiUd+ID5VWXQiNCNSy7lGFEDGfpmxASWMziXMhFmITezAXVrpFIrKCROmDEJL12x
         XAHO0OJxlXup8DfxacOU1eT4qWrUy+kfMxlSg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=VKS/VF0CIgvcZvBFOPg/1OgyZ/pIlJ2/81i9icexORw=;
        b=HE9QfwwYuJAFNp9mXwyLo//zfgaDVBIk2uWgkDwlfeoanH2upvLcvSIUd6wtObafO3
         QWDKYpbFiq2to2xPtChchST/NMSGEeqfRn3gygZX5eY6Fv1h6sBCR4STVejZEMLSVQzI
         AeLyxIi7S4Ap+xZg4lCUaTWULBrWnGVCR6cemFkGhuVvAZBVWSiM5TPQsROexJNPML5c
         aZ3dbxhSEHM4k6DVW0zg6Pl5yqnJJfXN3NL5KwkCcVeT5vk3yRKT/kT/PZLeh02Ov4ky
         tTogbUQVn7d04Qq7QBIUhCYIC/MD5OpR22Tti31spMridCcPag7x4efrK1EC+vaK9o2/
         vv7w==
X-Gm-Message-State: ACrzQf1k5Lz+Ywi/iaEfevISyZMjrprvdxUdnyTChCoTb0yLgww6VQ7v
        Xngi0h1wXx5eH5GMKgAjfS6wtImfcLwTqERdstM02w==
X-Google-Smtp-Source: AMsMyM7+efvQsRLd4e2MqG4ydC0xN3YqsjPc8629mTw8VIsF31t+nnGUFKem/9nHVbG9M7i14vzEBfCkJSHU3A+JEyM=
X-Received: by 2002:a17:907:7f93:b0:781:dbee:dece with SMTP id
 qk19-20020a1709077f9300b00781dbeedecemr26105617ejc.323.1664347884849; Tue, 27
 Sep 2022 23:51:24 -0700 (PDT)
MIME-Version: 1.0
References: <20220926102523.2367530-1-wenst@chromium.org> <20220926102523.2367530-4-wenst@chromium.org>
 <0a1618c4-b808-56bd-e89f-560b0423191d@collabora.com>
In-Reply-To: <0a1618c4-b808-56bd-e89f-560b0423191d@collabora.com>
From:   Chen-Yu Tsai <wenst@chromium.org>
Date:   Wed, 28 Sep 2022 14:51:13 +0800
Message-ID: <CAGXv+5E=RXd2u00-j98BFLpiXaei6JgHNbi21-R2nhqHn40x3Q@mail.gmail.com>
Subject: Re: [PATCH 3/6] clk: mediatek: mt8192: Do not re-register
 top_early_divs in probe function
To:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Cc:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Miles Chen <miles.chen@mediatek.com>,
        linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 27, 2022 at 6:39 PM AngeloGioacchino Del Regno
<angelogioacchino.delregno@collabora.com> wrote:
>
> Il 26/09/22 12:25, Chen-Yu Tsai ha scritto:
> > top_early_divs are registered in the CLK_OF_DECLARE_DRIVER() half of the
> > topckgen clk driver. Don't try to register it again in the actual probe
> > function. This gets rid of the "Trying to register duplicate clock ..."
> > warning.
> >
> > Signed-off-by: Chen-Yu Tsai <wenst@chromium.org>
>
> Can't we simply remove the CLK_OF_DECLARE_DRIVER() and top_init_early entirely,
> and transfer TOP_CSW_F26M_D2 to top_divs[] instead?
> I get that systimer concern and we have something similar in MT8195, where the
> TOP_CLK26M_D2 is registered "late".

That was what I initially wanted to do. However I asked MTK whether the
system would work fully without systimer, and apparently it is used during
suspend (presumably it is supposed to be running?), so making it not
functional was a bit concerning.

That said, I do plan to rework the systimer stuff. The /2 divider is
actually internal to the systimer block, and should not have been modeled
the way it is now. Notably, the divider is actually variable. It is
only configured and locked by the bootloader.

For this I think we have two options:

a. Move the /2 fixed factor clock into a standalone device node, like
   what was done for the MT8195

b. Rework the systimer to internalize the divider, and thus moving the
   systimer input clock to osc26M.

Either one is outside the scope of this series. Option a. works especially
well for MT8192, as the configurable divider was removed from the systimer
block (only for this chip).

> Getting back to MT8192, TOP_CSW_F26M_D2 seems to be used only for:
> 1. systimer
> 2. SPMI MST (registered "late").
>
> Being it a fixed factor clock, parented to another fixed clock, it doesn't
> even have any ON/OFF switch, so I think it would be actually possible to go
> for the proposed removal... which would further improve this cleanup.

As mentioned above, I do have some plans to rework the stuff, but it is
kind of beyond the scope of this series, as it changes the device tree
binding and ABI.

Regards
ChenYu
