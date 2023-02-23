Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7FFCF6A0607
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Feb 2023 11:23:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233783AbjBWKXL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Feb 2023 05:23:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233910AbjBWKWg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Feb 2023 05:22:36 -0500
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F7CB4FC84;
        Thu, 23 Feb 2023 02:22:31 -0800 (PST)
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 31N2R16e005929;
        Thu, 23 Feb 2023 10:22:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=sSP+qmgsxXr2sGqfpiPkDCc3EDwwHf/hj8AkhCmtSKQ=;
 b=SFWSOibVLV6wWLUIJ6TG1mVDDj5kvMz1HfG/qGPTOA3m+Mu44s4nwAU3Sr9uVvD2akQn
 QyU0ulfkfLkd+Br9IzQddZPWoDzMZfYUur1Sq0LRHzdoA+e4LZ/dm/Bxb5DldZLXKFyo
 fhZfUh9IYIMtWkM79C1OUYZyBpszQgcVpr3ugx3VAvRunBu2vTtgSu2gVKNo6F/AyYJu
 1Mzf5BjTYRZxBVc27FN//4uKHyZmCyIOW/PA9dvwkxutz45VB3+NFaF0bcrekORYFHFy
 VBke489vJNG6iJaS2xfWOtk1fJ0+5rtz718hSO0kDyS0ud6AYMZ8WjH3rTvq5O50th75 BA== 
Received: from nasanppmta04.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3nwybm0yud-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 23 Feb 2023 10:22:16 +0000
Received: from nasanex01a.na.qualcomm.com ([10.52.223.231])
        by NASANPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 31NAMFlL008110
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 23 Feb 2023 10:22:15 GMT
Received: from [10.239.155.136] (10.80.80.8) by nasanex01a.na.qualcomm.com
 (10.52.223.231) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Thu, 23 Feb
 2023 02:22:10 -0800
Message-ID: <bb96b0c4-d1ef-c198-3e07-d83621010a7e@quicinc.com>
Date:   Thu, 23 Feb 2023 18:22:08 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [PATCH v2 1/7] scsi: ufs: core: Fix mcq tag calcualtion
Content-Language: en-US
To:     Po-Wen Kao <powen.kao@mediatek.com>, <linux-scsi@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Avri Altman <avri.altman@wdc.com>,
        Bart Van Assche <bvanassche@acm.org>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        <quic_cang@quicinc.com>, <quic_asutoshd@quicinc.com>
CC:     <wsd_upstream@mediatek.com>, <peter.wang@mediatek.com>,
        <stanley.chu@mediatek.com>, <alice.chao@mediatek.com>,
        <naomi.chu@mediatek.com>, <chun-hung.wu@mediatek.com>,
        <cc.chou@mediatek.com>, <eddie.huang@mediatek.com>,
        <mason.zhang@mediatek.com>, <chaotian.jing@mediatek.com>,
        <jiajie.hao@mediatek.com>
References: <20230222030427.957-1-powen.kao@mediatek.com>
 <20230222030427.957-2-powen.kao@mediatek.com>
From:   Ziqi Chen <quic_ziqichen@quicinc.com>
In-Reply-To: <20230222030427.957-2-powen.kao@mediatek.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01a.na.qualcomm.com (10.52.223.231)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: 4gYogiX9VRbIXWwhX1NoQAqpeTHa_-uI
X-Proofpoint-GUID: 4gYogiX9VRbIXWwhX1NoQAqpeTHa_-uI
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.170.22
 definitions=2023-02-23_06,2023-02-23_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999
 suspectscore=0 phishscore=0 spamscore=0 priorityscore=1501 adultscore=0
 impostorscore=0 bulkscore=0 lowpriorityscore=0 malwarescore=0 mlxscore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2302230088
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 2/22/2023 11:04 AM, Po-Wen Kao wrote:
> Transfer command descriptor is allocated in ufshcd_memory_alloc()
> and referenced by transfer request descriptor with stride size
> sizeof_utp_transfer_cmd_desc()
> instead of
> sizeof(struct utp_transfer_cmd_desc).
>
> Consequently, computing tag by address offset should also refer to the
> same stride.
>
> Signed-off-by: Po-Wen Kao <powen.kao@mediatek.com>
> Reviewed-by: Bart Van Assche <bvanassche@acm.org>
> Reviewed-by: Manivannan Sadhasivam <mani@kernel.org>
> Reviewed-by: Stanley Chu <stanley.chu@mediatek.com>
reviewed-by:  Ziqi Chen <quic_ziqichen@quicinc.com>
> ---
>   drivers/ufs/core/ufs-mcq.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/ufs/core/ufs-mcq.c b/drivers/ufs/core/ufs-mcq.c
> index 31df052fbc41..3a27fa4b0024 100644
> --- a/drivers/ufs/core/ufs-mcq.c
> +++ b/drivers/ufs/core/ufs-mcq.c
> @@ -265,7 +265,7 @@ static int ufshcd_mcq_get_tag(struct ufs_hba *hba,
>   	addr = (le64_to_cpu(cqe->command_desc_base_addr) & CQE_UCD_BA) -
>   		hba->ucdl_dma_addr;
>   
> -	return div_u64(addr, sizeof(struct utp_transfer_cmd_desc));
> +	return div_u64(addr, sizeof_utp_transfer_cmd_desc(hba));
>   }
>   
>   static void ufshcd_mcq_process_cqe(struct ufs_hba *hba,
