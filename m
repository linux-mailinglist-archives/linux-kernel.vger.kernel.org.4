Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 571405B5A18
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Sep 2022 14:26:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229640AbiILM0X (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Sep 2022 08:26:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229614AbiILM0U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Sep 2022 08:26:20 -0400
Received: from mx0b-001ae601.pphosted.com (mx0a-001ae601.pphosted.com [67.231.149.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5BF6B26564
        for <linux-kernel@vger.kernel.org>; Mon, 12 Sep 2022 05:26:19 -0700 (PDT)
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
        by mx0a-001ae601.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 28CCPvib023066;
        Mon, 12 Sep 2022 07:25:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=PODMain02222019;
 bh=+ZOHK68YRYiDnXOwD+2PkU/saksSJrw7L0H/naqnjGA=;
 b=C5VfRVYGYWQbq+5LKW7AfYNQkvUqQY4uTtr1wlsZc5RzwDHHck9EtM4HmyN57yev4Hdm
 EscUZ/WjTSu8f2c6zFhX3ehYVAh/ZFlKeDRpC9FeDBIoLG+5ud/d5Cn5v42HMox+bYE7
 N7rnj9N7bhndwimB4PTmQ6X9KhqAmNbRmLi4Wt/RKtAp1BfQA/KpWzslymOG2WL+vuHC
 FuK8LWRsj51r3V3mJ31rDSkQWanMVklovuifTgQkitY9ZQInk/rkeni9R8nN/QNqPo6a
 WcqSzHmHaH60pJKsVbOrgoldk2fGR3Y5KyNws3qhYAS9zw/pObaXMRcoUq9E2mVwBBe2 Vw== 
Received: from ediex01.ad.cirrus.com ([84.19.233.68])
        by mx0a-001ae601.pphosted.com (PPS) with ESMTPS id 3jgr01ta12-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 12 Sep 2022 07:25:56 -0500
Received: from ediex02.ad.cirrus.com (198.61.84.81) by ediex01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.12; Mon, 12 Sep
 2022 07:25:54 -0500
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by
 anon-ediex02.ad.cirrus.com (198.61.84.81) with Microsoft SMTP Server id
 15.2.1118.12 via Frontend Transport; Mon, 12 Sep 2022 07:25:54 -0500
Received: from [198.90.251.95] (edi-sw-dsktp-006.ad.cirrus.com [198.90.251.95])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id 8472E2C5;
        Mon, 12 Sep 2022 12:25:54 +0000 (UTC)
Message-ID: <49ee34ef-7d64-aeb6-eb1b-6cdbfd9e36ae@opensource.cirrus.com>
Date:   Mon, 12 Sep 2022 13:25:54 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [PATCH v2 5/5] soundwire: bus: Don't exit early if no device IDs
 were programmed
Content-Language: en-US
To:     Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        <vkoul@kernel.org>, <yung-chuan.liao@linux.intel.com>,
        <sanyog.r.kale@intel.com>
CC:     <patches@opensource.cirrus.com>, <alsa-devel@alsa-project.org>,
        <linux-kernel@vger.kernel.org>
References: <20220907085259.3602-1-rf@opensource.cirrus.com>
 <20220907085259.3602-6-rf@opensource.cirrus.com>
 <fa14881d-0eb8-f652-aea7-00d8c3f2a6bb@linux.intel.com>
From:   Richard Fitzgerald <rf@opensource.cirrus.com>
In-Reply-To: <fa14881d-0eb8-f652-aea7-00d8c3f2a6bb@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: 0Mn-jJ6mSbYj30t59UaggENO3Z1RenWh
X-Proofpoint-ORIG-GUID: 0Mn-jJ6mSbYj30t59UaggENO3Z1RenWh
X-Proofpoint-Spam-Reason: safe
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/09/2022 12:43, Pierre-Louis Bossart wrote:
> 
> 
> On 9/7/22 10:52, Richard Fitzgerald wrote:
>> Only exit sdw_handle_slave_status() right after calling
>> sdw_program_device_num() if it actually programmed an ID into at
>> least one device.
>>
>> sdw_handle_slave_status() should protect itself against phantom
>> device #0 ATTACHED indications. In that case there is no actual
>> device still on #0. The early exit relies on there being a status
>> change to ATTACHED on the reprogrammed device to trigger another
>> call to sdw_handle_slave_status() which will then handle the status
>> of all peripherals. If no device was actually programmed with an
>> ID there won't be a new ATTACHED indication. This can lead to the
>> status of other peripherals not being handled.
>>
>> The status passed to sdw_handle_slave_status() is obviously always
>> from a point of time in the past, and may indicate accumulated
>> unhandled events (depending how the bus manager operates). It's
>> possible that a device ID is reprogrammed but the last PING status
>> captured state just before that, when it was still reporting on
>> ID #0. Then sdw_handle_slave_status() is called with this PING info,
>> just before a new PING status is available showing it now on its new
>> ID. So sdw_handle_slave_status() will receive a phantom report of a
>> device on #0, but it will not find one.
>>
>> Signed-off-by: Richard Fitzgerald <rf@opensource.cirrus.com>
>> ---
>>   drivers/soundwire/bus.c | 27 +++++++++++++++------------
>>   1 file changed, 15 insertions(+), 12 deletions(-)
>>
>> diff --git a/drivers/soundwire/bus.c b/drivers/soundwire/bus.c
>> index 6e569a875a9b..0bcc2d161eb9 100644
>> --- a/drivers/soundwire/bus.c
>> +++ b/drivers/soundwire/bus.c
>> @@ -736,20 +736,19 @@ static int sdw_program_device_num(struct sdw_bus *bus)
>>   	struct sdw_slave_id id;
>>   	struct sdw_msg msg;
>>   	bool found;
>> -	int count = 0, ret;
>> +	int count = 0, num_programmed = 0, ret;
>>   	u64 addr;
>>   
>>   	/* No Slave, so use raw xfer api */
>>   	ret = sdw_fill_msg(&msg, NULL, SDW_SCP_DEVID_0,
>>   			   SDW_NUM_DEV_ID_REGISTERS, 0, SDW_MSG_FLAG_READ, buf);
>>   	if (ret < 0)
>> -		return ret;
>> +		return 0;
> 
> this doesn't seem quite right to me, there are multiple -EINVAL cases
> handled in sdw_fill_msg().
> 
> I didn't check if all these error cases are irrelevant in that specific
> enumeration case, if that was the case maybe we need to break that
> function in two helpers so that all the checks can be skipped.
> 

I don't think that there's anything useful that
sdw_modify_slave_status() could do to recover from an error.

If any device IDs were programmed then, according to the statement in
sdw_modify_slave_status()

	* programming a device number will have side effects,
	* so we deal with other devices at a later time

if this is true, then we need to exit to deal with what _was_
programmed, even if one of them failed.

If nothing was programmed, and there was an error, we can't bail out of
sdw_modify_slave_status(). We have status for other devices which
we can't simply ignore.

Ultimately I can't see how pushing the error code up is useful.
sdw_modify_slave_status() can't really do any effective recovery action,
and the original behavior of giving up and returning means that
an error in programming dev ID potentially causes collateral damage to
the status of other peripherals.

>>   
>>   	do {
>>   		ret = sdw_transfer(bus, &msg);
>>   		if (ret == -ENODATA) { /* end of device id reads */
>>   			dev_dbg(bus->dev, "No more devices to enumerate\n");
>> -			ret = 0;
>>   			break;
>>   		}
>>   		if (ret < 0) {
>> @@ -781,7 +780,7 @@ static int sdw_program_device_num(struct sdw_bus *bus)
>>   				 * assigned a device ID.
>>   				 */
>>   				if (slave->status != SDW_SLAVE_UNATTACHED)
>> -					return 0;
>> +					return num_programmed;
>>   
>>   				/*
>>   				 * Assign a new dev_num to this Slave and
>> @@ -794,9 +793,11 @@ static int sdw_program_device_num(struct sdw_bus *bus)
>>   					dev_err(bus->dev,
>>   						"Assign dev_num failed:%d\n",
>>   						ret);
>> -					return ret;
>> +					return num_programmed;
>>   				}
>>   
>> +				++num_programmed;
>> +
>>   				break;
>>   			}
>>   		}
>> @@ -825,7 +826,7 @@ static int sdw_program_device_num(struct sdw_bus *bus)
>>   
>>   	} while (ret == 0 && count < (SDW_MAX_DEVICES * 2));
>>   
>> -	return ret;
>> +	return num_programmed;
>>   }
>>   
>>   static void sdw_modify_slave_status(struct sdw_slave *slave,
>> @@ -1787,14 +1788,16 @@ int sdw_handle_slave_status(struct sdw_bus *bus,
>>   
>>   	if (status[0] == SDW_SLAVE_ATTACHED) {
>>   		dev_dbg(bus->dev, "Slave attached, programming device number\n");
>> -		ret = sdw_program_device_num(bus);
>> -		if (ret < 0)
>> -			dev_err(bus->dev, "Slave attach failed: %d\n", ret);
>> +
>>   		/*
>> -		 * programming a device number will have side effects,
>> -		 * so we deal with other devices at a later time
>> +		 * Programming a device number will have side effects,
>> +		 * so we deal with other devices at a later time.
>> +		 * But only if any devices were reprogrammed, because
>> +		 * this relies on its PING state changing to ATTACHED,
>> +		 * triggering a status change.
>>   		 */
>> -		return ret;
>> +		if (sdw_program_device_num(bus))
>> +			return 0;
>>   	}
>>   
>>   	/* Continue to check other slave statuses */
