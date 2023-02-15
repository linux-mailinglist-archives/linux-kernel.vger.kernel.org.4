Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E4B58697AAA
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Feb 2023 12:26:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233338AbjBOL0z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Feb 2023 06:26:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233217AbjBOL0y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Feb 2023 06:26:54 -0500
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0CE4B28D05;
        Wed, 15 Feb 2023 03:26:52 -0800 (PST)
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 31F9mHmf008282;
        Wed, 15 Feb 2023 11:26:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=yZwXSKB70ZCMG1kqAHoH0/rLY/jRKvpp9gZFYBjBVIg=;
 b=iMIrbtMiHFtFFag+z0vxzXz/VSfUh/3+Gl7uYZ0pWW6hB+hPhbsQF0RZcG8XB5XICvjZ
 klZmYwMIyFjHXETosW8a3CUQD8g7dMNUDKTE2yWtZA39DIBv0q+u56ZW5T8seqFOFPY0
 41mUH6f5FB75N2iIQBgLlkzdA4FjZvLWyEXWIfrbwDmhm/WmpyYaJ5dpvMxCKQYZklhP
 w5bqbfls+TlfvGgnJ/HmDBpfJ8NExN4R28uuidp+Nt8zosW+1TBJVtPXi8hELUWkAhv2
 ZICLwDVv8KTFAvHXb8nmY6aZKHCSk9FXVhwyz0LLUCsMt/t2JqagX4E1Wjz1PLfAVM4V Nw== 
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3nr6ps3sgh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 15 Feb 2023 11:26:23 +0000
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
        by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 31FBQMo6028355
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 15 Feb 2023 11:26:22 GMT
Received: from [10.206.71.180] (10.80.80.8) by nalasex01b.na.qualcomm.com
 (10.47.209.197) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36; Wed, 15 Feb
 2023 03:26:20 -0800
Message-ID: <96cab5d9-9090-4cb2-ff17-eadc9da12f50@quicinc.com>
Date:   Wed, 15 Feb 2023 16:56:17 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.2
Subject: Re: [PATCH 1/2] wifi: cfg80211: Add beacon hint notifier support
To:     Johannes Berg <johannes@sipsolutions.net>,
        <ath10k@lists.infradead.org>
CC:     <linux-wireless@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <quic_mpubbise@quicinc.com>
References: <20221222124221.30894-1-quic_youghand@quicinc.com>
 <20221222124221.30894-2-quic_youghand@quicinc.com>
 <1df59863e78e8ddbe7eb3a74e6dd4c8f0bd7f098.camel@sipsolutions.net>
Content-Language: en-US
From:   "Youghandhar Chintala (Temp)" <quic_youghand@quicinc.com>
In-Reply-To: <1df59863e78e8ddbe7eb3a74e6dd4c8f0bd7f098.camel@sipsolutions.net>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: YupBIji6VphxvCJ0xbXQ4JYtLRQYL1z7
X-Proofpoint-GUID: YupBIji6VphxvCJ0xbXQ4JYtLRQYL1z7
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.170.22
 definitions=2023-02-15_06,2023-02-15_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 clxscore=1011
 impostorscore=0 adultscore=0 mlxlogscore=999 malwarescore=0
 priorityscore=1501 bulkscore=0 suspectscore=0 lowpriorityscore=0
 mlxscore=0 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2302150103
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 1/18/2023 10:00 PM, Johannes Berg wrote:
>> +++ b/include/net/cfg80211.h
>> @@ -5386,6 +5386,8 @@ struct wiphy {
>>   	void (*reg_notifier)(struct wiphy *wiphy,
>>   			     struct regulatory_request *request);
>>   
>> +	void (*beacon_hint_notifier)(struct wiphy *wiphy);
>
> missing documentation, for sure
I will add the missed documentation in next version of patch.
> Also this should probably be in the ops, rather than here? Not sure why
> reg_notifier is here.
I followed reg_notifier implementation.
>> -	if (channel_changed)
>> +	if (channel_changed) {
>>   		nl80211_send_beacon_hint_event(wiphy, &chan_before, chan);
>> +		if (wiphy->beacon_hint_notifier)
>> +			wiphy->beacon_hint_notifier(wiphy);
>> +	}
> This also seems excessive if you're not even passing the channel - you
> call it for every (affected) channel, but you don't tell it anything
> about the channel? Seems strange.
I will address this in next version of patch.
>
>
> However ...
>
> Why is this even needed? You should always get reg_notifier after this
> anyway?
>
> johannes

Currently when channel flag changed through the beacon hints are not 
informed to driver.

reg_notifier will be triggered for regdomain changes but not for channel flag changes due to beacon hints.

Regards,
Youghandhar

