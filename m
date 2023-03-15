Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 432546BA9B7
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Mar 2023 08:47:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231831AbjCOHrr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Mar 2023 03:47:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231538AbjCOHrm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Mar 2023 03:47:42 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1AC56BC37;
        Wed, 15 Mar 2023 00:47:14 -0700 (PDT)
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 32F729lI026428;
        Wed, 15 Mar 2023 07:46:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=NUmR7v0pz0d9wUwJDKMjwipQfwzJ0GkJCL7TCpiNoqY=;
 b=UfKnlvm4LJfUZ1yUYtO+HLlEzk2vjaI9kmisM3MmEJvi12QkavoaeHUOVFqKmvUXum84
 T/P8bfRz6idMHEJIQN5zHyl223szayFkzhK6U2FXJjAWvtuQOGAgaF0xjKPmGYT4cBIe
 Cv/DpgM4BA+8ZLra7KHJfubcpMWQhCc6NzlCCsAZ5JFLANtPs/kGUNcFjblhbqgKGdSQ
 oJ0KxIeFTYXOkH3IGOLkg3KutA+JxusZYZ0gj3UxKx4E/ddTLdRQSNd0HS7ImI2zpoqC
 j44tImT3HKA7D4cp86wvkmSq6yIVPcX4keMOuhI7/KkmLCLTf58YVhyREoJp1hPXKRnE dQ== 
Received: from nasanppmta04.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3pb2csgvjf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 15 Mar 2023 07:46:10 +0000
Received: from nasanex01a.na.qualcomm.com ([10.52.223.231])
        by NASANPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 32F7k98O026212
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 15 Mar 2023 07:46:09 GMT
Received: from [192.168.143.77] (10.80.80.8) by nasanex01a.na.qualcomm.com
 (10.52.223.231) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Wed, 15 Mar
 2023 00:46:09 -0700
Message-ID: <08a21d08-9067-caa5-94f9-3264efabea37@quicinc.com>
Date:   Wed, 15 Mar 2023 00:46:08 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [RFC PATCH v2 3/3] ufs: mcq: Added ufshcd_mcq_abort()
Content-Language: en-US
To:     hoyoung seo <hy50.seo@samsung.com>
CC:     <Arthur.Simchaev@wdc.com>, <adrian.hunter@intel.com>,
        <alim.akhtar@samsung.com>, <avri.altman@wdc.com>,
        <beanhuo@micron.com>, <bvanassche@acm.org>, <jejb@linux.ibm.com>,
        <linux-kernel@vger.kernel.org>, <linux-scsi@vger.kernel.org>,
        <mani@kernel.org>, <martin.petersen@oracle.com>,
        <quic_asutoshd@quicinc.com>, <quic_cang@quicinc.com>
References: <CGME20230315014541epcas2p3fdbf4ea817fbc87f9ba230e389914286@epcas2p3.samsung.com>
 <036101d956df$d9afe7a0$8d0fb6e0$@samsung.com>
