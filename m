Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A2EBF6B3187
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Mar 2023 23:56:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230323AbjCIW44 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Mar 2023 17:56:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229910AbjCIW4y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Mar 2023 17:56:54 -0500
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B21F622113;
        Thu,  9 Mar 2023 14:56:53 -0800 (PST)
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 329MsJAj031474;
        Thu, 9 Mar 2023 22:56:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=JqMVd9UYPMSGxNcKuDmyvd2PQYOsJShLk7Q0FXb4cAA=;
 b=nLQoBXML9Pbi0LwoD1XjSh4bzfwHxFxahyTvA3tDDfxLjVDuIDAAYNJVdkl2x5nzvqGn
 CelN1QbndhCBY2BuUikm/w98VJcC8yKDbG9UV4skSe2/whs3CP6+YszGVvcZ3cstd4Fw
 u8u7QNigsmkrRKOH4wf7oaSK3jjv9DCoXMNLtfqhliJOH6KF4EM+/QB6hbSyBRK7cYao
 ajqVi3geIjYIPHf5DXj++ojwkrhDLDxaYaWpiy4NPnqRAWU4tfFOsrOyqxJF8j5cpj5I
 iU8xQZbKPL9FAgfSSrd4SbQEeb67PIQ7cnnPEzm+83vwgytC4H7fzTZ9ELPkToknIHaV eQ== 
Received: from nasanppmta04.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3p7nbd8g91-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 09 Mar 2023 22:56:26 +0000
Received: from nasanex01a.na.qualcomm.com ([10.52.223.231])
        by NASANPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 329MuPNa023982
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 9 Mar 2023 22:56:25 GMT
Received: from [192.168.143.77] (10.80.80.8) by nasanex01a.na.qualcomm.com
 (10.52.223.231) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Thu, 9 Mar 2023
 14:56:25 -0800
Message-ID: <c1237665-60a6-97ec-3b9d-6067853aea48@quicinc.com>
Date:   Thu, 9 Mar 2023 14:56:24 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [RFC PATCH v2 1/3] ufs: mcq: Add supporting functions for mcq
 abort
Content-Language: en-US
To:     Bart Van Assche <bvanassche@acm.org>, <quic_asutoshd@quicinc.com>,
        <quic_cang@quicinc.com>, <mani@kernel.org>,
        <stanley.chu@mediatek.com>, <adrian.hunter@intel.com>,
        <beanhuo@micron.com>, <avri.altman@wdc.com>,
        <martin.petersen@oracle.com>
CC:     <linux-scsi@vger.kernel.org>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        Arthur Simchaev <Arthur.Simchaev@wdc.com>,
        open list <linux-kernel@vger.kernel.org>
References: <cover.1678338926.git.quic_nguyenb@quicinc.com>
 <68b786f390dbd93218a482d18c513bc332e82da3.1678338926.git.quic_nguyenb@quicinc.com>
 <1ca7dbef-5747-29c2-a11c-086cf36d636f@acm.org>
 <821e6994-9fed-2c15-6c25-b1761a267ec9@quicinc.com>
 <a7970fd0-ee6f-f1c1-e8c4-6ee42237a567@acm.org>
From:   "Bao D. Nguyen" <quic_nguyenb@quicinc.com>
In-Reply-To: <a7970fd0-ee6f-f1c1-e8c4-6ee42237a567@acm.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01a.na.qualcomm.com (10.52.223.231)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: IKO4PvGpm3KrtErwCR6QFYnFNXvekRfg
X-Proofpoint-ORIG-GUID: IKO4PvGpm3KrtErwCR6QFYnFNXvekRfg
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-09_12,2023-03-09_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501 mlxscore=0
 mlxlogscore=999 impostorscore=0 malwarescore=0 clxscore=1015 adultscore=0
 lowpriorityscore=0 bulkscore=0 spamscore=0 phishscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2212070000
 definitions=main-2303090183
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/9/2023 2:54 PM, Bart Van Assche wrote:
> On 3/9/23 14:47, Bao D. Nguyen wrote:
>> On 3/9/2023 10:15 AM, Bart Van Assche wrote:
>>> On 3/8/23 21:28, Bao D. Nguyen wrote:
>>>> +static inline bool ufshcd_mcq_is_sq_empty(struct ufs_hw_queue *q)
>>>> +{
>>>> +    return q->sq_head_slot == q->sq_tail_slot;
>>>> +}
>>>
>>> Please remove this function and inline this function into its callers.
>>
>> Same comment. Should I also update the existing 
>> ufshcd_mcq_is_cq_empty() in a separate patch together with 
>> ufshcd_mcq_update_cq_tail_slot(), ufshcd_mcq_update_cq_head() 
>> mentioned above?
>
> Hi Bao,
>
> Modifying the existing code may improve uniformity of the UFS host 
> controller driver. If any existing code is refactored, please do that 
> via a separate patch.
Thanks Bart. I will make that change in a separate patch.
>
> Thanks,
>
> Bart.
>

