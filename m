Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B9D3663EE2
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Jan 2023 12:03:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233140AbjAJLC4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Jan 2023 06:02:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238630AbjAJLAh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jan 2023 06:00:37 -0500
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF004E95;
        Tue, 10 Jan 2023 02:59:54 -0800 (PST)
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30A5T1dL030732;
        Tue, 10 Jan 2023 10:59:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=ySX3CqiWYeBusCdMeRMR9e/8ifnzdKBQyuw3gT2RojM=;
 b=C5rR2ThI1vdViUguH/vKJAfFF84gWCoNq162vWZjstxbaelXh+XYOpWVJlvbxJ+1rPV4
 27utJIdYNESqlIVn8ITtcpVL+QJT+P2FfLFuZ6wtG8ZIvLao02pgp0uNdhkjsrBmAy4z
 H23hcKXfIWn17BggzXtP1cTDR9dbjS2Po0A/ZYv4UQ9yFuI4tqvhzrMvbuS7YZFSWK8G
 oSB/h8nAEOIJ5p0leQ6nXwb+XIdMevbeDKOxV/+so8zryCr1mY0vrA4FQVTHMeSalCOI
 RMmwVI7qK2aM413HYZY0FFOCge2NWgJdOASLJnaBpT9zJV54SvwORmqbJ77bPMPrKMr3 vA== 
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3n0x0jh2xm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 10 Jan 2023 10:59:44 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 30AAxh1I026269
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 10 Jan 2023 10:59:43 GMT
Received: from [10.50.61.82] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36; Tue, 10 Jan
 2023 02:59:40 -0800
Message-ID: <ed5f14c9-e93a-baea-b327-0d54b47a69be@quicinc.com>
Date:   Tue, 10 Jan 2023 16:29:37 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Subject: Re: [PATCH V1 0/1] soc: qcom: dcc: Add QAD, Cti-trigger and
 Bootconfig support for Data Capture and Compare(DCC)
Content-Language: en-US
To:     Bjorn Andersson <andersson@kernel.org>
CC:     Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Alex Elder <elder@ieee.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-arm-msm@vger.kernel.org>,
        Sai Prakash Ranjan <quic_saipraka@quicinc.com>,
        Sibi Sankar <quic_sibis@quicinc.com>,
        "Rajendra Nayak" <quic_rjendra@quicinc.com>, <vkoul@kernel.org>
References: <cover.1673270769.git.quic_schowdhu@quicinc.com>
 <20230109151818.hxpi2nleb53ibv7w@builder.lan>
From:   Souradeep Chowdhury <quic_schowdhu@quicinc.com>
In-Reply-To: <20230109151818.hxpi2nleb53ibv7w@builder.lan>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: Z-yrnfP8mfooE5llZCV1f06lKYXwjIlo
X-Proofpoint-ORIG-GUID: Z-yrnfP8mfooE5llZCV1f06lKYXwjIlo
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2023-01-10_03,2023-01-10_03,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 malwarescore=0 clxscore=1015 suspectscore=0 priorityscore=1501
 lowpriorityscore=0 phishscore=0 mlxscore=0 adultscore=0 mlxlogscore=999
 spamscore=0 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2301100066
X-Spam-Status: No, score=0.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_SBL_CSS,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 1/9/2023 8:48 PM, Bjorn Andersson wrote:
> On Mon, Jan 09, 2023 at 07:32:25PM +0530, Souradeep Chowdhury wrote:
>> This patch adds the Bootconfig, QAD and CTI-Trigger support for DCC.
>>
> 
> As with the other patch, please move your motivation into the commit
> message of the patch.
> 
> That said, this seems to be 3 different topics, and hence should be
> three different patches.

Ack

> 
>> 1.Bootconfig
>>
>> Bootconfig parser has been added to DCC driver so that the register addresses
>> can be configured during boot-time. This is used to debug crashes that can happen
>> during boot-time. The expected format of a bootconfig is as follows:-
>>
>> dcc_config {
>> 	link_list_0 {
>> 		qcom-curr-link-list = <The list number to configure>
>> 		qcom-link-list =  <Address as same format as dcc separated by '_'>,
>> 	}
>> }
>>
>> Example:
>>
>> dcc_config {
>> 	link_list_0 {
> 
> The name of the node does not seem to have any significance; this could
> be nice to mention. I also think it would set a good precedence if you
> used the number of the qcom-curr-link-list in the node name, rather than
> just an iterator...

Ack

> 
>> 		qcom-curr-link-list = 6
>> 		qcom-link-list = R_0x1781005c_1_apb,
>> 				 R_0x1782005c_1_apb
>> 	}
>> 	link_list_1 {
>> 		qcom-curr-link-list = 5
>> 		qcom-link-list = R_0x1784005c_1_apb
>> 	}
>> }
>>
>> 2.QAD
>>
>> QAD can be enabled as a part of debugfs file under each individual list folder.
>> QAD is used to specify the access control for DCC configurations, on enabling
>> it the access control to dcc configuration space is restricted.
>>
> 
> Who is locked out from this restricted access? Please mention why this
> is a good thing.

Ack

> 
>> 3.CTI-trigger
>>
>> CTI trigger is used to enable the Cross trigger interface for DCC. On enabling
>> CTI trigger the dcc software trigger can be done by writing to CTI trig-out.
>> Also the hwtrigger debugfs file is created which needs to be disabled for enabling
>> CTI-trigger.
>>
> 
> Please mention why hwtrigger needs to be disabled, and why does it need
> to be disabled?

Ack

> 
>> Changes in V1
>>
>> *Fixed the W=1 warnings in V0 of the patch
> 
> Please follow the standard practice of giving your first version of a
> patch version 1.

Ack

> 
> Thanks,
> Bjorn
> 
>>
>> Souradeep Chowdhury (1):
>>    soc: qcom: dcc: Add QAD, Ctitrigger and Bootconfig support for DCC
>>
>>   Documentation/ABI/testing/debugfs-driver-dcc |  24 +++
>>   drivers/soc/qcom/dcc.c                       | 284 ++++++++++++++++++++++++++-
>>   2 files changed, 304 insertions(+), 4 deletions(-)
>>
>> --
>> 2.7.4
>>
