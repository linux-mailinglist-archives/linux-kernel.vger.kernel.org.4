Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DEF3F6E64B1
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Apr 2023 14:51:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232263AbjDRMvm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Apr 2023 08:51:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232179AbjDRMvf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Apr 2023 08:51:35 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB0B616F8C;
        Tue, 18 Apr 2023 05:51:02 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id CDA7663429;
        Tue, 18 Apr 2023 12:51:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E4B5BC433EF;
        Tue, 18 Apr 2023 12:50:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1681822261;
        bh=vDLBxL1a/LLgJCeDtLqmgJik9psfir0jW0YdoiOYOXE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=XB9QondD6yuvpQ230rAKbErtOUGQVdGgu0HZ7/bxbZ43tVMXHLUSqxqbTVw7VukPP
         i0o3zzLdDoGoGrX2T1iD57iDo1Sho+SLNmLaTYZEBHyDFcsSyWyxf25skaVEIGJKzO
         8P42fZ4HwdDeQFcywjo9+sxSIelIcix9LowKxbHnlyUE7S7McBruMqJOyODgx2g3X9
         2R9Veo78VzxMDphY96BvJ7uyWSc/TxHMaZXvW2Pkfu5MaOnnToSqhbPhPIcsnTutwP
         L9Z3xRF7DUCScSDaOWqkdXGdjwQFC+zmOmo51/Ddb7rrZmoAqr2Z3RefeXGqM8rDhC
         248WSZtCFlAXw==
Date:   Tue, 18 Apr 2023 18:20:47 +0530
From:   Manivannan Sadhasivam <mani@kernel.org>
To:     Konrad Dybcio <konrad.dybcio@linaro.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 2/2] soc: qcom: Introduce RPM master stats driver
Message-ID: <20230418125047.GB5530@thinkpad>
References: <20230405-topic-master_stats-v4-0-4217362fcc79@linaro.org>
 <20230405-topic-master_stats-v4-2-4217362fcc79@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230405-topic-master_stats-v4-2-4217362fcc79@linaro.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 17, 2023 at 07:37:53PM +0200, Konrad Dybcio wrote:
