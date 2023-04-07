Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 30EBC6DB681
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Apr 2023 00:36:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229827AbjDGWf7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Apr 2023 18:35:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229643AbjDGWf5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Apr 2023 18:35:57 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14A32CA1A;
        Fri,  7 Apr 2023 15:35:54 -0700 (PDT)
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 337LbUgi030608;
        Fri, 7 Apr 2023 22:35:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=GLPTOTfwSYH4/Oiye4DOEFwrubn3rrjGIYd6rskQ6hg=;
 b=KP8y2ONQGKZIohtcbcVh6KPVfIHsKls4n73O1Gmoyn+jXcsKhCjNN0UUEzz1IaJ1CJCG
 JtfLveRlbq2v9G3yWxa5W/i6Sbl6OAkN41l0kLGYvOYEYfQ5pYXzOLrnNpNXwMM7ohjg
 ySJ61ktiB3JYW1kZeFnjXm6MEtrSbn/2Atjd7BI9boOgNbgfPdpObhIsSNNpGyxHsLRH
 DfGPzbvDkVqknAepsmPU9w80s/jrVg5gQrT+PsCM7jeJ+CNlMR5tTDauDmgL6ATmI6NF
 qQbNeUJmI9H9SAzOdzfQQ23B2mqWoukN4Sx2o3mXQ4hLQnSqJYJg/BnXBjg2CJ7kINU+ Nw== 
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3ptgpk1jc5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 07 Apr 2023 22:35:51 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 337MZpeC027751
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 7 Apr 2023 22:35:51 GMT
Received: from [10.110.34.31] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.42; Fri, 7 Apr 2023
 15:35:50 -0700
Message-ID: <58305f4d-fbcb-44cc-053c-d30f4ca082e7@quicinc.com>
Date:   Fri, 7 Apr 2023 15:35:49 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH 0/2] rpmsg: glink: Wait for intent after intent request
Content-Language: en-US
To:     Bjorn Andersson <quic_bjorande@quicinc.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>
CC:     <linux-arm-msm@vger.kernel.org>,
        <linux-remoteproc@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20230327144617.3134175-1-quic_bjorande@quicinc.com>
From:   Chris Lew <quic_clew@quicinc.com>
In-Reply-To: <20230327144617.3134175-1-quic_bjorande@quicinc.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: ctf5nHn8wnafu-MSPyw-OvmjotHfcvYA
X-Proofpoint-GUID: ctf5nHn8wnafu-MSPyw-OvmjotHfcvYA
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-04-07_14,2023-04-06_03,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 adultscore=0
 clxscore=1015 lowpriorityscore=0 spamscore=0 suspectscore=0 malwarescore=0
 priorityscore=1501 mlxscore=0 phishscore=0 bulkscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2303200000
 definitions=main-2304070204
X-Spam-Status: No, score=-2.9 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 3/27/2023 7:46 AM, Bjorn Andersson wrote:
> When written it was assumed that upon requesting an intent, the intent
> would arrive followed by an intent request acknowledgement. But this is
> not always the case, in which case the current implementation would
> request yet another intent and when that is acknowledged find the first
> received intent - if the remote didn't run out of memory and failed the
> second request...
> 
> Bjorn Andersson (2):
>    rpmsg: glink: Transition intent request signaling to wait queue
>    rpmsg: glink: Wait for intent, not just request ack
> 
>   drivers/rpmsg/qcom_glink_native.c | 37 ++++++++++++++++++++++---------
>   1 file changed, 26 insertions(+), 11 deletions(-)
> 

Reviewed-by: Chris Lew <quic_clew@quicinc.com>
