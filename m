Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 83F6D6F63F7
	for <lists+linux-kernel@lfdr.de>; Thu,  4 May 2023 06:18:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229670AbjEDESd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 May 2023 00:18:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229554AbjEDESb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 May 2023 00:18:31 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 517E31BFC;
        Wed,  3 May 2023 21:18:22 -0700 (PDT)
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3442gRce015837;
        Thu, 4 May 2023 04:18:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=JRxXGj+jggWoHFuWrqp98yYQLnG7Q2Vc+BYHefHNdpw=;
 b=D4Y8pXNhzqMPzsLmhbxLw7qERnZ0Iusy14r4ssTX9PB7P+1fSGr3LGX1nrSdWlFdd+OS
 4nPOb+pnW80jphPyPHhUDB/+i1LZFyLafZK0EuF7fWQwzgAPR7FsXQCvWnbgZlL/nYoN
 bzTQDjUueJUcP1XEAFcsPGwcMNXGiWvN/WcN4I7QfzRY9M7RBtaVU3fzEsLKfqUk2+TD
 rwLwHU9mgt0yAxOoJqwmvP2LfEhYwfvAoumk6L3hht/qzVahfc4jGBYh+zOKYDVsITnd
 ld4AdeuBFTXoHXU5feODPtFoNVTtwWm0VWloLjpMAsv39tvATTtAzYWnr4pQfJ5NXE4T 6Q== 
Received: from nasanppmta04.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3qbsr41c3u-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 04 May 2023 04:18:04 +0000
Received: from nasanex01a.na.qualcomm.com (nasanex01a.na.qualcomm.com [10.52.223.231])
        by NASANPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3444I3wV020771
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 4 May 2023 04:18:03 GMT
Received: from [192.168.143.77] (10.80.80.8) by nasanex01a.na.qualcomm.com
 (10.52.223.231) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.42; Wed, 3 May 2023
 21:18:02 -0700
Message-ID: <b35c2e61-6fb1-37d5-886e-0fb67ee0d0a2@quicinc.com>
Date:   Wed, 3 May 2023 21:18:02 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH v2 5/5] ufs: core: Add error handling for MCQ mode
Content-Language: en-US
To:     Bart Van Assche <bvanassche@acm.org>, <quic_asutoshd@quicinc.com>,
        <quic_cang@quicinc.com>, <mani@kernel.org>,
        <Powen.Kao@mediatek.com>, <stanley.chu@mediatek.com>,
        <adrian.hunter@intel.com>, <beanhuo@micron.com>,
        <avri.altman@wdc.com>, <martin.petersen@oracle.com>
CC:     <linux-scsi@vger.kernel.org>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        open list <linux-kernel@vger.kernel.org>
References: <cover.1681764704.git.quic_nguyenb@quicinc.com>
 <5a52b255001e994d0a65be9b1d61fe69f2a12f6c.1681764704.git.quic_nguyenb@quicinc.com>
 <c3297d67-ac6f-e8b5-9167-648302319812@acm.org>
From:   "Bao D. Nguyen" <quic_nguyenb@quicinc.com>
In-Reply-To: <c3297d67-ac6f-e8b5-9167-648302319812@acm.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01a.na.qualcomm.com (10.52.223.231)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: N9ssHcotupDZbRzCQQd4GeNZn33mkr3t
X-Proofpoint-ORIG-GUID: N9ssHcotupDZbRzCQQd4GeNZn33mkr3t
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-05-04_01,2023-05-03_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 bulkscore=0 phishscore=0 adultscore=0 suspectscore=0
 spamscore=0 mlxscore=0 mlxlogscore=816 lowpriorityscore=0 impostorscore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2303200000 definitions=main-2305040035
