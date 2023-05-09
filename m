Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C0F746FC532
	for <lists+linux-kernel@lfdr.de>; Tue,  9 May 2023 13:40:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235606AbjEILkv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 May 2023 07:40:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235578AbjEILk1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 May 2023 07:40:27 -0400
Received: from mail-yb1-xb32.google.com (mail-yb1-xb32.google.com [IPv6:2607:f8b0:4864:20::b32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4B3C7AA4
        for <linux-kernel@vger.kernel.org>; Tue,  9 May 2023 04:40:04 -0700 (PDT)
Received: by mail-yb1-xb32.google.com with SMTP id 3f1490d57ef6-b9e27684b53so5037373276.0
        for <linux-kernel@vger.kernel.org>; Tue, 09 May 2023 04:40:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1683632404; x=1686224404;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=bN0WAPIA5nuw/1zElaEn49wysrmGwuQYJKZRalwsUmw=;
        b=OnVSNJpVblnnwgiSlmyGmsdKuG3dohMYP320MHE3X4o01oIXybQnQM1iy5Ut3lBakK
         3sZdLsbhCy3/fxaF9IXvbNmvCCaod8xrxQSf9BLysPEd4r7KrC3YZ3ymJzOUKs0ZeJd5
         /No/u12ExgDFYUuIYO5EZCmpSO5vboCsfrYqCUKqt3NpsRY4+DFEH+qT7yyC+xxbdhOF
         LiiDYQuoyqRAjKY4lSobsCTS+gpzpv62+kvCw3f1nO5hv7TobOjOnq1cKV2HKQ+yzQ/q
         I2GC5Pa1x8CA6p5pl9RLVY7T3VYspAWtYu2RBaN74khJoiDF1wutCQWbz8Yp7AREd2Qh
         bbvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683632404; x=1686224404;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bN0WAPIA5nuw/1zElaEn49wysrmGwuQYJKZRalwsUmw=;
        b=HXNz18c6rUPIgGu7Hbw8kxpCaHSSYM2io1XHCco62QTwdt1AIP/PRI1qvvn8cgJap3
         Xo/ji9/MFC6NiyUGrN2iMnWXY0A5BluKFrc+tUkMQ3KljyCRULq/JQP/wDz5XdPRR5qT
         bBaFWG8EFJOmW2abHMfF7tXR88xsAbKInK0tqeODxeRC3lf7gF8x3TA8H0LBJJ875U4r
         FBjx9Sfr5csZnpF/OMGnMuRhOhwY9coZck1QirGrtezVu7JZa3S0M6QO8o+II+InANfB
         IYKzcrlUAZZ/sFB+Dxl3lZDf7y3ydhucGW293+FJQgiYWX0Fg1MpdQkwbzr3BYvBKTbG
         0img==
X-Gm-Message-State: AC+VfDxRNHqqaYPS0sBVMvO0UzQ48Zgy6hcLAN0p+ccWddasD8tghUNl
        peniO0ItNFwLEZBRZAVaQx3Z47uWuz/fwCBuDqvnKQ==
X-Google-Smtp-Source: ACHHUZ4IK+Xjjbd0RHBKuyhtmQCkhzk0vW6RReCxJjstJev4rrbrHQHu9S/XcMyRbej258JMZDcoQCQLQVx4GF5b0aQ=
X-Received: by 2002:a25:40d2:0:b0:b9d:b22e:6080 with SMTP id
 n201-20020a2540d2000000b00b9db22e6080mr14726641yba.7.1683632403741; Tue, 09
 May 2023 04:40:03 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1683628357.git.quic_schowdhu@quicinc.com> <35863b47c04c2edd7ae49c57d23682aba6111d4f.1683628357.git.quic_schowdhu@quicinc.com>
In-Reply-To: <35863b47c04c2edd7ae49c57d23682aba6111d4f.1683628357.git.quic_schowdhu@quicinc.com>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date:   Tue, 9 May 2023 14:39:53 +0300
Message-ID: <CAA8EJppkqN6cuYUCC-THb8wb=deRv-01pbS0JgSGf-VXnm8qEg@mail.gmail.com>
Subject: Re: [PATCH V6 2/3] soc: qcom: boot_stat: Add Driver Support for Boot Stats
To:     Souradeep Chowdhury <quic_schowdhu@quicinc.com>
Cc:     Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        Sibi Sankar <quic_sibis@quicinc.com>,
        Rajendra Nayak <quic_rjendra@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 9 May 2023 at 13:53, Souradeep Chowdhury
<quic_schowdhu@quicinc.com> wrote:
>
> All of Qualcomm's proprietary Android boot-loaders capture boot time
> stats, like the time when the bootloader started execution and at what
> point the bootloader handed over control to the kernel etc. in the IMEM
> region. This information is captured in a specific format by this driver
> by mapping a structure to the IMEM memory region and then accessing the
> members of the structure to show the information within debugfs file.
> This information is useful in verifying if the existing boot KPIs have
> regressed or not. The information is shown in milliseconds, a sample
> log from sm8450(waipio) device is as follows:-
>
> /sys/kernel/debug/qcom_boot_stats # cat abl_time
> 17898 ms
> /sys/kernel/debug/qcom_boot_stats # cat pre_abl_time
> 2879 ms
>
> The Module Power Manager(MPM) sleep counter starts ticking at the PBL
> stage and the timestamp generated by the sleep counter is logged by
> the Qualcomm proprietary bootloader(ABL) at two points-> First when it
> starts execution which is logged here as "pre_abl_time" and the second
> when it is about to load the kernel logged as "abl_time". Documentation
> details are also added in Documentation/ABI/testing/debugfs-driver-bootstat
>
> Signed-off-by: Souradeep Chowdhury <quic_schowdhu@quicinc.com>
> ---
>  .../ABI/testing/debugfs-driver-bootstat       |  17 +++
>  drivers/soc/qcom/Kconfig                      |  10 ++
>  drivers/soc/qcom/Makefile                     |   1 +
>  drivers/soc/qcom/boot_stats.c                 | 100 ++++++++++++++++++
>  4 files changed, 128 insertions(+)
>  create mode 100644 Documentation/ABI/testing/debugfs-driver-bootstat
>  create mode 100644 drivers/soc/qcom/boot_stats.c
>
> diff --git a/Documentation/ABI/testing/debugfs-driver-bootstat b/Documentation/ABI/testing/debugfs-driver-bootstat
> new file mode 100644
> index 000000000000..7127d15d9f15
> --- /dev/null
> +++ b/Documentation/ABI/testing/debugfs-driver-bootstat
> @@ -0,0 +1,17 @@
> +What:          /sys/kernel/debug/qcom_boot_stats/pre_abl_time

Could you please change these bindings to be generic?

s/qcom_boot_stats/boot_stats/
s/pre_abl_time/pre_bootloader_msec/
s/abl_time/bootloader_msec/

This way other platforms might also use the same file structure.

> +Date:           May 2023
> +Contact:        Souradeep Chowdhury <quic_schowdhu@quicinc.com>
> +Description:
> +               This file is used to read the KPI value pre abl time.
> +               It shows the time in milliseconds from the starting
> +               point of PBL to the point when the control shifted
> +               to ABL(Qualcomm proprietary bootloader).
> +
> +What:           /sys/kernel/debug/qcom_boot_stats/abl_time
> +Date:           May 2023
> +Contact:        Souradeep Chowdhury <quic_schowdhu@quicinc.com>
> +Description:
> +               This file is used to read the KPI value abl time.
> +               It show the duration in milliseconds from the
> +               time control switched to ABL to the point when
> +               the linux kernel started getting loaded.
> diff --git a/drivers/soc/qcom/Kconfig b/drivers/soc/qcom/Kconfig
> index a491718f8064..04141236dcdd 100644
> --- a/drivers/soc/qcom/Kconfig
> +++ b/drivers/soc/qcom/Kconfig
> @@ -16,6 +16,16 @@ config QCOM_AOSS_QMP
>           subsystems as well as controlling the debug clocks exposed by the Always On
>           Subsystem (AOSS) using Qualcomm Messaging Protocol (QMP).
>
> +config QCOM_BOOTSTAT
> +       tristate "Qualcomm Technologies, Boot Stat driver"
> +       depends on ARCH_QCOM || COMPILE_TEST
> +       depends on DEBUG_FS
> +       help
> +         This option enables driver support for boot stats. Boot stat driver logs
> +         the kernel bootloader information by accessing the imem region. These
> +         information are exposed in the form of debugfs files. This is used to
> +         determine if there is any regression in boot timings.
> +
>  config QCOM_COMMAND_DB
>         tristate "Qualcomm Command DB"
>         depends on ARCH_QCOM || COMPILE_TEST
> diff --git a/drivers/soc/qcom/Makefile b/drivers/soc/qcom/Makefile
> index 0f43a88b4894..ae7bda96a539 100644
> --- a/drivers/soc/qcom/Makefile
> +++ b/drivers/soc/qcom/Makefile
> @@ -1,6 +1,7 @@
>  # SPDX-License-Identifier: GPL-2.0
>  CFLAGS_rpmh-rsc.o := -I$(src)
>  obj-$(CONFIG_QCOM_AOSS_QMP) += qcom_aoss.o
> +obj-$(CONFIG_QCOM_BOOTSTAT) += boot_stats.o
>  obj-$(CONFIG_QCOM_GENI_SE) +=  qcom-geni-se.o
>  obj-$(CONFIG_QCOM_COMMAND_DB) += cmd-db.o
>  obj-$(CONFIG_QCOM_CPR)         += cpr.o
> diff --git a/drivers/soc/qcom/boot_stats.c b/drivers/soc/qcom/boot_stats.c
> new file mode 100644
> index 000000000000..ca67b6b5d8eb
> --- /dev/null
> +++ b/drivers/soc/qcom/boot_stats.c
> @@ -0,0 +1,100 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * Copyright (c) 2013-2019, 2021 The Linux Foundation. All rights reserved.
> + * Copyright (c) 2023 Qualcomm Innovation Center, Inc. All rights reserved.
> + */
> +
> +#include <linux/debugfs.h>
> +#include <linux/err.h>
> +#include <linux/io.h>
> +#include <linux/init.h>
> +#include <linux/kernel.h>
> +#include <linux/module.h>
> +#include <linux/of.h>
> +#include <linux/of_address.h>
> +#include <linux/platform_device.h>
> +
> +#define TO_MS(timestamp) ((timestamp * 1000) / 32768)

Quoting v4 question, which got no answer:

Some of the platforms DTs define 32KHz clock instead of 32.768 KHz
What should be the divisor in this case?

> +
> +/**
> + *  struct boot_stats - timestamp information related to boot stats
> + *  @abl_start: Time for the starting point of the abl
> + *  @abl_end: Time when the kernel starts loading from abl
> + */
> +struct boot_stats {
> +       u32 abl_start;
> +       u32 abl_end;
> +} __packed;
> +
> +struct bs_data {
> +       struct boot_stats __iomem *b_stats;
> +       struct dentry *dbg_dir;
> +};
> +
> +static void populate_boot_stats(char *abl_str, char *pre_abl_str, struct bs_data *drvdata)
> +{
> +        u32 abl_time, pre_abl_time;
> +
> +        abl_time = TO_MS(drvdata->b_stats->abl_end) - TO_MS(drvdata->b_stats->abl_start);
> +        sprintf(abl_str, "%u ms", abl_time);
> +
> +        pre_abl_time =  TO_MS(drvdata->b_stats->abl_start);
> +        sprintf(pre_abl_str, "%u ms", pre_abl_time);

Another point from v4:

It would be better to move the unit to the file name and include just
the number.

> +}
> +
> +static int boot_stats_probe(struct platform_device *pdev)
> +{
> +       char abl_str[20], pre_abl_str[20], *abl, *pre_abl;
> +       struct device *bootstat_dev = &pdev->dev;
> +       struct bs_data *drvdata;
> +
> +       drvdata = devm_kzalloc(bootstat_dev, sizeof(*drvdata), GFP_KERNEL);
> +       if (!drvdata)
> +               return dev_err_probe(bootstat_dev, -ENOMEM, "failed to allocate memory");
> +       platform_set_drvdata(pdev, drvdata);
> +
> +       drvdata->b_stats = devm_of_iomap(bootstat_dev, bootstat_dev->of_node, 0, NULL);
> +       if (IS_ERR(drvdata->b_stats))
> +               return dev_err_probe(bootstat_dev, PTR_ERR(drvdata->b_stats),
> +                                    "failed to map imem region");
> +
> +       drvdata->dbg_dir = debugfs_create_dir("qcom_boot_stats", NULL);
> +       if (IS_ERR(drvdata->dbg_dir))
> +               return dev_err_probe(bootstat_dev, PTR_ERR(drvdata->dbg_dir),
> +                                    "failed to create debugfs directory");
> +
> +       populate_boot_stats(abl_str, pre_abl_str, drvdata);
> +       abl = abl_str;
> +       pre_abl = pre_abl_str;
> +
> +       debugfs_create_str("pre_abl_time", 0400, drvdata->dbg_dir, (char **)&pre_abl);
> +       debugfs_create_str("abl_time", 0400, drvdata->dbg_dir, (char **)&abl);
> +
> +       return 0;
> +}
> +
> +void boot_stats_remove(struct platform_device *pdev)
> +{
> +       struct bs_data *drvdata = platform_get_drvdata(pdev);
> +
> +       debugfs_remove_recursive(drvdata->dbg_dir);
> +}
> +
> +static const struct of_device_id boot_stats_dt_match[] = {
> +       { .compatible = "qcom,imem-bootstats" },
> +       { }
> +};
> +MODULE_DEVICE_TABLE(of, boot_stats_dt_match);
> +
> +static struct platform_driver boot_stat_driver = {
> +       .probe  = boot_stats_probe,
> +       .remove_new = boot_stats_remove,
> +       .driver = {
> +               .name = "qcom-boot-stats",
> +               .of_match_table = boot_stats_dt_match,
> +       },
> +};
> +module_platform_driver(boot_stat_driver);
> +
> +MODULE_DESCRIPTION("Qualcomm Technologies Inc. Boot Stat driver");
> +MODULE_LICENSE("GPL");
> --
> 2.17.1
>


-- 
With best wishes
Dmitry
