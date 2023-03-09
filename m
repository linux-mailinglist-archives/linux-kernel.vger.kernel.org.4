Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 03E936B1BE5
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Mar 2023 08:00:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229742AbjCIHAx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Mar 2023 02:00:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229549AbjCIHAt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Mar 2023 02:00:49 -0500
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8EEA992F01;
        Wed,  8 Mar 2023 23:00:47 -0800 (PST)
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3294gg9F029867;
        Thu, 9 Mar 2023 06:59:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=Js+sNrI/dGc2GrY+Ad4NiKF8uH8gqtN5WqhfBR4LbiE=;
 b=kvVMmcGO9Efr+VIiinMqLV1s6kyAwMf9iP4v8xZy8EvjSTeKVa7O2NI0Wxwu9p4fSsD6
 Rhs3C+2QKH1g0s7HdLc+nFrikNb3h2CwxDReDA97LLlexres0sylqWUL5s6Hr5OHylvh
 AMaFEhM3YZ81j3xtZWJGPzE8z4IEt9/yZxRMVxy5S966dWvnk51IyxBa4KDv0rFe2PWQ
 p7EeaX/NINOTnMw99T02MlX/xRrw5bEg/6uSVmAP/yby/6oPZ5CabE/jqeWuGAO8/Lcq
 qbLSY/a6HcUyw/PXTarrKgbP+0LAxgSL5mCPOkE9pqw3WjeGws/0kgB7n8fDWFUCXdbn Xg== 
Received: from nasanppmta04.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3p6fej40cu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 09 Mar 2023 06:59:34 +0000
Received: from nasanex01a.na.qualcomm.com ([10.52.223.231])
        by NASANPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3296xXlX001776
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 9 Mar 2023 06:59:33 GMT
Received: from [192.168.143.77] (10.80.80.8) by nasanex01a.na.qualcomm.com
 (10.52.223.231) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Wed, 8 Mar 2023
 22:59:33 -0800
Message-ID: <947d852c-7b43-e8f7-6f28-23f138bfae79@quicinc.com>
Date:   Wed, 8 Mar 2023 22:59:33 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [RFC PATCH v1 4/4] ufs: mcq: Added ufshcd_mcq_abort()
Content-Language: en-US
To:     Stanley Chu <chu.stanley@gmail.com>
CC:     <quic_asutoshd@quicinc.com>, <quic_cang@quicinc.com>,
        <bvanassche@acm.org>, <mani@kernel.org>,
        <stanley.chu@mediatek.com>, <adrian.hunter@intel.com>,
        <beanhuo@micron.com>, <avri.altman@wdc.com>,
        <martin.petersen@oracle.com>, <linux-scsi@vger.kernel.org>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        Arthur Simchaev <Arthur.Simchaev@wdc.com>,
        open list <linux-kernel@vger.kernel.org>
References: <cover.1678247309.git.quic_nguyenb@quicinc.com>
 <c7fcbb70f0e74d225c1a09f107ba1058270739be.1678247309.git.quic_nguyenb@quicinc.com>
 <CAGaU9a_CkxHU-k519TL2hfLZSM6Hfoo6sAELmJ+6Vy2X2ZCOrw@mail.gmail.com>
 <86620bee-383c-b1e4-d4df-e4d8465a1d89@quicinc.com>
 <CAGaU9a9QkCnN-1CvHGB78vXaARB0uWMZCeAYr7qRcUE9effGYQ@mail.gmail.com>
