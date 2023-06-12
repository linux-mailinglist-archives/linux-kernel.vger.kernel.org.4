Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EEB9472B88C
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Jun 2023 09:23:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233999AbjFLHXm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Jun 2023 03:23:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233172AbjFLHXj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Jun 2023 03:23:39 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A13D9E7B;
        Mon, 12 Jun 2023 00:18:38 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 712A162002;
        Mon, 12 Jun 2023 07:02:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2A54EC433EF;
        Mon, 12 Jun 2023 07:02:15 +0000 (UTC)
Message-ID: <380c6489-7a3c-778b-5b81-6339b6964b90@xs4all.nl>
Date:   Mon, 12 Jun 2023 09:02:13 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v2 0/5] Enable decoder for mt8183
Content-Language: en-US
To:     =?UTF-8?B?TsOtY29sYXMgRi4gUi4gQS4gUHJhZG8=?= 
        <nfraprado@collabora.com>,
        Matthias Brugger <matthias.bgg@gmail.com>
Cc:     kernel@collabora.com,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Andrew-CT Chen <andrew-ct.chen@mediatek.com>,
        Chen-Yu Tsai <wenst@chromium.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Miles Chen <miles.chen@mediatek.com>,
        Rob Herring <robh+dt@kernel.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Tiffany Lin <tiffany.lin@mediatek.com>,
        Yunfei Dong <yunfei.dong@mediatek.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-media@vger.kernel.org, linux-mediatek@lists.infradead.org
References: <20230607205714.510012-1-nfraprado@collabora.com>
From:   Hans Verkuil <hverkuil-cisco@xs4all.nl>
In-Reply-To: <20230607205714.510012-1-nfraprado@collabora.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Nicolas,

On 07/06/2023 22:53, Nícolas F. R. A. Prado wrote:
> 
> This series enables the hardware decoder present on mt8183. At first
> glance, the only missing piece is the devicetree node for it, however,
> simply adding it as is would cause an address collision between the
> first register iospace and the clock-controller node, so a rework of the
> dt-binding and driver, as well as addition of a clock, were needed
> first.
> 
> Tested that H264 decoding works with the hardware decoder on
> mt8183-kukui-jacuzzi-juniper-sku16, giving a fluster score of 98/135 on
> the JVT-AVC_V1 test suite. And ensured other SoCs (MT8192 and MT8195)
> still work as usual.
> 
> Changes in v2:
> - Merged commit 1 (media: dt-bindings: mediatek,vcodec: Allow single
>   clock for mt8183) into commit 3 (media: dt-bindings: mediatek,vcodec:
>   Remove VDEC_SYS for mt8183)
> - Further constrained properties in dt-binding
> - Added CLK_IGNORE_UNUSED flag to active clock
> - Reformatted reg-names in DT node
> 
> Nícolas F. R. A. Prado (4):
>   media: dt-bindings: mediatek,vcodec: Don't require assigned-clocks
>   media: dt-bindings: mediatek,vcodec: Remove VDEC_SYS for mt8183
>   media: mediatek: vcodec: Read HW active status from clock
>   clk: mediatek: mt8183: Add CLK_VDEC_ACTIVE to vdec

Is the clk patch independent from the others? It's not clear to me.

If the clk patch has to go in together with the media patches, then
please let me know and post a v3 where the clk patch is also CC-ed to
the linux-media mailinglist to ensure it ends up in our patchwork system.

And in that case I need a Acked-by from the clk maintainer as well.

If it is independent, then there is no need for a v3 (at least, not
for this).

Regards,

	Hans

> 
> Yunfei Dong (1):
>   arm64: dts: mediatek: mt8183: Add decoder
> 
>  .../media/mediatek,vcodec-decoder.yaml        | 65 +++++++++++++++----
>  arch/arm64/boot/dts/mediatek/mt8183.dtsi      | 30 +++++++++
>  drivers/clk/mediatek/clk-mt8183-vdec.c        |  5 ++
>  .../mediatek/vcodec/mtk_vcodec_dec_drv.c      | 59 +++++++++++++----
>  .../mediatek/vcodec/mtk_vcodec_dec_hw.c       | 20 ++++--
>  .../mediatek/vcodec/mtk_vcodec_dec_pm.c       | 12 +++-
>  .../platform/mediatek/vcodec/mtk_vcodec_drv.h |  1 +
>  include/dt-bindings/clock/mt8183-clk.h        |  3 +-
>  8 files changed, 165 insertions(+), 30 deletions(-)
> 

