Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DED3564046A
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Dec 2022 11:19:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233268AbiLBKTk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Dec 2022 05:19:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233282AbiLBKTh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Dec 2022 05:19:37 -0500
Received: from mx0b-001ae601.pphosted.com (mx0a-001ae601.pphosted.com [67.231.149.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7CF9CCFF0
        for <linux-kernel@vger.kernel.org>; Fri,  2 Dec 2022 02:19:33 -0800 (PST)
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
        by mx0a-001ae601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2B26LBAM009251;
        Fri, 2 Dec 2022 04:19:22 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=PODMain02222019;
 bh=mEPBtDJUF3lrYQbOAZFfdyNYc9Kp0mpGmDIp4M/hsKA=;
 b=mEDNsdrFjf9aKRCQyDCgcnIwg4S26D7NZjm4li4iRXzPj92Pgaw04TP82BhCYBIHUoFg
 7N38HDqvMSK1A1wr5U/tP2hoj72taVGYZuEN3ofPmlWWU6LfG03fTwjN3VyVnp5Kw9F+
 Iw4GjMopC6fBuPKw2iSLvdAk6TFSJ/UT1NFPPQIwQ8WhobmAcHAhXp3acQvyMIE3UYbL
 YVefJUtDDnrjnu8lAyBvPLRcRsrMPSk4BTftmOw0A+O5/8fLXdum2qqa2G/aFx4uthYd
 NlZ+zu+dR0WivDUzUqDOY0bWI6TuOs9uR6pTaU74ndr+P5dCFNXc8gkHN77geZC6L8WR Lg== 
Received: from ediex01.ad.cirrus.com ([84.19.233.68])
        by mx0a-001ae601.pphosted.com (PPS) with ESMTPS id 3m6k75spj0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 02 Dec 2022 04:19:21 -0600
Received: from ediex02.ad.cirrus.com (198.61.84.81) by ediex01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.20; Fri, 2 Dec
 2022 04:19:19 -0600
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by
 anon-ediex02.ad.cirrus.com (198.61.84.81) with Microsoft SMTP Server id
 15.2.1118.20 via Frontend Transport; Fri, 2 Dec 2022 04:19:19 -0600
Received: from [198.90.251.111] (edi-sw-dsktp-006.ad.cirrus.com [198.90.251.111])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id AF863B12;
        Fri,  2 Dec 2022 10:19:19 +0000 (UTC)
Message-ID: <030976a5-414b-17cd-33f3-427c3837727c@opensource.cirrus.com>
Date:   Fri, 2 Dec 2022 10:19:19 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [PATCH 2/3] soundwire: cadence: Remove wasted space in
 response_buf
Content-Language: en-US
To:     Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        <vkoul@kernel.org>
CC:     <yung-chuan.liao@linux.intel.com>, <sanyog.r.kale@intel.com>,
        <alsa-devel@alsa-project.org>, <linux-kernel@vger.kernel.org>,
        <patches@opensource.cirrus.com>
References: <20221201134845.4055907-1-rf@opensource.cirrus.com>
 <20221201134845.4055907-3-rf@opensource.cirrus.com>
 <cdc6b2ea-d20d-0e2e-0791-faf8f0994c78@linux.intel.com>
From:   Richard Fitzgerald <rf@opensource.cirrus.com>
In-Reply-To: <cdc6b2ea-d20d-0e2e-0791-faf8f0994c78@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: S-HG-szwv2sBjqIW403TbvgVQ8t9oemN
X-Proofpoint-GUID: S-HG-szwv2sBjqIW403TbvgVQ8t9oemN
X-Proofpoint-Spam-Reason: safe
X-Spam-Status: No, score=-3.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 01/12/2022 18:12, Pierre-Louis Bossart wrote:
> 
> 
> On 12/1/22 07:48, Richard Fitzgerald wrote:
>> The response_buf was declared much larger (128 entries) than the number
>> of responses that could ever be written into it (maximum 8).
> 
> Indeed I don't know why we used 128 entries. This is a magic value that
> doesn't appear in any specs I've looked at.
> 
> Note that there's 'sniffer' mode when each response takes two
> consecutive 32-words in the FIFO. we've never used this mode though so
> it's not really an issue.
> 
> It's also possible that this is related to the automatic command retry,
> where a failed command can be re-issued 15 times. However in that case
> the worst case would be 32 commands * 15 = 480. The value of 128 makes
> no sense at all, unless it was an upper bound for 8 * 15. We don't use
> this hardware retry btw.
> 
> See more below...
> 
>> Reduce response_buf to 8 entries and add checking in cdns_read_response()
>> to prevent overflowing reponse_buf if CDNS_MCP_RX_FIFO_AVAIL contains
>> an unexpectedly large number.
>>
>> Signed-off-by: Richard Fitzgerald <rf@opensource.cirrus.com>
>> ---
>>   drivers/soundwire/cadence_master.c | 6 ++++++
>>   drivers/soundwire/cadence_master.h | 2 +-
>>   2 files changed, 7 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/soundwire/cadence_master.c b/drivers/soundwire/cadence_master.c
>> index 27699f341f2c..95c84d9f0775 100644
>> --- a/drivers/soundwire/cadence_master.c
>> +++ b/drivers/soundwire/cadence_master.c
>> @@ -774,8 +774,14 @@ static void cdns_read_response(struct sdw_cdns *cdns)
>>   	u32 num_resp, cmd_base;
>>   	int i;
>>   
>> +	BUILD_BUG_ON(ARRAY_SIZE(cdns->response_buf) < CDNS_MCP_CMD_LEN);
>> +
>>   	num_resp = cdns_readl(cdns, CDNS_MCP_FIFOSTAT);
>>   	num_resp &= CDNS_MCP_RX_FIFO_AVAIL;
>> +	if (num_resp > ARRAY_SIZE(cdns->response_buf)) {
>> +		dev_warn(cdns->dev, "RX AVAIL %d too long\n", num_resp);
>> +		num_resp = CDNS_MCP_CMD_LEN;
> 
> .... this is different from what the hardware documentation tells me.
> The range of values to RX_FIFO_AVAIL is 0..RX_FIFO_DEPTH + 2.
> 
> I don't understand the +2, but we should maybe be more cautious and use
> u32 response_buf[CDNS_MCP_CMD_LEN + 2];
> 

Probably we wouldn't know what to do with those extra 2 responses.
_cdns_xfer_msg() tells cdns_fill_msg_resp() to extract the same number
of responses as the original message length. So it would only extract 8
maximum. But anyway yes I can add the mysterious +2 into this.
Thinking about it, that's probably a good idea anyay for the next patch
that drains the RX FIFO after an error.

>> +	}
>>   
>>   	cmd_base = CDNS_MCP_CMD_BASE;
>>   
>> diff --git a/drivers/soundwire/cadence_master.h b/drivers/soundwire/cadence_master.h
>> index 0434d70d4b1f..c2d817e8e22a 100644
>> --- a/drivers/soundwire/cadence_master.h
>> +++ b/drivers/soundwire/cadence_master.h
>> @@ -117,7 +117,7 @@ struct sdw_cdns {
>>   	struct sdw_bus bus;
>>   	unsigned int instance;
>>   
>> -	u32 response_buf[0x80];
>> +	u32 response_buf[8];
>>   	struct completion tx_complete;
>>   	struct sdw_defer *defer;
>>   
