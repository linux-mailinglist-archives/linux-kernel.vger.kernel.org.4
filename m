Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D3E655B42A2
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Sep 2022 00:48:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230240AbiIIWsx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Sep 2022 18:48:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231298AbiIIWss (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Sep 2022 18:48:48 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DCF12100421;
        Fri,  9 Sep 2022 15:48:43 -0700 (PDT)
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 289MCdE8013639;
        Fri, 9 Sep 2022 22:48:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=vJqz4Sf2ynYKhog3L8aleacU7e4uBAMVgmldEM6Ws2s=;
 b=Lik72sw9MqN8g15Nr6f/D8TZXztwX6cMPNdWmZjZeSM6ejNmoW8EYqFAX7jxViNxakkj
 YtzLsc4xDUdmmO/WweAHCY1BoHgiNHTjRhpEmkbM900F/F+qtNI6f3s7C8DWp3w27Ofr
 ClVxzfrVoFqvlmhqdiTxmSxB2/BtmvcX0rtFGp48TiCKtpZchLkkrEZxVQLMJXnTupjY
 VgZEPhAo2tLUDyGe4cdDBoYtK2ckOAaBUeO1dHifsg4/zZSWxqqyjl6awVBm5pU2NB6m
 nG+P3RMJ1ZgNXbQhxCFf7C5SjzPUa52VxvIr7qELO/c2QwCWFuLSTFnq3d3tAoUWhfCA Sg== 
Received: from nasanppmta05.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3jg68c1kfr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 09 Sep 2022 22:48:20 +0000
Received: from nasanex01a.na.qualcomm.com ([10.52.223.231])
        by NASANPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 289MmJGL009003
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 9 Sep 2022 22:48:19 GMT
Received: from [10.110.3.137] (10.80.80.8) by nasanex01a.na.qualcomm.com
 (10.52.223.231) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.29; Fri, 9 Sep 2022
 15:48:19 -0700
Message-ID: <4ef3ee8f-1210-3a03-da14-1bfdf6def297@quicinc.com>
Date:   Fri, 9 Sep 2022 15:48:18 -0700
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
From:   "Asutosh Das (asd)" <quic_asutoshd@quicinc.com>
In-Reply-To: <37d36dd9-f467-233c-babd-4e7c1c953c6c@acm.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01a.na.qualcomm.com (10.52.223.231)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: JAORX9ddPRm-pe-gpt27r2tbldjYqp85
X-Proofpoint-GUID: JAORX9ddPRm-pe-gpt27r2tbldjYqp85
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-09-09_10,2022-09-09_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 mlxlogscore=987
 bulkscore=0 impostorscore=0 malwarescore=0 lowpriorityscore=0 phishscore=0
 suspectscore=0 adultscore=0 clxscore=1015 priorityscore=1501 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2207270000
 definitions=main-2209090078
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Bart,
Thanks for the comments.

On 9/8/2022 2:58 PM, Bart Van Assche wrote:
> On 9/2/22 15:41, Asutosh Das wrote:
>> Preparatory changes for upcoming multi circular queue.
> 
> One patch per change please and also describe each individual change. 
>  From 
> https://www.kernel.org/doc/html/latest/process/submitting-patches.html#split-changes: "Separate each logical change into a separate patch".
> 
The intent of this change was to have all the non-mcq related changes to 
the ufshcd as a separate patch.
I would add more details to the commit message of this change.
If there's anything specific in this patch that may need changes, please 
let me know.

> Thanks,
> 
> Bart.

-asd
