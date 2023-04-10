Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8858C6DC3AE
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Apr 2023 08:49:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229732AbjDJGt3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Apr 2023 02:49:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229725AbjDJGt1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Apr 2023 02:49:27 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDBF63A8C;
        Sun,  9 Apr 2023 23:49:25 -0700 (PDT)
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 33A6LvMp025518;
        Mon, 10 Apr 2023 06:49:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=d33h0MeCKuVcMedfvoFaIM87gL5+nRQ4ofP6VMY89Hg=;
 b=MQLdE/H0f8FG/TvgAIKr7HQWhLBw1BC1mafMhtsD3pF3gGbQL7sjrBnL0aORYSWKKOCz
 IhOas0Kj1fq7bhwJdQ/aPdBJbqSLdCea8ycyJLNKY9xCDZLdKOyA1BR+LSOR0MSVwAS1
 8VpCadKzRg37EIw0wR/IpwTpPY1bx8z3JQoBfBTSrmg6jRzL+rvtikyJKr+e4sIXcQZ2
 HNjyx+j5PAA+xx/zSfQFZNpmjTQZ1sZsQFHylsZs2wqddOz3lCFL61O6VaA8HbVnQTCs
 ELXH4TuLhpdbGjlz4HiACOotoZRgdVi9RJc10R7Z8ratm1BGQpUzK30WxcxaizVbgd2P ww== 
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3ptwmythnv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 10 Apr 2023 06:49:13 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 33A6nCCK032301
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 10 Apr 2023 06:49:12 GMT
Received: from [10.50.45.204] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.42; Sun, 9 Apr 2023
 23:49:08 -0700
Message-ID: <8cf793df-b676-bbb4-0601-5647d58bb2b3@quicinc.com>
Date:   Mon, 10 Apr 2023 12:18:56 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: [PATCH V2 2/3] soc: qcom: boot_stat: Add Driver Support for Boot
 Stats
To:     Bjorn Andersson <andersson@kernel.org>
CC:     Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-arm-msm@vger.kernel.org>,
        <devicetree@vger.kernel.org>, Sibi Sankar <quic_sibis@quicinc.com>,
        Rajendra Nayak <quic_rjendra@quicinc.com>
References: <cover.1680874520.git.quic_schowdhu@quicinc.com>
 <5eeeb46e9b3f61656a37cb77c2ad6a04e383c16d.1680874520.git.quic_schowdhu@quicinc.com>
 <20230407154132.dpguz24f6rukyujq@ripper>
Content-Language: en-US
From:   Souradeep Chowdhury <quic_schowdhu@quicinc.com>
In-Reply-To: <20230407154132.dpguz24f6rukyujq@ripper>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: 8VWpsdI3C7kq6P_VaPy1RTpBPvT4ytJf
X-Proofpoint-GUID: 8VWpsdI3C7kq6P_VaPy1RTpBPvT4ytJf
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-04-10_03,2023-04-06_03,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 phishscore=0
 priorityscore=1501 adultscore=0 spamscore=0 mlxscore=0 clxscore=1015
 suspectscore=0 bulkscore=0 lowpriorityscore=0 impostorscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2303200000 definitions=main-2304100056
X-Spam-Status: No, score=-3.1 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 4/7/2023 9:11 PM, Bjorn Andersson wrote:
> On Fri, Apr 07, 2023 at 07:34:36PM +0530, Souradeep Chowdhury wrote:
>> All of Qualcomm's proprietary Android boot-loaders capture boot time
>> stats, like the time when the bootloader started execution and at what
>> point the bootloader handed over control to the kernel etc. in the IMEM
>> region. This information is captured in a specific format by this driver
>> by mapping a structure to the IMEM memory region and then accessing the
>> members of the structure to print the information. This information is
>> useful in verifying if the existing boot KPIs have regressed or not.
>> A sample log in SM8450(waipio) device is as follows:-
>>
>> KPI: Pre ABL Time = 3s
>> KPI: ABL Time = 14s
> 
> Why are these in whole seconds?

This is to give a granular view of time.

> 
>> KPI: Kernel MPM timestamp = 890206
> 
> And why is this presented in cycles?

This timestamp is used as an intermediate value for calculating one of 
the KPIs. Can be changed to seconds as well for consistency.

