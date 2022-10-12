Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6AD555FC2F3
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Oct 2022 11:19:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229677AbiJLJTv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Oct 2022 05:19:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229887AbiJLJT0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Oct 2022 05:19:26 -0400
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com [185.132.182.106])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9B43BD069;
        Wed, 12 Oct 2022 02:19:15 -0700 (PDT)
Received: from pps.filterd (m0241204.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 29C93s5T002826;
        Wed, 12 Oct 2022 11:18:47 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=message-id : date :
 mime-version : subject : to : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=selector1;
 bh=QeR3StUuPI4Ywk33EQuu/st80pAWGF0S/quurB7Ni1I=;
 b=k0HWvn+3u29vlgk7no3ReOnv3TShymClSjjdusvbSokuG2dlmJ388UIWNh9HKx8Up2DF
 PpwAPS7XhV3D37a4Cu2N1pJ9xJeShG0klxdlrGwouyYAU5UkYiegV5g2w6P8cHIFXCL5
 exkqUXCQaKX+BBn8hPBY39oxW2EFgoiuGAqSCITbi7jD5uD/vc/fNdnUo2x0rDOuP5Xz
 CrJ1XVOfdv54/x1iuRJUV5NerD3f/nOh5TWboJs4NvrmBoDK54z7ZG+JyJ6VVykG7pOC
 xu9CtXxO7dDFfYNP3CLSzwQsT0W0cMMn4t//znz6fHEQq9dRPpfbrXbM2Bktjymu9jg5 dw== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3k5tmag3rd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 12 Oct 2022 11:18:47 +0200
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 0BE43100034;
        Wed, 12 Oct 2022 11:18:42 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node2.st.com [10.75.129.70])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 05DBD2194F3;
        Wed, 12 Oct 2022 11:18:42 +0200 (CEST)
Received: from [10.201.22.54] (10.75.127.123) by SHFDAG1NODE2.st.com
 (10.75.129.70) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.2375.31; Wed, 12 Oct
 2022 11:18:38 +0200
Message-ID: <48b74c23-7d11-deff-8bf7-0dfb45c80e37@foss.st.com>
Date:   Wed, 12 Oct 2022 11:18:37 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [PATCH v2] remoteproc: imx_dsp_rproc: Add mutex protection for
 workqueue
Content-Language: en-US
To:     Shengjiu Wang <shengjiu.wang@nxp.com>, <andersson@kernel.org>,
        <mathieu.poirier@linaro.org>, <shawnguo@kernel.org>,
        <s.hauer@pengutronix.de>, <kernel@pengutronix.de>,
        <festevam@gmail.com>, <linux-imx@nxp.com>,
        <linux-remoteproc@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <shengjiu.wang@gmail.com>
References: <1664524216-19949-1-git-send-email-shengjiu.wang@nxp.com>
From:   Arnaud POULIQUEN <arnaud.pouliquen@foss.st.com>
In-Reply-To: <1664524216-19949-1-git-send-email-shengjiu.wang@nxp.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.75.127.123]
X-ClientProxiedBy: GPXDAG2NODE4.st.com (10.75.127.68) To SHFDAG1NODE2.st.com
 (10.75.129.70)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-10-12_04,2022-10-11_02,2022-06-22_01
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mathieu,

On 9/30/22 09:50, Shengjiu Wang wrote:
> The workqueue may execute late even after remoteproc is stopped or
> stopping, some resources (rpmsg device and endpoint) have been
> released in rproc_stop_subdevices(), then rproc_vq_interrupt()
> accessing these resources will cause kennel dump.
> 
> Call trace:
>  virtqueue_add_split+0x1ac/0x560
>  virtqueue_add_inbuf+0x4c/0x60
>  rpmsg_recv_done+0x15c/0x294
>  vring_interrupt+0x6c/0xa4
>  rproc_vq_interrupt+0x30/0x50
>  imx_dsp_rproc_vq_work+0x24/0x40 [imx_dsp_rproc]
>  process_one_work+0x1d0/0x354
>  worker_thread+0x13c/0x470
>  kthread+0x154/0x160
>  ret_from_fork+0x10/0x20
> 
> Add mutex protection in imx_dsp_rproc_vq_work(), if the state is
> not running, then just skip calling rproc_vq_interrupt().
> 
> Also the flush workqueue operation can't be added in rproc stop
> for the same reason. The call sequence is
> 
> rproc_shutdown
> -> rproc_stop
>    ->rproc_stop_subdevices
>    ->rproc->ops->stop()
>      ->imx_dsp_rproc_stop
>        ->flush_work
>          -> rproc_vq_interrupt
> 
> The resource needed by rproc_vq_interrupt has been released in
> rproc_stop_subdevices, so flush_work is not safe to be called in
> imx_dsp_rproc_stop.
> 
> Fixes: ec0e5549f358 ("remoteproc: imx_dsp_rproc: Add remoteproc driver for DSP on i.MX")
> Signed-off-by: Shengjiu Wang <shengjiu.wang@nxp.com>
> Reviewed-by: Peng Fan <peng.fan@nxp.com>
> ---
> changes in v2:
> - update commit message
> 
>  drivers/remoteproc/imx_dsp_rproc.c | 12 +++++++++---
>  1 file changed, 9 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/remoteproc/imx_dsp_rproc.c b/drivers/remoteproc/imx_dsp_rproc.c
> index 899aa8dd12f0..95da1cbefacf 100644
> --- a/drivers/remoteproc/imx_dsp_rproc.c
> +++ b/drivers/remoteproc/imx_dsp_rproc.c
> @@ -347,9 +347,6 @@ static int imx_dsp_rproc_stop(struct rproc *rproc)
>  	struct device *dev = rproc->dev.parent;
>  	int ret = 0;
>  
> -	/* Make sure work is finished */
> -	flush_work(&priv->rproc_work);
> -
>  	if (rproc->state == RPROC_CRASHED) {
>  		priv->flags &= ~REMOTE_IS_READY;
>  		return 0;
> @@ -432,9 +429,18 @@ static void imx_dsp_rproc_vq_work(struct work_struct *work)
>  {
>  	struct imx_dsp_rproc *priv = container_of(work, struct imx_dsp_rproc,
>  						  rproc_work);
> +	struct rproc *rproc = priv->rproc;
> +
> +	mutex_lock(&rproc->lock);
> +
> +	if (rproc->state != RPROC_RUNNING)
> +		goto unlock_mutex;
>  
>  	rproc_vq_interrupt(priv->rproc, 0);
>  	rproc_vq_interrupt(priv->rproc, 1);
> +
> +unlock_mutex:
> +	mutex_unlock(&rproc->lock);
>  }

I guess that this fix the issue in case of the use of a work queue for the
notification.

As I reproduced the issue on stm32 only one time without fix,
difficult for me to test the fix...

I also have a look on some other drivers
It seems not applicable for some other drivers such as TI k3 R5[1]
that call virtio under interrupt context ( if I have well understood).

An alternative to try to fix that in a more generic way could be to call
rproc_remove_virtio_dev in the subdev->unprepare, instead of subdev->stop.
This should postpone the virtio unregister after the stop of the coprocessor.

Of course it is only a suggestion/area of improvement, this fix LGTM.

[1]https://elixir.bootlin.com/linux/v6.0/source/drivers/remoteproc/ti_k3_r5_remoteproc.c#L180

Regards,
Arnaud


>  
>  /**
