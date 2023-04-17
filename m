Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 246E26E4268
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Apr 2023 10:20:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229892AbjDQIUW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Apr 2023 04:20:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230467AbjDQIUQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Apr 2023 04:20:16 -0400
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A999559A
        for <linux-kernel@vger.kernel.org>; Mon, 17 Apr 2023 01:20:13 -0700 (PDT)
Received: by mail-pl1-x633.google.com with SMTP id o2so24786886plg.4
        for <linux-kernel@vger.kernel.org>; Mon, 17 Apr 2023 01:20:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1681719612; x=1684311612;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=pmxox5y/MB/Uvs8BBlEeHXMdLMrq80W/RWiuw2ntXAc=;
        b=opFDqkGZEvH9Zb+mYqjhp9sM9x3bTTa4+PLU5svTELy54dzY/ogvaC22G5mQR3SuO8
         /UDMrj4D4ryWW0SHMhbXuWYhky9N7yN9fP6/uIXielL5BO2fyu1+yDij3ZsJSUdtCOwi
         6oH9mjNx5x+BOClakS9lOhRsaciOdWAJnOWr3bz3Yzv6r9eDJTt46e3qKiOUkns5p9qX
         WQuxLVwaN+3QJpMt9fbhvtrMpCntdBvuoSSpzNMbh50J497hljrWpLU1JOz+IWLs5T5p
         x9xKim7YKWmK8xhu87/LVAN5YHIFg2kHR4Mkb0fay+eMkuhPxciC6H3bm1H8VxjHBulp
         yPfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681719612; x=1684311612;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=pmxox5y/MB/Uvs8BBlEeHXMdLMrq80W/RWiuw2ntXAc=;
        b=EuHzMAr96ne+8kMzJV0FUVgY/VRd1+VaSrR80d/HJUwxnc5RMIFBCCsg2ONjY/D0jT
         EYhjVkPAQD5Bd4CUqPg20Voz3oQieJVPe1MuhQuG6sM0SIXS7x5KkA3OCA47S1aEhFEB
         2/k1NGdWLrrbFks185GD81Tj1PiDlHBPwkdaa5Hn64pFCxNd3gDp1CaWAscAffYXd46O
         cCkuuFkj9xAOzX70aW2nzRgAaOBLatfMA46D6/YumujhxIdZKaXOQz9ljyZCgBpC3NIV
         5aoAaGvTnbUEs3Lrjx80/nztMssAFVoR5L4j26yKx5jNVBTDXluoTLlzTYFIfMmwTas4
         Xp5Q==
X-Gm-Message-State: AAQBX9f3p3jaYqMG0aki+eHYbeh9O/3Vd4BcjgrujCbZ3IIe65sfwoof
        dmpAu3VkzrZBE9dxKklKhKjs
X-Google-Smtp-Source: AKy350Y0EWwLGuRnTz267xrrCfS6nTR2qCqiuL7psBmhfv06Th2Hyu2SfnvFbvsnjACotURF4Meg0Q==
X-Received: by 2002:a17:902:cf02:b0:1a6:b23c:3bf2 with SMTP id i2-20020a170902cf0200b001a6b23c3bf2mr7660797plg.10.1681719612455;
        Mon, 17 Apr 2023 01:20:12 -0700 (PDT)
Received: from thinkpad ([27.111.75.72])
        by smtp.gmail.com with ESMTPSA id d24-20020a17090ac25800b00246cc751c6bsm8231855pjx.46.2023.04.17.01.20.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Apr 2023 01:20:12 -0700 (PDT)
Date:   Mon, 17 Apr 2023 13:50:03 +0530
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     Konrad Dybcio <konrad.dybcio@linaro.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 2/2] soc: qcom: Introduce RPM master stats driver
Message-ID: <20230417082003.GA2874@thinkpad>
References: <20230405-topic-master_stats-v3-0-2cb2ba4f2092@linaro.org>
 <20230405-topic-master_stats-v3-2-2cb2ba4f2092@linaro.org>
 <20230416142055.GA2798@thinkpad>
 <ab6d9730-2eae-44c7-a809-b29174acdefc@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ab6d9730-2eae-44c7-a809-b29174acdefc@linaro.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 17, 2023 at 09:14:39AM +0200, Konrad Dybcio wrote:
