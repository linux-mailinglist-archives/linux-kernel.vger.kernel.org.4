Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E4D746A715C
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Mar 2023 17:37:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230147AbjCAQha (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Mar 2023 11:37:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229905AbjCAQhT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Mar 2023 11:37:19 -0500
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D6D94988F;
        Wed,  1 Mar 2023 08:36:53 -0800 (PST)
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 321GZt9U126046;
        Wed, 1 Mar 2023 10:35:55 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1677688555;
        bh=sITZyv1tyFmXqgH0GUHmAT6tC2/cSlL5cr4fVh06Kh4=;
        h=Date:Subject:To:CC:References:From:In-Reply-To;
        b=TMKfEu8fok+w9L6/Xcqw1Oj/LKQVxc7mvi/SkZ77rUPp+51kH/rTTerY2KNN+Z51B
         v09jnFhpRhPPmWzUhdnh5XiYrgf1Dbt7mdyTQkNWZupnBW3xZbrZ89zZPnMybRt4ep
         nE+5jnKPHmu4o3E0qB0X2+IDwYJpJYq4iuefYoi4=
Received: from DLEE104.ent.ti.com (dlee104.ent.ti.com [157.170.170.34])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 321GZt8N058701
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 1 Mar 2023 10:35:55 -0600
Received: from DLEE107.ent.ti.com (157.170.170.37) by DLEE104.ent.ti.com
 (157.170.170.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.16; Wed, 1
 Mar 2023 10:35:54 -0600
Received: from fllv0040.itg.ti.com (10.64.41.20) by DLEE107.ent.ti.com
 (157.170.170.37) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.16 via
 Frontend Transport; Wed, 1 Mar 2023 10:35:55 -0600
Received: from [10.249.33.186] (ileaxei01-snat2.itg.ti.com [10.180.69.6])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 321GZsqx069950;
        Wed, 1 Mar 2023 10:35:54 -0600
Message-ID: <d4abf0c3-f5c8-fd54-87f6-4397596ae40f@ti.com>
Date:   Wed, 1 Mar 2023 10:35:54 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH] mfd: tps65219: Add support for soft shutdown via sys-off
 API
Content-Language: en-US
To:     Lee Jones <lee@kernel.org>, Jerome Neanne <jneanne@baylibre.com>
CC:     <tony@atomide.com>, <linux-omap@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <khilman@baylibre.com>,
        <nm@ti.com>, <msp@baylibre.com>
References: <20230203140150.13071-1-jneanne@baylibre.com>
 <Y/94Pew4vr6FROcI@google.com>
From:   Andrew Davis <afd@ti.com>
In-Reply-To: <Y/94Pew4vr6FROcI@google.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/1/23 10:07 AM, Lee Jones wrote:
> On Fri, 03 Feb 2023, Jerome Neanne wrote:
> 
>> Use new API for power-off mode support:
>> Link: https://lwn.net/Articles/894511/
>> Link: https://lore.kernel.org/all/7hfseqa7l0.fsf@baylibre.com/
>>
>> sys-off API allows support of shutdown handler and restart handler.
>>
>> Shutdown was not supported before that enhancement.
>> This is required for platform that are not using PSCI.
>>

Not sure what platform doesn't have PSCI off, since you tested on
AM62-SK I'm guessing you manually disabled the PSCI off for testing?

Anyway I don't see any huge issues with the code itself, small comment below.

>> Test:
>> - restart:
>>    # reboot
>>    Default is cold reset:
>>    # cat /sys/kernel/reboot/mode
>>    Switch boot mode to warm reset:
>>    # echo warm > /sys/kernel/reboot/mode
>> - power-off:
>>    # halt
>>
>> Tested on AM62-SP-SK board.
>>
>> Signed-off-by: Jerome Neanne <jneanne@baylibre.com>
>> Suggested-by: Andrew Davis <afd@ti.com>
> 
> A review from Andrew would be helpful here.
> 
>> ---
>>   drivers/mfd/tps65219.c | 45 +++++++++++++++++++++++++++++++-----------
>>   1 file changed, 34 insertions(+), 11 deletions(-)
>>
>> diff --git a/drivers/mfd/tps65219.c b/drivers/mfd/tps65219.c
>> index 0e402fda206b..c134f3f6e202 100644
>> --- a/drivers/mfd/tps65219.c
>> +++ b/drivers/mfd/tps65219.c
>> @@ -25,25 +25,34 @@ static int tps65219_cold_reset(struct tps65219 *tps)
>>   				  TPS65219_MFP_COLD_RESET_I2C_CTRL_MASK);
>>   }
>>   
>> -static int tps65219_restart(struct notifier_block *this,
>> -			    unsigned long reboot_mode, void *cmd)
>> +static int tps65219_soft_shutdown(struct tps65219 *tps)
>>   {
>> -	struct tps65219 *tps;
>> +	return regmap_update_bits(tps->regmap, TPS65219_REG_MFP_CTRL,
>> +				  TPS65219_MFP_I2C_OFF_REQ_MASK,
>> +				  TPS65219_MFP_I2C_OFF_REQ_MASK);
>> +}
>>   
>> -	tps = container_of(this, struct tps65219, nb);
>> +static int tps65219_power_off_handler(struct sys_off_data *data)
>> +{
>> +	tps65219_soft_shutdown(data->cb_data);
>> +	return NOTIFY_DONE;
>> +}
>>   
>> +static int tps65219_restart(struct tps65219 *tps,
>> +			    unsigned long reboot_mode)
>> +{
>>   	if (reboot_mode == REBOOT_WARM)
>>   		tps65219_warm_reset(tps);
>>   	else
>>   		tps65219_cold_reset(tps);
>> -
>>   	return NOTIFY_DONE;
>>   }
>>   
>> -static struct notifier_block pmic_rst_restart_nb = {
>> -	.notifier_call = tps65219_restart,
>> -	.priority = 200,
>> -};
>> +static int tps65219_restart_handler(struct sys_off_data *data)
>> +{
>> +	tps65219_restart(data->cb_data, data->mode);
>> +	return NOTIFY_DONE;
>> +}
>>   
>>   static const struct resource tps65219_pwrbutton_resources[] = {
>>   	DEFINE_RES_IRQ_NAMED(TPS65219_INT_PB_FALLING_EDGE_DETECT, "falling"),
>> @@ -269,13 +278,27 @@ static int tps65219_probe(struct i2c_client *client)
>>   		}
>>   	}
>>   
>> -	tps->nb = pmic_rst_restart_nb;
>> -	ret = register_restart_handler(&tps->nb);
>> +	ret = devm_register_sys_off_handler(tps->dev,
>> +					    SYS_OFF_MODE_RESTART,
>> +					    SYS_OFF_PRIO_HIGH,

Why not default prio? SYS_OFF_PRIO_DEFAULT

Then you can use this new helper devm_register_restart_handler()

>> +					    tps65219_restart_handler,
>> +					    tps);
>> +
>>   	if (ret) {
>>   		dev_err(tps->dev, "cannot register restart handler, %d\n", ret);
>>   		return ret;
>>   	}
>>   
>> +	ret = devm_register_sys_off_handler(tps->dev,
>> +					    SYS_OFF_MODE_POWER_OFF,
>> +					    SYS_OFF_PRIO_DEFAULT,
>> +					    tps65219_power_off_handler,
>> +					    tps);


devm_register_power_off_handler()?

Otherwise I see no major issues,

Reviewed-by: Andrew Davis <afd@ti.com>

Andrew

>> +	if (ret) {
>> +		dev_err(tps->dev, "failed to register sys-off handler: %d\n",
>> +			ret);
>> +		return ret;
>> +	}
>>   	return 0;
>>   }
>>   
>> -- 
>> 2.34.1
>>
> 
