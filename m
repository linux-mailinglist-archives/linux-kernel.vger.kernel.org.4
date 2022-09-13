Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 840785B7A41
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Sep 2022 20:56:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232030AbiIMS4F (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Sep 2022 14:56:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233019AbiIMSzb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Sep 2022 14:55:31 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EBF70CFA;
        Tue, 13 Sep 2022 11:43:24 -0700 (PDT)
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 28DIFLWZ027735;
        Tue, 13 Sep 2022 18:41:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=vQhLlxqmzjKr9NsrPdkmOXYQsiz9/Tdn5+aZavAWXnA=;
 b=Jgp305mzyzJvJ0BeuKTDDJ3sWYkNQUc+IG5+Qbm0Lhn+VfREvy71ozQjAbCCISf5WYX3
 Jdjm2v29zaW1i+q/ml2mJd17Topem7OTL3cavf5oo7I85t8nN0G01JXd2m9K0tKvvuge
 Yg6LSLE2nr6lZJuWqgE5ccqRdcrfchGMOEQOeuLmDXhNiQnFYXpLWz99DrewgFdUFGCl
 jUxSbTJIcpjs+7tl8DlnHec8pVa9lbB6bsPoJE6vuV5TnZjFXE90nmfScNdXClz8RlT1
 zdyxh9IIR6kAJQ4fDtoeS9tNnVC/tfCLlwNognt9UacUg3JY3POyqWsO8hIes+Fx4yCk nA== 
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3jjxyvg26b-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 13 Sep 2022 18:41:55 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 28DIfen3023964
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 13 Sep 2022 18:41:40 GMT
Received: from [10.110.52.115] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.29; Tue, 13 Sep
 2022 11:41:37 -0700
Message-ID: <cd92cfec-0a68-a42d-1fa4-a16e37e59d53@quicinc.com>
Date:   Tue, 13 Sep 2022 11:41:35 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [PATCH 3/5] iommu: Add return errno rules to ->attach_dev ops
Content-Language: en-US
To:     Nicolin Chen <nicolinc@nvidia.com>, <joro@8bytes.org>,
        <suravee.suthikulpanit@amd.com>, <will@kernel.org>,
        <robin.murphy@arm.com>, <robdclark@gmail.com>,
        <dwmw2@infradead.org>, <baolu.lu@linux.intel.com>,
        <agross@kernel.org>, <bjorn.andersson@linaro.org>,
        <konrad.dybcio@somainline.org>, <matthias.bgg@gmail.com>,
        <heiko@sntech.de>, <orsonzhai@gmail.com>,
        <baolin.wang@linux.alibaba.com>, <zhang.lyra@gmail.com>,
        <thierry.reding@gmail.com>, <jean-philippe@linaro.org>,
        <jgg@nvidia.com>, <sricharan@codeaurora.org>
CC:     <yong.wu@mediatek.com>, <vdumpa@nvidia.com>,
        <jonathanh@nvidia.com>, <tglx@linutronix.de>,
        <shameerali.kolothum.thodi@huawei.com>,
        <thunder.leizhen@huawei.com>, <christophe.jaillet@wanadoo.fr>,
        <yangyingliang@huawei.com>, <jon@solid-run.com>,
        <iommu@lists.linux.dev>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-arm-msm@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-rockchip@lists.infradead.org>,
        <linux-tegra@vger.kernel.org>,
        <virtualization@lists.linux-foundation.org>
References: <20220913082448.31120-1-nicolinc@nvidia.com>
 <20220913082448.31120-4-nicolinc@nvidia.com>
From:   Jeff Johnson <quic_jjohnson@quicinc.com>
In-Reply-To: <20220913082448.31120-4-nicolinc@nvidia.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: etmjmEmkeGNTWFk3eX68NHU9O18Ysroz
X-Proofpoint-ORIG-GUID: etmjmEmkeGNTWFk3eX68NHU9O18Ysroz
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-09-13_09,2022-09-13_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 adultscore=0
 lowpriorityscore=0 spamscore=0 phishscore=0 priorityscore=1501
 suspectscore=0 mlxlogscore=999 clxscore=1011 bulkscore=0 impostorscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2208220000 definitions=main-2209130086
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/13/2022 1:24 AM, Nicolin Chen wrote:
> Cases like VFIO wish to attach a device to an existing domain that was
> not allocated specifically from the device. This raises a condition
> where the IOMMU driver can fail the domain attach because the domain and
> device are incompatible with each other.
> 
> This is a soft failure that can be resolved by using a different domain.
> 
> Provide a dedicated errno EINVAL from the IOMMU driver during attach that
> the reason attached failed is because of domain incompatability.
> 
> VFIO can use this to know attach is a soft failure and it should continue
> searching. Otherwise the attach will be a hard failure and VFIO will
> return the code to userspace.
> 
> Update kdocs first to add rules of return errno to ->attach_dev ops.
> 
> Suggested-by: Jason Gunthorpe <jgg@nvidia.com>
> Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
> ---
>   include/linux/iommu.h | 11 +++++++++++
>   1 file changed, 11 insertions(+)
> 
> diff --git a/include/linux/iommu.h b/include/linux/iommu.h
> index ea30f00dc145..c5d7ec0187c7 100644
> --- a/include/linux/iommu.h
> +++ b/include/linux/iommu.h
> @@ -266,6 +266,17 @@ struct iommu_ops {
>   /**
>    * struct iommu_domain_ops - domain specific operations
>    * @attach_dev: attach an iommu domain to a device
> + *              Rules of its return errno:
> + *               EINVAL  - Exclusively, device and domain are incompatible. Must
> + *                         avoid kernel prints along with this errno. Any EINVAL
> + *                         returned from kAPIs must be converted to ENODEV if it
> + *                         is device-specific, or to some other reasonable errno
> + *                         being listed below
> + *               ENOMEM  - Out of memory
> + *               ENOSPC  - No space left on device
> + *               EBUSY   - Device is attached to a domain and cannot be changed
> + *               ENODEV  - Device specific errors, not able to be attached
> + *              <others> - Treated as ENODEV by the caller. Use is discouraged

It is my understanding that kernel-doc won't preserve your formatting 
without extra directives. See the "Note" after 
<https://www.kernel.org/doc/html/latest/doc-guide/kernel-doc.html#return-values>


>    * @detach_dev: detach an iommu domain from a device
>    * @map: map a physically contiguous memory region to an iommu domain
>    * @map_pages: map a physically contiguous set of pages of the same size to