From:   "Bao D. Nguyen" <quic_nguyenb@quicinc.com>
In-Reply-To: <036101d956df$d9afe7a0$8d0fb6e0$@samsung.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01a.na.qualcomm.com (10.52.223.231)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: H1UD0iAwasP5DeEyFYl2aTxaK23se2qH
X-Proofpoint-ORIG-GUID: H1UD0iAwasP5DeEyFYl2aTxaK23se2qH
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-15_03,2023-03-14_02,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 mlxlogscore=999
 impostorscore=0 suspectscore=0 mlxscore=0 spamscore=0 malwarescore=0
 priorityscore=1501 adultscore=0 bulkscore=0 lowpriorityscore=0
 clxscore=1011 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2302240000 definitions=main-2303150063
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS,T_PDS_OTHER_BAD_TLD,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/14/2023 6:45 PM, hoyoung seo wrote:
> diff --git a/drivers/ufs/core/ufs-mcq.c b/drivers/ufs/core/ufs-mcq.c index 4c33c1a..8d0019e 100644
> --- a/drivers/ufs/core/ufs-mcq.c
> +++ b/drivers/ufs/core/ufs-mcq.c
> @@ -610,3 +610,65 @@ static bool ufshcd_mcq_sqe_search(struct ufs_hba *hba,
>   	spin_unlock(&hwq->sq_lock);
>   	return ret;
>   }
> +
> +/**
> + * ufshcd_mcq_abort - Abort the command in MCQ.
> + * @cmd - The command to be aborted.
> + *
> + * Returns SUCCESS or FAILED error codes  */ int
> +ufshcd_mcq_abort(struct scsi_cmnd *cmd) {
> +	struct Scsi_Host *host = cmd->device->host;
> +	struct ufs_hba *hba = shost_priv(host);
> +	int tag = scsi_cmd_to_rq(cmd)->tag;
> +	struct ufshcd_lrb *lrbp = &hba->lrb[tag];
> +	struct ufs_hw_queue *hwq;
> +	int err = FAILED;
> +
> +	if (!lrbp->cmd) {
> +		dev_err(hba->dev,
> +			"%s: skip abort. cmd at tag %d already completed.\n",
> +			__func__, tag);
> +		goto out;
> +	}
> +
> +	/* Skip task abort in case previous aborts failed and report failure */
> +	if (lrbp->req_abort_skip) {
> +		dev_err(hba->dev, "%s: skip abort. tag %d failed earlier\n",
> +			__func__, tag);
> +		goto out;
> +	}
> +
> +	hwq = ufshcd_mcq_req_to_hwq(hba, scsi_cmd_to_rq(cmd));
> +
> +	if (ufshcd_mcq_sqe_search(hba, hwq, tag)) {
> +		/*
> +		 * Failure. The command should not be "stuck" in SQ for
> +		 * a long time which resulted in command being aborted.
> +		 */
> +		dev_err(hba->dev, "%s: cmd found in sq. hwq=%d, tag=%d\n",
> +				__func__, hwq->id, tag);
> +		/* Set the Command Type to 0xF per the spec */
> +		ufshcd_mcq_nullify_cmd(hba, hwq);
> +		goto out;
> +	}
> +
> +	/*
> +	 * The command is not in the Submission Queue, and it is not
> +	 * in the Completion Queue either. Query the device to see if
> +	 * the command is being processed in the device.
> +	 */
> +	if (ufshcd_try_to_abort_task(hba, tag)) {
> +		dev_err(hba->dev, "%s: device abort failed %d\n", __func__, err);
> +		lrbp->req_abort_skip = true;
> +		goto out;
> +	}
> +
> +	err = SUCCESS;
> +	if (lrbp->cmd)
> +		ufshcd_release_scsi_cmd(hba, lrbp);
> +
> +out:
> +	return err;
> +}
>
> Hi, Bao.
>
> Looking at the 4.0spec, it stops SQ before abort processing and checks whether SQRTSy.STS is 1. Shouldn't this be added?
> And need to check SQRTSy.STS bit as '0' after re-start SQ
Hi Seo, we do ufshcd_mcq_sq_stop() to stop the SQ before the clean up 
operation and restart the SQ with ufshcd_mcq_sq_start() after the clean 
up is done.

We should also stop the SQ before the ufshcd_mcq_sqe_search() and 
restart the SQ after the search is done. I will add that logic.

Thanks!

>
> Below is the original text of the UFS 4.0 spec
>
> 1. The device driver set SQRTCy.STOP as ‘1’. The host controller will stop the fetching command from the Submission Queue, and set the SQRTS.STS bit as ‘1’ to indicate that SQ is stopped
>
> 2. Depending on the status of command which is requested to be aborted, A. If the command is already completed, then go to step 3.
> B. If the command is in the Submission Queue and not issued to the device yet, the host controller will mark the command to be skipped in the Submission Queue. The host controller will post to the Completion Queue to update the OCS field with ‘ABORTED’.
> C. If the command is issued to the device already but there is no response yet from the device, the host software driver issue the Abort task management function to the device for that command. Then the host driver set SQRTCy.ICU as ‘1’ to initiate the clean up the hardware resources. The host controller will post to the Completion Queue to update the OCS field with ‘ABORTED’. If host software driver receive the ‘task not found’ as the response of the associated task management function, then go to 3.
>
> 3. SW set SQRTCy. STOP as ‘0’, host controller set the SQRTSy.STS bit as ‘0’, then resume fetching the command from Submission Queue.
>
> Thanks.
> BRS SEO.
>
>

