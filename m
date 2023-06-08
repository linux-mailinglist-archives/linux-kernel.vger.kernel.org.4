Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4BA0B727BEF
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Jun 2023 11:53:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235022AbjFHJxW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Jun 2023 05:53:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233016AbjFHJxT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Jun 2023 05:53:19 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 145C6269E;
        Thu,  8 Jun 2023 02:53:19 -0700 (PDT)
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3587rFpo016359;
        Thu, 8 Jun 2023 09:53:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=uc6wj4K9NEKf6q2lrCLh1Wv1PkS+1YwrufLRpVGlx0g=;
 b=cdKkXaUMhIA/VdfDMw+mgZPGgA6853BUzNSii+MiPP2gdVmbV8cMggesLneUkG98UfBI
 TZtpKlUECFOsqVgzc6KUm1Xop7MWwFp04/mezSBxpwWuyG2Xem/v37FbQCRw26LEw8/e
 x0bpSlJE1NMNcxRO7Ed5HPm+0y9bSnc/8zJIXYNKjf8QF5ynJLjFdLC7KWnxm/6h4KOF
 Udnka0A/E+0+ex7rvxlsq3uGZJLZ2BQrO20ZrArYO3i0jMTTqqZ1iK1uFuk9Yy9tYpjx
 j7yiyX4mV5Hq73EGKVLTNRckuC7czX1swlpOABhAJ27ODEcvspp0mLh0mMRpyLM51XgN ng== 
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3r33bvrxd1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 08 Jun 2023 09:53:14 +0000
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
        by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3589rEfo010279
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 8 Jun 2023 09:53:14 GMT
Received: from [10.204.67.150] (10.80.80.8) by nalasex01b.na.qualcomm.com
 (10.47.209.197) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.42; Thu, 8 Jun 2023
 02:53:09 -0700
Message-ID: <a665978d-f1e7-380e-f5f2-cf1270fa7961@quicinc.com>
Date:   Thu, 8 Jun 2023 15:23:06 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [RESEND PATCH v1 0/2] Privileged process support on remote
 subsystem
Content-Language: en-US
To:     Greg KH <gregkh@linuxfoundation.org>
CC:     <srinivas.kandagatla@linaro.org>, <linux-arm-msm@vger.kernel.org>,
        <ekangupt@qti.qualcomm.com>, <linux-kernel@vger.kernel.org>,
        <fastrpc.upstream@qti.qualcomm.com>, <agross@kernel.org>,
        <andersson@kernel.org>, <konrad.dybcio@linaro.org>,
        <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <conor+dt@kernel.org>, <devicetree@vger.kernel.org>
References: <1686155407-20054-1-git-send-email-quic_ekangupt@quicinc.com>
 <2023060722-zap-fiftieth-4323@gregkh>
From:   Ekansh Gupta <quic_ekangupt@quicinc.com>
In-Reply-To: <2023060722-zap-fiftieth-4323@gregkh>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: ahJZflGDMl4ai-cX0mMG-xtTHvMJk74y
X-Proofpoint-ORIG-GUID: ahJZflGDMl4ai-cX0mMG-xtTHvMJk74y
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-06-08_06,2023-06-07_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 malwarescore=0
 mlxscore=0 clxscore=1015 spamscore=0 phishscore=0 mlxlogscore=999
 impostorscore=0 lowpriorityscore=0 priorityscore=1501 bulkscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2305260000 definitions=main-2306080083
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 6/8/2023 12:17 AM, Greg KH wrote:
> On Wed, Jun 07, 2023 at 10:00:05PM +0530, Ekansh Gupta wrote:
>> Add support to run remote user process as privileged on remote
>> subsystem. The privileged user process can be given prioritized
>> access to remote processor resources. This is achieved in kernel
>> based on the group ID of the process. The kernel will have a
>> pre-defined fastrpc group ID and if the process's group ID matches
>> with it, then the process is treated as a privileged process. This
>> information is sent to the remote processor during PD initialization
>> and the PD is treated as a privileged PD.
>>
>> Ekansh Gupta (2):
>>    dt-bindings: misc: fastrpc: add fastrpc group IDs property
>>    misc: fastrpc: detect privileged processes based on group ID
>>
>>   .../devicetree/bindings/misc/qcom,fastrpc.yaml     |   6 +
>>   drivers/misc/fastrpc.c                             | 124 +++++++++++++++++++++
>>   2 files changed, 130 insertions(+)
>>
>> -- 
>> 2.7.4
>>
> 
> Why is this a RESEND?
> 
I missed sending the patches to some necessary people and lists. Hence, 
resent the patch series.

Thanks,
Ekansh
> thanks,
> 
> greg k-h
