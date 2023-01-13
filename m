Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4FB4C66967E
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Jan 2023 13:10:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240751AbjAMMKL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Jan 2023 07:10:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240928AbjAMMJW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Jan 2023 07:09:22 -0500
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35A55736C0;
        Fri, 13 Jan 2023 04:03:06 -0800 (PST)
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30DBs2ik021014;
        Fri, 13 Jan 2023 12:02:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=WV1GMeXtHBAkSXAwxixVT2ra972So+jSDMEr/4FiIc0=;
 b=eqGPxT9dgnpzVQUTssleakiwPWCkmwe5Kde0cseueAZ3r9imfLBWequbgnEujOHp2f9z
 Yn/FOlMvCyafnjVr1l+q/BfYg7OBMR0KMDQb2DIeMGZ9GxC/ZiSq1GtI+IW/dNV4eVT+
 vrpOXPlm7bN0vjPh2ZptsDCjRslqXYkmY2d4ZwM0WmF8ygTYID36XqiSPyRtieiq9MKs
 wQbtxoAu+oJrZpM1oVSdhGTiY2XNP2pqk+Tg6W0TfLV1xAn1CZrGLSR7yD6s4xL5NCg5
 FtmdOi9TqjfN8tKSMN9nhZUWioCSm/i/1eLguvhnNDDF7Nhd5+er4t1Gw7dshbcEcUmx vA== 
Received: from nasanppmta03.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3n2k47jn51-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 13 Jan 2023 12:02:54 +0000
Received: from nasanex01c.na.qualcomm.com (nasanex01c.na.qualcomm.com [10.45.79.139])
        by NASANPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 30DC2qPJ017272
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 13 Jan 2023 12:02:52 GMT
Received: from [10.216.54.29] (10.80.80.8) by nasanex01c.na.qualcomm.com
 (10.45.79.139) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36; Fri, 13 Jan
 2023 04:02:49 -0800
Message-ID: <240e0299-96ca-2703-1339-1c52c4c1582d@quicinc.com>
Date:   Fri, 13 Jan 2023 17:32:46 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.1
Subject: Re: [PATCH] pstore/ram: Rework logic for detecting ramoops
Content-Language: en-US
To:     Kees Cook <keescook@chromium.org>
CC:     <tony.luck@intel.com>, <gpiccoli@igalia.com>,
        <linux-hardening@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <1673428065-22356-1-git-send-email-quic_mojha@quicinc.com>
 <202301121337.B8CCCB6@keescook>
From:   Mukesh Ojha <quic_mojha@quicinc.com>
In-Reply-To: <202301121337.B8CCCB6@keescook>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01c.na.qualcomm.com (10.45.79.139)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: KtUFqNPyFmQfR45qIlgY16zdOw1gfnCq
X-Proofpoint-ORIG-GUID: KtUFqNPyFmQfR45qIlgY16zdOw1gfnCq
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.923,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-01-13_05,2023-01-13_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 clxscore=1015 mlxscore=0 bulkscore=0 adultscore=0
 mlxlogscore=999 impostorscore=0 lowpriorityscore=0 spamscore=0
 suspectscore=0 phishscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2212070000 definitions=main-2301130081
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Kees,

Thanks for your comments.

On 1/13/2023 3:09 AM, Kees Cook wrote:
> On Wed, Jan 11, 2023 at 02:37:45PM +0530, Mukesh Ojha wrote:
>> The reserved memory region for ramoops is assumed to be at a fixed
>> and known location when read from the devicetree. This is not desirable
>> in environments where it is preferred the region to be dynamically
>> allocated at runtime, as opposed to being fixed at compile time.
>>
>> Also, Some of the platforms might be still expecting dedicated
>> memory region for ramoops node where the region is known
>> beforehand and platform_get_resource() is used in that case.
>>
>> So, Add logic to detect the start and size of the ramoops memory
>> region by looking up reserved memory region with
>> of_reserved_mem_lookup() when platform_get_resource() failed.
>>
>> Signed-off-by: Mukesh Ojha <quic_mojha@quicinc.com>
> 
> Thanks for the patch! Notes below...
> 
>> ---
>>   fs/pstore/ram.c | 19 ++++++++++++++-----
>>   1 file changed, 14 insertions(+), 5 deletions(-)
>>
>> diff --git a/fs/pstore/ram.c b/fs/pstore/ram.c
>> index ade66db..e4bbba1 100644
>> --- a/fs/pstore/ram.c
>> +++ b/fs/pstore/ram.c
>> @@ -20,6 +20,7 @@
>>   #include <linux/compiler.h>
>>   #include <linux/of.h>
>>   #include <linux/of_address.h>
>> +#include <linux/of_reserved_mem.h>
>>   
>>   #include "internal.h"
>>   #include "ram_internal.h"
>> @@ -643,6 +644,7 @@ static int ramoops_parse_dt(struct platform_device *pdev,
>>   {
>>   	struct device_node *of_node = pdev->dev.of_node;
>>   	struct device_node *parent_node;
>> +	struct reserved_mem *rmem;
>>   	struct resource *res;
>>   	u32 value;
>>   	int ret;
>> @@ -651,13 +653,20 @@ static int ramoops_parse_dt(struct platform_device *pdev,
>>   
>>   	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
>>   	if (!res) {
>> -		dev_err(&pdev->dev,
>> -			"failed to locate DT /reserved-memory resource\n");
>> -		return -EINVAL;
>> +		rmem = of_reserved_mem_lookup(of_node);
>> +		if (rmem) {
>> +			pdata->mem_size = rmem->size;
>> +			pdata->mem_address = rmem->base;
>> +		} else {
>> +			dev_err(&pdev->dev,
>> +				"failed to locate DT /reserved-memory resource\n");
>> +			return -EINVAL;
>> +		}
> 
> Since the "else" case returns, the traditional code pattern is to leave
> the other case "inline" (an indented), like so:
> 
> 		if (!rmem) {
> 			dev_err(&pdev->dev,
> 				"failed to locate DT /reserved-memory resource\n");
> 			return -EINVAL;
> 		}
> 		pdata->mem_size = rmem->size;
> 		pdata->mem_address = rmem->base;
> 

Fixed it in v2.

> 
>> +	} else {
>> +		pdata->mem_size = resource_size(res);
>> +		pdata->mem_address = res->start;
>>   	}
> 
> Since this change the potential interface with DT, can you also update
> the documentation in:
> 
> Documentation/devicetree/bindings/reserved-memory/ramoops.yaml
> 
> Or maybe my understanding of DT parsing is lacking and this change is
> doing something slightly different?
>

Have updated the docs in v2;

-Mukesh
