Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B52E6A3964
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Feb 2023 04:15:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230061AbjB0DPO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 26 Feb 2023 22:15:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229723AbjB0DPN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Feb 2023 22:15:13 -0500
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 706ACC65B;
        Sun, 26 Feb 2023 19:15:11 -0800 (PST)
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 31R2QlD3002025;
        Mon, 27 Feb 2023 03:14:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=KpqWmeVWmsOLm8pVxOCJXGWeNurXRtlo3K3msDyonpI=;
 b=eP0bjr4xk9A4Hlw/BQq30VELfrCEB0uc4rOXdVtUMHAHKkpFoD+XG+UUCgdkGsbVGkjy
 qMBAXkdWMfoNYQG5PTTpt4bvRz1pNzIaY1J4XAYIpcn6tSWkJIacc0I2NKQEdoHBXwvO
 xj9XThTMa4859kzb4CpsS8JtfSRAP0cNx0WV104EGTyT6YwIRVwlsUa+KhtlZ20URqrn
 Q7FQxG36uFZ7mMZYctu4mo8pSNIFOgkHEp+g9ZqNWRF/VoSMLzLseEP7gLJq0Dnh4VUG
 H/nx9afBJR7nC+dCa3it3drqFzFZaQLOfrGel6EXeo5jKveHa0X2tW/GYSRRLyz5EKYV TA== 
Received: from nasanppmta04.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3ny9bfbh84-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 27 Feb 2023 03:14:42 +0000
Received: from nasanex01a.na.qualcomm.com ([10.52.223.231])
        by NASANPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 31R3Ef1Z013824
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 27 Feb 2023 03:14:41 GMT
Received: from [10.239.155.136] (10.80.80.8) by nasanex01a.na.qualcomm.com
 (10.52.223.231) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Sun, 26 Feb
 2023 19:14:35 -0800
Message-ID: <0c17dd26-b1aa-54b0-6dc4-561cd996cead@quicinc.com>
Date:   Mon, 27 Feb 2023 11:14:33 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [PATCH v2 4/7] scsi: ufs: core: Add hwq print for debug
Content-Language: en-US
To:     =?UTF-8?B?UG93ZW4gS2FvICjpq5jkvK/mlocp?= <Powen.Kao@mediatek.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mediatek@lists.infradead.org" 
        <linux-mediatek@lists.infradead.org>,
        "jejb@linux.ibm.com" <jejb@linux.ibm.com>,
        "avri.altman@wdc.com" <avri.altman@wdc.com>,
        "bvanassche@acm.org" <bvanassche@acm.org>,
        "martin.petersen@oracle.com" <martin.petersen@oracle.com>,
        "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
        "alim.akhtar@samsung.com" <alim.akhtar@samsung.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "matthias.bgg@gmail.com" <matthias.bgg@gmail.com>,
        <quic_nguyenb@quicinc.com>
CC:     =?UTF-8?B?UGV0ZXIgV2FuZyAo546L5L+h5Y+LKQ==?= 
        <peter.wang@mediatek.com>,
        =?UTF-8?B?RWRkaWUgSHVhbmcgKOm7g+aZuuWCkSk=?= 
        <eddie.huang@mediatek.com>,
        =?UTF-8?B?SmlhamllIEhhbyAo6YOd5Yqg6IqCKQ==?= 
        <jiajie.hao@mediatek.com>,
        =?UTF-8?B?Q0MgQ2hvdSAo5ZGo5b+X5p2wKQ==?= <cc.chou@mediatek.com>,
        =?UTF-8?B?QWxpY2UgQ2hhbyAo6LaZ54+u5Z2HKQ==?= 
        <Alice.Chao@mediatek.com>,
        wsd_upstream <wsd_upstream@mediatek.com>,
        =?UTF-8?B?Q2h1bi1IdW5nIFd1ICjlt6vpp7/lro8p?= 
        <Chun-hung.Wu@mediatek.com>,
        =?UTF-8?B?Q2hhb3RpYW4gSmluZyAo5LqV5pyd5aSpKQ==?= 
        <Chaotian.Jing@mediatek.com>,
        =?UTF-8?B?TmFvbWkgQ2h1ICjmnLHoqaDnlLAp?= <Naomi.Chu@mediatek.com>,
        =?UTF-8?B?U3RhbmxleSBDaHUgKOacseWOn+mZnik=?= 
        <stanley.chu@mediatek.com>,
        =?UTF-8?B?TWFzb24gWmhhbmcgKOeroOi+iSk=?= <Mason.Zhang@mediatek.com>,
        "quic_cang@quicinc.com" <quic_cang@quicinc.com>,
        "quic_asutoshd@quicinc.com" <quic_asutoshd@quicinc.com>
