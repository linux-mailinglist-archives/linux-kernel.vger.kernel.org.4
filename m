Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B5B2C6F63FB
	for <lists+linux-kernel@lfdr.de>; Thu,  4 May 2023 06:19:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229712AbjEDETi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 May 2023 00:19:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229470AbjEDETe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 May 2023 00:19:34 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3EB541BF6;
        Wed,  3 May 2023 21:19:32 -0700 (PDT)
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 34448eQf015294;
        Thu, 4 May 2023 04:18:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=WOWK6KvqKDne1Xsxg0veSRp418OOvpSfdJx/mxhxPLE=;
 b=cpxE5MA+Poa5fjwPL28zxizC8Rb5UVdXQBrVVRgZUCAkUTAmOUTDUyo+m0rhFhdBnNfG
 UY+seipx5lVjjOwteH7bgoaNa5qoKe865TOlNcPwHWZuBq4KYjrbi4qn5kV4WtLEwhY0
 WYK2hYvNBzsXsSx67S+s53DD7Ze9RkviS51Xb3FqSzi+0P9jQ/KXF0eooNtrbCEQkYdp
 QcbBoG7kDNjU1p9lOO0Kr7Lq4R7kT91Y72KpwlaqaomJ69cyEDVsMRQKK7+VqKOcgyUH
 Vv2krwYnmau+xklKgmnIT/wOW2jY8G64tMPLijzCwJfA2kxNu8K1NYToM6YXyz5uIZKj Xg== 
Received: from nasanppmta01.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3qbeb2tymb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 04 May 2023 04:18:48 +0000
Received: from nasanex01a.na.qualcomm.com (nasanex01a.na.qualcomm.com [10.52.223.231])
        by NASANPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3444Ilux008202
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 4 May 2023 04:18:47 GMT
Received: from [192.168.143.77] (10.80.80.8) by nasanex01a.na.qualcomm.com
 (10.52.223.231) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.42; Wed, 3 May 2023
 21:18:46 -0700
Message-ID: <1030a6bd-88a9-8222-54b0-bcc5b5e4fe67@quicinc.com>
Date:   Wed, 3 May 2023 21:18:46 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH v1 5/5] ufs: core: Add error handling for MCQ mode
Content-Language: en-US
To:     Stanley Chu <chu.stanley@gmail.com>
CC:     <quic_asutoshd@quicinc.com>, <quic_cang@quicinc.com>,
        <bvanassche@acm.org>, <mani@kernel.org>,
        <stanley.chu@mediatek.com>, <adrian.hunter@intel.com>,
        <beanhuo@micron.com>, <avri.altman@wdc.com>,
        <martin.petersen@oracle.com>, <linux-scsi@vger.kernel.org>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "open list" <linux-kernel@vger.kernel.org>,
        Po-Wen Kao <powen.kao@mediatek.com>, <peter.wang@mediatek.com>,
        Alice Chao <alice.chao@mediatek.com>, <naomi.chu@mediatek.com>
References: <cover.1680083571.git.quic_nguyenb@quicinc.com>
 <56ff07e08dbaa6ca3db265c41fa8922a63797905.1680083571.git.quic_nguyenb@quicinc.com>
 <CAGaU9a9BUaWoKPk-7L6cE7D5c4dNuFbnG1jSaq8zR=P0m8z3Tw@mail.gmail.com>
