Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D7439672EF8
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Jan 2023 03:27:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229943AbjASC1U (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Jan 2023 21:27:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229646AbjASC1A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jan 2023 21:27:00 -0500
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE0B5A24E;
        Wed, 18 Jan 2023 18:26:47 -0800 (PST)
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30J1XYNn030513;
        Thu, 19 Jan 2023 02:26:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=VDBgZocVNIvdFGamlrSv0BYmZJ4ngYG+mkW6MKSc6ko=;
 b=Dfp3uLyL44ICmW7/lbNe7UieOTk3xkymZr/HMOiighaViLB234Y9F+VugF0/ggQaMOJr
 u1gAxnaOrJ96itOp3DzRMDUSPhW+8/w76wFlcV7EAWig1iumAoAyXLUS0JaedsKAZ+o7
 B/azYP3fkPS6+uS1ly4J8zn6AbPM1zS3wwx09YRu1f9eQYxsRVLezE0JCQ9eyHdw6G7R
 UQCL3Dr/R/KJUkpidTRGiQ4SYZiXBnyFAvZW/h2cXQEDkuAG28vcgx/O7X6NAmOYA42H
 LVXfnAV2olmyqfrki65OdRhiwFax7ZZM7z77kj3WYQNCIABymaRSTZgtLdTNdhPNZq8d aA== 
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3n69dpjcgj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 19 Jan 2023 02:26:41 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 30J2QeDu027072
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 19 Jan 2023 02:26:40 GMT
Received: from [10.253.35.168] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36; Wed, 18 Jan
 2023 18:26:38 -0800
Message-ID: <17047ffb-9c68-8339-a339-c51a2e721083@quicinc.com>
Date:   Thu, 19 Jan 2023 10:26:35 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.1
Subject: Re: [PATCH 2/2] wifi: ath10k: update the channel list if change in
 channel flags.
Content-Language: en-US
To:     Youghandhar Chintala <quic_youghand@quicinc.com>,
        <ath10k@lists.infradead.org>, <johannes@sipsolutions.net>
CC:     <linux-wireless@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <quic_mpubbise@quicinc.com>
References: <20221222124221.30894-1-quic_youghand@quicinc.com>
 <20221222124221.30894-3-quic_youghand@quicinc.com>
From:   Wen Gong <quic_wgong@quicinc.com>
In-Reply-To: <20221222124221.30894-3-quic_youghand@quicinc.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: 6si183OF6smCH7z2XMhkPHL7EJ2wpbXz
X-Proofpoint-ORIG-GUID: 6si183OF6smCH7z2XMhkPHL7EJ2wpbXz
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.923,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-01-18_05,2023-01-18_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 bulkscore=0
 priorityscore=1501 adultscore=0 malwarescore=0 lowpriorityscore=0
 clxscore=1011 mlxscore=0 suspectscore=0 impostorscore=0 spamscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2301190013
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/22/2022 8:42 PM, Youghandhar Chintala wrote:
...
>   
> +static void ath10k_mac_beacon_notifier(struct wiphy *wiphy)
> +{
> +	struct ieee80211_hw *hw = wiphy_to_ieee80211_hw(wiphy);
> +	struct ath10k *ar = hw->priv;
> +
> +	if (ath10k_update_channel_list(ar))
> +		ath10k_warn(ar, "failed to update channel list\n");
> +}
> +

Will this called while scan is running?
On ath11k, if send channel list to firmware, then the running scan will 
be cancel and removed.
I guess this is same for ath10k.

> ...
