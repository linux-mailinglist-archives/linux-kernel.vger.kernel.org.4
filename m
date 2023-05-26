Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BBD92712272
	for <lists+linux-kernel@lfdr.de>; Fri, 26 May 2023 10:42:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236721AbjEZImu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 May 2023 04:42:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242271AbjEZImq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 May 2023 04:42:46 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88A3399
        for <linux-kernel@vger.kernel.org>; Fri, 26 May 2023 01:42:45 -0700 (PDT)
Received: from [IPV6:2001:b07:2ed:14ed:a962:cd4d:a84:1eab] (unknown [IPv6:2001:b07:2ed:14ed:a962:cd4d:a84:1eab])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id BBF7E6606E87;
        Fri, 26 May 2023 09:42:43 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1685090564;
        bh=BNXanvyep5uBi6HyQ6HtMJheZQ49LWV8bcssg3dk5Ok=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=monxsZb1jFoOfAva4Maz69K5HYQAK5M2i3PjAjre83bOc3jlL/vQBm/0OgDIZO7aV
         uQcpW8/4KFqp06+S2hSO2lJpiAC+T5i06BOBWZTEAqkJt1ddf+a9SHpKwm1C0aePs8
         FUEE5r2Z1qiRx/IulDxmqFkiGT5uT270F9euJHJewsnkx3GjZQA4oa1rNrrAjDn4tU
         +QXwFSj3adBl7PBJQ7CGxDs+67OTfceKMr5jAb/W/1E6MZYpKjpQKfUOmSh4uLsp5Z
         uBkZvzzlwEggr0P2xzyKsQByKDBoJTLdDc0VZBfX+t2aHu/l/7Elhzzy+KV/jIIVJc
         oOv/81XHyDxyw==
Message-ID: <52dc6b40-9676-6e6c-de5c-5fad40e432ab@collabora.com>
Date:   Fri, 26 May 2023 10:42:41 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.1
Subject: Re: [PATCH v4 06/11] drm/mediatek: gamma: Use bitfield macros
Content-Language: en-US
To:     =?UTF-8?B?Q0sgSHUgKOiDoeS/iuWFiSk=?= <ck.hu@mediatek.com>,
        "chunkuang.hu@kernel.org" <chunkuang.hu@kernel.org>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mediatek@lists.infradead.org" 
        <linux-mediatek@lists.infradead.org>,
        "wenst@chromium.org" <wenst@chromium.org>,
        =?UTF-8?B?SmFzb24tSkggTGluICjmnpfnnb/npaUp?= 
        <Jason-JH.Lin@mediatek.com>,
        "kernel@collabora.com" <kernel@collabora.com>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "matthias.bgg@gmail.com" <matthias.bgg@gmail.com>
References: <20230518104857.124265-1-angelogioacchino.delregno@collabora.com>
 <20230518104857.124265-7-angelogioacchino.delregno@collabora.com>
 <069cbd4c325949e4662cec2d8547b6fcd111faf6.camel@mediatek.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <069cbd4c325949e4662cec2d8547b6fcd111faf6.camel@mediatek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 26/05/23 07:32, CK Hu (胡俊光) ha scritto:
> Hi, Angelo:
> 
> On Thu, 2023-05-18 at 12:48 +0200, AngeloGioacchino Del Regno wrote:
>> External email : Please do not click links or open attachments until
>> you have verified the sender or the content.
>>
>>
>> Make the code more robust and improve readability by using bitfield
>> macros instead of open coding bit operations.
>> While at it, also add a definition for LUT_BITS_DEFAULT.
>>
>> Signed-off-by: AngeloGioacchino Del Regno <
>> angelogioacchino.delregno@collabora.com>
>> Reviewed-by: Jason-JH.Lin <jason-jh.lin@mediatek.com>
>> ---
>>   drivers/gpu/drm/mediatek/mtk_disp_gamma.c | 41 ++++++++++++++-------
>> --
>>   1 file changed, 26 insertions(+), 15 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/mediatek/mtk_disp_gamma.c
>> b/drivers/gpu/drm/mediatek/mtk_disp_gamma.c
>> index 1592614b6de7..ed2aa1fb0171 100644
>> --- a/drivers/gpu/drm/mediatek/mtk_disp_gamma.c
>> +++ b/drivers/gpu/drm/mediatek/mtk_disp_gamma.c
>> @@ -3,6 +3,7 @@
>>    * Copyright (c) 2021 MediaTek Inc.
>>    */
>>
>> +#include <linux/bitfield.h>
>>   #include <linux/clk.h>
>>   #include <linux/component.h>
>>   #include <linux/module.h>
>> @@ -22,9 +23,16 @@
>>   #define GAMMA_LUT_EN                                   BIT(1)
>>   #define
>> GAMMA_DITHERING                                        BIT(2)
>>   #define DISP_GAMMA_SIZE                                0x0030
>> +#define DISP_GAMMA_SIZE_HSIZE                          GENMASK(28,
>> 16)
>> +#define DISP_GAMMA_SIZE_VSIZE                          GENMASK(12,
>> 0)
>>   #define DISP_GAMMA_LUT                         0x0700
>>
>> +#define DISP_GAMMA_LUT_10BIT_R                 GENMASK(29, 20)
>> +#define DISP_GAMMA_LUT_10BIT_G                 GENMASK(19, 10)
>> +#define DISP_GAMMA_LUT_10BIT_B                 GENMASK(9, 0)
>> +
>>   #define LUT_10BIT_MASK                         0x03ff
>> +#define LUT_BITS_DEFAULT                       10
> 
> This is used only for AAL after patch "drm/mediatek: gamma: Support
> specifying number of bits per LUT component", so I would like move AAL
> definition to AAL driver and pass it to gamma driver.
> 

Like LUT_SIZE_DEFAULT, this definition is not only for AAL but also for
the older gamma lut register layout.

In any case, I'll check if there's any clean way to pass AAL's gamma
size to this driver... it's a different "component", so this may get
complicated.

Let's see what I can come up with in v5...

Thanks,
Angelo