> 
> 
> On 16.04.2023 16:20, Manivannan Sadhasivam wrote:
> > On Fri, Apr 14, 2023 at 01:37:18PM +0200, Konrad Dybcio wrote:
> >> Introduce a driver to query and expose detailed, per-subsystem (as opposed
> >> to the existing qcom_stats driver which exposes SoC-wide data) about low
> >> power mode states of a given RPM master. That includes the APSS (ARM),
> >> MPSS (modem) and other remote cores, depending on the platform
> >> configuration.
> >>
> >> This is a vastly cleaned up and restructured version of a similar
> >> driver found in msm-5.4.
> >>
> >> Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
> >> ---
> >>  drivers/soc/qcom/Kconfig            |  11 +++
> >>  drivers/soc/qcom/Makefile           |   1 +
> >>  drivers/soc/qcom/rpm_master_stats.c | 160 ++++++++++++++++++++++++++++++++++++
> >>  3 files changed, 172 insertions(+)
> >>
> >> diff --git a/drivers/soc/qcom/Kconfig b/drivers/soc/qcom/Kconfig
> >> index a491718f8064..e597799e8121 100644
> >> --- a/drivers/soc/qcom/Kconfig
> >> +++ b/drivers/soc/qcom/Kconfig
> >> @@ -135,6 +135,17 @@ config QCOM_RMTFS_MEM
> >>  
> >>  	  Say y here if you intend to boot the modem remoteproc.
> >>  
> >> +config QCOM_RPM_MASTER_STATS
> >> +	tristate "Qualcomm RPM Master stats"
> >> +	depends on ARCH_QCOM || COMPILE_TEST
> >> +	help
> >> +	  The RPM Master sleep stats driver provides detailed per-subsystem
> >> +	  sleep/wake data, read from the RPM message RAM. It can be used to
> >> +	  assess whether all the low-power modes available are entered as
> >> +	  expected or to check which part of the SoC prevents it from sleeping.
> >> +
> >> +	  Say y here if you intend to debug or monitor platform sleep.
> >> +
> >>  config QCOM_RPMH
> >>  	tristate "Qualcomm RPM-Hardened (RPMH) Communication"
> >>  	depends on ARCH_QCOM || COMPILE_TEST
> >> diff --git a/drivers/soc/qcom/Makefile b/drivers/soc/qcom/Makefile
> >> index 0f43a88b4894..7349371fdea1 100644
> >> --- a/drivers/soc/qcom/Makefile
> >> +++ b/drivers/soc/qcom/Makefile
> >> @@ -14,6 +14,7 @@ obj-$(CONFIG_QCOM_QMI_HELPERS)	+= qmi_helpers.o
> >>  qmi_helpers-y	+= qmi_encdec.o qmi_interface.o
> >>  obj-$(CONFIG_QCOM_RAMP_CTRL)	+= ramp_controller.o
> >>  obj-$(CONFIG_QCOM_RMTFS_MEM)	+= rmtfs_mem.o
> >> +obj-$(CONFIG_QCOM_RPM_MASTER_STATS)	+= rpm_master_stats.o
> >>  obj-$(CONFIG_QCOM_RPMH)		+= qcom_rpmh.o
> >>  qcom_rpmh-y			+= rpmh-rsc.o
> >>  qcom_rpmh-y			+= rpmh.o
> >> diff --git a/drivers/soc/qcom/rpm_master_stats.c b/drivers/soc/qcom/rpm_master_stats.c
> >> new file mode 100644
> >> index 000000000000..73080c92bf89
> >> --- /dev/null
> >> +++ b/drivers/soc/qcom/rpm_master_stats.c
> >> @@ -0,0 +1,160 @@
> >> +// SPDX-License-Identifier: GPL-2.0-only
> >> +/*
> >> + * Copyright (c) 2012-2020, The Linux Foundation. All rights reserved.
> >> + * Copyright (c) 2023, Linaro Limited
> >> + *
> >> + * This driver supports what is known as "Master Stats v2", which seems to be
> >> + * the only version which has ever shipped, all the way from 2013 to 2023.
> > 
> > It'd better to mention "Qualcomm downstream" in the somewhere above comment to
> > make it clear for users.
> Ack
> 
> > 
> >> + */
> >> +
> >> +#include <linux/debugfs.h>
> >> +#include <linux/io.h>
> >> +#include <linux/module.h>
> >> +#include <linux/of.h>
> >> +#include <linux/of_address.h>
> >> +#include <linux/platform_device.h>
> >> +
> >> +struct master_stats_data {
> >> +	void __iomem *base;
> >> +	const char *label;
> >> +};
> >> +
> >> +struct rpm_master_stats {
> >> +	uint32_t active_cores;
> >> +	uint32_t num_shutdowns;
> >> +	uint64_t shutdown_req;
> >> +	uint64_t wakeup_idx;
> >> +	uint64_t bringup_req;
> >> +	uint64_t bringup_ack;
> >> +	uint32_t wakeup_reason; /* 0 = "rude wakeup", 1 = scheduled wakeup */
> >> +	uint32_t last_sleep_trans_dur;
> >> +	uint32_t last_wake_trans_dur;
> >> +
> >> +	/* Per-subsystem (*not necessarily* SoC-wide) XO shutdown stats */
> >> +	uint32_t xo_count;
> >> +	uint64_t xo_last_enter;
> >> +	uint64_t last_exit;
> >> +	uint64_t xo_total_dur;
> > 
> > Why can't you use u64, u32?
> Brain derp!
> 
> > 
> > Also, sort these members as below:
> > 
> > u64
> > u32
> No, it's the way this data is structured in the
> memory and we copy it as a whole.
> 

Ok, in that case you'd need __packed.

> > 
> >> +};
> >> +

