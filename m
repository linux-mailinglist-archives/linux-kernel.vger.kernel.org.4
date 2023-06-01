Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2908E719B09
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Jun 2023 13:37:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232966AbjFALhZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Jun 2023 07:37:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229514AbjFALhX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Jun 2023 07:37:23 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED37E129;
        Thu,  1 Jun 2023 04:37:22 -0700 (PDT)
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3518aJ20016784;
        Thu, 1 Jun 2023 11:32:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=3UBiAuW2p6np2qDHCwZSiasHNtb2TxsYcIbvRRtCpM0=;
 b=RxQtsITCPv/GQmCaUurfLI1UXJa/GZRRtVERO1RtIw//MRj/+zibcQAVVbhQ2vNGmGsJ
 pIMaMgj4BGeoyl6kPDLfEPVZSJPc6cUkNlW1z9tLPfuJ+xsUdCmYkYg/Sd1OSDuYKMdn
 NSu9tlsL4hw7NaeTZIqvhtdmYbFRdhk8kK7ROSO+cvJz8F7G3RhjlF+lQxUOm33v3tJb
 bU9l/6qdlt6APOPeHjECdFQgt1jWtExRya8EaTkxWmOGE9bflMG+yVr3lzWoyEVhi/9y
 O1tNXwgV3WCzebqNd5UFNQDkxuVpl3UsoViM/B1tu3iHwspLrFxyNvzVhRnh+7E6JsM0 xg== 
Received: from nasanppmta04.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3qxqyd8cx8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 01 Jun 2023 11:32:07 +0000
Received: from nasanex01a.na.qualcomm.com (nasanex01a.na.qualcomm.com [10.52.223.231])
        by NASANPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 351BW7gD024612
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 1 Jun 2023 11:32:07 GMT
Received: from [192.168.143.77] (10.80.80.8) by nasanex01a.na.qualcomm.com
 (10.52.223.231) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.42; Thu, 1 Jun 2023
 04:32:06 -0700
Message-ID: <6890bec9-df97-fe42-a2b4-0b8ce1701464@quicinc.com>
Date:   Thu, 1 Jun 2023 04:32:06 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH v1 1/1] ufs: mcq: Fix the variable wraparound logic
Content-Language: en-US
To:     <quic_asutoshd@quicinc.com>, <quic_cang@quicinc.com>,
        <bvanassche@acm.org>, <mani@kernel.org>,
        <stanley.chu@mediatek.com>, <adrian.hunter@intel.com>,
        <beanhuo@micron.com>, <avri.altman@wdc.com>,
        <martin.petersen@oracle.com>
CC:     <linux-scsi@vger.kernel.org>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        Alice Chao <alice.chao@mediatek.com>,
        open list <linux-kernel@vger.kernel.org>
References: <f711489c6b95ec410e500543fd24ca9fc0f462cd.1685618737.git.quic_nguyenb@quicinc.com>
 <e6e8559eee9626afa38f88e18080398e7296e1bb.1685617541.git.quic_nguyenb@quicinc.com>
From:   "Bao D. Nguyen" <quic_nguyenb@quicinc.com>
In-Reply-To: <e6e8559eee9626afa38f88e18080398e7296e1bb.1685617541.git.quic_nguyenb@quicinc.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01a.na.qualcomm.com (10.52.223.231)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: VJJSTrWvtvm_vquxPG2ZOmRJh7MvFdlg
X-Proofpoint-GUID: VJJSTrWvtvm_vquxPG2ZOmRJh7MvFdlg
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-06-01_08,2023-05-31_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0
 mlxlogscore=999 phishscore=0 mlxscore=0 bulkscore=0 spamscore=0
 adultscore=0 impostorscore=0 priorityscore=1501 lowpriorityscore=0
 suspectscore=0 clxscore=1015 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2304280000 definitions=main-2306010102
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Please ignore this duplicate patch. My apologies.

Thanks,
Bao

On 6/1/2023 4:27 AM, Bao D. Nguyen wrote:
> If the hwq's queue depth is not a multiple of 4s, the
> logic used for wrapping around the increase-by-1 sq_head_slot
> variable in ufshcd_mcq_sqe_search() will give an incorrect
> result because the binary expression of the mask is not
> a uniform of all 1s.
> 
> Signed-off-by: Bao D. Nguyen <quic_nguyenb@quicinc.com>
> ---
>   drivers/ufs/core/ufs-mcq.c | 6 ++++--
>   1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/ufs/core/ufs-mcq.c b/drivers/ufs/core/ufs-mcq.c
> index 66ac02e..8e5bc88 100644
> --- a/drivers/ufs/core/ufs-mcq.c
> +++ b/drivers/ufs/core/ufs-mcq.c
> @@ -585,7 +585,6 @@ static bool ufshcd_mcq_sqe_search(struct ufs_hba *hba,
>   {
>   	struct ufshcd_lrb *lrbp = &hba->lrb[task_tag];
>   	struct utp_transfer_req_desc *utrd;
> -	u32 mask = hwq->max_entries - 1;
>   	__le64  cmd_desc_base_addr;
>   	bool ret = false;
>   	u64 addr, match;
> @@ -610,7 +609,10 @@ static bool ufshcd_mcq_sqe_search(struct ufs_hba *hba,
>   			ret = true;
>   			goto out;
>   		}
> -		sq_head_slot = (sq_head_slot + 1) & mask;
> +
> +		sq_head_slot++;
> +		if (sq_head_slot == hwq->max_entries)
> +			sq_head_slot = 0;
>   	}
>   
>   out:

