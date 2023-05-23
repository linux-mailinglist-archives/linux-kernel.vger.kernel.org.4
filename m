Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A15670D47A
	for <lists+linux-kernel@lfdr.de>; Tue, 23 May 2023 09:01:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234154AbjEWHBg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 May 2023 03:01:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231948AbjEWHBc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 May 2023 03:01:32 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 319F6109;
        Tue, 23 May 2023 00:01:31 -0700 (PDT)
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 34N4r0C1018820;
        Tue, 23 May 2023 07:01:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=t6Uul4VkYvxZcqwnoeIttlKJ75AG53EJBrFHqmB54w0=;
 b=PJpR7G5uz3HcBQ9i0zgSt8GGSp8fvgqtX6/+2FhN2C11cWI00TxDoFoH2tCmFLa9CZaD
 qU/FgkK3B/lbLvTZzedsF/tWzRZDATkh3myKCcsvUcV3CwWtbM8y5ilxeIk+CQX1t8V8
 DRGvMG6IShnypeyV0a9UOtjDBpdyvGA0lDlV4y2hNVptFsjuL9rRIt0fpnHmUduFjfvT
 1DICPtUE9tcvyFdF6rPYP5jlagh5jmIvC8KEKNZPqbZPurrvKAYaAizVjjEckm71eXf2
 VguLBCubMIyAhfJNz57VVgsjIlS2q3yYgFQ+HvZMxaPfVCx0mEGbawk/hZxQlsWGlnhN Iw== 
Received: from nasanppmta01.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3qrpmm084w-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 23 May 2023 07:01:11 +0000
Received: from nasanex01a.na.qualcomm.com (nasanex01a.na.qualcomm.com [10.52.223.231])
        by NASANPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 34N71AN1002468
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 23 May 2023 07:01:10 GMT
Received: from [192.168.143.77] (10.80.80.8) by nasanex01a.na.qualcomm.com
 (10.52.223.231) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.42; Tue, 23 May
 2023 00:01:10 -0700
Message-ID: <a9352709-b9c8-065e-cca8-33e4cde55ff1@quicinc.com>
Date:   Tue, 23 May 2023 00:01:09 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH v5 7/7] ufs: core: Add error handling for MCQ mode
Content-Language: en-US
To:     Stanley Chu <chu.stanley@gmail.com>
CC:     <quic_asutoshd@quicinc.com>, <quic_cang@quicinc.com>,
        <bvanassche@acm.org>, <mani@kernel.org>,
        <stanley.chu@mediatek.com>, <adrian.hunter@intel.com>,
        <beanhuo@micron.com>, <avri.altman@wdc.com>,
        <martin.petersen@oracle.com>, <linux-scsi@vger.kernel.org>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "open list" <linux-kernel@vger.kernel.org>
References: <cover.1683872601.git.quic_nguyenb@quicinc.com>
 <7b884263c9db9a9666086a345ede85bb56d9dfc7.1683872601.git.quic_nguyenb@quicinc.com>
 <CAGaU9a8t9CHcGvJk+GFaTO=pDQA+PwEjCWH8sMo=T6-oKvTrsw@mail.gmail.com>
 <CAGaU9a8+mDgVu9-rmH944NhbSCGocADUhbdin5gQkrc_FD1xMQ@mail.gmail.com>
