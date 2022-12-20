Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C2BCE65213B
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Dec 2022 14:05:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233825AbiLTNFh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Dec 2022 08:05:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233846AbiLTNFW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Dec 2022 08:05:22 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC29915829;
        Tue, 20 Dec 2022 05:05:20 -0800 (PST)
Received: from [IPV6:2a01:e0a:120:3210:bf7d:b502:d93b:e4e3] (unknown [IPv6:2a01:e0a:120:3210:bf7d:b502:d93b:e4e3])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: benjamin.gaignard)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 2ABFD6602CA4;
        Tue, 20 Dec 2022 13:05:19 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1671541519;
        bh=OZ5V6cubKSs1/Cqc7qWLtyNRVl+rKSAvSR5Yfr2fDJM=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=Eelb0qPONmvnhvRWV6iOO/SnhhjV8OLKGMn0n+F23B8Yx17pTHBUr5CoA6czuzfjR
         iVmfuQhEY4Fm49gXzubK4JZ3ARNdXnxghDJ8JCJAdpfCqloVOG71TSn2vVvqhQqp9z
         fYyyMPCc8p8KlDwA/wq0Kjwg4y70NUFyICN9fCZdde/MQPOYL0Pwx6XlOUC9pdOaag
         dH+r13qlZ/58guRIylb0a2FTcpUw6aDEA8gqNAAhG37d8BEkCIeAQeRic7mYzSnt2L
         dVSzXA0piLq0qpu1qoQXmvEelsFJHU+QiOc63IRuSfBRjGzNlPhRrvLeWY1pr0JdnS
         BwXoJYNKzlkbQ==
Message-ID: <d5191316-97d1-185a-703d-c0932f91c9ee@collabora.com>
Date:   Tue, 20 Dec 2022 14:05:16 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH v1 3/9] media: verisilicon: Save bit depth for AV1 decoder
Content-Language: en-US
To:     Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>,
        Nicolas Dufresne <nicolas@ndufresne.ca>
Cc:     p.zabel@pengutronix.de, mchehab@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, heiko@sntech.de,
        daniel.almeida@collabora.com, nicolas.dufresne@collabora.co.uk,
        linux-media@vger.kernel.org, linux-rockchip@lists.infradead.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, kernel@collabora.com
References: <20221219155616.848690-1-benjamin.gaignard@collabora.com>
 <20221219155616.848690-4-benjamin.gaignard@collabora.com>
 <07747babe7f83a496f9cd82849c6c2386550ac28.camel@ndufresne.ca>
 <CAAEAJfDoX_aSTg1TO8F21iSriYeTXtRbHPo8wxx5br2v6eCt7Q@mail.gmail.com>
From:   Benjamin Gaignard <benjamin.gaignard@collabora.com>
In-Reply-To: <CAAEAJfDoX_aSTg1TO8F21iSriYeTXtRbHPo8wxx5br2v6eCt7Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Le 19/12/2022 à 22:29, Ezequiel Garcia a écrit :
> Bonjour Nicolas,
>
> On Mon, Dec 19, 2022 at 5:37 PM Nicolas Dufresne <nicolas@ndufresne.ca> wrote:
>> Le lundi 19 décembre 2022 à 16:56 +0100, Benjamin Gaignard a écrit :
>>> Store bit depth information from AV1 sequence control.
>>>
>>> Signed-off-by: Benjamin Gaignard <benjamin.gaignard@collabora.com>
>>> ---
>>>   .../media/platform/verisilicon/hantro_drv.c   | 26 +++++++++++++++++++
>>>   1 file changed, 26 insertions(+)
>>>
>>> diff --git a/drivers/media/platform/verisilicon/hantro_drv.c b/drivers/media/platform/verisilicon/hantro_drv.c
>>> index 4500e1fc0f2c..8e93710dcfed 100644
>>> --- a/drivers/media/platform/verisilicon/hantro_drv.c
>>> +++ b/drivers/media/platform/verisilicon/hantro_drv.c
>>> @@ -324,6 +324,25 @@ static int hantro_vp9_s_ctrl(struct v4l2_ctrl *ctrl)
>>>        return 0;
>>>   }
>>>
>>> +static int hantro_av1_s_ctrl(struct v4l2_ctrl *ctrl)
>>> +{
>>> +     struct hantro_ctx *ctx;
>>> +
>>> +     ctx = container_of(ctrl->handler,
>>> +                        struct hantro_ctx, ctrl_handler);
>>> +
>>> +     switch (ctrl->id) {
>>> +     case V4L2_CID_STATELESS_AV1_SEQUENCE:
>>> +             ctx->bit_depth = ctrl->p_new.p_av1_sequence->bit_depth;
>> That seems a little be weak, what happens if you change the bit_depth with a
>> non-request s_ctrl while its decoding ? To be this deserve a little bit of
>> protection, a something that validate and copy it at the start of the decoding.
>>
> Oh, nice catch. We need to return EBUSY, see
> https://www.kernel.org/doc/html/v5.0/media/uapi/v4l/buffer.html#interactions-between-formats-controls-and-buffers.
>
> There's already an API in the V4L2 control framework for drivers to use,
> see v4l2_ctrl_grab in
> https://www.kernel.org/doc/html/v5.0/media/kapi/v4l2-controls.html#active-and-grabbed-controls.
>
>> p.s. I know, VP9 seems similar, though arguably that was copied from jpeg, for
>> which it seems totally save to change the quality at run-time.
>>
> No, wasn't copied from JPEG :-) I just didn't realize this was an
> issue, but it is
> given the bit_depth affects the buffers so you are correct, it needs
> to be fixed for VP9 too.

I will use v4l2_ctrl_grab() in codecs->ops init() and exit() functions
but it will be on patch 7 because it where they appear for this codec.

Benjamin

>
> Thanks!
> Ezequiel
>
>>> +             break;
>>> +     default:
>>> +             return -EINVAL;
>>> +     }
>>> +
>>> +     return 0;
>>> +}
>>> +
>>> +
>>>   static const struct v4l2_ctrl_ops hantro_ctrl_ops = {
>>>        .try_ctrl = hantro_try_ctrl,
>>>   };
>>> @@ -336,6 +355,12 @@ static const struct v4l2_ctrl_ops hantro_vp9_ctrl_ops = {
>>>        .s_ctrl = hantro_vp9_s_ctrl,
>>>   };
>>>
>>> +static const struct v4l2_ctrl_ops hantro_av1_ctrl_ops = {
>>> +     .try_ctrl = hantro_try_ctrl,
>>> +     .s_ctrl = hantro_av1_s_ctrl,
>>> +};
>>> +
>>> +
>>>   #define HANTRO_JPEG_ACTIVE_MARKERS   (V4L2_JPEG_ACTIVE_MARKER_APP0 | \
>>>                                         V4L2_JPEG_ACTIVE_MARKER_COM | \
>>>                                         V4L2_JPEG_ACTIVE_MARKER_DQT | \
>>> @@ -513,6 +538,7 @@ static const struct hantro_ctrl controls[] = {
>>>                .codec = HANTRO_AV1_DECODER,
>>>                .cfg = {
>>>                        .id = V4L2_CID_STATELESS_AV1_SEQUENCE,
>>> +                     .ops = &hantro_av1_ctrl_ops,
>>>                },
>>>        }, {
>>>                .codec = HANTRO_AV1_DECODER,
