Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 994D172F77E
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Jun 2023 10:13:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242795AbjFNINw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Jun 2023 04:13:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230250AbjFNINt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Jun 2023 04:13:49 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62D4FDF;
        Wed, 14 Jun 2023 01:13:48 -0700 (PDT)
Received: from [IPV6:2001:b07:2ed:14ed:c5f8:7372:f042:90a2] (unknown [IPv6:2001:b07:2ed:14ed:c5f8:7372:f042:90a2])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 183A2660217A;
        Wed, 14 Jun 2023 09:13:46 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1686730426;
        bh=hyikFg5Dz7zmi/EIssCCeZgYJGF+cMu28Xs3zEK/yXg=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=nJFxFvrVLB3tCXlMcGaXRilrFAQLRM/fy7Vi1Bi3RXUVY74Y1Vglz24j4iFuelm15
         OjYBDuIBDQXiu7iBFiNWZvn48twBqLM39gOIO/kOYV1IGaPL+ysUQvuZY6uXPcSZAq
         RrpNUIGxEws9kQWdSwZWb0IK1/D8iJYA7gy3PNnxw07/WkvfkU1JebbpJj28/BBsRz
         jNC/a1xM1l44nT64E73hbb8BEPMt5uX5tJLbYUDJE53kCiGtg6rtF+fG3LyvZN12vc
         DrkmYUhO5LrIDa1btKYJjTY/5XJ7+JxD8Ul/hPasZ+PftQ8PTn7vdVjb8jGG/NycYN
         NkyaqbxadSoOA==
Message-ID: <d2c11880-afc1-5c0b-229b-2a4080b22fba@collabora.com>
Date:   Wed, 14 Jun 2023 10:13:43 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.2
Subject: Re: [PATCH v2 3/5] media: mediatek: vcodec: Read HW active status
 from clock
Content-Language: en-US
To:     Stephen Boyd <sboyd@kernel.org>, Chen-Yu Tsai <wenst@chromium.org>,
        =?UTF-8?B?TsOtY29sYXMgRi4gUi4gQS4gUHJhZG8=?= 
        <nfraprado@collabora.com>
Cc:     Matthias Brugger <matthias.bgg@gmail.com>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>, kernel@collabora.com,
        Andrew-CT Chen <andrew-ct.chen@mediatek.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Tiffany Lin <tiffany.lin@mediatek.com>,
        Yunfei Dong <yunfei.dong@mediatek.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-media@vger.kernel.org, linux-mediatek@lists.infradead.org
References: <20230607205714.510012-1-nfraprado@collabora.com>
 <20230607205714.510012-4-nfraprado@collabora.com>
 <CAGXv+5HHARvkCYfjPjRKgyWuzv-Dt215z1=yA+_tw4hyasdGQA@mail.gmail.com>
 <f0018817-d47b-d772-ed9f-9126bf71a0d1@collabora.com>
 <83770481aa762b69738c27f9d9934dd9.sboyd@kernel.org>
 <90781ea3-d43a-6267-278c-184050fe456e@collabora.com>
 <d579dc00ed9877f9daf170134fe781e6.sboyd@kernel.org>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <d579dc00ed9877f9daf170134fe781e6.sboyd@kernel.org>
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

Il 12/06/23 21:19, Stephen Boyd ha scritto:
> Quoting AngeloGioacchino Del Regno (2023-06-09 00:42:13)
>> Il 09/06/23 01:56, Stephen Boyd ha scritto:
>>> Quoting AngeloGioacchino Del Regno (2023-06-08 02:01:58)
>>>> Il 08/06/23 10:12, Chen-Yu Tsai ha scritto:
>>>>> On Thu, Jun 8, 2023 at 4:57 AM Nícolas F. R. A. Prado
>>>>> <nfraprado@collabora.com> wrote:
>>>>>> diff --git a/drivers/media/platform/mediatek/vcodec/mtk_vcodec_dec_drv.c b/drivers/media/platform/mediatek/vcodec/mtk_vcodec_dec_drv.c
>>>>>> index 9c652beb3f19..8038472fb67b 100644
>>>>>> --- a/drivers/media/platform/mediatek/vcodec/mtk_vcodec_dec_drv.c
>>>>>> +++ b/drivers/media/platform/mediatek/vcodec/mtk_vcodec_dec_drv.c
>>>>>
>>>>> AFAIK this is still around for clk drivers that haven't moved to clk_hw.
>>>>> It shouldn't be used by clock consumers. Would it be better to just pass
>>>>> a syscon?
>>>>>
>>>>
>>>> This is a legit usage of __clk_is_enabled().... because that's what we're really
>>>> doing here, we're checking if a clock got enabled by the underlying MCU (as that
>>>> clock goes up after the VDEC boots).
>>>>
>>>> If this is *not* acceptable as it is, we will have to add a clock API call to
>>>> check if a clock is enabled... but it didn't seem worth doing since we don't
>>>> expect anyone else to have any legit usage of that, or at least, we don't know
>>>> about anyone else needing that...
>>>
>>> The design of the clk.h API has been that no clk consumer should need to
>>> find out if a clk is enabled. Instead, the clk consumer should enable
>>> the clk if they want it enabled. Is there no other way to know that the
>>> vcodec hardware is active?
>>>
>>
>> The firmware gives an indication of "boot done", but that's for the "core" part
>> of the vcodec... then it manages this clock internally to enable/disable the
>> "compute" IP of the decoder.
>>
>> As far as I know (and I've been researching about this) the firmware will not
>> give any "decoder powered, clocked - ready to get data" indication, and the
>> only way that we have to judge whether it is in this specific state or not is
>> to check if the "VDEC_ACTIVE" clock got enabled by the firmware.
> 
> Is Linux ever going to use clk consumer APIs like clk_enable/clk_disable
> on this VDEC_ACTIVE clk? If the answer is no, then there isn't any
> reason to put it in the clk framework, and probably syscon is the way to
> go for now.
> 

Not for the current platform, but that may change in future SoCs... we're not sure.

> Another approach could be to wait for some amount of time after telling
> firmware to power up and assume the hardware is active.
> 

That would be highly error prone though. Expecting that the HW is alive means that
we're 100% sure that both firmware and driver are doing the right thing at every
moment, which is something that we'd like to assume but, realistically, for safety
reasons we just don't.

Should we anyway go for a syscon *now* and then change it to a clock later, if any
new platform needs this as a clock?

I'm in doubt now on how to proceed.

> ----
> 
> I see that the __clk_is_enabled() API is being used in some other
> consumer drivers. I think at one point we were down to one or two users.
> I'll try to remove this function entirely, but it will still be possible
> to get at the clk_hw for a clk with __clk_get_hw() and then call
> clk_hw_is_enabled().
> 

Makes sense.

Regards,
Angelo