References: <20230222030427.957-1-powen.kao@mediatek.com>
 <20230222030427.957-5-powen.kao@mediatek.com>
 <1b9c2bc9-a349-062a-597c-336804c05394@quicinc.com>
 <74bedcff32df0c93c14b004814017f3344247528.camel@mediatek.com>
From:   Ziqi Chen <quic_ziqichen@quicinc.com>
In-Reply-To: <74bedcff32df0c93c14b004814017f3344247528.camel@mediatek.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01a.na.qualcomm.com (10.52.223.231)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: Bwjn2tfh64sBDZPbFxPnTOZQXEU6PQIF
X-Proofpoint-ORIG-GUID: Bwjn2tfh64sBDZPbFxPnTOZQXEU6PQIF
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.170.22
 definitions=2023-02-26_22,2023-02-24_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999
 priorityscore=1501 mlxscore=0 bulkscore=0 malwarescore=0 phishscore=0
 adultscore=0 spamscore=0 suspectscore=0 lowpriorityscore=0 impostorscore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2302270023
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi  Powen,

The Bao. D . Nguyen (quic_nguyenb@quicinc.com) from QCOM already made 
patch to support MCQ abort.

++ Bao here to be aware of it in case your error handing patch conflict 
with his abort handling patch.


Best Regards,

Ziqi


On 2/23/2023 10:13 PM, Powen Kao (高伯文) wrote:
> Hi Ziqi,
>
> Thanks for ur comments.
>
> This piece of code successfully dump relevent registers on our
> platform. As you know, mcq error handling flow is not ready yet so the
> insertion point might not seems to be reasonable.
>
> Maybe drop this patch for now, I will send it later with error handling
> patches.
>
>
> On Thu, 2023-02-23 at 18:14 +0800, Ziqi Chen wrote:
>> Hi Po-Wen,
>>
>> On 2/22/2023 11:04 AM, Po-Wen Kao wrote:
>>> +void ufshcd_mcq_print_hwqs(struct ufs_hba *hba, unsigned long
>>> bitmap)
>>> +{
>>> +	int id, i;
>>> +	char prefix[15];
>>> +
>>> +	if (!is_mcq_enabled(hba))
>>> +		return;
>>> +
>>> +	for_each_set_bit(id, &bitmap, hba->nr_hw_queues) {
>>> +		snprintf(prefix, sizeof(prefix), "q%d SQCFG: ", id);
>>> +		ufshcd_hex_dump(prefix,
>>> +			hba->mcq_base + MCQ_QCFG_SIZE * id,
>>> MCQ_QCFG_SQ_SIZE);
>> Is your purpose dump per hardware queue registers here?  If yes, why
>> don't use ufsmcq_readl() to save to a buffer and then use
>> ufshcd_hex_dump()
>>
>> to dump ? Are you sure ufshcd_hex_dump() can dump register directly?
>>
>>> +
>>> +		snprintf(prefix, sizeof(prefix), "q%d CQCFG: ", id);
>>> +		ufshcd_hex_dump(prefix,
>>> +			hba->mcq_base + MCQ_QCFG_SIZE * id +
>>> MCQ_QCFG_SQ_SIZE, MCQ_QCFG_CQ_SIZE);
>> Same to above comment.
>>> +
>>> +		for (i = 0; i < OPR_MAX ; i++) {
>>> +			snprintf(prefix, sizeof(prefix), "q%d OPR%d: ",
>>> id, i);
>>> +			ufshcd_hex_dump(prefix, mcq_opr_base(hba, i,
>>> id), mcq_opr_size[i]);
>> Same.
>>> +		}
>>> +	}
>>> +}
>>> +
>>>
>>>    
>>> @@ -574,7 +569,16 @@ void ufshcd_print_trs(struct ufs_hba *hba,
>>> unsigned long bitmap, bool pr_prdt)
>>>    		if (pr_prdt)
>>>    			ufshcd_hex_dump("UPIU PRDT: ", lrbp-
>>>> ucd_prdt_ptr,
>>>    				ufshcd_sg_entry_size(hba) *
>>> prdt_length);
>>> +
>>> +		if (is_mcq_enabled(hba)) {
>>> +			cmd = lrbp->cmd;
>>> +			if (!cmd)
>>> +				return;
>>> +			hwq = ufshcd_mcq_req_to_hwq(hba,
>>> scsi_cmd_to_rq(cmd));
>>> +			ufshcd_mcq_print_hwqs(hba, 1 << hwq->id);
>> Calling registers dump function in ufshcd_print_trs() is not
>> reasonable,
>> eg.. for each aborted request, it would print out all hwq registers,
>> it's not make sense.
>>
>> I think we should move it out of ufshcd_print_trs().
>>
>>> +		}
>>>    	}
>>> +
>>>    }
>>
>> Best Regards,
>>
>> Ziqi
>>
