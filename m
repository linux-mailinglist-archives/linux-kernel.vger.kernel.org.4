Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 30CEF5EF5B7
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Sep 2022 14:50:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235029AbiI2Mur (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Sep 2022 08:50:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232080AbiI2Mun (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Sep 2022 08:50:43 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E432E12207D;
        Thu, 29 Sep 2022 05:50:42 -0700 (PDT)
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 0419566022AF;
        Thu, 29 Sep 2022 13:50:40 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1664455841;
        bh=W4hvA7XiCHkweWKtVQQQDwgKeQSoZdrUIBJphAwsUv4=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=Pkv1TP36XZwPEoSz/b4qGlcU78aN0fXyPvtAVCymrUncaArQ+2gPdy+HXRj7Rb/Mv
         TVTqMXNfnNmbInTi3/xUUPQ24Y1XA6vLBDOeLGQSL6Skyom66NDfJxGvbC6qZJzacp
         mCjAnTX0ot417sHgpNzDh4WuGGTroDI3+SXtNrg5RVNv9g2oKKogLbYoBlixWnzIPO
         gAfZBTY5uRdkH4NfXb2NYXXI9g80PBdDqocT0JWZdEo8YIsVwA+Z5U0PxMeY6YwXBD
         AMXu8mRxdiiWQgZt6eDBmX+/9Si/3Dalu6+VICb8Kb90d1QXJ/nJOPxA99okSbv8vQ
         uuqx1rR25kzMw==
Message-ID: <17c5cc9c-50ea-aeac-04e0-20b6c093c7ec@collabora.com>
Date:   Thu, 29 Sep 2022 14:50:38 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.0
Subject: Re: [PATCH v3] reset: mediatek: Move mediatek system clock reset to
 reset folder
Content-Language: en-US
To:     Bo-Chen Chen <rex-bc.chen@mediatek.com>, sboyd@kernel.org,
        mturquette@baylibre.com, matthias.bgg@gmail.com,
        p.zabel@pengutronix.de
Cc:     runyang.chen@mediatek.com, miles.chen@mediatek.com,
        wenst@chromium.org, nfraprado@collabora.com,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        Project_Global_Chrome_Upstream_Group@mediatek.com
References: <20220929121031.17523-1-rex-bc.chen@mediatek.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20220929121031.17523-1-rex-bc.chen@mediatek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 29/09/22 14:10, Bo-Chen Chen ha scritto:
> To manager mediatek system clock reset easier, we move the driver to
> drivers/reset.
> 
> The modifications in this series:
> - Move clk/mediatek/reset.c to reset/reset-mediatek-sysclk.c
> - Move reset data which are scattered around the mediatek drivers to
>    reset-mediatek-sysclk.c
> - For mtk clk drivers which support device, we can ues
>    mtk_reset_controller_register() to register reset controller using
>    auxiliary bus.
> - For mtk clk drivers which do not support device (only support
>    device_node), we use mtk_reset_{init/remove}_with_node to register
>    reset controller.
> 
> Signed-off-by: Bo-Chen Chen <rex-bc.chen@mediatek.com>

I've just analyzed this idea a bit more, and there's the outcome.

This driver would be fine, if some MediaTek SoCs weren't shipped with
a bootloader that supports only very small kernels... because then, if
the reset controller is not available at boot time, it's unlikely that
you can probe the eMMC or the uSD, so it won't be possible to actually
compile this driver as a module and load it afterwards.

Please don't misunderstand me: I like the idea of having the MediaTek
SoC sysclk reset controller as a ... reset controller driver but, to
make that work, one fundamental issue must be solved...

If the kernel is configured for, let's say, MT2701 and MT2712, we're
always building in reset controller support for MT7622, 7629, 8135, 8173,
8183, 8186, 8192, 8195 - and this list will grow with MT8188, and others.

Obviously, it's useless to have support for, say, MT7622, if the MT7622
system clock controllers aren't built-in, nor modules.

So, to make this idea to work, we have to find a way to:
1. Build in support only for the required SoC(s)
2. Put the reset index mapping arrays in SoC-specific files, or this
    single file driver will see an exponential growth.

Wrapping it up - as the driver is right now - we're losing flexibility:
we need to maintain the current flexibility while keeping the improvements
that are made with this proposal.

Ideas?

Regards,
Angelo

> ---
> Changes for v3:
> 1. Add reset bit of PCIE and USB for MT8195.
> 2. Rebased oo linux-next-0928.
> 
> Version for this series:
> v2 : https://lore.kernel.org/all/20220923045738.2027-1-rex-bc.chen@mediatek.com/
> v1 : https://lore.kernel.org/all/20220922141107.10203-1-rex-bc.chen@mediatek.com/
> RFC: https://lore.kernel.org/all/20220527090355.7354-1-rex-bc.chen@mediatek.com/

