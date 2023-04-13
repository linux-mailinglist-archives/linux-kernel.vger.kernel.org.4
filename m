Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 067356E06B8
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Apr 2023 08:09:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229899AbjDMGI6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Apr 2023 02:08:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229579AbjDMGIz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Apr 2023 02:08:55 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C8065FDE;
        Wed, 12 Apr 2023 23:08:53 -0700 (PDT)
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 33D5okWF003043;
        Thu, 13 Apr 2023 06:08:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=p1SPUdbAfaq/PCFjtFF8DMf37M4WKJ7gBfQvDxfM1Lc=;
 b=EXxMTRYlyPITfS2sv54xjRui2qDQp4TQRRs79Iv7FAZHnARuD6smwHJcgNg5KB+0yY4M
 EWArAMpg9dhaAavoREXzXxsXiWYGKIyrUGy2GsusZuVOzxt9v0yfTXYrt6Y6pBJGNz1a
 ow0OhFYqXeGJvTuvTZ72KF4MhdG/atilmzRqDX2LaV9zEii2p5UWeCd5oUw4q4NlTbsA
 grNNwOXQw/yvVmNdsjUNLON3Ffc0SXdw++T66uTgzEsLlSB9ZlalC6/PXsdxpDY7emCA
 lpuUmojW58HUGBbhiHfengZHZuzTus6p77we8wdmS9Pwi4IIhPW5g4KggOO+/aI6CJNr zA== 
Received: from nasanppmta01.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3pxbx5r11u-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 13 Apr 2023 06:08:33 +0000
Received: from nasanex01a.na.qualcomm.com (nasanex01a.na.qualcomm.com [10.52.223.231])
        by NASANPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 33D68Wsu028294
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 13 Apr 2023 06:08:32 GMT
Received: from [192.168.143.77] (10.80.80.8) by nasanex01a.na.qualcomm.com
 (10.52.223.231) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.42; Wed, 12 Apr
 2023 23:08:31 -0700
Message-ID: <e3d2ea6c-3078-dbdc-6000-f8ea1446381e@quicinc.com>
Date:   Wed, 12 Apr 2023 23:08:31 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH v1 1/5] ufs: mcq: Add supporting functions for mcq abort
Content-Language: en-US
To:     =?UTF-8?B?UG93ZW4gS2FvICjpq5jkvK/mlocp?= <Powen.Kao@mediatek.com>,
        "beanhuo@micron.com" <beanhuo@micron.com>,
        "avri.altman@wdc.com" <avri.altman@wdc.com>,
        "bvanassche@acm.org" <bvanassche@acm.org>,
        "quic_asutoshd@quicinc.com" <quic_asutoshd@quicinc.com>,
        "martin.petersen@oracle.com" <martin.petersen@oracle.com>,
        "mani@kernel.org" <mani@kernel.org>,
        "quic_cang@quicinc.com" <quic_cang@quicinc.com>,
        "adrian.hunter@intel.com" <adrian.hunter@intel.com>
CC:     "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
        "alim.akhtar@samsung.com" <alim.akhtar@samsung.com>,
        "jejb@linux.ibm.com" <jejb@linux.ibm.com>,
        =?UTF-8?B?U3RhbmxleSBDaHUgKOacseWOn+mZnik=?= 
        <stanley.chu@mediatek.com>,
        "Arthur.Simchaev@wdc.com" <Arthur.Simchaev@wdc.com>,
        "ebiggers@google.com" <ebiggers@google.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <cover.1680083571.git.quic_nguyenb@quicinc.com>
 <0351ea8bb5d7b223778367867ca3791cc6ee608d.1680083571.git.quic_nguyenb@quicinc.com>
 <ee415bbb6f1196103bbfeea1e393fa71de109f05.camel@mediatek.com>
From:   "Bao D. Nguyen" <quic_nguyenb@quicinc.com>
In-Reply-To: <ee415bbb6f1196103bbfeea1e393fa71de109f05.camel@mediatek.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01a.na.qualcomm.com (10.52.223.231)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: kjOj1LipJPDK13WOcByMTKR6V49rYz1X
X-Proofpoint-GUID: kjOj1LipJPDK13WOcByMTKR6V49rYz1X
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-04-13_02,2023-04-12_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 phishscore=0
 lowpriorityscore=0 adultscore=0 mlxlogscore=999 malwarescore=0 bulkscore=0
 spamscore=0 suspectscore=0 priorityscore=1501 clxscore=1015
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2303200000 definitions=main-2304130055
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS,T_PDS_OTHER_BAD_TLD,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/11/2023 6:14 AM, Powen Kao (高伯文) wrote:
> Hi Bao D.,
>
> We have done some test based on your RFC v3 patches and an issue is
> reported.

Hi Powen,

Thank you very much for catching this issue. It seems that I cannot use 
read_poll_timeout() because it sleeps while holding the spin_lock().

I will make the change to poll the registers in a tight loop with 
udelay(20) polling interval in the next revision.

Thanks,
Bao

