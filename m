Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F97B6F322B
	for <lists+linux-kernel@lfdr.de>; Mon,  1 May 2023 16:40:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232518AbjEAOkI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 May 2023 10:40:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232643AbjEAOkC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 May 2023 10:40:02 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4516698;
        Mon,  1 May 2023 07:39:53 -0700 (PDT)
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 341CnA9Q013549;
        Mon, 1 May 2023 14:39:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=tgrJ8oEg2eIYeOfZwOEMm2cKuYlQjJspqxw0rECH8tg=;
 b=FI0E1OX1sJBeITXmL4VOIq7R9nyoKicKO5ck5gCABE9yvE+bsKxNDV2Tr8wxl6y8UVqZ
 MR/HgCMx0Cjb1CjtMR/gTN6q9MQB+7sl97Lyv4yJzuOVz8W9XksnDaH71wfmUQoLGSeS
 Zm3f+O9YxsvTcEK+ayYhI7gWIaBe/jyY+YD5YZq99KiCH9WQUFrGkazWUyZc3Xj8ncWE
 igmEt+5VJ3kDvI6q/Kxf4d+JurgUYRaHJje/tswsFOB4HoTwQOxAWFgTdI4fY4NC8+lE
 h05qiY2rIzKkXlCrzEsDFp5hI7yZWbX7TtMNBNZIF/wbzUg/AtzBEbt9hbQlS4ZE7ekf HA== 
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3q8vhgum6s-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 01 May 2023 14:39:40 +0000
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
        by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 341EdU13006813
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 1 May 2023 14:39:30 GMT
Received: from [10.110.121.148] (10.80.80.8) by nalasex01c.na.qualcomm.com
 (10.47.97.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.42; Mon, 1 May 2023
 07:39:29 -0700
Message-ID: <6f806e8a-1f12-5793-66eb-d7497839ad14@quicinc.com>
Date:   Mon, 1 May 2023 07:39:29 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH v4 2/2] firmware: arm_scmi: Augment SMC/HVC to allow
 optional parameters
To:     <sudeep.holla@arm.com>, <f.fainelli@gmail.com>
CC:     <cristian.marussi@arm.com>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20230409181918.29270-1-quic_nkela@quicinc.com>
 <20230418185659.29745-1-quic_nkela@quicinc.com>
 <20230418185659.29745-3-quic_nkela@quicinc.com>
Content-Language: en-US
From:   Nikunj Kela <quic_nkela@quicinc.com>
In-Reply-To: <20230418185659.29745-3-quic_nkela@quicinc.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: WYdsf450ZryM37kW7WdzlKygc9Go8ORb
X-Proofpoint-ORIG-GUID: WYdsf450ZryM37kW7WdzlKygc9Go8ORb
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-05-01_08,2023-04-27_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 impostorscore=0
 suspectscore=0 phishscore=0 mlxscore=0 bulkscore=0 malwarescore=0
 mlxlogscore=999 adultscore=0 lowpriorityscore=0 priorityscore=1501
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2303200000 definitions=main-2305010118
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Reminder: Please review this patch! Thanks

On 4/18/2023 11:56 AM, Nikunj Kela wrote:
> This patch add support for passing shmem channel address as parameters
> in smc/hvc call. The address is split into 4KB-page and offset.
> This patch is useful when multiple scmi instances are using same smc-id
> and firmware needs to distinguish among the instances.
>
> Signed-off-by: Nikunj Kela <quic_nkela@quicinc.com>
> ---
>   drivers/firmware/arm_scmi/driver.c |  1 +
>   drivers/firmware/arm_scmi/smc.c    | 14 +++++++++++++-
>   2 files changed, 14 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/firmware/arm_scmi/driver.c b/drivers/firmware/arm_scmi/driver.c
> index e7d97b59963b..b5957cc12fee 100644
> --- a/drivers/firmware/arm_scmi/driver.c
> +++ b/drivers/firmware/arm_scmi/driver.c
> @@ -2914,6 +2914,7 @@ static const struct of_device_id scmi_of_match[] = {
>   #endif
>   #ifdef CONFIG_ARM_SCMI_TRANSPORT_SMC
>   	{ .compatible = "arm,scmi-smc", .data = &scmi_smc_desc},
> +	{ .compatible = "arm,scmi-smc-param", .data = &scmi_smc_desc},
>   #endif
>   #ifdef CONFIG_ARM_SCMI_TRANSPORT_VIRTIO
>   	{ .compatible = "arm,scmi-virtio", .data = &scmi_virtio_desc},
> diff --git a/drivers/firmware/arm_scmi/smc.c b/drivers/firmware/arm_scmi/smc.c
> index 93272e4bbd12..71e080b70df5 100644
> --- a/drivers/firmware/arm_scmi/smc.c
> +++ b/drivers/firmware/arm_scmi/smc.c
> @@ -20,6 +20,11 @@
>   
>   #include "common.h"
>   
> +#define SHMEM_SHIFT 12
> +#define SHMEM_SIZE (_AC(1, UL) << SHMEM_SHIFT)
> +#define SHMEM_PAGE(x) ((unsigned long)((x) >> SHMEM_SHIFT))
> +#define SHMEM_OFFSET(x) ((x) & (SHMEM_SIZE - 1))
> +
>   /**
>    * struct scmi_smc - Structure representing a SCMI smc transport
>    *
> @@ -30,6 +35,7 @@
>    * @inflight: Atomic flag to protect access to Tx/Rx shared memory area.
>    *	      Used when operating in atomic mode.
>    * @func_id: smc/hvc call function id
> + * @param: physical address of the shmem channel
>    */
>   
>   struct scmi_smc {
> @@ -40,6 +46,7 @@ struct scmi_smc {
>   #define INFLIGHT_NONE	MSG_TOKEN_MAX
>   	atomic_t inflight;
>   	u32 func_id;
> +	phys_addr_t param;
>   };
>   
>   static irqreturn_t smc_msg_done_isr(int irq, void *data)
> @@ -137,6 +144,8 @@ static int smc_chan_setup(struct scmi_chan_info *cinfo, struct device *dev,
>   	if (ret < 0)
>   		return ret;
>   
> +	if (of_device_is_compatible(dev->of_node, "arm,scmi-smc-param"))
> +		scmi_info->param = res.start;
>   	/*
>   	 * If there is an interrupt named "a2p", then the service and
>   	 * completion of a message is signaled by an interrupt rather than by
> @@ -179,6 +188,8 @@ static int smc_send_message(struct scmi_chan_info *cinfo,
>   {
>   	struct scmi_smc *scmi_info = cinfo->transport_info;
>   	struct arm_smccc_res res;
> +	unsigned long page = SHMEM_PAGE(scmi_info->param);
> +	unsigned long offset = SHMEM_OFFSET(scmi_info->param);
>   
>   	/*
>   	 * Channel will be released only once response has been
> @@ -188,7 +199,8 @@ static int smc_send_message(struct scmi_chan_info *cinfo,
>   
>   	shmem_tx_prepare(scmi_info->shmem, xfer, cinfo);
>   
> -	arm_smccc_1_1_invoke(scmi_info->func_id, 0, 0, 0, 0, 0, 0, 0, &res);
> +	arm_smccc_1_1_invoke(scmi_info->func_id, page, offset, 0, 0, 0, 0, 0,
> +			     &res);
>   
>   	/* Only SMCCC_RET_NOT_SUPPORTED is valid error code */
>   	if (res.a0) {
