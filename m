Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1112468D25A
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Feb 2023 10:16:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231377AbjBGJQO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Feb 2023 04:16:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231390AbjBGJQK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Feb 2023 04:16:10 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D28F3608E;
        Tue,  7 Feb 2023 01:16:08 -0800 (PST)
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 00890660206D;
        Tue,  7 Feb 2023 09:16:05 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1675761367;
        bh=zdQ4SNWW8NQ4Lx0RrKv5KAvJWFgOPBJ6A6hrrkNxUKI=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=oEVkQXC/tcnpTYpkkdbQ7P6KVjXQXDRUSrpNiyY+xgwlzQIa+44va/bsVQDR7981f
         +dInYtP5ePialc2Hksvs14j+nl86QrwrBnj+Dm48OiOzVXw0oOH+TT8TUHjabELOXW
         FOm0i/mx+/viu5Yekbao6lMBBT2FTWx+AaqjzuqOWxXFlyR8+o8hA8jzjfC9wXWqKj
         vf05W2ILYDnzehLG7t1c9QWL8f1hUGALi6hbjB457drnsVuLLLjheZZ9M91w28Xgru
         VAbIV0W6B2wdblkT3DczNyRQJzvfvV0XvLd+EW8TqqYN01jZu9VnyGENSb2SxCHM11
         BaBI3wpHmEOEA==
Message-ID: <7c8cb8c8-9e53-3c52-37c1-e6a1e165097e@collabora.com>
Date:   Tue, 7 Feb 2023 10:16:03 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH v1 12/45] clk: mediatek: mt8365: Convert to
 mtk_clk_simple_{probe,remove}()
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
 <20230206152928.918562-13-angelogioacchino.delregno@collabora.com>
 <CAGXv+5G0+pbgz_6ajWOYNLYMOn4a9+pmPKFngUCrQEtwZe8vVg@mail.gmail.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <CAGXv+5G0+pbgz_6ajWOYNLYMOn4a9+pmPKFngUCrQEtwZe8vVg@mail.gmail.com>
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

Il 07/02/23 08:28, Chen-Yu Tsai ha scritto:
> On Mon, Feb 6, 2023 at 11:30 PM AngeloGioacchino Del Regno
> <angelogioacchino.delregno@collabora.com> wrote:
>>
>> Change the custom mt8365_simple_gate to be mtk_gate clocks and
>> audio clocks to be composites to be consistent with all of the
>> other MediaTek clock drivers, allowing to convert this entire
>> driver to use the common mtk_clk_simple_probe() mechanism that
>> also allows building this driver as module.
> 
> I think this would be easier to follow if it were split in half:
> the first half migrating mt8365_simple_gate to mtk_gate, and the
> second half converting to mtk_clk_simple_probe.
> 
> I assume git would generate better diffs after that.
> 
>> While at it, also perform some macro compression cleanups and
>> switch to use module_platform_driver().
> 
> This would get split in half as well. The macro cleanups go with the
> first half, and the switch to module_platform_driver goes with the
> second.
> 

I agree, entirely. Will do that on v2.

>> Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
>> ---
>>   drivers/clk/mediatek/clk-mt8365.c | 460 ++++++++----------------------
>>   1 file changed, 124 insertions(+), 336 deletions(-)
>>
>> diff --git a/drivers/clk/mediatek/clk-mt8365.c b/drivers/clk/mediatek/clk-mt8365.c
>> index 69f293497778..4bd624884b62 100644
>> --- a/drivers/clk/mediatek/clk-mt8365.c
>> +++ b/drivers/clk/mediatek/clk-mt8365.c
>> @@ -1,6 +1,7 @@
>>   // SPDX-License-Identifier: GPL-2.0
>>   /*
>>    * Copyright (C) 2022 MediaTek Inc.
>> + * Copyright (C) 2023 Collabora Ltd.
>>    */
>>
>>   #include <dt-bindings/clock/mediatek,mt8365-clk.h>
>> @@ -17,7 +18,6 @@
>>   #include "clk-gate.h"
>>   #include "clk-mtk.h"
>>   #include "clk-mux.h"
>> -#include "clk-pll.h"
> 
> This should be in the previous patch?
> 
> Could you also remove some of the other inclusions that don't get
> referenced after this patch?
> 
>>   static DEFINE_SPINLOCK(mt8365_clk_lock);
>>
>> @@ -383,31 +383,23 @@ static const char * const mbist_diag_parents[] = {
>>          "univpll2_d8"
>>   };
>>
>> -static const char * const apll_i2s0_parents[] = {
>> +static const char * const apll_i2s_parents[] = {
> 
> Misc. unmentioned change. It makes sense, but please mention it.
> 

Yes, definitely.

Thanks!
Angelo



