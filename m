Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 118C76A0BEA
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Feb 2023 15:33:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234796AbjBWOdK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Feb 2023 09:33:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234792AbjBWOdE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Feb 2023 09:33:04 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9303274AF;
        Thu, 23 Feb 2023 06:32:55 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id BA9CA616E2;
        Thu, 23 Feb 2023 14:32:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 49193C433D2;
        Thu, 23 Feb 2023 14:32:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1677162774;
        bh=gNNdWZmSnvJsti4zk5f1OLxK35c7uhHXrsizeglWw/Q=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=pahXcyGERGcx/44T96g3pceZtKetLxpjXRGE+3vb9hrruivRdyv6aIKnhDcNUV4Am
         /G00GNu169iGMoBGekpCCJMyKHwOo5oVIcIiT6uS4s7Lzlj+bQn8n0v1skh9Zc6Tvf
         uh+3QyBNzahO7+P7dG9OjWT0bOWHx6w4t9VT3TtPt/LVltoVbjXRsLWlbA/9BXV+nM
         lEbQ8mNu6FtQSQu2AMTnxgLmhHK8uNCzwPHOOIFnXmdsdFB4dVl6Vc0N1WlEU6jXmK
         G5TiEIGJupGoxzUyFMZ89jEXkJimPrgVDD2lW0p60oAMxcyVXVyILn1mZct1DgFRHK
         brXh+nqshvc0A==
Date:   Thu, 23 Feb 2023 06:36:21 -0800
From:   Bjorn Andersson <andersson@kernel.org>
To:     Mukesh Ojha <quic_mojha@quicinc.com>
Cc:     agross@kernel.org, konrad.dybcio@linaro.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/4] firmware: qcom_scm: Refactor code to support
 multiple download mode
Message-ID: <20230223143621.bhwo6zzqaokkzekh@ripper>
References: <1676990381-18184-1-git-send-email-quic_mojha@quicinc.com>
 <1676990381-18184-4-git-send-email-quic_mojha@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1676990381-18184-4-git-send-email-quic_mojha@quicinc.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 21, 2023 at 08:09:40PM +0530, Mukesh Ojha wrote:
> Currently on Qualcomm SoC, download_mode is enabled if
> CONFIG_QCOM_SCM_DOWNLOAD_MODE_DEFAULT is selected. Refactor
> the code such that it supports multiple download modes and
> drop the config.
> 
> Signed-off-by: Mukesh Ojha <quic_mojha@quicinc.com>
> ---
>  drivers/firmware/Kconfig    | 11 -----------
>  drivers/firmware/qcom_scm.c | 45 +++++++++++++++++++++++++++++++++++++++------
>  include/linux/qcom_scm.h    |  4 ++++
>  3 files changed, 43 insertions(+), 17 deletions(-)
> 
> diff --git a/drivers/firmware/Kconfig b/drivers/firmware/Kconfig
> index b59e304..ff7e9f3 100644
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
> index c376ba8..4975d3c 100644
> --- a/drivers/firmware/qcom_scm.c
> +++ b/drivers/firmware/qcom_scm.c
> @@ -20,8 +20,43 @@
>  
>  #include "qcom_scm.h"
>  
> -static bool download_mode = IS_ENABLED(CONFIG_QCOM_SCM_DOWNLOAD_MODE_DEFAULT);
> -module_param(download_mode, bool, 0);
> +static unsigned int download_mode;
> +static struct qcom_scm *__scm;
> +static void qcom_scm_set_download_mode(bool enable);
> +static int set_dload_mode(const char *val, const struct kernel_param *kp)
> +{
> +	int ret;
> +	int old_mode = download_mode;
> +
> +	ret = param_set_int(val, kp);
> +	if (ret)
> +		return ret;
> +
> +	switch (download_mode) {
> +	case QCOM_DOWNLOAD_FULLDUMP:
> +		if (__scm)

If you, as I ask below, pass download_mode to
qcom_scm_set_download_mode(), you could replace this switch statement
with just:

if (__scm)
	qcom_scm_set_download_mode(download_mode);

> +			qcom_scm_set_download_mode(true);
> +		break;
> +	case QCOM_DOWNLOAD_NODUMP:
> +		if (__scm)
> +			qcom_scm_set_download_mode(false);
> +		break;
> +	default:

Please sanity check val before param_set_int() above instead.

> +		pr_err("unknown download mode\n");
> +		download_mode = old_mode;
> +		return -EINVAL;
> +	}
> +
> +	return 0;
> +}
> +
> +static const struct kernel_param_ops dload_mode_param_ops = {
> +	.set = set_dload_mode,
> +	.get = param_get_hexint,
> +};
> +module_param_cb(download_mode, &dload_mode_param_ops, &download_mode, 0644);
> +MODULE_PARM_DESC(download_mode,
> +		 "Download mode: 0x0=no dump mode (default), 0x10=full dump mode");

The module parameters are an interface for humans, so rather than
forcing the operator to play with magical numbers; how about accepting
the values "off", "full" and "minidump"? (And accepting 0 and 1 for any
existing users).

>  
>  #define SCM_HAS_CORE_CLK	BIT(0)
>  #define SCM_HAS_IFACE_CLK	BIT(1)
> @@ -70,8 +105,6 @@ static const char * const qcom_scm_convention_names[] = {
>  	[SMC_CONVENTION_LEGACY] = "smc legacy",
>  };
>  
> -static struct qcom_scm *__scm;
> -
>  static int qcom_scm_clk_enable(void)
>  {
>  	int ret;
> @@ -435,8 +468,8 @@ static void qcom_scm_set_download_mode(bool enable)
>  		}
>  
>  		ret = qcom_scm_io_writel(__scm->dload_mode_addr, enable ?
> -				dload_addr_val | QCOM_SCM_BOOT_SET_DLOAD_MODE :
> -				dload_addr_val & ~(QCOM_SCM_BOOT_SET_DLOAD_MODE));
> +				((dload_addr_val & ~QCOM_DOWNLOAD_MODE_MASK) | download_mode) :

You're passing 2 pieces of information from set_dload_mode(), one by
argument and one through a global variable - and currently they carry
the same "information", in the next patch enable will be !!download_mode.

Please pass download_mode (u32 mode) as an argument to the function -
even if it's accessible in the global scope.

> +				dload_addr_val & ~QCOM_DOWNLOAD_MODE_MASK);
>  	} else {
>  		dev_err(__scm->dev,
>  			"No available mechanism for setting download mode\n");
> diff --git a/include/linux/qcom_scm.h b/include/linux/qcom_scm.h
> index f833564..dd6aced 100644
> --- a/include/linux/qcom_scm.h
> +++ b/include/linux/qcom_scm.h
> @@ -14,6 +14,10 @@
>  #define QCOM_SCM_CPU_PWR_DOWN_L2_OFF	0x1
>  #define QCOM_SCM_HDCP_MAX_REQ_CNT	5
>  
> +#define QCOM_DOWNLOAD_MODE_MASK 0x30
> +#define QCOM_DOWNLOAD_NODUMP	0x0
> +#define QCOM_DOWNLOAD_FULLDUMP	0x10

I don't see who the intended user of these constants are, please move
them into qcom_scm.c.

Thanks,
Bjorn

> +
>  struct qcom_scm_hdcp_req {
>  	u32 addr;
>  	u32 val;
> -- 
> 2.7.4
> 
