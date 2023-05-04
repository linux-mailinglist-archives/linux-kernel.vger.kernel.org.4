Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 36C126F63DE
	for <lists+linux-kernel@lfdr.de>; Thu,  4 May 2023 06:10:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229671AbjEDEJ6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 May 2023 00:09:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229460AbjEDEJz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 May 2023 00:09:55 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3FC6D19A8;
        Wed,  3 May 2023 21:09:52 -0700 (PDT)
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3443iRd3014311;
        Thu, 4 May 2023 04:04:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=O3rCoIUVOuMd/J6NZAZDJjYENECHYw2yvu3cGgy6tA0=;
 b=i4Ll03Qks6DVsj6iJy6Uux9UB5nWIRQCP1vQ3swNuVALcFi4lA8Fo84mnnX5aXrnOiOf
 9SoDJ/kCWAZOGe/fM2JsIfzGTdkxDGB/NAPN3RItCiC51kYKikjD+/+PBeit4ABb8cw/
 6d2u7cl9YWKic7Rge7fOzqHGd2ZrPLG56Ln3U1ygudUZ5Ye32IG9vUoZLgmdGrzzafWj
 FMAT0+Xvimp0QCszd1JXk2vVjfXD922QpFRN+DhT9bi6F5WUXsp/q52eEaLplZ6jnbBF
 edkVFTPvDDefFYxoYWR5N5YbAiG52NDzRgfDghA/3d1SXrR3g9/9eqV62OoTQ2JkdW0x +A== 
Received: from nasanppmta03.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3qc1eurcq3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 04 May 2023 04:04:10 +0000
Received: from nasanex01a.na.qualcomm.com (nasanex01a.na.qualcomm.com [10.52.223.231])
        by NASANPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 344448J9011603
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 4 May 2023 04:04:08 GMT
Received: from [192.168.143.77] (10.80.80.8) by nasanex01a.na.qualcomm.com
 (10.52.223.231) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.42; Wed, 3 May 2023
 21:04:08 -0700
Message-ID: <c4b58912-d22e-9c35-3861-377cc78e7694@quicinc.com>
Date:   Wed, 3 May 2023 21:04:08 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH v2 3/5] ufs: mcq: Added ufshcd_mcq_abort()
Content-Language: en-US
To:     Bart Van Assche <bvanassche@acm.org>, <quic_asutoshd@quicinc.com>,
        <quic_cang@quicinc.com>, <mani@kernel.org>,
        <Powen.Kao@mediatek.com>, <stanley.chu@mediatek.com>,
        <adrian.hunter@intel.com>, <beanhuo@micron.com>,
        <avri.altman@wdc.com>, <martin.petersen@oracle.com>
CC:     <linux-scsi@vger.kernel.org>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        Arthur Simchaev <Arthur.Simchaev@wdc.com>,
        open list <linux-kernel@vger.kernel.org>
References: <cover.1681764704.git.quic_nguyenb@quicinc.com>
 <349ea681e56578191da834250cebfbd7859e9216.1681764704.git.quic_nguyenb@quicinc.com>
 <53f22b81-a738-8f94-8e08-2395133d0249@acm.org>
From:   "Bao D. Nguyen" <quic_nguyenb@quicinc.com>
In-Reply-To: <53f22b81-a738-8f94-8e08-2395133d0249@acm.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01a.na.qualcomm.com (10.52.223.231)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: 0fevYLIal4BHIgJtudMy7tQPiVl_BHy2
X-Proofpoint-GUID: 0fevYLIal4BHIgJtudMy7tQPiVl_BHy2
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-05-03_16,2023-05-03_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 spamscore=0 adultscore=0 malwarescore=0 phishscore=0 mlxscore=0
 suspectscore=0 clxscore=1015 mlxlogscore=999 priorityscore=1501
 impostorscore=0 bulkscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2303200000 definitions=main-2305040032
X-Spam-Status: No, score=-6.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/25/2023 5:12 PM, Bart Van Assche wrote:
> On 4/17/23 14:05, Bao D. Nguyen wrote:
>> +    if (!lrbp->cmd) {
>> +        dev_err(hba->dev,
>> +            "%s: skip abort. cmd at tag %d already completed.\n",
>> +            __func__, tag);
>> +        goto out;
>> +    }
> 
> Please do not use lrbp->cmd to check whether or not a command has 
> completed.
Yes. Same comment as in patch #2.

> 
>> +    if (ufshcd_mcq_sqe_search(hba, hwq, tag)) {
>> +        /*
>> +         * Failure. The command should not be "stuck" in SQ for
>> +         * a long time which resulted in command being aborted.
>> +         */
>> +        dev_err(hba->dev, "%s: cmd found in sq. hwq=%d, tag=%d\n",
>> +                __func__, hwq->id, tag);
>> +        /* Set the Command Type to 0xF per the spec */
>> +        ufshcd_mcq_nullify_cmd(hba, hwq);
> 
> The above looks wrong to me. How can ufshcd_mcq_nullify_cmd() identify a 
> command if the 'tag' argument is not passed to that function?
Same comment as in patch #1. I will change this function.

>  >> +    /*
>> +     * The command is not in the Submission Queue, and it is not
>> +     * in the Completion Queue either. Query the device to see if
>> +     * the command is being processed in the device.
>> +     */
> 
> Please only use capitals if these are required.
Yes, I will change.

> 
>> +    if (lrbp->cmd)
>> +        ufshcd_release_scsi_cmd(hba, lrbp);
> 
> Same comment here - do not use lrbp->cmd to check for completion.
Yes.

> 
> Thanks,
> 
> Bart.

