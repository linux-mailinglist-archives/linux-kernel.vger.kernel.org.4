Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 557686E8CC6
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Apr 2023 10:31:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233819AbjDTIa6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Apr 2023 04:30:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230237AbjDTIa5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Apr 2023 04:30:57 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DCCCD3A9B;
        Thu, 20 Apr 2023 01:30:55 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 696E2645F8;
        Thu, 20 Apr 2023 08:30:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 876E1C433D2;
        Thu, 20 Apr 2023 08:30:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1681979454;
        bh=enGq2JD5riUGYTQyUrl120OZ+vbKagTtlaWqtIZaDL4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ExkiN2htcJLv85vxga4giZuK1/v6OQmTF5zWDV/Byhou7VK0GATkoRCtd63pSY7Rz
         6ryMEWIiGd0+ufF7CP2ffZ1P1uKn3NjK6CNLoyzkJfRBeuDW/ZmYbZ2XF3SIqfHZiY
         egkZqE4vMMjgK4RWiSlah+bWZBOXWKTKEUIZ9M1B+ANhMmezFHLtIuRasr9Yqawqk3
         z7dUkexa8TktjiyTfmGGuS8zOHlpO5+O6Hr4aEf2npgfeqpUedpmCrYjkwp5FLf5IE
         7eTdcWCFUPFmsKEZAhf6qw1za7l/cH6n4YaQCLnHsdGb9Uwy1xzjuEJCp2NDDcJeS3
         Swi9N/rPBM+9A==
Date:   Thu, 20 Apr 2023 14:00:41 +0530
From:   Manivannan Sadhasivam <mani@kernel.org>
To:     Konrad Dybcio <konrad.dybcio@linaro.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 2/2] soc: qcom: Introduce RPM master stats driver
Message-ID: <20230420083041.GB6308@thinkpad>
References: <20230405-topic-master_stats-v5-0-2e1c98a8b63e@linaro.org>
 <20230405-topic-master_stats-v5-2-2e1c98a8b63e@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230405-topic-master_stats-v5-2-2e1c98a8b63e@linaro.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 19, 2023 at 02:23:21PM +0200, Konrad Dybcio wrote:
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

Reviewed-by: Manivannan Sadhasivam <mani@kernel.org>

- Mani

