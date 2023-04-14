Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 65F7D6E231D
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Apr 2023 14:23:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230328AbjDNMXn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Apr 2023 08:23:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230028AbjDNMXl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Apr 2023 08:23:41 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76C3FA5FF;
        Fri, 14 Apr 2023 05:23:24 -0700 (PDT)
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 33E6V1oS026488;
        Fri, 14 Apr 2023 12:23:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=FjfJW2qa+4v/46frlofxRlrOEOhnsw03Amtfy2j9ZHI=;
 b=KICXGGBEDSUD1fEL+ZLixkZCsTphaKtbu4CnB0Xrwic+hXYWwr3dE8+2PZjLoAageDSI
 jHSz014huoATjjbmYHMCwtc/fW3mPswLKGreW9SdNsBvsqxFALsZJTKfTz+Xuj/+8tis
 lwCYXWmNPx7VO9J49hqrKMbij4rCk37lazw8USWHaa00/qTNPH4vw7/x0fi2aALctj5/
 EeG3ogVhqvFRAw8LBfro1/2D2AMvDs73Ms1yv/d1DFazZWlm+q+dTJoXwAdK4YO/Dgag
 5WyPlIKPtJflNH08CX7KCbJseL8JGeNpupTai7wkhpMwfuY1r6gGshd0Lbj06uWxNLUd JQ== 
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3py1kx0nx2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 14 Apr 2023 12:23:13 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 33ECNBdq010538
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 14 Apr 2023 12:23:11 GMT
Received: from [10.131.117.137] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.42; Fri, 14 Apr
 2023 05:23:07 -0700
Message-ID: <e64f88ac-74c6-2dbb-c0fe-2b281d7f02c8@quicinc.com>
Date:   Fri, 14 Apr 2023 17:52:42 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: [PATCH V3 2/3] soc: qcom: boot_stat: Add Driver Support for Boot
 Stats
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        "Krzysztof Kozlowski" <krzysztof.kozlowski+dt@linaro.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Rob Herring <robh+dt@kernel.org>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-arm-msm@vger.kernel.org>,
        <devicetree@vger.kernel.org>, Sibi Sankar <quic_sibis@quicinc.com>,
        Rajendra Nayak <quic_rjendra@quicinc.com>
References: <cover.1681375949.git.quic_schowdhu@quicinc.com>
 <65b1db8d7d95bf09f8314ed3bfd9d007d1edbf3b.1681375949.git.quic_schowdhu@quicinc.com>
 <155e7420-a231-cc5a-4626-e484c3595e18@linaro.org>
