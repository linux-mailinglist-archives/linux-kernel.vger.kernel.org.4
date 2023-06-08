Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2DCB3727AB6
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Jun 2023 11:02:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235631AbjFHJCW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Jun 2023 05:02:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235601AbjFHJCD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Jun 2023 05:02:03 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1E87272E;
        Thu,  8 Jun 2023 02:02:02 -0700 (PDT)
Received: from [IPV6:2001:b07:2ed:14ed:a962:cd4d:a84:1eab] (unknown [IPv6:2001:b07:2ed:14ed:a962:cd4d:a84:1eab])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 95A3A66058B2;
        Thu,  8 Jun 2023 10:02:00 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1686214921;
        bh=LJ+HvhTd3r8A40SMUVKIa+zdl0EATp6N8y8llSkifhg=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=BPd1t8XBtn8+kBHTWacnnTywabw5crwx4HWW2ZfQqRkv3FSbaMc4djBmtqXiEdksT
         RY6LKQ0b5GUt/6dyETcf+oumayZ6S7ZcZOfevyRiSilJIOhUFYdABftjtGti7lEunk
         +aXTwE6wUY4U1NsAdbjDhJYBhs+mY1Kw5x5qrIAhka3/xOCsS4fmkLC8rT3AyndWZq
         Kg5O0bB14Evlq7oMBrdLUAw06uBRjWUDl4K43TPbOp2QzJZEwL3zunbcG5kYq51VB+
         DCgRzH0fZv4YQEgJBBUMta31sd00p32plSEebCoEjOnUb3dwdix1jSm2Hq0Sledf9M
         HjthEQ0dKa55w==
Message-ID: <f0018817-d47b-d772-ed9f-9126bf71a0d1@collabora.com>
Date:   Thu, 8 Jun 2023 11:01:58 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.2
Subject: Re: [PATCH v2 3/5] media: mediatek: vcodec: Read HW active status
 from clock
Content-Language: en-US
To:     Chen-Yu Tsai <wenst@chromium.org>,
        =?UTF-8?B?TsOtY29sYXMgRi4gUi4gQS4gUHJhZG8=?= 
        <nfraprado@collabora.com>, Stephen Boyd <sboyd@kernel.org>
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
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <CAGXv+5HHARvkCYfjPjRKgyWuzv-Dt215z1=yA+_tw4hyasdGQA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 08/06/23 10:12, Chen-Yu Tsai ha scritto:
> On Thu, Jun 8, 2023 at 4:57 AM Nícolas F. R. A. Prado
> <nfraprado@collabora.com> wrote:
>>
>> Remove the requirement of a VDEC_SYS reg iospace. To achieve that, rely
>> on the "active" clock being passed through the DT, and read its status
>> during IRQ handling to check whether the HW is active.
>>
>> The old behavior is still present when reg-names aren't supplied, as to
>> keep backward compatibility.
>>
>> Signed-off-by: Nícolas F. R. A. Prado <nfraprado@collabora.com>
>> ---
>>
>> (no changes since v1)
>>
>>   .../mediatek/vcodec/mtk_vcodec_dec_drv.c      | 59 +++++++++++++++----
>>   .../mediatek/vcodec/mtk_vcodec_dec_hw.c       | 20 +++++--
>>   .../mediatek/vcodec/mtk_vcodec_dec_pm.c       | 12 +++-
>>   .../platform/mediatek/vcodec/mtk_vcodec_drv.h |  1 +
>>   4 files changed, 74 insertions(+), 18 deletions(-)
>>
>> diff --git a/drivers/media/platform/mediatek/vcodec/mtk_vcodec_dec_drv.c b/drivers/media/platform/mediatek/vcodec/mtk_vcodec_dec_drv.c
>> index 9c652beb3f19..8038472fb67b 100644
>> --- a/drivers/media/platform/mediatek/vcodec/mtk_vcodec_dec_drv.c
>> +++ b/drivers/media/platform/mediatek/vcodec/mtk_vcodec_dec_drv.c
>> @@ -16,6 +16,7 @@
>>   #include <media/v4l2-mem2mem.h>
>>   #include <media/videobuf2-dma-contig.h>
>>   #include <media/v4l2-device.h>
>> +#include <linux/clk-provider.h>
> 
>                     ^^^^^^^^^^^^^^
> 
> This seems like a violation of the API separation.
> 
>>   #include "mtk_vcodec_drv.h"
>>   #include "mtk_vcodec_dec.h"
>> @@ -38,22 +39,29 @@ static int mtk_vcodec_get_hw_count(struct mtk_vcodec_dev *dev)
>>          }
>>   }
>>
>> +static bool mtk_vcodec_is_hw_active(struct mtk_vcodec_dev *dev)
>> +{
>> +       u32 cg_status = 0;
>> +
>> +       if (!dev->reg_base[VDEC_SYS])
>> +               return __clk_is_enabled(dev->pm.vdec_active_clk);
> 
> AFAIK this is still around for clk drivers that haven't moved to clk_hw.
> It shouldn't be used by clock consumers. Would it be better to just pass
> a syscon?
> 

This is a legit usage of __clk_is_enabled().... because that's what we're really
doing here, we're checking if a clock got enabled by the underlying MCU (as that
clock goes up after the VDEC boots).

If this is *not* acceptable as it is, we will have to add a clock API call to
check if a clock is enabled... but it didn't seem worth doing since we don't
expect anyone else to have any legit usage of that, or at least, we don't know
about anyone else needing that...

As for the syscon, that's something that we've been discussing as well... the
thing is: we're really *really* checking if a clock is enabled, so we should
be using clock related calls... reading from a syscon means that we'd have to
perform a register read (of.. again.. a clock) outside of the clock framework
which, in my opinion, wouldn't be clean; I'd expect that to become a bit messy
in the future too, should more MediaTek SoCs (I think MT8192/95 are already in
the list, Nicolas please correct me if I'm wrong here) need the same thing, as
we'd be adding more definitions around.

Cheers,
Angelo

