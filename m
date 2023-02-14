Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC6FB69654D
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Feb 2023 14:46:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232950AbjBNNqw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Feb 2023 08:46:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233113AbjBNNqj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Feb 2023 08:46:39 -0500
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5122C298CB;
        Tue, 14 Feb 2023 05:45:48 -0800 (PST)
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 31E9TIcc018659;
        Tue, 14 Feb 2023 13:44:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=Vp2fHwymSvhY5DxtYIGyE7DyxmKylLyMV1jfDjXcPmg=;
 b=lOVHvWKes/MjMu7DRv/jMVoDWeugIlnKBQ0vI5IIKVSJ5Pjd61DDA2IwBWuJ8DEhjDM5
 xEECB2K7O5mWv5w/gaXZysLwFLvksUhipEWR9iLIFpQK9SQN0Yf63BrHE+3ql5lYvEGk
 e692FwSzOelH7BZNzpGwl5SYmqdA+QYg/4xSjgfEQaBpsGJAD10CDYru05/dR6F6YVwD
 nFMVbr82rdKkSjgn0NwRnOVutLQP2yzOlDKGMvNPUgan3/FsrObtlWyAzOowoTNZNqAh
 OruFFo9QHKL5QNIuijpxsdqhQUUqXkZEokK0xFgdL41lbpD6zo2BSNnUid8OVW636HIe nA== 
Received: from nasanppmta04.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3nqtsut9w1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 14 Feb 2023 13:44:14 +0000
Received: from nasanex01c.na.qualcomm.com (nasanex01c.na.qualcomm.com [10.45.79.139])
        by NASANPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 31EDiDvU023407
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 14 Feb 2023 13:44:13 GMT
Received: from [10.216.50.155] (10.80.80.8) by nasanex01c.na.qualcomm.com
 (10.45.79.139) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36; Tue, 14 Feb
 2023 05:44:09 -0800
Message-ID: <89cff864-2103-1dc1-b8c2-ad1ef1fbdf1e@quicinc.com>
Date:   Tue, 14 Feb 2023 19:14:05 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH v5 2/2] pstore/ram: Rework logic for detecting ramoops
Content-Language: en-US
To:     <linux-hardening@vger.kernel.org>, <linux-doc@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>
CC:     <keescook@chromium.org>, <tony.luck@intel.com>,
        <gpiccoli@igalia.com>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <corbet@lwn.net>
References: <1675330081-15029-1-git-send-email-quic_mojha@quicinc.com>
 <1675330081-15029-2-git-send-email-quic_mojha@quicinc.com>
From:   Mukesh Ojha <quic_mojha@quicinc.com>
In-Reply-To: <1675330081-15029-2-git-send-email-quic_mojha@quicinc.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01c.na.qualcomm.com (10.45.79.139)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: MBUL8prDP-pLNpOt_30UC69_FAQYiHuf
X-Proofpoint-ORIG-GUID: MBUL8prDP-pLNpOt_30UC69_FAQYiHuf
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.170.22
 definitions=2023-02-14_07,2023-02-14_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0
 priorityscore=1501 malwarescore=0 mlxlogscore=999 phishscore=0
 lowpriorityscore=0 bulkscore=0 mlxscore=0 adultscore=0 impostorscore=0
 suspectscore=0 clxscore=1015 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2212070000 definitions=main-2302140118
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Kees/Rob,

Since, we are not agreeing to put dynamics ramoops region support in 
device tree.

In Qualcomm SoC, during reset the pstore static region did not get 
preserved across boots and we have our own mechanism to collect regions
if physical address and size is somehow passed to boot-firmware by 
writing to some shared memory. So, we wanted to reuse the region
supported by pstore(dmesg/console/ etc.) for that we wanted to this
flexibility to put this region dynamically anywhere in the ram.

This patch will help achieve the same . Can you suggest if this gets
allowed.

-Mukesh

