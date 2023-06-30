Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A825574342F
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Jun 2023 07:26:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232097AbjF3F0V (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Jun 2023 01:26:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231927AbjF3F0P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Jun 2023 01:26:15 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 522AC3583;
        Thu, 29 Jun 2023 22:26:14 -0700 (PDT)
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 35U5O1Zr014109;
        Fri, 30 Jun 2023 05:25:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=date : from : to :
 cc : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=qcppdkim1; bh=HFQXNzIcvaGV8VLNOglVGjxnRqTQMHy3qp9WNXgE8fw=;
 b=IsyOnS5raZ1GJglVGuGBhJhzEUxls0AnM50+kxJeEromMzlxvzuNznVo+qxLkLTgOB0u
 JQ/KYM7IGrvrZ5x1k4ixfXrguYSoDn+afoImKvhXznwj0PPU21ozwHD7nFxlCt4XwWME
 cRC/jC4UsisD+BVjt1j9a635fg5rR99/vmJtLNF6MVY3pjsbIZqtACkQAdA9Mr7ZynmL
 0w0wtoWmAqmTFWhQEoz7ZH4gT/JbHWzcHh3u3aqg2dj1LQH7p33YsBLKgKw4b+sZl6yA
 pBC6qVjkvwbBStQIya0P0AzL0TjI81aVouqyECFzJnLCEws9dzk75patM2WTMIKvo4me 1w== 
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3rh2ks2kj4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 30 Jun 2023 05:25:54 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 35U5PrmQ009221
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 30 Jun 2023 05:25:53 GMT
Received: from hu-pkondeti-hyd.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.7; Thu, 29 Jun 2023 22:25:46 -0700
Date:   Fri, 30 Jun 2023 10:55:39 +0530
From:   Pavan Kondeti <quic_pkondeti@quicinc.com>
To:     Mukesh Ojha <quic_mojha@quicinc.com>
CC:     <corbet@lwn.net>, <agross@kernel.org>, <andersson@kernel.org>,
        <konrad.dybcio@linaro.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
        <keescook@chromium.org>, <tony.luck@intel.com>,
        <gpiccoli@igalia.com>, <mathieu.poirier@linaro.org>,
        <catalin.marinas@arm.com>, <will@kernel.org>,
        <linus.walleij@linaro.org>, <andy.shevchenko@gmail.com>,
        <linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-msm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-hardening@vger.kernel.org>,
        <linux-remoteproc@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-gpio@vger.kernel.org>
Subject: Re: [PATCH v4 20/21] firmware: qcom_scm: Refactor code to support
 multiple download mode
Message-ID: <0ac3e4cd-485e-43a4-ae76-4c462a8145ed@quicinc.com>
References: <1687955688-20809-1-git-send-email-quic_mojha@quicinc.com>
 <1687955688-20809-21-git-send-email-quic_mojha@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <1687955688-20809-21-git-send-email-quic_mojha@quicinc.com>
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: aNMQl7VkIbhpDKzXPC8P1qvAgPDdSJEs
X-Proofpoint-ORIG-GUID: aNMQl7VkIbhpDKzXPC8P1qvAgPDdSJEs
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-06-30_02,2023-06-27_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 adultscore=0 bulkscore=0 malwarescore=0 phishscore=0 impostorscore=0
 mlxlogscore=999 clxscore=1015 spamscore=0 lowpriorityscore=0
 suspectscore=0 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2305260000 definitions=main-2306300046
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 28, 2023 at 06:04:47PM +0530, Mukesh Ojha wrote:
> Currently on Qualcomm SoC, download_mode is enabled if
> CONFIG_QCOM_SCM_DOWNLOAD_MODE_DEFAULT is selected.
> 
> Refactor the code such that it supports multiple download
> modes and drop CONFIG_QCOM_SCM_DOWNLOAD_MODE_DEFAULT config
> instead, give interface to set the download mode from
> module parameter.
> 
> Signed-off-by: Mukesh Ojha <quic_mojha@quicinc.com>
> ---
>  drivers/firmware/Kconfig    | 11 ---------
>  drivers/firmware/qcom_scm.c | 56 +++++++++++++++++++++++++++++++++++++++------
>  2 files changed, 49 insertions(+), 18 deletions(-)
> 
> diff --git a/drivers/firmware/Kconfig b/drivers/firmware/Kconfig
> index b59e3041fd62..ff7e9f330559 100644
> --- a/drivers/firmware/Kconfig
> +++ b/drivers/firmware/Kconfig
> @@ -215,17 +215,6 @@ config MTK_ADSP_IPC
>  config QCOM_SCM
>  	tristate
>  
> -config QCOM_SCM_DOWNLOAD_MODE_DEFAULT
> -	bool "Qualcomm download mode enabled by default"
> -	depends on QCOM_SCM
> -	help
> -	  A device with "download mode" enabled will upon an unexpected
> -	  warm-restart enter a special debug mode that allows the user to
> -	  "download" memory content over USB for offline postmortem analysis.
> -	  The feature can be enabled/disabled on the kernel command line.
> -
> -	  Say Y here to enable "download mode" by default.
> -
>  config SYSFB
>  	bool
>  	select BOOT_VESA_SUPPORT
> diff --git a/drivers/firmware/qcom_scm.c b/drivers/firmware/qcom_scm.c
> index a9ff77d16c42..946cb0f76a17 100644
> --- a/drivers/firmware/qcom_scm.c
> +++ b/drivers/firmware/qcom_scm.c
> @@ -18,13 +18,13 @@
>  #include <linux/of_irq.h>
>  #include <linux/of_platform.h>
>  #include <linux/clk.h>
> +#include <linux/kstrtox.h>
>  #include <linux/reset-controller.h>
>  #include <linux/arm-smccc.h>
>  
>  #include "qcom_scm.h"
>  
> -static bool download_mode = IS_ENABLED(CONFIG_QCOM_SCM_DOWNLOAD_MODE_DEFAULT);
> -module_param(download_mode, bool, 0);
> +static u32 download_mode;
>  
>  #define SCM_HAS_CORE_CLK	BIT(0)
>  #define SCM_HAS_IFACE_CLK	BIT(1)
> @@ -82,6 +82,11 @@ static const char * const qcom_scm_convention_names[] = {
>  	[SMC_CONVENTION_LEGACY] = "smc legacy",
>  };
>  
> +static const char * const download_mode_name[] = {
> +	[QCOM_DOWNLOAD_NODUMP]	 = "off",
> +	[QCOM_DOWNLOAD_FULLDUMP] = "full",
> +};
> +
>  static struct qcom_scm *__scm;
>  
>  static int qcom_scm_clk_enable(void)
> @@ -442,8 +447,9 @@ static int __qcom_scm_set_dload_mode(struct device *dev, bool enable)
>  	return qcom_scm_call_atomic(__scm->dev, &desc, NULL);
>  }
>  
> -static void qcom_scm_set_download_mode(bool enable)
> +static void qcom_scm_set_download_mode(u32 download_mode)
>  {
> +	bool enable = !!download_mode;
>  	bool avail;
>  	int val;
>  	int ret = 0;
> @@ -454,7 +460,7 @@ static void qcom_scm_set_download_mode(bool enable)
>  	if (avail) {
>  		ret = __qcom_scm_set_dload_mode(__scm->dev, enable);
>  	} else if (__scm->dload_mode_addr) {
> -		val = (enable ? QCOM_DOWNLOAD_FULLDUMP : QCOM_DOWNLOAD_NODUMP);
> +		val = download_mode;
>  		val <<= QCOM_DOWNLOAD_MODE_SHIFT;
>  		ret = qcom_scm_io_update_field(__scm->dload_mode_addr,
>  				QCOM_DOWNLOAD_MODE_MASK, val);
> @@ -1425,6 +1431,42 @@ static irqreturn_t qcom_scm_irq_handler(int irq, void *data)
>  	return IRQ_HANDLED;
>  }
>  
> +static int get_download_mode(char *buffer, const struct kernel_param *kp)
> +{
> +	if (download_mode >= ARRAY_SIZE(download_mode_name))
> +		return sysfs_emit(buffer, "unknown mode\n");
> +
> +	return sysfs_emit(buffer, "%s\n", download_mode_name[download_mode]);
> +}
> +
> +static int set_download_mode(const char *val, const struct kernel_param *kp)
> +{
> +	u32 old = download_mode;
> +	int ret;
> +
> +	ret = sysfs_match_string(download_mode_name, val);
> +	if (ret < 0) {
> +		download_mode = old;
> +		pr_err("qcom_scm: unknown download mode: %s\n", val);
> +		return -EINVAL;
> +	}

minor nit: %s/-EINVAL/ret 

> +
> +	download_mode = ret;
> +	if (__scm)
> +		qcom_scm_set_download_mode(download_mode);
> +
> +	return 0;
> +}
> +
> +static const struct kernel_param_ops download_mode_param_ops = {
> +	.get = get_download_mode,
> +	.set = set_download_mode,
> +};
> +
> +module_param_cb(download_mode, &download_mode_param_ops, NULL, 0644);
> +MODULE_PARM_DESC(download_mode,
> +		"download mode: off/full are acceptable values");
> +

Since we are adding a sysfs file under /sys/module/qcom_scm/ , does it
need to be documented under ABI?

Thanks,
Pavan
