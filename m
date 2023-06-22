Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E5AAD739907
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Jun 2023 10:09:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230332AbjFVIJX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Jun 2023 04:09:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229969AbjFVIJW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Jun 2023 04:09:22 -0400
Received: from cpanel.siel.si (cpanel.siel.si [46.19.9.99])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F18D199D;
        Thu, 22 Jun 2023 01:09:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=norik.com;
        s=default; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
        References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=gianlocX80/93eqK3HsoSta6CY4KDZkx0aSwUig8SOo=; b=cNcQN1PUrrAPsIiMMBu5Q61mAA
        c2Q8/YhZOYWHEhHGRJfTUZkXgViIlRFObjz78p5rz6N1wsgDGzo16ht4p4U671QMK6ysUt8qeQLAN
        AT3bjQ7bbOtH7mVatt8WqZbkh+8o9YhYHFxQS/BZKWSUAxB/iNVHH6/zJQKO+iPi3LWjqKf3P3Nqq
        0Pi+xuhC83aFPtXWn2+5XyGR2vuPaFOwiOsbdhHDJzyjzKv8xRYC8AvYEwE0pBaOlMVTQCqKnDSDO
        jukwb8bwdpZSbYWvTaEGtH/WkGKk5m9hLTppw/FtUM3ZCkdrD6dp/nretkbMLwLnNNxY5wOxznKtR
        qjidrj0g==;
Received: from 89-212-21-243.static.t-2.net ([89.212.21.243]:56706 helo=[192.168.69.84])
        by cpanel.siel.si with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.96)
        (envelope-from <andrej.picej@norik.com>)
        id 1qCFNV-00GeLD-2A;
        Thu, 22 Jun 2023 10:09:17 +0200
Message-ID: <b05eaef8-3371-1a4b-c264-b6d350155293@norik.com>
Date:   Thu, 22 Jun 2023 10:09:17 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v2] rtc: rv3028: Improve trickle charger logic
Content-Language: en-GB
To:     Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc:     a.zummo@towertech.it, linux-rtc@vger.kernel.org,
        linux-kernel@vger.kernel.org, upstream@phytec.de
References: <20230622071609.4032736-1-andrej.picej@norik.com>
 <20230622073458dcd9f636@mail.local>
From:   Andrej Picej <andrej.picej@norik.com>
In-Reply-To: <20230622073458dcd9f636@mail.local>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - cpanel.siel.si
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - norik.com
X-Get-Message-Sender-Via: cpanel.siel.si: authenticated_id: andrej.picej@norik.com
X-Authenticated-Sender: cpanel.siel.si: andrej.picej@norik.com
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Alexandre,

On 22. 06. 23 09:34, Alexandre Belloni wrote:
> On 22/06/2023 09:16:09+0200, Andrej Picej wrote:
>> Property "trickle-resistor-ohms" allows us to set trickle charger
>> resistor. However there is no possibility to disable it afterwards.
>>
>>  From now on, disable trickle charger circuit in case device-tree
>> property "trickle-resistor-ohms" is set to -1.
>>
>> Additionally, lets make sure we only update internal EEPROM in case of a
>> change. This prevents wear due to excessive EEPROM writes on each probe.
>>
>> Signed-off-by: Andrej Picej <andrej.picej@norik.com>
>> ---
>> Changes in v2:
>> - disable trickle charger if device tree property trickle-resistor-ohms
>>    is set to -1.
> 
> What about using aux-voltage-chargeable which is the generic property
> for this?

I thought that this is more of a property for specifying if connected 
battery/supercap has charging capabilities. I guess at the end it would 
be the same thing as knowingly disabling the trickle charger even if 
battery/supercap can be charged.
Do you want that I change and use "aux-voltage-chargeable"?

BR,
Andrej

> 
>> ---
>>   drivers/rtc/rtc-rv3028.c | 45 +++++++++++++++++++++++++++++-----------
>>   1 file changed, 33 insertions(+), 12 deletions(-)
>>
>> diff --git a/drivers/rtc/rtc-rv3028.c b/drivers/rtc/rtc-rv3028.c
>> index ec5d7a614e2d..da2ae81fe7c8 100644
>> --- a/drivers/rtc/rtc-rv3028.c
>> +++ b/drivers/rtc/rtc-rv3028.c
>> @@ -859,7 +859,8 @@ static int rv3028_probe(struct i2c_client *client)
>>   {
>>   	struct rv3028_data *rv3028;
>>   	int ret, status;
>> -	u32 ohms;
>> +	s32 ohms;
>> +	int val_old, val;
>>   	struct nvmem_config nvmem_cfg = {
>>   		.name = "rv3028_nvram",
>>   		.word_size = 1,
>> @@ -937,22 +938,42 @@ static int rv3028_probe(struct i2c_client *client)
>>   	if (ret)
>>   		return ret;
>>   
>> -	/* setup trickle charger */
>> -	if (!device_property_read_u32(&client->dev, "trickle-resistor-ohms",
>> -				      &ohms)) {
>> -		int i;
>> +	ret = regmap_read(rv3028->regmap, RV3028_BACKUP, &val_old);
>> +	if (ret < 0)
>> +		return ret;
>> +
>> +	/* mask out only trickle charger bits */
>> +	val_old = val_old & (RV3028_BACKUP_TCE | RV3028_BACKUP_TCR_MASK);
>>   
>> -		for (i = 0; i < ARRAY_SIZE(rv3028_trickle_resistors); i++)
>> -			if (ohms == rv3028_trickle_resistors[i])
>> -				break;
>> +	/* setup trickle charger */
>> +	if (!of_property_read_s32(client->dev.of_node, "trickle-resistor-ohms",
>> +				  &ohms)) {
>> +		/* disable trickle charger if trickle-resistor-ohms = <(-1)>; */
>> +		if (ohms == -1) {
>> +			val = val_old & ~RV3028_BACKUP_TCE;
>> +		} else {
>> +			int i;
>> +
>> +			for (i = 0; i < ARRAY_SIZE(rv3028_trickle_resistors); i++)
>> +				if (ohms == rv3028_trickle_resistors[i])
>> +					break;
>> +
>> +			if (i < ARRAY_SIZE(rv3028_trickle_resistors)) {
>> +				/* enable trickle charger and its resistor */
>> +				val = RV3028_BACKUP_TCE | i;
>> +			} else {
>> +				dev_warn(&client->dev, "invalid trickle resistor value\n");
>> +				/* don't update the trickle charger regs */
>> +				val = val_old;
>> +			}
>> +		}
>>   
>> -		if (i < ARRAY_SIZE(rv3028_trickle_resistors)) {
>> +		/* only update EEPROM if changes are necessary */
>> +		if (val_old != val) {
>>   			ret = rv3028_update_cfg(rv3028, RV3028_BACKUP, RV3028_BACKUP_TCE |
>> -						 RV3028_BACKUP_TCR_MASK, RV3028_BACKUP_TCE | i);
>> +						RV3028_BACKUP_TCR_MASK, val);
>>   			if (ret)
>>   				return ret;
>> -		} else {
>> -			dev_warn(&client->dev, "invalid trickle resistor value\n");
>>   		}
>>   	}
>>   
>> -- 
>> 2.25.1
>>
> 
