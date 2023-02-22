Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E79469EBE5
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Feb 2023 01:23:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230341AbjBVAXE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Feb 2023 19:23:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229448AbjBVAXD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Feb 2023 19:23:03 -0500
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1732825E3D;
        Tue, 21 Feb 2023 16:23:01 -0800 (PST)
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 31LNkrE9023676;
        Wed, 22 Feb 2023 00:22:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=GSqS92vIwQB799pi53rSrb1ngxfts/lxtA22QEfZ/Rk=;
 b=JLsEKJGAh/bi28x0DMUuK19FWhmJSNgj06XHZZm1i9Vyl4BY4eHXvq3RpgkFuf0EdYhn
 sDkN3FuokqzEsvtHnXiM3bbnl5rbUhOSLkghTmeUwy3OBkZT629FZkYYqMQNyaZARDGF
 Si/yy1sQZyMMyKtFqwvNQaIdC9C6gQKiXXhYf/4nNxaaxIi0j2RwBXibMufAcq+gqN6+
 4cvLLkGGUCKqKnflJ/yS5tmSyuL0q5gGiFFuuhm9s99H7UVKyMwLX43670SXu5VxOZGM
 wS2Aj6pb9pAflGKnj7qMjfMrx9kuyP2noxbTMVC0T9lfov8mWmkWkXguhq5qnx9VFmkG fg== 
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3nvtbxa4we-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 22 Feb 2023 00:22:48 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 31M0Ml52023334
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 22 Feb 2023 00:22:47 GMT
Received: from [10.253.74.210] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Tue, 21 Feb
 2023 16:22:45 -0800
Message-ID: <9ae693f2-b19e-ff1f-851c-c3d09db4d9d1@quicinc.com>
Date:   Wed, 22 Feb 2023 08:22:43 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.1
Subject: Re: [PATCH 1/2] wifi: cfg80211: Add beacon hint notifier support
Content-Language: en-US
To:     Johannes Berg <johannes@sipsolutions.net>,
        "Youghandhar Chintala (Temp)" <quic_youghand@quicinc.com>,
        <ath10k@lists.infradead.org>
CC:     <linux-wireless@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <quic_mpubbise@quicinc.com>, Wen Gong <quic_wgong@quicinc.com>
References: <20221222124221.30894-1-quic_youghand@quicinc.com>
 <20221222124221.30894-2-quic_youghand@quicinc.com>
 <1df59863e78e8ddbe7eb3a74e6dd4c8f0bd7f098.camel@sipsolutions.net>
 <96cab5d9-9090-4cb2-ff17-eadc9da12f50@quicinc.com>
 <0d4b99ab0a5bedc82f35bc1e548a611564b010e5.camel@sipsolutions.net>
From:   Wen Gong <quic_wgong@quicinc.com>
In-Reply-To: <0d4b99ab0a5bedc82f35bc1e548a611564b010e5.camel@sipsolutions.net>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: Dvi9KBhRlHTNhdqvYm6bry6T-3irrzVO
X-Proofpoint-ORIG-GUID: Dvi9KBhRlHTNhdqvYm6bry6T-3irrzVO
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.170.22
 definitions=2023-02-21_13,2023-02-20_02,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 lowpriorityscore=0 bulkscore=0 clxscore=1011 mlxscore=0 spamscore=0
 phishscore=0 mlxlogscore=764 impostorscore=0 adultscore=0 malwarescore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2302220000
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 2/15/2023 11:10 PM, Johannes Berg wrote:
>>> Why is this even needed? You should always get reg_notifier after this
>>> anyway?
>> Currently when channel flag changed through the beacon hints are not
>> informed to driver.
>>
>> reg_notifier will be triggered for regdomain changes but not for channel flag changes due to beacon hints.
>>
> So maybe triggering reg notifier once would be sufficient, a la Wen's
> patch that I recently merged?

My patch only take effect for this flag, not for all wiphy.

if (wiphy->flags & WIPHY_FLAG_NOTIFY_REGDOM_BY_DRIVER)

https://git.kernel.org/pub/scm/linux/kernel/git/kvalo/ath.git/commit?id=d99975c4953eb79e389d4630e848435c700e2dfc

>
> johannes
>