> 
>>
>> The Module Power Manager(MPM) sleep counter starts ticking at the PBL
>> stage and the timestamp generated by the sleep counter is logged by
>> the Qualcomm proprietary bootloader(ABL) at two points-> First when it
>> starts execution which is logged here as "Pre ABL Time" and the second
>> when it is about to load the kernel logged as "ABL Time". Both are
>> logged in the unit of seconds.
> 
> We have a policy to not taint the kernel log with "useless" information,
> for kernel developers this seems to add no value and for end users
> there's no benefit to this.
> 
>> The current kernel timestamp is
>> printed by the boot_stats driver as well.
>>
> 
> Why?

Same as stated above.


> 
>> Signed-off-by: Souradeep Chowdhury <quic_schowdhu@quicinc.com>
>> ---
>>   drivers/soc/qcom/Kconfig      |  7 ++++
>>   drivers/soc/qcom/Makefile     |  1 +
>>   drivers/soc/qcom/boot_stats.c | 95 +++++++++++++++++++++++++++++++++++++++++++
>>   3 files changed, 103 insertions(+)
>>   create mode 100644 drivers/soc/qcom/boot_stats.c
>>
>> diff --git a/drivers/soc/qcom/Kconfig b/drivers/soc/qcom/Kconfig
>> index d11bda2..2cfdbb7 100644
>> --- a/drivers/soc/qcom/Kconfig
>> +++ b/drivers/soc/qcom/Kconfig
>> @@ -79,6 +79,13 @@ config QCOM_DCC
>>   	  driver provides interface to configure DCC block and read back
>>   	  captured data from DCC's internal SRAM.
>>   
>> +config QCOM_BOOTSTAT
>> +	tristate "Qualcomm Technologies, Boot Stat driver"
>> +	depends on ARCH_QCOM || COMPILE_TEST
>> +	help
>> +	  This option enables driver for boot stats. Boot stat driver prints
>> +	  the kernel bootloader information by accessing the imem region.
>> +
>>   config QCOM_KRYO_L2_ACCESSORS
>>   	bool
>>   	depends on ARCH_QCOM && ARM64 || COMPILE_TEST
>> diff --git a/drivers/soc/qcom/Makefile b/drivers/soc/qcom/Makefile
>> index 3b92c6c..8a9d995 100644
>> --- a/drivers/soc/qcom/Makefile
>> +++ b/drivers/soc/qcom/Makefile
>> @@ -5,6 +5,7 @@ obj-$(CONFIG_QCOM_GENI_SE) +=	qcom-geni-se.o
>>   obj-$(CONFIG_QCOM_COMMAND_DB) += cmd-db.o
>>   obj-$(CONFIG_QCOM_CPR)		+= cpr.o
>>   obj-$(CONFIG_QCOM_DCC) += dcc.o
>> +obj-$(CONFIG_QCOM_BOOTSTAT) += boot_stats_new.o
> 
> Most other entries here are sorted alphabetically.

Ack

> 
>>   obj-$(CONFIG_QCOM_GSBI)	+=	qcom_gsbi.o
>>   obj-$(CONFIG_QCOM_MDT_LOADER)	+= mdt_loader.o
>>   obj-$(CONFIG_QCOM_OCMEM)	+= ocmem.o
>> diff --git a/drivers/soc/qcom/boot_stats.c b/drivers/soc/qcom/boot_stats.c
>> new file mode 100644
>> index 0000000..080e820
>> --- /dev/null
>> +++ b/drivers/soc/qcom/boot_stats.c
>> @@ -0,0 +1,95 @@
>> +// SPDX-License-Identifier: GPL-2.0-only
>> +/*
>> + * Copyright (c) 2013-2019, 2021 The Linux Foundation. All rights reserved.
>> + * Copyright (c) 2023 Qualcomm Innovation Center, Inc. All rights reserved.
>> + */
>> +
>> +#include <linux/err.h>
>> +#include <linux/io.h>
>> +#include <linux/init.h>
>> +#include <linux/kernel.h>
>> +#include <linux/module.h>
>> +#include <linux/of.h>
>> +#include <linux/of_address.h>
>> +#include <linux/platform_device.h>
>> +
>> +#define MPM_COUNTER_FREQ 32768
>> +
>> +/**
>> + *  struct boot_stats - timestamp information related to boot stats
>> + *  @bootloader_start:  Time for the starting point of the abl bootloader
>> + *  @bootloader_end:    Time when the kernel starts loading from abl bootloader
>> + */
>> +struct boot_stats {
>> +	u32 bootloader_start;
>> +	u32 bootloader_end;
> 
> bootloader != abl

Ack. Will change these names based on abl.

> 
>> +} __packed;
>> +
>> +struct boot_stats __iomem *boot_stats;
>> +void __iomem *mpm_counter_base;
> 
> Why are these non-static global variables?

