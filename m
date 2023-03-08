Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F87E6B1531
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Mar 2023 23:37:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230092AbjCHWh2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Mar 2023 17:37:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229525AbjCHWh1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Mar 2023 17:37:27 -0500
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED52565460;
        Wed,  8 Mar 2023 14:37:25 -0800 (PST)
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 328Lupav015496;
        Wed, 8 Mar 2023 22:37:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=ngea5itn2PRHnG9Bc1YLjFtw8iaYKohomeLhBkd2C7c=;
 b=plX2UNx21H/FvW/kkh0Mnk1zaesasKk5BYnh4fqQxv6P8SABxyJw0GCbtiRldKdnAoj8
 c6Oh4RBZ8Ep927PtJeBv2luRvpiEnS51MSfV91kbD+yJ1fcU5C4LOTdxvfZKYRyZ/BTc
 kESzaAXlfFFJQc35/bQMjLJSqFrFbqQ9GKHMb/0pKkhhskt6y49wJ7nJRkQfX6JYc0Cy
 XkgEG/h94vj6zsR0d2xm/EcD+F2WgvKDphM8M835q7+ySFwCd5+gFabLU2V2CS7m1Dv2
 8hNiNljE0A1G68LO8JAnAH0XQax7P9dSjdW9UlX18VtaQfdI7D2lPepBCs086dRC/LgO uA== 
Received: from nasanppmta05.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3p72qar2b3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 08 Mar 2023 22:37:04 +0000
Received: from nasanex01a.na.qualcomm.com ([10.52.223.231])
        by NASANPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 328Mb3iR019155
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 8 Mar 2023 22:37:03 GMT
Received: from [192.168.143.77] (10.80.80.8) by nasanex01a.na.qualcomm.com
 (10.52.223.231) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Wed, 8 Mar 2023
 14:37:03 -0800
Message-ID: <ec627f76-380b-bdfd-e736-1626d5bde0e4@quicinc.com>
Date:   Wed, 8 Mar 2023 14:37:02 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [RFC PATCH v1 4/4] ufs: mcq: Added ufshcd_mcq_abort()
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
References: <cover.1678247309.git.quic_nguyenb@quicinc.com>
 <c7fcbb70f0e74d225c1a09f107ba1058270739be.1678247309.git.quic_nguyenb@quicinc.com>
 <85994527-d09d-f381-3dda-7cfb9ce98d4b@acm.org>
From:   "Bao D. Nguyen" <quic_nguyenb@quicinc.com>
In-Reply-To: <85994527-d09d-f381-3dda-7cfb9ce98d4b@acm.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01a.na.qualcomm.com (10.52.223.231)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: UlNTLqGm8QTih0AwmmEQuOMzwQbdmbSe
X-Proofpoint-ORIG-GUID: UlNTLqGm8QTih0AwmmEQuOMzwQbdmbSe
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-08_15,2023-03-08_03,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 adultscore=0 impostorscore=0 suspectscore=0 clxscore=1015 bulkscore=0
 mlxlogscore=804 spamscore=0 mlxscore=0 phishscore=0 lowpriorityscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2303080189
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/8/2023 11:02 AM, Bart Van Assche wrote:
> On 3/7/23 20:01, Bao D. Nguyen wrote:
>> +    if (ufshcd_mcq_cqe_search(hba, hwq, tag)) {
>> +        dev_err(hba->dev, "%s: cmd found in cq. hwq=%d, tag=%d\n",
>> +                __func__, hwq->id, tag);
>> +        /*
>> +         * The command should not be 'stuck' in the CQ for such a 
>> long time.
>> +         * Is interrupt missing? Process the CQEs here. If the 
>> interrupt is
>> +         * invoked at a later time, the CQ will be empty because the 
>> CQEs
>> +         * are already processed here.
>> +         */
>> +        ufshcd_mcq_poll_cqe_lock(hba, hwq);
>> +        err = SUCCESS;
>> +        goto out;
>> +    }
>
> Please remove the above code and also the definition of the 
> ufshcd_mcq_cqe_search() function. The SCSI error handler submits an 
> abort to deal with command processing timeouts. 
> ufshcd_mcq_cqe_search() can only return true in case of a software bug 
> at the host side. Addressing such bugs is out of scope for the SCSI 
> error handler.

This is an attempt to handle the error case similar to SDB mode where it 
prints "%s: cmd was completed, but without a notifying intr, tag = %d" 
in the ufshcd_abort() function.

In this case the command has been completed by the hardware, but some 
reasons the software has not processed it. We have seen this print 
happened during debug sessions, so the error case does happen in SBL mode.

Are you suggesting we should return error in this case without calling 
ufshcd_mcq_poll_cqe_lock()?

Thanks.

>
>
> Thanks,
>
> Bart.


