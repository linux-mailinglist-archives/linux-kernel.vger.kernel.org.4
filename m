Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E0A2F673161
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Jan 2023 06:50:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229773AbjASFt6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Jan 2023 00:49:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229915AbjASFtx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jan 2023 00:49:53 -0500
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE140BC;
        Wed, 18 Jan 2023 21:49:51 -0800 (PST)
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30J4EeVe015389;
        Thu, 19 Jan 2023 05:49:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=TvLSxJKDlVSsYYhn2BY8VF0yC5B8to9hVsiCxE4epnk=;
 b=KwT8kheedk5k0XzYrO5mTUXzH7YXa1RCWfXdGhRMuO2QXS5Sdf6bSlZJoykSRLuti9zd
 PN5hMRR3bI0nxgnTSdjpWR9kikBClK+gGCXQIH4ZUSPrlKxeWdHcwbz4pY8qzmCwCr43
 KijkPAzjhz95jwjBmM+SWJFyXiGQhgCFJzKnDNvDMHHfPMVbGIgyhrEz1tB0cD59GCYc
 gLuDxOOcKXS7okX9bMOVxxoIKQg/SVvFtixeMUay4I1TxDGXkid02oeFmubBkPTETD3q
 9YnGw9m4HVfABmlTTkz1ghG8cbOBY2P1gOhvmZgYU2qpU/6lWKzsuRVE6nXhe9p17301 ow== 
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3n6debt8a2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 19 Jan 2023 05:49:31 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 30J5nUjm027196
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 19 Jan 2023 05:49:30 GMT
Received: from [10.50.23.189] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36; Wed, 18 Jan
 2023 21:49:28 -0800
Message-ID: <a4f47e6e-637d-8eb8-6bc1-a2dfc8e3632a@quicinc.com>
Date:   Thu, 19 Jan 2023 11:17:59 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH 2/2] wifi: ath10k: update the channel list if change in
 channel flags.
To:     Wen Gong <quic_wgong@quicinc.com>, <ath10k@lists.infradead.org>,
        <johannes@sipsolutions.net>
CC:     <linux-wireless@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <quic_mpubbise@quicinc.com>
References: <20221222124221.30894-1-quic_youghand@quicinc.com>
 <20221222124221.30894-3-quic_youghand@quicinc.com>
 <17047ffb-9c68-8339-a339-c51a2e721083@quicinc.com>
Content-Language: en-US
From:   "Youghandhar Chintala (Temp)" <quic_youghand@quicinc.com>
In-Reply-To: <17047ffb-9c68-8339-a339-c51a2e721083@quicinc.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: XshOoqtEjauMBIV8xfz67Qos_iC8ft_x
X-Proofpoint-ORIG-GUID: XshOoqtEjauMBIV8xfz67Qos_iC8ft_x
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.923,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-01-18_05,2023-01-18_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 mlxlogscore=906 adultscore=0 bulkscore=0 spamscore=0
 lowpriorityscore=0 phishscore=0 suspectscore=0 impostorscore=0
 clxscore=1015 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2301190044
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 1/19/2023 7:56 AM, Wen Gong wrote:
> On 12/22/2022 8:42 PM, Youghandhar Chintala wrote:
> ...
>>   +static void ath10k_mac_beacon_notifier(struct wiphy *wiphy)
>> +{
>> +    struct ieee80211_hw *hw = wiphy_to_ieee80211_hw(wiphy);
>> +    struct ath10k *ar = hw->priv;
>> +
>> +    if (ath10k_update_channel_list(ar))
>> +        ath10k_warn(ar, "failed to update channel list\n");
>> +}
>> +
>
> Will this called while scan is running?
> On ath11k, if send channel list to firmware, then the running scan 
> will be cancel and removed.
> I guess this is same for ath10k.
>
>> ...

Yes Wen. You are right.

Regards,

Youghandhar

