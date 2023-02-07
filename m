Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 109FA68D249
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Feb 2023 10:13:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230215AbjBGJNK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Feb 2023 04:13:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230361AbjBGJNI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Feb 2023 04:13:08 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2EAAD25293;
        Tue,  7 Feb 2023 01:13:07 -0800 (PST)
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id C4D7E660206E;
        Tue,  7 Feb 2023 09:13:04 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1675761185;
        bh=+nHmOUUUbSXdP/e82tgIxtjXu2hnF5Fu3GtIeW8DNpA=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=n1oQGRjV5IfYBwT2+XXXTYOPFizrDBNGubR0+7h2BlqUpgXf5hq+hHU7u06Bnn2co
         l2rG53XC2slSEmtZgnM+p9D1ixxmDiQqIKMhusefnri7m8Y+feYi/ZP71kaYeSO33o
         UtsHC+tIRPgcvcvgGqZNSTEuISkyoVRKOt5e/9hIjmaZfhmS2xiI++nxz9Gs9N50cq
         2Bm92PXp29sikoTcqmvYC8P1cSCLRfCScDlpLsBc9zRTlvNB5VmOfJogusej+6GVTl
         brj7SpNCriNYuQZmW6wwU0RWP9F/J008WusbNSuaNro2AhQ7FIM1tYFOuZquU2yuKg
         cd1h836bXUBMQ==
Message-ID: <6417aaca-f58d-7195-1f88-9bf896e69a90@collabora.com>
Date:   Tue, 7 Feb 2023 10:13:02 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH v1 08/45] clk: mediatek: mt2712: Move apmixedsys clock
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
 <20230206152928.918562-9-angelogioacchino.delregno@collabora.com>
 <CAGXv+5EFKxx8-8aD1VeMpPmNsztPJMsirpDc4Nd17ZMi7ED_9Q@mail.gmail.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <CAGXv+5EFKxx8-8aD1VeMpPmNsztPJMsirpDc4Nd17ZMi7ED_9Q@mail.gmail.com>
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

Il 07/02/23 07:50, Chen-Yu Tsai ha scritto:
> On Mon, Feb 6, 2023 at 11:29 PM AngeloGioacchino Del Regno
> <angelogioacchino.delregno@collabora.com> wrote:
>>
>> The only clock driver that does not support mtk_clk_simple_probe() is
>> apmixedsys: in preparation for enabling module build of non-critical
>> mt2712 clocks, move this to its own file.
>> While at it, also fix some indentation issues in the PLLs table.
>>
>> Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
>> ---
>>   drivers/clk/mediatek/Makefile                |   2 +-
>>   drivers/clk/mediatek/clk-mt2712-apmixedsys.c | 152 +++++++++++++++++
>>   drivers/clk/mediatek/clk-mt2712.c            | 164 -------------------
>>   3 files changed, 153 insertions(+), 165 deletions(-)
>>   create mode 100644 drivers/clk/mediatek/clk-mt2712-apmixedsys.c
> 
> `git diff --color-moved=dimmed-zebra --color-moved-ws=ignore-all-space`
> agrees this is mostly code movement.
> 
>> diff --git a/drivers/clk/mediatek/Makefile b/drivers/clk/mediatek/Makefile
>> index e5d018270ed0..3c7dd19cdddf 100644
>> --- a/drivers/clk/mediatek/Makefile
>> +++ b/drivers/clk/mediatek/Makefile
>> @@ -38,7 +38,7 @@ obj-$(CONFIG_COMMON_CLK_MT2701_HIFSYS) += clk-mt2701-hif.o
>>   obj-$(CONFIG_COMMON_CLK_MT2701_IMGSYS) += clk-mt2701-img.o
>>   obj-$(CONFIG_COMMON_CLK_MT2701_MMSYS) += clk-mt2701-mm.o
>>   obj-$(CONFIG_COMMON_CLK_MT2701_VDECSYS) += clk-mt2701-vdec.o
>> -obj-$(CONFIG_COMMON_CLK_MT2712) += clk-mt2712.o
>> +obj-$(CONFIG_COMMON_CLK_MT2712) += clk-mt2712.o clk-mt2712-apmixedsys.o
>>   obj-$(CONFIG_COMMON_CLK_MT2712_BDPSYS) += clk-mt2712-bdp.o
>>   obj-$(CONFIG_COMMON_CLK_MT2712_IMGSYS) += clk-mt2712-img.o
>>   obj-$(CONFIG_COMMON_CLK_MT2712_JPGDECSYS) += clk-mt2712-jpgdec.o
>> diff --git a/drivers/clk/mediatek/clk-mt2712-apmixedsys.c b/drivers/clk/mediatek/clk-mt2712-apmixedsys.c
>> new file mode 100644
>> index 000000000000..e841be3a02c9
>> --- /dev/null
>> +++ b/drivers/clk/mediatek/clk-mt2712-apmixedsys.c
>> @@ -0,0 +1,152 @@
>> +// SPDX-License-Identifier: GPL-2.0-only
>> +/*
>> + * Copyright (c) 2017 MediaTek Inc.
>> + * Copyright (c) 2023 Collabora Ltd.
>> + * Author: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
> 
> I think the original author still applies, given you are mostly just
> moving the code?
> 

It does indeed, that was a big mistake on my side - my apologies.

> [...]
> 
>> +static const struct of_device_id of_match_clk_mt2712_apmixed[] = {
>> +       { .compatible = "mediatek,mt2712-apmixedsys" },
>> +       { /* sentinel */ }
>> +};
>> +
>> +static struct platform_driver clk_mt2712_apmixed_drv = {
>> +       .probe = clk_mt2712_apmixed_probe,
>> +       .driver = {
>> +               .name = "clk-mt2712",
> 
> I'd change the name as well, but I'm not sure if that constitutes a
> uAPI change.
> 

My intention was to change this name as well, I should've better
re-checked this kind of cosmetics before sending out - I focused too
much on other kinds of re-checking action.

Noted for v2.

Cheers,
Angelo
