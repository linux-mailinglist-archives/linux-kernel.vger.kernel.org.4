Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3106565D54B
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Jan 2023 15:15:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234536AbjADOPZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Jan 2023 09:15:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235105AbjADOPH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jan 2023 09:15:07 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49BA33AAB4;
        Wed,  4 Jan 2023 06:14:55 -0800 (PST)
Received: from [IPV6:2001:4091:a244:801c:ff2e:9846:2bd1:fe62] (unknown [IPv6:2001:4091:a244:801c:ff2e:9846:2bd1:fe62])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: rmader)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 33D5F6602D11;
        Wed,  4 Jan 2023 14:14:53 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1672841693;
        bh=lw2JPVpDxfHC/ODQKCtrvMC8RVqDv1kVX/tAotai0sA=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=U2IkzowEhaZ6My70+KsMfUG2wTu7Wo8/9WWzs3e/C4T/o6/ekFvV2zLFfqXE7RwmY
         K3yb847DCT284KExyldIYc28BR0P1yYhsH/w8PGONz9zVZYqshTaU+cW5QcNA/3wrP
         X3MrNdJJB/WJEVRlsD+3xIKWrhwRuC307qczmI4kXkM/YXUUDfr5176aQKFUSgSx+G
         hk4CXYAyMkdN8FBgH2eNwG52nXBeg9JbeIJbKPJ0fzbvG3ixJ2ajI5z9wyxlPDva6j
         fQ2QXLZQIi+q0f40UeYOcBwyceoVZGHBVjGxWUWR5G7xUqn2HtaJ6Qn4KNJsDLB3oq
         0H6P193wOSlxg==
Message-ID: <e55766f0-5090-abb5-dbd7-58230153a8ce@collabora.com>
Date:   Wed, 4 Jan 2023 15:14:50 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH v2] media: i2c: imx258: Parse and register properties
Content-Language: en-US
To:     Jacopo Mondi <jacopo.mondi@ideasonboard.com>
Cc:     linux-kernel@vger.kernel.org, nicholas@rothemail.net,
        javierm@redhat.com, Sakari Ailus <sakari.ailus@linux.intel.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-media@vger.kernel.org
References: <20230104122337.123055-1-robert.mader@collabora.com>
 <20230104141159.e2klapbpenslxqbx@uno.localdomain>
From:   Robert Mader <robert.mader@collabora.com>
In-Reply-To: <20230104141159.e2klapbpenslxqbx@uno.localdomain>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04.01.23 15:11, Jacopo Mondi wrote:
> Hi Robert
>
> On Wed, Jan 04, 2023 at 01:23:37PM +0100, Robert Mader wrote:
>> Analogous to e.g. the imx219. This enables propagating
>> V4L2_CID_CAMERA_ORIENTATION and V4L2_CID_CAMERA_SENSOR_ROTATION
>> values.
>> The motivation is to allow libcamera detect these values from the
>> device tree and propagate them further to e.g. Pipewire.
>>
>> While at it, reserve space for 3 additional controls even if
>> v4l2_ctrl_new_fwnode_properties() can only register 2 of
>> them, to fix the existing implementation which reserve space for 8
>> controls but actually registers 9.
>>
>> Changes in v2:
>>   - Reserve 11 instead of 10 controls
>>   - Change order of variable declaration
>>   - Slightly extend description
> This part should go below, after ---, as it shouldn't be part of the commit
> message
>
> The patch looks good
>
> Reviewed-by: Jacopo Mondi <jacopo.mondi@ideasonboard.com>
Thanks! And ops, right, make sense. Should I spin a v3 for that or is it 
simple enough to fix when pulling?
>> Signed-off-by: Robert Mader <robert.mader@collabora.com>
>> ---
>>   drivers/media/i2c/imx258.c | 13 ++++++++++++-
>>   1 file changed, 12 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/media/i2c/imx258.c b/drivers/media/i2c/imx258.c
>> index eab5fc1ee2f7..3b560865b657 100644
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
>> @@ -1148,6 +1149,7 @@ static const struct v4l2_subdev_internal_ops imx258_internal_ops = {
>>   static int imx258_init_controls(struct imx258 *imx258)
>>   {
>>   	struct i2c_client *client = v4l2_get_subdevdata(&imx258->sd);
>> +	struct v4l2_fwnode_device_properties props;
>>   	struct v4l2_ctrl_handler *ctrl_hdlr;
>>   	s64 vblank_def;
>>   	s64 vblank_min;
>> @@ -1156,7 +1158,7 @@ static int imx258_init_controls(struct imx258 *imx258)
>>   	int ret;
>>
>>   	ctrl_hdlr = &imx258->ctrl_handler;
>> -	ret = v4l2_ctrl_handler_init(ctrl_hdlr, 8);
>> +	ret = v4l2_ctrl_handler_init(ctrl_hdlr, 11);
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
>>   	imx258->sd.ctrl_handler = ctrl_hdlr;
>>
>>   	return 0;
>> --
>> 2.39.0
>>
