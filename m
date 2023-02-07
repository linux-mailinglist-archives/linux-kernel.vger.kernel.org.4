Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 97FF068CF8A
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Feb 2023 07:37:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230224AbjBGGhg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Feb 2023 01:37:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229447AbjBGGhe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Feb 2023 01:37:34 -0500
Received: from mail-ua1-x936.google.com (mail-ua1-x936.google.com [IPv6:2607:f8b0:4864:20::936])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7B8C222E4
        for <linux-kernel@vger.kernel.org>; Mon,  6 Feb 2023 22:37:33 -0800 (PST)
Received: by mail-ua1-x936.google.com with SMTP id x21so1144820uaf.8
        for <linux-kernel@vger.kernel.org>; Mon, 06 Feb 2023 22:37:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=S/mLwk8/VVBrhfa6+5lxSIlHkjJ4T6hr1YCCbT0Qg1g=;
        b=LY5C6x5ALQg9snkrab2Qwr3cZyZCKjr29UMJ20Do3DosX1QBg1T8SyPYUh5MVRWGG3
         Wp1XhTO8b5Rp9tVRvWtTrvtEKQWHbZ+zHh42Dc5+pWVjr+w8WqGlpssDEbKYqe2DzwUG
         u6jsRw/taNBb9+ptSvVuAMRaVhosHowZ4F7B4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=S/mLwk8/VVBrhfa6+5lxSIlHkjJ4T6hr1YCCbT0Qg1g=;
        b=uRxL3Y2UtwX/TCyPgDDJp+AOdAp8T8cqY0P9lJ8iYrK+i0qqFWKe6WuFdXVcwJFrDj
         XSiShWhQadjHOURpMNOcXd7efyBw0SsQxW53OFRZMlR/cX729p/EMUX0jD6jmoWx8rJV
         Aumsvha1OVFN6rCaBhZR/rlIVlPcReaQSzPbWmwejG4UWvx7xodambnr1M4bldzWgmHz
         ++lExuLqUs60SfmuLGW5i/AX272c0V0ssdjgSCQ8+aKXHxVt/r8W63lgmvdKdSItcbZQ
         g4WHltFaoNhSWszDOAY6dxbLRTLYmj5cr9ujjB6hnkckncd6yM4BMNu+PuS2ZIZkNHG/
         UH0g==
X-Gm-Message-State: AO0yUKUtKm+GnQyh/oHSWIXkX+49bP45etVNBM6oo/i03mA2ANShMGn0
        K5+YDGTwf67FIpJ/hmQmKiNJWaR7uTojX4MnZSBvIw==
X-Google-Smtp-Source: AK7set+s3/+EOOTwnTt+Fj5G19N6k5DByCBAznUx9q6eZUWFVvTP5z6CKbaJ/gckiNnD/GCrTc7zSZxE0rfrQjty3MA=
X-Received: by 2002:ab0:76c4:0:b0:5f0:4676:e4f1 with SMTP id
 w4-20020ab076c4000000b005f04676e4f1mr411906uaq.44.1675751853046; Mon, 06 Feb
 2023 22:37:33 -0800 (PST)
MIME-Version: 1.0
References: <20230206152928.918562-1-angelogioacchino.delregno@collabora.com> <20230206152928.918562-34-angelogioacchino.delregno@collabora.com>
In-Reply-To: <20230206152928.918562-34-angelogioacchino.delregno@collabora.com>
From:   Chen-Yu Tsai <wenst@chromium.org>
Date:   Tue, 7 Feb 2023 14:37:22 +0800
Message-ID: <CAGXv+5FjV4WdJcjtT_VXC3W02noPC9+qVGv=FVW6UmPXSeqksQ@mail.gmail.com>
Subject: Re: [PATCH v1 33/45] clk: mediatek: Switch to module_platform_driver()
 where possible
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
> Lots of clock drivers have got both .probe() and a .remove() callbacks:
> switch from builtin_platform_driver() to module_platform_driver() so
> that we actually register the .remove() callback.
>
> Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
> ---

[...]

>  drivers/clk/mediatek/clk-mt8195-vpp0.c         | 2 +-
>  drivers/clk/mediatek/clk-mt8195-vpp1.c         | 2 +-

These two conflict with "clk: mediatek: remove MT8195 vppsys/0/1 simple_probe".
Since the rest of the vppsys stuff has been queued up, I'd like to see
that one get merged first so we don't have two drivers matching the same
compatible string.

This conflict also causes the last "clk: mediatek: Add MODULE_DEVICE_TABLE()
where appropriate" to not apply.

ChenYu
