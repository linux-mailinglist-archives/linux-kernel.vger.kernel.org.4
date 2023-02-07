Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4BCA068CF35
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Feb 2023 06:59:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229797AbjBGF7y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Feb 2023 00:59:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229462AbjBGF7x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Feb 2023 00:59:53 -0500
Received: from mail-vs1-xe2e.google.com (mail-vs1-xe2e.google.com [IPv6:2607:f8b0:4864:20::e2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C38F279BB
        for <linux-kernel@vger.kernel.org>; Mon,  6 Feb 2023 21:59:51 -0800 (PST)
Received: by mail-vs1-xe2e.google.com with SMTP id p10so15178062vsu.5
        for <linux-kernel@vger.kernel.org>; Mon, 06 Feb 2023 21:59:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=zYCBrgiptcIccQaoR1yFr00IgFPMzrEIhu4IjEnhkgg=;
        b=LlHXujmHCp9zs7IKT97LWrboG47EwQubQ7sfNVf5qAHR7BJ6WLHnXHsdYtwz5X0L7g
         JKjtaDMFiTLvm8F3kXA94FuvEwMrHWfDOvPBUchFS9xIqdKB3B9J2ioNQmzUkTsGCk6w
         UX9ughR6BhREXrhALLqD84j/T4ipl5ae+JCng=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zYCBrgiptcIccQaoR1yFr00IgFPMzrEIhu4IjEnhkgg=;
        b=sxcUwtLRzNrZf/1zUaVSli+b4v8jmCUo0SR0ytgMdjr+kM6/ymhR2IQClQHN6cwKR4
         zDQTWpOhzbd2BM0YhI3JEyI2t6D093bDRaTDJei30S0a/PF4yTZeDl228ZxXhEB5smLb
         CK2lOo4nv1RiBTi0IjuYXan1qTQ9ZFN1Z9sifLgqdMb3R1NFMQEAY2mxXd/lHa1WqE8D
         114Tj1I6KR9vcbHlsMpbWWSL0ByHtOS4D6QuMp3clfGTb/3FNlzbIoCH1576P/jRjkDL
         d5BVoneIZikVW9v/idxSqLYCwvK4FNqdxH/7s5IX3OSux1TetxAWq4f1ruTkMLbPQpLE
         KhiQ==
X-Gm-Message-State: AO0yUKUH2LwBRhLKuRLKvDkViQfvFMh87VtcMgBxHWJ+8oWzicH09Rh8
        24uU4RDEUshdK/iGe+s4k6y+JJNde6NNi8z/l9QNkQ==
X-Google-Smtp-Source: AK7set/0KGVG7XttQqf4/FRIWSRB4YO2NnGxWgc+i+WRT7rd5XTR77t3wZBV9Di5qnEkjLhLnkylNIoCRLfCU28oxWw=
X-Received: by 2002:a67:1904:0:b0:3e8:d5a8:3fbe with SMTP id
 4-20020a671904000000b003e8d5a83fbemr441325vsz.9.1675749590556; Mon, 06 Feb
 2023 21:59:50 -0800 (PST)
MIME-Version: 1.0
References: <20230206152928.918562-1-angelogioacchino.delregno@collabora.com> <20230206152928.918562-3-angelogioacchino.delregno@collabora.com>
In-Reply-To: <20230206152928.918562-3-angelogioacchino.delregno@collabora.com>
From:   Chen-Yu Tsai <wenst@chromium.org>
Date:   Tue, 7 Feb 2023 13:59:39 +0800
Message-ID: <CAGXv+5F3QqtjJ9n+OE0p+xT78Kau_KQ=dsU4=K3AEzCv_AEv7g@mail.gmail.com>
Subject: Re: [PATCH v1 02/45] clk: mediatek: clk-mtk: Introduce clk_mtk_pdev_{probe,remove}()
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

On Mon, Feb 6, 2023 at 11:29 PM AngeloGioacchino Del Regno
<angelogioacchino.delregno@collabora.com> wrote:
>
> Introduce functions clk_mtk_pdev_probe() and clk_mtk_pdev_remove():
> these will be useful to commonize the probe and remove handlers for
> multimedia (clk-mtxxxx-mm) drivers as these are registered by the
> mtk-mmsys driver instead of having their own devicetree compatible.
>
> In order to do this, the main logic of clk_mtk_simple{probe,remove}()
> was moved to new static __clk_mtk_simple_{probe,remove}() functions
> that take as parameter a pointer to struct device_node because when
> registering the clocks from mtk-mmsys we want to pass a pointer to
> the clock driver's parent (which is, obviously, mtk-mmsys) struct
> device_node instead.
>
> As for the clock driver's platform data: for the devicetree case, we
> keep using the standard match_data mechanism, else we retrieve it
> from an id_table.
>
> Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>

Reviewed-by: Chen-Yu Tsai <wenst@chromium.org>
