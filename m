Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B77370A3F8
	for <lists+linux-kernel@lfdr.de>; Sat, 20 May 2023 02:13:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229634AbjETANE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 May 2023 20:13:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbjETANC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 May 2023 20:13:02 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02B77B2;
        Fri, 19 May 2023 17:13:00 -0700 (PDT)
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 34JNQj5c028573;
        Sat, 20 May 2023 00:11:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=+aIKSDiUh7Xd1IVewLZ1SCeNggWpleZofFlgVYOqUd0=;
 b=Zri8mOmekKwPrpDiM4nBed0R8BQYRM4CSxpor5MlkccnXcCWj3HisnPDGG1nYLerc0fW
 giIjvhbatnx1wIQyBdFCjoVLi8tAH9JUa7WMwavvNd4snXGpKjGiK6oWHh9/Icx/tR56
 Dp2ELXixVfqctYo5k+4S9m3SgYCg75bQ+ZiRzXATp1fmL9Zf0YdshG4qp3+vvAnrR04C
 YgLEn+DWc2DICb+bw7qvUISYpgPxYenFajyy6bt3g3GlHk1VQifouwIyCuD4JMdQsaZR
 yeTVyCmmkmqgvU+qLFnrOX4+pJdd84e2J1ykBERYVBzWr73Al/I21m/0GlkKrWM92iFd 8A== 
Received: from nasanppmta05.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3qp69u1w6p-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sat, 20 May 2023 00:11:55 +0000
Received: from nasanex01a.na.qualcomm.com (nasanex01a.na.qualcomm.com [10.52.223.231])
        by NASANPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 34K0BsZk007181
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sat, 20 May 2023 00:11:54 GMT
Received: from [192.168.143.77] (10.80.80.8) by nasanex01a.na.qualcomm.com
 (10.52.223.231) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.42; Fri, 19 May
 2023 17:11:53 -0700
Message-ID: <0b7cccc6-df1f-8720-0704-4eb7bc2e781b@quicinc.com>
Date:   Fri, 19 May 2023 17:11:53 -0700
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
X-Proofpoint-ORIG-GUID: TFdIxCNFuF6HmGND1adjxhg5HDYIxZUX
X-Proofpoint-GUID: TFdIxCNFuF6HmGND1adjxhg5HDYIxZUX
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-05-19_18,2023-05-17_02,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 malwarescore=0
 bulkscore=0 adultscore=0 mlxlogscore=999 spamscore=0 suspectscore=0
 impostorscore=0 priorityscore=1501 clxscore=1015 mlxscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2304280000 definitions=main-2305190208
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
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
Thank you, Bart.
I will make the change.

Thanks
Bao

> 
> Thanks,
> 
> Bart.

