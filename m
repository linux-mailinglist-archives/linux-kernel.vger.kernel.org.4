Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 60BDD5B6C27
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Sep 2022 13:04:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231833AbiIMLDw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Sep 2022 07:03:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231828AbiIMLDk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Sep 2022 07:03:40 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2438757E1F;
        Tue, 13 Sep 2022 04:03:38 -0700 (PDT)
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 28DB3M0l014719;
        Tue, 13 Sep 2022 11:03:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=iEZPpVJ0lXSE+nq3+oJbCw0rEfLkRL88PiwT3XcNp9o=;
 b=G9zzIlSY78GkYInUjdSGkvN23gv5nqI6f1SgafPROU9DzOJUJ70OM+73ojh7d8Zpwm7h
 QB5R3mAkt1p1lnhUqr2HAuLqZmkOZ6cx8NWClGoD/wBrp6pq74hMdIAv3yo3OLkHnB3Z
 knEnXDHUFPBtU6YI36pXd+r5VwqcxPffaFc1WN0dPI9mhnPWyrRED1AtG2LuXlnHrgwm
 bZ/TNMDfFBRhHGzC7NI7S3DKtPMvZMVJMnyJPL4vADB+qM/6n9k04/X73BVpn5R1Lfiq
 RWFRaRRoXiXn6+Y5ojJtmN9D6CoKORceOz6a4/9t3eTj3Lvoua++KR6E2v14H1IofOI5 qA== 
Received: from nasanppmta02.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3jgk63726x-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 13 Sep 2022 11:03:37 +0000
Received: from nasanex01a.na.qualcomm.com (corens_vlan604_snip.qualcomm.com [10.53.140.1])
        by NASANPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 28DB3aGh005068
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 13 Sep 2022 11:03:36 GMT
Received: from [10.239.133.73] (10.80.80.8) by nasanex01a.na.qualcomm.com
 (10.52.223.231) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.29; Tue, 13 Sep
 2022 04:03:35 -0700
Message-ID: <128dc161-8949-1146-bf8b-310aa33c06a8@quicinc.com>
Date:   Tue, 13 Sep 2022 19:03:32 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.0
Subject: Re: [PATCH v1] remoteproc: core: do pm relax when not first crash
To:     Mathieu Poirier <mathieu.poirier@linaro.org>
CC:     <linux-remoteproc@vger.kernel.org>,
        <linux-arm-msm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <quic_clew@quicinc.com>
References: <1662712413-38233-1-git-send-email-quic_aiquny@quicinc.com>
 <20220909192357.GA319190@p14s>
From:   "Aiqun(Maria) Yu" <quic_aiquny@quicinc.com>
In-Reply-To: <20220909192357.GA319190@p14s>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01a.na.qualcomm.com (10.52.223.231)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: ATGqns5SvN0DWDMBmPGvdstxN1Rh8YXU
X-Proofpoint-ORIG-GUID: ATGqns5SvN0DWDMBmPGvdstxN1Rh8YXU
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-09-13_03,2022-09-13_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0
 priorityscore=1501 impostorscore=0 suspectscore=0 bulkscore=0
 clxscore=1015 adultscore=0 phishscore=0 spamscore=0 mlxscore=0
 mlxlogscore=999 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2207270000 definitions=main-2209130049
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mathieu,

pm_awake and pm_relax needed to be used as a pair. There is chance that 
pm_relax is not being called, and make the device always in cannot 
suspend state.

On 9/10/2022 3:23 AM, Mathieu Poirier wrote:
> Hi Maria,
> 
> On Fri, Sep 09, 2022 at 04:33:33PM +0800, Maria Yu wrote:
>> Even if it is not first crash, need to relax the pm
>> wakelock otherwise the device will stay awake.
>>
> 
> The goal is exactly to keep the device awake...
> 
>> Signed-off-by: Maria Yu <quic_aiquny@quicinc.com>
>> ---
>>   drivers/remoteproc/remoteproc_core.c | 1 +
>>   1 file changed, 1 insertion(+)
>>
>> diff --git a/drivers/remoteproc/remoteproc_core.c b/drivers/remoteproc/remoteproc_core.c
>> index e5279ed9a8d7..30078043e939 100644
>> --- a/drivers/remoteproc/remoteproc_core.c
>> +++ b/drivers/remoteproc/remoteproc_core.c
>> @@ -1956,6 +1956,7 @@ static void rproc_crash_handler_work(struct work_struct *work)
>>   	if (rproc->state == RPROC_CRASHED || rproc->state == RPROC_OFFLINE) {
>>   		/* handle only the first crash detected */
>>   		mutex_unlock(&rproc->lock);
>> +		pm_relax(rproc->dev.parent);
> 
> If we are here it means that rproc_crash_handler_work() has already been called
> _and_ that a recovery is in process.  When the first crash handler completes
> pm_relax() will be called and the device will go to sleep as expected.
If the rproc->state cannot be changed to running state, the device will 
always be awake from this return.
Also APROC_OFFLINE state can be given in other path like an shutdown 
request is issued.

While this patch is not considering carefully as well, I think I need to 
upload a new patchset with an ordered workqueue to make each work have 
each pm_relax before return.
what do you think?
> 
> Thanks,
> Mathieu
> 
>>   		return;
>>   	}
>>   
>> -- 
>> 2.7.4
>>


-- 
Thx and BRs,
Aiqun(Maria) Yu