Content-Language: en-US
From:   Souradeep Chowdhury <quic_schowdhu@quicinc.com>
In-Reply-To: <155e7420-a231-cc5a-4626-e484c3595e18@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: 75iYseEW1p3g5LQ23PtVf13SlCl7Vbjx
X-Proofpoint-GUID: 75iYseEW1p3g5LQ23PtVf13SlCl7Vbjx
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-04-14_06,2023-04-14_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 bulkscore=0 priorityscore=1501 adultscore=0 phishscore=0 clxscore=1011
 impostorscore=0 mlxlogscore=999 spamscore=0 suspectscore=0 mlxscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2303200000 definitions=main-2304140112
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 4/14/2023 5:04 PM, Srinivas Kandagatla wrote:
> 
> 
> On 13/04/2023 10:28, Souradeep Chowdhury wrote:
>> All of Qualcomm's proprietary Android boot-loaders capture boot time
>> stats, like the time when the bootloader started execution and at what
>> point the bootloader handed over control to the kernel etc. in the IMEM
>> region. This information is captured in a specific format by this driver
>> by mapping a structure to the IMEM memory region and then accessing the
>> members of the structure to show the information within debugfs file.
>> This information is useful in verifying if the existing boot KPIs have
>> regressed or not. The information is shown in milliseconds, a sample
>> log from sm8450(waipio) device is as follows:-
>>
>> /sys/kernel/debug/146aa6b0.boot_stats # cat abl_time
>> 17898 ms
>> /sys/kernel/debug/146aa6b0.boot_stats # cat pre_abl_time
>> 2879 ms
>>
>> The Module Power Manager(MPM) sleep counter starts ticking at the PBL
>> stage and the timestamp generated by the sleep counter is logged by
>> the Qualcomm proprietary bootloader(ABL) at two points-> First when it
>> starts execution which is logged here as "pre_abl_time" and the second
>> when it is about to load the kernel logged as "abl_time". Documentation
>> details are also added in 
>> Documentation/ABI/testing/debugfs-driver-bootstat
>>
>> Signed-off-by: Souradeep Chowdhury <quic_schowdhu@quicinc.com>
>> ---
>>   Documentation/ABI/testing/debugfs-driver-bootstat |  17 ++++
>>   drivers/soc/qcom/Kconfig                          |   9 ++
>>   drivers/soc/qcom/Makefile                         |   1 +
>>   drivers/soc/qcom/boot_stats.c                     | 109 
>> ++++++++++++++++++++++
>>   4 files changed, 136 insertions(+)
>>   create mode 100644 Documentation/ABI/testing/debugfs-driver-bootstat
>>   create mode 100644 drivers/soc/qcom/boot_stats.c
>>
>> diff --git a/Documentation/ABI/testing/debugfs-driver-bootstat 
>> b/Documentation/ABI/testing/debugfs-driver-bootstat
>> new file mode 100644
>> index 0000000..37d8e32
>> --- /dev/null
>> +++ b/Documentation/ABI/testing/debugfs-driver-bootstat
>> @@ -0,0 +1,17 @@
>> +What:        /sys/kernel/debug/...stats/pre_abl_time
>> +Date:           April 2023
>> +Contact:        Souradeep Chowdhury <quic_schowdhu@quicinc.com>
>> +Description:
>> +        This file is used to read the KPI value pre abl time.
>> +        It shows the time in milliseconds from the starting
>> +        point of PBL to the point when the control shifted
>> +        to ABL(Qualcomm proprietary bootloader).
>> +
>> +What:           /sys/kernel/debug/...stats/abl_time
>> +Date:           April 2023
>> +Contact:        Souradeep Chowdhury <quic_schowdhu@quicinc.com>
>> +Description:
>> +        This file is used to read the KPI value abl time.
>> +        It show the duration in milliseconds from the
>> +        time control switched to ABL to the point when
>> +        the linux kernel started getting loaded.
>> diff --git a/drivers/soc/qcom/Kconfig b/drivers/soc/qcom/Kconfig
>> index a8f2830..0d2cbd3 100644
>> --- a/drivers/soc/qcom/Kconfig
>> +++ b/drivers/soc/qcom/Kconfig
>> @@ -16,6 +16,15 @@ config QCOM_AOSS_QMP
>>         subsystems as well as controlling the debug clocks exposed by 
>> the Always On
>>         Subsystem (AOSS) using Qualcomm Messaging Protocol (QMP).
>>
>> +config QCOM_BOOTSTAT
>> +    tristate "Qualcomm Technologies, Boot Stat driver"
>> +    depends on ARCH_QCOM || COMPILE_TEST
>> +    help
>> +      This option enables driver support for boot stats. Boot stat 
>> driver logs
>> +      the kernel bootloader information by accessing the imem region. 
>> These
>> +      information is exposed in the form of debugfs files. This is 
>> used to
>> +      determine if there is any regression in boot timings.
>> +
>>   config QCOM_COMMAND_DB
>>       tristate "Qualcomm Command DB"
>>       depends on ARCH_QCOM || COMPILE_TEST
>> diff --git a/drivers/soc/qcom/Makefile b/drivers/soc/qcom/Makefile
>> index 6e88da8..bdaa41a 100644
>> --- a/drivers/soc/qcom/Makefile
>> +++ b/drivers/soc/qcom/Makefile
>> @@ -1,6 +1,7 @@
>>   # SPDX-License-Identifier: GPL-2.0
>>   CFLAGS_rpmh-rsc.o := -I$(src)
>>   obj-$(CONFIG_QCOM_AOSS_QMP) +=    qcom_aoss.o
>> +obj-$(CONFIG_QCOM_BOOTSTAT) += boot_stats.o
>>   obj-$(CONFIG_QCOM_GENI_SE) +=    qcom-geni-se.o
>>   obj-$(CONFIG_QCOM_COMMAND_DB) += cmd-db.o
>>   obj-$(CONFIG_QCOM_CPR)        += cpr.o
>> diff --git a/drivers/soc/qcom/boot_stats.c 
>> b/drivers/soc/qcom/boot_stats.c
>> new file mode 100644
>> index 0000000..9b65aa1
>> --- /dev/null
>> +++ b/drivers/soc/qcom/boot_stats.c
>> @@ -0,0 +1,109 @@
>> +// SPDX-License-Identifier: GPL-2.0-only
>> +/*
>> + * Copyright (c) 2013-2019, 2021 The Linux Foundation. All rights 
>> reserved.
>> + * Copyright (c) 2023 Qualcomm Innovation Center, Inc. All rights 
>> reserved.
>> + */
>> +
>> +#include <linux/debugfs.h>
>> +#include <linux/err.h>
>> +#include <linux/io.h>
>> +#include <linux/init.h>
>> +#include <linux/kernel.h>
>> +#include <linux/module.h>
>> +#include <linux/of.h>
>> +#include <linux/of_address.h>
>> +#include <linux/platform_device.h>
>> +
>> +#define TO_MS(timestamp) ((timestamp * 1000) / 32768)
>> +
>> +/**
>> + *  struct boot_stats - timestamp information related to boot stats
>> + *  @abl_start: Time for the starting point of the abl
>> + *  @abl_end: Time when the kernel starts loading from abl
>> + */
>> +struct boot_stats {
>> +    u32 abl_start;
>> +    u32 abl_end;
>> +} __packed;
>> +
>> +static struct boot_stats __iomem *boot_stats;
>> +static struct dentry *dbg_dir;
>> +
> I would avoid global variables where possible, and allocate them 
> dynamically.
> 
> In this case you could do that in probe and pass it(boot_stats) as 
> argument to debugfs_create_file() and also set dbg_dir as 
> dev_set_drvdata to be able to use it in remove.

