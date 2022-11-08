Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 24C83620C48
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Nov 2022 10:33:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232939AbiKHJcv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Nov 2022 04:32:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233522AbiKHJco (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Nov 2022 04:32:44 -0500
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61DBB13F3A;
        Tue,  8 Nov 2022 01:32:43 -0800 (PST)
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2A87sGep002648;
        Tue, 8 Nov 2022 09:32:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=GFimtkGd4X5sNcwitFqbrGsUYGX/9oHdzJgyVyCBYfI=;
 b=kYjqzHnbKNO1JD/XDxLmITuWBnz6dSRKGep8xaI8KmpHcqxLGmusLJC50VqSNikTANOv
 DtOVDe5CookusU2h60yZGMXp93TUZOB3Q/iKorUR6EPE3Gge0fMXAlL+IltmYIg7TyWJ
 KYDz42YC3cB2brJHR/7pUAYVWxYSc612YPQW65BSzzx1NWpWwNFj5+V/GI/hIo/bqa3j
 tVjJoK3t6ARVKgO4AAhnlbmERDiWR9uta5yiJcM7VghZHXMrvDq7Pk4N6B8OZ+YLoM4x
 gqqn8iAHsc9TkSlUBVZSFKDNGBXPeScr55D5TXEF6EPwTgHqCONgpsrQpIB7U9T6ZnMi EA== 
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3kqhmggc01-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 08 Nov 2022 09:32:08 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 2A89W70D015294
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 8 Nov 2022 09:32:07 GMT
Received: from [10.79.43.101] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.29; Tue, 8 Nov 2022
 01:32:03 -0800
Message-ID: <43662bfd-2f3d-5264-c9c2-5187f573a924@quicinc.com>
Date:   Tue, 8 Nov 2022 15:01:52 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [PATCH] cpufreq: qcom-hw: Fix memory leak in
 qcom_cpufreq_hw_read_lut()
Content-Language: en-US
To:     Chen Hui <judy.chenhui@huawei.com>, <agross@kernel.org>,
        <andersson@kernel.org>, <konrad.dybcio@somainline.org>,
        <rafael@kernel.org>, <viresh.kumar@linaro.org>,
        <sibis@codeaurora.org>, <mka@chromium.org>
CC:     <linux-arm-msm@vger.kernel.org>, <linux-pm@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
References: <20221108072302.736-1-judy.chenhui@huawei.com>
From:   Sibi Sankar <quic_sibis@quicinc.com>
In-Reply-To: <20221108072302.736-1-judy.chenhui@huawei.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: pi39rmtiAGnMT-DB1gQ1c8xNFmZo4zGQ
X-Proofpoint-ORIG-GUID: pi39rmtiAGnMT-DB1gQ1c8xNFmZo4zGQ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-07_11,2022-11-07_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 clxscore=1011 impostorscore=0 adultscore=0 suspectscore=0 mlxlogscore=999
 priorityscore=1501 phishscore=0 malwarescore=0 mlxscore=0 spamscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2210170000 definitions=main-2211080051
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hey Chen,

Thanks for the patch.

On 11/8/22 12:53, Chen Hui wrote:
> If "cpu_dev" fails to get opp table in qcom_cpufreq_hw_read_lut(),
> the program will return, resulting in "table" resource is not released.
> 
> Fixes: 51c843cf77bb ("cpufreq: qcom: Update the bandwidth levels on frequency change")

Reviewed-by: Sibi Sankar <quic_sibis@quicinc.com>

> Signed-off-by: Chen Hui <judy.chenhui@huawei.com>
> ---
>   drivers/cpufreq/qcom-cpufreq-hw.c | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/cpufreq/qcom-cpufreq-hw.c b/drivers/cpufreq/qcom-cpufreq-hw.c
> index 833589bc95e4..d15097549e8c 100644
> --- a/drivers/cpufreq/qcom-cpufreq-hw.c
> +++ b/drivers/cpufreq/qcom-cpufreq-hw.c
> @@ -193,6 +193,7 @@ static int qcom_cpufreq_hw_read_lut(struct device *cpu_dev,
>   		}
>   	} else if (ret != -ENODEV) {
>   		dev_err(cpu_dev, "Invalid opp table in device tree\n");
> +		kfree(table);
>   		return ret;
>   	} else {
>   		policy->fast_switch_possible = true;