From:   "Bao D. Nguyen" <quic_nguyenb@quicinc.com>
In-Reply-To: <CAGaU9a9BUaWoKPk-7L6cE7D5c4dNuFbnG1jSaq8zR=P0m8z3Tw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01a.na.qualcomm.com (10.52.223.231)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: _Bmv5HOfVhBVq_hOD9-0fnneAC2s61c_
X-Proofpoint-GUID: _Bmv5HOfVhBVq_hOD9-0fnneAC2s61c_
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-05-04_01,2023-05-03_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0
 impostorscore=0 spamscore=0 bulkscore=0 mlxscore=0 phishscore=0
 malwarescore=0 adultscore=0 clxscore=1015 priorityscore=1501
 mlxlogscore=999 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2303200000 definitions=main-2305040035
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/27/2023 12:17 AM, Stanley Chu wrote:
> Hi Bao,
> 
> Bao D. Nguyen <quic_nguyenb@quicinc.com> 於 2023年3月29日 週三 下午6:14寫道：
>>
>> Add support for error handling for MCQ mode.
>>
>> Signed-off-by: Bao D. Nguyen <quic_nguyenb@quicinc.com>
>> ---
>>   drivers/ufs/core/ufshcd.c | 80 ++++++++++++++++++++++++++++++++++++++++-------
>>   1 file changed, 69 insertions(+), 11 deletions(-)
>>
>> diff --git a/drivers/ufs/core/ufshcd.c b/drivers/ufs/core/ufshcd.c
>> index fef1907..e947f7f 100644
>> --- a/drivers/ufs/core/ufshcd.c
>> +++ b/drivers/ufs/core/ufshcd.c
>> @@ -3127,6 +3127,12 @@ static int ufshcd_wait_for_dev_cmd(struct ufs_hba *hba,
>>                  err = -ETIMEDOUT;
>>                  dev_dbg(hba->dev, "%s: dev_cmd request timedout, tag %d\n",
>>                          __func__, lrbp->task_tag);
>> +
>> +               /* MCQ mode */
>> +               if (is_mcq_enabled(hba))
>> +                       return ufshcd_clear_cmds(hba, 1UL << lrbp->task_tag);
> 
> When a time-out occurs during the command-clearing process, it appears
> that the MCQ path does not properly clear 'hba->dev_cmd.complete'.
> This could result in a null pointer reference if the device command
> interrupt arrives at a later time.
> 
> Could you please help check this?
Thanks Stanley. I will take a look.

> 
> Thanks,
> Stanley Chu
> 
>> +
>> +               /* SDB mode */
>>                  if (ufshcd_clear_cmds(hba, 1UL << lrbp->task_tag) == 0) {
>>                          /* successfully cleared the command, retry if needed */
>>                          err = -EAGAIN;
>> @@ -5562,6 +5568,10 @@ static int ufshcd_poll(struct Scsi_Host *shost, unsigned int queue_num)
>>    */
>>   static irqreturn_t ufshcd_transfer_req_compl(struct ufs_hba *hba)
>>   {
>> +       struct ufshcd_lrb *lrbp;
>> +       u32 hwq_num, utag;
>> +       int tag;
>> +
>>          /* Resetting interrupt aggregation counters first and reading the
>>           * DOOR_BELL afterward allows us to handle all the completed requests.
>>           * In order to prevent other interrupts starvation the DB is read once
>> @@ -5580,7 +5590,22 @@ static irqreturn_t ufshcd_transfer_req_compl(struct ufs_hba *hba)
>>           * Ignore the ufshcd_poll() return value and return IRQ_HANDLED since we
>>           * do not want polling to trigger spurious interrupt complaints.
>>           */
>> -       ufshcd_poll(hba->host, UFSHCD_POLL_FROM_INTERRUPT_CONTEXT);
>> +       if (!is_mcq_enabled(hba)) {
>> +               ufshcd_poll(hba->host, UFSHCD_POLL_FROM_INTERRUPT_CONTEXT);
>> +               goto out;
>> +       }
>> +
>> +       /* MCQ mode */
>> +       for (tag = 0; tag < hba->nutrs; tag++) {
>> +               lrbp = &hba->lrb[tag];
>> +               if (lrbp->cmd) {
>> +                       utag = blk_mq_unique_tag(scsi_cmd_to_rq(lrbp->cmd));
>> +                       hwq_num = blk_mq_unique_tag_to_hwq(utag);
>> +                       ufshcd_poll(hba->host, hwq_num);
>> +               }
>> +       }
>> +
>> +out:
>>
>>          return IRQ_HANDLED;
>>   }
>> @@ -6359,18 +6384,36 @@ static bool ufshcd_abort_all(struct ufs_hba *hba)
>>          bool needs_reset = false;
>>          int tag, ret;
>>
>> -       /* Clear pending transfer requests */
>> -       for_each_set_bit(tag, &hba->outstanding_reqs, hba->nutrs) {
>> -               ret = ufshcd_try_to_abort_task(hba, tag);
>> -               dev_err(hba->dev, "Aborting tag %d / CDB %#02x %s\n", tag,
>> -                       hba->lrb[tag].cmd ? hba->lrb[tag].cmd->cmnd[0] : -1,
>> -                       ret ? "failed" : "succeeded");
>> -               if (ret) {
>> -                       needs_reset = true;
>> -                       goto out;
>> +       if (is_mcq_enabled(hba)) {
>> +               struct ufshcd_lrb *lrbp;
>> +               int tag;
>> +
>> +               for (tag = 0; tag < hba->nutrs; tag++) {
>> +                       lrbp = &hba->lrb[tag];
>> +                       if (lrbp->cmd) {
>> +                               ret = ufshcd_try_to_abort_task(hba, tag);
>> +                               dev_err(hba->dev, "Aborting tag %d / CDB %#02x %s\n", tag,
>> +                                       hba->lrb[tag].cmd ? hba->lrb[tag].cmd->cmnd[0] : -1,
>> +                                       ret ? "failed" : "succeeded");
>> +                       }
>> +                       if (ret) {
>> +                               needs_reset = true;
>> +                               goto out;
>> +                       }
>> +               }
>> +       } else {
>> +               /* Clear pending transfer requests */
>> +               for_each_set_bit(tag, &hba->outstanding_reqs, hba->nutrs) {
>> +                       ret = ufshcd_try_to_abort_task(hba, tag);
>> +                       dev_err(hba->dev, "Aborting tag %d / CDB %#02x %s\n", tag,
>> +                               hba->lrb[tag].cmd ? hba->lrb[tag].cmd->cmnd[0] : -1,
>> +                               ret ? "failed" : "succeeded");
>> +                       if (ret) {
>> +                               needs_reset = true;
>> +                               goto out;
>> +                       }
>>                  }
>>          }
>> -
>>          /* Clear pending task management requests */
>>          for_each_set_bit(tag, &hba->outstanding_tasks, hba->nutmrs) {
>>                  if (ufshcd_clear_tm_cmd(hba, tag)) {
>> @@ -7302,6 +7345,8 @@ static int ufshcd_eh_device_reset_handler(struct scsi_cmnd *cmd)
>>          unsigned long flags, pending_reqs = 0, not_cleared = 0;
>>          struct Scsi_Host *host;
>>          struct ufs_hba *hba;
>> +       struct ufs_hw_queue *hwq;
>> +       struct ufshcd_lrb *lrbp;
>>          u32 pos;
>>          int err;
>>          u8 resp = 0xF, lun;
>> @@ -7317,6 +7362,19 @@ static int ufshcd_eh_device_reset_handler(struct scsi_cmnd *cmd)
>>                  goto out;
>>          }
>>
>> +       if (is_mcq_enabled(hba)) {
>> +               for (pos = 0; pos < hba->nutrs; pos++) {
>> +                       lrbp = &hba->lrb[pos];
>> +                       if (lrbp->cmd && lrbp->lun == lun) {
>> +                               ufshcd_clear_cmds(hba, 1UL << pos);
>> +                               hwq = ufshcd_mcq_req_to_hwq(hba, scsi_cmd_to_rq(lrbp->cmd));
>> +                               ufshcd_mcq_poll_cqe_lock(hba, hwq);
>> +                       }
>> +               }
>> +               err = 0;
>> +               goto out;
>> +       }
>> +
>>          /* clear the commands that were pending for corresponding LUN */
>>          spin_lock_irqsave(&hba->outstanding_lock, flags);
>>          for_each_set_bit(pos, &hba->outstanding_reqs, hba->nutrs)
>> --
>> 2.7.4
>>

