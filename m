Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4DBCF6B1516
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Mar 2023 23:28:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230319AbjCHW2W (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Mar 2023 17:28:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229959AbjCHW2T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Mar 2023 17:28:19 -0500
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5395426CC1;
        Wed,  8 Mar 2023 14:28:06 -0800 (PST)
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 328MFBmo018768;
        Wed, 8 Mar 2023 22:27:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=BHijq9f2rn9kqYQDjhBAzcS08yGketxNfDi37LTBYI8=;
 b=b+qQs6OFTrgAlIDT2ykrNXyfpMD9TpFx6ZSb6Lz8pbgFUeatQkEhvyJXYmXSa+G2czE5
 qvDY5JMQZ+B07qr1+bePlZPyTV1qQX682WJdQbmBPkaLPNxlZY2YTy0Ynv5g5NnRKwPk
 aLKZfuy507Qt/2dGaHuN+/MY18Wh8Vb1gh8kZt3FtUPVAYeyiJfBDJwd33Dx6zUvmvaJ
 6Xz4kKAeK3SJAH0AA+BJ/Xlgx9gSv1OLPUkQXl3a7cE+VzrEG+FZHfzJ1LESSgyE4Jw+
 gWU2+VpFAkeG6np75NlOV12b3kI/XTxjWhLd6FVRPZUakX44tdlfV2i/LKWGA9NRbbWD gg== 
Received: from nasanppmta03.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3p6fgh3343-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 08 Mar 2023 22:27:49 +0000
Received: from nasanex01a.na.qualcomm.com ([10.52.223.231])
        by NASANPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 328MRlhj021272
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 8 Mar 2023 22:27:48 GMT
Received: from [192.168.143.77] (10.80.80.8) by nasanex01a.na.qualcomm.com
 (10.52.223.231) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Wed, 8 Mar 2023
 14:27:47 -0800
Message-ID: <67d9218e-03c2-c0af-b5a6-6092a9299ea4@quicinc.com>
Date:   Wed, 8 Mar 2023 14:27:47 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [RFC PATCH v1 3/4] ufs: mcq: Add support for clean up mcq
 resources
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
References: <cover.1678247309.git.quic_nguyenb@quicinc.com>
 <392b790072c2307d366ac80b7552d5f09ae25dfc.1678247309.git.quic_nguyenb@quicinc.com>
 <30fea558-75bd-8d5c-b981-079fca5c1bf5@acm.org>
From:   "Bao D. Nguyen" <quic_nguyenb@quicinc.com>
In-Reply-To: <30fea558-75bd-8d5c-b981-079fca5c1bf5@acm.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01a.na.qualcomm.com (10.52.223.231)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: FoavutUcUEqmil4aCOPOQTdl1sueOCT9
X-Proofpoint-GUID: FoavutUcUEqmil4aCOPOQTdl1sueOCT9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-08_15,2023-03-08_03,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999 spamscore=0
 phishscore=0 priorityscore=1501 mlxscore=0 suspectscore=0 adultscore=0
 impostorscore=0 clxscore=1015 malwarescore=0 lowpriorityscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2303080189
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/8/2023 10:53 AM, Bart Van Assche wrote:
> On 3/7/23 20:01, Bao D. Nguyen wrote:
>>   static int ufshcd_clear_cmds(struct ufs_hba *hba, u32 mask)
>>   {
>>       unsigned long flags;
>> +    int err, result, tag;
>>   +    if (is_mcq_enabled(hba)) {
>> +        /*
>> +         * MCQ mode. Clean up the MCQ resources similar to
>> +         * what the ufshcd_utrl_clear() does for SDB mode.
>> +         */
>> +        flags = (unsigned long)mask;
>> +        for_each_set_bit(tag, &flags, hba->nutrs) {
>> +            err = ufshcd_mcq_sq_cleanup(hba, tag, &result);
>> +            if (err || result) {
>> +                dev_err(hba->dev, "%s: failed tag=%d. err=%d, 
>> result=%d\n",
>> +                    __func__, tag, err, result);
>> +                return FAILED;
>> +            }
>> +        }
>> +        return 0;
>> +    }
>
> Please change the type of the 'mask' argument from u32 into unsigned 
> long such that the assignment of 'mask' to 'flags' can be removed.
>
I will make the change in the next rev. Thank you.

> Thanks,
>
> Bart.


