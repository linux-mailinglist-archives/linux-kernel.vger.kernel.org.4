Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 466F86FE0CC
	for <lists+linux-kernel@lfdr.de>; Wed, 10 May 2023 16:51:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237341AbjEJOvA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 May 2023 10:51:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237176AbjEJOu5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 May 2023 10:50:57 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D0241BD6;
        Wed, 10 May 2023 07:50:56 -0700 (PDT)
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 34ADswei016231;
        Wed, 10 May 2023 14:50:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=2wwVnk5uXEvsHS6E6k3z7kwxwfFjYsn0/KoCYekK6d0=;
 b=dV1gjrCW7DdpDtkU3wN16zqkQXMuH0kpdMbCwTednmVp2KYxmNWJOVYrGP1mdCO9nV5c
 IAwbUxMUGNVIRNHISn1pSI/KhqaSgD20a44gsBUUn8TFD8OUak++5Hi1VSrKvJY8F8u1
 waRJ2i2FJ0FuCiFXwZ6yzHnqx1b7/C2STcVo57xO3Fh4TRloFyclXJqjlKQ0PJM/3Mjy
 diws6xkTOucGVYBB8CwumH6f6OFEWOqAkSXaSg7/bRWKI2On/UeP+Vin8Tg7WeBaYE2E
 soItOwtwR9Pwqex4fRCXbqDjcQXvMuLaVkCUcHIIkY4tRflkIuq8KM7BW5ZmQHhd2+c2 Dw== 
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3qfrutad78-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 10 May 2023 14:50:46 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 34AEojkq007183
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 10 May 2023 14:50:45 GMT
Received: from [10.226.59.182] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.42; Wed, 10 May
 2023 07:50:44 -0700
Message-ID: <a3e030d7-d7f8-80d9-6026-f994cc362d55@quicinc.com>
Date:   Wed, 10 May 2023 08:50:43 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.0
Subject: Re: [PATCH] bus: mhi: host: Skip MHI reset if device is in RDDM
Content-Language: en-US
To:     Qiang Yu <quic_qianyu@quicinc.com>, <mani@kernel.org>
CC:     <mhi@lists.linux.dev>, <linux-arm-msm@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <quic_cang@quicinc.com>,
        <quic_mrana@quicinc.com>
References: <1683698675-33315-1-git-send-email-quic_qianyu@quicinc.com>
From:   Jeffrey Hugo <quic_jhugo@quicinc.com>
In-Reply-To: <1683698675-33315-1-git-send-email-quic_qianyu@quicinc.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: HB2Q4VXueCAhB48kbhfvKuJ4hbNKHjxa
X-Proofpoint-ORIG-GUID: HB2Q4VXueCAhB48kbhfvKuJ4hbNKHjxa
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-05-10_04,2023-05-05_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 malwarescore=0
 priorityscore=1501 impostorscore=0 suspectscore=0 phishscore=0 bulkscore=0
 clxscore=1011 adultscore=0 lowpriorityscore=0 mlxscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2304280000
 definitions=main-2305100119
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/10/2023 12:04 AM, Qiang Yu wrote:
> In RDDM EE, device can not process MHI reset
> issued by host. In case of MHI power off, host
> is issuing MHI reset and polls for it to get
> cleared until it times out. Since this timeout
> can not be avoided in case of RDDM, skip the
> MHI reset in this scenarios.

Looks like you only use ~45 columns of 75 possible.  Feels a little odd. 
  Any particular reason for that?

Fixes tag?

> Signed-off-by: Qiang Yu <quic_qianyu@quicinc.com>
> ---
>   drivers/bus/mhi/host/pm.c | 5 +++++
>   1 file changed, 5 insertions(+)
> 
> diff --git a/drivers/bus/mhi/host/pm.c b/drivers/bus/mhi/host/pm.c
> index 0834590..8a4362d 100644
> --- a/drivers/bus/mhi/host/pm.c
> +++ b/drivers/bus/mhi/host/pm.c
> @@ -470,6 +470,10 @@ static void mhi_pm_disable_transition(struct mhi_controller *mhi_cntrl)
>   
>   	/* Trigger MHI RESET so that the device will not access host memory */
>   	if (!MHI_PM_IN_FATAL_STATE(mhi_cntrl->pm_state)) {
> +		/* Skip MHI RESET if in RDDM state */
> +		if (mhi_cntrl->rddm_image && mhi_get_exec_env(mhi_cntrl) == MHI_EE_RDDM)
> +			goto skip_mhi_reset;
> +
>   		dev_dbg(dev, "Triggering MHI Reset in device\n");
>   		mhi_set_mhi_state(mhi_cntrl, MHI_STATE_RESET);
>   
> @@ -495,6 +499,7 @@ static void mhi_pm_disable_transition(struct mhi_controller *mhi_cntrl)
>   		}
>   	}
>   
> +skip_mhi_reset:
>   	dev_dbg(dev,
>   		 "Waiting for all pending event ring processing to complete\n");
>   	mhi_event = mhi_cntrl->mhi_event;