> ---
>  drivers/soc/qcom/Kconfig            |  11 +++
>  drivers/soc/qcom/Makefile           |   1 +
>  drivers/soc/qcom/rpm_master_stats.c | 163 ++++++++++++++++++++++++++++++++++++
>  3 files changed, 175 insertions(+)
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
> index 000000000000..6dd98b9f7129
> --- /dev/null
> +++ b/drivers/soc/qcom/rpm_master_stats.c
> @@ -0,0 +1,163 @@
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
> +	u32 active_cores;
> +	u32 num_shutdowns;
> +	u64 shutdown_req;
> +	u64 wakeup_idx;
> +	u64 bringup_req;
> +	u64 bringup_ack;
> +	u32 wakeup_reason; /* 0 = "rude wakeup", 1 = scheduled wakeup */
> +	u32 last_sleep_trans_dur;
> +	u32 last_wake_trans_dur;
> +
> +	/* Per-subsystem (*not necessarily* SoC-wide) XO shutdown stats */
> +	u32 xo_count;
> +	u64 xo_last_enter;
> +	u64 last_exit;
> +	u64 xo_total_dur;
> +} __packed;
> +
> +static int master_stats_show(struct seq_file *s, void *unused)
> +{
> +	struct master_stats_data *data = s->private;
> +	struct rpm_master_stats stat;
> +
> +	memcpy_fromio(&stat, data->base, sizeof(stat));
> +
> +	seq_printf(s, "%s:\n", data->label);
> +
> +	seq_printf(s, "\tLast shutdown @ %llu\n", stat.shutdown_req);
> +	seq_printf(s, "\tLast bringup req @ %llu\n", stat.bringup_req);
> +	seq_printf(s, "\tLast bringup ack @ %llu\n", stat.bringup_ack);
> +	seq_printf(s, "\tLast wakeup idx: %llu\n", stat.wakeup_idx);
> +	seq_printf(s, "\tLast XO shutdown enter @ %llu\n", stat.xo_last_enter);
> +	seq_printf(s, "\tLast XO shutdown exit @ %llu\n", stat.last_exit);
> +	seq_printf(s, "\tXO total duration: %llu\n", stat.xo_total_dur);
> +	seq_printf(s, "\tLast sleep transition duration: %u\n", stat.last_sleep_trans_dur);
> +	seq_printf(s, "\tLast wake transition duration: %u\n", stat.last_wake_trans_dur);
> +	seq_printf(s, "\tXO shutdown count: %u\n", stat.xo_count);
> +	seq_printf(s, "\tWakeup reason: 0x%x\n", stat.wakeup_reason);
> +	seq_printf(s, "\tShutdown count: %u\n", stat.num_shutdowns);
> +	seq_printf(s, "\tActive cores bitmask: 0x%x\n", stat.active_cores);
> +
> +	return 0;
> +}
> +DEFINE_SHOW_ATTRIBUTE(master_stats);
> +
> +static int master_stats_probe(struct platform_device *pdev)
> +{
> +	struct device *dev = &pdev->dev;
> +	struct master_stats_data *data;
> +	struct device_node *msgram_np;
> +	struct dentry *dent, *root;
> +	struct resource res;
> +	int count, i, ret;
> +
> +	count = of_property_count_strings(dev->of_node, "qcom,master-names");
> +	if (count < 0)
> +		return count;
> +
> +	data = devm_kzalloc(dev, count * sizeof(*data), GFP_KERNEL);
> +	if (!data)
> +		return -ENOMEM;
> +
> +	root = debugfs_create_dir("qcom_rpm_master_stats", NULL);
> +	platform_set_drvdata(pdev, root);
> +
> +	for (i = 0; i < count; i++) {
> +		msgram_np = of_parse_phandle(dev->of_node, "qcom,rpm-msg-ram", i);
> +		if (!msgram_np) {
> +			debugfs_remove_recursive(root);
> +			return dev_err_probe(dev, -ENODEV,
> +					     "Couldn't parse MSG RAM phandle idx %d", i);
> +		}
> +
> +		/*
> +		 * Purposefully skip devm_platform helpers as we're using a
> +		 * shared resource.
> +		 */
> +		ret = of_address_to_resource(msgram_np, 0, &res);
> +		of_node_put(msgram_np);
> +		if (ret < 0) {
> +			debugfs_remove_recursive(root);
> +			return ret;
> +		}
> +
> +		data[i].base = devm_ioremap(dev, res.start, resource_size(&res));
> +		if (IS_ERR(data[i].base)) {
> +			debugfs_remove_recursive(root);
> +			return dev_err_probe(dev, -EINVAL,
> +					     "Could not map the MSG RAM slice idx %d!\n", i);
> +		}
> +
> +		ret = of_property_read_string_index(dev->of_node, "qcom,master-names", i,
> +						    &data[i].label);
> +		if (ret < 0) {
> +			debugfs_remove_recursive(root);
> +			return dev_err_probe(dev, ret,
> +					     "Could not read name idx %d!\n", i);
> +		}
> +
> +		/*
> +		 * Generally it's not advised to fail on debugfs errors, but this
> +		 * driver's only job is exposing data therein.
> +		 */
> +		dent = debugfs_create_file(data[i].label, 0444, root,
> +					   &data[i], &master_stats_fops);
> +		if (IS_ERR(dent)) {
> +			debugfs_remove_recursive(root);
> +			return dev_err_probe(dev, PTR_ERR(dent),
> +					     "Failed to create debugfs file %s!\n", data[i].label);
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
> +		.name = "qcom_rpm_master_stats",
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
