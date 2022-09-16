Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0AA5C5BA408
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Sep 2022 03:34:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229686AbiIPBeP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Sep 2022 21:34:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229572AbiIPBeN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Sep 2022 21:34:13 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3CE2142ACD;
        Thu, 15 Sep 2022 18:34:12 -0700 (PDT)
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 28G188Bp017692;
        Fri, 16 Sep 2022 01:34:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=Z6eRLLRE2v99IpbI9QIUwHJEZ6Q1uUiI8UhTimDCPEs=;
 b=kuG5ETgtbylskiP5mGqd8A4B2nL27DZLK6A93DWr2OQeqU8Pyt7ikK3qTvf5105oXX7s
 0hbru6oplshbWPZ7d8CkbXb0k1PA4uLljYZ0JcxE5lIGJU8a6V9Fzb9UhEssDvusp0LQ
 C8Rpg4nH4k72y/nNTAkVi01x66Xmv5Tu3zefIgNa06RD0mmOP+DrIU8LP8XFB4Ib0xlB
 Gs1mOfmjeqa8GQNINGO+RO0t6wWspvwCv2ifsid0ErPHVnKgKrzp5AsYFK8BQ8NPa/Cp
 yc1MMLaFdqDA+aVw5UMlA0SvBuCK1NlcsZgUYtNVcXH+gvvWQEbgrdpXB4Q3abI2rKkV hg== 
Received: from nasanppmta04.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3jm9qcrxcc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 16 Sep 2022 01:34:10 +0000
Received: from nasanex01a.na.qualcomm.com ([10.52.223.231])
        by NASANPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 28G1YADW011908
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 16 Sep 2022 01:34:10 GMT
Received: from [10.239.133.73] (10.80.80.8) by nasanex01a.na.qualcomm.com
 (10.52.223.231) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.29; Thu, 15 Sep
 2022 18:34:08 -0700
Message-ID: <e46ea3ab-3202-bb3e-ebb6-a08444991ef0@quicinc.com>
Date:   Fri, 16 Sep 2022 09:34:05 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.0
Subject: Re: [PATCH v2] remoteproc: core: do pm relax when in RPROC_OFFLINE
To:     Mukesh Ojha <quic_mojha@quicinc.com>, <mathieu.poirier@linaro.org>
CC:     <linux-remoteproc@vger.kernel.org>,
        <linux-arm-msm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <quic_clew@quicinc.com>
References: <128dc161-8949-1146-bf8b-310aa33c06a8@quicinc.com>
 <1663236256-52289-1-git-send-email-quic_aiquny@quicinc.com>
 <2d6fb1c1-125b-7479-ed6c-7640c03a4cb8@quicinc.com>
From:   "Aiqun(Maria) Yu" <quic_aiquny@quicinc.com>
In-Reply-To: <2d6fb1c1-125b-7479-ed6c-7640c03a4cb8@quicinc.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01a.na.qualcomm.com (10.52.223.231)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: tonV3y_NWqr_MFLOOVcmNiIFE-nbFrP8
X-Proofpoint-ORIG-GUID: tonV3y_NWqr_MFLOOVcmNiIFE-nbFrP8
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-09-15_10,2022-09-14_04,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 suspectscore=0
 priorityscore=1501 adultscore=0 impostorscore=0 mlxscore=0 mlxlogscore=999
 spamscore=0 phishscore=0 lowpriorityscore=0 clxscore=1015 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2209130000
 definitions=main-2209160009
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/15/2022 8:47 PM, Mukesh Ojha wrote:
> Hi,
> 
> On 9/15/2022 3:34 PM, Maria Yu wrote:
>> RPROC_OFFLINE state indicate there is no recovery process
>> is in progress and no chance to do the pm_relax.
>> Because when recovering from crash, rproc->lock is hold and
> 
> s/hold/held ?
> 
Thanks.
>> state is RPROC_CRASHED -> RPROC_OFFLINE -> RPROC_RUNNING,
>> and then unlock rproc->lock.
>> When the state is in RPROC_OFFLINE it means separate request
>> of rproc_stop was done and no need to hold the wakeup source
>> in crash handler to recover any more.
>>
>> Signed-off-by: Maria Yu <quic_aiquny@quicinc.com>
>> ---
>>   drivers/remoteproc/remoteproc_core.c | 11 +++++++++++
>>   1 file changed, 11 insertions(+)
>>
>> diff --git a/drivers/remoteproc/remoteproc_core.c 
>> b/drivers/remoteproc/remoteproc_core.c
>> index e5279ed9a8d7..247ced6b0655 100644
>> --- a/drivers/remoteproc/remoteproc_core.c
>> +++ b/drivers/remoteproc/remoteproc_core.c
>> @@ -1956,6 +1956,17 @@ static void rproc_crash_handler_work(struct 
>> work_struct *work)
>>       if (rproc->state == RPROC_CRASHED || rproc->state == 
>> RPROC_OFFLINE) {
>>           /* handle only the first crash detected */
>>           mutex_unlock(&rproc->lock);
>> +        /*
>> +         * RPROC_OFFLINE state indicate there is no recovery process
>> +         * is in progress and no chance to have pm_relax in place.
>> +         * Because when recovering from crash, rproc->lock is hold and
> 
> ..ditto..
> 
>> +         * state is RPROC_CRASHED -> RPROC_OFFLINE -> RPROC_RUNNING,
>> +         * and then unlock rproc->lock.
>> +         * RPROC_OFFLINE is only an intermediate state in recovery
>> +         * process.
>> +         */
>> +        if (rproc->state == RPROC_OFFLINE)
>> +            pm_relax(rproc->dev.parent);
> 
> 
> Looks good, apart from minor nit.
:)
> 
> Reviewed-by: Mukesh Ojha <quic_mojha@quicinc.com>
> 
> -Mukesh
>>           return;
>>       }


-- 
Thx and BRs,
Aiqun(Maria) Yu