From:   "Bao D. Nguyen" <quic_nguyenb@quicinc.com>
In-Reply-To: <CAGaU9a9QkCnN-1CvHGB78vXaARB0uWMZCeAYr7qRcUE9effGYQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01a.na.qualcomm.com (10.52.223.231)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: Nf54sT-7vRXCt7rpwqNOHSST6xxZjC6f
X-Proofpoint-ORIG-GUID: Nf54sT-7vRXCt7rpwqNOHSST6xxZjC6f
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-09_04,2023-03-08_03,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0
 priorityscore=1501 mlxscore=0 lowpriorityscore=0 adultscore=0 bulkscore=0
 mlxlogscore=999 impostorscore=0 clxscore=1015 phishscore=0 suspectscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2303090053
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/8/2023 10:21 PM, Stanley Chu wrote:
> Hi Bao,
>
> On Thu, Mar 9, 2023 at 1:31 PM Bao D. Nguyen <quic_nguyenb@quicinc.com> wrote:
>> On 3/8/2023 7:10 PM, Stanley Chu wrote:
>>> Hi Bao,
>>>
>>> On Wed, Mar 8, 2023 at 12:10 PM Bao D. Nguyen <quic_nguyenb@quicinc.com> wrote:
>>>> Add ufshcd_mcq_abort() to support ufs abort in mcq mode.
>>>>
>>>> Signed-off-by: Bao D. Nguyen <quic_nguyenb@quicinc.com>
>>>> ---
>>>>    drivers/ufs/core/ufs-mcq.c     | 76 ++++++++++++++++++++++++++++++++++++++++++
>>>>    drivers/ufs/core/ufshcd-priv.h |  5 ++-
>>>>    drivers/ufs/core/ufshcd.c      | 11 ++++--
>>>>    3 files changed, 88 insertions(+), 4 deletions(-)
>>>>
>>>> diff --git a/drivers/ufs/core/ufs-mcq.c b/drivers/ufs/core/ufs-mcq.c
>>>> index e27d8eb..6c65cd5 100644
>>>> --- a/drivers/ufs/core/ufs-mcq.c
>>>> +++ b/drivers/ufs/core/ufs-mcq.c
>>>> @@ -646,3 +646,79 @@ static bool ufshcd_mcq_cqe_search(struct ufs_hba *hba,
>>>>           spin_unlock(&hwq->cq_lock);
>>>>           return ret;
>>>>    }
>>>> +
>>>> +/**
>>>> + * ufshcd_mcq_abort - Abort the command in MCQ.
>>>> + * @cmd - The command to be aborted.
>>>> + *
>>>> + * Returns SUCCESS or FAILED error codes
>>>> + */
>>>> +int ufshcd_mcq_abort(struct scsi_cmnd *cmd)
>>>> +{
>>>> +       struct Scsi_Host *host = cmd->device->host;
>>>> +       struct ufs_hba *hba = shost_priv(host);
>>>> +       int tag = scsi_cmd_to_rq(cmd)->tag;
>>>> +       struct ufshcd_lrb *lrbp = &hba->lrb[tag];
>>>> +       struct ufs_hw_queue *hwq;
>>>> +       int err = FAILED;
>>>> +
>>>> +       if (!lrbp->cmd) {
>>>> +               dev_err(hba->dev,
>>>> +                       "%s: skip abort. cmd at tag %d already completed.\n",
>>>> +                       __func__, tag);
>>>> +               goto out;
>>>> +       }
>>>> +
>>>> +       /* Skip task abort in case previous aborts failed and report failure */
>>>> +       if (lrbp->req_abort_skip) {
>>>> +               dev_err(hba->dev, "%s: skip abort. tag %d failed earlier\n",
>>>> +                       __func__, tag);
>>>> +               goto out;
>>>> +       }
>>>> +
>>>> +       hwq = ufshcd_mcq_req_to_hwq(hba, scsi_cmd_to_rq(cmd));
>>>> +
>>>> +       if (ufshcd_mcq_sqe_search(hba, hwq, tag)) {
>>>> +               /*
>>>> +                * Failure. The command should not be "stuck" in SQ for
>>>> +                * a long time which resulted in command being aborted.
>>>> +                */
>>>> +               dev_err(hba->dev, "%s: cmd found in sq. hwq=%d, tag=%d\n",
>>>> +                               __func__, hwq->id, tag);
>>>> +               /* Set the Command Type to 0xF per the spec */
>>>> +               ufshcd_mcq_nullify_cmd(hba, hwq);
>>>> +               goto out;
>>>> +       }
>>>> +
>>>> +       if (ufshcd_mcq_cqe_search(hba, hwq, tag)) {
>>>> +               dev_err(hba->dev, "%s: cmd found in cq. hwq=%d, tag=%d\n",
>>>> +                               __func__, hwq->id, tag);
>>>> +               /*
>>>> +                * The command should not be 'stuck' in the CQ for such a long time.
>>>> +                * Is interrupt missing? Process the CQEs here. If the interrupt is
>>>> +                * invoked at a later time, the CQ will be empty because the CQEs
>>>> +                * are already processed here.
>>>> +                */
>>>> +               ufshcd_mcq_poll_cqe_lock(hba, hwq);
>>>> +               err = SUCCESS;
>>>> +               goto out;
>>>> +       }
>>>> +
>>>> +       /*
>>>> +        * The command is not in the Submission Queue, and it is not
>>>> +        * in the Completion Queue either. Query the device to see if
>>>> +        * the command is being processed in the device.
>>>> +        */
>>>> +       if (ufshcd_try_to_abort_task(hba, tag)) {
>>>> +               dev_err(hba->dev, "%s: device abort failed %d\n", __func__, err);
>>>> +               lrbp->req_abort_skip = true;
>>>> +               goto out;
>>>> +       }
>>>> +
>>>> +       err = SUCCESS;
>>>> +       if (lrbp->cmd)
>>>> +               ufshcd_release_scsi_cmd(hba, lrbp);
>>>> +
>>>> +out:
>>>> +       return err;
>>>> +}
>>>> diff --git a/drivers/ufs/core/ufshcd-priv.h b/drivers/ufs/core/ufshcd-priv.h
>>>> index 0527926..d883c03 100644
>>>> --- a/drivers/ufs/core/ufshcd-priv.h
>>>> +++ b/drivers/ufs/core/ufshcd-priv.h
>>>> @@ -77,7 +77,10 @@ unsigned long ufshcd_mcq_poll_cqe_lock(struct ufs_hba *hba,
>>>>                                          struct ufs_hw_queue *hwq);
>>>>
>>>>    int ufshcd_mcq_sq_cleanup(struct ufs_hba *hba, int task_tag, int *result);
>>>> -
>>>> +int ufshcd_mcq_abort(struct scsi_cmnd *cmd);
>>>> +int ufshcd_try_to_abort_task(struct ufs_hba *hba, int tag);
>>>> +void ufshcd_release_scsi_cmd(struct ufs_hba *hba,
>>>> +                               struct ufshcd_lrb *lrbp);
>>>>    #define UFSHCD_MCQ_IO_QUEUE_OFFSET     1
>>>>    #define SD_ASCII_STD true
>>>>    #define SD_RAW false
>>>> diff --git a/drivers/ufs/core/ufshcd.c b/drivers/ufs/core/ufshcd.c
>>>> index 408c16c..e06399e 100644
>>>> --- a/drivers/ufs/core/ufshcd.c
>>>> +++ b/drivers/ufs/core/ufshcd.c
>>>> @@ -302,7 +302,6 @@ static int ufshcd_setup_hba_vreg(struct ufs_hba *hba, bool on);
>>>>    static int ufshcd_setup_vreg(struct ufs_hba *hba, bool on);
>>>>    static inline int ufshcd_config_vreg_hpm(struct ufs_hba *hba,
>>>>                                            struct ufs_vreg *vreg);
>>>> -static int ufshcd_try_to_abort_task(struct ufs_hba *hba, int tag);
>>>>    static void ufshcd_wb_toggle_buf_flush_during_h8(struct ufs_hba *hba,
>>>>                                                    bool enable);
>>>>    static void ufshcd_hba_vreg_set_lpm(struct ufs_hba *hba);
>>>> @@ -5414,7 +5413,7 @@ static irqreturn_t ufshcd_uic_cmd_compl(struct ufs_hba *hba, u32 intr_status)
>>>>    }
>>>>
>>>>    /* Release the resources allocated for processing a SCSI command. */
>>>> -static void ufshcd_release_scsi_cmd(struct ufs_hba *hba,
>>>> +void ufshcd_release_scsi_cmd(struct ufs_hba *hba,
>>>>                                       struct ufshcd_lrb *lrbp)
>>>>    {
>>>>           struct scsi_cmnd *cmd = lrbp->cmd;
>>>> @@ -7340,7 +7339,7 @@ static void ufshcd_set_req_abort_skip(struct ufs_hba *hba, unsigned long bitmap)
>>>>     *
>>>>     * Returns zero on success, non-zero on failure
>>>>     */
>>>> -static int ufshcd_try_to_abort_task(struct ufs_hba *hba, int tag)
>>>> +int ufshcd_try_to_abort_task(struct ufs_hba *hba, int tag)
>>>>    {
>>>>           struct ufshcd_lrb *lrbp = &hba->lrb[tag];
>>>>           int err = 0;
>>>> @@ -7500,6 +7499,12 @@ static int ufshcd_abort(struct scsi_cmnd *cmd)
>>>>                   goto release;
>>>>           }
>>>>
>>>> +       if (is_mcq_enabled(hba)) {
>>>> +               /* MCQ mode. Branch off to handle abort for mcq mode */
>>>> +               err = ufshcd_mcq_abort(cmd);
>>>> +               goto release;
>>>> +       }
>>>> +
>>>>           /* Skip task abort in case previous aborts failed and report failure */
>>>>           if (lrbp->req_abort_skip) {
>>>>                   dev_err(hba->dev, "%s: skipping abort\n", __func__);
>>>> --
>>>> 2.7.4
>>>>
>>> It seems that ufshcd_abort_all() also needs an error handling flow for MCQ.
>> Hi Stanley, thank you for the reviews.
>>
>> I am not able to find the function ufshcd_abort_all() in the drivers/ufs
>> directory. Can you please clarify where this function is located? Thanks.
> The function ufshcd_abort_all() was introduced in the following link:
> https://android.googlesource.com/kernel/common/+/b817e6ffbad7a1a0a5ca5bb7d4020823c3f4d9d0

Ah ok. Thank you for this info. The ufshcd_abort_all() is in 
ufshcd_err_handler(), it is unrelated to the ufshcd_abort().

Adding MCQ support to ufshcd_err_handler() will be in a separate patch.

> Can you confirm if these patches are based on the latest kernel
> 6.3-rc1 or the latest linux-next tree?
>
> Thanks,
> Stanley
>
>>> Thanks,
>>> Stanley
>>

