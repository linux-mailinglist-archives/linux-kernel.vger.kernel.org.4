Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C7B1F5B6016
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Sep 2022 20:19:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229597AbiILST1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Sep 2022 14:19:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229668AbiILSTW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Sep 2022 14:19:22 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26B3E42AC1;
        Mon, 12 Sep 2022 11:19:22 -0700 (PDT)
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 28CFkEPi032703;
        Mon, 12 Sep 2022 18:18:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=R5hKuMdv6LMrIyP1zvUTwecK/eE0/c7+ayjM1uGMEGk=;
 b=NgleLbSRkfoZiMw0m1CYisl5GuvOhNOcIt84pwBZCeSk7mLnbdsKrdhvuH5xiGxc6MpX
 sIT/iOblNoxwE3NwCMcguirqg4pFrrQvpLQ0WRP93n+KLoutYwUBhTbMb6UPKj+x7uKn
 q61yF4K8KYWsav2NVAZ8rH9OUfgnARfNsL7KDuZ9+BKXbQf4/T+z+c0lQ1aVHDlH1Ab1
 i9IXgpjYR0jm/sDsRQphnoo7U9nAmCEq5fDWNvE8o/YQAYmq+W+Yqt1B0VhShzw2VwIn
 gE+X7tJCLbIv1PECwFnIMA0fHqdsfX/8M3hA719uyS7v7Jq1VOs9a45bOJHPQhzKR4rE 3w== 
Received: from nasanppmta01.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3jgkve5u4e-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 12 Sep 2022 18:18:58 +0000
Received: from nasanex01a.na.qualcomm.com (corens_vlan604_snip.qualcomm.com [10.53.140.1])
        by NASANPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 28CIIwlI022551
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 12 Sep 2022 18:18:58 GMT
Received: from [10.46.161.58] (10.80.80.8) by nasanex01a.na.qualcomm.com
 (10.52.223.231) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.29; Mon, 12 Sep
 2022 11:18:57 -0700
Message-ID: <7b513cc3-b218-fe57-1d24-6a10b225b6da@quicinc.com>
Date:   Mon, 12 Sep 2022 11:18:57 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.1
Subject: Re: [RFC PATCH v3 1/4] ufs: core: prepare ufs for multi circular
 queue support
To:     Bart Van Assche <bvanassche@acm.org>, <quic_nguyenb@quicinc.com>,
        <quic_xiaosenh@quicinc.com>, <stanley.chu@mediatek.com>,
        <adrian.hunter@intel.com>, <avri.altman@wdc.com>,
        <mani@kernel.org>, <quic_cang@quicinc.com>, <beanhuo@micron.com>,
        <martin.petersen@oracle.com>, <linux-scsi@vger.kernel.org>
CC:     <linux-arm-msm@vger.kernel.org>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        open list <linux-kernel@vger.kernel.org>
References: <cover.1662157846.git.quic_asutoshd@quicinc.com>
 <757bbfe36629b7c31ef2630971f8678a7801223f.1662157846.git.quic_asutoshd@quicinc.com>
 <37d36dd9-f467-233c-babd-4e7c1c953c6c@acm.org>
 <4ef3ee8f-1210-3a03-da14-1bfdf6def297@quicinc.com>
 <c85af2ae-42b2-89e4-0dc1-17658379ac3a@acm.org>
From:   "Asutosh Das (asd)" <quic_asutoshd@quicinc.com>
In-Reply-To: <c85af2ae-42b2-89e4-0dc1-17658379ac3a@acm.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01a.na.qualcomm.com (10.52.223.231)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: LyWqzIGMq7EyProtKPnGTRc0yOjKfsf9
X-Proofpoint-GUID: LyWqzIGMq7EyProtKPnGTRc0yOjKfsf9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-09-12_12,2022-09-12_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 clxscore=1015
 adultscore=0 mlxlogscore=999 spamscore=0 suspectscore=0 bulkscore=0
 impostorscore=0 malwarescore=0 lowpriorityscore=0 phishscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2207270000 definitions=main-2209120063
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/9/2022 4:38 PM, Bart Van Assche wrote:
> On 9/9/22 15:48, Asutosh Das (asd) wrote:
>> Hello Bart,
>> Thanks for the comments.
>>
>> On 9/8/2022 2:58 PM, Bart Van Assche wrote:
>>> On 9/2/22 15:41, Asutosh Das wrote:
>>>> Preparatory changes for upcoming multi circular queue.
>>>
>>> One patch per change please and also describe each individual change. 
>>>  From 
>>> https://www.kernel.org/doc/html/latest/process/submitting-patches.html#split-changes: "Separate each logical change into a separate patch".
>>>
>> The intent of this change was to have all the non-mcq related changes 
>> to the ufshcd as a separate patch.
>> I would add more details to the commit message of this change.
>> If there's anything specific in this patch that may need changes, 
>> please let me know.
> 
> Please follow the "one change per patch" rule. This is a widely followed 
> rule in the Linux kernel community. This rule exists because it is the 
> responsibility of the developer(s) who post a patch series to make it 
> easy for reviewers to review their work.
> 
Let me review and restructure the code and push it again.
I would like to remove the RFC tag in the next version.
Please let me know if that's _not_ OK.

> Thanks,
> 
> Bart.

