Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C3DC86975BE
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Feb 2023 06:17:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232749AbjBOFRN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Feb 2023 00:17:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230212AbjBOFRK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Feb 2023 00:17:10 -0500
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89D106E80;
        Tue, 14 Feb 2023 21:17:09 -0800 (PST)
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 31F1hgf7018371;
        Wed, 15 Feb 2023 05:17:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=oGCT/5IFWwFCKLzPtnIq0Q+X/5HAUDivyeTJBKdWj6k=;
 b=f3c/TU25ZSEFeTr9eUhy2sma03vAshydzKIYpVyUACaOXPNE0NwX9hjARWew7Ugk7rps
 rMSxBl3F0SuSEKofZIPeyxZhJW3hzhXhDzklQmiRoZNucT9UEygzPs68K225IQmI3xBh
 cdf9Sjzu3jFFTs6JKXWY+sHUznps4pEXTSevy91eH3I0EVzNPK67iVqBvPF/sf4FzkeY
 dJ3qsKTzOxvppjc449e3Y6T0eeq7hgj+mchDfLw9r3g6oy3mr4o7zaFjyAUbjC6vWXxI
 nzDWiXUMSqQIUookx86BqVexrFzJ1+n6xgz7LtUFZy1lYHlFOqyWVYhU1GL8DHffaTtU 9g== 
Received: from nasanppmta03.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3nr6qkjwe5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 15 Feb 2023 05:17:05 +0000
Received: from nasanex01c.na.qualcomm.com (nasanex01c.na.qualcomm.com [10.45.79.139])
        by NASANPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 31F5H42T027026
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 15 Feb 2023 05:17:04 GMT
Received: from [10.216.8.213] (10.80.80.8) by nasanex01c.na.qualcomm.com
 (10.45.79.139) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36; Tue, 14 Feb
 2023 21:17:01 -0800
Message-ID: <8aeea3f5-7b90-f384-33ab-ba7b4afb5317@quicinc.com>
Date:   Wed, 15 Feb 2023 10:46:58 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH] remoteproc: qcom: replace kstrdup with kstrndup
Content-Language: en-US
To:     Bjorn Andersson <andersson@kernel.org>
CC:     <dmitry.baryshkov@linaro.org>, <agross@kernel.org>,
        <mathieu.poirier@linaro.org>, <konrad.dybcio@linaro.org>,
        <linux-arm-msm@vger.kernel.org>,
        <linux-remoteproc@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <1675180866-16695-1-git-send-email-quic_mojha@quicinc.com>
 <1676383691-29738-1-git-send-email-quic_mojha@quicinc.com>
 <20230214163944.y5tkgdfmsycmpg7p@ripper>
From:   Mukesh Ojha <quic_mojha@quicinc.com>
In-Reply-To: <20230214163944.y5tkgdfmsycmpg7p@ripper>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01c.na.qualcomm.com (10.45.79.139)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: 9PlTnfRyFABlGgXrF7iH0q31QJ30WOon
X-Proofpoint-ORIG-GUID: 9PlTnfRyFABlGgXrF7iH0q31QJ30WOon
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.170.22
 definitions=2023-02-15_02,2023-02-14_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 adultscore=0
 clxscore=1015 bulkscore=0 impostorscore=0 suspectscore=0
 lowpriorityscore=0 spamscore=0 priorityscore=1501 mlxscore=0 phishscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2302150047
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2/14/2023 10:09 PM, Bjorn Andersson wrote:
> On Tue, Feb 14, 2023 at 07:38:11PM +0530, Mukesh Ojha wrote:
>> Since, there is no guarantee that region.name will be 0-terminated
>> from the firmware side, replace kstrdup with kstrndup.
>>
>> Suggested-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
>> Signed-off-by: Mukesh Ojha <quic_mojha@quicinc.com>
> 
> Please don't send additional patches in-reply-to another patch, it makes
> it impossible to use b4 to pick up the first patch.
> 
> And please don't send two patches which clearly will conflict with
> each other. Now I had to manually apply the first patch...
> 

Really sorry, for the inconvenience.
will keep in mind.

Thanks,
-Mukesh

> Regards,
> Bjorn
> 
>> ---
>>   drivers/remoteproc/qcom_common.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/remoteproc/qcom_common.c b/drivers/remoteproc/qcom_common.c
>> index 020349f..7810f91 100644
>> --- a/drivers/remoteproc/qcom_common.c
>> +++ b/drivers/remoteproc/qcom_common.c
>> @@ -124,7 +124,7 @@ static int qcom_add_minidump_segments(struct rproc *rproc, struct minidump_subsy
>>   	for (i = 0; i < seg_cnt; i++) {
>>   		memcpy_fromio(&region, ptr + i, sizeof(region));
>>   		if (region.valid == MD_REGION_VALID) {
>> -			name = kstrdup(region.name, GFP_KERNEL);
>> +			name = kstrndup(region.name, MAX_REGION_NAME_LENGTH - 1, GFP_KERNEL);
>>   			if (!name) {
>>   				iounmap(ptr);
>>   				return -ENOMEM;
>> -- 
>> 2.7.4
>>
