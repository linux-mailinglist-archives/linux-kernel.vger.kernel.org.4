Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 49EB25E9861
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Sep 2022 06:08:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233220AbiIZEIq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Sep 2022 00:08:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233099AbiIZEIm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Sep 2022 00:08:42 -0400
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 914792A971
        for <linux-kernel@vger.kernel.org>; Sun, 25 Sep 2022 21:08:41 -0700 (PDT)
Received: by mail-ej1-x62b.google.com with SMTP id sb3so11393249ejb.9
        for <linux-kernel@vger.kernel.org>; Sun, 25 Sep 2022 21:08:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=sOR1HCqCWdSbaMEzOVaKKzwSu7f5OFySFkSjJn8FZ2A=;
        b=jaTx8wpigkGkl6A5tkPzCkLvUK2IHWtK9xhaqrVZA41hzheFEIRPLj2QcrcPOPefHc
         JSstJMgcFxyWDwexkjIT0qyJuCEdOETqE4iQkc26xhSFcMCmWIYnIpI/zLswMWrNbh3R
         XFETvnNFiuhUF8Mo16DRTZGw3gOXuEEWS4r5U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=sOR1HCqCWdSbaMEzOVaKKzwSu7f5OFySFkSjJn8FZ2A=;
        b=YVaYYXCqIr1+uASO/ydjmR/tbJH1c0rMjfeJ1IFTgQsImbigGFT8deaatO8VVC/MJ0
         OJUFWxLbxAV/oo0oTyDmsoJ62/eFyq/uEYi15/A+iLNygN/WYAwKY3ukc/LgWX7HM+D4
         KjSYVqMV4o98gfHCNhFd6MFs1IjmJqxJSNGyOX5E7jXqJUdLZLQuSrGo/gBTEQA+WNhT
         5E6mVuqHRL+iUrSw8UvAXDSx0qZm2gmQLOAUMM2jQqYHvk93WoKsCsgM9QGzpFrw9H0j
         UWQooBYaRlnv+5zCo0n3c4T3OLtxcDYNMC1Z2zTkSQ84H8KBOvgQt9VkMwrzFyRF2d0A
         6Wrg==
X-Gm-Message-State: ACrzQf1Z3acsQwl/U7BxJwC3BOq/7PM5Mk17axL9OCuxmzVvep/9il7u
        v+j0o5evxcZUXgRy/pPkPZK76zDOzqJyrWE+FNNoUIR4fwQ=
X-Google-Smtp-Source: AMsMyM6AbSZNeSyPM3bn5XK6eCiXpj0PURzOGegzp8trgtGVJOL93SxM/MGKL4DedKUbISaYwJlDjKgnCzZ8mSWa/xg=
X-Received: by 2002:a17:907:80d:b0:73d:1e3f:3d83 with SMTP id
 wv13-20020a170907080d00b0073d1e3f3d83mr15972482ejb.372.1664165320144; Sun, 25
 Sep 2022 21:08:40 -0700 (PDT)
MIME-Version: 1.0
References: <20220922091841.4099-1-miles.chen@mediatek.com> <20220922091841.4099-2-miles.chen@mediatek.com>
In-Reply-To: <20220922091841.4099-2-miles.chen@mediatek.com>
From:   Chen-Yu Tsai <wenst@chromium.org>
Date:   Mon, 26 Sep 2022 12:08:28 +0800
Message-ID: <CAGXv+5GitZopbd2FOC=9QxEG7SDYK7zy6JvsBoCXgeiM_j9E9g@mail.gmail.com>
Subject: Re: [PATCH 1/7] clk: mediatek: mt2701: use mtk_clk_simple_probe to
 simplify driver
To:     Miles Chen <miles.chen@mediatek.com>
Cc:     Stephen Boyd <sboyd@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        linux-kernel@vger.kernel.org,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Chun-Jie Chen <chun-jie.chen@mediatek.com>,
        linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
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

On Thu, Sep 22, 2022 at 5:18 PM Miles Chen <miles.chen@mediatek.com> wrote:
>
> mtk_clk_simple_probe was added by Chun-Jie to simply common flow
> of MediaTek clock drivers and ChenYu enhanced the error path of
> mtk_clk_simple_probe and added mtk_clk_simple_remove.
>
> Let's use mtk_clk_simple_probe and mtk_clk_simple_probe in other
> MediaTek clock drivers as well.
>
> Signed-off-by: Miles Chen <miles.chen@mediatek.com>
> Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>

Just FYI, but you should have your patch subject contain the proper version
tag, and not just on the cover letter. Patchwork gets confused otherwise.

ChenYu
