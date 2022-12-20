Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B500F652127
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Dec 2022 14:02:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233837AbiLTNCs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Dec 2022 08:02:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233810AbiLTNC0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Dec 2022 08:02:26 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0F761403A;
        Tue, 20 Dec 2022 05:02:21 -0800 (PST)
Received: from [IPV6:2a01:e0a:120:3210:bf7d:b502:d93b:e4e3] (unknown [IPv6:2a01:e0a:120:3210:bf7d:b502:d93b:e4e3])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: benjamin.gaignard)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id D83F36602CA4;
        Tue, 20 Dec 2022 13:02:19 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1671541340;
        bh=haA6w9EmCpkqi5iB2LLsKdnh/6FRvbucp0GFooZKrYY=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=Ig+qjYbgy6FmCKIolAqd/b+GmUivS+lSt3G3l1Jky716MRoHegVUU/ybihyrv7VZp
         Kw6t2o6sGuTp8iSV/p7h1I1Bx60Yn2/R0Yz92bD8CpzY/32VjOgI4dVJF7IAnUr/wI
         YIvlidIoBzkNi1jZqow35Y6HWkT6LLeCEUkyI19rfYCjQvvPmMS/shlpl0sgqtAtvC
         sAqxuLw6gENlQnloy2hk8RfLXMvYqYozSweCl1Daee9MYSnGS4kJzwxmTiB9M56R30
         3U2MWzr2HgLc/omi6nDnD9GOQlKZCziVddk/qPypwQTpcYjc0GdwjWF3bQiMOrRhXF
         0anirHn4J3A4w==
Message-ID: <4aae8684-5ab4-c5a6-cc73-5dc61309b745@collabora.com>
Date:   Tue, 20 Dec 2022 14:02:17 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH v1 4/9] media: verisilicon: Check AV1 bitstreams bit depth
Content-Language: en-US
To:     Nicolas Dufresne <nicolas@ndufresne.ca>,
        ezequiel@vanguardiasur.com.ar, p.zabel@pengutronix.de,
        mchehab@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, heiko@sntech.de,
        daniel.almeida@collabora.com, nicolas.dufresne@collabora.co.uk
Cc:     linux-media@vger.kernel.org, linux-rockchip@lists.infradead.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, kernel@collabora.com
References: <20221219155616.848690-1-benjamin.gaignard@collabora.com>
 <20221219155616.848690-5-benjamin.gaignard@collabora.com>
 <e3663c85c75d09259a3135cb6ccfe7d6231bd752.camel@ndufresne.ca>
From:   Benjamin Gaignard <benjamin.gaignard@collabora.com>
In-Reply-To: <e3663c85c75d09259a3135cb6ccfe7d6231bd752.camel@ndufresne.ca>
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


Le 19/12/2022 à 21:38, Nicolas Dufresne a écrit :
> Le lundi 19 décembre 2022 à 16:56 +0100, Benjamin Gaignard a écrit :
>> The driver supports 8 and 10 bits bitstreams, make sure to discard
>> other cases.
>>
>> Signed-off-by: Benjamin Gaignard <benjamin.gaignard@collabora.com>
>> ---
>>   drivers/media/platform/verisilicon/hantro_drv.c | 6 ++++++
>>   1 file changed, 6 insertions(+)
>>
>> diff --git a/drivers/media/platform/verisilicon/hantro_drv.c b/drivers/media/platform/verisilicon/hantro_drv.c
>> index 8e93710dcfed..e10fc59634dd 100644
>> --- a/drivers/media/platform/verisilicon/hantro_drv.c
>> +++ b/drivers/media/platform/verisilicon/hantro_drv.c
>> @@ -282,7 +282,13 @@ static int hantro_try_ctrl(struct v4l2_ctrl *ctrl)
>>   		/* We only support profile 0 */
>>   		if (dec_params->profile != 0)
>>   			return -EINVAL;
>> +	} else if (ctrl->id == V4L2_CID_STATELESS_AV1_SEQUENCE) {
>> +		const struct v4l2_ctrl_av1_sequence *sequence = ctrl->p_new.p_av1_sequence;
>> +
>> +		if (sequence->bit_depth != 8 && sequence->bit_depth != 10)
>> +			return -EINVAL;
> As you state in the cover letter, should this just be this for now ?

The driver can decode 8 or 10 bits bitstreams but will on produce 8bits (NV12_4L4 or NV12)
frames. The hardware is able to truncate 10bits bitstreams to 8 bits output.

>
>
>> +		if (sequence->bit_depth != 8)
>> +			return -EINVAL;
>
>>   	}
>> +
>>   	return 0;
>>   }
>>   