On 2/2/2023 2:58 PM, Mukesh Ojha wrote:
> The reserved memory region for ramoops is assumed to be at a fixed
> and known location when read from the devicetree. This is not desirable
> in an environment where it is preferred the region to be dynamically
> allocated at runtime, as opposed to being fixed at compile time.
> 
> Also, some of the platforms might be still expecting dedicated
> memory region for ramoops node where the region is known beforehand
> and platform_get_resource() is used in that case.
> 
> So, add logic to detect the start and size of the ramoops memory
> region by looking up reserved memory region with of_reserved_mem_lookup()
> api when platform_get_resource() fails also update the ramoops
> documentation.
> 
> Signed-off-by: Mukesh Ojha <quic_mojha@quicinc.com> > ---
> Changes in v5:
>   - Removed the CC list from the commit text.
> 
> Changes in v4:
>   - Updated the minor change in documentation.
> 
> Changes in v3:
>   - Merged 2/3 and 3/3 into one.
>     https://lore.kernel.org/lkml/1673611126-13803-2-git-send-email-quic_mojha@quicinc.com/
>     https://lore.kernel.org/lkml/1673611126-13803-3-git-send-email-quic_mojha@quicinc.com/
> 
> Changes in v2:
>   - Addressed the comments made by kees and Guilherme in v1.
> 
> 
>   Documentation/admin-guide/ramoops.rst | 25 ++++++++++++++++++++++---
>   fs/pstore/ram.c                       | 18 +++++++++++++-----
>   2 files changed, 35 insertions(+), 8 deletions(-)
> 
> diff --git a/Documentation/admin-guide/ramoops.rst b/Documentation/admin-guide/ramoops.rst
> index e9f8514..3586d15 100644
> --- a/Documentation/admin-guide/ramoops.rst
> +++ b/Documentation/admin-guide/ramoops.rst
> @@ -16,8 +16,9 @@ survive after a restart.
>   Ramoops concepts
>   ----------------
>   
> -Ramoops uses a predefined memory area to store the dump. The start and size
> -and type of the memory area are set using three variables:
> +Ramoops uses both predefined and dynamically memory area to store the dump.
> +The start and size and type of the memory area are set using three
> +variables:
>   
>     * ``mem_address`` for the start
>     * ``mem_size`` for the size. The memory size will be rounded down to a
> @@ -70,7 +71,8 @@ Setting the ramoops parameters can be done in several different manners:
>   
>    B. Use Device Tree bindings, as described in
>    ``Documentation/devicetree/bindings/reserved-memory/ramoops.yaml``.
> - For example::
> +
> + Example of statically reserved ramoops region::
>   
>   	reserved-memory {
>   		#address-cells = <2>;
> @@ -85,6 +87,23 @@ Setting the ramoops parameters can be done in several different manners:
>   		};
>   	};
>   
> + Example of dynamically reserved ramoops region::
> +
> +	reserved-memory {
> +		#address-cells = <1>;
> +		#size-cells = <1>;
> +		ranges;
> +
> +		ramoops_region: ramoops {
> +			compatible = "ramoops";
> +			alloc-ranges = <0x00000000 0xffffffff>;
> +			size = <0 0x100000>;
> +			record-size = <0x4000>;
> +			console-size = <0x4000>;
> +		};
> +	};
> +
> +
>    C. Use a platform device and set the platform data. The parameters can then
>    be set through that platform data. An example of doing that is:
>   
> diff --git a/fs/pstore/ram.c b/fs/pstore/ram.c
> index ade66db..17c9f46 100644
> --- a/fs/pstore/ram.c
> +++ b/fs/pstore/ram.c
> @@ -20,6 +20,7 @@
>   #include <linux/compiler.h>
>   #include <linux/of.h>
>   #include <linux/of_address.h>
> +#include <linux/of_reserved_mem.h>
>   
>   #include "internal.h"
>   #include "ram_internal.h"
> @@ -643,6 +644,7 @@ static int ramoops_parse_dt(struct platform_device *pdev,
>   {
>   	struct device_node *of_node = pdev->dev.of_node;
>   	struct device_node *parent_node;
> +	struct reserved_mem *rmem;
>   	struct resource *res;
>   	u32 value;
>   	int ret;
> @@ -651,13 +653,19 @@ static int ramoops_parse_dt(struct platform_device *pdev,
>   
>   	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
>   	if (!res) {
> -		dev_err(&pdev->dev,
> -			"failed to locate DT /reserved-memory resource\n");
> -		return -EINVAL;
> +		rmem = of_reserved_mem_lookup(of_node);
> +		if (!rmem) {
> +			dev_err(&pdev->dev,
> +				"failed to locate DT /reserved-memory resource\n");
> +			return -EINVAL;
> +		}
> +		pdata->mem_size = rmem->size;
> +		pdata->mem_address = rmem->base;
> +	} else {
> +		pdata->mem_size = resource_size(res);
> +		pdata->mem_address = res->start;
>   	}
>   
> -	pdata->mem_size = resource_size(res);
> -	pdata->mem_address = res->start;
>   	/*
>   	 * Setting "unbuffered" is deprecated and will be ignored if
>   	 * "mem_type" is also specified.