Ack

> 
> 
> ----------------->cut<--------------
>> +static ssize_t abl_read(struct file *filp, char __user *userbuf,
>> +            size_t count, loff_t *ppos)
>> +{
>> +    char buf[20];
>> +
>> +    u32 abl_time = TO_MS(boot_stats->abl_end) - 
>> TO_MS(boot_stats->abl_start);
>> +
>> +    sprintf(buf, "%u ms\n", abl_time);
>> +    return simple_read_from_buffer(userbuf, count, ppos, buf, 
>> strlen(buf));
>> +}
>> +
>> +static const struct file_operations abl_fops = {
>> +    .read = abl_read,
>> +    .open = simple_open,
>> +    .llseek = generic_file_llseek,
>> +};
>> +
> --------------->cut<----------------
> can be replaced with.
> 
> static int abl_show(struct seq_file *s_file, void *data)
> {
>          struct boot_stats *boot_stats = s_file->private;
>      ...
> }
> 
> DEFINE_SHOW_ATTRIBUTE(abl);

Ack

> 
>> +static ssize_t pre_abl_read(struct file *filp, char __user *userbuf,
>> +                size_t count, loff_t *ppos)
>> +{
>> +    char buf[20];
>> +
>> +    sprintf(buf, "%u ms\n", TO_MS(boot_stats->abl_start));
>> +    return simple_read_from_buffer(userbuf, count, ppos, buf, 
>> strlen(buf));
>> +}
>> +
>> +static const struct file_operations pre_abl_fops = {
>> +    .read = pre_abl_read,
>> +    .open = simple_open,
>> +    .llseek = generic_file_llseek,
>> +};
>> +
> same here.

Ack

> 
>> +static int boot_stats_probe(struct platform_device *pdev)
>> +{
>> +    struct device *boot_stat = &pdev->dev;
>> +
>> +    dbg_dir = debugfs_create_dir(dev_name(&pdev->dev), NULL);
>> +    if (IS_ERR(dbg_dir))
>> +        return dev_err_probe(&pdev->dev, -ENOENT,
>> +                     "failed to create debugfs directory");
>> +
>> +    boot_stats = of_iomap(boot_stat->of_node, 0);
> 
> may be devm_of_iomap?

Ack

> 
>> +    if (!boot_stats)
>> +        return dev_err_probe(&pdev->dev, -ENOMEM,
>> +                "failed to map imem region\n");
>> +
>> +    debugfs_create_file("pre_abl_time", 0200, dbg_dir, NULL, 
>> &pre_abl_fops);
>> +    debugfs_create_file("abl_time", 0200, dbg_dir, NULL, &abl_fops);
>> +
>> +    return 0;
>> +}
>> +
>> +static int boot_stats_remove(struct platform_device *pdev)
>> +{
>> +    debugfs_remove_recursive(dbg_dir);
>> +    iounmap(boot_stats);
>> +
>> +    return 0;
>> +}
>> +
>> +static const struct of_device_id boot_stats_dt_match[] = {
>> +    { .compatible = "qcom,sm8450-bootstats" },
>> +    { }
>> +};
>> +MODULE_DEVICE_TABLE(of, boot_stats_dt_match);
>> +
>> +static struct platform_driver boot_stat_driver = {
>> +    .probe  = boot_stats_probe,
>> +    .remove = boot_stats_remove,
> 
> consider using remove_new as its suggested that new drivers implement 
> .remove_new as it returns void.
> more details in  include/linux/platform_device.h

Ack

> 
> 
> -srini
> 
>> +    .driver = {
>> +        .name = "qcom-boot-stats",
>> +        .of_match_table = boot_stats_dt_match,
>> +    },
>> +};
>> +module_platform_driver(boot_stat_driver);
>> +
>> +MODULE_DESCRIPTION("Qualcomm Technologies Inc. Boot Stat driver");
>> +MODULE_LICENSE("GPL");
>> -- 
>> 2.7.4
>>