>
>     kworker/u16:4: BUG: scheduling while atomic:
>     kworker/u16:4/5736/0x00000002
>     kworker/u16:4: [name:core&]Preemption disabled at:
>     kworker/u16:4: [<ffffffef97e33024>] ufshcd_mcq_sq_cleanup+0x9c/0x27c
>     kworker/u16:4: CPU: 2 PID: 5736 Comm: kworker/u16:4 Tainted: G
>     S      W  OE
>     kworker/u16:4: Workqueue: ufs_eh_wq_0 ufshcd_err_handler
>     kworker/u16:4: Call trace:
>     kworker/u16:4:  dump_backtrace+0x108/0x15c
>     kworker/u16:4:  show_stack+0x20/0x30
>     kworker/u16:4:  dump_stack_lvl+0x6c/0x8c
>     kworker/u16:4:  dump_stack+0x20/0x44
>     kworker/u16:4:  __schedule_bug+0xd4/0x100
>     kworker/u16:4:  __schedule+0x660/0xa5c
>     kworker/u16:4:  schedule+0x80/0xec
>     kworker/u16:4:  schedule_hrtimeout_range_clock+0xa0/0x140
>     kworker/u16:4:  schedule_hrtimeout_range+0x1c/0x30
>     kworker/u16:4:  usleep_range_state+0x88/0xd8
>     kworker/u16:4:  ufshcd_mcq_sq_cleanup+0x170/0x27c
>     kworker/u16:4:  ufshcd_clear_cmds+0x78/0x184
>     kworker/u16:4:  ufshcd_wait_for_dev_cmd+0x234/0x348
>     kworker/u16:4:  ufshcd_exec_dev_cmd+0x220/0x298
>     kworker/u16:4:  ufshcd_verify_dev_init+0x68/0x124
>     kworker/u16:4:  ufshcd_probe_hba+0x390/0x9bc
>     kworker/u16:4:  ufshcd_host_reset_and_restore+0x74/0x158
>     kworker/u16:4:  ufshcd_reset_and_restore+0x70/0x31c
>     kworker/u16:4:  ufshcd_err_handler+0xad4/0xe58
>     kworker/u16:4:  process_one_work+0x214/0x5b8
>     kworker/u16:4:  worker_thread+0x2d4/0x448
>     kworker/u16:4:  kthread+0x110/0x1e0
>     kworker/u16:4:  ret_from_fork+0x10/0x20
>     kworker/u16:4: ------------[ cut here ]------------
>
>
> On Wed, 2023-03-29 at 03:01 -0700, Bao D. Nguyen wrote:
>
>> +/**
>> + * ufshcd_mcq_sq_cleanup - Clean up Submission Queue resources
>> + * associated with the pending command.
>> + * @hba - per adapter instance.
>> + * @task_tag - The command's task tag.
>> + * @result - Result of the Clean up operation.
>> + *
>> + * Returns 0 and result on completion. Returns error code if
>> + * the operation fails.
>> + */
>> +int ufshcd_mcq_sq_cleanup(struct ufs_hba *hba, int task_tag, int
>> *result)
>> +{
>> +       struct ufshcd_lrb *lrbp = &hba->lrb[task_tag];
>> +       struct scsi_cmnd *cmd = lrbp->cmd;
>> +       struct ufs_hw_queue *hwq;
>> +       void __iomem *reg, *opr_sqd_base;
>> +       u32 nexus, i, val;
>> +       int err;
>> +
>> +       if (task_tag != hba->nutrs - UFSHCD_NUM_RESERVED) {
>> +               if (!cmd)
>> +                       return FAILED;
>> +               hwq = ufshcd_mcq_req_to_hwq(hba,
>> scsi_cmd_to_rq(cmd));
>> +       } else {
>> +               hwq = hba->dev_cmd_queue;
>> +       }
>> +
>> +       i = hwq->id;
>> +
>> +       spin_lock(&hwq->sq_lock);
> As spin_lock() disable preemption
>
>> +
>> +       /* stop the SQ fetching before working on it */
>> +       err = ufshcd_mcq_sq_stop(hba, hwq);
>> +       if (err)
>> +               goto unlock;
>> +
>> +       /* SQCTI = EXT_IID, IID, LUN, Task Tag */
>> +       nexus = lrbp->lun << 8 | task_tag;
>> +       opr_sqd_base = mcq_opr_base(hba, OPR_SQD, i);
>> +       writel(nexus, opr_sqd_base + REG_SQCTI);
>> +
>> +       /* SQRTCy.ICU = 1 */
>> +       writel(SQ_ICU, opr_sqd_base + REG_SQRTC);
>> +
>> +       /* Poll SQRTSy.CUS = 1. Return result from SQRTSy.RTC */
>> +       reg = opr_sqd_base + REG_SQRTS;
>> +       err = read_poll_timeout(readl, val, val & SQ_CUS, 20,
>> +                               MCQ_POLL_US, false, reg);
> read_poll_timeout() was ufshcd_mcq_poll_register() in last patch,
> right? ufshcd_mcq_poll_register() calls usleep_range() causing KE as
> reported above. Same issue seems to still exist as read_poll_timeout()
> sleeps.
>
> Skipping ufshcd_mcq_sq_cleanup() by returning FAILED directly to
> trigger reset in ufshcd error handler successfully recover host.
>
> BTW, is there maybe a change list between RFC v3 and this v1 patch? :)
> Thanks
>
> Po-Wen
>
>

