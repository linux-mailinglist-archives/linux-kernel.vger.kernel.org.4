Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D018E73CBD4
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Jun 2023 18:06:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231964AbjFXQGU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 24 Jun 2023 12:06:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229485AbjFXQGT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Jun 2023 12:06:19 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 858F4E5E;
        Sat, 24 Jun 2023 09:06:17 -0700 (PDT)
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 35OFwvSD003729;
        Sat, 24 Jun 2023 16:06:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=AHeKVxN60rAVGoJtIK+ThHIv61dgUGDzkTmgkYmzxzg=;
 b=fjgH+Q42vxty8HRmoAIjsGPTcq5OagzOo/eCsSFEDX/LlGaPftUTaq5hoB+UKiyOMspk
 CTa009BojN/HvMitavybhCyzkwWq1YfL6yJ8W2bfkznHCmgTrxdrmt7Llx4LM//b/pai
 S6LgwOS0bE3wjGRVo8YGK1V7nrVizqbgIQvcdDL0YOYU6ei4/Yww4CIbRMwBuSht1IT3
 +clhVC0uWuDBenUDEW2dKMZMwHL3RsthNDFQ74J3n9AkXQOxAqAIsZ86FRBsBxWb9j3G
 LwlEZzEJThBdFO9njaU3r8L7MgD/UHfrhqvwehJnbrOkS+hpfQNfEH7qvkz1zdZONvIt qA== 
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3rdssdgpcy-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sat, 24 Jun 2023 16:06:09 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 35OG68rA025297
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sat, 24 Jun 2023 16:06:08 GMT
Received: from [10.226.59.182] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.42; Sat, 24 Jun
 2023 09:06:08 -0700
Message-ID: <2f1d4e18-f377-74c1-59fc-da422d4e99ee@quicinc.com>
Date:   Sat, 24 Jun 2023 10:06:07 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.0
Subject: Re: [PATCH 10/26] bus: mhi: host: use array_size
Content-Language: en-US
To:     Kees Cook <keescook@chromium.org>
CC:     Julia Lawall <julia.lawall@inria.fr>,
        Manivannan Sadhasivam <mani@kernel.org>,
        <kernel-janitors@vger.kernel.org>, <mhi@lists.linux.dev>,
        <linux-arm-msm@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20230623211457.102544-1-Julia.Lawall@inria.fr>
 <20230623211457.102544-11-Julia.Lawall@inria.fr>
 <3b4ff79b-93b4-cf56-1488-113905b3981d@quicinc.com>
 <alpine.DEB.2.22.394.2306232340510.3129@hadrien>
 <58cb3bf6-5ffd-194b-1455-4e5bb045fc34@quicinc.com>
 <202306231639.68955384A@keescook>
From:   Jeffrey Hugo <quic_jhugo@quicinc.com>
In-Reply-To: <202306231639.68955384A@keescook>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: FVd_FYpvNMuEqE3Jw1BkvypnTVJkbW7m
X-Proofpoint-ORIG-GUID: FVd_FYpvNMuEqE3Jw1BkvypnTVJkbW7m
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-06-24_11,2023-06-22_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 mlxscore=0
 phishscore=0 suspectscore=0 clxscore=1015 malwarescore=0 bulkscore=0
 priorityscore=1501 lowpriorityscore=0 impostorscore=0 spamscore=0
 mlxlogscore=749 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2305260000 definitions=main-2306240152
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/23/2023 5:45 PM, Kees Cook wrote:
> On Fri, Jun 23, 2023 at 04:09:46PM -0600, Jeffrey Hugo wrote:
>> Kees, would you please chime in and educate me here?  I feel like I'm
>> missing something important here.
> 
> The array_size() family will saturate at SIZE_MAX (rather than potentially
> wrapping around). No allocator can fulfil a 18446744073709551615 byte
> (18 exabyte) allocation. :) So the NULL return value will (hopefully)
> trigger an error path.
> 

Fair enough, that handles the 64-bit usecase.  I'm guessing the 
assumption is that on a 32-bit usecase where size_t is ~4GB, there won't 
actually be 4GB to allocate and things will also fail.  So far, so good.

What about a 32-bit system with something like ARM's LPAE (Large 
Physical Address Extension) where the host is 32-bit, and so size_t 
would be ~4GB (as far as I can tell) but phys_addr_t is larger than 
that, and so we can have/access more than 4GB of resources?  Lets see, 
ignoring that its a 13 year old feature and probably not in circulation 
anymore, probably still can't satisfy a 4GB allocation since you'd need 
to map all of it to address it, and part of the address space is surely 
reserved for other things.

Ok, I think I'm convinced.  I'm going to sleep on it, but I suspect all 
will still be good early next week.

Thank you for the explanation.

-Jeff