> Introduce a driver to query and expose detailed, per-subsystem (as opposed
> to the existing qcom_stats driver which exposes SoC-wide data) about low
> power mode states of a given RPM master. That includes the APSS (ARM),
> MPSS (modem) and other remote cores, depending on the platform
> configuration.
> 
> This is a vastly cleaned up and restructured version of a similar
> driver found in msm-5.4.
> 
> Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
> ---
>  drivers/soc/qcom/Kconfig            |  11 +++
>  drivers/soc/qcom/Makefile           |   1 +
>  drivers/soc/qcom/rpm_master_stats.c | 162 ++++++++++++++++++++++++++++++++++++
>  3 files changed, 174 insertions(+)
> 
> diff --git a/drivers/soc/qcom/Kconfig b/drivers/soc/qcom/Kconfig
> index a491718f8064..e597799e8121 100644
> --- a/drivers/soc/qcom/Kconfig
> +++ b/drivers/soc/qcom/Kconfig
> @@ -135,6 +135,17 @@ config QCOM_RMTFS_MEM
>  
>  	  Say y here if you intend to boot the modem remoteproc.
>  
> +config QCOM_RPM_MASTER_STATS
> +	tristate "Qualcomm RPM Master stats"
> +	depends on ARCH_QCOM || COMPILE_TEST
> +	help
> +	  The RPM Master sleep stats driver provides detailed per-subsystem
> +	  sleep/wake data, read from the RPM message RAM. It can be used to
> +	  assess whether all the low-power modes available are entered as
> +	  expected or to check which part of the SoC prevents it from sleeping.
> +
> +	  Say y here if you intend to debug or monitor platform sleep.
> +
>  config QCOM_RPMH
>  	tristate "Qualcomm RPM-Hardened (RPMH) Communication"
>  	depends on ARCH_QCOM || COMPILE_TEST
> diff --git a/drivers/soc/qcom/Makefile b/drivers/soc/qcom/Makefile
> index 0f43a88b4894..7349371fdea1 100644
> --- a/drivers/soc/qcom/Makefile
> +++ b/drivers/soc/qcom/Makefile
> @@ -14,6 +14,7 @@ obj-$(CONFIG_QCOM_QMI_HELPERS)	+= qmi_helpers.o
>  qmi_helpers-y	+= qmi_encdec.o qmi_interface.o
>  obj-$(CONFIG_QCOM_RAMP_CTRL)	+= ramp_controller.o
>  obj-$(CONFIG_QCOM_RMTFS_MEM)	+= rmtfs_mem.o
> +obj-$(CONFIG_QCOM_RPM_MASTER_STATS)	+= rpm_master_stats.o
>  obj-$(CONFIG_QCOM_RPMH)		+= qcom_rpmh.o
>  qcom_rpmh-y			+= rpmh-rsc.o
>  qcom_rpmh-y			+= rpmh.o
> diff --git a/drivers/soc/qcom/rpm_master_stats.c b/drivers/soc/qcom/rpm_master_stats.c
> new file mode 100644
> index 000000000000..ac87401e2217
> --- /dev/null
> +++ b/drivers/soc/qcom/rpm_master_stats.c
> @@ -0,0 +1,162 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * Copyright (c) 2012-2020, The Linux Foundation. All rights reserved.
> + * Copyright (c) 2023, Linaro Limited
> + *
> + * This driver supports what is known as "Master Stats v2" in Qualcomm
> + * downstream kernel terms, which seems to be the only version which has
> + * ever shipped, all the way from 2013 to 2023.
> + */
> +
> +#include <linux/debugfs.h>
> +#include <linux/io.h>
> +#include <linux/module.h>
> +#include <linux/of.h>
> +#include <linux/of_address.h>
> +#include <linux/platform_device.h>
> +
> +struct master_stats_data {
> +	void __iomem *base;
> +	const char *label;
> +};
> +
> +struct rpm_master_stats {
> +	uint32_t active_cores;
> +	uint32_t num_shutdowns;
> +	uint64_t shutdown_req;
> +	uint64_t wakeup_idx;
> +	uint64_t bringup_req;
> +	uint64_t bringup_ack;
> +	uint32_t wakeup_reason; /* 0 = "rude wakeup", 1 = scheduled wakeup */
> +	uint32_t last_sleep_trans_dur;
> +	uint32_t last_wake_trans_dur;
> +
> +	/* Per-subsystem (*not necessarily* SoC-wide) XO shutdown stats */
> +	uint32_t xo_count;
> +	uint64_t xo_last_enter;
> +	uint64_t last_exit;
> +	uint64_t xo_total_dur;

Still no u64, u32.

> +} __packed;
> +

[...]

> +		/*
> +		 * Generally it's not advised to fail on debugfs errors, but this
> +		 * driver's only job is exposing data therein.
> +		 */
> +		dent = debugfs_create_file(data[i].label, 0444, root,
> +					   &data[i], &master_stats_fops);
> +		if (IS_ERR(dent)) {
> +			debugfs_remove_recursive(root);
> +			return -EINVAL;

PTR_ERR(dent). Also it doesn't hurt to use dev_err_probe() here.

> +		}
> +	}
> +
> +	device_set_pm_not_required(dev);
> +
> +	return 0;
> +}
> +
> +static void master_stats_remove(struct platform_device *pdev)
> +{
> +	struct dentry *root = platform_get_drvdata(pdev);
> +
> +	debugfs_remove_recursive(root);
> +}
> +
> +static const struct of_device_id rpm_master_table[] = {
> +	{ .compatible = "qcom,rpm-master-stats" },
> +	{ },
> +};
> +
> +static struct platform_driver master_stats_driver = {
> +	.probe = master_stats_probe,
> +	.remove_new = master_stats_remove,
> +	.driver = {
> +		.name = "rpm_master_stats",

qcom_rpm_master_stats

- Mani

> +		.of_match_table = rpm_master_table,
> +	},
> +};
> +module_platform_driver(master_stats_driver);
> +
> +MODULE_DESCRIPTION("Qualcomm RPM Master Statistics driver");
> +MODULE_LICENSE("GPL");
> 
> -- 
> 2.40.0
> 

-- 
மணிவண்ணன் சதாசிவம்
