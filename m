Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D49C69A67C
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Feb 2023 09:03:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229670AbjBQIDD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Feb 2023 03:03:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229541AbjBQIDA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Feb 2023 03:03:00 -0500
Received: from mail-vs1-xe32.google.com (mail-vs1-xe32.google.com [IPv6:2607:f8b0:4864:20::e32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A1A45DE3F
        for <linux-kernel@vger.kernel.org>; Fri, 17 Feb 2023 00:02:27 -0800 (PST)
Received: by mail-vs1-xe32.google.com with SMTP id j40so2743454vsv.2
        for <linux-kernel@vger.kernel.org>; Fri, 17 Feb 2023 00:02:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=VcW8AG2TyLkBNE4Hu3VEFQ3wFgGW5n9M9IjZpHAujXM=;
        b=Ufr+SXBAXOeAF3Pfn6zF2CYkJbX5X9kEu0PnrJRw8Vz/YhPa9j9LzIw7wkJKS/xlFO
         U1PkKAWNRZDY6MEPwPjsaaYl27rcXPLkGE3MrQOMc18aB6Gr0nb8DyDprYWppiz56arD
         QEvvMi1JOOjHdf9OnoaOuKHCCUy5aFDgXhTL4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VcW8AG2TyLkBNE4Hu3VEFQ3wFgGW5n9M9IjZpHAujXM=;
        b=Z0Qs0wsR0IGClRkIlJyMxeHK88BenIkxTWJhr7Rrx729qqorL+0DwKYAJ/cEUolUDT
         PmIMlFxpXbZtVthpnDUjXhWxlztnpZCxpXGP9LOL5PXkWpcF3pxFIqmeX0ySGu10nRe3
         gTiYlbK3gh3qC+9wPr5sWo9RX2+zQ0QyBdheJQxH4gg2YQoMfRmt4pnL58WOCvCCovXD
         ogckqLyBpgEoP3+ncGL1sIx0XlAmS+XjfIMHD67l2t8AJ2KLwB880Ls4kmxatKJcxGA/
         Nw5UyAuu1vyS13VlCylA9oSRaNl5SR5at+LTs+dZ0lf/aBqZuz05VKUrkXbYBu+Tu3zy
         sSvQ==
X-Gm-Message-State: AO0yUKV5GbjEQzZKm9ITDz7gTc9LUiJkIIpapQ+q68/Xcj7um+uSnBcI
        +3SWQuNesYl/gdJ0hOF+8nTFFxsM1RwCMinyly0Iiw==
X-Google-Smtp-Source: AK7set/dcXJQTdYoBFqpLsFuJwG80t02UFy21lpWoaeP0BlAHVzzkYwngm6oaJzSjA7yR666ENfUJS7byME7bnLyZw8=
X-Received: by 2002:a67:f749:0:b0:3fc:58d:f90f with SMTP id
 w9-20020a67f749000000b003fc058df90fmr1614101vso.60.1676620946419; Fri, 17 Feb
 2023 00:02:26 -0800 (PST)
MIME-Version: 1.0
References: <20230214134127.59273-1-angelogioacchino.delregno@collabora.com> <20230214134127.59273-46-angelogioacchino.delregno@collabora.com>
In-Reply-To: <20230214134127.59273-46-angelogioacchino.delregno@collabora.com>
From:   Chen-Yu Tsai <wenst@chromium.org>
Date:   Fri, 17 Feb 2023 16:02:15 +0800
Message-ID: <CAGXv+5E+mkxNDc8kV+DwKVjmmF65555Pogh1OauwwKKqbrBz7A@mail.gmail.com>
Subject: Re: [PATCH v2 45/47] clk: mediatek: mt8192: Move apmixedsys clock
 driver to its own file
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

On Tue, Feb 14, 2023 at 9:42 PM AngeloGioacchino Del Regno
<angelogioacchino.delregno@collabora.com> wrote:
>
> This is the last man standing in clk-mt8192.c that won't allow us to
> use the module_platform_driver() macro, and for *no* good reason.
> Move it to clk-mt8192-apmixedsys.c and while at it, also add a
> .remove() callback for it.
>
> Also, since the need for "clk-mt8192-simple" and "clk-mt8192" was
> just due to them being in the same file and probing different clocks,
> and since now there's just one platform_driver struct per file, it
> seemed natural to rename the `-simple` variant to just "clk-mt8192".

All the above combined, I think this patch is doing a bit too much, but
splitting it probably doesn't make much sense either :/

> Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>

So a weak

Reviewed-by: Chen-Yu Tsai <wenst@chromium.org>

in case anyone objects.