[...]

> >> +		/*
> >> +		 * Generally it's not advised to fail on debugfs errors, but this
> >> +		 * driver's only job is exposing data therein.
> >> +		 */
> >> +		dent = debugfs_create_file(d[i].label, 0444, root,
> >> +					   &d[i], &master_stats_fops);
> >> +		if (!dent) {
> > 
> > Don't check for NULL, instead use IS_ERR() if you really care about error
> > checking here.
> "This function will return a pointer to a dentry if
> it succeeds. This pointer must be passed to the
> debugfs_remove function when the file is to be removed
> (no automatic cleanup happens if your module is unloaded,
> you are responsible here.) If an error occurs, NULL will
> be returned."

This seems to be the old comment. Take a look at the updated one in mainline:
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/fs/debugfs/inode.c#n468

Greg changed the semantics of the debugfs APIs a while back but the kernel doc
was updated recently:
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/fs/debugfs/inode.c?id=d3002468cb5d5da11e22145c9af32facd5c34352

- Mani

> 
> > 
> >> +			debugfs_remove_recursive(root);
> >> +			return -EINVAL;
> >> +		}
> >> +	}
> >> +
> >> +	device_set_pm_not_required(dev);
> >> +
> >> +	return 0;
> >> +}
> >> +
> >> +static void master_stats_remove(struct platform_device *pdev)
> >> +{
> >> +	struct dentry *root = platform_get_drvdata(pdev);
> >> +
> >> +	debugfs_remove_recursive(root);
> >> +}
> >> +
> >> +static const struct of_device_id rpm_master_table[] = {
> >> +	{ .compatible = "qcom,rpm-master-stats" },
> >> +	{ },
> >> +};
> >> +
> >> +static struct platform_driver master_stats_driver = {
> >> +	.probe = master_stats_probe,
> >> +	.remove_new = master_stats_remove,
> >> +	.driver = {
> >> +		.name = "rpm_master_stats",
> >> +		.of_match_table = rpm_master_table,
> >> +	},
> >> +};
> >> +module_platform_driver(master_stats_driver);
> >> +
> >> +MODULE_DESCRIPTION("RPM Master Statistics driver");
> > 
> > Qualcomm RPM Master Statistics driver
> Ack
> 
> Konrad
> > 
> > - Mani
> > 
> >> +MODULE_LICENSE("GPL");
> >>
> >> -- 
> >> 2.40.0
> >>
> > 

-- 
மணிவண்ணன் சதாசிவம்
