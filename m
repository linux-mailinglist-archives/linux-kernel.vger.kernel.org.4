Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0FCF865D2FF
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Jan 2023 13:47:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229548AbjADMrM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Jan 2023 07:47:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231795AbjADMrH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jan 2023 07:47:07 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D854167FA;
        Wed,  4 Jan 2023 04:47:05 -0800 (PST)
Received: from [IPV6:2001:4091:a244:801c:ff2e:9846:2bd1:fe62] (unknown [IPv6:2001:4091:a244:801c:ff2e:9846:2bd1:fe62])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: rmader)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 8AE2B6602D11;
        Wed,  4 Jan 2023 12:47:03 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1672836423;
        bh=t14T8tj2RtWwvBr/+ApmxPga1nTZbNsBeZ5XFdnGQng=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=CcWENA6ZZb840wB6qk2QhHwxs8OIx3vzSLQ9bjrCsQQ+AFpTtT0DsMXtDyJwxQMCf
         RX+HcpgFlMgeTE6HYZZoWESFu1QHdIf7kyTEjpsBRbrq+yXo1GW0JLAki8rkRarDUS
         H+qq7lwGXG40DskFdTfcIJzkeE1HpqGf4TW0iqHLHYS9RbQ1FC4M7E/QpUNCKEBDOC
         lhfKYAetjzDID4vQdaVQ7kRa3zIqT5hDjgXDf5BFQpd73DBKk3FAq2AkUBSGlZCsxm
         hCYzX8dNPRLhFTYLRg6z5m+PMDfqHZ2otUW+2ix7qJMW35iWRc/fklKY9sW5jZQO1K
         PFkgsW1hQbikA==
Message-ID: <62b0d46f-7962-ad5f-dd4e-5820d76964b4@collabora.com>
Date:   Wed, 4 Jan 2023 13:47:00 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH] media: i2c: imx258: Parse and register properties
Content-Language: en-US
To:     Sakari Ailus <sakari.ailus@linux.intel.com>,
        Jacopo Mondi <jacopo.mondi@ideasonboard.com>
Cc:     linux-kernel@vger.kernel.org, nicholas@rothemail.net,
        javierm@redhat.com, Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-media@vger.kernel.org
References: <20221225154234.378555-1-robert.mader@collabora.com>
 <20230102140631.hadlh3stozecnzpj@uno.localdomain>
 <20f405f3-0a82-5d2f-2b0d-ce0d510b5098@collabora.com>
 <20230103171624.qx6hm2exs3d5lg53@uno.localdomain>
 <Y7Uo3JlOoGJAoorz@paasikivi.fi.intel.com>
From:   Robert Mader <robert.mader@collabora.com>
In-Reply-To: <Y7Uo3JlOoGJAoorz@paasikivi.fi.intel.com>
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

Sure, makes sense!

Send out v2 now.

On 04.01.23 08:21, Sakari Ailus wrote:
> Hi Jacopo, Robert,
>
> On Tue, Jan 03, 2023 at 06:16:24PM +0100, Jacopo Mondi wrote:
>> Hi Robert
>>
>> On Tue, Jan 03, 2023 at 03:11:44PM +0100, Robert Mader wrote:
>>> On 02.01.23 15:06, Jacopo Mondi wrote:
>>>> Hi Robert
>>>>
>>>> On Sun, Dec 25, 2022 at 04:42:34PM +0100, Robert Mader wrote:
>>>>> Analogous to e.g. the imx219. This enables propagating
>>>>> V4L2_CID_CAMERA_SENSOR_ROTATION values so that libcamera
>>>>> can detect the correct rotation from the device tree
>>>>> and propagate it further to e.g. Pipewire.
>>>>>
>>>>> Signed-off-by: Robert Mader <robert.mader@collabora.com>
>>>>> ---
>>>>>    drivers/media/i2c/imx258.c | 13 ++++++++++++-
>>>>>    1 file changed, 12 insertions(+), 1 deletion(-)
>>>>>
>>>>> diff --git a/drivers/media/i2c/imx258.c b/drivers/media/i2c/imx258.c
>>>>> index eab5fc1ee2f7..85819043d1e3 100644
>>>>> --- a/drivers/media/i2c/imx258.c
>>>>> +++ b/drivers/media/i2c/imx258.c
>>>>> @@ -9,6 +9,7 @@
>>>>>    #include <linux/pm_runtime.h>
>>>>>    #include <media/v4l2-ctrls.h>
>>>>>    #include <media/v4l2-device.h>
>>>>> +#include <media/v4l2-fwnode.h>
>>>>>    #include <asm/unaligned.h>
>>>>>
>>>>>    #define IMX258_REG_VALUE_08BIT		1
>>>>> @@ -1149,6 +1150,7 @@ static int imx258_init_controls(struct imx258 *imx258)
>>>>>    {
>>>>>    	struct i2c_client *client = v4l2_get_subdevdata(&imx258->sd);
>>>>>    	struct v4l2_ctrl_handler *ctrl_hdlr;
>>>>> +	struct v4l2_fwnode_device_properties props;
>>>> Might be nicer to move this one line up
>>>   Can you say what's your reasoning? I personally slightly prefer
>>> alphabetical order, but no strong opinion :)
>>>
>> I've often been instructed to try to respect the inverse-xmas-tree
> I'd advise the same, unless there are other reasons to arrange the lines
> differently.
>
