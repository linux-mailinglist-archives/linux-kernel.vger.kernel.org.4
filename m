Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 475D368D251
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Feb 2023 10:14:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231241AbjBGJOq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Feb 2023 04:14:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231202AbjBGJOp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Feb 2023 04:14:45 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE57123846;
        Tue,  7 Feb 2023 01:14:43 -0800 (PST)
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 83882660206E;
        Tue,  7 Feb 2023 09:14:41 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1675761282;
        bh=yDG4mGu6jtsVDMEGMmzjAKZKrGPZh4YUhRcgyE1cfUs=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=l/iQw3VkxE+7fb+CxtwD0ebMx+xBjEe9JmfU4bbY8M2ICYZimQdzfpt8npGgyYOW5
         Z7ey/3yNlPeLflDo53uPzKVtkCdaHeB1DACuUkr3Ozy9WWlpUVWFnSlg4Xn7Z7Qew4
         UeKEhQrFkUgPNoxmFJ8jL16Av9HBAjeRK6Ncnk7WzAggo4fQjravCuVaqnCcTbChWp
         vwljaIvv1g+hJwM+GPMEZiJHZJJF7kgTKadvaWIBbUvnqNugO/L6H4NExbXoyL8eKD
         rkFcnUFksRRF+aXuN3brfPb1bKNR4ZuE4ndS/TjxJVphtiwIlA9pDKJf4uM4+xBUOQ
         1Qz/Vr1d02ZPw==
Message-ID: <0cf002b1-73ca-29c4-6e6d-5b0a54d356de@collabora.com>
Date:   Tue, 7 Feb 2023 10:14:38 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH v1 11/45] clk: mediatek: mt8365: Move apmixedsys clock
 driver to its own file
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
 <20230206152928.918562-12-angelogioacchino.delregno@collabora.com>
 <CAGXv+5EvYq9eJkfvrEt-LEN0ODt-_tQ+wiAK-BjKeSi6VCDzEA@mail.gmail.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <CAGXv+5EvYq9eJkfvrEt-LEN0ODt-_tQ+wiAK-BjKeSi6VCDzEA@mail.gmail.com>
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

Il 07/02/23 08:12, Chen-Yu Tsai ha scritto:
> On Mon, Feb 6, 2023 at 11:30 PM AngeloGioacchino Del Regno
> <angelogioacchino.delregno@collabora.com> wrote:
>>
>> In preparation for migrating all other mt8365 clocks to the common
>> mtk_clk_simple_probe(), move apmixedsys clocks to a different file.
>> While at it, use the builtin_platform_driver() macro for it.
> 
> `git diff --color-moved=dimmed-zebra --color-moved-ws=ignore-all-space`
> agrees this is mostly a code move.
> 
>> Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
>> ---
>>   drivers/clk/mediatek/Makefile                |   2 +-
>>   drivers/clk/mediatek/clk-mt8365-apmixedsys.c | 164 +++++++++++++++++++
>>   drivers/clk/mediatek/clk-mt8365.c            | 142 ----------------
> 
> Reviewed-by: Chen-Yu Tsai <wenst@chromium.org>
> 
> But see below.
> 
>>   3 files changed, 165 insertions(+), 143 deletions(-)
>>   create mode 100644 drivers/clk/mediatek/clk-mt8365-apmixedsys.c
>>
>> diff --git a/drivers/clk/mediatek/Makefile b/drivers/clk/mediatek/Makefile
>> index 3c7dd19cdddf..b004a47026d4 100644
>> --- a/drivers/clk/mediatek/Makefile
>> +++ b/drivers/clk/mediatek/Makefile
>> @@ -112,7 +112,7 @@ obj-$(CONFIG_COMMON_CLK_MT8195) += clk-mt8195-apmixedsys.o clk-mt8195-topckgen.o
>>                                     clk-mt8195-venc.o clk-mt8195-vpp0.o clk-mt8195-vpp1.o \
>>                                     clk-mt8195-wpe.o clk-mt8195-imp_iic_wrap.o \
>>                                     clk-mt8195-apusys_pll.o
>> -obj-$(CONFIG_COMMON_CLK_MT8365) += clk-mt8365.o
>> +obj-$(CONFIG_COMMON_CLK_MT8365) += clk-mt8365.o clk-mt8365-apmixedsys.o
>>   obj-$(CONFIG_COMMON_CLK_MT8365_APU) += clk-mt8365-apu.o
>>   obj-$(CONFIG_COMMON_CLK_MT8365_CAM) += clk-mt8365-cam.o
>>   obj-$(CONFIG_COMMON_CLK_MT8365_MFG) += clk-mt8365-mfg.o
>> diff --git a/drivers/clk/mediatek/clk-mt8365-apmixedsys.c b/drivers/clk/mediatek/clk-mt8365-apmixedsys.c
>> new file mode 100644
>> index 000000000000..6f0fdf92bbd2
>> --- /dev/null
>> +++ b/drivers/clk/mediatek/clk-mt8365-apmixedsys.c
>> @@ -0,0 +1,164 @@
>> +// SPDX-License-Identifier: GPL-2.0-only
>> +/*
>> + * Copyright (c) 2022 MediaTek Inc.
>> + * Copyright (c) 2023 Collabora Ltd.
>> + */
>> +
>> +#include <dt-bindings/clock/mediatek,mt8365-clk.h>
>> +#include <linux/clk.h>
> 
> like in the MT2712 patch, this could be clk-provider.h .
> Or maybe we should do a pass of header cleanup? There's a bunch left
> over from the conversion from |struct clk| to |structk clk_hw|, and
> then migration to mtk_clk_simple_probe.
> 
> What do you think?
> 

I'm more for a separated pass of header cleanup, honestly...

Cheers,
Angelo

