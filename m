Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 61114712243
	for <lists+linux-kernel@lfdr.de>; Fri, 26 May 2023 10:33:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242716AbjEZIdi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 May 2023 04:33:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242692AbjEZIdf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 May 2023 04:33:35 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF4BD135;
        Fri, 26 May 2023 01:33:34 -0700 (PDT)
Received: from [IPV6:2001:b07:2ed:14ed:a962:cd4d:a84:1eab] (unknown [IPv6:2001:b07:2ed:14ed:a962:cd4d:a84:1eab])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id C96D46606E83;
        Fri, 26 May 2023 09:33:32 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1685090013;
        bh=WrowHc+4yGRPLiyYPvvG4JYOR+mPGcHxjVgb39lx+FA=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=g06/xOFhstlgqDPNyk+/b7fjllrKt0tkTDvq7y0ngnvPTprNQuq5i0YgwajJs9OQw
         X/4USKtVZL/Wu9KOcc2cIbxveNH4uoOaK7qTOq9yC7K/0CxV03XFrNO+q0puTfxDsR
         ApkxwhKWE6ufg5ra4TtGQ7Ma5JrML7zrZYgETMaGqhTkQuL/IInaT/LNDBxgaeg/78
         fLmcppUB9dd5UJE7gxFk5yedjn0F1t78UdQn2kGcG2HWsUgk0Cq0Xhexee6Idd0a/L
         6ME28Ex9/Umy0DJM0260BvM5gGO5X07i4iKe7cNj1Y3q2xbyuWHGZ4Je97B4oZUkr7
         cH7UXwUmFpq0A==
Message-ID: <2a60740f-782d-08d5-f62f-dcc67aaf4d32@collabora.com>
Date:   Fri, 26 May 2023 10:33:30 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.1
Subject: Re: [PATCH v2 2/2] clk: mediatek: mt8365: Fix index issue
Content-Language: en-US
To:     Alexandre Mergnat <amergnat@baylibre.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Chen-Yu Tsai <wenst@chromium.org>
Cc:     Markus Schneider-Pargmann <msp@baylibre.com>,
        linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
References: <20230517-fix-clk-index-v2-0-1b686cefcb7e@baylibre.com>
 <20230517-fix-clk-index-v2-2-1b686cefcb7e@baylibre.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20230517-fix-clk-index-v2-2-1b686cefcb7e@baylibre.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 25/05/23 16:50, Alexandre Mergnat ha scritto:
> Before the patch [1], the clock probe was done directly in the
> clk-mt8365 driver. In this probe function, the array which stores the
> data clocks is sized using the higher defined numbers (*_NR_CLOCK) in
> the clock lists [2]. Currently, with the patch [1], the specific
> clk-mt8365 probe function is replaced by the mtk generic one [3], which
> size the clock data array by adding all the clock descriptor array size
> provided by the clk-mt8365 driver.
> 
> Actually, all clock indexes come from the header file [2], that mean, if
> there are more clock (then more index) in the header file [2] than the
> number of clock declared in the clock descriptor arrays (which is the
> case currently), the clock data array will be undersized and then the
> generic probe function will overflow when it will try to write in
> "clk_data[CLK_INDEX]". Actually, instead of crashing at boot, the probe
> function returns an error in the log which looks like:
> "of_clk_hw_onecell_get: invalid index 135", then this clock isn't
> enabled.
> 
> Solve this issue by adding in the driver the missing clocks declared in
> the header clock file [2].
> 
> [1]: Commit ffe91cb28f6a ("clk: mediatek: mt8365: Convert to
>       mtk_clk_simple_{probe,remove}()")
> [2]: include/dt-bindings/clock/mediatek,mt8365-clk.h
> [3]: drivers/clk/mediatek/clk-mtk.c
> 
> Fixes: ffe91cb28f6a ("clk: mediatek: mt8365: Convert to mtk_clk_simple_{probe,remove}()")

This is not fixing the conversion, but the clock driver, as it originally missed
clock entries and hence was not compliant with its binding (header).
It worked before, probably, but this doesn't mean that this driver didn't contain
a logic mistake from the beginning :-)

So, add (or replace the current one with) the relevant Fixes tag...

Cheers,
Angelo

