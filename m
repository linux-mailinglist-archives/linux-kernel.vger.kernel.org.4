Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DD0736F63DB
	for <lists+linux-kernel@lfdr.de>; Thu,  4 May 2023 06:07:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229731AbjEDEG6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 May 2023 00:06:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229530AbjEDEG4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 May 2023 00:06:56 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED5BC19A8;
        Wed,  3 May 2023 21:06:54 -0700 (PDT)
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3442wD1t022553;
        Thu, 4 May 2023 04:01:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=J7dM4YfP2Cn22FfC54o6HXBvZDJbbsBila3/VvkxwQ0=;
 b=PUFwU4UW4dNXAUmEfCoryfUMPOcrtcv4CAKyxowgtfdT63Iy6fb7uzUWkh1mBQjH3HmS
 nCJNgJqTWcrpZIdJWi2tt1R7PjlpwDuLLbNDApQhPFYemOh2wTtsYso6MBYt4v0SVTks
 mr037YN7fClXiHqalrG5iGlG8QA+yK5JJZF+t+5ZcUY7Mlv/JIeF/Vz/yLJU08WdOHtK
 jx3VTLMVXah59+fbFMUBML7jw4jriEMWKwXLJCvz8KRFgp4/FydkGB+Za5aK/JnIOBcv
 m8Q4ycDZptdqbNnEBwNm8ADPlKbDhPsVgN19Gxcu8U2qAyXgrMHXtkshkTfObOq4wA3U sw== 
Received: from nasanppmta05.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3qbmy49ytt-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 04 May 2023 04:01:27 +0000
Received: from nasanex01a.na.qualcomm.com (nasanex01a.na.qualcomm.com [10.52.223.231])
        by NASANPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 34441Qsi022326
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 4 May 2023 04:01:26 GMT
Received: from [192.168.143.77] (10.80.80.8) by nasanex01a.na.qualcomm.com
 (10.52.223.231) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.42; Wed, 3 May 2023
 21:01:26 -0700
Message-ID: <b1af6459-43b7-d193-c6e7-37f24d7349e6@quicinc.com>
Date:   Wed, 3 May 2023 21:01:25 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH v2 2/5] ufs: mcq: Add support for clean up mcq resources
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
 <5e662692bc0ad5108ce91ae3d1ec2b575c34d4ae.1681764704.git.quic_nguyenb@quicinc.com>
 <12308ca3-f824-596e-078f-bc00fa674aef@acm.org>
From:   "Bao D. Nguyen" <quic_nguyenb@quicinc.com>
In-Reply-To: <12308ca3-f824-596e-078f-bc00fa674aef@acm.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01a.na.qualcomm.com (10.52.223.231)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: aFEuaGkgD6p-cENCvp6dUp53kCzpc-e_
X-Proofpoint-GUID: aFEuaGkgD6p-cENCvp6dUp53kCzpc-e_
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-05-04_01,2023-05-03_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 bulkscore=0 priorityscore=1501 malwarescore=0 suspectscore=0
 impostorscore=0 adultscore=0 mlxlogscore=999 spamscore=0 phishscore=0
 clxscore=1015 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2303200000 definitions=main-2305040032
X-Spam-Status: No, score=-6.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/25/2023 5:08 PM, Bart Van Assche wrote:
> On 4/17/23 14:05, Bao D. Nguyen wrote:
>> @@ -3110,7 +3128,7 @@ static int ufshcd_wait_for_dev_cmd(struct 
>> ufs_hba *hba,
>>           err = -ETIMEDOUT;
>>           dev_dbg(hba->dev, "%s: dev_cmd request timedout, tag %d\n",
>>               __func__, lrbp->task_tag);
>> -        if (ufshcd_clear_cmds(hba, 1U << lrbp->task_tag) == 0) {
>> +        if (ufshcd_clear_cmds(hba, 1UL << lrbp->task_tag) == 0) {
>>               /* successfully cleared the command, retry if needed */
>>               err = -EAGAIN;
>>               /*
> 
> Is this change necessary?
My intention was to support tag greater than 31 and less than 64.
The 1U << only works up to 32 bits.

> 
>> @@ -7379,6 +7397,20 @@ static int ufshcd_try_to_abort_task(struct 
>> ufs_hba *hba, int tag)
>>                */
>>               dev_err(hba->dev, "%s: cmd at tag %d not pending in the 
>> device.\n",
>>                   __func__, tag);
>> +            if (is_mcq_enabled(hba)) {
>> +                /* MCQ mode */
>> +                if (lrbp->cmd) {
>> +                    /* sleep for max. 200us to stabilize */
> 
> What is being stabilized here? Please make this comment more clear.
This is to keep the same operation/timing as in SDB mode.

> 
>> +                    usleep_range(100, 200);
>> +                    continue;
>> +                }
>> +                /* command completed already */
>> +                dev_err(hba->dev, "%s: cmd at tag=%d is cleared.\n",
>> +                    __func__, tag);
>> +                goto out;
>> +            }
> 
> Please do not use lrbp->cmd to check whether or not a command has 
> completed. See also my patch "scsi: ufs: Fix handling of lrbp->cmd".
I have been thinking how to replace lrbp->cmd, but could not find a good 
solution. Throughout this patch series, I am using lrbp->cmd as a way to 
find the pending command that is being aborted and clean up the 
resources associated with it. Any suggestions to achieve it? Thanks.

> 
>> @@ -7415,7 +7447,7 @@ static int ufshcd_try_to_abort_task(struct 
>> ufs_hba *hba, int tag)
>>           goto out;
>>       }
>> -    err = ufshcd_clear_cmds(hba, 1U << tag);
>> +    err = ufshcd_clear_cmds(hba, 1UL << tag);
>>       if (err)
>>           dev_err(hba->dev, "%s: Failed clearing cmd at tag %d, err 
>> %d\n",
>>               __func__, tag, err);
> 
> Is this change necessary?
Same as above, I intended  to support 64 > tag > 31

> 
>> -    if (!(test_bit(tag, &hba->outstanding_reqs))) {
>> +    if (!is_mcq_enabled(hba) && !(test_bit(tag, 
>> &hba->outstanding_reqs))) {
> 
> Please leave out one pair of superfluous parentheses from the above 
> expression.
Yes, I will change.

> 
> Thanks,
> 
> Bart.

