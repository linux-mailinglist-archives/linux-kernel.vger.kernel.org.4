Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B1DE68D310
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Feb 2023 10:41:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231646AbjBGJlZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Feb 2023 04:41:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231551AbjBGJlX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Feb 2023 04:41:23 -0500
Received: from mail-vs1-xe36.google.com (mail-vs1-xe36.google.com [IPv6:2607:f8b0:4864:20::e36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 087314ECA
        for <linux-kernel@vger.kernel.org>; Tue,  7 Feb 2023 01:41:22 -0800 (PST)
Received: by mail-vs1-xe36.google.com with SMTP id a24so15652948vsl.2
        for <linux-kernel@vger.kernel.org>; Tue, 07 Feb 2023 01:41:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=z47jquheaISlmvaf1FVEcgmJUQJ8XYLvl0oKGBE77is=;
        b=aYa9zIdLtif0FwTqlAZxpxZYrEurh8AKhOhMK3XToKB/QecPRTMdA1Fflvep/53b3L
         yvOUUxfWyt0mZhjXkWfy3hFC+RT/zoBQT/eEZXazsNpTqtgMvvgnkSS3490OHqoyahU+
         Y/grwzdCpJbh9rW94SKE1TcKDpHzazlb3HUHw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=z47jquheaISlmvaf1FVEcgmJUQJ8XYLvl0oKGBE77is=;
        b=OqzS5nn94r/eW+8/7Yc9qu3Zab6ROSR1dUrUbDdZknGQ/JXMu2CjdtrbWjdy9C69C9
         qR6QOKekkDWiD6t5pIvQ0UxV6AQir1oVuaJJsVSJrMl6twL6uSIkS4VjlE3vkyCwIAr4
         p+275o9PNr9h1oEJnmp8p9W26xpsShfHn9YZ8h2tgkWFiHoDiHiNy4EOTK5tpL8DF2Dp
         q3993CPkK26hwswQ1k8FEvD7xuz+3txRrnGoTspygABOkKKJxW/+ZeTj1e1WFURS2UZN
         1T6QMI14K8b1C28CDc99NftfxKDdLZqtGYX6/Q8zzt7DgTN9EGrMVcf+96sZKj16sxs8
         0z3A==
X-Gm-Message-State: AO0yUKWlNPO9tfKLbIvrm4x6MK42N5votGjIdauxjyS7xE5KFKFSON3U
        srN5xfjXS1fS9H5/232ykU3RfRsdmxCleIs1f1ok1Q==
X-Google-Smtp-Source: AK7set/0Pocl3IQY+0CFHfoLLcC5bZPmOMEhu0z0xP0ngcuSbBnObUD0C6IFTIgXY/RCiQll0BfBa+K/EcxnU37xCoU=
X-Received: by 2002:a67:d206:0:b0:3ed:2cd6:deed with SMTP id
 y6-20020a67d206000000b003ed2cd6deedmr644186vsi.65.1675762881149; Tue, 07 Feb
 2023 01:41:21 -0800 (PST)
MIME-Version: 1.0
References: <20230206152928.918562-1-angelogioacchino.delregno@collabora.com> <20230206152928.918562-19-angelogioacchino.delregno@collabora.com>
In-Reply-To: <20230206152928.918562-19-angelogioacchino.delregno@collabora.com>
From:   Chen-Yu Tsai <wenst@chromium.org>
Date:   Tue, 7 Feb 2023 17:41:10 +0800
Message-ID: <CAGXv+5GYFv_Eqzbv9w4T6XWjuC-wnSp6Djj74dymChfXj6UXCw@mail.gmail.com>
Subject: Re: [PATCH v1 18/45] clk: mediatek: mt8183: Compress clocks arrays
 entries where possible
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

On Mon, Feb 6, 2023 at 11:30 PM AngeloGioacchino Del Regno
<angelogioacchino.delregno@collabora.com> wrote:
>
> Increase human readability and decrease number of lines by compressing
> the clock array entries where possible, to a maximum of ~90 columns.
>
> Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
> ---
>  drivers/clk/mediatek/clk-mt8183.c | 432 ++++++++++--------------------
>  1 file changed, 144 insertions(+), 288 deletions(-)

wdiff agrees. I'd go up to 100 columns though. Should be able to squeeze
out a couple more lines.
