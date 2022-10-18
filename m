Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 60DF1602914
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Oct 2022 12:10:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230325AbiJRKK1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Oct 2022 06:10:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230321AbiJRKKK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Oct 2022 06:10:10 -0400
Received: from smtpbgeu2.qq.com (smtpbgeu2.qq.com [18.194.254.142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 410896C964;
        Tue, 18 Oct 2022 03:10:02 -0700 (PDT)
X-QQ-mid: bizesmtp88t1666087780toqcpdz3
Received: from [10.4.23.219] ( [58.240.82.166])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Tue, 18 Oct 2022 18:09:39 +0800 (CST)
X-QQ-SSF: 00400000000000C0K000000A0000000
X-QQ-FEAT: TFgy1zK7+HXgfcYLTLlK3TQ03kfXa1/Vu1sUv9tj8xWm8nuVPhGBMcffgoaXY
        dJItXYor6NypQ0nVlq8AzAovpNvU+Ril7DgWyqxU07mEiKQzTy/bN8vYS9yu+tjUx0jtGR0
        ZTLcZug8GNChdPGYN70smlMMKawiaS+r+rFLV0nDfGUGCc94IzMIn9ViHqzUIUkA94U90tC
        N3g3zsJZ63ZfVmLwRCv1lswXFrMUN5raBOhXSLIeDSziEopPY0lSVZVfDRmzP0tGGxF9HRb
        CT3Lt4v2HoLxeZKJT/f5NLpAOu8zLhohp5a8we6YMX4kXwUPSUw1tVH2QF177CPf+vd9rIP
        LMJwgY0VOd3i80BKeRtLlGvutFyXH9vFvFhmvMZrP4Tljwo8Gt2oGhLoiewRXtLB9Dvv3ce
        UhADstclphE=
X-QQ-GoodBg: 1
Message-ID: <29BB6624DF28611B+45506374-c2c6-109c-df13-17531f7b1937@uniontech.com>
Date:   Tue, 18 Oct 2022 18:09:39 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [PATCH] platform/x86: ideapad-laptop: Disable touchpad_switch
To:     Hans de Goede <hdegoede@redhat.com>, ike.pan@canonical.com,
        markgross@kernel.org
Cc:     platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20221018061457.26937-1-limanyi@uniontech.com>
 <bade32f9-594c-3efd-d6da-ea6a4a433948@redhat.com>
From:   Manyi Li <limanyi@uniontech.com>
In-Reply-To: <bade32f9-594c-3efd-d6da-ea6a4a433948@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:uniontech.com:qybglogicsvr:qybglogicsvr4
X-Spam-Status: No, score=0.4 required=5.0 tests=BAYES_00,FORGED_MUA_MOZILLA,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_PASS,T_SPF_HELO_TEMPERROR
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



在 2022/10/18 15:48, Hans de Goede 写道:
> Hi,
> 
> On 10/18/22 08:14, Manyi Li wrote:
>> Ideapads for "Lenovo Yoga 3 Pro 1370" and "ZhaoYang K4e-IML" do not
>> use EC to switch touchpad.
>>
>> Reading VPCCMD_R_TOUCHPAD will return zero thus touchpad may be blocked
>> unexpectedly.
>>
>> Signed-off-by: Manyi Li <limanyi@uniontech.com>
>> ---
>>   drivers/platform/x86/ideapad-laptop.c | 19 +++++++++++++++++++
>>   1 file changed, 19 insertions(+)
>>
>> diff --git a/drivers/platform/x86/ideapad-laptop.c b/drivers/platform/x86/ideapad-laptop.c
>> index abd0c81d62c4..20b8a94934b4 100644
>> --- a/drivers/platform/x86/ideapad-laptop.c
>> +++ b/drivers/platform/x86/ideapad-laptop.c
>> @@ -1533,6 +1533,24 @@ static const struct dmi_system_id hw_rfkill_list[] = {
>>   	{}
>>   };
>>   
>> +static const struct dmi_system_id no_touchpad_switch_list[] = {
>> +	{
>> +	.ident = "Lenovo Yoga 3 Pro 1370",
>> +	.matches = {
>> +		DMI_MATCH(DMI_SYS_VENDOR, "LENOVO"),
>> +		DMI_MATCH(DMI_PRODUCT_VERSION, "Lenovo YOGA 3"),
>> +		},
>> +	},
>> +	{
>> +	.ident = "ZhaoYang K4e-IML",
>> +	.matches = {
>> +		DMI_MATCH(DMI_SYS_VENDOR, "LENOVO"),
>> +		DMI_MATCH(DMI_PRODUCT_VERSION, "ZhaoYang K4e-IML"),
>> +		},
>> +	},
>> +	{}
>> +};
>> +
>>   static void ideapad_check_features(struct ideapad_private *priv)
>>   {
>>   	acpi_handle handle = priv->adev->handle;
>> @@ -1542,6 +1560,7 @@ static void ideapad_check_features(struct ideapad_private *priv)
>>   
>>   	/* Most ideapads with ELAN0634 touchpad don't use EC touchpad switch */
>>   	priv->features.touchpad_ctrl_via_ec = !acpi_dev_present("ELAN0634", NULL, -1);
>> +	priv->features.touchpad_ctrl_via_ec = !dmi_check_system(no_touchpad_switch_list);
> 
> This needs to be:
> 
> 	priv->features.touchpad_ctrl_via_ec =
> 		!acpi_dev_present("ELAN0634", NULL, -1) &&
> 		!dmi_check_system(no_touchpad_switch_list);
> 
> Otherwise you over overriding the results of the ELAN0634 check. Also I wonder if there
> is not a better way to check for this (for both cases) ?
> 
> Is the touchpad on these devices perhaps connected over I2C ? Maybe we need to figure
> out a way to check for that.

Yes,the touchpad on these devices is connected over I2C.

> 
> Regards,
> 
> Hans
> 
> 
> 
>>   
>>   	if (!read_ec_data(handle, VPCCMD_R_FAN, &val))
>>   		priv->features.fan_mode = true;
> 
> 

-- 
Manyi Li

