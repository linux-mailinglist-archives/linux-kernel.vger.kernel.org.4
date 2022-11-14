Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 28A72628343
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Nov 2022 15:53:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236900AbiKNOxr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Nov 2022 09:53:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236785AbiKNOxh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Nov 2022 09:53:37 -0500
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2518B334;
        Mon, 14 Nov 2022 06:53:36 -0800 (PST)
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2AEEPFLN029937;
        Mon, 14 Nov 2022 14:53:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=3zTrcoF9Xv6zFxIKUZYqy883VlNmHoFuse9W+M5yNfM=;
 b=N1edgSAdC0sHauGXExZPlPzxrAJM4KGXqoHxKoHiALtVrEeQJiT/CzmqIXWbR43F9tDo
 jsqD6FiAmGu/nyR/v6NPkhvA/EUHUmw/z67ZGji5T6Hv98xoYZpb9mbudNLY7D4pkaPX
 e6uP334bKUomVlF96eRT5lbmWBLvRb+iu2+Hh3W5ZjRcmsOxAusDBcACWh9jeRZUrco5
 SwzA84GN6t22TlxdHoRxDLI5ev1rqJbbVQOqIidsWcRW9KYIC0ZygBI7xfIriKPlvyab
 ZzyUZzZ/jOYL5eJgYhvkshBTxZvcatP/FM3SBOLsOcfJ0PDkZ/8D9PEYW9VgxYDwiRSM 9Q== 
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3kug3hh923-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 14 Nov 2022 14:53:31 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 2AEErUUm019083
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 14 Nov 2022 14:53:30 GMT
Received: from [10.226.59.182] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.29; Mon, 14 Nov
 2022 06:53:29 -0800
Message-ID: <8aae17cf-7c2b-85bb-d0f5-a5f71e792d16@quicinc.com>
Date:   Mon, 14 Nov 2022 07:53:28 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.0
Subject: Re: [PATCH v2] bus: mhi: host: Disable preemption while processing
 data events
Content-Language: en-US
To:     Qiang Yu <quic_qianyu@quicinc.com>, <mani@kernel.org>,
        <loic.poulain@linaro.org>
CC:     <mhi@lists.linux.dev>, <linux-arm-msm@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <quic_cang@quicinc.com>,
        <mrana@quicinc.com>
References: <1668419923-20292-1-git-send-email-quic_qianyu@quicinc.com>
From:   Jeffrey Hugo <quic_jhugo@quicinc.com>
In-Reply-To: <1668419923-20292-1-git-send-email-quic_qianyu@quicinc.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: TRr4WJFTY27fxiDlceDvQZMtsvrrxCId
X-Proofpoint-ORIG-GUID: TRr4WJFTY27fxiDlceDvQZMtsvrrxCId
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-14_12,2022-11-11_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 spamscore=0
 priorityscore=1501 adultscore=0 clxscore=1015 lowpriorityscore=0
 phishscore=0 mlxlogscore=999 impostorscore=0 malwarescore=0 suspectscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2210170000 definitions=main-2211140105
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/14/2022 2:58 AM, Qiang Yu wrote:
> If data processing of an event is scheduled out because core
> is busy handling multiple irqs, this can starve the processing
> of MHI M0 state change event on another core. Fix this issue by
> disabling irq on the core processing data events.
> 
> Signed-off-by: Qiang Yu <quic_qianyu@quicinc.com>
> ---
> v1->v2: add comments about why we disable local irq
> 
>   drivers/bus/mhi/host/main.c | 11 +++++++++--
>   1 file changed, 9 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/bus/mhi/host/main.c b/drivers/bus/mhi/host/main.c
> index f3aef77a..fcb2586 100644
> --- a/drivers/bus/mhi/host/main.c
> +++ b/drivers/bus/mhi/host/main.c
> @@ -1027,13 +1027,20 @@ int mhi_process_data_event_ring(struct mhi_controller *mhi_cntrl,
>   
>   void mhi_ev_task(unsigned long data)
>   {
> +	unsigned long flags;
>   	struct mhi_event *mhi_event = (struct mhi_event *)data;
>   	struct mhi_controller *mhi_cntrl = mhi_event->mhi_cntrl;
>   
>   	/* process all pending events */
> -	spin_lock_bh(&mhi_event->lock);
> +	spin_lock_irqsave(&mhi_event->lock, flags);
> +	/*
> +	 * When muiltiple IRQs come, the tasklet will be scheduled out with event ring lock

multiple

> +	 * remaining acquired, causing M0 event process on another core gets stuck when it
> +	 * tries to acquire the same event ring lock. Thus let's disable local IRQs here.
> +	 */
> +
>   	mhi_event->process_event(mhi_cntrl, mhi_event, U32_MAX);
> -	spin_unlock_bh(&mhi_event->lock);
> +	spin_unlock_irqrestore(&mhi_event->lock, flags);
>   }
>   
>   void mhi_ctrl_ev_task(unsigned long data)

