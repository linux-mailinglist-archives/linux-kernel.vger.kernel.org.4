Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B45671F16F
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Jun 2023 20:13:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231702AbjFASNM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Jun 2023 14:13:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229524AbjFASNK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Jun 2023 14:13:10 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CCB3B123;
        Thu,  1 Jun 2023 11:13:09 -0700 (PDT)
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 351A6QH6009107;
        Thu, 1 Jun 2023 18:12:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=jTGP7Vsgjxm812AUKY1rMnWy3VKrpwWdhTSG3NhCRo0=;
 b=WII1+L0rmbqBCh1e/z8d0oQHKwX4cA4lTH+30kJdQJsJqNGK/+gRI9V+CaOLkp6pI8vc
 akeuB6T9P3ccBnbCqflAM60sioEzqtq0gA0kMuwadqgXpz3dDD6w849x6MfCrHzF5fM4
 MBj+SzXfLmn9Fda+00hMctuUlQrGIl8514fG4BrVpnNOP7kDBTBBJsFsz6W/7FWVhfw7
 9HE+aQOXav9r8C5JbWdyvF5wRwWw5zcI7/OY/SK+L6VW9lHIUkGNKbTlySvzgkonO45l
 TDi1LekVlvwONVJJ4SdASgbvjVaIhx3Xp4EnSqzf5qH7SXmOtZ0RloTFZUk13pwjV5KV Rw== 
Received: from nasanppmta05.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3qxs9gs9e8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 01 Jun 2023 18:12:59 +0000
Received: from nasanex01a.na.qualcomm.com (nasanex01a.na.qualcomm.com [10.52.223.231])
        by NASANPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 351ICwgH001124
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 1 Jun 2023 18:12:58 GMT
Received: from [192.168.143.77] (10.80.80.8) by nasanex01a.na.qualcomm.com
 (10.52.223.231) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.42; Thu, 1 Jun 2023
 11:12:57 -0700
Message-ID: <aef25380-790e-6776-aaf2-6a74971054e4@quicinc.com>
Date:   Thu, 1 Jun 2023 11:12:57 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH v1] ufs: core: Remove the nolock version of
 ufshcd_mcq_poll_cqe()
Content-Language: en-US
To:     Stanley Chu <stanley.chu@mediatek.com>,
        <linux-scsi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <martin.petersen@oracle.com>, <avri.altman@wdc.com>,
        <alim.akhtar@samsung.com>, <jejb@linux.ibm.com>,
        <bvanassche@acm.org>
References: <20230601090202.27035-1-stanley.chu@mediatek.com>
From:   "Bao D. Nguyen" <quic_nguyenb@quicinc.com>
In-Reply-To: <20230601090202.27035-1-stanley.chu@mediatek.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01a.na.qualcomm.com (10.52.223.231)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: 6jBla3t2X-I2NVpN2T5O7i2jh1BsVb7J
X-Proofpoint-GUID: 6jBla3t2X-I2NVpN2T5O7i2jh1BsVb7J
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-06-01_08,2023-05-31_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 mlxscore=0
 spamscore=0 priorityscore=1501 malwarescore=0 bulkscore=0 adultscore=0
 phishscore=0 lowpriorityscore=0 mlxlogscore=999 suspectscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2304280000 definitions=main-2306010157
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/1/2023 2:02 AM, Stanley Chu wrote:
> Since ufshcd_mcq_poll_cqe_nolock() is no longer used by any users,
> it should be removed.
> 
> Signed-off-by: Stanley Chu <stanley.chu@mediatek.com>
> ---
>   drivers/ufs/core/ufs-mcq.c | 17 ++++-------------
>   1 file changed, 4 insertions(+), 13 deletions(-)
> 
> diff --git a/drivers/ufs/core/ufs-mcq.c b/drivers/ufs/core/ufs-mcq.c
> index 920eb954f594..785fc9762cad 100644
> --- a/drivers/ufs/core/ufs-mcq.c
> +++ b/drivers/ufs/core/ufs-mcq.c
> @@ -307,11 +307,13 @@ void ufshcd_mcq_compl_all_cqes_lock(struct ufs_hba *hba,
>   	spin_unlock_irqrestore(&hwq->cq_lock, flags);
>   }
>   
> -static unsigned long ufshcd_mcq_poll_cqe_nolock(struct ufs_hba *hba,
> -						struct ufs_hw_queue *hwq)
> +unsigned long ufshcd_mcq_poll_cqe_lock(struct ufs_hba *hba,
> +				       struct ufs_hw_queue *hwq)
>   {
>   	unsigned long completed_reqs = 0;
> +	unsigned long flags;
>   
> +	spin_lock_irqsave(&hwq->cq_lock, flags);
>   	ufshcd_mcq_update_cq_tail_slot(hwq);
>   	while (!ufshcd_mcq_is_cq_empty(hwq)) {
>   		ufshcd_mcq_process_cqe(hba, hwq);
> @@ -321,17 +323,6 @@ static unsigned long ufshcd_mcq_poll_cqe_nolock(struct ufs_hba *hba,
>   
>   	if (completed_reqs)
>   		ufshcd_mcq_update_cq_head(hwq);
> -
> -	return completed_reqs;
> -}
> -
> -unsigned long ufshcd_mcq_poll_cqe_lock(struct ufs_hba *hba,
> -				       struct ufs_hw_queue *hwq)
> -{
> -	unsigned long completed_reqs, flags;
> -
> -	spin_lock_irqsave(&hwq->cq_lock, flags);
> -	completed_reqs = ufshcd_mcq_poll_cqe_nolock(hba, hwq);
>   	spin_unlock_irqrestore(&hwq->cq_lock, flags);
>   
>   	return completed_reqs;
Hi Stanley,

Other than the commit message that Bart mentioned, this patch looks good.

Reviewed-by: Bao D. Nguyen <quic_nguyenb@quicinc.com>
