Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B5A66E76D5
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Apr 2023 11:54:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232739AbjDSJyj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Apr 2023 05:54:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229617AbjDSJy3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Apr 2023 05:54:29 -0400
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com [185.132.182.106])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2FB7106;
        Wed, 19 Apr 2023 02:54:27 -0700 (PDT)
Received: from pps.filterd (m0241204.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 33J8Zxxm024719;
        Wed, 19 Apr 2023 11:53:57 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=selector1;
 bh=r5fGeSW1qloHrllhhlo+1StgRSiMEfN93pArR9r/3Tk=;
 b=HebYnIq01lJcOXuvSb6RCmdS3d553pbOold+KHzM7/njzlKhUMWDYAkX6aVqQ975v+Vj
 X8jHNdye9JJRG40kMPAN+TazC0zMOKqCMFoZv8P/W8bMkCDhADTCRamoOfsl4BpiY8s6
 r3S9eITTMbqm1OWVFKYv92iDOSHA5nOd+qm5/bUETdzF66FNpJ2LwItwschptBjrhHhM
 N6cLo9svfpz6whnKOWkOd8GO9+AU4Tcu28ObLK0/I9eyhilLr/akeKBry53qzWEr4gd1
 KRGmbEnuLx6q53idk1hfN3SnC5EFwqz/pAOyqqIP8l6k6G85CE1srq4Ne3fun1lfyFry Ww== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3q10ve8k1h-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 19 Apr 2023 11:53:57 +0200
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id DF6FF10002A;
        Wed, 19 Apr 2023 11:53:50 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node2.st.com [10.75.129.70])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id B8D7C214D29;
        Wed, 19 Apr 2023 11:53:50 +0200 (CEST)
Received: from [10.201.21.178] (10.201.21.178) by SHFDAG1NODE2.st.com
 (10.75.129.70) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.21; Wed, 19 Apr
 2023 11:53:49 +0200
Message-ID: <0543735a-5f0c-bdf4-2a89-e94841bd4a68@foss.st.com>
Date:   Wed, 19 Apr 2023 11:53:49 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH V5 1/3] rpmsg: core: Add signal API support
Content-Language: en-US
To:     Sarannya S <quic_sarannya@quicinc.com>,
        <quic_bjorande@quicinc.com>, <swboyd@chromium.org>,
        <quic_clew@quicinc.com>, <mathieu.poirier@linaro.org>
CC:     <linux-kernel@vger.kernel.org>, <linux-arm-msm@vger.kernel.org>,
        <linux-remoteproc@vger.kernel.org>,
        Deepak Kumar Singh <quic_deesin@quicinc.com>,
        Bjorn Andersson <andersson@kernel.org>
References: <1681807721-32343-1-git-send-email-quic_sarannya@quicinc.com>
 <1681807721-32343-2-git-send-email-quic_sarannya@quicinc.com>
From:   Arnaud POULIQUEN <arnaud.pouliquen@foss.st.com>
Organization: STMicroelectronics
In-Reply-To: <1681807721-32343-2-git-send-email-quic_sarannya@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.201.21.178]
X-ClientProxiedBy: EQNCAS1NODE4.st.com (10.75.129.82) To SHFDAG1NODE2.st.com
 (10.75.129.70)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-04-19_06,2023-04-18_01,2023-02-09_01
X-Spam-Status: No, score=-5.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,


On 4/18/23 10:48, Sarannya S wrote:
> From: Deepak Kumar Singh <quic_deesin@quicinc.com>
> 
> Some transports like Glink support the state notifications between
> clients using flow control signals similar to serial protocol signals.
> Local glink client drivers can send and receive flow control status
> to glink clients running on remote processors.
> 
> Add APIs to support sending and receiving of flow control status by
> rpmsg clients.
> 
> Signed-off-by: Deepak Kumar Singh <quic_deesin@quicinc.com>
> Signed-off-by: Sarannya S <quic_sarannya@quicinc.com>
> ---
>  drivers/rpmsg/rpmsg_core.c     | 20 ++++++++++++++++++++
>  drivers/rpmsg/rpmsg_internal.h |  2 ++
>  2 files changed, 22 insertions(+)
> 
> diff --git a/drivers/rpmsg/rpmsg_core.c b/drivers/rpmsg/rpmsg_core.c
> index a2207c0..86b4912 100644
> --- a/drivers/rpmsg/rpmsg_core.c
> +++ b/drivers/rpmsg/rpmsg_core.c
> @@ -331,6 +331,24 @@ int rpmsg_trysend_offchannel(struct rpmsg_endpoint *ept, u32 src, u32 dst,
>  EXPORT_SYMBOL(rpmsg_trysend_offchannel);
>  
>  /**
> + * rpmsg_set_flow_control() - sets/clears serial flow control signals
> + * @ept:	the rpmsg endpoint
> + * @enable:	pause/resume incoming data flow
> + *
> + * Return: 0 on success and an appropriate error value on failure.
> + */
> +int rpmsg_set_flow_control(struct rpmsg_endpoint *ept, bool enable)


Regression since V4[1]

In V4 version the function was:

int rpmsg_set_flow_control(struct rpmsg_endpoint *ept, bool enable, u32 dst)

Following comments on V3 [2]

Without dst parameter it is not compatible with the rpmsg_virtio backend


[1]https://lkml.org/lkml/2022/12/7/506
[2]https://www.spinics.net/lists/kernel/msg4573082.html

Regards
Arnaud

> +{
> +	if (WARN_ON(!ept))
> +		return -EINVAL;
> +	if (!ept->ops->set_flow_control)
> +		return -ENXIO;
> +
> +	return ept->ops->set_flow_control(ept, enable);
> +}
> +EXPORT_SYMBOL(rpmsg_set_flow_control);
> +
> +/**
>   * rpmsg_get_mtu() - get maximum transmission buffer size for sending message.
>   * @ept: the rpmsg endpoint
>   *
> @@ -539,6 +557,8 @@ static int rpmsg_dev_probe(struct device *dev)
>  
>  		rpdev->ept = ept;
>  		rpdev->src = ept->addr;
> +
> +		ept->flow_cb = rpdrv->flowcontrol;
>  	}
>  
>  	err = rpdrv->probe(rpdev);
> diff --git a/drivers/rpmsg/rpmsg_internal.h b/drivers/rpmsg/rpmsg_internal.h
> index 39b646d..4fea45a 100644
> --- a/drivers/rpmsg/rpmsg_internal.h
> +++ b/drivers/rpmsg/rpmsg_internal.h
> @@ -55,6 +55,7 @@ struct rpmsg_device_ops {
>   * @trysendto:		see @rpmsg_trysendto(), optional
>   * @trysend_offchannel:	see @rpmsg_trysend_offchannel(), optional
>   * @poll:		see @rpmsg_poll(), optional
> + * @set_flow_control:	see @rpmsg_set_flow_control(), optional
>   * @get_mtu:		see @rpmsg_get_mtu(), optional
>   *
>   * Indirection table for the operations that a rpmsg backend should implement.
> @@ -75,6 +76,7 @@ struct rpmsg_endpoint_ops {
>  			     void *data, int len);
>  	__poll_t (*poll)(struct rpmsg_endpoint *ept, struct file *filp,
>  			     poll_table *wait);
> +	int (*set_flow_control)(struct rpmsg_endpoint *ept, bool enable);
>  	ssize_t (*get_mtu)(struct rpmsg_endpoint *ept);
>  };
>  
