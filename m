Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5BECC689EFB
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Feb 2023 17:18:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232502AbjBCQSx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Feb 2023 11:18:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231495AbjBCQSu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Feb 2023 11:18:50 -0500
Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com [67.231.152.168])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 604171CF43
        for <linux-kernel@vger.kernel.org>; Fri,  3 Feb 2023 08:18:49 -0800 (PST)
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
        by mx0b-001ae601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3135VLJe006873;
        Fri, 3 Feb 2023 10:18:33 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=PODMain02222019;
 bh=BnYGLNTq8h0hMRcu1a2dAht1uvid0WksodfxullA1h4=;
 b=n/iP52/XawhwGmrHOWt27ygD5euHuzAHpdgR3F8FTG1IJlfcv2lxNSa8lNvJFmlc8qOr
 qn+C7JUvApPoxUerGRv3+MlL0hEFW8gnyPyU/dnthJzFXtMetW/sDy/EInRCVnMoB0Ww
 LRXv1fhZZ6EvikQ1Juxa1/pJhULSMpTpa5JuOcWlDbeN7EPf3HUrOkK2B6I9cOPvJo6r
 58b3NwhaHJRpQlzGjQY0ecJmJ3NxeRoR+bSWQ4/qAaNUNw5OdB/RH8YnaLp+WP+gFY/9
 92al1Kr+nuSGnvlx1i2j+e2dNR3SuI9O7Trp5Z6BNntwCJpTR9EKrYq/ej3Y3ZNUDNDl aA== 
Received: from ediex01.ad.cirrus.com ([84.19.233.68])
        by mx0b-001ae601.pphosted.com (PPS) with ESMTPS id 3nfqv9krnp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 03 Feb 2023 10:18:32 -0600
Received: from ediex02.ad.cirrus.com (198.61.84.81) by ediex01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.21; Fri, 3 Feb
 2023 10:18:31 -0600
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by
 anon-ediex02.ad.cirrus.com (198.61.84.81) with Microsoft SMTP Server id
 15.2.1118.21 via Frontend Transport; Fri, 3 Feb 2023 10:18:31 -0600
Received: from [198.90.251.127] (edi-sw-dsktp-006.ad.cirrus.com [198.90.251.127])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id 3F2042A9;
        Fri,  3 Feb 2023 16:18:31 +0000 (UTC)
Message-ID: <2d1f1bc1-afaa-b1f4-1a93-df1bfa00405b@opensource.cirrus.com>
Date:   Fri, 3 Feb 2023 16:18:30 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH 1/2] soundwire: bus: Prevent infinite loop in
 sdw_ch_mask_to_ch()
Content-Language: en-US
To:     Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        <vkoul@kernel.org>, <yung-chuan.liao@linux.intel.com>,
        <sanyog.r.kale@intel.com>
CC:     <alsa-devel@alsa-project.org>, <linux-kernel@vger.kernel.org>,
        <patches@opensource.cirrus.com>
References: <20230202154212.1098736-1-rf@opensource.cirrus.com>
 <20230202154212.1098736-2-rf@opensource.cirrus.com>
 <0b49c924-5994-c1cd-a174-4a2e2cfaf0d2@linux.intel.com>
From:   Richard Fitzgerald <rf@opensource.cirrus.com>
In-Reply-To: <0b49c924-5994-c1cd-a174-4a2e2cfaf0d2@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: E_TKrm5iu3B59QLHCLnnsZE8uvGSNP1K
X-Proofpoint-ORIG-GUID: E_TKrm5iu3B59QLHCLnnsZE8uvGSNP1K
X-Proofpoint-Spam-Reason: safe
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03/02/2023 14:35, Pierre-Louis Bossart wrote:
> 
> 
> On 2/2/23 09:42, Richard Fitzgerald wrote:
>> Define the ch_mask argument of sdw_ch_mask_to_ch() as an unsigned
>> so that the shift right is guaranteed to eventually make the
>> value of ch_mask==0.
>>
>> Previously ch_mask was defined as a signed int, but a right
>> shift of a signed value preserves the sign bit. So if the sign
>> bit was 1, ch_mask would never become 0 and the for loop would
>> be infinite.
>> Signed-off-by: Richard Fitzgerald <rf@opensource.cirrus.com>
>> ---
>>   drivers/soundwire/bus.h | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/soundwire/bus.h b/drivers/soundwire/bus.h
>> index 7631ef5e71fb..28bedc919b78 100644
>> --- a/drivers/soundwire/bus.h
>> +++ b/drivers/soundwire/bus.h
>> @@ -160,7 +160,7 @@ int sdw_fill_msg(struct sdw_msg *msg, struct sdw_slave *slave,
>>   		 u32 addr, size_t count, u16 dev_num, u8 flags, u8 *buf);
>>   
>>   /* Retrieve and return channel count from channel mask */
>> -static inline int sdw_ch_mask_to_ch(int ch_mask)
>> +static inline int sdw_ch_mask_to_ch(unsigned int ch_mask)
>>   {
>>   	int c = 0;
>>   
> 
> This patch1 is fine, but you remove this function in patch2, so is this
> patch needed at all?
> 
> -/* Retrieve and return channel count from channel mask */
> -static inline int sdw_ch_mask_to_ch(unsigned int ch_mask)
> -{
> -	int c = 0;
> -
> -	for (c = 0; ch_mask; ch_mask >>= 1)
> -		c += ch_mask & 1;
> -
> -	return c;
> -}
> -

I'm happy to squash them, I did it in two steps so it didn't get
overlooked that there's a bugfix happening.
