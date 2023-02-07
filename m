Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C06BB68D1F8
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Feb 2023 10:03:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230437AbjBGJDZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Feb 2023 04:03:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231352AbjBGJDX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Feb 2023 04:03:23 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DFF0E32E61;
        Tue,  7 Feb 2023 01:03:14 -0800 (PST)
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 6FF21660206B;
        Tue,  7 Feb 2023 09:03:12 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1675760593;
        bh=VuZqdr7n7xEXZB2d/3Tch4hTmLWr+acY4x8KfnIz+Rk=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=SSQhTqEygzg5uzZ50NmQK4QcjdMiB4BGLRNXDEyOCteBQHcWfawePtwxw3UcP8+7r
         gv6esvDmwVM3HvUZA9nvvy9qmOXAxnqtp9zS9+Vle3b/TApa8yr3WzIfaigQ2XgIFB
         T4K1GjCDtHVZoBB02oH4X90o1+0tko2cpOLx+EZ0kGQhf2HlObRapZVl0KraHm8Cpc
         IE1gPdz9t1CBzetVKqN5GcQp7mlBvcPC25Y2ioop6PAzwC5zqTJtIywRRDzhEsZcZm
         uG1HDjLBI7JtZVuXhkmRZMm/9SPoqU3HKUIrH6EMhcgeMuP9lomNU0TLUe4blVW86y
         5DxxHEcBDUASg==
Message-ID: <490f5fc6-d73a-40a5-5205-354d5bf844f3@collabora.com>
Date:   Tue, 7 Feb 2023 10:03:09 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH v1 33/45] clk: mediatek: Switch to
 module_platform_driver() where possible
Content-Language: en-US
To:     Chen-Yu Tsai <wenst@chromium.org>
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
References: <20230206152928.918562-1-angelogioacchino.delregno@collabora.com>
 <20230206152928.918562-34-angelogioacchino.delregno@collabora.com>
 <CAGXv+5FjV4WdJcjtT_VXC3W02noPC9+qVGv=FVW6UmPXSeqksQ@mail.gmail.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <CAGXv+5FjV4WdJcjtT_VXC3W02noPC9+qVGv=FVW6UmPXSeqksQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 07/02/23 07:37, Chen-Yu Tsai ha scritto:
> On Mon, Feb 6, 2023 at 11:30 PM AngeloGioacchino Del Regno
> <angelogioacchino.delregno@collabora.com> wrote:
>>
>> Lots of clock drivers have got both .probe() and a .remove() callbacks:
>> switch from builtin_platform_driver() to module_platform_driver() so
>> that we actually register the .remove() callback.
>>
>> Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
>> ---
> 
> [...]
> 
>>   drivers/clk/mediatek/clk-mt8195-vpp0.c         | 2 +-
>>   drivers/clk/mediatek/clk-mt8195-vpp1.c         | 2 +-
> 
> These two conflict with "clk: mediatek: remove MT8195 vppsys/0/1 simple_probe".
> Since the rest of the vppsys stuff has been queued up, I'd like to see
> that one get merged first so we don't have two drivers matching the same
> compatible string.
> 
> This conflict also causes the last "clk: mediatek: Add MODULE_DEVICE_TABLE()
> where appropriate" to not apply.
> 
> ChenYu

Yes that makes a lot of sense - this series is really big, so let's get the
8195 vppsys stuff merged in first.

I'll rebase on top of that for v2.

Angelo
