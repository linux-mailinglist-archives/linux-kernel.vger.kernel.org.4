Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DAB01667E96
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Jan 2023 20:04:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232772AbjALTEF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Jan 2023 14:04:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230385AbjALTDM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jan 2023 14:03:12 -0500
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B9296951B;
        Thu, 12 Jan 2023 10:42:28 -0800 (PST)
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30CIKLmL013835;
        Thu, 12 Jan 2023 18:42:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=avfOBY7qvXyRddvkWYry9tNFbdDWtZH/PaLOovOizhA=;
 b=hMgPGkhzHzxX+heRi2x5eNuuvWFrUV78AEgMfNHl0+cHo6FMjX7ns+8agaT4c3hAbcFz
 a4k0OTZUpHKHkfJbF+4Bg6LXCohYlF5PXUETDTXdFT9ioZaIc+pJndYkV2h+YCXlAUbo
 MXgT9hNCEmFRYPASLuJodxfkAdxF7Uw1+PO5BlbCBabG14AmnMXoZYWzFbLADTMyqVk5
 7hendzGEyOYGhwmLCAzR0AsLDgr9w7E3RPgajqR87/GF35AWzoD1wpWN3WldksdgEaK1
 Ik+6Om4uZbbBYbZkEiEiOq+xHFNA9X2Yrmrx6MzewoZJ9mPTDdYAJdOSm1AQ/ggjPD1J PA== 
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3n2k47gr34-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 12 Jan 2023 18:42:20 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 30CIgJZT024170
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 12 Jan 2023 18:42:19 GMT
Received: from [10.79.43.91] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36; Thu, 12 Jan
 2023 10:42:16 -0800
Message-ID: <991d6680-480c-b9be-e09b-3b129dbb40a6@quicinc.com>
Date:   Fri, 13 Jan 2023 00:12:13 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [PATCH V8 2/2] firmware: qcom: scm: Add wait-queue handling logic
Content-Language: en-US
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        <andersson@kernel.org>
CC:     <agross@kernel.org>, <linux-arm-msm@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <robh+dt@kernel.org>,
        <konrad.dybcio@somainline.org>, <robimarko@gmail.com>,
        <quic_gurus@quicinc.com>
References: <20230111101718.9225-1-quic_sibis@quicinc.com>
 <20230111101718.9225-3-quic_sibis@quicinc.com>
 <00e70137-3cc3-877e-5435-ac15f750f466@linaro.org>
From:   Sibi Sankar <quic_sibis@quicinc.com>
In-Reply-To: <00e70137-3cc3-877e-5435-ac15f750f466@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: eUHkfjsOA3L9p99ZLzrhx0H3T6VgtG0Q
X-Proofpoint-ORIG-GUID: eUHkfjsOA3L9p99ZLzrhx0H3T6VgtG0Q
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2023-01-12_10,2023-01-12_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 clxscore=1015 mlxscore=0 bulkscore=0 adultscore=0
 mlxlogscore=884 impostorscore=0 lowpriorityscore=0 spamscore=0
 suspectscore=0 phishscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2212070000 definitions=main-2301120135
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hey Srini,
Thanks for taking time to review the series.

On 1/11/23 21:31, Srinivas Kandagatla wrote:
> 
> 
> On 11/01/2023 10:17, Sibi Sankar wrote:
>> +static int qcom_scm_waitq_wakeup(struct qcom_scm *scm, unsigned int 
>> wq_ctx, bool wake_all)
>> +{
>> +    int ret;
>> +
>> +    ret = qcom_scm_assert_valid_wq_ctx(wq_ctx);
>> +    if (ret)
>> +        return ret;
>> +
>> +    if (wake_all)
>> +        complete_all(&__scm->waitq_comp);
> 
> As you explained in v7 that there will be only one caller at any point 
> in time and that will be synchronous, so complete_all here is a dead 
> code, isn't it?
> 
> Adding complete_all here is missleading and will require reinit 
> completion in case you want to reuse the same completion.
> 
> AFAIU, you should remove support to wake_all in this patchset and add it 
> when we really can do multiple scm calls simultaneously.
> 

ACK, IIRC v4 of the series had it dropped and was added
later on for feature parity but like you pointed out it's
dead code and should be added back later when there is support
for it. I'll fix this in the next re-spin.


> --srini
> 
> --srini
>> +    else
>> +        complete(&__scm->waitq_comp);
>> +
