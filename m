Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C75525BA87F
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Sep 2022 10:48:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230434AbiIPIsM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Sep 2022 04:48:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230195AbiIPIsI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Sep 2022 04:48:08 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B06194C635;
        Fri, 16 Sep 2022 01:48:07 -0700 (PDT)
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 28G4RQKD008662;
        Fri, 16 Sep 2022 08:48:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=BU9xiPtQh06aalOlVgaBQjQ1rGmIDxLbjWVT4cZPAMY=;
 b=L+MtZ/hX13mhImTqEGvB+mrWBQoaURx5Fp5hU6ZVaaeAnoEeDSs0iUi8Hk21t3hs3+Ub
 eXmHzUijqVjBeN95d6bw7MDoqK9R4FZBg8iJEwvE1DKPNCWpnx1yHuIPttsu5AyEPwLo
 GAwscZkvRpAnai4O5h4AtczMF03VcNZXhH10uQvYm1gyibYDpA1EDmWMRuC1SvRABvkW
 3k5GfpDcmCXohPxG7Jz0gxpN8s65TiUuL8LmXBa6nb3M8MA8BGXkre25HsqA1VLkZq8k
 9Sn0dV+yyAsmtuL/um2CWzR79U17Nfxpl0JeAZoyBYyeCY9AYjvuNj7i9GmiULtvJ8Cv 7w== 
Received: from nasanppmta01.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3jm950tg9m-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 16 Sep 2022 08:48:06 +0000
Received: from nasanex01c.na.qualcomm.com (corens_vlan604_snip.qualcomm.com [10.53.140.1])
        by NASANPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 28G8m5Q7007992
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 16 Sep 2022 08:48:06 GMT
Received: from [10.216.40.140] (10.80.80.8) by nasanex01c.na.qualcomm.com
 (10.45.79.139) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.29; Fri, 16 Sep
 2022 01:48:03 -0700
Message-ID: <1cc9acbd-1576-ab2b-c51f-d2ab70cb1a45@quicinc.com>
Date:   Fri, 16 Sep 2022 14:17:59 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.0
Subject: Re: [PATCH v4] remoteproc: core: do pm relax when in RPROC_OFFLINE
Content-Language: en-US
To:     Maria Yu <quic_aiquny@quicinc.com>, <mathieu.poirier@linaro.org>
CC:     <linux-remoteproc@vger.kernel.org>,
        <linux-arm-msm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <quic_clew@quicinc.com>
References: <128dc161-8949-1146-bf8b-310aa33c06a8@quicinc.com>
 <1663312351-28476-1-git-send-email-quic_aiquny@quicinc.com>
From:   Mukesh Ojha <quic_mojha@quicinc.com>
In-Reply-To: <1663312351-28476-1-git-send-email-quic_aiquny@quicinc.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01c.na.qualcomm.com (10.45.79.139)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: TOP5r6r3Vmb0d0EgmGfQjUx2GTM31Nv-
X-Proofpoint-ORIG-GUID: TOP5r6r3Vmb0d0EgmGfQjUx2GTM31Nv-
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-09-16_04,2022-09-14_04,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 suspectscore=0
 impostorscore=0 malwarescore=0 adultscore=0 mlxscore=0 mlxlogscore=999
 priorityscore=1501 spamscore=0 lowpriorityscore=0 bulkscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2209130000
 definitions=main-2209160064
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 9/16/2022 12:42 PM, Maria Yu wrote:
> RPROC_OFFLINE state indicate there is no recovery process
> is in progress and no chance to do the pm_relax.
> Because when recovering from crash, rproc->lock is held and
> state is RPROC_CRASHED -> RPROC_OFFLINE -> RPROC_RUNNING,
> and then unlock rproc->lock.
> When the state is in RPROC_OFFLINE it means separate request
> of rproc_stop was done and no need to hold the wakeup source
> in crash handler to recover any more.
> 
> Signed-off-by: Maria Yu <quic_aiquny@quicinc.com>
> ---
>   drivers/remoteproc/remoteproc_core.c | 11 +++++++++++
>   1 file changed, 11 insertions(+)
> 
> diff --git a/drivers/remoteproc/remoteproc_core.c b/drivers/remoteproc/remoteproc_core.c
> index e5279ed9a8d7..6bc7b8b7d01e 100644
> --- a/drivers/remoteproc/remoteproc_core.c
> +++ b/drivers/remoteproc/remoteproc_core.c
> @@ -1956,6 +1956,17 @@ static void rproc_crash_handler_work(struct work_struct *work)
>   	if (rproc->state == RPROC_CRASHED || rproc->state == RPROC_OFFLINE) {
>   		/* handle only the first crash detected */
>   		mutex_unlock(&rproc->lock);
> +		/*
> +		 * RPROC_OFFLINE state indicate there is no recovery process
> +		 * is in progress and no chance to have pm_relax in place.
> +		 * Because when recovering from crash, rproc->lock is held and
> +		 * state is RPROC_CRASHED -> RPROC_OFFLINE -> RPROC_RUNNING,
> +		 * and then unlock rproc->lock.
> +		 * RPROC_OFFLINE is only an intermediate state in recovery
> +		 * process.
> +		 */
> +		if (rproc->state == RPROC_OFFLINE)
> +			pm_relax(rproc->dev.parent);


LGTM.
Reviewed-by: Mukesh Ojha <quic_mojha@quicinc.com>

-Mukesh
>   		return;
>   	}
>   
