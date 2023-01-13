Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9186466A5C8
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Jan 2023 23:16:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231250AbjAMWQe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Jan 2023 17:16:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229450AbjAMWQb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Jan 2023 17:16:31 -0500
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 802F3745BC;
        Fri, 13 Jan 2023 14:16:30 -0800 (PST)
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30DMBus9009411;
        Fri, 13 Jan 2023 22:16:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=date : from : to :
 cc : subject : message-id : references : mime-version : content-type :
 content-transfer-encoding : in-reply-to; s=qcppdkim1;
 bh=fkeLtwRO6wBwJUnimyrF1CxxKm7ZcetohA+JU8YeieY=;
 b=ZvnJuuVYRWUoJYMqNXzhtd88GLlrZfaaiN7iDwNJ4yrN53MY7pc54YtQsIkqwHvQG2Aj
 VLQ/lrgcqeVqo9Q8hKAla7rSSxTDhwZdip+Pw/FdkLgEmcebNCLT6sVVdAEyfGrgyana
 dWqq6VSdXsRDC2jcbdWaQpytUfjr3hLVVmAjltE9yNUNEocYuWllHM9gRBTnmI0EIyzF
 vVtExpqT1ROL/nWnN/eNMTBMKnhdHACEVn6g5YNpwgReCtE64WiZojBbc2taKQJlBRHz
 PxwU0F638golMElVZ7Jv3ZeucRQV5FeoRW3Eaj2NjBKAiN/T9d3q0ZQpqgn4rH6vLXAA bg== 
Received: from nasanppmta03.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3n2hum3ufu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 13 Jan 2023 22:16:23 +0000
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
        by NASANPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 30DMGMqn023618
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 13 Jan 2023 22:16:22 GMT
Received: from quicinc.com (10.80.80.8) by nasanex01b.na.qualcomm.com
 (10.46.141.250) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36; Fri, 13 Jan
 2023 14:16:21 -0800
Date:   Fri, 13 Jan 2023 14:16:20 -0800
From:   Guru Das Srinagesh <quic_gurus@quicinc.com>
To:     Sibi Sankar <quic_sibis@quicinc.com>
CC:     <andersson@kernel.org>, <srinivas.kandagatla@linaro.org>,
        <agross@kernel.org>, <linux-arm-msm@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <robh+dt@kernel.org>,
        <konrad.dybcio@somainline.org>, <robimarko@gmail.com>
Subject: Re: [PATCH V10 2/2] firmware: qcom: scm: Add wait-queue handling
 logic
Message-ID: <20230113221620.GA19768@quicinc.com>
References: <20230113161114.22607-1-quic_sibis@quicinc.com>
 <20230113161114.22607-3-quic_sibis@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230113161114.22607-3-quic_sibis@quicinc.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: b1YBQcsseQQ1467sUxAn9AS3vRgyhX2p
