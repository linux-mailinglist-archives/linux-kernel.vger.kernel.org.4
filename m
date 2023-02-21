Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9698769D975
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Feb 2023 04:45:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233051AbjBUDpk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Feb 2023 22:45:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232317AbjBUDpi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Feb 2023 22:45:38 -0500
Received: from mail-ua1-x933.google.com (mail-ua1-x933.google.com [IPv6:2607:f8b0:4864:20::933])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6CD2BCA29
        for <linux-kernel@vger.kernel.org>; Mon, 20 Feb 2023 19:45:37 -0800 (PST)
Received: by mail-ua1-x933.google.com with SMTP id x1so158032uav.9
        for <linux-kernel@vger.kernel.org>; Mon, 20 Feb 2023 19:45:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Cfuibyga3kBcPYS2RK8Q0rhkGtFXfRUtTm1VmlKCtmI=;
        b=MwOJMAu4C4BwoMTuljZj8PM7bIgbx+3783h0xl3r4CoGbA/Vm1iSJy+Q2khrV+7X45
         TH3CXPm06jtpwFkh08aND5340hknRrlKu/6XiaGgEW05/m6TbgyYIfMZULmKronFDec0
         NswtJhEXJOiuXqBK1DhvPkJmO7KNcHIPuchFE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Cfuibyga3kBcPYS2RK8Q0rhkGtFXfRUtTm1VmlKCtmI=;
        b=afiravxEGKfzNIvdC67iSWHMeOuPFC2AZWtNigdaeuyOY+dLzIuESgsBmPyaXKVfMZ
         d36tAqIdqJFY9lWcQXQc4tetui2c6vhA6a5Q1ir/fFq+Nkxd4bM2ngtoOmKwj46IwUNP
         +bFXyiWE3W+HCCmeAuJd3z+aInDKsVOGmMynZW8AgmuPUih9fHY5iTj8+YEoOKkjHxVd
         DQPojWM2sU7ImUIctwFqUxkE97MS5bXX3GXEv6qzgNSPnjkEK5lTJSnK7FtZAx1FB0bg
         yFO2MRtVaeVPQn67I62sYGBw6azl8qWWG4fDT09QnTLj7pz+sG1bnUIntw/SX3HrjiDE
         G2yg==
X-Gm-Message-State: AO0yUKUgz44BFVp96NF2PhH78GkRMU0N5OZZMze1PSf8cFbphyh8M8jP
        bEuW8Srx1RfDm1MWxpbxZi6Zf+LwM5dJsnnoBlmdKg==
X-Google-Smtp-Source: AK7set9sssRYKvNDSP4z192UFAq4Q6RMujJfk6fKp46gtcIEHXpa2JZkEjr830ufkrHiQa368xDo2jzjEb7Un/z/6pU=
X-Received: by 2002:a05:6130:3a7:b0:68d:10f8:b068 with SMTP id
 az39-20020a05613003a700b0068d10f8b068mr630828uab.1.1676951136616; Mon, 20 Feb
 2023 19:45:36 -0800 (PST)
MIME-Version: 1.0
References: <20230220150111.77897-1-angelogioacchino.delregno@collabora.com> <20230220150111.77897-4-angelogioacchino.delregno@collabora.com>
In-Reply-To: <20230220150111.77897-4-angelogioacchino.delregno@collabora.com>
From:   Chen-Yu Tsai <wenst@chromium.org>
Date:   Tue, 21 Feb 2023 11:45:25 +0800
Message-ID: <CAGXv+5GC6nhgMpYA+Zrajxy8EYgkzL957AzpoCgu4+V6Z9PO9g@mail.gmail.com>
Subject: Re: [PATCH v3 03/55] clk: mediatek: Migrate to mtk_clk_pdev_probe()
 for multimedia clocks
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

On Mon, Feb 20, 2023 at 11:01 PM AngeloGioacchino Del Regno
<angelogioacchino.delregno@collabora.com> wrote:
>
> Reduce duplication and simplify all MediaTek multimedia clock drivers
> by migrating away from defining custom probe functions for each driver
> and instead use mtk_clk_pdev_probe().
>
> While at it, also add a .remove() callback to all of the multimedia
> clock drivers where missing.
>
> Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
> Reviewed-by: Chen-Yu Tsai <wenst@chromium.org>
> ---
>  drivers/clk/mediatek/clk-mt2701-mm.c   | 31 +++++---------
>  drivers/clk/mediatek/clk-mt2712-mm.c   | 31 +++++---------
>  drivers/clk/mediatek/clk-mt6779-mm.c   | 24 +++++------
>  drivers/clk/mediatek/clk-mt6795-mm.c   | 55 +++++-------------------
>  drivers/clk/mediatek/clk-mt6797-mm.c   | 31 +++++---------
>  drivers/clk/mediatek/clk-mt8167-mm.c   | 47 +++++----------------
>  drivers/clk/mediatek/clk-mt8173-mm.c   | 58 +++++---------------------
>  drivers/clk/mediatek/clk-mt8183-mm.c   | 24 +++++------
>  drivers/clk/mediatek/clk-mt8186-mm.c   | 56 +++++--------------------
>  drivers/clk/mediatek/clk-mt8192-mm.c   | 29 +++++--------
>  drivers/clk/mediatek/clk-mt8195-vdo0.c | 55 +++++-------------------
>  drivers/clk/mediatek/clk-mt8195-vdo1.c | 57 ++++++-------------------

>  drivers/clk/mediatek/clk-mt8195-vpp0.c | 54 +++++-------------------
>  drivers/clk/mediatek/clk-mt8195-vpp1.c | 54 +++++-------------------

This doesn't apply for these two files. Can you rebase onto clk-next?
Stephen hand applied v6 and edited of the vpp patches, not the final v7
version, so the code is slightly different, even though the functionality
is the same.

ChenYu
