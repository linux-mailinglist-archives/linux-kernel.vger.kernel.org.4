Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6BA1665C195
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Jan 2023 15:14:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237832AbjACOMT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Jan 2023 09:12:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237805AbjACOMN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jan 2023 09:12:13 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6326411459;
        Tue,  3 Jan 2023 06:12:09 -0800 (PST)
Received: from [172.18.164.161] (unknown [46.183.103.8])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: rmader)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id C951E6602CFA;
        Tue,  3 Jan 2023 14:12:05 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1672755127;
        bh=QFKONSnl44fUfO33ehjMQ74G8iDnLg2h0QSpeLd9wjg=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=EzQ8N7bmre26Fvyo8QmIyR5itT5XXt3mTLA8kgegO0iu+h5juCFwCxDfhOPDQk/Lp
         fJAk3z/XlRfJrXbLWY/+SRrbmihh8bnSY27EsgwILAmYv+2/A7qhM4Sjy7YxYrLJiN
         Lq3oVHb1BU8RFtIb8kFG8dEsfvw3/iDr7xq3Y5bAOq9Ew3H4bs7J1LKwSmQzX7G+LR
         zhvu3wChKTSyO2bhTc3lMeUYauahaZriGoiu5uTcPJvBaI8FPvDyCAnhh4mcneGaDg
         Pa1B9SEujwIt9VV0I1SRs8QZrf0Fd/xnVYo+B9klY5Zb2TyjD6WeCANak3P+0lqJfa
         l7jWUmcy3gMYw==
Message-ID: <20f405f3-0a82-5d2f-2b0d-ce0d510b5098@collabora.com>
Date:   Tue, 3 Jan 2023 15:11:44 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH] media: i2c: imx258: Parse and register properties
Content-Language: en-US
To:     Jacopo Mondi <jacopo@jmondi.org>
Cc:     linux-kernel@vger.kernel.org, nicholas@rothemail.net,
        javierm@redhat.com, Sakari Ailus <sakari.ailus@linux.intel.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-media@vger.kernel.org
References: <20221225154234.378555-1-robert.mader@collabora.com>
 <20230102140631.hadlh3stozecnzpj@uno.localdomain>
From:   Robert Mader <robert.mader@collabora.com>
In-Reply-To: <20230102140631.hadlh3stozecnzpj@uno.localdomain>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_SBL_CSS,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02.01.23 15:06, Jacopo Mondi wrote:
> Hi Robert
>
> On Sun, Dec 25, 2022 at 04:42:34PM +0100, Robert Mader wrote:
>> Analogous to e.g. the imx219. This enables propagating
>> V4L2_CID_CAMERA_SENSOR_ROTATION values so that libcamera
>> can detect the correct rotation from the device tree
>> and propagate it further to e.g. Pipewire.
>>
>> Signed-off-by: Robert Mader <robert.mader@collabora.com>
>> ---
>>   drivers/media/i2c/imx258.c | 13 ++++++++++++-
>>   1 file changed, 12 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/media/i2c/imx258.c b/drivers/media/i2c/imx258.c
>> index eab5fc1ee2f7..85819043d1e3 100644
>> --- a/drivers/media/i2c/imx258.c
>> +++ b/drivers/media/i2c/imx258.c
>> @@ -9,6 +9,7 @@
>>   #include <linux/pm_runtime.h>
>>   #include <media/v4l2-ctrls.h>
>>   #include <media/v4l2-device.h>
>> +#include <media/v4l2-fwnode.h>
>>   #include <asm/unaligned.h>
>>
>>   #define IMX258_REG_VALUE_08BIT		1
>> @@ -1149,6 +1150,7 @@ static int imx258_init_controls(struct imx258 *imx258)
>>   {
>>   	struct i2c_client *client = v4l2_get_subdevdata(&imx258->sd);
>>   	struct v4l2_ctrl_handler *ctrl_hdlr;
>> +	struct v4l2_fwnode_device_properties props;
> Might be nicer to move this one line up

  Can you say what's your reasoning? I personally slightly prefer 
alphabetical order, but no strong opinion :)

>>   	s64 vblank_def;
>>   	s64 vblank_min;
>>   	s64 pixel_rate_min;
>> @@ -1156,7 +1158,7 @@ static int imx258_init_controls(struct imx258 *imx258)
>>   	int ret;
>>
>>   	ctrl_hdlr = &imx258->ctrl_handler;
>> -	ret = v4l2_ctrl_handler_init(ctrl_hdlr, 8);
>> +	ret = v4l2_ctrl_handler_init(ctrl_hdlr, 10);
> I count 9 controls being registered before this patch, not 8. Do I
> count them right ?
>
> If that's case, as v4l2_ctrl_new_fwnode_properties()
> can register up to two controls (V4L2_CID_ROTATION and
> V4L2_CID_ORIENTATION) I would pre-reserve 11 controls not 10 to avoid
> relocations.

Indeed, looks like bumping this was forgotten in 
c6f9d67e2ac625e331f6a7f5715d2f809ff0a922

>>   	if (ret)
>>   		return ret;
>>
>> @@ -1232,6 +1234,15 @@ static int imx258_init_controls(struct imx258 *imx258)
>>   		goto error;
>>   	}
>>
>> +	ret = v4l2_fwnode_device_parse(&client->dev, &props);
>> +	if (ret)
>> +		goto error;
>> +
>> +	ret = v4l2_ctrl_new_fwnode_properties(ctrl_hdlr, &imx258_ctrl_ops,
>> +					      &props);
>> +	if (ret)
>> +		goto error;
>> +
> The rest looks good to me!
>
> Thanks
>     j
Thanks!

-- 
Robert Mader
Consultant Software Developer

Collabora Ltd.
Platinum Building, St John's Innovation Park, Cambridge CB4 0DS, UK
Registered in England & Wales, no. 5513718

