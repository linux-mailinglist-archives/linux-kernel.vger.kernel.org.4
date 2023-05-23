Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D0C4470D472
	for <lists+linux-kernel@lfdr.de>; Tue, 23 May 2023 08:59:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235302AbjEWG7j (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 May 2023 02:59:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235243AbjEWG7c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 May 2023 02:59:32 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DEAEC119;
        Mon, 22 May 2023 23:59:30 -0700 (PDT)
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 34N5wRZp003873;
        Tue, 23 May 2023 06:59:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=Ex1tFxvKrAnpGLQRQ3xEj2hakDnV5kwPAUrcxK4mQsI=;
 b=ZruPuJCtWanF7CwfQcjXF9ptTGyrWWC1pTET0BsUMdfAo3WCvuEAmCfcMQcGAlsr30mZ
 np4urwGv/ado1BliI2rz7sxrOe7UlOUOnk39yN30rbUWeA0Ppb6uVXvousqHWSnvVHYg
 t0Ffrnehp5Yebgf0CJSd7Fyf155DFQffsnrJ5fhoYcuCHZvwGfvQzK/Afn3tf5aVObvh
 Abtun+LdQqJwe0nxrsLfhcGFNl+OTfw+GnwJs5Q4ULDJSQsTD66BUaGr1LAKM2Yq9OJ0
 TQvhLEs+c59504mFMYbh4Xe0aO6lusgNh+WrcYMiPRWCmd9RYNTIwxANVmCrveXGNWJa aA== 
Received: from nasanppmta05.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3qrf778wtn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 23 May 2023 06:59:01 +0000
Received: from nasanex01a.na.qualcomm.com (nasanex01a.na.qualcomm.com [10.52.223.231])
        by NASANPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 34N6x0og015738
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 23 May 2023 06:59:00 GMT
Received: from [192.168.143.77] (10.80.80.8) by nasanex01a.na.qualcomm.com
 (10.52.223.231) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.42; Mon, 22 May
 2023 23:58:59 -0700
Message-ID: <1e99521e-1e15-b7ec-30be-1f6a86ea728f@quicinc.com>
Date:   Mon, 22 May 2023 23:58:59 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH v5 7/7] ufs: core: Add error handling for MCQ mode
Content-Language: en-US
To:     Bart Van Assche <bvanassche@acm.org>, <quic_asutoshd@quicinc.com>,
        <quic_cang@quicinc.com>, <mani@kernel.org>,
        <stanley.chu@mediatek.com>, <adrian.hunter@intel.com>,
        <beanhuo@micron.com>, <avri.altman@wdc.com>,
        <martin.petersen@oracle.com>
CC:     <linux-scsi@vger.kernel.org>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        open list <linux-kernel@vger.kernel.org>
References: <cover.1683872601.git.quic_nguyenb@quicinc.com>
 <7b884263c9db9a9666086a345ede85bb56d9dfc7.1683872601.git.quic_nguyenb@quicinc.com>
 <5065e9ca-d5ce-22fc-4089-651cfacb7166@acm.org>
From:   "Bao D. Nguyen" <quic_nguyenb@quicinc.com>
In-Reply-To: <5065e9ca-d5ce-22fc-4089-651cfacb7166@acm.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01a.na.qualcomm.com (10.52.223.231)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: IfqR3gXU64h5IlsWlu252i4gctquHXUk
X-Proofpoint-ORIG-GUID: IfqR3gXU64h5IlsWlu252i4gctquHXUk
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-05-23_03,2023-05-22_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 impostorscore=0
 bulkscore=0 clxscore=1015 priorityscore=1501 suspectscore=0
 lowpriorityscore=0 mlxlogscore=999 malwarescore=0 mlxscore=0 spamscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2304280000 definitions=main-2305230056
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/19/2023 4:03 PM, Bart Van Assche wrote:
> On 5/11/23 23:28, Bao D. Nguyen wrote:
>> @@ -6378,18 +6407,36 @@ static bool ufshcd_abort_all(struct ufs_hba *hba)
>>       bool needs_reset = false;
>>       int tag, ret;
>> -    /* Clear pending transfer requests */
>> -    for_each_set_bit(tag, &hba->outstanding_reqs, hba->nutrs) {
>> -        ret = ufshcd_try_to_abort_task(hba, tag);
>> -        dev_err(hba->dev, "Aborting tag %d / CDB %#02x %s\n", tag,
>> -            hba->lrb[tag].cmd ? hba->lrb[tag].cmd->cmnd[0] : -1,
>> -            ret ? "failed" : "succeeded");
>> -        if (ret) {
>> -            needs_reset = true;
>> -            goto out;
>> +    if (is_mcq_enabled(hba)) {
>> +        struct ufshcd_lrb *lrbp;
>> +        int tag;
>> +
>> +        for (tag = 0; tag < hba->nutrs; tag++) {
>> +            lrbp = &hba->lrb[tag];
>> +            if (!ufshcd_cmd_inflight(lrbp->cmd))
>> +                continue;
>> +            ret = ufshcd_try_to_abort_task(hba, tag);
>> +            dev_err(hba->dev, "Aborting tag %d / CDB %#02x %s\n", tag,
>> +                hba->lrb[tag].cmd ? hba->lrb[tag].cmd->cmnd[0] : -1,
>> +                ret ? "failed" : "succeeded");
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
> Please move the ufshcd_cmd_inflight() check into ufshcd_try_to_abort_task()
> such that the same code path can be used for MCQ and legacy mode.
Hi Bart,
Because the ufshcd_try_to_abort_task() is shared by sdb and mcq modes, I 
feel a bit uncomfortable using the new function ufshcd_cmd_inflight() in 
ufshcd_try_to_abort_task(). In this patch series, I am trying to avoid 
changing the sdb error handling logic as much as possible; only add 
error handling support for mcq mode. If you feel there is a very good 
benefit in making the change, I would give it a try. Otherwise, I would 
prefer not touching sdb error handling code that has been working well. 
Please let me know.

Thanks,
Bao

> 
> Thanks,
> 
> Bart.

