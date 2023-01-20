Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D4F1674FC0
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Jan 2023 09:50:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229648AbjATIuC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Jan 2023 03:50:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229619AbjATIuB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jan 2023 03:50:01 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2558F74960;
        Fri, 20 Jan 2023 00:49:58 -0800 (PST)
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id EB256660087F;
        Fri, 20 Jan 2023 08:49:55 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1674204596;
        bh=dtOCdLeTQE8zVSUcE8A4hi8VQQlIAstmK+GCMOpm3gw=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=dNmUuKaMEpcLhTJXo8+9pFLy257FUS5znKBB7aPeH8tiqJudb246wHzQ1/LV8XLKP
         RhfzW2YxAypWrQoAJUfYu+Mm64RVJwVQeTa6dtO7DAU8BW+7Gp+IRwG+n5fdkhldbp
         K3pmge3y07BdVmi/tAWxLuQZ8aZ6S43luTpzTIyVVruh1mTpG1Diwl/fu8fbdhuNbi
         BgTB12x5Db6a5k/Ady/vXeGRwWVV5B0w52XBfAtippXsZcWS7ZkjCP3PGF0THdimjK
         nHpAMlriHnf1jgt9E5gS5G7vgQdSWJn9PD8G0FJy8frYa+/aQqMgB0DVeb9yHo2Pv6
         R2pJz8iNvt0yQ==
Message-ID: <c4cf0c0d-9863-fa3a-88da-591c26e08188@collabora.com>
Date:   Fri, 20 Jan 2023 09:49:53 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH 0/3 v2] add support for clocks on MT7981 SoC
Content-Language: en-US
To:     Daniel Golle <daniel@makrotopia.org>, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-armkernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>
Cc:     Chen-Yu Tsai <wenst@chromium.org>,
        Miles Chen <miles.chen@mediatek.com>,
        Edward-JW Yang <edward-jw.yang@mediatek.com>,
        Johnson Wang <johnson.wang@mediatek.com>,
        Fabien Parent <fparent@baylibre.com>,
        Chun-Jie Chen <chun-jie.chen@mediatek.com>,
        Sam Shih <sam.shih@mediatek.com>,
        Jianhui Zhao <zhaojh329@gmail.com>
References: <cover.1674152610.git.daniel@makrotopia.org>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <cover.1674152610.git.daniel@makrotopia.org>
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

Il 20/01/23 02:24, Daniel Golle ha scritto:
> The MediaTek MT7981 SoC is quite similar to its big sibling, the
> MT7986. Hence most drivers can be reused and not much is missing the
> get also this SoC working on mainline Linux.
> 
> Start with a cleaned-up version of the clock drivers, based on what can
> also be found in MediaTek's SDK[1].
> 
> Upon request of AngeloGioacchino Del Regno this series has been rebased
> and adapted to be applied on top of the pending series
> "MediaTek clocks cleanups and improvements"[2]
> 
> Changes since v1:
>   * rebase and adapt on top of [2]
>   * split-off addition of dt-bindings header, fix filename
>   * changed commit title as requested

You didn't change it as requested :-P

> 
> [1]: https://git01.mediatek.com/plugins/gitiles/openwrt/feeds/mtk-openwrt-feeds/+/refs/heads/master/target/linux/mediatek/files-5.4/drivers/clk/mediatek/clk-mt7981.c
> [2]: https://patchwork.kernel.org/project/linux-mediatek/list/?series=711734
> 
> Daniel Golle (3):
>    dt-bindings: clk: Add apmixedsys/topckgen compatibles for MT7981
>    dt-bindings: clk: mediatek: add mt7981 clock IDs

s/clk/clock/g :-)

Regards,
Angelo


