Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 58E576A0894
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Feb 2023 13:26:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233811AbjBWM0Y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Feb 2023 07:26:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229448AbjBWM0W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Feb 2023 07:26:22 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D2194C6FE
        for <linux-kernel@vger.kernel.org>; Thu, 23 Feb 2023 04:25:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1677155135;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Vlhfn8tA0IPcHcqagD5wqt5nb53wGseGUDE2K0I/G38=;
        b=PY8XLGoeE7IvxUT7njHAJLpnBAiIsnziHijwW9WWVOLi8prRnibTv2qyYu3/yRhMUmhlQz
        3Ed1qaDy9fDqHHxzeYbVFI+oq65TYsWE8K5w0R4OAe56RxuDfRoGDFBPMiezN0G+m0b32y
        Zabi5fzJAH2zD6H5AB3ktOZ41s329As=
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com
 [209.85.166.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-321--TC6XFcAOXyM3q3KGLBCGA-1; Thu, 23 Feb 2023 07:25:34 -0500
X-MC-Unique: -TC6XFcAOXyM3q3KGLBCGA-1
Received: by mail-io1-f70.google.com with SMTP id z5-20020a6b5c05000000b007447572f3f8so6056451ioh.3
        for <linux-kernel@vger.kernel.org>; Thu, 23 Feb 2023 04:25:33 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Vlhfn8tA0IPcHcqagD5wqt5nb53wGseGUDE2K0I/G38=;
        b=gtZZPRZr0RGQcwP8nYT42xRaPWtP/v9S7l2OiffOPcf50AI0ppyaQuY3MsAPir890k
         aeNtObAKXV8hzZp07bk8wWl9xwXlRW6ALKcjFmQdTLzsoRfuoAreJ2OEkCtMoT+M6bXV
         drNIEyVp1+AVE5zIDGpAe4XPXZShBxnLE1BE2YJ2NnrGKNbqvhMaa+RuVdG3e1MgkaH8
         cICBGaq/8wlY1g/tZ6YxK6AW+SGfcKOimk+IL5x8HyjeJazjaf6G+S4Zw7q454Unyx5W
         EFKQi/PkGBnFepgXV1cpwPiy1holuqrLmM8C/YmtKnsmNiHDxERaOzV0A6QAfCU7ydy6
         +XxQ==
X-Gm-Message-State: AO0yUKUrk0ekfTWI9CDDZQPHXMC+cZo7K/U1Yf7LLgc74OSDiqJnpIfS
        ufzTn56r0zK+Fa0CtWnvjda/AmAq5INVrGo4Kt9SuXKJzl5htUBr4fgeZPkfkRcHIs+D3ZcgNOx
        iNJ8OjelZ1dp+Llv9tJNEk77x
X-Received: by 2002:a92:ca0e:0:b0:316:e3a0:723f with SMTP id j14-20020a92ca0e000000b00316e3a0723fmr7133177ils.17.1677155133374;
        Thu, 23 Feb 2023 04:25:33 -0800 (PST)
X-Google-Smtp-Source: AK7set9J9K5vAM+Z307Jj89Gj1T2DAVET7LqPbgfFcmJRdfj00zhduzFv3Ng2Go6ZPSOmGI1agMwYQ==
X-Received: by 2002:a92:ca0e:0:b0:316:e3a0:723f with SMTP id j14-20020a92ca0e000000b00316e3a0723fmr7133160ils.17.1677155133128;
        Thu, 23 Feb 2023 04:25:33 -0800 (PST)
Received: from x1 (c-73-214-169-22.hsd1.pa.comcast.net. [73.214.169.22])
        by smtp.gmail.com with ESMTPSA id b16-20020a029a10000000b003c2bb1bd5a4sm1228446jal.34.2023.02.23.04.25.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Feb 2023 04:25:32 -0800 (PST)
Date:   Thu, 23 Feb 2023 07:25:30 -0500
From:   Brian Masney <bmasney@redhat.com>
To:     Mukesh Ojha <quic_mojha@quicinc.com>
Cc:     agross@kernel.org, andersson@kernel.org, konrad.dybcio@linaro.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/4] firmware: qcom_scm: Refactor code to support
 multiple download mode
Message-ID: <Y/dbOtOHHAihhw87@x1>
References: <1676990381-18184-1-git-send-email-quic_mojha@quicinc.com>
 <1676990381-18184-4-git-send-email-quic_mojha@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1676990381-18184-4-git-send-email-quic_mojha@quicinc.com>
User-Agent: Mutt/2.2.7 (2022-08-07)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
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

Add newline. Also, moving __scm wasn't called out in the commit
description.

> +static void qcom_scm_set_download_mode(bool enable);
> +static int set_dload_mode(const char *val, const struct kernel_param *kp)

Can set_dload_mode() be placed after qcom_scm_set_download_mode() so
that you don't need to declare it before hand.

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
> +			qcom_scm_set_download_mode(true);
> +		break;
> +	case QCOM_DOWNLOAD_NODUMP:
> +		if (__scm)
> +			qcom_scm_set_download_mode(false);
> +		break;
> +	default:
> +		pr_err("unknown download mode\n");
> +		download_mode = old_mode;
> +		return -EINVAL;

param_set_int() has been called already and has the invalid value. I
think the param_set_int() should be called after the download mode has
been set successfully.

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
> +				dload_addr_val & ~QCOM_DOWNLOAD_MODE_MASK);

These two lines were introduced in an earlier patch in this series. Why
not just introduce the QCOM_DOWNLOAD_MODE_MASK there?

Brian

