Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 000E0655BFA
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Dec 2022 01:15:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229853AbiLYAPD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 24 Dec 2022 19:15:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229445AbiLYAPB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Dec 2022 19:15:01 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10B393899;
        Sat, 24 Dec 2022 16:14:59 -0800 (PST)
Received: from [IPV6:2003:c7:df11:b00:fc6d:91a:a11d:a091] (p200300c7df110b00fc6d091aa11da091.dip0.t-ipconnect.de [IPv6:2003:c7:df11:b00:fc6d:91a:a11d:a091])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: rmader)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 8100B6601B06;
        Sun, 25 Dec 2022 00:14:56 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1671927297;
        bh=Ssm3igtjYoF1mqISjvcxMuDfQYYSzbscwC6hQ4FM+xM=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=eLpvf+vxIZZrECDM65IenJkrV8/2zA+B/WEGfgbHXf58IX96XfZIXxwfOKd5IYkXL
         sSmbnoqVHGNK0eQajyJ/S4Rd8yeUjOIgHN+b0E2j5HbcBPDxmk6mkJT0TfP9LTdiUC
         jebC1NnO42xOE2JlcVQ/8QaRdlsEU7dvdmyj7qybSsI4GZVSHRARYxVq4ABkY8f9DR
         elSvubXQO352g3sOB3JYaLQffWbYQKyGqiC+J749vmMe02vFE/YBjn9LHB6DBpFpW2
         t865uwz+IZ0pfhB+LgDYS6VoiIXDxR6SL5kv51956jkCJRkC+Chgvd1kkN/0SXc38n
         fzK5fRRjRENbQ==
Message-ID: <9cb9a6dc-1bc6-ce32-0948-8f87014aae87@collabora.com>
Date:   Sun, 25 Dec 2022 01:14:53 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH v2] hantro: Fix JPEG encoder ENUM_FRMSIZE on RK3399
To:     Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>,
        Benjamin Gaignard <benjamin.gaignard@collabora.com>
Cc:     Nicolas Dufresne <nicolas.dufresne@collabora.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>, kernel@collabora.com,
        linux-media@vger.kernel.org, linux-rockchip@lists.infradead.org,
        linux-kernel@vger.kernel.org
References: <20221223181647.720918-1-nicolas.dufresne@collabora.com>
 <8d13ffb9-74cb-00f9-072a-0614e341e1ef@collabora.com>
 <Y6cw3dU8Ku2+aL9y@eze-laptop>
Content-Language: en-US
From:   Robert Mader <robert.mader@collabora.com>
In-Reply-To: <Y6cw3dU8Ku2+aL9y@eze-laptop>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 24.12.22 18:03, Ezequiel Garcia wrote:
> On Sat, Dec 24, 2022 at 09:03:59AM +0100, Benjamin Gaignard wrote:
>> Le 23/12/2022 à 19:16, Nicolas Dufresne a écrit :
>>> Since 79c987de8b354, enumerating framesize on format set with "MODE_NONE"
>>> (any raw formats) is reporting an invalid frmsize.
>>>
>>>     Size: Stepwise 0x0 - 0x0 with step 0/0
>>>
>>> Before this change, the driver would return EINVAL, which is also invalid but
>>> worked in GStreamer. The original intent was not to implement it, hence the
>>> -ENOTTY return in this change. While drivers should implement ENUM_FRMSIZE for
>>> all formats and queues, this change is limited in scope to fix the regression.
>>>
>>> This fixes taking picture in Gnome Cheese software, or any software using
>>> GSteamer to encode JPEG with hardware acceleration.
>>>
>>> Fixes: 79c987de8b354 ("media: hantro: Use post processor scaling capacities")
>>> Reported-by: Robert Mader <robert.mader@collabora.com>
>>> Signed-off-by: Nicolas Dufresne <nicolas.dufresne@collabora.com>
>> Reviewed-by: Benjamin Gaignard <benjamin.gaignard@collabora.com>
>>
> Reviewed-by: Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>
>
> Thanks,
> Ezequiel

Tested-by: Robert Mader <robert.mader@collabora.com>

Thanks a lot for this Christmas present, confirmed that it fixes the 
affected apps / use-cases for me :)

>
>>> ---
>>>    drivers/media/platform/verisilicon/hantro_v4l2.c | 7 +++++--
>>>    1 file changed, 5 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/drivers/media/platform/verisilicon/hantro_v4l2.c b/drivers/media/platform/verisilicon/hantro_v4l2.c
>>> index 2c7a805289e7b..30e650edaea8a 100644
>>> --- a/drivers/media/platform/verisilicon/hantro_v4l2.c
>>> +++ b/drivers/media/platform/verisilicon/hantro_v4l2.c
>>> @@ -161,8 +161,11 @@ static int vidioc_enum_framesizes(struct file *file, void *priv,
>>>    	}
>>>    	/* For non-coded formats check if postprocessing scaling is possible */
>>> -	if (fmt->codec_mode == HANTRO_MODE_NONE && hantro_needs_postproc(ctx, fmt)) {
>>> -		return hanto_postproc_enum_framesizes(ctx, fsize);
>>> +	if (fmt->codec_mode == HANTRO_MODE_NONE) {
>>> +		if (hantro_needs_postproc(ctx, fmt))
>>> +			return hanto_postproc_enum_framesizes(ctx, fsize);
>>> +		else
>>> +			return -ENOTTY;
>>>    	} else if (fsize->index != 0) {
>>>    		vpu_debug(0, "invalid frame size index (expected 0, got %d)\n",
>>>    			  fsize->index);

-- 
Robert Mader
Consultant Software Developer

Collabora Ltd.
Platinum Building, St John's Innovation Park, Cambridge CB4 0DS, UK
Registered in England & Wales, no. 5513718

