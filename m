Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D58E26EA439
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Apr 2023 09:01:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230333AbjDUHBo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Apr 2023 03:01:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229659AbjDUHBl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Apr 2023 03:01:41 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 029651BD1;
        Fri, 21 Apr 2023 00:01:39 -0700 (PDT)
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 33L5b7CV002757;
        Fri, 21 Apr 2023 07:01:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=uBwCAYhc6w2JHfeiWLA2s6WEWuJlqJrOu2+OalGBPmg=;
 b=lOvU2kLZ0kA8bRHCdn2shT6zvgUiKpY3OiY1xvFCPVelvuPCFXet9Cuq2vObLqzSQ1wk
 6wfpOpF1DUeZJbbVnVvAIo0MPkxjGzcb++Vr0ZKxwEyCRi+cIxC1jZ70c52eHe3InYCi
 eKC9h5odeB8DVL9LN8/OKt9YrK7FybZTEVjiPVZdV/UuBsceRciolUBVQjxsf92TbA7S
 ysTrw+lFZF9jxisD16iY31XH9admJFFPishQrzwMRu4vHvzem9Pspl8BE/QYZCP9tm42
 uue1yG+M0er2oFGZ8iq8qZo+N1DAlm9ovmC+RvoESFXTMkKYjwXyI/GRsjqq9cMMq3gQ Kw== 
Received: from nasanppmta05.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3q3cpyrxu3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 21 Apr 2023 07:01:24 +0000
Received: from nasanex01c.na.qualcomm.com (nasanex01c.na.qualcomm.com [10.45.79.139])
        by NASANPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 33L71Nl0015109
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 21 Apr 2023 07:01:23 GMT
Received: from [10.216.26.107] (10.80.80.8) by nasanex01c.na.qualcomm.com
 (10.45.79.139) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.42; Fri, 21 Apr
 2023 00:01:15 -0700
Message-ID: <df34031f-18a4-3d1b-120f-3e4ec9015934@quicinc.com>
Date:   Fri, 21 Apr 2023 12:31:12 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH] remoteproc: imx_dsp_rproc: use modern pm_ops
Content-Language: en-US
To:     Arnd Bergmann <arnd@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>
CC:     Arnd Bergmann <arnd@arndb.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Shengjiu Wang <shengjiu.wang@nxp.com>,
        Iuliana Prodan <iuliana.prodan@nxp.com>,
        Daniel Baluta <daniel.baluta@nxp.com>,
        Markus Elfring <Markus.Elfring@web.de>,
        <linux-remoteproc@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
References: <20230420213610.2219080-1-arnd@kernel.org>
From:   Mukesh Ojha <quic_mojha@quicinc.com>
In-Reply-To: <20230420213610.2219080-1-arnd@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01c.na.qualcomm.com (10.45.79.139)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: Rme5vwbtxmrICaMKgAKN2ygabagI5Hzz
X-Proofpoint-ORIG-GUID: Rme5vwbtxmrICaMKgAKN2ygabagI5Hzz
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-04-21_01,2023-04-20_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0
 priorityscore=1501 mlxlogscore=999 spamscore=0 mlxscore=0
 lowpriorityscore=0 clxscore=1011 impostorscore=0 adultscore=0 phishscore=0
 bulkscore=0 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2303200000 definitions=main-2304210060
X-Spam-Status: No, score=-3.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 4/21/2023 3:06 AM, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> Without CONFIG_PM, the driver warns about unused functions:
> 
> drivers/remoteproc/imx_dsp_rproc.c:1210:12: error: 'imx_dsp_runtime_suspend' defined but not used [-Werror=unused-function]
>   1210 | static int imx_dsp_runtime_suspend(struct device *dev)
>        |            ^~~~~~~~~~~~~~~~~~~~~~~
> drivers/remoteproc/imx_dsp_rproc.c:1178:12: error: 'imx_dsp_runtime_resume' defined but not used [-Werror=unused-function]
>   1178 | static int imx_dsp_runtime_resume(struct device *dev)
>        |            ^~~~~~~~~~~~~~~~~~~~~~
> 
> Change the old SET_SYSTEM_SLEEP_PM_OPS()/SET_RUNTIME_PM_OPS()
> helpers to their modern replacements that avoid the warning,
> and remove the now unnecessary __maybe_unused annotations
> on the other PM helper functions.
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>   drivers/remoteproc/imx_dsp_rproc.c | 11 +++++------
>   1 file changed, 5 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/remoteproc/imx_dsp_rproc.c b/drivers/remoteproc/imx_dsp_rproc.c
> index cab06dbf37fb..2d75dea43f20 100644
> --- a/drivers/remoteproc/imx_dsp_rproc.c
> +++ b/drivers/remoteproc/imx_dsp_rproc.c
> @@ -1243,7 +1243,7 @@ static void imx_dsp_load_firmware(const struct firmware *fw, void *context)
>   	release_firmware(fw);
>   }
>   
> -static __maybe_unused int imx_dsp_suspend(struct device *dev)
> +static int imx_dsp_suspend(struct device *dev)
>   {
>   	struct rproc *rproc = dev_get_drvdata(dev);
>   	struct imx_dsp_rproc *priv = rproc->priv;
> @@ -1278,7 +1278,7 @@ static __maybe_unused int imx_dsp_suspend(struct device *dev)
>   	return pm_runtime_force_suspend(dev);
>   }
>   
> -static __maybe_unused int imx_dsp_resume(struct device *dev)
> +static int imx_dsp_resume(struct device *dev)
>   {
>   	struct rproc *rproc = dev_get_drvdata(dev);
>   	int ret = 0;
> @@ -1312,9 +1312,8 @@ static __maybe_unused int imx_dsp_resume(struct device *dev)
>   }
>   
>   static const struct dev_pm_ops imx_dsp_rproc_pm_ops = {
> -	SET_SYSTEM_SLEEP_PM_OPS(imx_dsp_suspend, imx_dsp_resume)
> -	SET_RUNTIME_PM_OPS(imx_dsp_runtime_suspend,
> -			   imx_dsp_runtime_resume, NULL)
> +	SYSTEM_SLEEP_PM_OPS(imx_dsp_suspend, imx_dsp_resume)
> +	RUNTIME_PM_OPS(imx_dsp_runtime_suspend, imx_dsp_runtime_resume, NULL)
>   };
>   
>   static const struct of_device_id imx_dsp_rproc_of_match[] = {
> @@ -1332,7 +1331,7 @@ static struct platform_driver imx_dsp_rproc_driver = {
>   	.driver = {
>   		.name = "imx-dsp-rproc",
>   		.of_match_table = imx_dsp_rproc_of_match,
> -		.pm = &imx_dsp_rproc_pm_ops,
> +		.pm = pm_ptr(&imx_dsp_rproc_pm_ops),

LGTM.
Reviewed-by: Mukesh Ojha <quic_mojha@quicinc.com>

-Mukesh
>   	},
>   };
>   module_platform_driver(imx_dsp_rproc_driver);