X-Proofpoint-ORIG-GUID: b1YBQcsseQQ1467sUxAn9AS3vRgyhX2p
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.923,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-01-13_10,2023-01-13_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1011 adultscore=0
 bulkscore=0 suspectscore=0 mlxlogscore=805 spamscore=0 impostorscore=0
 mlxscore=0 phishscore=0 lowpriorityscore=0 malwarescore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2301130153
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Jan 13 2023 21:41, Sibi Sankar wrote:
> From: Guru Das Srinagesh <quic_gurus@quicinc.com>
> 
> When the firmware (FW) supports multiple requests per VM, multiple requests
> from the same/different VM can reach the firmware at the same time. Since
> the firmware currently being used has limited resources, it guards them
> with a resource lock and puts requests on a wait-queue internally and
> signals to HLOS that it is doing so. It does this by returning a new return
> value in addition to success or error: SCM_WAITQ_SLEEP. A sleeping SCM call
> can be woken up by an interrupt that the FW raises.
> 
>   1) SCM_WAITQ_SLEEP:
> 
>   	When an SCM call receives this return value instead of success
>   	or error, FW has placed this call on a wait-queue and has signalled
> 	HLOS to put it to non-interruptible sleep.
> 
> 	Along with this return value, FW also passes to HLOS `wq_ctx` -
> 	a unique number (UID) identifying the wait-queue that it has put
> 	the call on, internally. This is to help HLOS with its own
> 	bookkeeping to wake this sleeping call later.
> 
> 	Additionally, FW also passes to HLOS `smc_call_ctx` - a UID
> 	identifying the SCM call thus being put to sleep. This is also
> 	for HLOS' bookkeeping to wake this call up later.
> 
> 	These two additional values are passed via the a1 and a2
> 	registers.
> 
> 	N.B.: The "ctx" in the above UID names = "context".
> 
> The handshake mechanism that HLOS uses to talk to FW about wait-queue
> operations involves two new SMC calls.
> 
>   1) get_wq_ctx():
> 
>     	Arguments: 	None
>     	Returns:	wq_ctx, flags, more_pending
> 
>     	Get the wait-queue context, and wake up either one or all of the
>     	sleeping SCM calls associated with that wait-queue.
> 
>     	Additionally, repeat this if there are more wait-queues that are
>     	ready to have their requests woken up (`more_pending`).
> 
>   2) wq_resume(smc_call_ctx):
> 
>   	Arguments:	smc_call_ctx
> 
>   	HLOS needs to issue this in response to receiving an
>   	IRQ, passing to FW the same smc_call_ctx that FW
>   	receives from HLOS via the get_wq_ctx() call.
> 
> (The mechanism to wake a SMC call back up is described in detail below)
> 
>  VM_1                     VM_2                            Firmware
>    │                        │                                 │
>    │                        │                                 │
>    │                        │                                 │
>    │                        │                                 │
>    │      REQUEST_1         │                                 │
>    ├────────────────────────┼─────────────────────────────────┤
>    │                        │                                 │
>    │                        │                              ┌──┼──┐
>    │                        │                              │  │  │
>    │                        │     REQUEST_2                │  │  │
>    │                        ├──────────────────────────────┼──┤  │
>    │                        │                              │  │  │Resource
>    │                        │                              │  │  │is busy
>    │                        │       {WQ_SLEEP}             │  │  │
>    │                        │◄─────────────────────────────┼──┤  │
>    │                        │  wq_ctx, smc_call_ctx        │  │  │
>    │                        │                              └──┼──┘
>    │   REQUEST_1 COMPLETE   │                                 │
>    │◄───────────────────────┼─────────────────────────────────┤
>    │                        │                                 │
>    │                        │         IRQ                     │
>    │                        │◄─-------------------------------│
>    │                        │                                 │
>    │                        │      get_wq_ctx()               │
>    │                        ├────────────────────────────────►│
>    │                        │                                 │
>    │                        │                                 │
>    │                        │◄────────────────────────────────┤
>    │                        │   wq_ctx, flags, and            │
>    │                        │        more_pending             │
>    │                        │                                 │
>    │                        │                                 │
>    │                        │ wq_resume(smc_call_ctx)         │
>    │                        ├────────────────────────────────►│
>    │                        │                                 │
>    │                        │                                 │
>    │                        │      REQUEST_2 COMPLETE         │
>    │                        │◄────────────────────────────────┤
>    │                        │                                 │
>    │                        │                                 │
> 
> With the exception of get_wq_ctx(), the other SMC call wq_resume() can
> return WQ_SLEEP (these nested rounds of WQ_SLEEP are not shown in the
> above diagram for the sake of simplicity). Therefore, introduce a new
> do-while loop to handle multiple WQ_SLEEP return values for the same
> parent SCM call.
> 
> Request Completion in the above diagram refers to either a success
> return value (zero) or error (and not SMC_WAITQ_SLEEP)
> 
> Also add the interrupt handler that wakes up a sleeping SCM call.
> 
> Signed-off-by: Guru Das Srinagesh <quic_gurus@quicinc.com>
> Co-developed-by: Sibi Sankar <quic_sibis@quicinc.com>
> Signed-off-by: Sibi Sankar <quic_sibis@quicinc.com>

Reviewed-by: Guru Das Srinagesh <quic_gurus@quicinc.com>

Thank you.

Guru Das.
