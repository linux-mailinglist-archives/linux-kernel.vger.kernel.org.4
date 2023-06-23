Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A8D8473C2E6
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Jun 2023 23:31:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232266AbjFWVbH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Jun 2023 17:31:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231610AbjFWVbA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Jun 2023 17:31:00 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64B54FE;
        Fri, 23 Jun 2023 14:30:59 -0700 (PDT)
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 35NLUc3Q012107;
        Fri, 23 Jun 2023 21:30:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=JCixL365Uev+2ywsn75IQi2PZAT40O03nsVyo9OFnQ8=;
 b=oWeJEd62DJ4DgSiwkrRz8dnSIwlIGFpjKpKaVu2tXEuOOeuczgsB+3o4WpgNTm2+B+wZ
 jItqmfxHoygJzJ+XucgnxdOe9yrG+H+dLW6AVi18TcF/TZR3Dwi7HWlHp0BE7wlN89uI
 YWrF8EZagqsfhvZeFWo0LNe10vti0YfSsgDeLI4JWaLLQM4dE1CCiGSnzyY7SerTqU5V
 Dp0b7F23WBmNrUxqKYBxFry+F4ww3A4soJwBPbJAOk03YFLk2EYhyXOTjUaEgfyZTZzG
 KbspbSYU4cOZ6wDtkdH0lBspB2N0IEJgdIKj/6MMjhixINhaKAY26kqGNNbLdERAcqLV /A== 
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3rdcuuryyy-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 23 Jun 2023 21:30:38 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 35NLUbBg006643
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 23 Jun 2023 21:30:37 GMT
Received: from [10.226.59.182] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.42; Fri, 23 Jun
 2023 14:30:36 -0700
Message-ID: <3b4ff79b-93b4-cf56-1488-113905b3981d@quicinc.com>
Date:   Fri, 23 Jun 2023 15:30:36 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.0
Subject: Re: [PATCH 10/26] bus: mhi: host: use array_size
Content-Language: en-US
To:     Julia Lawall <Julia.Lawall@inria.fr>,
        Manivannan Sadhasivam <mani@kernel.org>
CC:     <keescook@chromium.org>, <kernel-janitors@vger.kernel.org>,
        <mhi@lists.linux.dev>, <linux-arm-msm@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
References: <20230623211457.102544-1-Julia.Lawall@inria.fr>
 <20230623211457.102544-11-Julia.Lawall@inria.fr>
From:   Jeffrey Hugo <quic_jhugo@quicinc.com>
In-Reply-To: <20230623211457.102544-11-Julia.Lawall@inria.fr>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: ZN7XA75NUVO-qu_Wn-0IOBgjPJCGzDz8
X-Proofpoint-ORIG-GUID: ZN7XA75NUVO-qu_Wn-0IOBgjPJCGzDz8
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-06-23_12,2023-06-22_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 mlxlogscore=989
 phishscore=0 spamscore=0 suspectscore=0 lowpriorityscore=0 malwarescore=0
 clxscore=1011 priorityscore=1501 bulkscore=0 impostorscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2305260000
 definitions=main-2306230193
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/23/2023 3:14 PM, Julia Lawall wrote:
> Use array_size to protect against multiplication overflows.
> 
> The changes were done using the following Coccinelle semantic patch:
> 
> // <smpl>
> @@
>      expression E1, E2;
>      constant C1, C2;
>      identifier alloc = {vmalloc,vzalloc};
> @@
>      
> (
>        alloc(C1 * C2,...)
> |
>        alloc(
> -           (E1) * (E2)
> +           array_size(E1, E2)
>        ,...)
> )
> // </smpl>
> 
> Signed-off-by: Julia Lawall <Julia.Lawall@inria.fr>
> 
> ---
>   drivers/bus/mhi/host/init.c |    4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/bus/mhi/host/init.c b/drivers/bus/mhi/host/init.c
> index f72fcb66f408..34a543a67068 100644
> --- a/drivers/bus/mhi/host/init.c
> +++ b/drivers/bus/mhi/host/init.c
> @@ -759,8 +759,8 @@ static int parse_ch_cfg(struct mhi_controller *mhi_cntrl,
>   	 * so to avoid any memory possible allocation failures, vzalloc is
>   	 * used here
>   	 */
> -	mhi_cntrl->mhi_chan = vzalloc(mhi_cntrl->max_chan *
> -				      sizeof(*mhi_cntrl->mhi_chan));
> +	mhi_cntrl->mhi_chan = vzalloc(array_size(mhi_cntrl->max_chan,
> +				      sizeof(*mhi_cntrl->mhi_chan)));
>   	if (!mhi_cntrl->mhi_chan)
>   		return -ENOMEM;
>   
> 
> 

This doesn't seem like a good fix.

If we've overflowed the multiplication, I don't think we should 
continue, and the function should return an error.  array_size() is 
going to return SIZE_MAX, and it looks like it is possible that 
vzalloc() may be able to allocate that successfully in some scenarios. 
However, that is going to be less memory than parse_ch_cfg() expected to 
allocate, so later on I expect the function will still corrupt memory - 
basically the same result as what the unchecked overflow would do.

I'm not convinced the semantic patch is bringing value as I suspect most 
of the code being patched is in the same situation.

-Jeff