X-Spam-Status: No, score=-6.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/25/2023 5:21 PM, Bart Van Assche wrote:
> On 4/17/23 14:05, Bao D. Nguyen wrote:
>> +        /* MCQ mode */
>> +        if (is_mcq_enabled(hba))
>> +            return ufshcd_clear_cmds(hba, 1UL << lrbp->task_tag);
> 
> The above code will trigger an overflow if lrbp->task_tag >= 8 * 
> sizeof(unsigned long). That's not acceptable.
This ufshcd_clear_cmds() uses a bit map. There are multiple places in 
the UFS code have this limitation if the queue depth grows to be greater 
than 64. I am thinking:
1. Current ufs controllers in the market probably support queue depth 64 
or less, so it may not be a problem today if host controller cap is set 
to 64 queue depth, but can be a problem in multiple places in the code 
later.
2. In mcq mode, we can pass a tag number into this api 
ufshcd_clear_cmds(); while in SDB mode, pass the tag's bit mask as before.
3. Use sbitmask() to support large queue depth? Thanks for any suggestions.

> 
>>   static irqreturn_t ufshcd_transfer_req_compl(struct ufs_hba *hba)
>>   {
>> +    struct ufshcd_lrb *lrbp;
>> +    u32 hwq_num, utag;
>> +    int tag;
>> +
>>       /* Resetting interrupt aggregation counters first and reading the
>>        * DOOR_BELL afterward allows us to handle all the completed 
>> requests.
>>        * In order to prevent other interrupts starvation the DB is 
>> read once
>> @@ -5580,7 +5590,22 @@ static irqreturn_t 
>> ufshcd_transfer_req_compl(struct ufs_hba *hba)
>>        * Ignore the ufshcd_poll() return value and return IRQ_HANDLED 
>> since we
>>        * do not want polling to trigger spurious interrupt complaints.
>>        */
>> -    ufshcd_poll(hba->host, UFSHCD_POLL_FROM_INTERRUPT_CONTEXT);
>> +    if (!is_mcq_enabled(hba)) {
>> +        ufshcd_poll(hba->host, UFSHCD_POLL_FROM_INTERRUPT_CONTEXT);
>> +        goto out;
>> +    }
>> +
>> +    /* MCQ mode */
>> +    for (tag = 0; tag < hba->nutrs; tag++) {
>> +        lrbp = &hba->lrb[tag];
>> +        if (lrbp->cmd) {
>> +            utag = blk_mq_unique_tag(scsi_cmd_to_rq(lrbp->cmd));
>> +            hwq_num = blk_mq_unique_tag_to_hwq(utag);
>> +            ufshcd_poll(hba->host, hwq_num);
>> +        }
>> +    }
> 
> Is my understanding correct that ufshcd_transfer_req_compl() is only 
> called from single doorbell code paths and hence that the above change 
> is not necessary?
ufshcd_transfer_req_compl() can be invoked from MCQ mode such as the 
ufshcd_err_handler() as below:
ufshcd_err_handler()-->ufshcd_complete_requests()-->ufshcd_transfer_req_compl()

> 
> 
>> +    if (is_mcq_enabled(hba)) {
>> +        struct ufshcd_lrb *lrbp;
>> +        int tag;
>> +
>> +        for (tag = 0; tag < hba->nutrs; tag++) {
>> +            lrbp = &hba->lrb[tag];
>> +            if (lrbp->cmd) {
>> +                ret = ufshcd_try_to_abort_task(hba, tag);
>> +                dev_err(hba->dev, "Aborting tag %d / CDB %#02x %s\n", 
>> tag,
>> +                    hba->lrb[tag].cmd ? hba->lrb[tag].cmd->cmnd[0] : -1,
>> +                    ret ? "failed" : "succeeded");
>> +            }
>> +            if (ret) {
>> +                needs_reset = true;
>> +                goto out;
>> +            }
>> +        }
>> +    } else {
>> +        /* Clear pending transfer requests */
>> +        for_each_set_bit(tag, &hba->outstanding_reqs, hba->nutrs) {
>> +            ret = ufshcd_try_to_abort_task(hba, tag);
>> +            dev_err(hba->dev, "Aborting tag %d / CDB %#02x %s\n", tag,
>> +                hba->lrb[tag].cmd ? hba->lrb[tag].cmd->cmnd[0] : -1,
>> +                ret ? "failed" : "succeeded");
>> +            if (ret) {
>> +                needs_reset = true;
>> +                goto out;
>> +            }
>>           }
>>       }
> 
> Please introduce helper functions for the MCQ and SDB code paths such 
> that the nesting level of the above code is reduced.
Sure. I will change.

> 
> Thanks,
> 
> Bart.

