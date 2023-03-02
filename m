Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 710D86A822D
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Mar 2023 13:30:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229787AbjCBM37 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Mar 2023 07:29:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229803AbjCBM3t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Mar 2023 07:29:49 -0500
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90B537280;
        Thu,  2 Mar 2023 04:29:47 -0800 (PST)
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3229ZELo007375;
        Thu, 2 Mar 2023 12:29:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=oHObD0hUu6NPhZDz0+6RYBcDjAzdwtSmNMGwg9BRTZE=;
 b=Y+8tpsckgP9q8RXwXnFgi/r6cHsS6qpoRC1dPd9QDXDRyBEWuh/nUbNTbuH4QpIRHiYc
 LStkNlVTbsIS0ieHLjWkfwXP5uMhsCWnG0JhhtaJIK3c+aoHkdzkeghzJJquEVcJhav/
 uHGXHwB7EPSSZrYlUGNoKvPporg8UYblnlC9fGc6a8mMgGIlOMdmjMwqSPiHUA2Muyk0
 TJQPvyKXNjH2WehK2KIrBSuALibTLdmwFyFD9dNMQ0rh3yt0tZHEKVr8odUxAlZW46+K
 UokzPsUmqSOW5YuHpbrEpQjBVMrO/gtfpqUh9tZvRhaCTh4inbiGLGeRkN8TAiECQkt4 dA== 
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3p25jwkgw4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 02 Mar 2023 12:29:37 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 322CTa2G015068
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 2 Mar 2023 12:29:36 GMT
Received: from [10.239.133.9] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Thu, 2 Mar 2023
 04:29:33 -0800
Message-ID: <a9fc9830-dce6-3def-d06c-c56c62ac2fce@quicinc.com>
Date:   Thu, 2 Mar 2023 20:29:30 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.1
Subject: Re: [PATCH] stm: class: Add MIPI OST protocol support
Content-Language: en-US
To:     Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>
CC:     <linux-kernel@vger.kernel.org>, <linux-arm-msm@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>,
        Tingwei Zhang <quic_tingweiz@quicinc.com>,
        Yuanfang Zhang <quic_yuanfang@quicinc.com>,
        "Tao Zhang" <quic_taozha@quicinc.com>,
        Hao Zhang <quic_hazha@quicinc.com>
References: <20230208124053.18533-1-quic_jinlmao@quicinc.com>
From:   Jinlong Mao <quic_jinlmao@quicinc.com>
In-Reply-To: <20230208124053.18533-1-quic_jinlmao@quicinc.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: tAHVkZwavDN5t4zQShCP2e2FoMrEDeBb
X-Proofpoint-ORIG-GUID: tAHVkZwavDN5t4zQShCP2e2FoMrEDeBb
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-02_06,2023-03-02_02,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0
 lowpriorityscore=0 impostorscore=0 mlxlogscore=999 spamscore=0
 priorityscore=1501 mlxscore=0 clxscore=1015 suspectscore=0 phishscore=0
 adultscore=0 malwarescore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2212070000 definitions=main-2303020108
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Reviewers,

Could you please help to review this patch ?

Thanks
Jinlong Mao

