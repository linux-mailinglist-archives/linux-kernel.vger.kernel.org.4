Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ECC065B6AB3
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Sep 2022 11:30:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231349AbiIMJaW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Sep 2022 05:30:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230523AbiIMJaS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Sep 2022 05:30:18 -0400
Received: from mx0b-001ae601.pphosted.com (mx0a-001ae601.pphosted.com [67.231.149.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5D6B205C6
        for <linux-kernel@vger.kernel.org>; Tue, 13 Sep 2022 02:30:16 -0700 (PDT)
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
        by mx0a-001ae601.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 28D6ssnw011959;
        Tue, 13 Sep 2022 04:29:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=PODMain02222019;
 bh=cxJEoBEl4Vi+BihLQdSoluZlTabtxlkV9KL4mlVwNPw=;
 b=fj9g+idnhP89LHmyMvrW01Ya2ALSSWkYmvh85XH4Z1CS90/NpcOrSY0oXokHG0VPGHV9
 VCLHmWRDY/dgOcjwNSvcUrGd7+pIzAGq2/3oiugXlzfXRFngCRRmp1GSoQZULi64CgNd
 7cxpScDx13uYBy7xrXEt4OY7LJFIN3hKBjZ8fQDI6iRtqh0WYt97LamwSdBN3pruovy5
 FlJv9w+ZQ8MDGRZwkdCq+GwKTPyRsy6/+r9S+Z9mbSvDueK38AgKruVcwEDt5/i8qhl9
 ntxIW2MnzOHa8oejJjXZo3nUow2x/bZS1JLLgCC/TZIVfSA6pC7cg9CMzfLCU3Bykltt MA== 
Received: from ediex01.ad.cirrus.com ([84.19.233.68])
        by mx0a-001ae601.pphosted.com (PPS) with ESMTPS id 3jgr01umgc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 13 Sep 2022 04:29:40 -0500
Received: from ediex01.ad.cirrus.com (198.61.84.80) by ediex01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.12; Tue, 13 Sep
 2022 04:29:38 -0500
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by ediex01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server id 15.2.1118.12 via Frontend
 Transport; Tue, 13 Sep 2022 04:29:38 -0500
Received: from [198.90.251.95] (edi-sw-dsktp-006.ad.cirrus.com [198.90.251.95])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id 65277468;
        Tue, 13 Sep 2022 09:29:38 +0000 (UTC)
Message-ID: <d0f32ac9-1de3-5047-b01a-04a68934a8a2@opensource.cirrus.com>
Date:   Tue, 13 Sep 2022 10:29:38 +0100
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
 <9de21235-c77d-f53f-3426-4a5927f484c9@opensource.cirrus.com>
 <9055c565-8616-8480-ea49-8db1b8707b34@linux.intel.com>
From:   Richard Fitzgerald <rf@opensource.cirrus.com>
In-Reply-To: <9055c565-8616-8480-ea49-8db1b8707b34@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: HXhpxVpPyXMEw5PzUMSjeFyU8M-pK2SG
X-Proofpoint-ORIG-GUID: HXhpxVpPyXMEw5PzUMSjeFyU8M-pK2SG
X-Proofpoint-Spam-Reason: safe
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/09/2022 18:12, Pierre-Louis Bossart wrote:
> 
> 
> On 9/12/22 17:36, Richard Fitzgerald wrote:
>> On 12/09/2022 11:53, Pierre-Louis Bossart wrote:
>>>
>>>
>>> On 9/7/22 12:14, Richard Fitzgerald wrote:
>>>> The cadence_master code needs the interrupt to complete message
>>>> transfers.
>>>> When the bus driver is being removed child drivers are removed, and
>>>> their
>>>> remove actions might need bus transactions.
>>>>
>>>> Use the sdw_master_ops.remove callback to disable the interrupt handling
>>>> only after the child drivers have been removed.
>>>>
>>>> Signed-off-by: Richard Fitzgerald <rf@opensource.cirrus.com>
>>>> ---
>>>>    drivers/soundwire/intel.c | 9 ++++++++-
>>>>    1 file changed, 8 insertions(+), 1 deletion(-)
>>>>
>>>> diff --git a/drivers/soundwire/intel.c b/drivers/soundwire/intel.c
>>>> index 01be62fa6c83..d5e723a9c80b 100644
>>>> --- a/drivers/soundwire/intel.c
>>>> +++ b/drivers/soundwire/intel.c
>>>> @@ -1255,6 +1255,13 @@ static int intel_prop_read(struct sdw_bus *bus)
>>>>        return 0;
>>>>    }
>>>>    +static void intel_bus_remove(struct sdw_bus *bus)
>>>> +{
>>>> +    struct sdw_cdns *cdns = bus_to_cdns(bus);
>>>> +
>>>> +    sdw_cdns_enable_interrupt(cdns, false);
>>>
>>> don't you need to check for any on-going transactions on the bus?
>>>
>>
>> As all the child drivers have removed, I think the only other place that
>> can generate bus transactions is the PING handler but
>> sdw_cdns_enable_interrupt(false) calls cancel_work_sync() to
>> cancel the cdns->work and it sets a flag so that it will not be
>> re-queued.
>>
>>> I wonder if there could be a corner case where there are no child
>>> devices but still a device physically attached to the bus. I am not sure
>>> if the 'no devices left' is a good-enough indication of no activity on
>>> the bus.
>>>
>>
>> As above - yes there could, but sdw_cdns_enable_interrupt(false) will
>> cancel the work and stop it being re-queued.
> 
> Ah yes, I forgot that part, thanks!
> 

... but I have noticed that there is a bug in
sdw_cdns_enable_interrupt(). It doesn't ensure that the
IRQ thread has seen the cdns->interrupt_enabled = false.
I'll add a patch to fix that when I re-push this chain.
