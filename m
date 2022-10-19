Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C486A605435
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Oct 2022 01:50:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229971AbiJSXuQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Oct 2022 19:50:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229807AbiJSXuM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Oct 2022 19:50:12 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00D88FF8F6;
        Wed, 19 Oct 2022 16:50:10 -0700 (PDT)
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 29JMvF0N005767;
        Wed, 19 Oct 2022 23:49:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=PKlvJyr2CLODo5qWsgOnyStlxfDpx8K32m51Mvty0So=;
 b=EjX1n2PSktb274+6pjGEvtdzZnnWDOXhkKVCbxAyAWKx4HP2x/ZVnvTqbJw5G/Z5ltDz
 4//ppxyLpti16SePtoXOT2FI4rFZxrfaMEKAPWiPttDJX+V7lcCqaa2nsdYGqgrBMZrC
 pWIMg9UttruVAUMp3BEZDTDH9uNhQ6161N6FSo46YDiM8okl7pvLO2sJeSFmneZ21bqI
 xbcnBHcTOIoLbE7KavwV1YDd35rj5Lk8fr4O8lJZzZB5VnryQTvzKaAkwvOJC2eTkb5f
 knnIvlyfVmYKRYjFvhFxTHhxHRPPU3f56O9r7zU+oRHPuGc7VSBZBYbLwiC4XI7TOq9P rw== 
Received: from nasanppmta02.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3ka820v6kc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 19 Oct 2022 23:49:53 +0000
Received: from nasanex01b.na.qualcomm.com (corens_vlan604_snip.qualcomm.com [10.53.140.1])
        by NASANPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 29JNnqiK031012
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 19 Oct 2022 23:49:52 GMT
Received: from [10.134.66.255] (10.80.80.8) by nasanex01b.na.qualcomm.com
 (10.46.141.250) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.29; Wed, 19 Oct
 2022 16:49:52 -0700
Message-ID: <0d9123cd-d741-31c3-7c75-92c8e98e1000@quicinc.com>
Date:   Wed, 19 Oct 2022 16:49:52 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [PATCH v2 3/6] clk: qcom: branch: Add BRANCH_HALT_INVERT flag
 support for branch clocks
Content-Language: en-US
To:     Stephen Boyd <sboyd@kernel.org>, Andy Gross <agross@kernel.org>,
        "Bjorn Andersson" <andersson@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Marc Zyngier <maz@kernel.org>,
        "Michael Turquette" <mturquette@baylibre.com>,
        Rob Herring <robh+dt@kernel.org>,
        "Thomas Gleixner" <tglx@linutronix.de>
CC:     <linux-arm-msm@vger.kernel.org>, <linux-clk@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Imran Shaik <quic_imrashai@quicinc.com>
References: <20221014221011.7360-1-quic_molvera@quicinc.com>
 <20221014221011.7360-4-quic_molvera@quicinc.com>
 <20221015002007.E3815C433D7@smtp.kernel.org>
From:   Melody Olvera <quic_molvera@quicinc.com>
In-Reply-To: <20221015002007.E3815C433D7@smtp.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: IYAedlfPUMCJJK-RJSWQ85rBRpKeYDL7
X-Proofpoint-GUID: IYAedlfPUMCJJK-RJSWQ85rBRpKeYDL7
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-10-19_13,2022-10-19_04,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999
 lowpriorityscore=0 spamscore=0 priorityscore=1501 bulkscore=0 adultscore=0
 malwarescore=0 mlxscore=0 impostorscore=0 suspectscore=0 phishscore=0
 clxscore=1011 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2209130000 definitions=main-2210190133
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 10/14/2022 5:20 PM, Stephen Boyd wrote:
> Quoting Melody Olvera (2022-10-14 15:10:08)
>> diff --git a/drivers/clk/qcom/clk-branch.c b/drivers/clk/qcom/clk-branch.c
>> index f869fc6aaed6..b5dc1f4ef277 100644
>> --- a/drivers/clk/qcom/clk-branch.c
>> +++ b/drivers/clk/qcom/clk-branch.c
>> @@ -1,6 +1,7 @@
>>  // SPDX-License-Identifier: GPL-2.0
>>  /*
>>   * Copyright (c) 2013, The Linux Foundation. All rights reserved.
>> + * Copyright (c) 2022, Qualcomm Innovation Center, Inc. All rights reserved.
>>   */
>>  
>>  #include <linux/kernel.h>
>> @@ -56,6 +57,10 @@ static bool clk_branch2_check_halt(const struct clk_branch *br, bool enabling)
>>  
>>         if (enabling) {
>>                 val &= mask;
>> +
>> +               if (br->halt_check == BRANCH_HALT_INVERT)
>> +                       return (val & BRANCH_CLK_OFF) == BRANCH_CLK_OFF;
>> +
>>                 return (val & BRANCH_CLK_OFF) == 0 ||
>>                         val == BRANCH_NOC_FSM_STATUS_ON;
>>         } else {
>> diff --git a/drivers/clk/qcom/clk-branch.h b/drivers/clk/qcom/clk-branch.h
>> index 17a58119165e..4ac1debeb91e 100644
>> --- a/drivers/clk/qcom/clk-branch.h
>> +++ b/drivers/clk/qcom/clk-branch.h
>> @@ -1,5 +1,6 @@
>>  /* SPDX-License-Identifier: GPL-2.0 */
>>  /* Copyright (c) 2013, The Linux Foundation. All rights reserved. */
>> +/* Copyright (c) 2022, Qualcomm Innovation Center, Inc. All rights reserved. */
>>  
>>  #ifndef __QCOM_CLK_BRANCH_H__
>>  #define __QCOM_CLK_BRANCH_H__
>> @@ -33,6 +34,7 @@ struct clk_branch {
>>  #define BRANCH_HALT_ENABLE_VOTED       (BRANCH_HALT_ENABLE | BRANCH_VOTED)
>>  #define BRANCH_HALT_DELAY              2 /* No bit to check; just delay */
>>  #define BRANCH_HALT_SKIP               3 /* Don't check halt bit */
>> +#define BRANCH_HALT_INVERT             4 /* Invert logic for halt bit */
> How is it different from BRANCH_HALT vs. BRANCH_HALT_ENABLE?
Main difference here is in how other parts of the register are checked to see if halting
happened or not. Turns out the clocks that use this can be reconfigured to be a little
more friendly to the code already submitted, so this patch isn't necessary. I'll drop it
in the next PS.

Thanks,
Melody