This was removed as per the comment on version 1 of the patch. Will 
reinstate it.

> 
>> +
>> +static void print_boot_stats(void)
>> +{
>> +	u32 pre_abl_time = readl_relaxed(&boot_stats->bootloader_start) / MPM_COUNTER_FREQ;
>> +	u32 abl_time = readl_relaxed(&boot_stats->bootloader_end) / MPM_COUNTER_FREQ;
>> +
>> +	pr_info("KPI: Pre ABL Time = %us\n", pre_abl_time);
>> +	pr_info("KPI: ABL Time = %us\n", abl_time);
>> +	pr_info("KPI: Kernel MPM timestamp = %u\n", readl_relaxed(mpm_counter_base));
> 
> This number is completely dependent on link order and other things in
> happening in the kernel, so what trust do you give in this number going
> up or down?
> 
> As above, why is this presented in ticks?

This is the sleep counter for module power manager unit which starts 
ticking from PBL stage, it will keep on ticking till the system shuts 
down. As mentioned above this timestamp value is used at an intermediate
point for calculating one of the KPIs, we can change it to seconds for 
consistency.

> 
>> +}
>> +
>> +static int boot_stats_probe(struct platform_device *pdev)
>> +{
>> +	struct device_node *np_mpm2;
>> +	struct device *boot_stat = &pdev->dev;
>> +
>> +	boot_stats = of_iomap(boot_stat->of_node->child, 0);
> 
> You can't just do ->child here, what if boot stats isn't the first item
> in the list?

Ack

> 
>> +	if (!boot_stats)
>> +		return dev_err_probe(&pdev->dev, -ENOMEM,
>> +					"failed to map imem region\n");
>> +
>> +	np_mpm2 = of_find_compatible_node(NULL, NULL,
>> +					  "qcom,mpm2-sleep-counter");
>> +	if (!np_mpm2) {
>> +		return dev_err_probe(&pdev->dev, -EINVAL,
>> +				     "failed to get the counter node\n");
>> +	}
>> +
>> +	if (of_get_address(np_mpm2, 0, NULL, NULL)) {
>> +		mpm_counter_base = of_iomap(np_mpm2, 0);
> 
> Isn't this region going to be also accessed by some sleep stats driver?

Currently there is no sleep stat driver present for this upstream.

> 
>> +		if (!mpm_counter_base) {
>> +			return dev_err_probe(&pdev->dev, -ENOMEM,
>> +					     "failed to map the counter\n");
>> +		}
>> +	}
>> +	print_boot_stats();
> 
> You're done with your platform_device, and your two ioremap regions
> here. But you're holding on to those 10kb of memory for the rest of the
> systems runtime.

Ack

> 
>> +
>> +	return 0;
>> +}
>> +
>> +static int boot_stats_remove(struct platform_device *pdev)
>> +{
>> +	iounmap(boot_stats);
>> +	iounmap(mpm_counter_base);
>> +
>> +	return 0;
>> +}
>> +
>> +static const struct of_device_id boot_stats_dt_match[] = {
>> +	{ .compatible = "qcom,sm8450-imem" },
> 
> You're binding to the root imem node, rather than your boot stats child
> node.

Ack

> 
> How about just exposing the boot stats imem region to userspace, through
> debugfs or similar and then you can have a userspace tool that digs out
> and reports this information when profiling is relevant?

Ack. This can be exposed to user as a part of debugfs interface.

> 
> Regards,
> Bjorn
> 
>> +	{ }
>> +};
>> +MODULE_DEVICE_TABLE(of, boot_stats_dt_match);
>> +
>> +static struct platform_driver boot_stat_driver = {
>> +	.probe  = boot_stats_probe,
>> +	.remove = boot_stats_remove,
>> +	.driver = {
>> +		.name = "qcom-boot-stats",
>> +		.of_match_table = boot_stats_dt_match,
>> +	},
>> +};
>> +module_platform_driver(boot_stat_driver);
>> +
>> +MODULE_DESCRIPTION("Qualcomm Technologies Inc. Boot Stat driver");
>> +MODULE_LICENSE("GPL");
>> -- 
>> 2.7.4
>>
