Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0910965E647
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Jan 2023 08:52:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230320AbjAEHwZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Jan 2023 02:52:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229527AbjAEHwW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jan 2023 02:52:22 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34D2114028;
        Wed,  4 Jan 2023 23:52:21 -0800 (PST)
Received: from [IPV6:2a01:e0a:120:3210:ead5:88fc:cd91:c042] (unknown [IPv6:2a01:e0a:120:3210:ead5:88fc:cd91:c042])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: benjamin.gaignard)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id AE3B96602D29;
        Thu,  5 Jan 2023 07:52:18 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1672905139;
        bh=I9+kXg3GpKIbjc5YSQXZHG/6U6cH7e+ZQgdfpA18EMM=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=ADMxEGvXipnJKcNj5GP8AvdiMDBFxRXT0YpNOYNJa6CJrbl5t8ZhHfXTnCnwQMKS8
         kLfG9Uzw3qA6trfC776ndavgII8win/f4eE7Y2jmBP1Gd/OqWLhOMgLl67mMZzv3um
         uCAxkniZaXgx4Vgq4v7MeRUz1QemNSASGs4f5T9A4s9lfzgkc8/ib1Vc7SSnbN3dON
         joXSvfmO2qBdpt6GaZRNE4FuHtThJ7vprYUIWrgsNQieZaS7VL2UOmu2gHv11xpEs/
         Md92k1tfQYJQJWigRxJDVAQyqWq7cVh/Abyb7rbK0M9vg1b56+01ZgbbQa4MBKWow9
         aH7V00V9V5giw==
Message-ID: <20ff6ebe-7469-444a-f9f4-cb8b38e31538@collabora.com>
Date:   Thu, 5 Jan 2023 08:52:15 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH v2 07/13] media: verisilicon: Check AV1 bitstreams bit
 depth
To:     Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>
Cc:     p.zabel@pengutronix.de, mchehab@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, heiko@sntech.de,
        daniel.almeida@collabora.com, nicolas.dufresne@collabora.co.uk,
        linux-media@vger.kernel.org, linux-rockchip@lists.infradead.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, kernel@collabora.com
References: <20230103170058.810597-1-benjamin.gaignard@collabora.com>
 <20230103170058.810597-8-benjamin.gaignard@collabora.com>
 <CAAEAJfBpGwa-ZDFFCep8rk4+dgLrYOFdfyrqBZP68C+jkN0qMQ@mail.gmail.com>
Content-Language: en-US
From:   Benjamin Gaignard <benjamin.gaignard@collabora.com>
In-Reply-To: <CAAEAJfBpGwa-ZDFFCep8rk4+dgLrYOFdfyrqBZP68C+jkN0qMQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Le 04/01/2023 à 20:33, Ezequiel Garcia a écrit :
> Hi Benjamin,
>
> Thanks for the patch.
>
> On Tue, Jan 3, 2023 at 2:01 PM Benjamin Gaignard
> <benjamin.gaignard@collabora.com> wrote:
>> The driver supports 8 and 10 bits bitstreams, make sure to discard
>> other cases.
>>
>> Signed-off-by: Benjamin Gaignard <benjamin.gaignard@collabora.com>
>> ---
>>   drivers/media/platform/verisilicon/hantro_drv.c | 14 +++++++++++++-
>>   1 file changed, 13 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/media/platform/verisilicon/hantro_drv.c b/drivers/media/platform/verisilicon/hantro_drv.c
>> index 8e93710dcfed..16539e89935c 100644
>> --- a/drivers/media/platform/verisilicon/hantro_drv.c
>> +++ b/drivers/media/platform/verisilicon/hantro_drv.c
>> @@ -282,7 +282,13 @@ static int hantro_try_ctrl(struct v4l2_ctrl *ctrl)
>>                  /* We only support profile 0 */
>>                  if (dec_params->profile != 0)
>>                          return -EINVAL;
>> +       } else if (ctrl->id == V4L2_CID_STATELESS_AV1_SEQUENCE) {
>> +               const struct v4l2_ctrl_av1_sequence *sequence = ctrl->p_new.p_av1_sequence;
>> +
>> +               if (sequence->bit_depth != 8 && sequence->bit_depth != 10)
>> +                       return -EINVAL;
>>          }
>> +
>>          return 0;
>>   }
>>
>> @@ -333,7 +339,13 @@ static int hantro_av1_s_ctrl(struct v4l2_ctrl *ctrl)
>>
>>          switch (ctrl->id) {
>>          case V4L2_CID_STATELESS_AV1_SEQUENCE:
>> -               ctx->bit_depth = ctrl->p_new.p_av1_sequence->bit_depth;
>> +               int bit_depth = ctrl->p_new.p_av1_sequence->bit_depth;
>> +
>> +               if (vb2_is_streaming(v4l2_m2m_get_src_vq(ctx->fh.m2m_ctx)))
>> +                       if (ctx->bit_depth != bit_depth)
>> +                               return -EINVAL;
>> +
> Please use the v4l2_ctrl_grab API. Can you send a separate series to address
> this for the other codecs?

I have tried to use v4l2_ctrl_grab API but when you grab a control you can set it anymore
and V4L2_CID_STATELESS_AV1_SEQUENCE is send for each frame so it blocks everything.

Benjamin

>
> Thanks a lot!
> Ezequiel
>
>> +               ctx->bit_depth = bit_depth;
>>                  break;
>>          default:
>>                  return -EINVAL;
>> --
>> 2.34.1
>>