From:   "Bao D. Nguyen" <quic_nguyenb@quicinc.com>
In-Reply-To: <CAGaU9a8+mDgVu9-rmH944NhbSCGocADUhbdin5gQkrc_FD1xMQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01a.na.qualcomm.com (10.52.223.231)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: AlSrd92oLc9IXbv54LCDeg7fNDI3iais
X-Proofpoint-GUID: AlSrd92oLc9IXbv54LCDeg7fNDI3iais
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-05-23_04,2023-05-22_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 clxscore=1015
 mlxscore=0 lowpriorityscore=0 impostorscore=0 suspectscore=0 bulkscore=0
 adultscore=0 mlxlogscore=999 spamscore=0 malwarescore=0 priorityscore=1501
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2304280000
 definitions=main-2305230057
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/21/2023 11:56 PM, Stanley Chu wrote:
> On Mon, May 22, 2023 at 2:48 PM Stanley Chu <chu.stanley@gmail.com> wrote:
>>
>> Hi Bao,
>>
>> Bao D. Nguyen <quic_nguyenb@quicinc.com> 於 2023年5月12日 週五 下午2:34寫道：
>>>
>>> Add support for error handling for MCQ mode.
>>>
>>> Signed-off-by: Bao D. Nguyen <quic_nguyenb@quicinc.com>
>>> ---
>>>   drivers/ufs/core/ufshcd.c | 85 +++++++++++++++++++++++++++++++++++++++++------
>>>   1 file changed, 74 insertions(+), 11 deletions(-)
>>>
>>> diff --git a/drivers/ufs/core/ufshcd.c b/drivers/ufs/core/ufshcd.c
>>> index ec07e49..9345118 100644
>>> --- a/drivers/ufs/core/ufshcd.c
>>> +++ b/drivers/ufs/core/ufshcd.c
>>> @@ -3148,6 +3148,16 @@ static int ufshcd_wait_for_dev_cmd(struct ufs_hba *hba,
>>>                  err = -ETIMEDOUT;
>>>                  dev_dbg(hba->dev, "%s: dev_cmd request timedout, tag %d\n",
>>>                          __func__, lrbp->task_tag);
>>> +
>>> +               /* MCQ mode */
>>> +               if (is_mcq_enabled(hba)) {
>>> +                       err = ufshcd_clear_cmd(hba, lrbp->task_tag);
>>> +                       if (!err)
>>> +                               hba->dev_cmd.complete = NULL;
>>
>> How about always clearing hba->dev_cmd.complete? If ufshcd_clear_cmd()
>> fails (for example, times out), "complete" should be cleared, similar
>> to the "pending" case in the SDB path.
>>
>>> +                       return err;
>>> +               }
>>> +
>>> +               /* SDB mode */
>>>                  if (ufshcd_clear_cmd(hba, lrbp->task_tag) == 0) {
>>>                          /* successfully cleared the command, retry if needed */
>>>                          err = -EAGAIN;
>>> @@ -5581,6 +5591,10 @@ static int ufshcd_poll(struct Scsi_Host *shost, unsigned int queue_num)
>>>    */
>>>   static irqreturn_t ufshcd_transfer_req_compl(struct ufs_hba *hba)
>>>   {
>>> +       struct ufshcd_lrb *lrbp;
>>> +       u32 hwq_num, utag;
>>> +       int tag;
>>> +
>>>          /* Resetting interrupt aggregation counters first and reading the
>>>           * DOOR_BELL afterward allows us to handle all the completed requests.
>>>           * In order to prevent other interrupts starvation the DB is read once
>>> @@ -5599,7 +5613,22 @@ static irqreturn_t ufshcd_transfer_req_compl(struct ufs_hba *hba)
>>>           * Ignore the ufshcd_poll() return value and return IRQ_HANDLED since we
>>>           * do not want polling to trigger spurious interrupt complaints.
>>>           */
>>> -       ufshcd_poll(hba->host, UFSHCD_POLL_FROM_INTERRUPT_CONTEXT);
>>> +       if (!is_mcq_enabled(hba)) {
>>> +               ufshcd_poll(hba->host, UFSHCD_POLL_FROM_INTERRUPT_CONTEXT);
>>> +               goto out;
>>> +       }
>>> +
>>> +       /* MCQ mode */
>>> +       for (tag = 0; tag < hba->nutrs; tag++) {
>>> +               lrbp = &hba->lrb[tag];
>>> +               if (ufshcd_cmd_inflight(lrbp->cmd)) {
>>> +                       utag = blk_mq_unique_tag(scsi_cmd_to_rq(lrbp->cmd));
>>> +                       hwq_num = blk_mq_unique_tag_to_hwq(utag);
>>> +                       ufshcd_poll(hba->host, hwq_num);
>>> +               }
>>> +       }
>>
>> In SDB mode, the DOOR_BELL is reset by ufshcd_hba_stop(). All bits
>> that were previously set in DOOR_BELL are also set in "completed_reqs"
>> in ufshcd_poll(). This allows ufshcd_poll() to handle all outstanding
>> requests properly.
>>
>> However, in MCQ mode, the CQ tail registers cannot provide the same
>> information after they are reset. Hence, they cannot be properly
>> referenced by ufshcd_poll().
> 
> A fixed version sample is as follows and has been tested on our end.
Thank you Stanley. I will make the change.

> 
> struct scsi_cmnd *cmd;
> 
> for (tag = 0; tag < hba->nutrs; tag++) {
>          lrbp = &hba->lrb[tag];
>          cmd = lrbp->cmd;
>          if (ufshcd_cmd_inflight(cmd)) {
>                  set_host_byte(cmd, DID_ERROR);
>                  ufshcd_release_scsi_cmd(hba, lrbp);
>                  scsi_done(cmd);
>          }
> }
> 
> Thanks,
> Stanley Chu

