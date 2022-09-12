Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 01D5C5B5D4F
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Sep 2022 17:37:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230182AbiILPgp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Sep 2022 11:36:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230378AbiILPgc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Sep 2022 11:36:32 -0400
Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com [67.231.152.168])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED7E630F56
        for <linux-kernel@vger.kernel.org>; Mon, 12 Sep 2022 08:36:30 -0700 (PDT)
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
        by mx0b-001ae601.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 28CDO0TH025384;
        Mon, 12 Sep 2022 10:36:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=PODMain02222019;
 bh=eU9Fp7PfOHjpPPUa8134+maR0Y9k1aTyalwtsLMt2K8=;
 b=q2c6sSzRHIrNLvYTa7A9EGYxMQS4TgAqBTKam16Iyyrzbct2oyyo4QZas0der/NpX8rq
 a5w1hBCNzUALjob70bKv7n63tvWhNxkgKfXirJjeyTdz3V+51Um00CSf5tKnkSSLRyPk
 gQE2IKHOR3k14oPGaI7KUzLYhADVEDu+AQckjAmlPm4oHnztWfZM6UjZkaBMRo8i9ITp
 aHr8icBR0FvuVOfkpJauZxDF4NhXrb62l7ifFB9jd/uStKbNbm0Po436n0jWVqZcAEAi
 aQD6UST+W/bcVw+kowNP+D1IhsK+zbJ4N3MHqsbM5bYrJ7OuKPbCzKCj/XWCKtEvxhGs xg== 
Received: from ediex01.ad.cirrus.com ([84.19.233.68])
        by mx0b-001ae601.pphosted.com (PPS) with ESMTPS id 3jgq0ntfuw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 12 Sep 2022 10:36:11 -0500
Received: from ediex02.ad.cirrus.com (198.61.84.81) by ediex01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.12; Mon, 12 Sep
 2022 10:36:09 -0500
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by
 anon-ediex02.ad.cirrus.com (198.61.84.81) with Microsoft SMTP Server id
 15.2.1118.12 via Frontend Transport; Mon, 12 Sep 2022 10:36:09 -0500
Received: from [198.90.251.95] (edi-sw-dsktp-006.ad.cirrus.com [198.90.251.95])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id 518DD2C5;
        Mon, 12 Sep 2022 15:36:09 +0000 (UTC)
Message-ID: <9de21235-c77d-f53f-3426-4a5927f484c9@opensource.cirrus.com>
Date:   Mon, 12 Sep 2022 16:36:09 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [PATCH 5/7] soundwire: intel: Don't disable interrupt until
 children are removed
Content-Language: en-US
To:     Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        <vkoul@kernel.org>, <yung-chuan.liao@linux.intel.com>,
        <lgirdwood@gmail.com>, <peter.ujfalusi@linux.intel.com>,
        <ranjani.sridharan@linux.intel.com>,
        <kai.vehmanen@linux.intel.com>, <daniel.baluta@nxp.com>,
        <sanyog.r.kale@intel.com>, <broonie@kernel.org>
CC:     <patches@opensource.cirrus.com>, <alsa-devel@alsa-project.org>,
        <linux-kernel@vger.kernel.org>,
        <sound-open-firmware@alsa-project.org>
References: <20220907101402.4685-1-rf@opensource.cirrus.com>
 <20220907101402.4685-6-rf@opensource.cirrus.com>
 <c83fb25e-ef59-63e1-4223-648dab9885ea@linux.intel.com>
From:   Richard Fitzgerald <rf@opensource.cirrus.com>
In-Reply-To: <c83fb25e-ef59-63e1-4223-648dab9885ea@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: 5l9_s5s92997QXhoL8gsk2eY4s0OPr1T
X-Proofpoint-ORIG-GUID: 5l9_s5s92997QXhoL8gsk2eY4s0OPr1T
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

On 12/09/2022 11:53, Pierre-Louis Bossart wrote:
> 
> 
> On 9/7/22 12:14, Richard Fitzgerald wrote:
>> The cadence_master code needs the interrupt to complete message transfers.
>> When the bus driver is being removed child drivers are removed, and their
>> remove actions might need bus transactions.
>>
>> Use the sdw_master_ops.remove callback to disable the interrupt handling
>> only after the child drivers have been removed.
>>
>> Signed-off-by: Richard Fitzgerald <rf@opensource.cirrus.com>
>> ---
>>   drivers/soundwire/intel.c | 9 ++++++++-
>>   1 file changed, 8 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/soundwire/intel.c b/drivers/soundwire/intel.c
>> index 01be62fa6c83..d5e723a9c80b 100644
>> --- a/drivers/soundwire/intel.c
>> +++ b/drivers/soundwire/intel.c
>> @@ -1255,6 +1255,13 @@ static int intel_prop_read(struct sdw_bus *bus)
>>   	return 0;
>>   }
>>   
>> +static void intel_bus_remove(struct sdw_bus *bus)
>> +{
>> +	struct sdw_cdns *cdns = bus_to_cdns(bus);
>> +
>> +	sdw_cdns_enable_interrupt(cdns, false);
> 
> don't you need to check for any on-going transactions on the bus?
>

As all the child drivers have removed, I think the only other place that
can generate bus transactions is the PING handler but
sdw_cdns_enable_interrupt(false) calls cancel_work_sync() to
cancel the cdns->work and it sets a flag so that it will not be
re-queued.

> I wonder if there could be a corner case where there are no child
> devices but still a device physically attached to the bus. I am not sure
> if the 'no devices left' is a good-enough indication of no activity on
> the bus.
>

As above - yes there could, but sdw_cdns_enable_interrupt(false) will
cancel the work and stop it being re-queued.

>> +}
>> +
>>   static struct sdw_master_ops sdw_intel_ops = {
>>   	.read_prop = sdw_master_read_prop,
>>   	.override_adr = sdw_dmi_override_adr,
>> @@ -1264,6 +1271,7 @@ static struct sdw_master_ops sdw_intel_ops = {
>>   	.set_bus_conf = cdns_bus_conf,
>>   	.pre_bank_switch = intel_pre_bank_switch,
>>   	.post_bank_switch = intel_post_bank_switch,
>> +	.remove = intel_bus_remove,
>>   };
>>   
>>   static int intel_init(struct sdw_intel *sdw)
>> @@ -1502,7 +1510,6 @@ static void intel_link_remove(struct auxiliary_device *auxdev)
>>   	 */
>>   	if (!bus->prop.hw_disabled) {
>>   		intel_debugfs_exit(sdw);
>> -		sdw_cdns_enable_interrupt(cdns, false);
>>   		snd_soc_unregister_component(dev);
>>   	}
>>   	sdw_bus_master_delete(bus);
