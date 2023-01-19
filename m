Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7CD76673C06
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Jan 2023 15:31:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231187AbjASOb1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Jan 2023 09:31:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231716AbjASOaz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jan 2023 09:30:55 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14ED587299;
        Thu, 19 Jan 2023 06:29:28 -0800 (PST)
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 47BEB6600874;
        Thu, 19 Jan 2023 14:29:25 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1674138566;
        bh=p/A/jWIk2sK78OlSgWI3fy+vpqk60q5IY/hSeAcs6AY=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=AksgbLzNeb2yo5Q6rWlWYXCGSsU4Pw/YGPRQEW1/m2X3nIhXkAmzKvRiJFLQkhCgb
         ukyskjoKouGS2gXuEQJINq9XuoH6OYZsUt9oO28COwpJ7T22eLdTZ7AmsIo2dphiBp
         TyPFWJflc5dKPM7QADxTaqIOOoG12xtf2fJnqz/M2MwZp7vt5ww2+qtDmThvAsL1+A
         aZ73cLGHN43OnZ3/21dRCEk1nfVUNkbY4RfPNxK56KRa3vWDqPI9MPhx4ahriTCyKH
         8kVvCc1YbmOzwji4Zyr2Y1dyP3ZqS5tWPxRZnA4bjXC549UvdB/jdpvLWLEHtfYVdE
         j/yIeZyytE8Sg==
Message-ID: <b8fafc86-40fe-c0ef-1310-b4e284e14609@collabora.com>
Date:   Thu, 19 Jan 2023 15:29:22 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH 2/2] clk: mediatek: add MT7981 clock support
Content-Language: en-US
To:     Daniel Golle <daniel@makrotopia.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
Cc:     Chen-Yu Tsai <wenst@chromium.org>,
        Miles Chen <miles.chen@mediatek.com>,
        Edward-JW Yang <edward-jw.yang@mediatek.com>,
        Johnson Wang <johnson.wang@mediatek.com>,
        Fabien Parent <fparent@baylibre.com>,
        Chun-Jie Chen <chun-jie.chen@mediatek.com>,
        Sam Shih <sam.shih@mediatek.com>,
        Jianhui Zhao <zhaojh329@gmail.com>
References: <cover.1674137304.git.daniel@makrotopia.org>
 <d1718b4f9887664e56b56019b8d21470407c4aaf.1674137304.git.daniel@makrotopia.org>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <d1718b4f9887664e56b56019b8d21470407c4aaf.1674137304.git.daniel@makrotopia.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 19/01/23 15:12, Daniel Golle ha scritto:
> Add MT7986 clock support, include topckgen, apmixedsys, infracfg and
> ethernet subsystem clocks.
> 
> The drivers are based on clk-mt7981.c which can be found in MediaTek's
> SDK sources. To be fit for upstream inclusion the driver has been split
> into clock domains and the infracfg part has been significantly
> de-bloated by removing all the 1:1 factors (aliases).
> 
> Signed-off-by: Jianhui Zhao <zhaojh329@gmail.com>
> Signed-off-by: Daniel Golle <daniel@makrotopia.org>
> ---
>   drivers/clk/mediatek/Kconfig               |  17 +
>   drivers/clk/mediatek/Makefile              |   4 +
>   drivers/clk/mediatek/clk-mt7981-apmixed.c  | 103 +++++
>   drivers/clk/mediatek/clk-mt7981-eth.c      | 138 +++++++
>   drivers/clk/mediatek/clk-mt7981-infracfg.c | 236 +++++++++++
>   drivers/clk/mediatek/clk-mt7981-topckgen.c | 431 +++++++++++++++++++++
>   include/dt-bindings/clock/mt7981-clk.h     | 215 ++++++++++

dt-bindings go in a different commit; also, please follow binding rules for
filenames... mt7981-clk.h -> mediatek,mt7981-clk.h

>   7 files changed, 1144 insertions(+)
>   create mode 100644 drivers/clk/mediatek/clk-mt7981-apmixed.c
>   create mode 100644 drivers/clk/mediatek/clk-mt7981-eth.c
>   create mode 100644 drivers/clk/mediatek/clk-mt7981-infracfg.c
>   create mode 100644 drivers/clk/mediatek/clk-mt7981-topckgen.c
>   create mode 100644 include/dt-bindings/clock/mt7981-clk.h
> 

Moreover, I have pushed a pretty big cleanup series, which would reduce a bit
the size of the drivers that you're trying to introduce, and which is well
tested and reviewed: can you please rebase this on top of [1]?

Thanks!

[1]: https://patchwork.kernel.org/project/linux-mediatek/list/?series=711734

Regards,
Angelo