On 2/8/2023 8:40 PM, Mao Jinlong wrote:
> Add MIPI OST protocol support for stm to format the traces.
> Framework copied from drivers/hwtracing/stm.p-sys-t.c as of
> commit d69d5e83110f ("stm class: Add MIPI SyS-T protocol
> support").
>
> Signed-off-by: Tingwei Zhang <quic_tingweiz@quicinc.com>
> Signed-off-by: Mao Jinlong <quic_jinlmao@quicinc.com>
> ---
>   drivers/hwtracing/stm/Kconfig  | 14 +++++
>   drivers/hwtracing/stm/Makefile |  2 +
>   drivers/hwtracing/stm/p_ost.c  | 95 ++++++++++++++++++++++++++++++++++
>   3 files changed, 111 insertions(+)
>   create mode 100644 drivers/hwtracing/stm/p_ost.c
>
> diff --git a/drivers/hwtracing/stm/Kconfig b/drivers/hwtracing/stm/Kconfig
> index aad594fe79cc..0b52901125f7 100644
> --- a/drivers/hwtracing/stm/Kconfig
> +++ b/drivers/hwtracing/stm/Kconfig
> @@ -41,6 +41,20 @@ config STM_PROTO_SYS_T
>   
>   	  If you don't know what this is, say N.
>   
> +config STM_PROTO_OST
> +	tristate "MIPI OST STM framing protocol driver"
> +	default CONFIG_STM
> +	help
> +	  This is an implementation of MIPI OST protocol to be used
> +	  over the STP transport. In addition to the data payload, it
> +	  also carries additional metadata for entity, better
> +	  means of trace source identification, etc.
> +
> +	  The receiving side must be able to decode this protocol in
> +	  addition to the MIPI STP, in order to extract the data.
> +
> +	  If you don't know what this is, say N.
> +
>   config STM_DUMMY
>   	tristate "Dummy STM driver"
>   	help
> diff --git a/drivers/hwtracing/stm/Makefile b/drivers/hwtracing/stm/Makefile
> index 1692fcd29277..715fc721891e 100644
> --- a/drivers/hwtracing/stm/Makefile
> +++ b/drivers/hwtracing/stm/Makefile
> @@ -5,9 +5,11 @@ stm_core-y		:= core.o policy.o
>   
>   obj-$(CONFIG_STM_PROTO_BASIC) += stm_p_basic.o
>   obj-$(CONFIG_STM_PROTO_SYS_T) += stm_p_sys-t.o
> +obj-$(CONFIG_STM_PROTO_OST) += stm_p_ost.o
>   
>   stm_p_basic-y		:= p_basic.o
>   stm_p_sys-t-y		:= p_sys-t.o
> +stm_p_ost-y		:= p_ost.o
>   
>   obj-$(CONFIG_STM_DUMMY)	+= dummy_stm.o
>   
> diff --git a/drivers/hwtracing/stm/p_ost.c b/drivers/hwtracing/stm/p_ost.c
> new file mode 100644
> index 000000000000..2ca1a3fda57f
> --- /dev/null
> +++ b/drivers/hwtracing/stm/p_ost.c
> @@ -0,0 +1,95 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * Copied from drivers/hwtracing/stm.p-sys-t.c as of commit d69d5e83110f
> + * ("stm class: Add MIPI SyS-T protocol support").
> + *
> + * Copyright (c) 2022 Qualcomm Innovation Center, Inc. All rights reserved.
> + * Copyright (c) 2020 The Linux Foundation. All rights reserved.
> + * Copyright (c) 2018, Intel Corporation.
> + *
> + * MIPI OST framing protocol for STM devices.
> + */
> +
> +#include <linux/configfs.h>
> +#include <linux/module.h>
> +#include <linux/device.h>
> +#include <linux/slab.h>
> +#include <linux/stm.h>
> +#include <linux/sched/clock.h>
> +#include "stm.h"
> +
> +#define OST_TOKEN_STARTSIMPLE		(0x10)
> +#define OST_VERSION_MIPI1		(0x10 << 8)
> +#define OST_ENTITY_FTRACE		(0x01 << 16)
> +#define OST_CONTROL_PROTOCOL		(0x0 << 24)
> +
> +#define DATA_HEADER (OST_TOKEN_STARTSIMPLE | OST_VERSION_MIPI1 | \
> +			OST_ENTITY_FTRACE | OST_CONTROL_PROTOCOL)
> +
> +#define STM_MAKE_VERSION(ma, mi)	((ma << 8) | mi)
> +#define STM_HEADER_MAGIC		(0x5953)
> +
> +static ssize_t notrace ost_write(struct stm_data *data,
> +		struct stm_output *output, unsigned int chan,
> +		const char *buf, size_t count)
> +{
> +	unsigned int c = output->channel + chan;
> +	unsigned int m = output->master;
> +	const unsigned char nil = 0;
> +	u32 header = DATA_HEADER;
> +	u8 trc_hdr[24];
> +	ssize_t sz;
> +
> +	/*
> +	 * STP framing rules for OST frames:
> +	 *   * the first packet of the OST frame is marked;
> +	 *   * the last packet is a FLAG.
> +	 */
> +	/* Message layout: HEADER / DATA / TAIL */
> +	/* HEADER */
> +
> +	sz = data->packet(data, m, c, STP_PACKET_DATA, STP_PACKET_MARKED,
> +			  4, (u8 *)&header);
> +	if (sz <= 0)
> +		return sz;
> +	*(uint16_t *)(trc_hdr) = STM_MAKE_VERSION(0, 3);
> +	*(uint16_t *)(trc_hdr + 2) = STM_HEADER_MAGIC;
> +	*(uint32_t *)(trc_hdr + 4) = raw_smp_processor_id();
> +	*(uint64_t *)(trc_hdr + 8) = sched_clock();
> +	*(uint64_t *)(trc_hdr + 16) = task_tgid_nr(get_current());
> +	sz = stm_data_write(data, m, c, false, trc_hdr, sizeof(trc_hdr));
> +	if (sz <= 0)
> +		return sz;
> +
> +	/* DATA */
> +	sz = stm_data_write(data, m, c, false, buf, count);
> +
> +	/* TAIL */
> +	if (sz > 0)
> +		data->packet(data, m, c, STP_PACKET_FLAG,
> +			STP_PACKET_TIMESTAMPED, 0, &nil);
> +
> +	return sz;
> +}
> +
> +static const struct stm_protocol_driver ost_pdrv = {
> +	.owner			= THIS_MODULE,
> +	.name			= "p_ost",
> +	.write			= ost_write,
> +};
> +
> +static int ost_stm_init(void)
> +{
> +	return stm_register_protocol(&ost_pdrv);
> +}
> +
> +static void ost_stm_exit(void)
> +{
> +	stm_unregister_protocol(&ost_pdrv);
> +}
> +
> +module_init(ost_stm_init);
> +module_exit(ost_stm_exit);
> +
> +MODULE_LICENSE("GPL");
> +MODULE_DESCRIPTION("MIPI Open System Trace STM framing protocol driver");
